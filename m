Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EDCACA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:26:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEMvc-0003l2-Hj; Wed, 07 Oct 2026 04:23:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xEHgg-0005xU-I1
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:47:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xEHgX-0003u8-7m
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:47:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791341198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rfrA15FP5979hTY9u7DXgebpD1Ahe6zg8g51Qv/Nn1E=;
 b=Rc79KJxKDIqF8Ozbu6fW7wQPzNKZHbuesdysuMwX7dQV3w9Yttck066y1hVSRq2wsxGm2J
 fK9cib+kkjn0FqH5XRjLaMc1f5OBTlmVVsjFAGg1wENOrC+/n3TeegHkjTJyxtLH6M5voY
 ruOpAD2t+MfNJFQH85NZVzEktMWW1U4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-6nlmXaZoOZCh48W7seGEjw-1; Tue,
 06 Oct 2026 12:18:14 -0400
X-MC-Unique: 6nlmXaZoOZCh48W7seGEjw-1
X-Mimecast-MFC-AGG-ID: 6nlmXaZoOZCh48W7seGEjw_1791303493
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 05A8B1955F6E; Tue,  6 Oct 2026 16:18:13 +0000 (UTC)
Received: from redhat.com (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AAC0F1800345; Tue,  6 Oct 2026 16:18:10 +0000 (UTC)
Date: Tue, 6 Oct 2026 11:18:08 -0500
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 "open list:Network Block Dev..." <qemu-block@nongnu.org>
Subject: Re: [PATCH] qemu-nbd: Support -s and -l at the same time
Message-ID: <asUeiDNcvRf0VGy9@redhat.com>
References: <20260408021636.794794-2-eblake@redhat.com>
 <fa352330-32a8-4491-b045-812eb8a05966@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa352330-32a8-4491-b045-812eb8a05966@yandex-team.ru>
User-Agent: NeoMutt/20260616
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

[checking through my old branches]

On Wed, Apr 08, 2026 at 11:03:31AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 08.04.26 05:16, Eric Blake wrote:
> > qemu-nbd already has the ability to wrap a read-write layer on top of
> > the export of a read-only image (-s) and the ability to export an
> > internal snapshot rather than the main image in a qcow2 file (-l
> > SNAPID).  But it gave a confusing error message when trying to mix the
> > two, because the snapshot overlay created first no longer has access
> > to the internal snapshots of the image being wrapped.
> > 
> > WIth a bit of finesse, this useful scenario is now supported.
> > 
> > https://gitlab.com/qemu-project/qemu/-/work_items/159
> > 
> > Signed-off-by: Eric Blake <eblake@redhat.com>
> 
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> 
> Some optional suggestions below:
> 
> > +
> > +echo
> > +echo "=== Main image in snapshot mode ==="
> > +echo
> > +
> > +nbd_server_start_unix_socket -s -f qcow2 "$TEST_IMG"
> > +$QEMU_IO -c 'r -P 2 3M 1M' -c 'w -P 3 3M 1M' -f raw \
> 
> Maybe, add read command after write, to check write correctness. [*]

Good idea.

> 
> > +  nbd:unix:$nbd_unix_socket | _filter_qemu_io
> > +nbd_server_stop
> > +
> > +echo
> > +echo "=== Read-only snapshot access ==="
> > +echo
> > +
> > +nbd_server_start_unix_socket -l snap -f qcow2 "$TEST_IMG"
> > +$QEMU_IO -r -c 'r -P 1 3M 1M' -f raw \
> 
> Suggest, add write command, to check that it fails.

qemu-io rejects attempts to do -c 'w ...' on a read-only connection,
but it is a good idea to prove that qemu-io won't connect read-write
to a read-only server.

I'm queueing this patch with the following squashed in.

diff --git i/tests/qemu-iotests/tests/qemu-nbd-snapshots w/tests/qemu-iotests/tests/qemu-nbd-snapshots
index de405e43720..5bc7a1a5d23 100755
--- i/tests/qemu-iotests/tests/qemu-nbd-snapshots
+++ w/tests/qemu-iotests/tests/qemu-nbd-snapshots
@@ -45,7 +45,7 @@ echo "=== Main image in snapshot mode ==="
 echo

 nbd_server_start_unix_socket -s -f qcow2 "$TEST_IMG"
-$QEMU_IO -c 'r -P 2 3M 1M' -c 'w -P 3 3M 1M' -f raw \
+$QEMU_IO -c 'r -P 2 3M 1M' -c 'w -P 3 3M 1M' -c 'r -P 3 3M 1M' -f raw \
   nbd:unix:$nbd_unix_socket | _filter_qemu_io
 nbd_server_stop

@@ -56,6 +56,9 @@ echo
 nbd_server_start_unix_socket -l snap -f qcow2 "$TEST_IMG"
 $QEMU_IO -r -c 'r -P 1 3M 1M' -f raw \
   nbd:unix:$nbd_unix_socket | _filter_qemu_io
+$QEMU_IO -c 'r -P 1 3M 1M' -f raw \
+  nbd:unix:$nbd_unix_socket 2>&1 | _filter_qemu_io | _filter_testdir
+
 nbd_server_stop

 echo
@@ -63,7 +66,7 @@ echo "=== Combine -s and -l for read-write internal snapshot access ==="
 echo

 nbd_server_start_unix_socket -s -l snap -f qcow2 "$TEST_IMG"
-$QEMU_IO -c 'r -P 1 3M 1M' -c 'w -P 3 3M 1M' -f raw \
+$QEMU_IO -c 'r -P 1 3M 1M' -c 'w -P 3 3M 1M' -c 'r -P 3 3M 1M' -f raw \
   nbd:unix:$nbd_unix_socket | _filter_qemu_io
 nbd_server_stop

diff --git i/tests/qemu-iotests/tests/qemu-nbd-snapshots.out w/tests/qemu-iotests/tests/qemu-nbd-snapshots.out
index 6bce9d90253..47289c30f1d 100644
--- i/tests/qemu-iotests/tests/qemu-nbd-snapshots.out
+++ w/tests/qemu-iotests/tests/qemu-nbd-snapshots.out
@@ -14,11 +14,14 @@ read 1048576/1048576 bytes at offset 3145728
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 1048576/1048576 bytes at offset 3145728
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 1048576/1048576 bytes at offset 3145728
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)

 === Read-only snapshot access ===

 read 1048576/1048576 bytes at offset 3145728
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+qemu-io: can't open device nbd:unix:SOCK_DIR/qemu-nbd.sock: Could not open image: Permission denied

 === Combine -s and -l for read-write internal snapshot access ===

@@ -26,6 +29,8 @@ read 1048576/1048576 bytes at offset 3145728
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 1048576/1048576 bytes at offset 3145728
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 1048576/1048576 bytes at offset 3145728
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)

 === Check that original image is unchanged ===


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


