Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 875D1FF8868
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 16:31:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHOrL-0001bv-Dk; Mon, 27 Apr 2026 12:31:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHOqQ-0001G5-78
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 12:30:02 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHOqN-0005ip-SX
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 12:30:01 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-43d73422431so9720773f8f.2
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 09:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777307398; x=1777912198; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fOD0i9GhiEqpC8sZVvRnPoCide7MBp86g5LtpIZMIlU=;
 b=FzQl9DukovO43/kq7fu/xpYiJZsTiLhR8cDBGBDt82bwUCw7SRVcQ7YvwHgw7Cl7E8
 xE6DrMFpgrriMkiQNRkOL0u357ULe+jIibaHWj75njY4gy2iBYzkOuIq5vTvtUK7dUzK
 DxWmmRtUcuAd5NRYFx6tciiVXuyi4Bv+hCT6gPEVMOQM8ay5vVRLv+eSR7dp04g/tiI4
 So/J6+5cpqy4Zyy1xwpdgupeCa/aQhvjxMR14jQR6o933/0vy7WEhn6AsSSWMLD4SyBx
 BPukpV7gaARotCj4M7jzFmhOOfsYOEj2sKUqodpuvHX1MZKy2dYGWiW6RnWusTNjcNkZ
 YNHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777307398; x=1777912198;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fOD0i9GhiEqpC8sZVvRnPoCide7MBp86g5LtpIZMIlU=;
 b=UkYcequV33WWyl15hzAir4yhzP3PTcpiMW82AFSjJ7POr/93tWsLIc4dRbwFc+MDfR
 E5FdFTHt7T1Uez2urdO1S0AN9TzBv85GymlcLiiiO2IEvtpO7rTC6h3HuNbxhGbNTklS
 LwcilY2zcy621DniVSAAF9rla3TZHvAN2JvBCGx75qx9WzZESQN3EqcWX7geGWggIV+D
 4CpfW6U1mv/NGtvI4n1aT+5mp3dthOzAUGNufDYgNmDxb6B5O4MWRSVR43lieDccmwZO
 CKFknSsnHMqitdwzDlS3IHWA2m5WhEPzvB7EGpi1ZhsLOYj/d1QCcIaIgnd44luVVHAc
 DVkw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/kX28ir9n1LYdWRrk2NI2XJz1UvRd4Ue6DVS4Xd/lGh70ktutECBxtNEBQsn4FoU89R5ZD6NjIJPZV@nongnu.org
X-Gm-Message-State: AOJu0YyPFVABEuc3brrQa7k1JZMJP8UmasSTNiw1oOXYwVGS/OR0jHG7
 HTUB0l4CLVT14aTGo+v+mlDK2VqsuYxrX/Z1orGwn6elnzgirEQ2csXBDVh5OxGOxDxEFD04Pam
 FEdSl9pw=
X-Gm-Gg: AeBDieuZkiBqb+qjUJI8X1Wuv5W0VkFrh7okTNB9qBIg3zHUm+TStABzQQ7mKKYiMy1
 S7FKHqCBEo1oco+qA5UlglePSkRfVU09Er6Nm36pSLEOuvl2nvr6LglOmAPpiisJ9tKTa8UzYom
 6z7b1yVBh8M4Q5JfCKMGCplVYS3DnKY2biq9jU/FQoSuh9MBCL1qhI61zA01dQ4NjAdqEwHx21Q
 k0iB9LX6Cbx5+B1ItrW/FkixhicDexfDAj1RkoYBCmGJnfV3ee4yrxNEQjaEKMbfgOkjpWef7CF
 rLI1m1hXsOA6FXCmnxWopEFLlvLGdo7YGuD47idGBb+GW+tS/pzL9Lre4Hvjz5AHfmlqjSx3M45
 1A5rgqSSiL3YaaH8ULK56rbCITzNM0gaQ539hSqexlnrNaklQrVkNwTpJBniUYox4rxuzOTXohQ
 ESH5f289yt9zxwqi4IJfDnWjpM+JgGJC8OBZAMl9cxypkgTe9qcVuTRiM3LNg4xVKklGnRnwlg8
 0F4
X-Received: by 2002:a05:6000:2890:b0:43d:77c6:be78 with SMTP id
 ffacd0b85a97d-43fe3e16c4dmr68147077f8f.39.1777307398005; 
 Mon, 27 Apr 2026 09:29:58 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cb11b4sm82559942f8f.2.2026.04.27.09.29.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2026 09:29:57 -0700 (PDT)
Message-ID: <5f8d159a-460a-469c-8773-1fec500695ce@linaro.org>
Date: Mon, 27 Apr 2026 18:29:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/84] fpu: Drop parts_pick_nan
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org
References: <20260426134002.865628-1-richard.henderson@linaro.org>
 <20260426134002.865628-8-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260426134002.865628-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 26/4/26 15:38, Richard Henderson wrote:
> Use parts{64,128}_pick_nan at each call site.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   fpu/softfloat.c           | 11 ++---------
>   fpu/softfloat-parts.c.inc | 10 +++++-----
>   2 files changed, 7 insertions(+), 14 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

