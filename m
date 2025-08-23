Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 497C9CA0EE4
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Aug 2025 10:42:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uplhJ-0006pS-TV; Sat, 23 Aug 2025 06:42:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1uplhI-0006ov-LH
 for qemu-devel@nongnu.org; Sat, 23 Aug 2025 06:42:08 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1uplhG-00059K-Cg
 for qemu-devel@nongnu.org; Sat, 23 Aug 2025 06:42:08 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-459fc779bc3so26245e9.1
 for <qemu-devel@nongnu.org>; Sat, 23 Aug 2025 03:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1755945723; x=1756550523; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=A52l1A9VVDaEBVZbxzO51pCSYaQBBPLyn/x3KFuGomg=;
 b=bcE6lXHR77pK2miVZZDflqVafbTXOXbKLHl11ruILU2A+kbM8uc/Jyc6ZMpw2f+Lgz
 D6fL/+4o87oUkS+knCRhLSXJHp4mvdUpKnQHnjl0NtsTdaJcP8ycytYPQZYECOj1pTuQ
 m6GKg0YV7SCDMlyOhUzO+2FYfLB0UOsarItc3ihHJk/35XFEfACrznVGS2D9ljpiEPwp
 VcU3JlYlyMZrXcalHWf1Vnzxo0WroEzkYHNuAhNG+lEMGcFcDSLwQaG1YHbe13hiMG7f
 O8fgnNIEfhkI3cnS9NRsPh9rxD7GfZMKnZk/YzS2WtgK7BXGpZPbPo67b7hxp8exnrHo
 AKfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755945723; x=1756550523;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=A52l1A9VVDaEBVZbxzO51pCSYaQBBPLyn/x3KFuGomg=;
 b=JzPUqiLZcTk3oaJmAwakffOPKcXxtXzX3dhLFgPJTjvm6JChKAJBcvr9ygz0Vcuwy3
 5OCvG0TNWfZVCyS2osKayPG0ZdXbO/405VP8nmQp0LKyIHRk2aqY8+QNuAhenH+ckL8w
 jxIUENMFf4XuRbyxn9WYebi8CQEHVS7RkEDljT5guxZWoj9ZRt/ycml64i1BdDbDzbDM
 OWHalWOV5IgoVC+/lhxo0SWPNRc7UpIYEUxg06Dn+IDGWc62K/uldJvmj60GtPuGTQAE
 BUzG6FjDnJAu0LepCCNLjS309oB+lms3hkjlyZrDGSogMOCfxHqU2IcY4ogR/vfmsMvA
 VprA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzyJUKP4c8kwFK925dP1lPVG6vJE5+6lKYDEnsEd3ZLmvNjBcMSQ6c4s4lSk4XLiHdQc9d86bTToz7@nongnu.org
X-Gm-Message-State: AOJu0YxENq8IstHGAFR4aEXlIZowW4DCZ9kud6kKMA6ZcPwioS7n0Daf
 ncy05TXoWuDU5rL6nvVJZBmptSETS+CA4N0SFiw8TnGwMol2hsDQs68xQOGgr2fG0A==
X-Gm-Gg: ASbGncvSCeJPpPKg4/dAxz8Vdhie1lrnM0fTWEIPHPZz5GclnCt4GPUMpmTY79kvSDn
 VyHb1ikgTJltpTyPAqhwyK2Yv5oFI6ZmERuHhw8Ab0/chg/I/SdTAWtn9xdrdNV6CSNsCOLD9TM
 bpBeqDZizyuoR/aBb24rMwLUTyvIokZKVAlow/oMsDDkvATvvHFcG5vigtfZUMrYdcBvX6bhM1R
 jQfnZadJQxi69o0tcf1X8V2Zvn6xyAZGn5KQ1jJrhYibZywBo1AUzxYrjXYhQ0gQnXzLblCw0ej
 JcSytMnNZnufA3LEZRrA/kl+23dV+pDFUKFjoQI1coVDKl1FSNUechUpv+yOuLFwNCdMTzcS7hV
 z4RAHXPzuqgYbpH+ZA64tDEnHrIy5ptTFdT0Rpk/FageCJxuyTeYCqzKhd919HsGlbeI=
X-Google-Smtp-Source: AGHT+IGy4gAqr1dlpfjyCuIVbSTB07o8JcOsFJhJ6uSj72duMR670jYZvpkQNZohY1gg8+//duHK3Q==
X-Received: by 2002:a05:600c:8906:b0:456:4607:b193 with SMTP id
 5b1f17b1804b1-45b5863ac74mr744845e9.7.1755945723009; 
 Sat, 23 Aug 2025 03:42:03 -0700 (PDT)
Received: from google.com (248.27.205.35.bc.googleusercontent.com.
 [35.205.27.248]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c70f237fefsm3162897f8f.30.2025.08.23.03.42.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Aug 2025 03:42:02 -0700 (PDT)
Date: Sat, 23 Aug 2025 10:41:59 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Tao Tang <tangtao1634@phytium.com.cn>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 jean-philippe@linaro.org
Subject: Re: [RFC 02/11] hw/arm/smmuv3: Implement read/write logic for secure
 registers
Message-ID: <aKma98hlAWG9M4h_@google.com>
References: <20250806151134.365755-1-tangtao1634@phytium.com.cn>
 <20250806151134.365755-3-tangtao1634@phytium.com.cn>
 <aKOaIcPp26kbS3Nn@google.com>
 <53607fe8-0555-4408-bfa6-e4b95d44e230@phytium.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <53607fe8-0555-4408-bfa6-e4b95d44e230@phytium.com.cn>
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=smostafa@google.com; helo=mail-wm1-x330.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=unavailable autolearn_force=no
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

On Wed, Aug 20, 2025 at 11:21:02PM +0800, Tao Tang wrote:
> 
> On 2025/8/19 05:24, Mostafa Saleh wrote:
> > On Wed, Aug 06, 2025 at 11:11:25PM +0800, Tao Tang wrote:
> > > This patch builds upon the previous introduction of secure register
> > > definitions by providing the functional implementation for their access.
> > > 
> > > The availability of the secure programming interface is now correctly
> > > gated by the S_IDR1.SECURE_IMPL bit. When this bit indicates that
> > > secure functionality is enabled, the I/O handlers (smmuv3_read and
> > > smmuv3_write) will correctly dispatch accesses to the secure
> > > register space.
> > > 
> > > Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> > > ---
> > >   hw/arm/smmuv3-internal.h |   5 +
> > >   hw/arm/smmuv3.c          | 451 +++++++++++++++++++++++++++++++++++++++
> > >   2 files changed, 456 insertions(+)
> > > 
> > > diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
> > > index 483aaa915e..1a8b1cb204 100644
> > > --- a/hw/arm/smmuv3-internal.h
> > > +++ b/hw/arm/smmuv3-internal.h
> > > @@ -122,6 +122,11 @@ REG32(CR0,                 0x20)
> > >   #define SMMU_CR0_RESERVED 0xFFFFFC20
> > > +/*
> > > + * BIT1 and BIT4 are RES0 in SMMU_S_CRO
> > > + */
> > > +#define SMMU_S_CR0_RESERVED 0xFFFFFC12
> > > +
> > >   REG32(CR0ACK,              0x24)
> > >   REG32(CR1,                 0x28)
> > >   REG32(CR2,                 0x2c)
> > > diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> > > index ab67972353..619180d204 100644
> > > --- a/hw/arm/smmuv3.c
> > > +++ b/hw/arm/smmuv3.c
> > > @@ -317,6 +317,18 @@ static void smmuv3_init_regs(SMMUv3State *s)
> > >       s->gerrorn = 0;
> > >       s->statusr = 0;
> > >       s->gbpa = SMMU_GBPA_RESET_VAL;
> > > +
> > > +    /* Initialize secure state */
> > > +    memset(s->secure_idr, 0, sizeof(s->secure_idr));
> > > +    /* Secure EL2 and Secure stage 2 support */
> > > +    s->secure_idr[1] = FIELD_DP32(s->secure_idr[1], S_IDR1, SEL2, 1);
> > AFAIU, this is wrong, SEL2 means that the SMMU has dual stage-2,
> > one for secure (S_S2TTB) and one for non-secure IPAs(S2TTB).
> > Which is not implemented in this series.
> 
> 
> Hi Mostafa,
> 
> Thank you for the very detailed and helpful review. Your feedback is spot
> on, and I'd like to address your points and ask for a quick confirmation on
> them.
> 
> Regarding the SEL2 bit, you are absolutely right, my understanding was
> incorrect. I've spent the last few days reviewing the manual to better
> understand the selection between Secure and Non-secure Stage 2 translations.
> I would be very grateful if you could confirm if my new understanding is
> correct:
> 
> - In Stage 2-only mode (Stage 1 bypassed), the choice between a Secure or
> Non-secure IPA translation is determined solely by STE.NSCFG.
> 

Yes, but that's only with SMMU_IDR1.ATTR_PERMS_OVR which Qemu doesn't
advertise, so in our case it's always secure.

> - In Stage 1-enabled mode, STE.NSCFG is ignored. The choice is determined by
> the translation process, starting from CD.NSCFGx, with the output NS
> attribute being the result of intermediate NSTable flags and the final
> descriptor.NS bit (TTD.NSTable, TTD.NS).
> 

You have to differentiate between the security state of the translation and
the security state of the translation table access.

For stage-1, the security state is determined by the NS bit in the last
level PTE, which in case of nested translation it will choose between S2TTB
or S_S2TTB.

Also, note that the stage-2 also have an NS which define the final attribute
of the transaction.

You have to also be careful around things such as NSCFG{0,1} as it might
change which stage-2 is used for the stage-1 TTB walk.

I see, in your patches, all the page-table access is done using the secure
state of the SID which is not correct.


> Based on this, I plan to have an internal flag, perhaps named
> target_ipa_is_ns in SMMUTransCfg.SMMUS2Cfg struct, to track the outcome of
> this process. This flag will then determine whether S_S2TTB or S2TTB is used
> for the Stage 2 translation.
> 

I am worried that it's not that simple for a single secure nested translation
you can have multiple stage-2 walks where some might be secure and others not,
so I imagine this some how will be determined from each stage-1 walk and
some how returned (maybe in the TLB struct) which is then the stage-2
walk looks into.

I am not sure how complicated it is to manage 2 stage-2 with the current code
base, so my advice would be to split the problem; for now you can drop SEL2
from this series and rely on NS stage-2.

And later, it can be added separately, but that’s up to you and the maintainers
on how they want to do this, I will try to review as much as I can.

Also, according to the spec:
"STT is 1 in implementations where SMMU_S_IDR1.SEL2 == 1."
which requires extra work in the translation table code to support this
feature.

> 
> > 
> > > +    /* Secure state implemented */
> > > +    s->secure_idr[1] = FIELD_DP32(s->secure_idr[1], S_IDR1,
> > > +        SECURE_IMPL, 1);
> > > +    s->secure_idr[1] = FIELD_DP32(s->secure_idr[1], S_IDR1,
> > > +        S_SIDSIZE, SMMU_IDR1_SIDSIZE);
> > > +
> > > +    s->secure_gbpa = SMMU_GBPA_RESET_VAL;
> > >   }
> > >   static int smmu_get_ste(SMMUv3State *s, dma_addr_t addr, STE *buf,
> > > @@ -1278,6 +1290,12 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage)
> > >       }
> > >   }
> > > +/* Check if the SMMU hardware itself implements secure state features */
> > > +static inline bool smmu_hw_secure_implemented(SMMUv3State *s)
> > > +{
> > > +    return FIELD_EX32(s->secure_idr[1], S_IDR1, SECURE_IMPL);
> > > +}
> > > +
> > I see that the secure SMMU support is unconditional. So, is this always true?
> > Also, how that looks with migration?
> 
> For the v2 series, my plan is to make SECURE_IMPL a user-configurable device
> property. I will add a "secure-enabled" property to smmuv3_properties and
> ensure all necessary states are added to the VMStateDescription to handle
> migration correctly. Does this approach sound reasonable to you?

Yes, that makes sense.

> 
> 
> > 
> > >   static int smmuv3_cmdq_consume(SMMUv3State *s)
> > >   {
> > >       SMMUState *bs = ARM_SMMU(s);
> > > @@ -1508,9 +1526,91 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
> > >       return 0;
> > >   }
> > > +/* Helper function for secure register write validation */
> > > +static bool smmu_validate_secure_write(MemTxAttrs attrs, bool secure_impl,
> > > +                                       hwaddr offset, const char *reg_name)
> > > +{
> > > +    if (!attrs.secure || !secure_impl) {
> > > +        const char *reason = !attrs.secure ?
> > > +            "Non-secure write attempt" :
> > > +            "SMMU didn't implement Security State";
> > > +        qemu_log_mask(LOG_GUEST_ERROR,
> > > +                      "%s: %s at offset 0x%" PRIx64 " (%s, WI)\n",
> > > +                      __func__, reason, offset, reg_name);
> > > +        return false;
> > > +    }
> > > +    return true;
> > > +}
> > > +
> > > +/* Helper function for secure register read validation */
> > > +static bool smmu_validate_secure_read(MemTxAttrs attrs, bool secure_impl,
> > > +                                      hwaddr offset, const char *reg_name,
> > > +                                      uint64_t *data)
> > > +{
> > > +    if (!attrs.secure || !secure_impl) {
> > > +        const char *reason = !attrs.secure ?
> > > +            "Non-secure read attempt" :
> > > +            "SMMU didn't implement Security State";
> > > +        qemu_log_mask(LOG_GUEST_ERROR,
> > > +                      "%s: %s at offset 0x%" PRIx64 " (%s, RAZ)\n",
> > > +                      __func__, reason, offset, reg_name);
> > > +        *data = 0; /* RAZ */
> > > +        return false;
> > > +    }
> > > +    return true;
> > > +}
> > > +
> > > +/* Macro for secure write validation - returns early if validation fails */
> > > +#define SMMU_CHECK_SECURE_WRITE(reg_name) \
> > > +    do { \
> > > +        if (!smmu_validate_secure_write(attrs, secure_impl, offset, \
> > > +                                        reg_name)) { \
> > > +            return MEMTX_OK; \
> > > +        } \
> > > +    } while (0)
> > > +
> > > +/* Macro for attrs.secure only validation */
> > > +#define SMMU_CHECK_ATTRS_SECURE(reg_name) \
> > > +    do { \
> > > +        if (!attrs.secure) { \
> > > +            qemu_log_mask(LOG_GUEST_ERROR, \
> > > +                          "%s: Non-secure write attempt at offset " \
> > > +                          "0x%" PRIx64 " (%s, WI)\n", \
> > > +                          __func__, offset, reg_name); \
> > > +            return MEMTX_OK; \
> > > +        } \
> > > +    } while (0)
> > > +
> > > +/* Macro for secure read validation - returns RAZ if validation fails */
> > > +#define SMMU_CHECK_SECURE_READ(reg_name) \
> > > +    do { \
> > > +        if (!smmu_validate_secure_read(attrs, secure_impl, offset, \
> > > +                                       reg_name, data)) { \
> > > +            return MEMTX_OK; \
> > > +        } \
> > > +    } while (0)
> > > +
> > > +/* Macro for attrs.secure only validation (read) */
> > > +#define SMMU_CHECK_ATTRS_SECURE_READ(reg_name) \
> > > +    do { \
> > > +        if (!attrs.secure) { \
> > > +            qemu_log_mask(LOG_GUEST_ERROR, \
> > > +                          "%s: Non-secure read attempt at offset " \
> > > +                          "0x%" PRIx64 " (%s, RAZ)\n", \
> > > +                          __func__, offset, reg_name); \
> > > +            *data = 0; \
> > > +            return MEMTX_OK; \
> > > +        } \
> > > +    } while (0)
> > > +
> > > 
> > Can’t we just have one check? If the access > SMMU_SECURE_BASE_OFFSET, just
> > check the security state?
> > 
> > And then based on banking, many of those switches will be common with
> > non secure cases.
> > 
> > Thanks,
> > Mostafa
> 
> 
> I have already refactored this part in my v2 series, exactly as you
> proposed. This also addresses your earlier feedback on patch #1 regarding
> the overall structure:
> 
> > As Philippe mentioned, this would be better the secure state is separated
> > in another instance of the struct, that seems it would reduce a lot of the
> > duplication later around the logic of MMIO and queues... in the next
> > patches.
> 
> The new code performs a single, necessary security state check at the entry
> point of the MMIO handlers. The rest of the logic relies on the banking
> mechanism, which makes the implementation generic for Non-secure, Secure,
> and future states like Realm/Root. The new structure looks like this:
> 
> /* Structure for one register bank */
> typedef struct SMMUv3Bank {
>     uint32_t idr[6];     /* IDR0-IDR5, note: IDR5 only used for NS bank */
>     uint32_t cr[3];      /* CR0-CR2 */
>     uint32_t cr0ack;
>     uint32_t init;       /* S_INIT register (secure only), reserved for NS
> */
>     uint32_t gbpa;
> 
> ......
> 
>     SMMUQueue eventq, cmdq;
> } SMMUv3Bank;
> 
> struct SMMUv3State {
>     SMMUState     smmu_state;
> 
>     /* Shared (non-banked) registers and state */
>     uint32_t features;
>     uint8_t sid_size;
>     uint8_t sid_split;
> 
> ......
> 
>     /* Banked registers for all access */
>     SMMUv3Bank bank[SMMU_SEC_IDX_NUM];
> ......
> };
> 

Yes, IMO,that’s the right approach. Although that might make the
migration code more complicated as we changed the state struct.

Thanks,
Mostafa

> 
> Thanks again for your valuable feedback. I've outlined my proposed plan
> above and would be grateful for any thoughts on it to ensure I'm on the
> right track for v2.
> 
> Best regards,
> 
> Tao
> 
> 
> 
> 
> 

