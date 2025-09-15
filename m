Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78FEACAC597
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 09:16:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy5I4-0007E7-FC; Mon, 15 Sep 2025 05:14:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1uy5I1-0007Dc-1G
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 05:14:26 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1uy5Hw-00061J-TI
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 05:14:24 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-45f28aba94cso74805e9.0
 for <qemu-devel@nongnu.org>; Mon, 15 Sep 2025 02:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1757927653; x=1758532453; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=phvkTGlJ19Pg5EKrxfwNjliEXWpnCXO5oXj3aYMdwo8=;
 b=wSLtvv8/2pvqZ8zjTbWcYmxTe0q7pSnHgwIpGHQN9MxegzNL4y9wqnM+t9u869wjGR
 jQ8oObMo/TAvysiz4CzCOXZCVaRlGb2zUL4AkXUEG+ECxDaF9zXlxhB7Hx85VTukmIOu
 7p+aij0isgwTFJrgjz1o1daRtLalcY71ibB3h6GVYpiuxCGd5MKfcHd6cw5Uy3GRunVM
 p1JQe7wayA4/tJSVUCvc9kWuWfSKUQvjTwk1BudZ3Mu2Dly6XT1IKuif64x0eXMc4/wi
 zaksoklchqCjDuI3aO+/e+g5OpkE/mNbzgdXCbF02KUMY5QrgACEjAt8F6uTNd0g8vJe
 hZqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757927653; x=1758532453;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=phvkTGlJ19Pg5EKrxfwNjliEXWpnCXO5oXj3aYMdwo8=;
 b=JiJjNvXyJtUOzpz/ZG3gJ37jatnHb6NPkP49kMbXeDKLYdollD465poCLAyqPJ0Xpu
 i1dAUHIUfHniqqetjAdYWduRyihDWORLXVaeAjpXGVwH5LTUION5k0gJ/Yc6xAMZIaYN
 WGaOuJpBPmH7Q3j/569kRLFpyoBXDPPWWXljSMPN0e2kXHKD5Nj4lDo2CzVCOfL76AZG
 UQB0qF3JSplZGYpu1Ai3C9MpIDrsO2MI/n7e9I0SGrqDW17mVAjDIS6AmMeOePt8S0yp
 UsBsdwaq0BwSJ43AFvHQOdhBiY9jsXyLBnB/91jyQfQaauH6+0SHCoRAngDtnDsuxKVZ
 UjMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWERx9ZQCyFTBH59ihRbT5XfKuBaJnMWddnzlCsMyrZRSpw5XSh5GgZhmEE71BPmZF9zIOXjy+9P4tG@nongnu.org
X-Gm-Message-State: AOJu0YwUrxAOfoRr7zq8A9v+zhib44ZRsjq79OjdTXZT0uNDgEvFbFvl
 mM0t+YsF34MJwsI8nqYuNTc04eDixYrwuyqllp8AMO3IntCAs1896JI1Ay4w5A6ZFg==
X-Gm-Gg: ASbGncs9k/ptRIbpNeE7IKrvedfvp/3jsCvXsH57GOdeQY3dspJrsxnmcFf73o7uJGm
 h/SHf97XufpJIxsboRcsHng7dOV8XGhou2AaJDru8cfbKWyUTTUclCQVVvub+YHIat3yQ9gdss6
 W5rDqsridiwAoWEAloRW1vM3lT7Iwua95r/YxMBME3Vl+B+rd/7zcmvawKuF954QZC7dM0nihs1
 y6flP9jqaeKTMoiPKSctilBRb3KnFLcZlCHeMV5rW182E5LjQCBGs3qcAWYRlyV6gndcCjbny5r
 Y0e9mns21BCJNe+iB5Aa9afRyRZ+t/RVRv9ieG9fVoWkx2LkLqw7CoPw2u0J4DEHsADwjecy+0y
 SfzesqKh5zlJ0FLBcW66IP71CVZ6/n5/RLwecfbrsbtgeEfPYqiE38JlNl6qPVc/7niZyzd1N3A
 1afUf3
X-Google-Smtp-Source: AGHT+IGPsiXisLlbtqMfSI5sEwS3oLEv4PMIGXS/nEgWPO1eXkh7PR2Oxr9Q5TDh/MCpDAYXaiZOlQ==
X-Received: by 2002:a05:600c:64c7:b0:45d:f6a6:a13e with SMTP id
 5b1f17b1804b1-45f2d98f76dmr1147585e9.1.1757927652895; 
 Mon, 15 Sep 2025 02:14:12 -0700 (PDT)
Received: from google.com (157.24.148.146.bc.googleusercontent.com.
 [146.148.24.157]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e7c778f764sm11513990f8f.57.2025.09.15.02.14.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Sep 2025 02:14:12 -0700 (PDT)
Date: Mon, 15 Sep 2025 09:14:08 +0000
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
Message-ID: <aMfY4LJVEGw3egdP@google.com>
References: <20250806151134.365755-1-tangtao1634@phytium.com.cn>
 <20250806151134.365755-3-tangtao1634@phytium.com.cn>
 <aKOaIcPp26kbS3Nn@google.com>
 <53607fe8-0555-4408-bfa6-e4b95d44e230@phytium.com.cn>
 <aKma98hlAWG9M4h_@google.com>
 <8987bd11-afae-4157-979d-ef10be69a7a5@phytium.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8987bd11-afae-4157-979d-ef10be69a7a5@phytium.com.cn>
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=smostafa@google.com; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

Hi Tao,

On Thu, Sep 11, 2025 at 11:27:50PM +0800, Tao Tang wrote:
> 
> Hi Mostafa,
> 
> First, my apologies for the long delay in getting back to you. I was away on
> paternity leave for the last few weeks.

No worries!

> 
> Thank you for the detailed follow-up, your advice is very helpful for
> simplifying the series.
> 
> 
> On 2025/8/23 18:41, Mostafa Saleh wrote:
> > On Wed, Aug 20, 2025 at 11:21:02PM +0800, Tao Tang wrote:
> > > On 2025/8/19 05:24, Mostafa Saleh wrote:
> > > > On Wed, Aug 06, 2025 at 11:11:25PM +0800, Tao Tang wrote:
> > > > > This patch builds upon the previous introduction of secure register
> > > > > definitions by providing the functional implementation for their access.
> > > > > 
> > > > > The availability of the secure programming interface is now correctly
> > > > > gated by the S_IDR1.SECURE_IMPL bit. When this bit indicates that
> > > > > secure functionality is enabled, the I/O handlers (smmuv3_read and
> > > > > smmuv3_write) will correctly dispatch accesses to the secure
> > > > > register space.
> > > > > 
> > > > > Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> > > > > ---
> > > > >    hw/arm/smmuv3-internal.h |   5 +
> > > > >    hw/arm/smmuv3.c          | 451 +++++++++++++++++++++++++++++++++++++++
> > > > >    2 files changed, 456 insertions(+)
> > > > > 
> > > > > diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
> > > > > index 483aaa915e..1a8b1cb204 100644
> > > > > --- a/hw/arm/smmuv3-internal.h
> > > > > +++ b/hw/arm/smmuv3-internal.h
> > > > > @@ -122,6 +122,11 @@ REG32(CR0,                 0x20)
> > > > >    #define SMMU_CR0_RESERVED 0xFFFFFC20
> > > > > +/*
> > > > > + * BIT1 and BIT4 are RES0 in SMMU_S_CRO
> > > > > + */
> > > > > +#define SMMU_S_CR0_RESERVED 0xFFFFFC12
> > > > > +
> > > > >    REG32(CR0ACK,              0x24)
> > > > >    REG32(CR1,                 0x28)
> > > > >    REG32(CR2,                 0x2c)
> > > > > diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> > > > > index ab67972353..619180d204 100644
> > > > > --- a/hw/arm/smmuv3.c
> > > > > +++ b/hw/arm/smmuv3.c
> > > > > @@ -317,6 +317,18 @@ static void smmuv3_init_regs(SMMUv3State *s)
> > > > >        s->gerrorn = 0;
> > > > >        s->statusr = 0;
> > > > >        s->gbpa = SMMU_GBPA_RESET_VAL;
> > > > > +
> > > > > +    /* Initialize secure state */
> > > > > +    memset(s->secure_idr, 0, sizeof(s->secure_idr));
> > > > > +    /* Secure EL2 and Secure stage 2 support */
> > > > > +    s->secure_idr[1] = FIELD_DP32(s->secure_idr[1], S_IDR1, SEL2, 1);
> > > > AFAIU, this is wrong, SEL2 means that the SMMU has dual stage-2,
> > > > one for secure (S_S2TTB) and one for non-secure IPAs(S2TTB).
> > > > Which is not implemented in this series.
> > > 
> > > Hi Mostafa,
> > > 
> > > Thank you for the very detailed and helpful review. Your feedback is spot
> > > on, and I'd like to address your points and ask for a quick confirmation on
> > > them.
> > > 
> > > Regarding the SEL2 bit, you are absolutely right, my understanding was
> > > incorrect. I've spent the last few days reviewing the manual to better
> > > understand the selection between Secure and Non-secure Stage 2 translations.
> > > I would be very grateful if you could confirm if my new understanding is
> > > correct:
> > > 
> > > - In Stage 2-only mode (Stage 1 bypassed), the choice between a Secure or
> > > Non-secure IPA translation is determined solely by STE.NSCFG.
> > > 
> > Yes, but that's only with SMMU_IDR1.ATTR_PERMS_OVR which Qemu doesn't
> > advertise, so in our case it's always secure.
> > 
> > > - In Stage 1-enabled mode, STE.NSCFG is ignored. The choice is determined by
> > > the translation process, starting from CD.NSCFGx, with the output NS
> > > attribute being the result of intermediate NSTable flags and the final
> > > descriptor.NS bit (TTD.NSTable, TTD.NS).
> > > 
> > You have to differentiate between the security state of the translation and
> > the security state of the translation table access.
> > 
> > For stage-1, the security state is determined by the NS bit in the last
> > level PTE, which in case of nested translation it will choose between S2TTB
> > or S_S2TTB.
> > 
> > Also, note that the stage-2 also have an NS which define the final attribute
> > of the transaction.
> > 
> > You have to also be careful around things such as NSCFG{0,1} as it might
> > change which stage-2 is used for the stage-1 TTB walk.
> > 
> > I see, in your patches, all the page-table access is done using the secure
> > state of the SID which is not correct.
> > 
> > 
> > > Based on this, I plan to have an internal flag, perhaps named
> > > target_ipa_is_ns in SMMUTransCfg.SMMUS2Cfg struct, to track the outcome of
> > > this process. This flag will then determine whether S_S2TTB or S2TTB is used
> > > for the Stage 2 translation.
> > > 
> > I am worried that it's not that simple for a single secure nested translation
> > you can have multiple stage-2 walks where some might be secure and others not,
> > so I imagine this some how will be determined from each stage-1 walk and
> > some how returned (maybe in the TLB struct) which is then the stage-2
> > walk looks into.
> > 
> > I am not sure how complicated it is to manage 2 stage-2 with the current code
> > base, so my advice would be to split the problem; for now you can drop SEL2
> > from this series and rely on NS stage-2.
> 
> 
> I would like to confirm my understanding of the implementation. Does this
> mean that for the current RFC, we should set S_IDR1.SEL2=0, which implies
> that all Stage-2 translations will begin with a Non-secure IPA? And the
> final output PA space will then almost always be Non-secure PA, with the
> sole exception being when S2SW, S2SA, S2NSW, and S2NSA are ALL ZERO.
> 
> 
> However, since these fields are RES0 when S_IDR1.SEL2=0, it seems we can
> conclude that for this version, the output will definitively be a Non-secure
> PA. I believe this is what you meant by your advice to "rely on NS stage-2".
> I would be grateful if you could let me know whether this interpretation is
> on the right track.

Yes, that’s what I meant, I think that simplifies a lot, in this series we
can focus on the infrastructure for the secure SMMU (registers, TLBs..),
and then extra features such as secure stage-2 can be added later.

> 
> 
> ------------------------------<snip>------------------------------
> 
> > > The new code performs a single, necessary security state check at the entry
> > > point of the MMIO handlers. The rest of the logic relies on the banking
> > > mechanism, which makes the implementation generic for Non-secure, Secure,
> > > and future states like Realm/Root. The new structure looks like this:
> > > 
> > > /* Structure for one register bank */
> > > typedef struct SMMUv3Bank {
> > >      uint32_t idr[6];     /* IDR0-IDR5, note: IDR5 only used for NS bank */
> > >      uint32_t cr[3];      /* CR0-CR2 */
> > >      uint32_t cr0ack;
> > >      uint32_t init;       /* S_INIT register (secure only), reserved for NS
> > > */
> > >      uint32_t gbpa;
> > > 
> > > ......
> > > 
> > >      SMMUQueue eventq, cmdq;
> > > } SMMUv3Bank;
> > > 
> > > struct SMMUv3State {
> > >      SMMUState     smmu_state;
> > > 
> > >      /* Shared (non-banked) registers and state */
> > >      uint32_t features;
> > >      uint8_t sid_size;
> > >      uint8_t sid_split;
> > > 
> > > ......
> > > 
> > >      /* Banked registers for all access */
> > >      SMMUv3Bank bank[SMMU_SEC_IDX_NUM];
> > > ......
> > > };
> > > 
> > Yes, IMO,that’s the right approach. Although that might make the
> > migration code more complicated as we changed the state struct.
> > 
> > Thanks,
> > Mostafa
> I have almost completed the refactoring based on this new structure, and I
> will send out the v2 patch series in the next few days for review.

Sounds good!

Thanks,
Mostafa

> 
> Thanks again for your invaluable guidance.
> 
> Best regards,
> 
> Tao
> 

