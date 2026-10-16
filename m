Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A04D5CC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 06:01:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHb06-0008LF-1x; Fri, 16 Oct 2026 02:01:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xHazk-0008GZ-R9
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 02:00:52 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xHazf-0003dz-UE
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 02:00:41 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4a1b07c3c5fso24632535e9.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 23:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792130436; x=1792735236; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=f4sDiXM9/tTNgB0aMRi4Zv835+twwqzTRkKvclDCYgE=;
 b=OlckUg0oUPIEGdqzGcDOPjwXqgxKE7IzBFsFIJ0adw5XXW9vBafOvw08j1MXqfhyXY
 sKV25VfpRmiIqtcpIV09UPmc4NvKEZJhwedDcb0gg2p1jWWJBtwf21gSf18q26HhKUJU
 /yRDsGaxwCMPMuVGvmYZnrMWHpeqhCOqYzdv8lA4L3ISGAOfnIyNMTt/w/rbDnZ91Rc0
 wtCFr9KO/O8TacjY+K7HcQu45W4xVsP/zBHQ6DGZEo/b/JURXlIoTy8MRPrvb16StIsv
 uRbJndKbYRUC0NQhPIsBE8vY8cFa7g4XUkoF/0u8eT2o/y7xLhhWGgvCp7Qqr9bCbnSL
 EZwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792130436; x=1792735236;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=f4sDiXM9/tTNgB0aMRi4Zv835+twwqzTRkKvclDCYgE=;
 b=RimFdm0Npawn7MbrVGfQZfimrsSkJJQy3wmalh0xhoHz2lgE63GwiMtRGnCvvZXy9u
 cXDpnR4QjMYKejhw3nZDJ+XDdKNv2nQHH/wLTVnUj8aWc/m/LkY2zGinIgLeT2oz0MF7
 RrT9Aj89WlJnpAo7HZzUlrI7x04DVlHtPsAlR6XGKpGxR76xEYKgTSwr/7C/QXGm6lAv
 UExurnSJKYp/x1m04qen/PnV998bGFOyqzjQGgUuMbUiagiIhOPre04LnEnBDK3uLHNP
 tBu6zi5LAE+4uFg1Ij7BFj/m+kiPZUoNxqRGxSndtKdtFMINQWhJ/0JnUkK5YVOXSzlC
 zbmg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzoYjy1JsgqvMmZekqsYefnPetaOQnuVx06mTBbBbE2gRem3ACtulg4GMAf/wbH/Zu1D+qb0p4dLZjF@nongnu.org
X-Gm-Message-State: AFq9FYKNBHfwdXlUjjxFjCnfSUc6V52x7cyLlrw8MZX9ckc0o+JW2sW9
 hEwtQjDEJV2lILTaQXG3U9bikkVACCAFt3qZBcesxpO7Go1eSNHsfj/UMXiRpOBTeTGVeZHzV44
 Prn8hmBI=
X-Gm-Gg: AYBFou0LKTNGgB4iNO69x2nZNRHr3f2mLWoFyUZjkpo8vvoBZvAP9hlQ+HC3SVCFfxi
 noSDJp2e8wXf9Bt5QAyDlQ6avU6SIAMyyKdyFHnPcKsEccae+PSACkXDYAa+q1oYwa4yeI68AME
 NklHrlMi68kAXlguM0XTAmnYxrrS9PtJv6r5G8gfeGdFTQ0wojvo6UVA5efONKTkyt3uwktBzeR
 44Qgv0/Ry5kw0Ly8IQHHo1UB/14etOGrZv9M0ecR0tXjqvQ5wBZraYziyLYdXklbDlMZGGS3iH4
 zTMftISQ7uA6Voy1Hi24CUIxmwr8/IRSQbtjG0MBvTewGZUoJgWFFbcsSugbxNZznnZ40/X6kdi
 CH5oj/WgjGlRk0dECFeF51XK5GtHuA0m6nk43JGPXULKpuONCeHW0MQxtYafJXSTOXW0AKiDVQg
 P7JzdHY62HpO55ChjiAPEeVT5m2XFkqrJKjjuZF8hsipmQttkbm8ul+bhp/UPeYSZER4GE1dlXA
 5q8WYqXh9WXpwCQrVojgphAuRJY5WbrkP5w3eiUYe0v45E=
X-Received: by 2002:a05:600c:37cf:b0:4a1:d087:f6ab with SMTP id
 5b1f17b1804b1-4a1d087f76bmr5911165e9.18.1792130435917; 
 Thu, 15 Oct 2026 23:00:35 -0700 (PDT)
Received: from [10.233.235.227] (p54a4c6f0.dip0.t-ipconnect.de.
 [84.164.198.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd9b35a6sm116388205e9.6.2026.10.15.23.00.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2026 23:00:35 -0700 (PDT)
Message-ID: <578c7a0f-43ec-4830-b121-48b893383c5f@linaro.org>
Date: Fri, 16 Oct 2026 08:00:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/2] Linux user next patches
To: Helge Deller <deller@kernel.org>, qemu-devel@nongnu.org
Cc: Andreas Schwab <schwab@suse.de>, wangyang
 <wangyang25@otcaix.iscas.ac.cn>, Helge Deller <deller@gmx.de>
References: <20261015200225.6314-1-deller@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261015200225.6314-1-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/15/26 22:02, Helge Deller wrote:
> From: Helge Deller<deller@gmx.de>
> 
> The following changes since commit 8ee6c77176cfee03be0ec7665b6652b2f31f1531:
> 
>    Merge tag 'pull-ufs-20261012' ofhttps://gitlab.com/jeuk20.kim/qemu into staging (2026-10-13 22:01:07 +0200)
> 
> are available in the Git repository at:
> 
>    https://github.com/hdeller/qemu-hppa.git tags/linux-user-next-pull-request
> 
> for you to fetch changes up to fdd414709dea458794e03dc64b2495e579133ead:
> 
>    linux-user/riscv: preserve rs1 address for cbo.zero fault reporting (2026-10-14 21:16:41 +0200)
> 
> ----------------------------------------------------------------
> linux user patches
> 
> Two linus user patches:
> - Show correct fault address on riscv
> - Do not trash stderr on unhandled core dump, but instead log it into guest_errors log

This conflicted with the riscv pull.


r~

