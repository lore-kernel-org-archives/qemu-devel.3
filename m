Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E9DDCEDD86
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 13:43:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLLyp-0006UF-Va; Tue, 18 Nov 2025 08:42:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkrcmar@ventanamicro.com>)
 id 1vLLyi-0006P6-GX
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 08:42:40 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkrcmar@ventanamicro.com>)
 id 1vLLyg-0000ZP-Bs
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 08:42:39 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b735a1fb3c0so81237066b.0
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 05:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1763473355; x=1764078155; darn=nongnu.org;
 h=in-reply-to:references:from:to:cc:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tLFoe+Ox212Q6IhIYveuzqORPCKMuHFtz21Tlq2VIKk=;
 b=ApGqehDvVCaaDybQw4dsUbx8GOSy2q9+A9JYhS1tCzAPrQCCgm7MpDd+/j9la+iJuw
 go+S3mxPX0HMX0DPUpMmscBDjPW5ybJwRa2b+O4srouvXzEev+ENMjXTinR/Q17M5PUH
 2BuChcnPgQaDlVtmCdYMVSNckqyTUvCHD3iM7DMZkcEGyEaxY5DgsGJsmNz5h4CvIgVe
 Hh2baJwJPAu4o8uPG86IgabiIl74FyXhxRXpHFJDTBuZkEdwAlS7CM9XLSxyakVJckiz
 DJ3wE2nYEfKhDBRTORnQw/dqmCWh1Ocv1wt4rH7Al/HtBQ09g0ovLSx8t7geYNJx8PzV
 veFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763473355; x=1764078155;
 h=in-reply-to:references:from:to:cc:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tLFoe+Ox212Q6IhIYveuzqORPCKMuHFtz21Tlq2VIKk=;
 b=FuLwQjutmaTN/rOWX4J2v6ytA/qZU1ucrpC8qNCftb+aIM0p+JQ+Ero9yxxGxSN0hP
 Uur7Yzh48kJNIEB4bqgpyh1P+RkW14hlH0EFZ50xNu1TWTixYzlDdJgDdGeWePdwlALa
 j4rwdpXOppq5Jk9TiHh8CO/dudxLiYE+qt1gHlIpwqb1dAEQMS7ec+hE9YDY17s73AmB
 s+azlxOO8ogzTU+a+ZvC4pYZry1nXCE5/1EaBDRe1LeO+L++l/1EUFRYVnCyYpsPSR3t
 J4Mz4GfVZMcAKP1jgO2PmgEGZklAcqbQacKVoITSMm7Quz9d/BW2sOwGySqCODWqIJJo
 XXtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeWBtwXd8B0JAyhk7dJ0gqG5qeoFS3C9ocOUL2deBwCqcSrA09vIWMfqAcj1DgrlCazUSYCjyXWJnp@nongnu.org
X-Gm-Message-State: AOJu0YzeQtbUIEYqjfgyzUqJVudLjaYPXO9QFDwUv0TdewkFkfMzAf4E
 LCYK/ju1x9GisgXxc9aRqfy3fLQSeL7O6Tr2IdPi/IO1VYv3kYA5s2T1cfBLVOnOmaY=
X-Gm-Gg: ASbGncvJAtc5dL9gkyyEmd2OAWuJVVvXScfHQ/CQgLMPONZ7HQ8OFNEDDmuocse/OKc
 EFt5xKQB6yIEiGRYj7lq+wQdPSDiHmW5gl9Uy7BKkAKOzhhhLBo7twmMN7ovYi7gLGvaXirSoPe
 nAMjRKMenksKIl1v5RbZ5/pDKpzt5R4Kc7ZEjYxeeUcd5stq7kO8fxhyqkJ0DgKPZ6oMC4C5SKg
 fC/9sFp4egDu8uaqDJOIKSUlRsKi3YZ8ks3lzGxjBfbsN61zOyhaRTdF4h2heCVyfqTdCT/+D57
 2InHbfnibMu0IEKR2MqVYtFA11udpzxGhPzCPAEpuB3h9WDY8CefV/GkVriYW0zUfsv9JzTqVlV
 2vHqcM9UfReYamZ/Gn9YLNIIycnJTPEllzo3GHX1EQaPteQrh7Jzy9QTKzAV5FeS+LHsq5Er35N
 Y=
X-Google-Smtp-Source: AGHT+IGSwdNKXSGum/84X+9QXmq+L19J74Jo3ndHSU8X6jSKoQ47MTGhQCN3rHu06U1RVz+AoCN0cQ==
X-Received: by 2002:a17:907:962a:b0:b71:a627:3d9a with SMTP id
 a640c23a62f3a-b7622f58569mr156829666b.0.1763473355269; 
 Tue, 18 Nov 2025 05:42:35 -0800 (PST)
Received: from localhost ([2a02:8308:a00c:e200::3052])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-b734fd80841sm1362757766b.41.2025.11.18.05.42.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 05:42:34 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 18 Nov 2025 14:42:09 +0100
Message-Id: <DEBV4FNF28A7.5SB1P3YUJTA@ventanamicro.com>
Subject: Re: [PATCH 2/3] target/riscv: Fix pointer masking PMM field
 selection logic
Cc: "Palmer Dabbelt" <palmer@dabbelt.com>, "Alistair Francis"
 <alistair.francis@wdc.com>, "Weiwei Li" <liwei1518@gmail.com>, "Daniel
 Henrique Barboza" <dbarboza@ventanamicro.com>, "Liu Zhiwei"
 <zhiwei_liu@linux.alibaba.com>, "open list:RISC-V TCG CPUs"
 <qemu-riscv@nongnu.org>,
 <qemu-riscv-bounces+qemu-riscv=archiver.kernel.org@nongnu.org>
To: <frank.chang@sifive.com>, <qemu-devel@nongnu.org>
From: =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
References: <20251118105936.2839054-1-frank.chang@sifive.com>
 <20251118105936.2839054-3-frank.chang@sifive.com>
In-Reply-To: <20251118105936.2839054-3-frank.chang@sifive.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=rkrcmar@ventanamicro.com; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

2025-11-18T18:59:35+08:00, <frank.chang@sifive.com>:
> From: Frank Chang <frank.chang@sifive.com>
>
> mstatus.MPV only records the previous virtualization state, and does not
> affect pointer masking according to the Zjpm specification.
>
> This patch rewrites riscv_pm_get_pmm() to follow the architectural
> definition of Smmpm, Smnpm, and Ssnpm.
>
> The resulting PMM source for each mode is summarized below:
>
>   * Smmpm + Smnpm + Ssnpm:
>       M-mode:  mseccfg.PMM
>       S-mode:  menvcfg.PMM
>       U-mode:  senvcfg.PMM
>       VS-mode: henvcfg.PMM
>       VU-mode: senvcfg.PMM
>
>   * Smmpm + Smnpm (RVS implemented):
>       M-mode:  mseccfg.PMM
>       S-mode:  menvcfg.PMM
>       U/VS/VU: disabled (Ssnpm not present)
>
>   * Smmpm + Smnpm (RVS not implemented):
>       M-mode:  mseccfg.PMM
>       U-mode:  menvcfg.PMM
>       S/VS/VU: disabled (no S-mode)
>
>   * Smmpm only:
>       M-mode:  mseccfg.PMM
>       Other existing modes: pointer masking disabled
>
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> ---
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> @@ -154,22 +154,30 @@ RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env)
>          }
>          break;
>      case PRV_S:
> -        if (riscv_cpu_cfg(env)->ext_smnpm) {
> -            if (get_field(env->mstatus, MSTATUS_MPV)) {
> -                return get_field(env->henvcfg, HENVCFG_PMM);
> -            } else {
> +        if (!env->virt_enabled) {
> +            if (riscv_cpu_cfg(env)->ext_smnpm) {

It wasn't correct before, but it doesn't seem correct now either.
MPRV+MPV+MPP change the effective access mode to VS without setting
virt_enabled, and henvcfg is supposed to be used in that case.

I liked the way you described the desired behavior in the commit
message:

  M-mode:  mseccfg.PMM
  S-mode:  menvcfg.PMM
  U-mode:  senvcfg.PMM
  VS-mode: henvcfg.PMM
  VU-mode: senvcfg.PMM

Can we have a "switch (get_effective_access_mode(env))" with the same
structure?

Thanks.

---
Other bugs I noticed while skimming the adjust_addr_body() and
riscv_pm_get_pmm():
* Sign extension for HLV/HSV must be performed when vsatp.MODE !=3D Bare.
* The sign extension also depends on the effective mode, and not on the
  current mode.
* MXR should set PMLEN=3D0 for all accesses that aren't M to M, not just
  when using MPRV.

