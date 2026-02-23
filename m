Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F3CFE98E0F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 09:44:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuSUJ-00031y-IE; Mon, 23 Feb 2026 04:44:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vuSUH-00031T-0k
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 04:44:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vuSUF-0006Us-IK
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 04:44:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771839858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sgrtKjG0tM1s+uDhEp8gFwOFOgEyQb7jl9R2j0/djYk=;
 b=XNnLVXu+SpmCN/5QHicCRsCTt1M0hVs9JrdM09xP4/CTGwGJiQUYLr+XcLPjj6dmKx3gZo
 KQvqay3bt4e787MRy7Cq6OneOGPgTW4nu54bQMAhdHmCoaFU10QNGZ59fcmWiFxluGs2OT
 RxMqoyRLFSZiWprfqQTP5YOEldUJdFo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-31M6b55lNR6vXS08_0rHQg-1; Mon, 23 Feb 2026 04:44:16 -0500
X-MC-Unique: 31M6b55lNR6vXS08_0rHQg-1
X-Mimecast-MFC-AGG-ID: 31M6b55lNR6vXS08_0rHQg_1771839855
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4837b6f6b93so30664225e9.3
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 01:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771839855; x=1772444655; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sgrtKjG0tM1s+uDhEp8gFwOFOgEyQb7jl9R2j0/djYk=;
 b=lspE7rprp1dQB07Ekiu3a8NIEuo9k6ha/pBWCST8CVe66GzzhRETQjGpzlhYXuAXwS
 f3z53gCl6VyjhC/18P4Sb8qSNPNPcvjBT8jUn2PdET8DNeWfBoXZrQtblZCC8QY6RGGy
 4SeC/5p+OG9O7JdDgT9OjkoMNtqSZpX+us1qLQYpz7znNghoXhgDZu2XnPy5M0vPkRVh
 nxUEeAfeDk8rVNKT5sdUZYn5iQYFbAOcZ1U2YqStHBx7Qz92r/cRu2E1i2EgOGvF5Nsn
 D3F8uPZngVJDO3YVKpfuv+Z2CswYNfHG28oasiOxeTVub/O62XIY4o6mlS6LY0G0fBS3
 yi2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771839855; x=1772444655;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sgrtKjG0tM1s+uDhEp8gFwOFOgEyQb7jl9R2j0/djYk=;
 b=qLLybFk/qCoMj80up8EPoap8kEnt0584j6R3mTfIKepZ3VR/OI2bWMckQ7IqE1bKfB
 qSYUC+zM5K4s4rJHh+yC43DffFfVtWuQD9/rHz5vy3+PiPurkx76b3HDLoPmFqTBZsaL
 Gd49kmXy3r3rQAu2lHQnz+jec9dTjMV9h67IE7U6DLVVQ5W3sUtO4HyrD30VOuNnHVH3
 IRZ0ieodbzZ01+WXxR6YVOkeOcEQ+V4dXP1xalCglUp/Osy1N+L4cRe+0kZhk3iUdEVl
 d1MOUaLEYT4pQlR01w4e3xYEOs8M19i/3XPNgFHTtuyT9D5qmhk0eNR/I5bGM5cKZaLe
 Y6NA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVljIDS/czS7I6LbEy+TrrRJwbkD018/XIN6RzNHvxSH0MY03z/Sqou5Kwj+M+WZlY3wr93Kfw5QPZJ@nongnu.org
X-Gm-Message-State: AOJu0YzuPeTOSHTJCqNw5TjCuOPPGu/hLNjipq8m0MDiXXyGDiieJwD0
 32wZ5l6KDP23WoqK0C/PfDj8I4WERaZ9o1jgYWIVqff7KkB5gq176FqJzAzU7waYabY1Ex3uYzS
 Pl0vQqif8O0I8uE9Aft8wDsnGtHyiAXU4XgpkZDj9YcOYMzdmB1KB5pps
X-Gm-Gg: AZuq6aJhMqJ5fUWrObt6XGxLu8gExhmcfK3vbFejWE7dNHb99jWtbpUj8Pxx8IIRm/c
 MQ2Ot6GsB2FyibW8bhSWwwDhcfXpScUloMMbXPGPhULWNmVLM+N0qlTbUjA4VqqMNMqrnldQ40v
 6QuaR2tgukE7G6EbJk86WMUjYwp/NOrdyhP/Ozqtg/lsrFb+XnLabOCtKWshQNKYV0BMvE+o1mL
 dQquXmiyceKYu5F8KJBP+zXTr9ikM5ctKYS7E+CEkUdUQ5fTLhMtUZsbuu80FrPYEaXeE6zkHzk
 g/ZoxkMoSQVH6Z2hxqvQ5g1CbWYfP5tvwWjJMlI55VbW3DxpBFdeA4+gny4z+eik4TxwKbm4GR6
 uG+R1AQ==
X-Received: by 2002:a05:600c:37cd:b0:483:6d4a:7e6d with SMTP id
 5b1f17b1804b1-483a960604cmr114507545e9.30.1771839855371; 
 Mon, 23 Feb 2026 01:44:15 -0800 (PST)
X-Received: by 2002:a05:600c:37cd:b0:483:6d4a:7e6d with SMTP id
 5b1f17b1804b1-483a960604cmr114507005e9.30.1771839854883; 
 Mon, 23 Feb 2026 01:44:14 -0800 (PST)
Received: from imammedo ([213.175.46.86]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a4293bdfsm135614265e9.3.2026.02.23.01.44.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 01:44:14 -0800 (PST)
Date: Mon, 23 Feb 2026 10:44:11 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Ankit Agrawal <ankita@nvidia.com>
Cc: Vikram Sethi <vsethi@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Shameer Kolothum Thodi <skolothumtho@nvidia.com>, "alex@shazbot.org"
 <alex@shazbot.org>, "mst@redhat.com" <mst@redhat.com>,
 "anisinha@redhat.com" <anisinha@redhat.com>, Aniket Agashe
 <aniketa@nvidia.com>, Neo Jia <cjia@nvidia.com>, Kirti Wankhede
 <kwankhede@nvidia.com>, "Tarun Gupta (SW-GPU)" <targupta@nvidia.com>, Zhi
 Wang <zhiw@nvidia.com>, Matt Ochs <mochs@nvidia.com>, Krishnakant Jaju
 <kjaju@nvidia.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v1 1/1] hw/acpi/pci.c: preserve generic initiator
 insertion order
Message-ID: <20260223104411.57a815fa@imammedo>
In-Reply-To: <SA1PR12MB7199F0C2E1D2325B0062B004B077A@SA1PR12MB7199.namprd12.prod.outlook.com>
References: <20260222020812.26475-1-ankita@nvidia.com>
 <20260223082804.0d293861@imammedo>
 <SA1PR12MB7199F0C2E1D2325B0062B004B077A@SA1PR12MB7199.namprd12.prod.outlook.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.798, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.79,
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

On Mon, 23 Feb 2026 07:49:51 +0000
Ankit Agrawal <ankita@nvidia.com> wrote:

> >> During creation of the VM's SRAT table, the generic initiator entries
> >> are added. Currently the order in the entries are not controllable from
> >> the qemu command. This is due to the fact that the code queries the
> >> object tree which may not be in the order objects were inserted.
> >>
> >> As a fix the patch maintains a GPtrArray of generic initiator objects
> >> that preserves their insertion order. Objects are automatically added
> >> to the array when initialized and removed when finalized. When building
> >> the SRAT table, objects are processed in the order they were first
> >> inserted.  
> >
> > so question would be, why does it matter?
> > Is ther a requirement in spec for SRAT entries being put in a particular order?  
> 
> Hi Igor, reposting my response. I'll make this information as part of the next
> version if and when I refresh.
> 
> VM's Linux kernel parses the generic initiator (GI) structures present in the SRAT
> table sequentially in the order of their occurrence and assigns a numa node
> id when a new proximity domain (that is part of the GI structure) is encountered.
> A jumbled up entries in the VM's SRAT consequently results in the jumbled up
> sequence on numa nodes v/s the ones intended to be assigned through the
> qemu command line. This messes up the internode numa distances assignment
> through the qemu command line as the VM's view of the corresponding nodes
> is entirely different.

Assuming that QEMU CLI is correctly defined, above looks very much like a linux
kernel bug.

Aka: if kernel is not mapping proximity ID to its internal node ids correctly
and then links them with something else entirely, it's kernel in wrong
and not ACPI tables QEMU provides.

IMHO it should be fixed on kernel side. (unless you find statement in spec
that mandates the particular ordering in SRAT)


