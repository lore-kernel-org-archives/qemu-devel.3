Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 953D9F94CDF
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 08:07:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFScX-0001aN-DO; Wed, 22 Apr 2026 04:07:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFScV-0001Zs-Vl
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 04:07:39 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFScU-0002Li-CE
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 04:07:39 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4891cd41959so32118085e9.3
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 01:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776845257; x=1777450057; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zSbmgQ4mUKO3noT9uImqlbfaB1HH+PFpn68SkuRwax0=;
 b=hA+lkWMN6d8SmiUbYSX5AluH0DIIeJPWmwckbrnhyqJqcTYXo029/mmH7Cqahj5DlJ
 RIqZJ1akdp1X3/DSBS3WN70UI4A5gLkTa0BiXIjdGuyyVrkpvDF4PS5ndY2e+ccyIUIK
 lEWXMZQ0gilmYXEc7yJKFcmuz7Tgt4pTbpXKbh9S2pFiKB050q9gBQIOmUv5hOscIi8j
 Nc6XrUE3zkZ0J4/7ChQGdUqdsWQuyxE6pXLKgE0/3spls26/OwaYZkIzZkXQKQWZ5i9E
 gUIzT7lOLZ7wSeIMR23CMwxBprS+4RtKDqMfYxEwjyD7tl3v9axXc4WIgP/AofyulHCS
 cfig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776845257; x=1777450057;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zSbmgQ4mUKO3noT9uImqlbfaB1HH+PFpn68SkuRwax0=;
 b=MXxbqz0pyG5oPLJJkcQSjZ7G3C3NVgX7jwf9M+Ism6EYeyVl/orqkMmnYgY5VaDYmb
 lhd7GyhA4ER0E/hHS49nOwKc5x/k1io/I6GRDgUw5hWZVMKqvpMKcdsHklmgfkGhqvBJ
 9xLtzOs4L1EYwkfajcldB+B+xSEsdDPuI0ELgsoQilMOp3suhWH9YpQEoEZDfaY2eonG
 tTKBXy/1Ougi6V54zi0gTp2qXzDwz8WUa1faeoNEJdslWg6xUFYx9nXChBV2tq86Mi5w
 ShYL4TqvknLqgqVdmQRQALGrQMm7/N9LoXL3P6sjaxTuTkELEoKckR/GA2mStRpycOrk
 59PQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9CmZ7ZagPVJOGbdIYDYTQm1Ewoq0XQgHhiSe7WlXieU677pXKnlFkAr1NUmRn6mYsfKdSuTr75n0tu@nongnu.org
X-Gm-Message-State: AOJu0YwHWvhmAUz+nuDaqvrTwDlaNYM3wGQCd5Lpu3hX/dSgjAAsw6rX
 mGCysdfhHFW8yjBo8qn+9Z2F+4si5l89ZfD11aYIMgP6hgt+wHdO6OoVUn1OUetfyDE=
X-Gm-Gg: AeBDiet+b+R8q6+EhZTcDzGYerCRMQGMwtV4eB/2X4mwrKUnoMmp71Hhc9Lk/TvjBTI
 ZGT49rEOYDs7NQkn7kNQ4vHdEVhgHt7KrV+EU76FeSGNHwtafzSjJ2mHo1pmszOcAbnyEH2LFVk
 kwZa8IG5vGBH9gh1paZ+W8vaaDOTQkWpRqw0TZAfJqOAIdEXmwjXNmtlFziOLOvSuOAOnN4+Mlr
 UXkhTWQopuTO2NjySIiGu9njDSlnpOCLS+7DzKb6ME4SeqPXaAeLtDy42FtDR6j4/wS43SIp/nO
 txACvWZrN/LVGPZDJ3X81vzzvfnpV6SuDcu8a859rZDhkJeJ3hWUtyR3QYt0AfiSxxkV2k7E/eI
 Mr9aRN8oqzeXM2TVBkY+XnxVTFi4H8maxNo05b9yvtnB8Ze2/VHVgyYYyRUr9Y0QNxOwmpNlv8r
 Vt56evY1ktp2gQ6+LluNVI5PF58pzgC2Yybh2cEb2zA13mUM2WcfmDsdn1crQustqT9z4BgtoSp
 vCR
X-Received: by 2002:a05:600c:3f0c:b0:48a:563c:c8e0 with SMTP id
 5b1f17b1804b1-48a563cd16bmr75304245e9.1.1776845256395; 
 Wed, 22 Apr 2026 01:07:36 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4d6casm39675477f8f.32.2026.04.22.01.07.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2026 01:07:35 -0700 (PDT)
Message-ID: <1012727b-f164-4543-b23b-bb68e4ddcd1d@linaro.org>
Date: Wed, 22 Apr 2026 10:07:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/sh4/sh7750: Remove forgotten abort() in the
 MM_ITLB_DATA handler
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Yoshinori Sato <yoshinori.sato@nifty.com>
Cc: qemu-trivial@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>
References: <20260422075429.341409-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260422075429.341409-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 22/4/26 09:54, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> QEMU currently aborts when the guest writes to the MM_ITLB_DATA register:
> 
>   echo "writel 0xf3000000 0x11223344" | \
>    ./qemu-system-sh4 -M r2d -display none -accel qtest -qtest stdio
>   [I 0.000000] OPENED
>   [R +0.004476] writel 0xf3000000 0x11223344
>   Aborted                    (core dumped)
> 
> Looking at the history of the code, the abort() here has likely just
> been forgotten when the register handler had been implemented (it used
> to be a reminder about unimplemented functionality initially):
> 
>   https://gitlab.com/qemu-project/qemu/-/commit/9f97309a70f12df5f9104f1f
> 
> Thus simply remove the abort() now to get rid of the problem.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3420
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/sh4/sh7750.c | 1 -
>   1 file changed, 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

