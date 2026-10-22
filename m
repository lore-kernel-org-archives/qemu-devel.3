Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BD6606A320
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 10:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=fmEDWx5M
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJq1k-0000w0-34; Thu, 22 Oct 2026 06:28:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aastharawat@linux.microsoft.com>)
 id 1xJq1i-0000vk-SY; Thu, 22 Oct 2026 06:28:02 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aastharawat@linux.microsoft.com>)
 id 1xJq1h-0006pu-6E; Thu, 22 Oct 2026 06:28:02 -0400
Received: by linux.microsoft.com (Postfix, from userid 1236)
 id D72FE20B7166; Thu, 22 Oct 2026 03:27:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D72FE20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1792664869;
 bh=cJMA9EIwsd9H9FiYrhrKU/BF6qCRnB5jl+a4O3774Is=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fmEDWx5MAfwMnb58bUKbIQ8DGQuISZiHrvua5lV15nT3toaeJrnkmTAd3qOGK3Otv
 22IeR6uW4Y1+te7vz0tgE0Vbjr0PUaN2mnqc2M5MBJB8/H5qijBB2ZMkQ5m87n9C7j
 BxXHL7+yLCWU00JTcynb3Olk6pJyxLqiX/5EEWFA=
Date: Thu, 22 Oct 2026 03:27:49 -0700
From: Aastha Rawat <aastharawat@linux.microsoft.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Wei Liu <wei.liu@kernel.org>,
 Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <dblanzeanu@linux.microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anirudh Rayabharam <anirudh@anirudhrb.com>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
Subject: Re: [PATCH v6 10/14] target/arm: extract MMIO emulation logic for
 HVF & WHPX
Message-ID: <atnlJf74tfOGaN9x@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20261001-mshv_accel_arm64_supp-v6-0-aefe5e76a0e3@linux.microsoft.com>
 <20261001-mshv_accel_arm64_supp-v6-10-aefe5e76a0e3@linux.microsoft.com>
 <CAFEAcA8g=U+sP8i38Vvv_AA1fXnnXSVjVkfHfHhu77xKhEGLmg@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8g=U+sP8i38Vvv_AA1fXnnXSVjVkfHfHhu77xKhEGLmg@mail.gmail.com>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=aastharawat@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 13, 2026 at 05:40:18PM +0100, Peter Maydell wrote:
> On Thu, 1 Oct 2026 at 11:52, Aastha Rawat
> <aastharawat@linux.microsoft.com> wrote:
> >
> > - Move common MMIO emulation code from HVF and WHPX backend to
> >   arm_emulate_mmio() in helper.c.
> > - Update HVF and WHPX to use the new helper and shared types.
> >
> > Signed-off-by: Aastha Rawat <aastharawat@linux.microsoft.com>
> > ---
> 
> 
> > +/*
> > + * Emulate a data abort syndrome for MMIO/guest memory access
> > + */
> > +int arm_emulate_mmio(CPUState *cpu, EsrEl2 syndrome, uint64_t gpa,
> > +                     const struct arm_emul_ops *ops)
> 
> Please don't put more stuff into helper.c. It is big enough
> as it is.

I plan to introduce target/arm/hyp-mmio.c for this extraction in that case.
  
> > diff --git a/target/arm/helper.h b/target/arm/helper.h
> > index b1c26c180ea..503404112d4 100644
> > --- a/target/arm/helper.h
> > +++ b/target/arm/helper.h
> > @@ -3,8 +3,24 @@
> >  #ifndef HELPER__H
> >  #define HELPER__H
> >
> > +#include <stdint.h>
> > +#include <stdbool.h>
> 
> osdep.h includes stdint and stdbool for you, you don't need
> to include them manually anywhere.

Got it. 

> >  #include "exec/helper-proto-common.h"
> >  #include "exec/helper-gen-common.h"
> > +#include "target/arm/syndrome.h"
> > +
> > +/*
> > + * Callback ops for per-register access during MMIO emulation.
> > + * Each hypervisor backend provides its own implementation to avoid
> > + * syncing the full CPU state for a single-register MMIO access.
> > + */
> > +struct arm_emul_ops {
> > +    uint64_t (*get_reg)(CPUState *cpu, int reg);
> > +    void (*set_reg)(CPUState *cpu, int reg, uint64_t val);
> > +};
> > +
> > +int arm_emulate_mmio(CPUState *cpu, EsrEl2 syndrome, uint64_t gpa,
> > +                     const struct arm_emul_ops *ops);
> 
> helper.h is structly for the autogenerated prototypes for TCG
> helper functions (hence its name). Put your prototype somewhere else.
 
Will move to target/arm/hyp-mmio.h, paired with hyp-mmio.c.
 
> > diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
> > index 2a6fa903f27..8b4cc7f7b21 100644
> > --- a/target/arm/syndrome.h
> > +++ b/target/arm/syndrome.h
> > @@ -106,6 +106,53 @@ typedef enum {
> >      GCS_IT_GCSPOPX = 9,
> >  } GCSInstructionType;
> >
> > +typedef union {
> > +    uint64_t raw;
> > +    struct {
> > +        uint32_t iss:25;
> > +        uint32_t il:1;
> > +        uint32_t ec:6;
> > +        uint32_t iss2:5;
> > +        uint32_t _rsvd:27;
> > +    } QEMU_PACKED;
> > +} EsrEl2;
> 
> Do not use bitfields. They are not portable (notably, they have
> endianness issues). syndrome. already sets up FIELD() definitions
> that you can use with FIELD_EX32 to extract subfields of the syndrome.

Sure, will use the existing SYNDROME and DABORT_ISS definitions. 

> > +typedef enum {
> > +    data_abort_lower = 36,
> > +    data_abort = 37,
> > +} ExceptionClass;
> 
> Don't define new versions of what we already have either.
> These are EC_DATAABORT and EC_DATAABORT_SAME_EL.
> 
> > +
> > +#define ARM_EL_EC_LENGTH 6
> > +#define ARM_EL_EC_SHIFT 26
> > +#define ARM_EL_IL_SHIFT 25
> > +#define ARM_EL_ISV_SHIFT 24
> > +#define ARM_EL_IL (1 << ARM_EL_IL_SHIFT)
> > +#define ARM_EL_ISV (1 << ARM_EL_ISV_SHIFT)
> 
> This also is reimplementing what the header already gives you.

Ack.

Thanks,
Aastha

