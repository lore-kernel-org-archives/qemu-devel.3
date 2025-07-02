Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB1DDC83F07
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 11:23:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWvYl-00074H-AO; Wed, 02 Jul 2025 07:23:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uWvYe-0006ym-69
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 07:23:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uWvYZ-00034h-Ak
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 07:23:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751455392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x8yqFJS7T2pzVp8H2HNUpAV0xUHAdmoZbS+ig8L+N38=;
 b=RtLo8O63XhY2Q6GYNVTNYETJNQcF5G+/bvoZKlVFK8A47hPCTL/PoQc0sgK4moLTTEio0w
 deTRWOamHOJtmA5HJV4mR8AQkiFBJ/b4hwtyMHDrsweMzyn6tZKXathD7yxU7Vz9MtJzSJ
 S8B7ahEcHPWALLCxo+Y948KgsI7izb8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-ZSRBlIUmOR-Gork0U0st9A-1; Wed, 02 Jul 2025 07:23:11 -0400
X-MC-Unique: ZSRBlIUmOR-Gork0U0st9A-1
X-Mimecast-MFC-AGG-ID: ZSRBlIUmOR-Gork0U0st9A_1751455390
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4532ff43376so39625555e9.3
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 04:23:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751455390; x=1752060190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x8yqFJS7T2pzVp8H2HNUpAV0xUHAdmoZbS+ig8L+N38=;
 b=tbgzgqA9K+5CrzuwEfbk1yt+0iTzUwab+XA57mIEP6iYcovOxScqOMqGxoiA4t3AFa
 q9Y9tf718mTlXXIcH4PonxJPpnj9j1hLrYyjGMhvjGYWV71IHbqxmuPMjoxbHdKZcOQh
 5051O9klRaY2DnPEchIxfMvBmYuxm7ZGeJ4GAWCoX400jdIY3ST8G6PErt62JTuT/NF2
 7lLjRDPBFK0jER99uBAhh70Giaau0+If5GwSI1yB5DUSpvSNgFa8Zq0aB042Tddo51Jf
 N8PzSHu0mOs580GnJy1sTGycgmF5ehpjQHJc7kmq+TsGBuYKEORo94VLyKzxgH7iHUQh
 r2BA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOtYbJI48yMaNPC9MTrII6giipAKIfUcawywC4ONGEutkdK8L98/X/Rj0SJFENMCDPaB72HAXo6ebu@nongnu.org
X-Gm-Message-State: AOJu0YzaU/0acAEDGlZjP7lBBHQK97woIcEf5706S9yiuT1TofsvF7IP
 QYZfD5cF4fjn9SF/zi86tBK5mszP9Dm8JW3neb4WdQGmfShPL9FI77jWW8LFuWOwW7nPfroX6di
 VQmrJmaTficZGQiT7Y2yaIhXOfsm6hCFe/tDR7CxiMx2SmJ/O9wXYaPZJ
X-Gm-Gg: ASbGncvJYmmTkCRQ1ZRHjl+46BhtcXYj6D/oWXLpADOUbsDOr6l0610Y1zNOuxG19E/
 QJTbWUrFFHiHrUnNS80s6tK4Sj3kdGQz6ewqK01ASWDlCB2jDxxBVAw609OLk6WZLIfcrmO1vNp
 DdgqlGq0xQA6S1yL9y/1WSpk62tZw2Akbrhmc+c5CXUg3n10XTWHxHl6eOj9OdQ6mAHxNm4O+ln
 2ebRsWRTwVUDxdRuIikVAiu3gY6jCYPu03zCd4kZWYmYYrMSp585INhACV9GcfPh6CY5YnzBY8T
 kyrNfs6TxVHG
X-Received: by 2002:a05:600c:8b22:b0:453:1e14:6387 with SMTP id
 5b1f17b1804b1-454a4e1c2d0mr13588715e9.32.1751455390112; 
 Wed, 02 Jul 2025 04:23:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJF3cGjOKUfJ0j9WgQHOufxJLqjKaO2THVF2AcMDHMH0fjo5rJxkwGemPPZ4hLXqnX52gyWg==
X-Received: by 2002:a05:600c:8b22:b0:453:1e14:6387 with SMTP id
 5b1f17b1804b1-454a4e1c2d0mr13588315e9.32.1751455389619; 
 Wed, 02 Jul 2025 04:23:09 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538a3a57c2sm195024455e9.12.2025.07.02.04.23.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 04:23:09 -0700 (PDT)
Date: Wed, 2 Jul 2025 13:23:07 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Alexandre Chartre <alexandre.chartre@oracle.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, qemu-stable@nongnu.org, boris.ostrovsky@oracle.com,
 maciej.szmigiero@oracle.com, Sean Christopherson <seanjc@google.com>,
 kvm@vger.kernel.org
Subject: Re: [PATCH] i386/cpu: ARCH_CAPABILITIES should not be advertised on
 AMD
Message-ID: <20250702132307.71e3b783@fedora>
In-Reply-To: <aGQ-ke-pZhzLnr8t@char.us.oracle.com>
References: <20250630133025.4189544-1-alexandre.chartre@oracle.com>
 <aGO3vOfHUfjgvBQ9@intel.com>
 <c6a79077-024f-4d2f-897c-118ac8bb9b58@intel.com>
 <aGPWW/joFfohy05y@intel.com> <20250701150500.3a4001e9@fedora>
 <aGQ-ke-pZhzLnr8t@char.us.oracle.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 1 Jul 2025 16:01:21 -0400
Konrad Rzeszutek Wilk <konrad.wilk@oracle.com> wrote:

> On Tue, Jul 01, 2025 at 03:05:00PM +0200, Igor Mammedov wrote:
> > On Tue, 1 Jul 2025 20:36:43 +0800
> > Zhao Liu <zhao1.liu@intel.com> wrote:
> >  =20
> > > On Tue, Jul 01, 2025 at 07:12:44PM +0800, Xiaoyao Li wrote: =20
> > > > Date: Tue, 1 Jul 2025 19:12:44 +0800
> > > > From: Xiaoyao Li <xiaoyao.li@intel.com>
> > > > Subject: Re: [PATCH] i386/cpu: ARCH_CAPABILITIES should not be adve=
rtised
> > > >  on AMD
> > > >=20
> > > > On 7/1/2025 6:26 PM, Zhao Liu wrote:   =20
> > > > > > unless it was explicitly requested by the user.   =20
> > > > > But this could still break Windows, just like issue #3001, which =
enables
> > > > > arch-capabilities for EPYC-Genoa. This fact shows that even expli=
citly
> > > > > turning on arch-capabilities in AMD Guest and utilizing KVM's emu=
lated
> > > > > value would even break something.
> > > > >=20
> > > > > So even for named CPUs, arch-capabilities=3Don doesn't reflect th=
e fact
> > > > > that it is purely emulated, and is (maybe?) harmful.   =20
> > > >=20
> > > > It is because Windows adds wrong code. So it breaks itself and it's=
 just the
> > > > regression of Windows.   =20
> > >=20
> > > Could you please tell me what the Windows's wrong code is? And what's
> > > wrong when someone is following the hardware spec? =20
> >=20
> > the reason is that it's reserved on AMD hence software shouldn't even t=
ry
> > to use it or make any decisions based on that.
> >=20
> >=20
> > PS:
> > on contrary, doing such ad-hoc 'cleanups' for the sake of misbehaving
> > guest would actually complicate QEMU for no big reason. =20
>=20
> The guest is not misbehaving. It is following the spec.

that's not how I read spec:

"
AMD64 Architecture Programmer=E2=80=99s Manual Volume 3: General-Purpose an=
d System Instructions
24594=E2=80=94Rev. 3.36=E2=80=94March 2024
...
Appendix E Obtaining Processor Information Via the CPUID Instruction
...
All bit positions that are not defined as fields are
reserved. The value of bits within reserved ranges cannot be relied upon to=
 be zero.
Software must mask off all reserved bits in the return value prior to makin=
g any value comparisons of represented
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
information.
...
E.3.6 Function 7h=E2=80=94Structured Extended Feature Identifiers
...
The value returned in EDX is undefined and is reserved.
"

what actually happens is guest side being lazy and blindly following CPUID.


> > Also
> > KVM does do have plenty of such code, and it's not actively preventing =
guests from using it.
> > Given that KVM is not welcoming such change, I think QEMU shouldn't do =
that either. =20
>=20
> Because KVM maintainer does not want to touch the guest ABI. He agrees
> this is a bug.
one can say both guest and hypervisor are to blame,
  1st is not masking reserved bits
  2nd provides 'hybrid' cpu that doesn't exists in real world,
  but then 'host' cpu model has never been the exact match for physical cpu.

what I dislike is ad-hoc fixups in generic code,=20
if consensus were to implement _out of spec_ fixup for already fixed issue =
in Windows,
it should be better be done in host cpumodel code.

Or even better a single KVM optin feature 'do_not_advertise_features_not_su=
pported_by_host_cpu',
and then QEMU could use that for disabling all nonsense in one go.
Plus all of that won't be breaking KVM ABI nor qemu had to add fixups for t=
his and that feature.

After some time when old machine types are deprecated/gone, KVM could make =
it default and eventually
remove advertising 'fake' features.

PS:
On QEMU side we usually tolerant to such fixups if it's not fixable on gues=
t side.
but that's not the case here.


