Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1E1BCCFA1A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 21:38:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIw1D-0001hk-Pq; Tue, 11 Nov 2025 16:35:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vIw0R-0000XP-Vt
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 16:34:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vIw0N-0002IH-Nf
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 16:34:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762896847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DpNqXUG11AGsY3sUGvyckw8XphYJ8cR1pOTzBckv6uc=;
 b=MqDYCmQ5+A+/J1pRaFhuxy7ZBnVPYs4PR9R8/ufcMHgVyKl+iBh0UOKEjZNiAjHBkG5T/4
 b5Jz9XiHIDvnix+vUfrpqXjLb7E4Qp30Tuy8ruTZJea8Ci0QFWlmDdQPte/ZNj2+Egeo09
 3nQUCsvCp0vo4V/SLTv51Nm1phjaTOk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-214-PEx8NJJaMvm8lAPihEfVng-1; Tue,
 11 Nov 2025 16:34:02 -0500
X-MC-Unique: PEx8NJJaMvm8lAPihEfVng-1
X-Mimecast-MFC-AGG-ID: PEx8NJJaMvm8lAPihEfVng_1762896841
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9D0AC1956095; Tue, 11 Nov 2025 21:34:01 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.45.225.214])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0EEDE30044E0; Tue, 11 Nov 2025 21:33:59 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v2 27/28] qcow2,
 vmdk: Restrict creation with secondary file using protocol
Date: Tue, 11 Nov 2025 22:32:37 +0100
Message-ID: <20251111213238.181992-28-kwolf@redhat.com>
In-Reply-To: <20251111213238.181992-1-kwolf@redhat.com>
References: <20251111213238.181992-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Eric Blake <eblake@redhat.com>

Ever since CVE-2024-4467 (see commit 7ead9469 in qemu v9.1.0), we have
intentionally treated the opening of secondary files whose name is
specified in the contents of the primary file, such as a qcow2
data_file, as something that must be a local file and not a protocol
prefix (it is still possible to open a qcow2 file that wraps an NBD
data image by using QMP commands, but that is from the explicit action
of the QMP overriding any string encoded in the qcow2 file).  At the
time, we did not prevent the use of protocol prefixes on the secondary
image while creating a qcow2 file, but it results in a qcow2 file that
records an empty string for the data_file, rather than the protocol
passed in during creation:

$ qemu-img create -f raw datastore.raw 2G
$ qemu-nbd -e 0 -t -f raw datastore.raw &
$ qemu-img create -f qcow2 -o data_file=nbd://localhost:10809/ \
  datastore_nbd.qcow2 2G
Formatting 'datastore_nbd.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=2147483648 data_file=nbd://localhost:10809/ lazy_refcounts=off refcount_bits=16
$ qemu-img info datastore_nbd.qcow2 | grep data
$ qemu-img info datastore_nbd.qcow2 | grep data
image: datastore_nbd.qcow2
    data file:
    data file raw: false
    filename: datastore_nbd.qcow2

And since an empty string was recorded in the file, attempting to open
the image without using QMP to supply the NBD data store fails, with a
somewhat confusing error message:

$ qemu-io -f qcow2 datastore_nbd.qcow2
qemu-io: can't open device datastore_nbd.qcow2: The 'file' block driver requires a file name

Although the ability to create an image with a convenience reference
to a protocol data file is not a security hole (unlike the case with
open, the image is not untrusted if we are the ones creating it), the
above demo shows that it is still inconsistent.  Thus, it makes more
sense if we also insist that image creation rejects a protocol prefix
when using the same syntax.  Now, the above attempt produces:

$ qemu-img create -f qcow2 -o data_file=nbd://localhost:10809/ \
  datastore_nbd.qcow2 2G
Formatting 'datastore_nbd.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=2147483648 data_file=nbd://localhost:10809/ lazy_refcounts=off refcount_bits=16
qemu-img: datastore_nbd.qcow2: Could not create 'nbd://localhost:10809/': No such file or directory

with datastore_nbd.qcow2 no longer created.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-ID: <20250915213919.3121401-6-eblake@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2.c | 2 +-
 block/vmdk.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index ec72e27214..cb0bdb32ec 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3971,7 +3971,7 @@ qcow2_co_create_opts(BlockDriver *drv, const char *filename, QemuOpts *opts,
     /* Create and open an external data file (protocol layer) */
     val = qdict_get_try_str(qdict, BLOCK_OPT_DATA_FILE);
     if (val) {
-        ret = bdrv_co_create_file(val, opts, true, errp);
+        ret = bdrv_co_create_file(val, opts, false, errp);
         if (ret < 0) {
             goto finish;
         }
diff --git a/block/vmdk.c b/block/vmdk.c
index eb3c174eca..3b35b63cb5 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -2334,7 +2334,7 @@ vmdk_create_extent(const char *filename, int64_t filesize, bool flat,
     int ret;
     BlockBackend *blk = NULL;
 
-    ret = bdrv_co_create_file(filename, opts, true, errp);
+    ret = bdrv_co_create_file(filename, opts, false, errp);
     if (ret < 0) {
         goto exit;
     }
-- 
2.51.1


