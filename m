Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3374BC5AD49
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 15:46:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKIyX-0003HD-Qk; Wed, 28 May 2025 11:45:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uKIyS-0003G1-Vg
 for qemu-devel@nongnu.org; Wed, 28 May 2025 11:45:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uKIyQ-0007nK-TB
 for qemu-devel@nongnu.org; Wed, 28 May 2025 11:45:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748447145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ID7PnL5IGvdgp7kG+lasWihv2vm2JLmaXVpofG9E8sg=;
 b=bo6veu2k7YGWAkE9oDJtTdsDo7mGPsjBFAwYzqtKt5JY3pR6Mk7D4raaRT//gvLUQsqZt6
 u7RlTEvFB3DK+qApjipm5Yrmi0FHSbKXLEBiTIdt3Zd6P67fGf+6QP51wcUx4qToHM/VdD
 M3ixGL9TlQyMZMEe+aMZjE2JtsvsYjc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-t0rwGOioO-21TmCIPi4bfQ-1; Wed,
 28 May 2025 11:45:42 -0400
X-MC-Unique: t0rwGOioO-21TmCIPi4bfQ-1
X-Mimecast-MFC-AGG-ID: t0rwGOioO-21TmCIPi4bfQ_1748447141
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9358D1800570; Wed, 28 May 2025 15:45:40 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.48])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7221130001B0; Wed, 28 May 2025 15:45:38 +0000 (UTC)
Date: Wed, 28 May 2025 10:45:35 -0500
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, f.ebner@proxmox.com, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v2 2/3] iotests: Improve mirror-sparse on ext4
Message-ID: <ibn5a3mq4co2h5rpslkq42hir4ka4dz5fsgcbmuwqnoiwarhmf@5qlu3ssskquc>
References: <20250523163041.2548675-5-eblake@redhat.com>
 <20250523163041.2548675-7-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523163041.2548675-7-eblake@redhat.com>
User-Agent: NeoMutt/20250404
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, May 23, 2025 at 11:27:22AM -0500, Eric Blake wrote:
> Fiona reported that an ext4 filesystem on top of LVM can sometimes
> report over-allocation to du (based on the hueristics the filesystem
> is making while observing the contents being mirrored); even though
> the contents and actual size matched, about 50% of the time the size
> reported by disk_usage was too large by 4k, failing the test.  In
> auditing other iotests, this is a common problem we've had to deal
> with.
> 
> Reported-by: Fiona Ebner <f.ebner@proxmox.com>
> Fixes: c0ddcb2c ("tests: Add iotest mirror-sparse for recent patches")
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Fiona Ebner <f.ebner@proxmox.com>
> Tested-by: Fiona Ebner <f.ebner@proxmox.com>
> 
> ---
> v2: Drop sync for ZFS
> ---
>  tests/qemu-iotests/tests/mirror-sparse | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Squashing this in since Markus is reporting failures even with this
patch applied, and I'm lacking enough context to see what else might
be interfering:

diff --git i/tests/qemu-iotests/tests/mirror-sparse w/tests/qemu-iotests/tests/mirror-sparse
index 39e3196c811..a30e52de41d 100755
--- i/tests/qemu-iotests/tests/mirror-sparse
+++ w/tests/qemu-iotests/tests/mirror-sparse
@@ -105,7 +105,7 @@ if test $result -lt $((3*1024*1024)); then
 elif test $result -gt $((19*1024*1024)); then
     actual=full
 else
-    actual=unknown
+    actual="unexpected size ($result)"
 fi
 echo "Destination is $actual; expected $expected"
 }


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


