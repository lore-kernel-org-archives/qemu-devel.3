Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61DB1CD5BAC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 13:47:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ3kR-00079Q-Rs; Thu, 21 May 2026 09:47:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wQ3k0-0006rE-HI
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:47:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wQ3jy-0002b9-Uu
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:47:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779371229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=74UnIbQq/VyHz/i0QDTHnaQ+zdT4EETS6jiUFL5Ny2Q=;
 b=ccuFwaJHnyz/7Kq4gYaZH0xibPjNrnAgtVzDo22orTJTNMPjQnFTlCWUsm/egIs3GYq4pN
 +NTjK2C0nRkG2Bh/X/66I2dDJra+rvdNTHLPgx9Zh3/FjIXW48vHabI13tfohGPC8U96z3
 96Ex7qTepesYw5tbSIT/HN8uYlD6cOc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-347-hyqCnPiQOdap0GuOduobFg-1; Thu,
 21 May 2026 09:47:02 -0400
X-MC-Unique: hyqCnPiQOdap0GuOduobFg-1
X-Mimecast-MFC-AGG-ID: hyqCnPiQOdap0GuOduobFg_1779371221
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CD0651800612; Thu, 21 May 2026 13:47:00 +0000 (UTC)
Received: from redhat.com (unknown [10.44.34.67])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 93B4219560A3; Thu, 21 May 2026 13:46:56 +0000 (UTC)
Date: Thu, 21 May 2026 15:46:53 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-block@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 hreitz@redhat.com, den@openvz.org, stefanha@redhat.com,
 qemu-stable@nongnu.org, qemu-devel@nongnu.org,
 Thomas Lamprecht <t.lamprecht@proxmox.com>
Subject: Re: [PATCH 3/4] qcow2: Fix corruption on discard during write with COW
Message-ID: <ag8MzS2ULm8UTFlb@redhat.com>
References: <20260427170520.101242-1-kwolf@redhat.com>
 <20260427170520.101242-4-kwolf@redhat.com>
 <414848c6-3829-4120-b760-6db8d43c1ab5@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <414848c6-3829-4120-b760-6db8d43c1ab5@proxmox.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Fiona,

Am 21.05.2026 um 14:12 hat Fiona Ebner geschrieben:
> Am 27.04.26 um 7:04 PM schrieb Kevin Wolf:
> > Most code in qcow2 that accesses (and potentially modifies) L2 tables
> > does so while holding s->lock.
> > 
> > There is one exception, which is allocating writes. They hold the lock
> > initially while allocating clusters, but drop it for writing the guest
> > payload before taking the lock again for updating the L2 tables. This
> > allows concurrent requests that touch other parts of the image file to
> > continue in parallel and is an important performance optimisation.
> > 
> > However, this means that other requests that run while the lock is
> > dropped for writing guest data must synchronise with the list of
> > allocating requests in s->cluster_allocs and wait if they would overlap.
> > For writes, this is done in handle_dependencies(), but discard and write
> > zeros operations neglect to synchronise with s->cluster_allocs.
> > 
> > This means that discard can free a cluster whose L2 entry will already
> > be modified in qcow2_alloc_cluster_link_l2() by a previously started
> > write. In the case of a pre-allocated zero cluster that is in the
> > process of being overwritten, this means that discard can lead to a
> > situation where the cluster is still mapped (because the write will
> > restore the L2 entry just without the zero flag), but its refcount has
> > been decreased, resulting in a corrupted image.
> > 
> > Add the missing synchronisation to qcow2_cluster_discard() and
> > qcow2_subcluster_zeroize() to fix the problem.
> > 
> > Cc: qemu-stable@nongnu.org
> > Reported-by: Denis V. Lunev <den@openvz.org>
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> 
> we had started rolling out a build of QEMU 11 with this patch already
> included. However, some of our users reported issues with VMs using
> qcow2 disks soon after [0][1]. I was able to reproduce the in-guest
> segfaults from [1] in a memory-constrained Debian 12 guest when using a
> swap partition on the same disk. Thanks to Thomas for the hunch with
> swap! After reverting this patch, I wasn't able to reproduce the issue
> anymore. I do not have a better reproducer yet and am not sure about the
> exact pattern causing the issue. It's related to the
> wait_for_dependencies() call in qcow2_subcluster_zeroize(), because if I
> revert just the one in qcow2_cluster_discard(), the issue still reproduces.
> 
> Commandline for my reproducer VM [2]. The issue does not happen if I
> drop "detect-zeroes":"unmap". Note that I don't have discard-no-unref
> for the qcow2 image, so in zero_in_l2_slice(), the branch with
> qcow2_free_any_cluster() is taken. Could the conflict be related to that?
> 
> I'm still trying to figure things out and come up with a better
> reproducer, but wanted to let you know early, also because of the
> upcoming stable releases. Of course, I'd also be happy for hints/hunches
> and am happy to test suggestions!

Do you have any information about the options used with the image file?
In particular, is it using subclusters? Maybe just the 'qemu-img info'
output would already give a bit more context.

Could you already locate the actual corruption and check what the
pattern looks like? Something like zeros where we would expect data or
the other way around? Or something less clear? (If you don't know,
that's a good answer too. I know well that this kind of things is hard
to debug.)

Kevin


