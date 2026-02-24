Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59C5DF3C98B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 14:55:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vutok-0006CS-FZ; Tue, 24 Feb 2026 09:55:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vutof-0006Ac-AC
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 09:55:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vutob-0004IM-Ob
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 09:55:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771944901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NRdqOl1pVUPKkAfSUQZ3zHG7TonZj4gCOguPVHgnHug=;
 b=dg0Wd9DIug1vEUQOzkZ9XXIuHHXw65zqR8vgXzFF02RGmQKJvr+TXPWbvQlSibIZz2M57g
 Umk3WzRb+n6PzPag5seFpmQirNQsfU3Bw9jg5sFSMvBIxobQyIXTG+1rWBMFETAuYMvhSQ
 G5feKbZFtBJeHFpq8fFU+lspxNUW+XU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-KOHBRUOMPFystArCmJ9MDA-1; Tue, 24 Feb 2026 09:54:59 -0500
X-MC-Unique: KOHBRUOMPFystArCmJ9MDA-1
X-Mimecast-MFC-AGG-ID: KOHBRUOMPFystArCmJ9MDA_1771944898
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-48372facfedso56058625e9.0
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 06:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771944897; x=1772549697; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NRdqOl1pVUPKkAfSUQZ3zHG7TonZj4gCOguPVHgnHug=;
 b=rFbRYMqnh3oyuepIJdXoy5oTsLx1vaBF1l7GvGLbZnldYByS6/lGe685XF+dmc6yjP
 3NQrND6K2iRf1UN6PQ06VTDk9CVFmejlrIGJ597k7SFds1Uc2r26qit22G24gEmblYlF
 bziibekrRUq2HmbTqiNsPoFb4nt4BoXJKdpi/ZlvGx1EvzPt9GickHqNkZrIJO4xcbwA
 17H126q/5Ok+XxbhJlV0CdgrWLNzYtZ54vqM/gzN+g3bts9n1RSRreKdhXhE9lRhGV2X
 PwCVh6UNAzVGTenioNAJXkjEHcFkbduSV9ji6xDcTUrtDosZHr7EhmeOZrp9QDqB5gRs
 tU+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771944897; x=1772549697;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NRdqOl1pVUPKkAfSUQZ3zHG7TonZj4gCOguPVHgnHug=;
 b=gDYf3AbJxaVPE1QZ2u2a3f5XiSaag46sOm5SEQ/YAEEF4tIixfM1YOewRttPiMNcV5
 8gHEg/dbXdijC2kGJb1EEgobYXmiNdCZTRiigKrDk+Q0C3W975+pFCCKRB1B2KBjzoZP
 m66p4wb/5VK/xPmtHuwaGUCV7OG/VTwIqqS3tK8JP1QNHhXDYHmkcQzbzVodEs0UG6My
 qPX/N/52tHWrZ4ioL3aRiMZvUFBDHqHhgVoY/wUIHmfismsHxaJdvzVt84fmH+QjbZ5z
 JEiJ1uwFDr3CShVUtSCl4qFfxKRswxZ7cGO39Gcb7sIO9ULbPnetPmF41J7OYO/qqJtp
 uang==
X-Forwarded-Encrypted: i=1;
 AJvYcCWM7blxMRcztEPRu5JBdIVAXEaZJPUhYP6p5Q7JiJg/y2ncrxla9fN8+M5J0i+WAwLAjBPebPwDJcC1@nongnu.org
X-Gm-Message-State: AOJu0YxkUd0ZFC50Sg4ZApsWkaf9bOeCK1sQv2lIsWlanposq8chka50
 /oMJBOceJEzVlIqqbjKjdvK8lEExhcOzX8oU8UY1RWHpgDpeR7U35yHm0To7Vcym9/4o+D2Xk/h
 gzPBSlPEjuWhNrDotbSTvCpW/VG7mmrSjzZSuK7PO+CguNbYOe7nohZWC
X-Gm-Gg: AZuq6aLDhnLGAGCPYQbcL4swNWzZCu4lBxoJ3eC4KqhbKrrLvEjtwDC3vwZMrfX8Oa2
 DT2qgLUCGJh6K3sRep587G96kQHvJ76i7/ahp1lAX+f72MU51H4xo44wpzLDgdQZhozjSssUSOM
 utFX2Vym1dDLH/7SYeyBnhP1narcQOn/8I7T/ljr5aQWYHTBY0mw7FhXofMGfor02IuYq/a5O4h
 YnFI6FM1T7H/wxbbaE6Dbw0+E94007yyi8hB29xf0BfEemi0Rbbo/e4p7fUOf/6yuaAYDLNoj5Z
 /aeKRJBq62/TzfW3tQw7hVeLaXMWEEiZp5wftqP9z8B7fTl5AKFbKK6reGLP6EWPqi6yKzaCpUZ
 MBS903ly140Q3xH432fTYL/CerqspWrcjeozD9SMkHemHVA==
X-Received: by 2002:a05:600c:8206:b0:479:13e9:3d64 with SMTP id
 5b1f17b1804b1-483bd74eeefmr3763165e9.15.1771944897489; 
 Tue, 24 Feb 2026 06:54:57 -0800 (PST)
X-Received: by 2002:a05:600c:8206:b0:479:13e9:3d64 with SMTP id
 5b1f17b1804b1-483bd74eeefmr3762535e9.15.1771944896950; 
 Tue, 24 Feb 2026 06:54:56 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd7031f3sm4086255e9.6.2026.02.24.06.54.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 06:54:56 -0800 (PST)
Date: Tue, 24 Feb 2026 09:54:53 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ankit Agrawal <ankita@nvidia.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Vikram Sethi <vsethi@nvidia.com>,
 Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
 "alex@shazbot.org" <alex@shazbot.org>,
 "anisinha@redhat.com" <anisinha@redhat.com>,
 Aniket Agashe <aniketa@nvidia.com>, Neo Jia <cjia@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "Tarun Gupta (SW-GPU)" <targupta@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 Krishnakant Jaju <kjaju@nvidia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v1 1/1] hw/acpi/pci.c: preserve generic initiator
 insertion order
Message-ID: <20260224095358-mutt-send-email-mst@kernel.org>
References: <20260222020812.26475-1-ankita@nvidia.com>
 <20260223082804.0d293861@imammedo>
 <SA1PR12MB7199F0C2E1D2325B0062B004B077A@SA1PR12MB7199.namprd12.prod.outlook.com>
 <20260223104411.57a815fa@imammedo>
 <20260223111302.00000081@huawei.com> <aZ2sylCydE9Js1ec@nvidia.com>
 <20260224085955-mutt-send-email-mst@kernel.org>
 <aZ2449e8ucB8e3AJ@nvidia.com>
 <SA1PR12MB7199847A879D66527B03DB1CB074A@SA1PR12MB7199.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1PR12MB7199847A879D66527B03DB1CB074A@SA1PR12MB7199.namprd12.prod.outlook.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Feb 24, 2026 at 02:51:42PM +0000, Ankit Agrawal wrote:
> >> 
> >> Not arguing against this, but if there's a linux bug it is important
> >> to fix it as a 1st step. qemu work arounds for broken guests
> >> notwithstanding. then we can check how long the uapi has been around,
> >> how practical bugfix backport in linux is, and decide on whether
> >> a host side work around is worth it.
> >
> > Yeah, Ankit should provide more details to check for kernel bugs, but
> > I fear it is more userspace bugs in practice :\
> >
> > However, I think even if it is minor and easier to backport it still
> > doesn't matter. The CSPs all built their VM types for this HW with the
> > exepcted ACPI and this stuff is now very widely deployed. It makes no
> > sense for qemu to be incompatible with everything pre-existing...
> 
> I don't think this is a kernel bug. To give somewhat more details,
> we pass memory-less, cpu-less NUMA node to the VM such as
> the following through the command line.
> 
> qemu-system-aarch64 \
> ..
> -numa node,nodeid=2
> -object acpi-generic-initiator,id=gi0,pci-dev=dev0,node=2 \
> ..
> 
> The qemu code here only adds the numa node if the size > 0.
> https://github.com/qemu/qemu/blob/stable-10.2/hw/arm/virt-acpi-build.c#L718
> These nodes are thus discovered through the Generic Initiator
> Affinity SRAT structures that is build for the acpi-generic-initiator
> object such as the following.
> 
> 
> [1A0h 0416 001h]               Subtable Type : 05 [Generic Initiator Affinity]
> [1A1h 0417 001h]                      Length : 20
> 
> [1A2h 0418 001h]                   Reserved1 : 00
> [1A3h 0419 001h]          Device Handle Type : 01
> [1A4h 0420 004h]            Proximity Domain : 00000002
> [1A8h 0424 010h]               Device Handle : 00 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
> [1B8h 0440 004h]       Flags (decoded below) : 00000001
>                                      Enabled : 1
>                   Architectural Transactions : 0
> [1BCh 0444 004h]                   Reserved2 : 00000000
> 
> 
> Now the kernel parse it in the sequence of their occurrence. A jumbled up
> sequence thus results in a jumbled up assignment.
> 
> Thanks
> Ankit Agrawal

it can parse in any order it wants. but you are saying it exposes the
offset in the table as a proximity domain?


