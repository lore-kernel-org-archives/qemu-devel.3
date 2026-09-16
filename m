Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 847E7C982C9
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 15:10:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6rHC-0004lY-Qx; Wed, 16 Sep 2026 11:10:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x6rH8-0004jS-0E
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 11:10:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x6rH1-0004EI-N6
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 11:10:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789571409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cadIf6707X9oo2vFy6VRSXmLT7YgvB4txOMXdRDkuHk=;
 b=cNy19N3kEcFfAnKYadjwhvVdhl50s9iKQn0jL8wP+vSmsAA/8fjZK8wEqmsm+QSNYg5EZ8
 OcM3UWRWC3UA1/aMyGt1wX1NfUZw3Itwa7I8eQGwKLI9Kxrz+du+U63q9LZExgKu5+AumX
 JPPEa0G+YH3E0PkrZGGtaDpqW39FdpU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-KWHBVlaUMLS5ySWxVZUSqA-1; Wed, 16 Sep 2026 11:10:06 -0400
X-MC-Unique: KWHBVlaUMLS5ySWxVZUSqA-1
X-Mimecast-MFC-AGG-ID: KWHBVlaUMLS5ySWxVZUSqA_1789571405
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49e73659ac5so43038075e9.2
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 08:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789571405; x=1790176205; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cadIf6707X9oo2vFy6VRSXmLT7YgvB4txOMXdRDkuHk=;
 b=biASkbEhWZUwXFg0/5wENEJmB57YnNNGgVR5O6MFPNtNDpH1Qvz9YCyZapHL9R9Wf8
 nNtMJ+3kHUHDBRRv4TSWNFvhjg1FXNwvBfGjkPK5EdVX3fsRFAO2l0gZnEm999bx7Bha
 5Mtqsc8tivZswzq5MQCaoVZbPfQ+PU5v741nb2I3AalXAhXfqlC8rmz5VkRCegf/ulSE
 0wB54MmFWv1c2aNb2L63kSwvBEBMjANU+iWjKm6UM47djRmQPO119vxzZxl9HLQrVb6U
 D1uEMXkpD046Srl4gTRJxNptdloaFwpUfCEDGeTjdv5bmGBOg97ygzghO/WdEyMsZ0pJ
 NXag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789571405; x=1790176205;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cadIf6707X9oo2vFy6VRSXmLT7YgvB4txOMXdRDkuHk=;
 b=eU47f6O03DgbSMgRG7d50Z7cm94B/QuwTpVFHccvQAZncyiAtCN+bJQ3Y2OnOFwomL
 7tZZWhNoWzC1ftHTUHNR45ckzlxD8SImVIy6YjJEoh6udBfYKqUAWpgu6LhrXf/b2RbL
 V4UJX0uy/s3SDqIpQYHkCcOR4i4XCP4JC8uF+l93/BRA5wFBsjB5byVy3y7aPS2jzunb
 yHrZCByJjOkX664jnzZpYElICUZriat4Qr7ZbNUmFvTkFJOE8xqKPbtNZSkkKRs3PPU/
 oiC58Ik9WTsmgippdG/Ug3araQkCfe4Boju37lgkqFcVWNOjkqNVqKcvHRkwiUtlJG9f
 Oi7Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBx4Owg/XqjjMzhgEIy2r9vGvO8SMi85SrLH+T82BmlcvuH1lzP0pBopmrMwo50xICB+eIMxxiyGFGY9@nongnu.org
X-Gm-Message-State: AFuF++nlCUxW4FK+R4NIEpXvfZ7MV5gvJ0xUzxkTDp4FJEDZdQLVXDrJ
 3nTwRm5VtFEKV8Ca1LOn9Qio/nqYm2mN0TA1YgOgLYSH0sJWPbM6+6hHrSrxdxGy/LLIk+ieifX
 CQTPzDNzTgBxV+6g6TsfINFlYTsMgPg+3M0fNuF47P+WAXgefoYAthkYC
X-Gm-Gg: AYBFou0dT4xJRhMfv24cdVBrqeojM1yXKelyQy+Z4ZZhhdSHvr55jbFzuQfa2+0rzb+
 2zxk9Vua7yRKcuyH8+41UzPqXlosF27GtjggDsEuD9o6bze+oa/8B/PS1q/T1J/rhv9XLWilnCW
 teiSdDOGB42ckp754MMqjv8+UerbLMF8CYhiauIyDhZgE3PCmeM69xmknZW1SJa+ESS73pS4oRq
 /cxnT1SumJ03AOjCW3FHbnTKDhkc0IzQ38Z4W3SUJkbMgZx4xcqfwgqvGruFXzZxJ15B/u0IqzM
 lSR8cj+CsVKeoZ3EvWwntDzKc8le4f9N2wxmBvFrk9qDh8fGCXY9onh4uk7vAZyQL1relcsuKBF
 rEVp0OKSqN7vZSyUqAcFaOaI=
X-Received: by 2002:a05:600c:8b6a:b0:49c:eb04:1c49 with SMTP id
 5b1f17b1804b1-49eb72f62a1mr33398975e9.13.1789571404716; 
 Wed, 16 Sep 2026 08:10:04 -0700 (PDT)
X-Received: by 2002:a05:600c:8b6a:b0:49c:eb04:1c49 with SMTP id
 5b1f17b1804b1-49eb72f62a1mr33398575e9.13.1789571404155; 
 Wed, 16 Sep 2026 08:10:04 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbd0a4e68sm929655e9.2.2026.09.16.08.10.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 08:10:03 -0700 (PDT)
Date: Wed, 16 Sep 2026 11:10:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Alex Fishman <afishman@redhat.com>, qemu-devel@nongnu.org,
 sgarzare@redhat.com, farosas@suse.de, lvivier@redhat.com,
 pbonzini@redhat.com
Subject: Re: [PATCH v1 0/2] vhost: Handle vrings crossing virtio-mem slots
Message-ID: <20260916110929-mutt-send-email-mst@kernel.org>
References: <20260909125923.75340-1-afishman@redhat.com>
 <20260916145903.GA145703@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916145903.GA145703@fedora>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, Sep 16, 2026 at 10:59:03AM -0400, Stefan Hajnoczi wrote:
> On Wed, Sep 09, 2026 at 03:59:21PM +0300, Alex Fishman wrote:
> > Virtio-mem dynamic memslots are intentionally exposed as separate memory
> > regions. If a guest places a vring part across two adjacent slots, a later
> > memory update fails vhost ring verification because the complete ring part
> > is not contained in one vhost memory region.
> > 
> > Coalesce coherent adjacent sections only when a descriptor table,
> > available ring, or used ring crosses their boundary. Unrelated
> > unmergeable sections remain separate so they can still be updated
> > independently.
> > 
> > Patch 2 adds an end-to-end qtest reproducer using a fake vhost-user
> > backend and virtio-mem dynamic memslots. It also verifies that a newly
> > activated slot is not folded into the merge required by the crossing
> > vring.
> > 
> > Tested with the vhost-user/mem-slots/boundary qtest.
> > 
> > Buglink: https://redhat.atlassian.net/browse/RHEL-146583
> > 
> > Alex Fishman (2):
> >   vhost: coalesce unmergeable sections across vring boundaries
> >   tests/qtest: Add vhost-user memslot boundary test
> > 
> >  hw/virtio/vhost.c             |  72 ++++++-
> >  tests/qtest/vhost-user-test.c | 395 +++++++++++++++++++++++++++++++++-
> >  2 files changed, 452 insertions(+), 15 deletions(-)
> > 
> > 
> > base-commit: ff1d2d19d7e24893e2012d879f8e73077e17b9bd
> > -- 
> > 2.52.0
> 
> I'm pretty sure a similar problem exists with hw/virtio/virtio.c's
> MemoryRegionCaches. If a vring spans virtio-mem dynamic memslots, then
> the MemoryRegionCache won't work because the memory range crosses
> MemoryRegions.

IIUC address_space_cache_init does not check unmergeable, so virtio
doesn't have this problem.


> Is it worth looking at that first (e.g. triggering the issue with a test
> case that uses a built-in VIRTIO device instead of a vhost-user device)
> before implementing a solution that is specific to vhost-user?
> 
> Stefan



