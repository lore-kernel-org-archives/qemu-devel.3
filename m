Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0204DCF9C7B
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 18:04:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM91Q-00032u-RI; Thu, 20 Nov 2025 13:04:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vM91L-0002wg-AD
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 13:04:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vM91I-00085v-MG
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 13:04:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763661874;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H1qsywmTjPfRVy141w5QC7uOf+CSJWbigf7mMZoLpIo=;
 b=bQsJCamJacBeGMjHopGaJfqwUDhE5p8Aw9V73Oyw5oIunFROiUEwX2XFLeu9dTSvjgNdP3
 PDyU6O3AEFYEnR8LFsAF7RAheSGXZeNoCSHDLh8FgIXXqbVO/TPP+FCoRY5HXsexyubjZ4
 Th0Oua5U7L+Xg+6RR55vcT2q2QR/qzk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-o45SGxPTMDu36U13uLxYKw-1; Thu, 20 Nov 2025 13:04:31 -0500
X-MC-Unique: o45SGxPTMDu36U13uLxYKw-1
X-Mimecast-MFC-AGG-ID: o45SGxPTMDu36U13uLxYKw_1763661870
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-42b2b642287so549151f8f.2
 for <qemu-devel@nongnu.org>; Thu, 20 Nov 2025 10:04:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763661870; x=1764266670;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H1qsywmTjPfRVy141w5QC7uOf+CSJWbigf7mMZoLpIo=;
 b=AHiR68QGu3HXUhNqviRlnDaMxYwpINGbqPgyxxHyD8OuGnRtzHtBCWkssdIvIM0yLT
 55FQlq6gkPy2Zeqdc6iH3y8axlL6u0LfbwMUA6TgnVGmRYSDfabNvq9vO3ucqTnbxdwr
 C7OvRYqZTwmx2uR965JPsDZGORMYUi7jQ271My5GgC4o3wXuBijrEu9OOsuwktWf7+yA
 OeXKD2UJZNGy8PqI7o2lc1rGyuUy7Cp2WUmWp4mKBQQcB5SpWgrLjgT4tI2/h2QFSTvB
 SXhPdNWDWCtK0/6PXe4VeBjjOAx/A7AqWpjDakOfiPKpcVxv8BZg1PMWlg5DJZ5YszeM
 mGZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaM+0SH60CeBhn/BTy+OPqwHSLq8bcX0pkBf0nETmLjlwolx3hx0Yt+K9ef/SGFzugsbe1g4N6nY5R@nongnu.org
X-Gm-Message-State: AOJu0YyYPMT3vwsG5AX40Exk8iKwi1xjw6aiUw8qtBsdA3wzSJQZweCo
 WbAW6opQkIhPbHBDNnDcfRXREtgn+0k2BuNzf4QBGTuQh/SivDMKhrTucZUfKkdoNLdrpuTXN/F
 Ny6DXYizFPOCNK6HKwBKN29eC200+ilxfM/s0/l0fUTKZq2IoVUPh/7Ne
X-Gm-Gg: ASbGncsmebEjIEkazEEH/vJHtHqKrJJ5NyW8IE8v85+S6plAMVFHpCkbPpcQuBZ/Mtf
 18yqkIVeYj/K+hJuX/MA/1U7qXNZH5dRXkwSF2naxVlFUzsZPMnaFL9RCHkzryZ9BOFoBBIv5i+
 QaYmYofE4ZP2Rdze68FcOblM080LtNS0miXVxpXFZL0sxdanNOFxjKqRc1W2ZpJdGawwXbBTKyb
 zijYY7gCHV9zVFVl6Nbg4wY61MtozWSCv+/h362P7zLZCYONffCfhRauFyHShubIxtpimHSUMqv
 OHZ980k7agYaA98P3GCGbtfJig2AfDIlYWPhBQd3snrJCRARV6J5S9G/DJC3tDezLXtoqj8Sv3I
 YtfWHTJRW0uCJm398K+RutkeSBpaAv9xkxOZijfW9h3wPs6ceqKOlFkpMZA==
X-Received: by 2002:a05:6000:200e:b0:42b:5521:31c6 with SMTP id
 ffacd0b85a97d-42cb9a55d76mr4577615f8f.54.1763661870206; 
 Thu, 20 Nov 2025 10:04:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGkr1sog0D8x8e0i0AZ7sDlo7GO72R/Nyn/dVqoUH4E/JSCp3U/e5QZkJZtWE0wbmrcF98SAw==
X-Received: by 2002:a05:6000:200e:b0:42b:5521:31c6 with SMTP id
 ffacd0b85a97d-42cb9a55d76mr4577564f8f.54.1763661869555; 
 Thu, 20 Nov 2025 10:04:29 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7f2e5a3sm6840325f8f.6.2025.11.20.10.04.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Nov 2025 10:04:29 -0800 (PST)
Message-ID: <ef7a800a-99fe-472a-b3a2-c6eff15d65ff@redhat.com>
Date: Thu, 20 Nov 2025 19:04:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.0] arm: add DCZID_EL0 to idregs array
Content-Language: en-US
To: Cornelia Huck <cohuck@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
References: <20251119134414.2892640-1-cohuck@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251119134414.2892640-1-cohuck@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Connie,

On 11/19/25 2:44 PM, Cornelia Huck wrote:
> This requires a bit of care, since we still have to handle the EL
> specific part (DCZID_EL0.DZP). Callers can set/access dcz_blocksize
what do you mean by EL specific part?

you may simply say that at the moment only bs field is handled as part
of cpu.dcz_blocklen
so you replace all the users of that field by accessors to the
isar.idreg[] storage
> via a wrapper working on DCZID_EL.BS.
>
> KVM currently does not support DCZID_EL0 via ONE_REG, and actually
> does not need to work with it, so provide a dummy value for now.
>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>
> This is another followup on the ID register rework. The last missing set
> of registers are CCSIDR* and friends, then we should be able to switch
> to autogenerated registers (probably with a different script than the
> last attempt.)
>
> ---
>  target/arm/cpu-sysregs.h.inc   |  1 +
>  target/arm/cpu.c               |  2 +-
>  target/arm/cpu.h               | 15 +++++++++++++--
>  target/arm/cpu64.c             |  4 ++--
>  target/arm/helper.c            |  3 ++-
>  target/arm/kvm.c               |  7 +++++++
>  target/arm/tcg/cpu64.c         | 22 +++++++++++-----------
>  target/arm/tcg/helper-a64.c    |  2 +-
>  target/arm/tcg/mte_helper.c    |  4 ++--
>  target/arm/tcg/translate-a64.c |  2 +-
>  10 files changed, 41 insertions(+), 21 deletions(-)
>
> diff --git a/target/arm/cpu-sysregs.h.inc b/target/arm/cpu-sysregs.h.inc
> index 2bb2861c6234..7f3aa8b991aa 100644
> --- a/target/arm/cpu-sysregs.h.inc
> +++ b/target/arm/cpu-sysregs.h.inc
> @@ -39,3 +39,4 @@ DEF(ID_MMFR5_EL1, 3, 0, 0, 3, 6)
>  DEF(CLIDR_EL1, 3, 1, 0, 0, 1)
>  DEF(ID_AA64ZFR0_EL1, 3, 0, 0, 4, 4)
>  DEF(CTR_EL0, 3, 3, 0, 0, 1)
> +DEF(DCZID_EL0, 3, 3, 0, 0, 7)
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 39292fb9bc1f..ad99233839c0 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -2184,7 +2184,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
>  #endif
>  
>      if (tcg_enabled()) {
> -        int dcz_blocklen = 4 << cpu->dcz_blocksize;
> +        int dcz_blocklen = 4 << get_dcz_blocksize(cpu);
>  
>          /*
>           * We only support DCZ blocklen that fits on one page.
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 39f2b2e54deb..e3fa6ebda3f2 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -1111,8 +1111,6 @@ struct ArchCPU {
>      bool prop_pauth_qarma5;
>      bool prop_lpa2;
>  
> -    /* DCZ blocksize, in log_2(words), ie low 4 bits of DCZID_EL0 */
> -    uint8_t dcz_blocksize;
>      /* GM blocksize, in log_2(words), ie low 4 bits of GMID_EL0 */
>      uint8_t gm_blocksize;
>  
> @@ -1178,6 +1176,19 @@ struct ARMCPUClass {
>      ResettablePhases parent_phases;
>  };
>  
> +static inline uint8_t get_dcz_blocksize(ARMCPU *cpu)
While at it I would replace dcz_blocksize by dczid_el0_bs to be more
explicit
> +{
> +    return cpu->isar.idregs[DCZID_EL0_IDX] & 0xf;
extract64?
> +}
> +
> +static inline void set_dcz_blocksize(ARMCPU *cpu, uint8_t bs)
> +{
> +    uint64_t dczid = cpu->isar.idregs[DCZID_EL0_IDX];
> +
> +    /* keep dzp unchanged */
> +    cpu->isar.idregs[DCZID_EL0_IDX] = (dczid & ~0xf) | bs;
deposit64?
> +}
> +
>  /* Callback functions for the generic timer's timers. */
>  void arm_gt_ptimer_cb(void *opaque);
>  void arm_gt_vtimer_cb(void *opaque);
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index ae84d8e42050..23924f251020 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -689,7 +689,7 @@ static void aarch64_a57_initfn(Object *obj)
>      cpu->ccsidr[1] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 3, 64, 48 * KiB, 2);
>      /* 2048KB L2 cache */
>      cpu->ccsidr[2] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 16, 64, 2 * MiB, 7);
> -    cpu->dcz_blocksize = 4; /* 64 bytes */
> +    set_dcz_blocksize(cpu, 4); /* 64 bytes */
>      cpu->gic_num_lrs = 4;
>      cpu->gic_vpribits = 5;
>      cpu->gic_vprebits = 5;
> @@ -751,7 +751,7 @@ static void aarch64_a53_initfn(Object *obj)
>      cpu->ccsidr[1] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 1, 64, 32 * KiB, 2);
>      /* 1024KB L2 cache */
>      cpu->ccsidr[2] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 16, 64, 1 * MiB, 7);
> -    cpu->dcz_blocksize = 4; /* 64 bytes */
> +    set_dcz_blocksize(cpu, 4); /* 64 bytes */
>      cpu->gic_num_lrs = 4;
>      cpu->gic_vpribits = 5;
>      cpu->gic_vprebits = 5;
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 27ebc6f29b82..8dfeaff25350 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -3324,7 +3324,8 @@ static uint64_t aa64_dczid_read(CPUARMState *env, const ARMCPRegInfo *ri)
the name of the function seems to indicate you read the whole DCZID but
I see the DZP bit is tweaked below. Do you get why we can't return the
raw id reg?
>      if (aa64_zva_access(env, NULL, false) == CP_ACCESS_OK) {
>          dzp_bit = 0;
>      }
> -    return cpu->dcz_blocksize | dzp_bit;
> +
nit spurious NL
> +    return cpu->isar.idregs[DCZID_EL0_IDX] | dzp_bit;
>  }
>  
>  static CPAccessResult sp_el0_access(CPUARMState *env, const ARMCPRegInfo *ri,
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 0d57081e69fb..5d65f64addc6 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -2020,6 +2020,13 @@ int kvm_arch_init_vcpu(CPUState *cs)
>      }
>      cpu->mp_affinity = mpidr & ARM64_AFFINITY_MASK;
>  
> +    /*
> +     * We currently do not need this, except for tcg. Should KVM gain support
> +     * for accessing DCZID_EL0 via ONE_REG, we'll overwrite this below. Just
> +     * set a dummy value that corresponds to the minimum value for FEAT_MTE2.
> +     */
> +    set_dcz_blocksize(cpu, 2);
it is not clear to me why we need that?
> +
>      return kvm_arm_init_cpreg_list(cpu);
>  }
>  
> diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
> index 6871956382f7..d86fc38e7157 100644
> --- a/target/arm/tcg/cpu64.c
> +++ b/target/arm/tcg/cpu64.c
> @@ -72,7 +72,7 @@ static void aarch64_a35_initfn(Object *obj)
>      SET_IDREG(isar, ID_AA64MMFR0, 0x00101122);
>      SET_IDREG(isar, ID_AA64MMFR1, 0);
>      SET_IDREG(isar, CLIDR, 0x0a200023);
> -    cpu->dcz_blocksize = 4;
> +    set_dcz_blocksize(cpu, 4);
>  
>      /* From B2.4 AArch64 Virtual Memory control registers */
>      cpu->reset_sctlr = 0x00c50838;
> @@ -219,7 +219,7 @@ static void aarch64_a55_initfn(Object *obj)
>      /* Ordered by B2.4 AArch64 registers by functional group */
>      SET_IDREG(isar, CLIDR, 0x82000023);
>      cpu->ctr = 0x84448004; /* L1Ip = VIPT */
> -    cpu->dcz_blocksize = 4; /* 64 bytes */
> +    set_dcz_blocksize(cpu, 4); /* 64 bytes */
>      SET_IDREG(isar, ID_AA64DFR0, 0x0000000010305408ull);
>      SET_IDREG(isar, ID_AA64ISAR0, 0x0000100010211120ull);
>      SET_IDREG(isar, ID_AA64ISAR1, 0x0000000000100001ull);
> @@ -325,7 +325,7 @@ static void aarch64_a72_initfn(Object *obj)
>      cpu->ccsidr[1] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 3, 64, 48 * KiB, 2);
>      /* 1MB L2 cache */
>      cpu->ccsidr[2] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 16, 64, 1 * MiB, 7);
> -    cpu->dcz_blocksize = 4; /* 64 bytes */
> +    set_dcz_blocksize(cpu, 4); /* 64 bytes */
>      cpu->gic_num_lrs = 4;
>      cpu->gic_vpribits = 5;
>      cpu->gic_vprebits = 5;
> @@ -352,7 +352,7 @@ static void aarch64_a76_initfn(Object *obj)
>      /* Ordered by B2.4 AArch64 registers by functional group */
>      SET_IDREG(isar, CLIDR, 0x82000023);
>      cpu->ctr = 0x8444C004;
> -    cpu->dcz_blocksize = 4;
> +    set_dcz_blocksize(cpu, 4);
>      SET_IDREG(isar, ID_AA64DFR0, 0x0000000010305408ull);
>      SET_IDREG(isar, ID_AA64ISAR0, 0x0000100010211120ull);
>      SET_IDREG(isar, ID_AA64ISAR1, 0x0000000000100001ull);
> @@ -424,7 +424,7 @@ static void aarch64_a78ae_initfn(Object *obj)
>      /* Ordered by 3.2.4 AArch64 registers by functional group */
>      SET_IDREG(isar, CLIDR, 0x82000023);
>      cpu->ctr = 0x9444c004;
> -    cpu->dcz_blocksize = 4;
> +    set_dcz_blocksize(cpu, 4);
>      SET_IDREG(isar, ID_AA64DFR0, 0x0000000110305408ull);
>      SET_IDREG(isar, ID_AA64ISAR0, 0x0010100010211120ull);
>      SET_IDREG(isar, ID_AA64ISAR1, 0x0000000001200031ull);
> @@ -517,7 +517,7 @@ static void aarch64_a64fx_initfn(Object *obj)
>      cpu->ccsidr[1] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 256, 64 * KiB, 2);
>      /* 8MB L2 cache */
>      cpu->ccsidr[2] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 16, 256, 8 * MiB, 7);
> -    cpu->dcz_blocksize = 6; /* 256 bytes */
> +    set_dcz_blocksize(cpu, 6); /* 256 bytes */
>      cpu->gic_num_lrs = 4;
>      cpu->gic_vpribits = 5;
>      cpu->gic_vprebits = 5;
> @@ -673,7 +673,7 @@ static void aarch64_neoverse_n1_initfn(Object *obj)
>      /* Ordered by B2.4 AArch64 registers by functional group */
>      SET_IDREG(isar, CLIDR, 0x82000023);
>      cpu->ctr = 0x8444c004;
> -    cpu->dcz_blocksize = 4;
> +    set_dcz_blocksize(cpu, 4);
>      SET_IDREG(isar, ID_AA64DFR0, 0x0000000110305408ull);
>      SET_IDREG(isar, ID_AA64ISAR0, 0x0000100010211120ull);
>      SET_IDREG(isar, ID_AA64ISAR1, 0x0000000000100001ull);
> @@ -749,7 +749,7 @@ static void aarch64_neoverse_v1_initfn(Object *obj)
>      /* Ordered by 3.2.4 AArch64 registers by functional group */
>      SET_IDREG(isar, CLIDR, 0x82000023);
>      cpu->ctr = 0xb444c004; /* With DIC and IDC set */
> -    cpu->dcz_blocksize = 4;
> +    set_dcz_blocksize(cpu, 4);
>      SET_IDREG(isar, ID_AA64AFR0, 0x00000000);
>      SET_IDREG(isar, ID_AA64AFR1, 0x00000000);
>      SET_IDREG(isar, ID_AA64DFR0, 0x000001f210305519ull);
> @@ -1011,7 +1011,7 @@ static void aarch64_a710_initfn(Object *obj)
>      SET_IDREG(isar, CLIDR, 0x0000001482000023ull);
>      cpu->gm_blocksize      = 4;
>      cpu->ctr               = 0x000000049444c004ull;
> -    cpu->dcz_blocksize     = 4;
> +    set_dcz_blocksize(cpu, 4);
>      /* TODO FEAT_MPAM: mpamidr_el1 = 0x0000_0001_0006_003f */
>  
>      /* Section B.5.2: PMCR_EL0 */
> @@ -1113,7 +1113,7 @@ static void aarch64_neoverse_n2_initfn(Object *obj)
>      SET_IDREG(isar, CLIDR, 0x0000001482000023ull);
>      cpu->gm_blocksize      = 4;
>      cpu->ctr               = 0x00000004b444c004ull;
> -    cpu->dcz_blocksize     = 4;
> +    set_dcz_blocksize(cpu, 4);
>      /* TODO FEAT_MPAM: mpamidr_el1 = 0x0000_0001_001e_01ff */
>  
>      /* Section B.7.2: PMCR_EL0 */
> @@ -1377,7 +1377,7 @@ void aarch64_max_tcg_initfn(Object *obj)
>       * blocksize since we don't have to follow what the hardware does.
>       */
>      cpu->ctr = 0x80038003; /* 32 byte I and D cacheline size, VIPT icache */
> -    cpu->dcz_blocksize = 7; /*  512 bytes */
> +    set_dcz_blocksize(cpu, 7); /*  512 bytes */
>  #endif
>      cpu->gm_blocksize = 6;  /*  256 bytes */
>  
> diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
> index ba1d775d818e..045a00b43373 100644
> --- a/target/arm/tcg/helper-a64.c
> +++ b/target/arm/tcg/helper-a64.c
> @@ -792,7 +792,7 @@ void HELPER(dc_zva)(CPUARMState *env, uint64_t vaddr_in)
>       * (which matches the usual QEMU behaviour of not implementing either
>       * alignment faults or any memory attribute handling).
>       */
> -    int blocklen = 4 << env_archcpu(env)->dcz_blocksize;
> +    int blocklen = 4 << get_dcz_blocksize(env_archcpu(env));
>      uint64_t vaddr = vaddr_in & ~(blocklen - 1);
>      int mmu_idx = arm_env_mmu_index(env);
>      void *mem;
> diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
> index bb48fe359b8c..20f8351d8676 100644
> --- a/target/arm/tcg/mte_helper.c
> +++ b/target/arm/tcg/mte_helper.c
> @@ -545,7 +545,7 @@ void HELPER(stzgm_tags)(CPUARMState *env, uint64_t ptr, uint64_t val)
>       * i.e. 32 bytes, which is an unreasonably small dcz anyway,
>       * to make sure that we can access one complete tag byte here.
>       */
> -    log2_dcz_bytes = env_archcpu(env)->dcz_blocksize + 2;
> +    log2_dcz_bytes = get_dcz_blocksize(env_archcpu(env)) + 2;
>      log2_tag_bytes = log2_dcz_bytes - (LOG2_TAG_GRANULE + 1);
>      dcz_bytes = (intptr_t)1 << log2_dcz_bytes;
>      tag_bytes = (intptr_t)1 << log2_tag_bytes;
> @@ -945,7 +945,7 @@ uint64_t HELPER(mte_check_zva)(CPUARMState *env, uint32_t desc, uint64_t ptr)
>       * i.e. 32 bytes, which is an unreasonably small dcz anyway, to make
>       * sure that we can access one complete tag byte here.
>       */
> -    log2_dcz_bytes = env_archcpu(env)->dcz_blocksize + 2;
> +    log2_dcz_bytes = get_dcz_blocksize(env_archcpu(env)) + 2;
>      log2_tag_bytes = log2_dcz_bytes - (LOG2_TAG_GRANULE + 1);
>      dcz_bytes = (intptr_t)1 << log2_dcz_bytes;
>      tag_bytes = (intptr_t)1 << log2_tag_bytes;
> diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
> index 08b21d7dbfa6..c72611e55e45 100644
> --- a/target/arm/tcg/translate-a64.c
> +++ b/target/arm/tcg/translate-a64.c
> @@ -10712,7 +10712,7 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
>      dc->vec_stride = 0;
>      dc->cp_regs = arm_cpu->cp_regs;
>      dc->features = env->features;
> -    dc->dcz_blocksize = arm_cpu->dcz_blocksize;
> +    dc->dcz_blocksize = get_dcz_blocksize(arm_cpu);
>      dc->gm_blocksize = arm_cpu->gm_blocksize;
>  
>  #ifdef CONFIG_USER_ONLY
Thanks

Eric


