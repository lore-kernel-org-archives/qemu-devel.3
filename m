Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08BA1CD98F2
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 20:01:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbkp4-0008OA-NN; Mon, 22 Jun 2026 16:00:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wbkok-0008MW-OZ
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 16:00:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wbkoj-0000Be-0M
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 16:00:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782158424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9isACaP9VFg2o8NuepGElq1JkBXhzmmqPpstXjs4boo=;
 b=QyBJznPbuH+1x/felHvi1iNJ+Yix2rc3nSKXXNQTrWFg3kcPOLyoPHSMqcjqZNW4GkSnrU
 bnr7vn+8b9rxTGQbY0GYrWABfK3jz15tk21FYDJxsX0h67rN1eKQueweHiiWxXsBWZRRLG
 gtnflUlNNCIa8Nub86nebkZe7wiVWYs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-FQjpVooaMwW4d-JENLhZDQ-1; Mon, 22 Jun 2026 16:00:22 -0400
X-MC-Unique: FQjpVooaMwW4d-JENLhZDQ-1
X-Mimecast-MFC-AGG-ID: FQjpVooaMwW4d-JENLhZDQ_1782158421
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-461e0dad8easo2906049f8f.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 13:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782158421; x=1782763221; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9isACaP9VFg2o8NuepGElq1JkBXhzmmqPpstXjs4boo=;
 b=Laf9azYeOssOe90Cy9v9298LnHvhiRc3eE2BQVpQUBRrRM3hgUpYWRuYvA+sZJySro
 uZabTFam0I9dzGZSWxgczNxZ2j333pMN/gpSPLClZVDswdxBKXhefkOA9ONBTkqKP9uM
 aUuzTJWcuWzjrG5pehGqGBDDIfLqBK09nJ454E5wKUOUiK8vb85UFWDGTjt2yrvXV8pj
 ngW+B0fFrhR4X+yKXq/Ct9pGiE6SfMJHwS/mVtstssWMC2+sJ/7GgFPIBkbS74XV7xHN
 xZGdmXxckOuxKvEke9aS9ufhz64BQeIkuEH78AU1etpWFBnsxnVq1LCKJdxGtZkKj1nr
 jyhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782158421; x=1782763221;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9isACaP9VFg2o8NuepGElq1JkBXhzmmqPpstXjs4boo=;
 b=jBKRHCQsYRmA/T4bFmKLEe+/qLFUu20RPQPtx3ZFE64OQCISJRv4nFK06aJ7AEWEbI
 dXmph1nLPnYxXsFihA5tKaxGubLI6BD0h6X/m+S+qvMwp0P5KSZ8xpYoAd7WenZNXErt
 Ud3LO3g96YCJEaOc/lysbCK8CvuDy34aOnpm/c1rYbqYh2D03nuCUujejF/emcL74dSr
 qQqIt3ZQFBgRynW5cuOlv8BC9ZMUtopPSBJScCCAJUpAxWoyRDtubd7aWAbr5aKejOHF
 Hh2z2MPUaBYknxTl6vXemmYnyK8XqdSY73sZcfl4anor0fY+j77jELqX4AXde7mBFd4I
 d8Tg==
X-Gm-Message-State: AOJu0YzyU9MwYVDI3u6sbP6TqMz6HBnQTjkD12jMr9sEBdSeR6m8tmhT
 awnqcNYkD5OUFEV0RbfIFr94ClY5yaNFVbH6P5erGmapUbgzSNut/9FBGDQVMSjOt8SjYnbNzy4
 qZq/qo5AT2GepgCkCjuiHMizad+ASply3KbdcCCqnDJjPCE/DnrqssQmG
X-Gm-Gg: AfdE7cln6zLpAX0qFmYNvAnGHHYKf+x2VeHlzSZTPzSle133niAyb5yJBBGFYYo0PcN
 SgncNacY1Uz8NfPeV2UM9LmrGNeuWjIoNsraSNCMDy3EUEDa4+meQjXwBK4r56S27fgo55K9Gnm
 ItTdrHFCSDKmSR7tfSBpRdPyAnPEhQVCI8yWEdPwwtvH0TFgn+/ReStXKRw/JjZ5aeh23FEpvQP
 6E7jab9gVEyJSv4n6ulQwBG1koyb2V/03zTVFgEiAp3Xo0a1Yk/5ml3mx0AOlkI5MVz5+52rDh7
 aTEQ2ZM+FyAYq23P2Pw2REKllqnmHstebzYVWiYmHWKVbbVEHHNO2m4jOtvXKjx3VrTJFfH1tof
 1KnL8vJKOS23DoIc9ukh2wITxLYDIZ+7r
X-Received: by 2002:a5d:6f1d:0:b0:45e:edcc:f6dc with SMTP id
 ffacd0b85a97d-4656bcc97d6mr22191240f8f.6.1782158421217; 
 Mon, 22 Jun 2026 13:00:21 -0700 (PDT)
X-Received: by 2002:a5d:6f1d:0:b0:45e:edcc:f6dc with SMTP id
 ffacd0b85a97d-4656bcc97d6mr22191173f8f.6.1782158420593; 
 Mon, 22 Jun 2026 13:00:20 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-466667881bfsm30516259f8f.22.2026.06.22.13.00.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 13:00:20 -0700 (PDT)
Date: Mon, 22 Jun 2026 16:00:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Sairaj Kodilkar <sarunkod@amd.com>,
 Vasant Hegde <vasant.hegde@amd.com>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PULL 081/106] amd_iommu: Generate XT interrupts when xt support
 is enabled
Message-ID: <20260622155957-mutt-send-email-mst@kernel.org>
References: <cover.1781463125.git.mst@redhat.com>
 <cf0210df65aa4f582e444b910c950e2b4a80b194.1781463125.git.mst@redhat.com>
 <CAFEAcA8sZSNr5N8ri6SCok2aWLED9+OGvy0qA7A83SuwXg9xKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8sZSNr5N8ri6SCok2aWLED9+OGvy0qA7A83SuwXg9xKA@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Jun 22, 2026 at 04:19:50PM +0100, Peter Maydell wrote:
> On Sun, 14 Jun 2026 at 20:09, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > From: Sairaj Kodilkar <sarunkod@amd.com>
> >
> > When MMIO 0x18[IntCapXTEn]=1, interrupts originating from the IOMMU itself are
> > sent based on the programming in XT IOMMU Interrupt Control Registers in MMIO
> > 0x170-0x180 instead of the programming in the IOMMU's MSI capability registers.
> > The guest programs these registers with appropriate vector and destination
> > ID instead of writing to PCI MSI capability.
> >
> > Current AMD vIOMMU is capable of generating interrupts only through PCI
> > MSI capability and does not care about xt mode. Because of this AMD
> > vIOMMU cannot generate event log interrupts when the guest has enabled
> > xt mode.
> >
> > Introduce a new flag "intcapxten" which is set when guest writes control
> > register [IntCapXTEn] (bit 51) and use vector and destination field in
> > the XT MMIO register (0x170) to support XT mode.
> 
> Hi; Coverity points out a use of an uninitialized struct field here
> (CID 1660056):
> 
> > +static void amdvi_build_xt_msi_msg(AMDVIState *s, MSIMessage *msg)
> > +{
> > +    union mmio_xt_intr xt_reg;
> > +    struct X86IOMMUIrq irq;
> 
> Here we declare irq, without a struct initializer...
> 
> > +
> > +    xt_reg.val = amdvi_readq(s, AMDVI_MMIO_XT_GEN_INTR);
> > +
> > +    irq.vector = xt_reg.vector;
> > +    irq.delivery_mode = xt_reg.delivery_mode;
> > +    irq.dest_mode = xt_reg.destination_mode;
> > +    irq.dest = (xt_reg.destination_hi << 24) | xt_reg.destination_lo;
> > +    irq.trigger_mode = 0;
> > +    irq.redir_hint = 0;
> 
> ...and here we fill in some but not all of its fields...
> 
> > +
> > +    x86_iommu_irq_to_msi_message(&irq, msg);
> 
> ...and here we call a function which (among other things) does this:
>    msg.__not_used = irq->msi_addr_last_bits;
> 
> which will read the uninitialized msi_addr_last_bits field.
> 
> Bonus extra bug report:
> 
> +union mmio_xt_intr {
> +    uint64_t val;
> +    struct {
> +        uint64_t rsvd_1:2,
> +                 destination_mode:1,
> +                 rsvd_2:5,
> +                 destination_lo:24,
> +                 vector:8,
> +                 delivery_mode:1,
> +                 rsvd_3:15,
> +                 destination_hi:8;
> +    };
> +};
> 
> Please don't use bitfields like this -- this is not portable to big
> endian hosts. Use the extract64() function instead, or the FIELD macros.
> 
> I suggest something like (untested):
> 
> (at top level in a source file or header; the numbers are
> start-bit and length, check these as I may have made typos)
> 
> FIELD(XT_GEN_INTR, DEST_MODE, 2, 1)
> FIELD(XT_GEN_INTR, DEST_LO, 24, 8)
> FIELD(XT_GEN_INTR, VECTOR, 32, 8)
> FIELD(XT_GEN_INTR, DELIVERY_MODE, 33, 1)
> FIELD(XT_GEN_INTR, DEST_HI, 49, 8)
> 
> and then in the function you can do:
> 
>    uint64_t xtreg = amdvi_readq(s, AMDVI_MMIO_XT_GEN_INTR);
>    X86IOMMUIrq irq = {
>        .vector = FIELD_EX64(xtreg, XT_GEN_INTR, VECTOR),
>        .delivery_mode = FIELD_EX64(xtreg, XT_GEN_INTR, DELIVERY_MODE),
>        .dest_mode = FIELD_EX64(xtreg, XT_GEN_INTR, DEST_MODE),
>        .dest = (FIELD_X64(xtreg, XT_GEN_INTR, DEST_HI) << 24) |
> FIELD_EX64(xtreg, XT_GEN_INTR, DEST_LO),
>    };
> 
> which gives you a struct initializer and you can rely on the
> whole struct being initialized.
> 
> > +}
> 
> thanks
> -- PMM

Indeed. Alejandro should we revert or fix up?

-- 
MST


