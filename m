Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0A06CA1013
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 15:59:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzH1a-00029f-Ta; Thu, 18 Sep 2025 11:58:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uzH1U-00025G-Uk
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 11:58:20 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uzH1R-0007Ow-DC
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 11:58:15 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7761b392d50so1508083b3a.0
 for <qemu-devel@nongnu.org>; Thu, 18 Sep 2025 08:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758211091; x=1758815891; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QjoL3B7/Q4Dr3v+93XUH8Ll/ZtmdI1oPJVmow4urwIc=;
 b=URZ0rwwCzdvfIHt/eMkwVhj9hs1fxKryHGRDeP1kN1W2BB9TneZFM7wubvzWLauKd5
 A1bjnvBepP5UmK+fEenIoaUBsqelG4HNrnp+zNmp5IXZfDl40VwSKDO8Jheb4pYlY/r0
 u8SrQ5Bqp/GoL/LVqlJj5QTLW5wLzV6mKCNeINLhizfgT9QWPxhEa4Cj3ire14eycl2b
 wHWtr04GS+uLzZquXuNN7FUKVnXTn4AkpxvfxeTaGeA63IV1rp2mwFSdu8izvGI/5Uey
 0U7m3tL4RxExeWCKtjAtpFamQKyJ2p/of0blptq6ebNBOl/dr+PNfvGRaKsqVZL3VM26
 KHbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758211091; x=1758815891;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QjoL3B7/Q4Dr3v+93XUH8Ll/ZtmdI1oPJVmow4urwIc=;
 b=p/eYSeWzjOtjwWhzO383VOO8B/idNUKe01uN5GJ/QnIy4/m9qioO2gdjKFe7V+ZUlS
 scHWlTWJnVKHGOV5U/QZHTgE+Tc5yx5qszYHo2pERSqVTMzq3Y4CGlhzCWcYuOPxwowB
 ILcWlwsZZGEWYy1MAhbUij6o/A79WrhcM9fuJjvJCuI1t7zfLEKrggkW2QPywB4IbR2J
 VRFNlIIZylVYieUbBrCmSMR6gt0mu7BuV4/BiL5pq5TXafb/043REFZGA5138E2L3Iyb
 JW5bvrD6YIWlyuwgGRwoi1tzl3QxunLQ1eI4ql9B9FvMOlJ3t5HU1X8cN1KnX+NHIysy
 jMdA==
X-Gm-Message-State: AOJu0YyE+6Uo1Ctf49dlxjh6UpgW6F3pwrGufFE5JptJ87nBiz+CwFQi
 BIB8iGfU4MAIySj0BOH5946664eq8v80M04m51Z7huabudi9GEjeWBZ6N3UtktY6yScdYltBxrL
 y/Ms+
X-Gm-Gg: ASbGncuA8e5mJUxs0nyfbRCP5zFSp5R37mZEQxXEXz1/pZIDvvzVMc7k8WUHgGdE/EQ
 vrRlJBKssC6tPdxFpNO+v3i0Cd5ysK/S2LYoFgxCZG6AjtRDTfS54nRwBH2pLwNVawLOzzYAKVV
 FJO9h/AJUqJULPsSk7rGyhoghhWf9QTgrXiDPpC/1i2YyTY7sLYpU6i1fi12woKvg1OwgsAlZLy
 7gtK4VNvsH+ZEtx+vT0PLqOTZ/2/6qQSFFFuKTRVywtXU3crEJpAz5pjQ2k3ZLuFfGJ+X3CT1z2
 7H5a6eqrZXfXUEsqmOBSFBaoyo5PT0MPc7agefm9Rn2SqzYMfW1Snf1DqO7hFwrlTyHpTbMqoPy
 7SIyz/w7UNVJN6Ju46wYjuMTiq70xMUHXvTbHKxy47Tuz4hHhqPst+Uc=
X-Google-Smtp-Source: AGHT+IF1rfXDg4V1CRdLBdt3acH0kdu1B56ExAda4E6NzlqHNccLVb37YKRfmX3kWTeW+WO5HJb6bg==
X-Received: by 2002:a05:6a00:993:b0:772:5a3f:7cb3 with SMTP id
 d2e1a72fcca58-77bf6dceaebmr8287316b3a.1.1758211091272; 
 Thu, 18 Sep 2025 08:58:11 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77cfec3f84fsm2727600b3a.79.2025.09.18.08.58.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Sep 2025 08:58:10 -0700 (PDT)
Message-ID: <d73d1d7c-2957-45ac-9b04-c1cb4e36226a@linaro.org>
Date: Thu, 18 Sep 2025 08:58:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/3] loongarch-to-apply queue
To: qemu-devel@nongnu.org
References: <20250918092047.785269-1-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250918092047.785269-1-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 9/18/25 02:20, Song Gao wrote:
> The following changes since commit f0007b7f03e2d7fc33e71c3a582f2364c51a226b:
> 
>    Merge tag 'pull-target-arm-20250916' of https://gitlab.com/pm215/qemu into staging (2025-09-17 11:10:55 -0700)
> 
> are available in the Git repository at:
> 
>    https://github.com/gaosong715/qemu.git tags/pull-loongarch-20250918
> 
> for you to fetch changes up to cb5ee0017fc9909916383634a3f13eae05e6fe5c:
> 
>    hw/loongarch/virt: Register reset interface with cpu plug callback (2025-09-18 17:39:57 +0800)
> 
> ----------------------------------------------------------------
> pull-loongarch-20250918
> 
> ----------------------------------------------------------------
> Bibo Mao (3):
>        hw/loongarch/virt: Add BSP support with aux boot code
>        hw/loongarch/virt: Remove unnecessay pre-boot setting with BSP
>        hw/loongarch/virt: Register reset interface with cpu plug callback
> 
>   hw/loongarch/boot.c    | 71 ++++++++++++++++++++++++--------------------------
>   hw/loongarch/virt.c    |  2 ++
>   target/loongarch/cpu.h |  4 ---
>   3 files changed, 36 insertions(+), 41 deletions(-)
> 
> 


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

