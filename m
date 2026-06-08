Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46413CD8C92
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 13:07:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWZhO-0004Av-KV; Mon, 08 Jun 2026 09:07:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWZhH-0004AD-Sc
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 09:07:20 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWZhG-0006o5-6P
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 09:07:19 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-660e9ea26b9so4040123d50.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 06:07:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780924035; cv=none;
 d=google.com; s=arc-20240605;
 b=YrkmInFXpBLxKT3ZcisFTR6g1x92fRn5W1NR3uBwrb/+OgR4OfuwV3EBi/HXjMimQb
 ZuFbxTgznQqj2aDxvKg+h7Dpkrkofua+L3YPMB493pmunc/px23GJvZH194gWy829yLE
 GxDsoWxbxONtPXnaEUsXiFX48pjTLbyX3QiYJ7Z19RzWkws/ZRUDqZAvnzRxlFdRwvVv
 tVrQp+dPRxlcBEe6GL+zYJzhuoPAwHjne2Uq3FmhnK5EhX54r1J1tDm+q+ZpKE+wugVo
 kZl0/VDbYqW/ugNiZx+OJHYyvmCKdgTT/W+qL+yjbrJRD/vJggLjBfujPbbS7RO9CVru
 i5Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=X2E6QoyoXiQqafcCnuYVQGqLMF+AEhSP/fPIZuT/MpE=;
 fh=aojSFv4xjtZ1bDYcH6GOMi8YLF42cGtTS5yPa8SRnII=;
 b=cCjgkyLTl5DAuaY9PTRmI/8PqGTUCzpBIfrcxJKHjDpzXdtmgJ4IE8rvWalUqjqXlY
 5bJLd/Av4NJhotf3zQwRB+c9yFm1AiwfNFCqpQzq95z8zN9wTMOTyq6givnQGDkv5Jq4
 fQF6kWXJTR98LYbV2FsAdc8C355l3VecxAIO+HpqiqUCE9n2wuoKvHA/y1eI4aCPJVE1
 P3UNg6XhkRc7tFfWyGbwDKcKtTGF1fWNxrL2OKNr63q76RZJyIKk6w0fow8K+txymnXg
 nGYViGGDZQzxqXUO6u9W9rYQY9CwCs6tetkQA5loOEe4Zo0PXF9PjvVxleqir2zdsENY
 VUug==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780924035; x=1781528835; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=X2E6QoyoXiQqafcCnuYVQGqLMF+AEhSP/fPIZuT/MpE=;
 b=KYoRll/9NZxmuqrr1EAZZs5Lgl0+y0x5tNH+2xn2Ltq97Ve3s4olA8mbRNJlBF+287
 /p/10Yfzq3laTQPOksFsQbZOZwr1T6Gtlv+zrZ5KSdStnKYphZ4bAEcAm3gNz2TThsJe
 6yMXaggaaxoT+Aonoluxc5HvdKFsSpaiyuxorL3ZMj25MjSQ6ptgFLznyA5qZpMp3uiS
 6g+b+BNyAtxm0uBVXc+2rMmtkhYq55jZtwqTJ9etsrPtsi4VJmYizoQUFn6i04LGSQjq
 IAi735qHuknbNAdoN1a5wCEmDSB2kq4xBajaSfi0RYpBrLaVaOF0NSX8Xi68WRs2WEFw
 0Hpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780924035; x=1781528835;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X2E6QoyoXiQqafcCnuYVQGqLMF+AEhSP/fPIZuT/MpE=;
 b=OKAjaHv0NcSrc5MAHSGx4I0eAJxZnE+5MO1pSrU8vm+XD+dcAsNNapU29SH1mrKiuU
 0nOC/tOiIxy8QHQpSY4ySvlCdV2MYeKz7dYw+8TAXJUe2W+H434k7Rn2aHj+mlOF8Cgj
 Cq/Ah8OSt4/N9P5XbQO5MXC6ooDsY/Q0CdBNXntVGDnhmEYpruKsDJXE0v+U8WJxiXtQ
 0obptPVfEAO7pPJjzn4jzewfZw6Zu4B9kAXbdot/P0SViyhC8Oi7bnq8kqtIjgi/eZDC
 Xp1EUAvzZADaG4ItE8Sa5YhXeupdLZqddu30cVKxt/ZOpm5LeWhw/pj8LKHyUk70SdIr
 NMJw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8SQ62t/stsrTkc3pVmwj2duBTaQHAO7c6Xsj6OcAguSjxOhzpFtbfhyhn7lT+AtDn/3NyMS/G99w3I@nongnu.org
X-Gm-Message-State: AOJu0YwNSyYaqoHgODZbg/3FJvHmnWcL7Vc09C+HZ1+plzFGPLmb+cVR
 GHR5kh62c4Dmab/u9J6wyGUIVfq7vHYbk6AfFZG1EEvRrZC/RW0koZLbRTDglE82p6KZ6r+sPao
 0BsHrQi/vn0Fkv2bcm49csfuBQmpfnndjxx5T2hMmYg==
X-Gm-Gg: Acq92OHUAY7GWSi22yQgTQOsZj7SgZapP/8apes+MGfwpFf8qXlDAjJ6hwp7Dn0tVIa
 UebTvmEijBFcXmMpfPbQ+I12W2kYfiFWsY1qV1Ao/3jZz5gTLMstqnvUhhwFTL+L7WDsFYpXxAO
 p1EFoAInLZK7xR3LI4PYzOb2/8fbXLqgGH4J1bAZ1s5JoamSpQJQKdIMGLAWMTfkX4ArBBnG7i9
 /82SUqEt6FIqZcBtACh/JH2t66D8/ntvJXBhj8RFh7TUwdxsGi6kDYhIxLsPZu/eK3nr7NpTfgU
 kri0RMyrHQyoUxclRBdRGnh77CxpoR6QpMycp8e0PEWaM5y1xAp12T5HKKU0iE/1wteNrITGl12
 MrQ==
X-Received: by 2002:a05:690e:144b:b0:660:8e61:1a60 with SMTP id
 956f58d0204a3-661073da64dmr12653994d50.14.1780924035332; Mon, 08 Jun 2026
 06:07:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260529114723.42040-1-peter.maydell@linaro.org>
 <20260529114723.42040-18-peter.maydell@linaro.org>
 <745e66c7-2a9b-4185-bae7-77e10623332b@linux.dev>
 <20260607182221.4357-1-wrigjl@proton.me>
In-Reply-To: <20260607182221.4357-1-wrigjl@proton.me>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jun 2026 14:07:03 +0100
X-Gm-Features: AVVi8CcPWkIESGx4vqtg_G5eMNCMNTKW_VlAYElXxaQxdD1ktV5N9k1BylPAKfM
Message-ID: <CAFEAcA-xEaA2LM=17Q1pKOF6L=rHhaDimXeSmLe=BtDqeaBeFA@mail.gmail.com>
Subject: Re: [PATCH] target/arm/hvf: manually sync ID_AA64ISAR0_EL1 on vCPU
 init
To: Jason Wright <wrigjl@proton.me>
Cc: agraf@csgraf.de, qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 zenghui.yu@linux.dev, richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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

On Sun, 7 Jun 2026 at 19:22, Jason Wright <wrigjl@proton.me> wrote:
>
> Commit 887eaa8a29 ("target/arm: implement FEAT_RNG_TRAP for RNDR/RNDRRS")
> gave ID_AA64ISAR0_EL1 a readfn so the RNDR field can reflect SCR_EL3.TRNDR
> at read time, and marked the cpreg ARM_CP_NO_RAW in the system-emulation
> path.  HVF then trips its hvf_arch_init_vcpu() assertion that no ID
> register in hvf_sreg_list[] is NO_RAW, aborting on boot on Apple Silicon:
>
>   Assertion failed: (!(ri->type & ARM_CP_NO_RAW)),
>   function hvf_arch_init_vcpu, file hvf.c, line 1442.
>
> Reproduce with:
>
>   qemu-system-aarch64 -M virt,accel=hvf -cpu host \
>                       -nographic -display none -bios /dev/null
>
> Mirror the existing treatment of ID_AA64PFR0_EL1: move
> HV_SYS_REG_ID_AA64ISAR0_EL1 into the SYNC_NO_RAW_REGS block in
> sysreg.c.inc so the assert loop skips it, and push QEMU's view of the
> register to the vCPU at init time.  HVF does not expose EL3, so
> SCR_EL3.TRNDR is never set and the readfn is functionally static there.
>
> Reported-by: Zenghui Yu <zenghui.yu@linux.dev>
> Fixes: 887eaa8a29 ("target/arm: implement FEAT_RNG_TRAP for RNDR/RNDRRS")
> Signed-off-by: Jason Wright <wrigjl@proton.me>
> ---
>  target/arm/hvf/hvf.c        | 4 ++++
>  target/arm/hvf/sysreg.c.inc | 2 +-
>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index d88cbe7c82..afa1120c8a 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -1485,6 +1485,10 @@ int hvf_arch_init_vcpu(CPUState *cpu)
>      ret = hv_vcpu_set_sys_reg(cpu->accel->fd, HV_SYS_REG_ID_AA64PFR0_EL1, pfr);
>      assert_hvf_ok(ret);
>
> +    ret = hv_vcpu_set_sys_reg(cpu->accel->fd, HV_SYS_REG_ID_AA64ISAR0_EL1,
> +                              GET_IDREG(&arm_cpu->isar, ID_AA64ISAR0));
> +    assert_hvf_ok(ret);
> +

For ID_AA64PFR0_EL1, we do "read the value from hvf, update it,
write it back", and we do not either read or write the isar.idregs[]
entry for it.

For ID_AA64MMFR0_EL1, we read the hvf value into the isar.idregs[]
array entry, update it there, and write it back to hvf.

For ID_AA64ISAR0_EL1, we write whatever is in the isar.idregs[]
array entry into hvf.

Why do we do three different things for these three registers ?

thanks
-- PMM

