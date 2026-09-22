Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F70EC98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:24:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x971D-0003zl-Qi; Tue, 22 Sep 2026 16:23:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x970B-0000qw-PD
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:22:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x970A-0000EV-6b
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:22:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j3kQNBjYU/mWOL9sUSYAoZn1cB4PUxK+hUiKnkfGjfI=;
 b=G38NOg23HOdEID0hh+P7uCl/Y1R8+3dgKWA7ZC2EZmBmHO/9T0ViqZETq24beFfq0MmJtq
 1b25zUU6Itj3FDCpuF9Bq6LIn6TUSzIZrI2qr0bL0rbjWdiDCddN5hSIYenZ2doY30siE6
 39+fhq7wbLIdgm3WQ/6xM8FIE5wZ+ds=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-518-WkMufaeBPXqu3OsQ7DTyHg-1; Tue,
 22 Sep 2026 16:22:02 -0400
X-MC-Unique: WkMufaeBPXqu3OsQ7DTyHg-1
X-Mimecast-MFC-AGG-ID: WkMufaeBPXqu3OsQ7DTyHg_1790108521
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6281E195D013; Tue, 22 Sep 2026 20:22:01 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8462D1800446; Tue, 22 Sep 2026 20:22:00 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:17:55 +0400
Subject: [PATCH 48/88] qemu-iotests/007: migrate away from HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-48-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1853;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=bbrdnb+ya+FVaVNWV+jV9hfsjFL4W8ap1a0JI7znIBQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqsuKxYnqmvkl2mYjD8aexiuLBpcCqGyAtD/ncW
 ILvPx/KPXaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarLisQAKCRDa6OEJdZac
 5QfMD/95VqQJaHpC6PauCTPhOWFVUjxh0YyoAoGiWtTsu5cSb7GcxAW0HWqLzBZoiRESu19IV5z
 7eJ275d6Jk+AL/UsUcqOGVZYCUCZK0OnRFckFaBuvKHsqYwAboQv24vNZm5Hmybukx2o8N39Fr+
 Hwga0vvgP/ND+ejNwMvKiR9dRaxKKKl8Shr2A/gHcl/hopRCo092YaZsfy3qYdP38awUNgAWmk5
 zU0IIrDC/G5OcexrSWbntDYpbrfBbWYagIVVUTSl/dogYfUih+QEi68PC5fcuw77pOWZW9cvV4o
 as8LRLiM+lfqmECGoybCys7gu5/JzjIZ6LnoPZGOn/RbkKfhU2pbkTH4Ww5rvJqZ+qUf2FTBNSF
 3CKGy53wEc7X1USKJ2iVblsYQzLlJ5omQ4mzPPSMYxf2zX3Ik2xOYT5l852rEDPbIJWr6dZ9+FA
 58Fu29+HEK1NRgme2NPapy5EidVJDwmQ5+3J0CuCM4Iv1LBCr04fbDYoAq1H4Q6QBmNPljM34R8
 XEHpl6ZgQmK9cwKdTZPI63XEbh3N9yQ7DDeCmX13qXx2VtprlVr4EkXPyft7L6rB1ZocKA11tTt
 uRTcqv6JRZhmlitnCFFuUtMtFqpTxbX/waBFSbWnxz2RJLek15Nq3JuNpEo6VfqhR820mdgKcTY
 HJbBQLbzJ2rIQRg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Replace HMP 'savevm' with QMP 'snapshot-save' job-based API.
Use _launch_qemu/_send_qemu_cmd for proper QMP interaction.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qemu-iotests/007 | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/tests/qemu-iotests/007 b/tests/qemu-iotests/007
index 936d3f14fbad..06096149ce83 100755
--- a/tests/qemu-iotests/007
+++ b/tests/qemu-iotests/007
@@ -29,6 +29,7 @@ status=1	# failure is the default!
 
 _cleanup()
 {
+	_cleanup_qemu
 	_cleanup_test_img
 	true
 }
@@ -37,6 +38,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
+. ./common.qemu
 
 # currently only qcow2 allows for consistency checks using qemu-img
 _supported_fmt qcow2
@@ -50,12 +52,23 @@ echo
 echo "creating image"
 _make_test_img 1M
 
-for ((i=1;i<=10;i++)); do
-    echo "savevm $i"
-    $QEMU -nographic -hda "$TEST_IMG" -serial none -monitor stdio >/dev/null 2>&1 <<EOF
-savevm test-$i
-quit
-EOF
+silent=yes
+for ((n=1;n<=10;n++)); do
+    echo "savevm $n"
+    _launch_qemu \
+        -drive if=none,id=drive0,node-name=disk0,file="$TEST_IMG",format="$IMGFMT" \
+        -device virtio-scsi,id=hba0 -device scsi-hd,drive=drive0
+    _send_qemu_cmd $QEMU_HANDLE \
+        "{ 'execute': 'qmp_capabilities' }" 'return'
+    _run_qmp_job $QEMU_HANDLE 'save' \
+        "{ 'execute': 'snapshot-save',
+           'arguments': { 'job-id': 'save',
+                          'tag': 'test-$n',
+                          'vmstate': 'disk0',
+                          'devices': ['disk0'] } }"
+    _send_qemu_cmd $QEMU_HANDLE \
+        "{ 'execute': 'quit' }" 'return'
+    _cleanup_qemu
 done
 
 echo

-- 
2.56.0.rc0.29.g47ce80527c56


