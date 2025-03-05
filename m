Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 162DEC282EC
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 23:06:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpxof-0007OQ-M2; Wed, 05 Mar 2025 18:06:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tpxoY-0007N1-WD
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 18:06:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tpxoX-0000Hj-2E
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 18:06:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741215967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v0aMqzc1F0dHi5tCg3272uegy17iK1O0O6GbkFKQ1uI=;
 b=RMu+Tx8+mNjwAbjV8Hj17M+q8DH48urH6QivQkhH13NdMKyBNEBucf6NLTRcjwQX9RMyTg
 xyJZnLKSbBRouX451DeKJGtbF0P1ORxzlXwutfcNynTzrdqy9oZ6h4cX/bPDqersBPYH7d
 7emrjTgDWug/G1tx1I/QbZTi/byJa2s=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-675-_W5aEhsjOKOW8ri72rDrtA-1; Wed,
 05 Mar 2025 18:05:50 -0500
X-MC-Unique: _W5aEhsjOKOW8ri72rDrtA-1
X-Mimecast-MFC-AGG-ID: _W5aEhsjOKOW8ri72rDrtA_1741215949
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 10F38180049D; Wed,  5 Mar 2025 23:05:49 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.105])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 268021955DCE; Wed,  5 Mar 2025 23:05:45 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Nir Soffer <nirsof@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Block layer core)
Subject: [PULL 1/4] iotest: Unbreak 302 with python 3.13
Date: Wed,  5 Mar 2025 17:05:21 -0600
Message-ID: <20250305230542.2225013-7-eblake@redhat.com>
In-Reply-To: <20250305230542.2225013-6-eblake@redhat.com>
References: <20250305230542.2225013-6-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Nir Soffer <nirsof@gmail.com>

This test depends on TarFile.addfile() to add tar member header without
writing the member data, which we write ourself using qemu-nbd. Python
3.13 changed the function in a backward incompatible way[1] to require a
file object for tarinfo with non-zero size, breaking the test:

     -[{"name": "vm.ovf", "offset": 512, "size": 6}, {"name": "disk", "offset": 1536, "size": 393216}]
     +Traceback (most recent call last):
     +  File "/home/stefanha/qemu/tests/qemu-iotests/302", line 118, in <module>
     +    tar.addfile(disk)
     +    ~~~~~~~~~~~^^^^^^
     +  File "/usr/lib64/python3.13/tarfile.py", line 2262, in addfile
     +    raise ValueError("fileobj not provided for non zero-size regular file")
     +ValueError: fileobj not provided for non zero-size regular file

The new behavior makes sense for most users, but breaks our unusual
usage. Fix the test to add the member header directly using public but
undocumented attributes. This is more fragile but the test works again.

This also fixes a bug in the previous code - when calling addfile()
without a fileobject, tar.offset points to the start of the member data
instead of the end.

[1] https://github.com/python/cpython/pull/117988

Signed-off-by: Nir Soffer <nirsof@gmail.com>
Message-ID: <20250228195708.48035-1-nirsof@gmail.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/302 | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/tests/qemu-iotests/302 b/tests/qemu-iotests/302
index a6d79e727b5..e980ec513f2 100755
--- a/tests/qemu-iotests/302
+++ b/tests/qemu-iotests/302
@@ -115,13 +115,22 @@ with tarfile.open(tar_file, "w") as tar:

     disk = tarfile.TarInfo("disk")
     disk.size = actual_size
-    tar.addfile(disk)

-    # 6. Shrink the tar to the actual size, aligned to 512 bytes.
+    # Since python 3.13 we cannot use addfile() to create the member header.
+    # Add the tarinfo directly using public but undocumented attributes.

-    tar_size = offset + (disk.size + 511) & ~511
-    tar.fileobj.seek(tar_size)
-    tar.fileobj.truncate(tar_size)
+    buf = disk.tobuf(tar.format, tar.encoding, tar.errors)
+    tar.fileobj.write(buf)
+    tar.members.append(disk)
+
+    # Update the offset and position to the location of the next member.
+
+    tar.offset = offset + (disk.size + 511) & ~511
+    tar.fileobj.seek(tar.offset)
+
+    # 6. Shrink the tar to the actual size.
+
+    tar.fileobj.truncate(tar.offset)

 with tarfile.open(tar_file) as tar:
     members = [{"name": m.name, "size": m.size, "offset": m.offset_data}
-- 
2.48.1


