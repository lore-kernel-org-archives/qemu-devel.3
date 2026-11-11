Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D034606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 20:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TnKS2Zuc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xREYA-0004BD-VA; Wed, 11 Nov 2026 15:04:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xREY9-0004AT-Mx
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 15:04:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xREY7-0001zs-Ko
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 15:04:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794427441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S/9EQWGUlMPSBywpdb48WNnRvvDtBr/70lwdi/VTMsA=;
 b=TnKS2Zuc06RPcaUW7NTCPAe/C0tDyaFmquS7Abazik23jAKAXHstd+UbXiVCRiDltjGYxH
 h2I6A3pZhkHR43maKYbDmPtsrwBH3FHFY1lVoovZZRWOefQyPMVEuAt/ATe2QZBF5+lUu5
 XgUTE3df+sDLwYPvELF4CG8pbash7ys=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-440-dgRCTzgOMLuarkBar1mRaQ-1; Wed,
 11 Nov 2026 15:03:57 -0500
X-MC-Unique: dgRCTzgOMLuarkBar1mRaQ-1
X-Mimecast-MFC-AGG-ID: dgRCTzgOMLuarkBar1mRaQ_1794427435
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 823A21873242; Wed, 11 Nov 2026 20:03:42 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6944718004FC; Wed, 11 Nov 2026 20:03:39 +0000 (UTC)
Date: Wed, 11 Nov 2026 14:03:36 -0600
From: Eric Blake <eblake@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 qemu-block@nongnu.org
Subject: Re: [PATCH v2 5/5] iotests/migrate-bitmaps-postcopy-test: cover
 postcopy with a return path
Message-ID: <avS7g0KVPZLrjfwk@redhat.com>
References: <20261110183257.2930908-1-den@openvz.org>
 <20261110183257.2930908-6-den@openvz.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110183257.2930908-6-den@openvz.org>
User-Agent: NeoMutt/20260616
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 10, 2026 at 07:32:57PM +0100, Denis V. Lunev wrote:
> From: Denis V. Lunev <den@openvz.org>
> 
> The test migrates through an exec: fifo, which has no return path, so
> the source never waits for the destination's package-loaded pong.
> libvirt enables return-path for every migration that is not tunnelled.
> 
> Add a case that migrates one bitmap over a unix socket with return-path,
> unthrottled, and waits for the source to enter postcopy-active, so that
> the bitmap really goes through postcopy, and then for both sides to
> complete. It times out when the destination answers the pong from the
> run BH while dirty_bitmap_load() holds its lock across stream reads.
> 
> The existing cases are not run with a return path instead. They
> throttle the source, which lets the run BH take the lock between
> sections, and with a return path the source notices the destination
> shutdown and resumes the VM, as each VM has its own image.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Fabiano Rosas <farosas@suse.de>
> Cc: Juraj Marcin <jmarcin@redhat.com>
> Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> Cc: Eric Blake <eblake@redhat.com>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Hanna Reitz <hreitz@redhat.com>
> Cc: qemu-block@nongnu.org
> ---
>  .../tests/migrate-bitmaps-postcopy-test       | 39 +++++++++++++++++++
>  .../tests/migrate-bitmaps-postcopy-test.out   |  4 +-
>  2 files changed, 41 insertions(+), 2 deletions(-)

I'm having trouble getting this test to fail when applied in isolation
without the rest of the series.

I even tried amending your patch as follows (to force more migration
traffic, and ensure that postcopy is in the loop), but still could not
get it to fail:

diff --git i/tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test w/tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test
index a6e21dec0a0..7eb729716ff 100755
--- i/tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test
+++ w/tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test
@@ -303,8 +303,8 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
 # libvirt's configuration: the source waits for the destination's pong
 class TestDirtyBitmapPostcopyReturnPath(iotests.QMPTestCase):
     def setUp(self):
-        qemu_img('create', '-f', iotests.imgfmt, disk_a, '1G')
-        qemu_img('create', '-f', iotests.imgfmt, disk_b, '1G')
+        qemu_img('create', '-f', iotests.imgfmt, disk_a, '256G')
+        qemu_img('create', '-f', iotests.imgfmt, disk_b, '256G')
         self.vm_a = iotests.VM(path_suffix='a').add_drive(disk_a)
         self.vm_b = iotests.VM(path_suffix='b').add_drive(disk_b)
         self.vm_b.add_incoming('unix:' + mig_sock)
@@ -318,13 +318,17 @@ class TestDirtyBitmapPostcopyReturnPath(iotests.QMPTestCase):
         os.remove(disk_b)

     def test_postcopy_success(self):
-        self.vm_a.cmd('block-dirty-bitmap-add', node='drive0',
-                      name='bitmap0', persistent=True)
+        for i in range(15):
+            self.vm_a.cmd('block-dirty-bitmap-add', node='drive0',
+                          name=f'bitmap{i}', granularity=512, persistent=True)
+        self.vm_a.hmp_qemu_io('drive0', 'write 0 256M')

         caps = [{'capability': 'dirty-bitmaps', 'state': True},
+                {'capability': 'postcopy-ram', 'state': True},
                 {'capability': 'events', 'state': True},
                 {'capability': 'return-path', 'state': True}]
         self.vm_a.cmd('migrate-set-capabilities', capabilities=caps)
+        self.vm_a.cmd('migrate-set-parameters', max_bandwidth=16536)
         self.vm_b.cmd('migrate-set-capabilities', capabilities=caps)

         self.vm_a.cmd('migrate', uri='unix:' + mig_sock)
@@ -332,10 +336,11 @@ class TestDirtyBitmapPostcopyReturnPath(iotests.QMPTestCase):

         match = {'data': {'status': 'postcopy-active'}}
         self.vm_a.event_wait('MIGRATION', match=match)
+        self.vm_a.cmd('migrate-set-parameters', max_bandwidth=524288)
         match = {'data': {'status': 'completed'}}
         self.vm_b.event_wait('MIGRATION', match=match)
         self.vm_a.event_wait('MIGRATION', match=match)
-        check_bitmaps(self.vm_b, 1)
+        check_bitmaps(self.vm_b, 15)


 if __name__ == '__main__':


While it is indeed valuable to add a test covering libvirt's setup, I
was hoping that the test would also make it more obvious why the rest
of the series is necessary; if the test passes without the rest of the
series, it is not testing what you fixed.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


