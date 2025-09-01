Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D43E3CA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 12:07:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut3I3-00036W-PG; Mon, 01 Sep 2025 08:05:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1ut3I1-00035Z-NF
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 08:05:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1ut3Hq-0005L2-97
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 08:05:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756728321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C92Jb1vPx6AsO3XUCz+MmXZ+Q5EFx3phYwlyl4ZRlic=;
 b=bOngXK4mXzyH2sITXVo+6o/tRDLzI6n3RSsU4VTm8zvMEBFt3NQ7qewwbxB/eFLi1bmpG/
 dPfA/lKzxBFtE+tWsBjHCLEZ5+6nVaMqxUYzD/w7X3+LcJsXAAq5RVyp/kuC427UfCchn0
 sZVTDaxEPBM+dcRpZowKKoLrOQ5yJd4=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-aaRN-UoYMAyVQuKRlL42Mw-1; Mon, 01 Sep 2025 08:05:20 -0400
X-MC-Unique: aaRN-UoYMAyVQuKRlL42Mw-1
X-Mimecast-MFC-AGG-ID: aaRN-UoYMAyVQuKRlL42Mw_1756728320
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7e870646b11so938898485a.2
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 05:05:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756728319; x=1757333119;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C92Jb1vPx6AsO3XUCz+MmXZ+Q5EFx3phYwlyl4ZRlic=;
 b=m1lCmpY7+gqrWnRRByPXErPZHrAZxplvyM152+tgTPqBsHsNeUkL+wtJfIKtlyAhJ6
 b2UEGLauztjSMyGiNguc+MjBL7IxIIxYgD5/GRHiPkvwZ6vJxjb2lS3yTer7DlCaYlBX
 j0M6vvKWkJFp9a8pmtYIHcOUcseu6A4t2EZkaK6s8QqCDZ5frZ4hoaGZzCHeL/KvG+Eg
 zja7W2XYVV1jinH8XKyzjPR7xJUbX3NDV3MU6CLmpFUuKZyJIu0w9UiHGZaTNpWMo4pE
 nMjL1H0YaFb3ra22ZRPTikc+8ZbbKMiLLpQaXaTRnV1HYPVR3CXLKszfDbzrIAjWin24
 UrNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmd5Cv5Uy/oatBrVb9nio+BIjNfqQzpkLgzVJK4ywlS8baGuDfBnBw/RUMKeCpE9zsUdj5bhuC/YSe@nongnu.org
X-Gm-Message-State: AOJu0Yzj1ZLzF+3P9KQjbxHklIRiFSx6mGzg1eekuMpgHy9zONnJDATd
 UFWUfEu/Enopzs1V+68E8EM/5iqSEW19SMpQBT2fyO16yRaVtKEvQyIioQhvrPaVr5AE9ueSXOq
 7+xbqXpxNHkRqbdMZT3NcykPoFi2BeEETiiCL6bNEp/p7u0XOt7mCfNSjfeCyyP+m
X-Gm-Gg: ASbGncsN0vcE0UNFdFErgVX0HU5+YWOfXvZq38KeemNqMFaG9m/eHaRXDSLkUj8dEoh
 QXi/elDcG7D6YC++zz35c4rnvze4rZJ0TcRA9GC3jsk0uyvTPuI58a4pMT9tUksy03YIbNL+YQr
 9Pd7RixXO+jHCtEt7mcKoF0STGrkU6SLp97X+t+UdWLcGQ7r6+P0dhZ05YxgOBT5rcYIoQd3ltw
 ZQaEKg2vG++c5AQZbKMQ3AKkZCxEtQQ286toNYtNxZw8H7ZUNuok3gI3PaF4dYtEebb/8GpFlTU
 zc12cys0nz7Cr+yrjBivkepG2CmwxQ==
X-Received: by 2002:a05:620a:6cc3:b0:7e8:1f79:67a2 with SMTP id
 af79cd13be357-7ff284b2c5fmr783423885a.34.1756728318840; 
 Mon, 01 Sep 2025 05:05:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtBrtcXrGIJbqCN4Edb1D5QpCc4HBMbgnLBa9zENiXovXI79he47XgyPCvhKxRlfUIwsTbUw==
X-Received: by 2002:a05:620a:6cc3:b0:7e8:1f79:67a2 with SMTP id
 af79cd13be357-7ff284b2c5fmr783417285a.34.1756728318190; 
 Mon, 01 Sep 2025 05:05:18 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7fc16536012sm651323685a.66.2025.09.01.05.05.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 05:05:17 -0700 (PDT)
Date: Mon, 1 Sep 2025 14:05:10 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, qemu-devel@nongnu.org,
 peterx@redhat.com, mst@redhat.com, mtosatti@redhat.com,
 richard.henderson@linaro.org, riku.voipio@iki.fi, thuth@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, david@redhat.com,
 jjherne@linux.ibm.com, shorne@gmail.com, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com,
 peter.maydell@linaro.org, agraf@csgraf.de, mads@ynddal.dk,
 mrolnik@gmail.com, deller@gmx.de, dirty@apple.com, rbolshakov@ddn.com,
 phil@philjordan.eu, reinoud@netbsd.org, sunilmut@microsoft.com,
 gaosong@loongson.cn, laurent@vivier.eu, edgar.iglesias@gmail.com,
 aurelien@aurel32.net, jiaxun.yang@flygoat.com, arikalo@gmail.com,
 chenhuacai@kernel.org, npiggin@gmail.com, rathc@linux.ibm.com,
 harshpb@linux.ibm.com, yoshinori.sato@nifty.com, iii@linux.ibm.com,
 mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org
Subject: Re: [PATCH v5 6/8] add cpu_test_interrupt()/cpu_set_interrupt()
 helpers and use them tree wide
Message-ID: <20250901140510.2925ac85@fedora>
In-Reply-To: <CABgObfb6Hs8EOeLQeG_S=Y8j8dj6A9fAMn0DzSSVKZYBG_rP-g@mail.gmail.com>
References: <20250814160600.2327672-7-imammedo@redhat.com>
 <20250821155603.2422553-1-imammedo@redhat.com>
 <aKyBFlCtnxnP9kt/@intel.com> <20250825171912.1bc7b841@fedora>
 <aK1mHGan+n9NSAOk@intel.com> <20250826104731.1440e3ed@fedora>
 <33661ea1-b0aa-45b3-8923-0b47a40dcea8@redhat.com>
 <CABgObfb6Hs8EOeLQeG_S=Y8j8dj6A9fAMn0DzSSVKZYBG_rP-g@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, 29 Aug 2025 14:33:57 +0200
Paolo Bonzini <pbonzini@redhat.com> wrote:

> On Fri, Aug 29, 2025 at 10:18=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.c=
om> wrote:
> >
> > On 8/26/25 10:47, Igor Mammedov wrote: =20
> > > While overhead might be issue, it's better to have correcteness 1st.
> > > (that's why blanket tree wide change to make sure we don't miss place=
s that
> > > set/test interrupts). =20
> >
> > Looking more at it, I found at least one place that sets interrupts
> > without bql:
> >
> >      if (ctl_has_irq(env)) {
> >          cpu_set_interrupt(cs, CPU_INTERRUPT_VIRQ);
> >      }
> >
> > I'm going to squash this in: =20
>=20
> Rethinking about it - this can be a separate patch that also affects
> cpu_reset_interrupt(), as well as all cases where
> cpu_reset_interrupt() is open coded.

I can take care of replacing open coded cpu_reset_interrupt() cases
(I've already looked through them, while answering reviewers questions)

>=20
> Paolo
>=20
> > diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> > index 1dee9d4c76e..5c3397fe108 100644
> > --- a/include/hw/core/cpu.h
> > +++ b/include/hw/core/cpu.h
> > @@ -959,12 +959,13 @@ static inline bool cpu_test_interrupt(CPUState *c=
pu, int mask)
> >    * @cpu: The CPU to set pending interrupt(s) on.
> >    * @mask: The interrupts to set.
> >    *
> > - * Sets interrupts in @mask as pending on @cpu.
> > + * Sets interrupts in @mask as pending on @cpu.  Unlike @cpu_interrupt,
> > + * this does not kick the vCPU.
> >    */
> >   static inline void cpu_set_interrupt(CPUState *cpu, int mask)
> >   {
> > -    qatomic_store_release(&cpu->interrupt_request,
> > -        cpu->interrupt_request | mask);
> > +    /* Pairs with cpu_test_interrupt(). */
> > +    qatomic_or(&cpu->interrupt_request, mask);
> >   }
> >
> >   /**
> > =20
>=20


