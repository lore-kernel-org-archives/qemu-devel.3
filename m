Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35830CA0EEB
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 15:57:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up7fD-0002xE-QK; Thu, 21 Aug 2025 11:57:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1up7fA-0002sq-Ib
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 11:57:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1up7f8-0000Ei-Tq
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 11:57:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755791832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ifvj4MABzf1GWyv7GOzNLOvrdAcDcI8LHYQe/seyGSM=;
 b=RyypYeubqjUi6pa7IQYHyz5myUM5pmATpeQoC0F2kXoaerifz1PZcR4zksvBdKNWIE1zzl
 WoTnVF7d9POsJR5uhsohqISaQ8wNuzyZyTAAdFiXXAWYXTkDR6ADpkZ9vy+DdwyHgXrP8w
 yihbqB5lkcDbaZyyu4+jeeTS1dJo4+M=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-5XX8vBvCPiWC3o8nHeGUPA-1; Thu, 21 Aug 2025 11:57:11 -0400
X-MC-Unique: 5XX8vBvCPiWC3o8nHeGUPA-1
X-Mimecast-MFC-AGG-ID: 5XX8vBvCPiWC3o8nHeGUPA_1755791831
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-709e7485b3eso45024256d6.1
 for <qemu-devel@nongnu.org>; Thu, 21 Aug 2025 08:57:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755791831; x=1756396631;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ifvj4MABzf1GWyv7GOzNLOvrdAcDcI8LHYQe/seyGSM=;
 b=UOtPJSY+fcuNHpk8P6jsxjDb6cN7nFZf2uV5U8VC7ZaLji9eZ/Q1kP+sl1EMB0UBC4
 08ZYvx5n5KbEkDj9YLvieSyNjVVQ6KA1nD1Wpw9xtLzgSBk/TCGFkIINfpXNZNl0ZfpJ
 nNATMHsCEUvK9PpvP3c4zvOspS9XES8tYjO1DgFuTnA/4SOh8ZH7Lg8MoPT1YrJAKvoU
 SXLWyU/DF2/PZBhq7/QcABXsVyQaERmCgu5IrB/580kjf5U3b2hJwar+U54DpAWS3uHt
 fsOhRIrxCK8thBy/jDA1FgpImtTjFLkVWLNCCMHPhHiJqPEH0uIiLui6Rxs+GDYhKMEt
 jg7A==
X-Gm-Message-State: AOJu0YyjBSPcmKgCchrBX0od/rVI/70rnU7pDtdwWIHhZZgk6KaweVmU
 X+1pj3gYRLd+HaZ2pYmpc/qxEk68F+GW4aUrGDQcZAKzYPc0CPu/kKbbFphksnFOUwwzTK2YMpL
 KX9HcybwoH3n30N0j60s/8lSiMZjOamGvKd7IOv6+Enq6B2pg62SvlVjA
X-Gm-Gg: ASbGncsUL7aGzTmIB1YGSRp4FIUxK6DHiDN1tCAu1Sf4r8KstAp562cC79O9fAkxXpa
 39M5ddGaDnEzUq8Y7HWC4oDaqvQcjLIXmdngC3ei0ZLuhxtiX23M4LzMnE7QPAubdmn1oK8h9Tj
 2tEJ7MCDicIoXQs/T6rgSVx2XuqfWPlufgnwsT6wzNx816E7LdwDrWy0cy1W/DpBZ/3uh3zqN2s
 BuVUU8aBd0a2snJ466P/au1N2TMUaKUNWTAx+t38Ber1kVIF4IZeT8RJTVTRDUPU8c/kQqU1fDe
 QemIik9bKTiGHcfZWr0MDGU2OkUF9g==
X-Received: by 2002:a05:6214:2248:b0:704:7dfa:3fd with SMTP id
 6a1803df08f44-70d8988d43fmr31649696d6.4.1755791830742; 
 Thu, 21 Aug 2025 08:57:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBbepghKtLYdGRsHfa6Vu6LdvA1UZfQ7rkPI4waKMc6oIO2y0DpPtMsHn9d4P8Cq/zh0nPJA==
X-Received: by 2002:a05:6214:2248:b0:704:7dfa:3fd with SMTP id
 6a1803df08f44-70d8988d43fmr31649116d6.4.1755791830220; 
 Thu, 21 Aug 2025 08:57:10 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-70ba9032801sm105836596d6.16.2025.08.21.08.57.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Aug 2025 08:57:09 -0700 (PDT)
Date: Thu, 21 Aug 2025 17:57:00 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: "Jason J. Herne" <jjherne@linux.ibm.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Xu
 <peterx@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 mtosatti@redhat.com, richard.henderson@linaro.org, riku.voipio@iki.fi,
 thuth@redhat.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 david@redhat.com, shorne@gmail.com, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com,
 zhao1.liu@intel.com, peter.maydell@linaro.org, agraf@csgraf.de,
 mads@ynddal.dk, mrolnik@gmail.com, deller@gmx.de, dirty@apple.com,
 rbolshakov@ddn.com, phil@philjordan.eu, reinoud@netbsd.org,
 sunilmut@microsoft.com, gaosong@loongson.cn, laurent@vivier.eu,
 edgar.iglesias@gmail.com, aurelien@aurel32.net, jiaxun.yang@flygoat.com,
 arikalo@gmail.com, chenhuacai@kernel.org, npiggin@gmail.com,
 rathc@linux.ibm.com, harshpb@linux.ibm.com, yoshinori.sato@nifty.com,
 iii@linux.ibm.com, mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org
Subject: Re: [PATCH v4 6/8] add cpu_test_interrupt()/cpu_set_interrupt()
 helpers and use them tree wide
Message-ID: <20250821175700.00e7ea97@fedora>
In-Reply-To: <2d7317bc-e2cd-4f92-8956-4122f0860a49@linux.ibm.com>
References: <20250814160600.2327672-1-imammedo@redhat.com>
 <20250814160600.2327672-7-imammedo@redhat.com>
 <2d7317bc-e2cd-4f92-8956-4122f0860a49@linux.ibm.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 20 Aug 2025 11:01:13 -0400
"Jason J. Herne" <jjherne@linux.ibm.com> wrote:

> On 8/14/25 12:05 PM, Igor Mammedov wrote:
> > the helpers form load-acquire/store-release pair and use them to replace
> > open-coded checkers/setters consistently across the code, which
> > ensures that appropriate barriers are in place in case checks happen
> > outside of BQL.
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> > v4:
> >     add cpu_set_interrupt() and merge helpers patch with
> >     patches that use them (v3 6-7,9/10).
> >         Peter Xu <peterx@redhat.com>
> > 
> > CC: mst@redhat.com
> > ...
> > 
> > diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> > index 5eaf41a566..3e233ff6de 100644
> > --- a/include/hw/core/cpu.h
> > +++ b/include/hw/core/cpu.h
> > @@ -942,6 +942,31 @@ CPUState *cpu_by_arch_id(int64_t id);
> >   
> >   void cpu_interrupt(CPUState *cpu, int mask);
> >   
> > +/**
> > + * cpu_test_interrupt:
> > + * @cpu: The CPU to check interrupt(s) on.
> > + * @mask: The interrupts to check.
> > + *
> > + * Checks if any of interrupts in @mask are pending on @cpu.
> > + */
> > +static inline bool cpu_test_interrupt(CPUState *cpu, int mask)
> > +{
> > +    return qatomic_load_acquire(&cpu->interrupt_request) & mask;
> > +}
> > +
> > +/**
> > + * cpu_set_interrupt:
> > + * @cpu: The CPU to set pending interrupt(s) on.
> > + * @mask: The interrupts to set.
> > + *
> > + * Checks if any of interrupts in @mask are pending on @cpu.
> > + */  
> 
> Copy paste error, comment description for 'set' appears to be for the 
> 'test' variant. :)

thanks, I'll post fixed up v5 here
> 
> > ...
> >   
> > diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
> > index 8f4c9fd52e..1eed5125d1 100644
> > --- a/hw/intc/s390_flic.c
> > +++ b/hw/intc/s390_flic.c
> > @@ -190,7 +190,7 @@ static void qemu_s390_flic_notify(uint32_t type)
> >       CPU_FOREACH(cs) {
> >           S390CPU *cpu = S390_CPU(cs);
> >   
> > -        cs->interrupt_request |= CPU_INTERRUPT_HARD;
> > +        cpu_set_interrupt(cs, CPU_INTERRUPT_HARD);
> >   
> >           /* ignore CPUs that are not sleeping */
> >           if (s390_cpu_get_state(cpu) != S390_CPU_STATE_OPERATING &&  
> 
> Looks good wrt s390-flic.
> 
> Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>
> 


