Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCADAC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 06:41:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOAiD-000439-Uk; Mon, 01 Jul 2024 02:40:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sOAi9-00042t-7j
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 02:40:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sOAhr-0007LV-LK
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 02:40:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719816003;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oZpa2KWD7NKndd3EVYpX3X1HFtoEsIx4+BlZntlngcc=;
 b=cwaddkS+wk//LVQGOh2Lxnf8u6QzSy1eLM94XRAdcWlvMQ2eef7UmJfqv324nK2n+FbMcl
 XQwF4d/cfxWpZA8bcGvnujdMB4HGPKsfjfyMs1fVUOu728XIJbjDIBlzzRESjNOk0ikhRZ
 5iZ8n5B/HdAZWqvyeC4y2xxrC/RlZmM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-jPWuRj-6NjaCTqhqkXX7zw-1; Mon, 01 Jul 2024 02:39:57 -0400
X-MC-Unique: jPWuRj-6NjaCTqhqkXX7zw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4257dd7d40dso4845985e9.0
 for <qemu-devel@nongnu.org>; Sun, 30 Jun 2024 23:39:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719815996; x=1720420796;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oZpa2KWD7NKndd3EVYpX3X1HFtoEsIx4+BlZntlngcc=;
 b=dDvqiFQ6JhqkK4gjOALxE0KZQ64/4hPs5mIbb6FgUk2PlFTLGKo9fo2o0LFOGWo2Rf
 nlOT3R7+R8IYmeRPBbhK4o0GaNvhT3dqTkfJYRzm4hcn7VFb7/Y2wcy1XPhNJJs3Jl7C
 7WPnnvvCKrAiAb0CEQa8U0smAURUki4MiWmP372WdETAcnNFf8m7Y/BOjWALFGbw32e9
 sAh4XVnwG48zRKr6RlQlmBn0xQ9n/UqfF6melf2ctXUv6vWcY2JpN8A52qMo5zaE0XS2
 bpQ/24BO0d5noAuJUQGF3nSuITIRz/eIl22bRYCw6Bi1+V5cVaBr8VUAKzjdyxszcxi7
 lxcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXP9K9mAcVS6a5LF+uUv2OR+H/BVqJ3KFqbcbd/xRTkd9W2Mc2uMnxQq5sA6mDLvumHNBybi/wHtz4eNv785HJ21QJPlSA=
X-Gm-Message-State: AOJu0YwgHdmQJtTppmvgOGvGl5tY1Nl3oQchHlRBlk+pIgqI7n29f9oY
 x7Nh7QpdqN2k2S3fLvr5tR1MRQp2q+290FnsRNWK3NNOBgJCr890GmcV3WN/GgfHjhBmh9EWpoA
 PiT3xQD68Cu39q6Oe4TqWyBrJncny5scpEMLCRLRl37hGnqNnqEUWUh9adVnPsw5NMF1x6hb2P4
 C+yrg3PwM0j9rEWiuAscSwGMA3G4Y=
X-Received: by 2002:a05:600c:1c96:b0:421:811b:b83e with SMTP id
 5b1f17b1804b1-4256d56407amr70771545e9.13.1719815996785; 
 Sun, 30 Jun 2024 23:39:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLduekItFEDdyhOKfE8d1vQflnPdfkpDp6POvZtQ1P6zeH2SZI+ePVJUcUJHSelevhGtunVEdqkVT0OHYVIDc=
X-Received: by 2002:a05:600c:1c96:b0:421:811b:b83e with SMTP id
 5b1f17b1804b1-4256d56407amr70771445e9.13.1719815996464; Sun, 30 Jun 2024
 23:39:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240627140628.1025317-1-pbonzini@redhat.com>
 <20240627140628.1025317-3-pbonzini@redhat.com>
 <a8f5d517-7037-4146-824e-3f985774c780@intel.com>
 <CABgObfa24iTNt7V_VjsKYRhLyD3pt6oGDHEUFxe1A_A-4HF7MA@mail.gmail.com>
 <ZoIvUtVOgK91UuvF@intel.com>
In-Reply-To: <ZoIvUtVOgK91UuvF@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 1 Jul 2024 08:39:44 +0200
Message-ID: <CABgObfa_OESgS6uAP8NoFvGAXVW_z=XWi5TA2tVudyfQi7d_rQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] target/i386: drop AMD machine check bits from Intel
 CPUID
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, qemu-devel <qemu-devel@nongnu.org>, 
 John Allen <john.allen@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Jul 1, 2024 at 6:08=E2=80=AFAM Zhao Liu <zhao1.liu@intel.com> wrote=
:
> > > It seems to adjust it based on vendor in kvm_arch_get_supported_cpuid=
()
> > > is better than in x86_cpu_get_supported_feature_word(). Otherwise
> > > kvm_arch_get_supported_cpuid() still returns "risky" value for Intel =
VMs.
> >
> > But the cpuid bit is only invalid for Intel *guest* vendor, not host. I=
t is
> > not a problem to have it if you run on Intel host but have a guest mode=
l
> > with AMD vendor.
> >
> > I will check if there are other callers of kvm_arch_get_supported_cpuid=
(),
> > or callers of x86_cpu_get_supported_feature_word() with NULL cpu, that
> > might care about the difference.
>
> Another example is CPUID_EXT3_TOPOEXT, though it's a no_autoenable_flags,
> it can be set by "-cpu host,+topoext" on Intel platforms.

That was done by commit 7210a02c585 ("i386: Disable TOPOEXT by default
on "-cpu host"", 2018-08-16) which however does not explain what the
bug was. It talks about missing or inconsistent cache topology
information, but that's not precise enough to decide what the problem
was.

> For this case, we have recognized that that the host/max CPU should only
> contain vender specific features, and I think it would be hard to expand
> such a rule afterwards, especially since there's other x86 vender like
> zhaoxin who implement a subset of Intel/AMD:
>
> What about a new flag "host_bare_metal_check" in FeatureWordInfo? Then
> if a feature is marked as "host_bare_metal_check", in addition to the
> current checks in x86_cpu_get_supported_feature_word(), bare-metal CPUID
> check is also needed (by host_cpuid()) for "host" CPU.

I don't see why it's needed. The bare metal vendor is not visible to
the guest, therefore it should have no bearing on whether a bit is
included in CPUID.

Paolo


