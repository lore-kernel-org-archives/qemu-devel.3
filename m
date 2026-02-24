Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33703F3C9B2
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 16:31:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuvJ4-00051Y-G5; Tue, 24 Feb 2026 11:30:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vuvIt-0004zK-Kl
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 11:30:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vuvIr-0006Zs-Gn
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 11:30:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771950625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FHawXC1WyTyFinooL0vB/oE6gX65AciE/nbTVdJxBcU=;
 b=GK9ljuscFGDN3zourfENmsE5DAxhC6pqHPn6FUrFbjqgj5DocNcnsCeyuJEE6e6G8pS8oT
 Hgwj4AmX9h7qPE5oSYoBXeR6Fb3jcZiL96MJ2dXBx8v+KBcwBnEU86dlW8nkbn+NuGvFbW
 VuWDayBQTV/8gjYD1OwufdnuK94GjN0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-G17D82OGMdeFSWECc8YFqA-1; Tue, 24 Feb 2026 11:30:22 -0500
X-MC-Unique: G17D82OGMdeFSWECc8YFqA-1
X-Mimecast-MFC-AGG-ID: G17D82OGMdeFSWECc8YFqA_1771950622
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-483a24db6ecso60477355e9.1
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 08:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771950621; x=1772555421; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FHawXC1WyTyFinooL0vB/oE6gX65AciE/nbTVdJxBcU=;
 b=iMpq4DWrYNHpWuNc8OhY6F6SIpCDaDU1EvYG9wJ2IbKWrFqrJXxuhGqpCCnwFMKBEv
 I5VcskUPemU90fY/Fq3PssUN7oeoMGTXNd+KFC7NqL+fvMYNUakjs8yneuCyZfp3Nf8U
 LidBBl8ruzV/PQ2ST/U4O+ANSeXl2pL1gAgZ4Z7+fmtzstrF7cAPWTZ7q7bRTbllUxjC
 p7pKmQTruRcrGtJ8yHba2pQ/FsBGOwkfoVKGJ0EVuMOUepZ/3K7D9BLOF3EoXaAspnOg
 kj2NK1PSxQ5DNxbCKblkQXVc1eXOQ9hwCAgRG/15DpDbgaK8P0Za+W3gfNK1MVqVuWSm
 yspw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771950621; x=1772555421;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FHawXC1WyTyFinooL0vB/oE6gX65AciE/nbTVdJxBcU=;
 b=SyJIJGPTn31YzptIZHjboPSV7CLqu/CoFdCeW5VvEEal4AvzV/q+a72bi+KhTYkoK3
 zeRJoHy8dAI572DBGn8gUeE3242cyVBnN6JnIjFdyEgteIbsKS1Kel3wwV2+lCR9B8DH
 4kXE4i5cteRNDfz5wQjyrUCDrphGl9cmG9u4mxRXzU60B81q6Eh0vt2xvS66AuvU64tM
 pfs+pmLYNUsrctlKX9YzSdgGxd05XMSjR7Ml1aEhzVgqwNp4/hAhcyW4PdPg5w9Zqhrg
 cnoZX2hYf94CIMgtX6QGnyeg7+rusGiwlKjrJriEKtIY1/3E8L6rytoOTljq907hY/EZ
 riTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWr45WM5Rq6BMZTNiEWrCo5hgfRSDUd6a6S2zWbkO1+PMNc1L9g2FlJcIy8zIzKXZdK3qaJegOLfBlJ@nongnu.org
X-Gm-Message-State: AOJu0YwinNQeX/PvRn5Tvbl4zKaFYcHyRTR0BDfd4gPXg+gpmT+yKiu1
 XRdGSBBCpd/B8zZZJasS0IumTo3RX/qv2oADhVhCCZfCJLqa8CntYvR3jdyPdWfjSwlpSSL+dW+
 pvXNRo46L6LhkjgRyyEUjS6NpC2ftxblY9KhdRk6apj0Bo8Kv1V71qumS
X-Gm-Gg: AZuq6aJWLoohRSPNnZ/2pADBfktbtE+fwVfVIqMFH99waWefDWz5+Yh3gYGI/nf0Tz7
 kK5f73Ku1BEBhTu+qpBwLdq0uViuVLJ+eHtWNZ/WyDQFyCMx6fPk1wwPNwNO9WI++MZ7GlxhyIo
 wwA4AS0XDiZvz5c7PmUSxKRXTsJkN2BdV+QfeRyFAXbON9iJNsmBUO/LVau+gFwARAmwvFKyHBZ
 bnquuNNB6P+0nO2V06qktISAXoMYei8R2Dp0P2qEMDDlv0+DLWGOj+9LG8qFTB5/EMCs2UONUTE
 hHvr5RkvTsblcdIBLczievV6KcATvD2Xhw/hvmO23qHFBrS8n7jGmCmOYX8S3mX2r+jdETfeOOd
 2fP6g+FGNxmt8mvktJwy99r3fuSSJsqFOoJsiFvAZt6Ib+w==
X-Received: by 2002:a05:600c:450c:b0:47d:73a4:45a7 with SMTP id
 5b1f17b1804b1-483a96377b1mr208140695e9.24.1771950621146; 
 Tue, 24 Feb 2026 08:30:21 -0800 (PST)
X-Received: by 2002:a05:600c:450c:b0:47d:73a4:45a7 with SMTP id
 5b1f17b1804b1-483a96377b1mr208139545e9.24.1771950620245; 
 Tue, 24 Feb 2026 08:30:20 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483b820def3sm55218065e9.2.2026.02.24.08.30.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 08:30:19 -0800 (PST)
Date: Tue, 24 Feb 2026 11:30:16 -0500
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
Message-ID: <20260224112907-mutt-send-email-mst@kernel.org>
References: <20260223082804.0d293861@imammedo>
 <SA1PR12MB7199F0C2E1D2325B0062B004B077A@SA1PR12MB7199.namprd12.prod.outlook.com>
 <20260223104411.57a815fa@imammedo>
 <20260223111302.00000081@huawei.com> <aZ2sylCydE9Js1ec@nvidia.com>
 <20260224085955-mutt-send-email-mst@kernel.org>
 <aZ2449e8ucB8e3AJ@nvidia.com>
 <SA1PR12MB7199847A879D66527B03DB1CB074A@SA1PR12MB7199.namprd12.prod.outlook.com>
 <aZ28qvehl7Lleo2a@nvidia.com>
 <SA1PR12MB71991611FEAA1B2D6A5171DFB074A@SA1PR12MB7199.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1PR12MB71991611FEAA1B2D6A5171DFB074A@SA1PR12MB7199.namprd12.prod.outlook.com>
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

On Tue, Feb 24, 2026 at 04:22:56PM +0000, Ankit Agrawal wrote:
> >> Now the kernel parse it in the sequence of their occurrence. A jumbled up
> >> sequence thus results in a jumbled up assignment.
> >
> > But what is the actual failure mode here? So the numa IDs are all in a
> > weird order, what goes wrong from that?
> 
> This interferes with the ability to replicate the numa distance topology
> on host in the VM through qemu command line.
> 
> E.g. consider a NUMA system with 2 sockets each with a GPU.
> 0,1 are the node ids for the sysmem on socket 0,1 respectively and
> 2,3 are the node ids for the GPU memory on socket 0,1 respectively
> dist(0,2) = X
> dist(0,3) = Y
> 
> If we try to replicate this for the VM by passing qemu arguments with
> 4 numa nodes and assign numa distances similar to host, and for the
> sake of example qemu mixes up by putting GI for 3 over 2. The SLIT
> which sets up the distances do it considering the original order in the
> qemu command line.
> https://github.com/qemu/qemu/blob/stable-10.2/hw/acpi/aml-build.c#L2040
> 
> This would lead to a different numa config in terms of distance within
> the VM that the one intended through the qemu command line.
> 
> Thanks
> Ankit Agrawal

but this is not how SLIT is formatted, is it? it does not refer to
entries by their location in the table, or am I confused?


