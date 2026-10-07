Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D291CA6004
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 21:44:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEZR7-0003vJ-9q; Wed, 07 Oct 2026 17:44:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xEZR5-0003ua-Tr
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 17:44:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xEZR4-0001Kj-AV
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 17:44:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791409465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D9tW2Gkz8D2CoPCS6Z1aPTM4zSoZ/5ZYUfFXNZs0hk8=;
 b=brc7TsSnFTKSwlgbKuYCGCAS/CNHkRjvBozddK6ZoX/1/ZX3CfzCc0LvGtqp07rmR6eacT
 3icMXu2IxH1kPGhnVGnlCoQGEgWGD9N0mNi8hlIEHz32zazQ/nMtFgia77lsDCgXUAPnEo
 RPDVP+nEipFbYd1Utoh9juFCLHZgn8Q=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-197-R07X_bszN5-Uv2bf3LOkJQ-1; Wed,
 07 Oct 2026 17:44:22 -0400
X-MC-Unique: R07X_bszN5-Uv2bf3LOkJQ-1
X-Mimecast-MFC-AGG-ID: R07X_bszN5-Uv2bf3LOkJQ_1791409461
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8A7361831ECA; Wed,  7 Oct 2026 21:44:20 +0000 (UTC)
Received: from redhat.com (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 38D891800603; Wed,  7 Oct 2026 21:44:18 +0000 (UTC)
Date: Wed, 7 Oct 2026 16:44:15 -0500
From: Eric Blake <eblake@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PATCH v2 3/3] iotests/migrate-bitmaps-postcopy-test: add a
 bitmap on a second node
Message-ID: <asa8mpHviiTwP6P3@redhat.com>
References: <20261006170738.453977-1-den@openvz.org>
 <20261006170738.453977-4-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261006170738.453977-4-den@openvz.org>
User-Agent: NeoMutt/20260616
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Oct 06, 2026 at 07:07:38PM +0200, Denis V. Lunev wrote:
> From: Denis V. Lunev <den@openvz.org>
> 
> All bitmaps in the test live on drive0, so the source never switches
> nodes after setup and the destination never resolves a node name from
> the postcopy listen thread. Add a second drive with one bitmap and check
> that it arrives intact.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> Tested-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Fabiano Rosas <farosas@suse.de>
> Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  .../tests/migrate-bitmaps-postcopy-test       | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)

While playing with this patch series, I sent SIGINT mid-test, and then
all subsequent runs failed...

>      def setUp(self):
>          os.mkfifo(fifo)

because fifo was not cleanly removed on the preceeding run, but mkfifo
wasn't expecting it to already exist.  I'm squashing in this fix, even
though it was a pre-existing issue:

diff --git i/tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test w/tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test
index b2b37ada4b2..817a9216e58 100755
--- i/tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test
+++ w/tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test
@@ -100,6 +100,8 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
         os.remove(fifo)

     def setUp(self):
+        if os.path.exists(fifo):
+            os.remove(fifo)
         os.mkfifo(fifo)
         qemu_img('create', '-f', iotests.imgfmt, disk_a, size)
         qemu_img('create', '-f', iotests.imgfmt, disk_b, size)


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


