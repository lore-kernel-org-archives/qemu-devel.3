Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DABEECAC587
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 15:40:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqaId-0004tW-AY; Tue, 17 Sep 2024 11:39:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sqaIc-0004sP-Ce
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 11:39:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sqaIZ-0000ZA-NX
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 11:39:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726587566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ctAJCrUL8b2piLskwMDaIRx5SuwaThyMiEgclk/w+Lc=;
 b=O/GvEZ1qaClnxOCIl2s/Ap3aIyBxn3RH7p2XVLB8EacjlNNfi9FtGQQqibo4ITJNfkQEqt
 Q/DIkkkHweXKM7MiHnyon/8xr/7fX5vLmVlHQJZzdpUHN+U2wMnlRZDdZLBDT2MufvD1Sp
 hrXwplFIhaXuWX7MXKsNMYGwo48a9SY=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-Z04KI8gRMvuQU4sJeG9e9g-1; Tue, 17 Sep 2024 11:39:24 -0400
X-MC-Unique: Z04KI8gRMvuQU4sJeG9e9g-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4584224c8ffso124630941cf.3
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2024 08:39:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726587563; x=1727192363;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ctAJCrUL8b2piLskwMDaIRx5SuwaThyMiEgclk/w+Lc=;
 b=qLn3HNs2TkI86omlokVdDNViaWJxukfow4MrCG/lRw4oKtp0lbgkhbgo+lzjPguIkW
 MXD33llqEpC3CBOyQ0pBQZ711G0rOB5306v4YjpjRzxgC+k6x//6gsyCKILON7hsQrtJ
 WObVqnCwsZY9d8OpqlnMYFDZFvyWX4Lg1uSsbNIFZBrgZ6uCpffj8+qihA8GCLReZTSY
 H7ajx4wLuERReDioykefImUBAO19G3IJ9BKTIFEKvn9Tzwt+1gs1emrZURI6AGR5R+ux
 kKDva/uE2ggO4GXbpi70WX1oWJQnrNxLtQUapgPXXmsW8UxniW9KU5zhg3+Mq8Dg89eN
 SSfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqs9dTepfPs3oAGRiy6AEd4gVffoDhK41eVRg5CDHIGHL0muLbJx6Hu36YFPUF6BDIG3wTUJVgEqpW@nongnu.org
X-Gm-Message-State: AOJu0YwGALeigJ8tdalGIgpwyPWDN55R6NCkj90zL8trgKZkxSj/I5NG
 e8Dd9mW04+Rxkenchn260GCBzgnKsG6kILoK3qnqkJfQ7jNnFp2qvgQ1Rd/DpVbgYutjFL7mCOb
 YCNZRZtcnA8N7fl7EPjn2YkJxpnTC4n16Z63DgyQYZLy79REMrqfG
X-Received: by 2002:ac8:5810:0:b0:458:232d:db63 with SMTP id
 d75a77b69052e-4599d23e04emr269179251cf.21.1726587563589; 
 Tue, 17 Sep 2024 08:39:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7E1xzmlUJXZGx0J3B9qTN2LupUxuU6ckqwn2VuxLw+csqTONk6w7x7cbYwUZEXVLqIatMzA==
X-Received: by 2002:ac8:5810:0:b0:458:232d:db63 with SMTP id
 d75a77b69052e-4599d23e04emr269178921cf.21.1726587563220; 
 Tue, 17 Sep 2024 08:39:23 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-459aad1fcc9sm39463191cf.85.2024.09.17.08.39.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2024 08:39:22 -0700 (PDT)
Date: Tue, 17 Sep 2024 11:39:20 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: mail@maciej.szmigiero.name, Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 12/17] migration/multifd: Device state transfer
 support - send side
Message-ID: <ZumiqMiM4NgTdEgA@x1n>
References: <fdcfd68dfcf3b20278a4495eb639905b2a8e8ff3.1724701542.git.maciej.szmigiero@oracle.com>
 <87h6b4nosy.fsf@suse.de> <ZuCickYhs3nf2ERC@x1n>
 <87zfoc1zms.fsf@suse.de> <ZuOGAb3988ExsrHi@x1n>
 <87o74r1yfw.fsf@suse.de> <ZuRJ8i4T_vUzrawY@x1n>
 <87ldzv1tpb.fsf@suse.de> <ZuRYouLwikc4OYye@x1n>
 <87a5gb1kbg.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87a5gb1kbg.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Sep 13, 2024 at 03:26:43PM -0300, Fabiano Rosas wrote:
> The thread-pool approach is being looked at to solve this particular
> problem, but we have also discussed in the past that multifd threads
> themselves should be managed by a thread pool. Will we add this
> requirement to what is being done now? Otherwise, don't we risk having
> an implementation that doesn't serve the rest of multifd? Do we even
> know what the requirements are? Keep in mind that we're already not
> modifying the existing ThreadPool, but planning to write a new one.

Multifd currently has below specialties:

  - Multifd thread has 1:1 mapping with iochannels

  - Multifd thread num should be relevant to target bandwidth (e.g., the
    NIC performance)

While for a generic thread pool:

  - Thread has no correlation to any iochannel, but some async cpu
    intensive workloads during migration (either during switchover, or
    maybe even before that?)

  - Thread number should have no correlation to NIC/bandwidth, a sane start
    could be $(nproc), but maybe not..

I don't remember what I was thinking previously, but now it sounds ok to
keep multifd separate as of now to me, because multifd does service a
slightly different purpose (maximum network throughput) v.s. where we want
a pool of threads doing async tasks (which can be anything).

-- 
Peter Xu


