Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28937C98308
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:27:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9731-00032h-1x; Tue, 22 Sep 2026 16:25:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x971o-0008BJ-Rd
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:23:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x971m-0000Sb-Lm
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:23:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HHJc+T4KepJJr+in79W/PnOBVuFLMUlWcdlj1QiE4ak=;
 b=B4y6iQ9W0jKdhAIRd2wWMBiXKD8GVnlEywDKiXoht3DtbaSAtT9tetRJWpPziFKuMdBvh8
 BjLQP+qVc+XeZed2gqZykbUuY8vItbez1mOVyngYptNCABYHLjkrAYWA+SuaUKz+I5hz4h
 h+xorglLF3aSpSezV7Bmw68eFOYdLCs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-542-yYEeK8SJOxav7vPcPwsbDg-1; Tue,
 22 Sep 2026 16:23:42 -0400
X-MC-Unique: yYEeK8SJOxav7vPcPwsbDg-1
X-Mimecast-MFC-AGG-ID: yYEeK8SJOxav7vPcPwsbDg_1790108621
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B8FA618009C4; Tue, 22 Sep 2026 20:23:41 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EB3FC1800370; Tue, 22 Sep 2026 20:23:40 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:18:23 +0400
Subject: [PATCH 76/88] qemu-iotests/157: migrate away from HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-76-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=2854;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=TNLf3j3z/aF2QnIRb7Q32lRIcrKEmsdosTMxFMBLNsY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqsuKzGN+9HLRJSVYQ7f2Jv5RinrK6VSibcCutu
 gZRW+bKsXGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarLiswAKCRDa6OEJdZac
 5ZZXD/9VzfjY3kpKDwePwWFVdW2qB9X5wLS82fdPlnkdSIxbLtN1vf5CtixZRY/cqpZQPKh2jp9
 4NzBvCaUGF6SFBfRal67yTxVx5ppBaRknHt4dbmSZZNojcfGsBVkyX8K+Omev+C69sz1sAiYVLk
 oqCmjtie1SkY1ovWngJa+X0G7XNyeKIQPKuzsL3ywXe4GMTK6rsfvnssmZvx+aaMqubHZQUdXjV
 gSbi0zZ1BfgngFzmWlLVDaCh9zUIgT73ppi+8W9etW8WsMnUHPau3i05T/JXVFSTcriRW7DnXCU
 pwBXK75vmyxGnlx2a5pjYNIjKCQBSR9z7SO1qfgkWAxSllGNissO6kBNdN2IPMJQjVEtLZ8sI/3
 bpZwHLPuPyfu+CZqmaOmkpiS97wRuYTR/TAxzLOi055boNoCcbVtupzPqgkOiCf5uSkgsN2Yg5U
 JEGY+EG2eBjMi2h8Zj/IAZDQ5xt/QQdFsKFwNQYKgve2MF+ye5UegqFkuxNZUdF292cLZPmuFts
 MKzcfhdwu3H69mB7iqIMOIJgRJrY3FyQ+tf+N4sLj2LzOq/4h9rrWwF7xdJq4hCY2I4KdcSr966
 AdC9Sk6n/W4rKzwJk5YvOXssGlGxLDs3+4VXYuOcQ6OAXdZoOUUYHlDvu9zg0Ei7/9TlSHBj6oD
 Uv3IX30gY4CrPwQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Replace HMP "info block" with QMP "query-block". The expected
output changes from HMP "Cache mode: writeback/writethrough" to
QMP "writeback": true/false.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qemu-iotests/157     | 10 +++++-----
 tests/qemu-iotests/157.out | 16 ++++++++--------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/tests/qemu-iotests/157 b/tests/qemu-iotests/157
index 531dbd3122b1..2f9d73155a10 100755
--- a/tests/qemu-iotests/157
+++ b/tests/qemu-iotests/157
@@ -41,18 +41,18 @@ _supported_fmt generic
 _supported_proto file
 
 _require_devices virtio-blk
-_require_hmp
 
 do_run_qemu()
 {
     (
+        printf '%s\n' '{"execute":"qmp_capabilities"}'
         if ! test -t 0; then
             while read cmd; do
                 echo $cmd
             done
         fi
-        echo quit
-    ) | $QEMU -nodefaults -nographic -monitor stdio -serial none "$@"
+        printf '%s\n' '{"execute":"quit"}'
+    ) | $QEMU -nodefaults -nographic -qmp stdio -serial none "$@"
     echo
 }
 
@@ -89,10 +89,10 @@ echo
 for cache in "writeback" "writethrough"; do
     for wce in "" ",write-cache=auto" ",write-cache=on" ",write-cache=off"; do
         echo "Testing: cache='$cache' wce='$wce'"
-        echo "info block" \
+        echo '{"execute":"query-block"}' \
             | run_qemu $SYSEMU_EXTRA_ARGS -drive "$SYSEMU_DRIVE_ARG,cache=$cache" \
                        -device "virtio-blk,drive=none0$wce" \
-            | grep -e "Testing" -e "Cache mode"
+            | grep -o '"writeback": *[a-z]*'
     done
 done
 
diff --git a/tests/qemu-iotests/157.out b/tests/qemu-iotests/157.out
index fdc807f541f3..f6c345f143cc 100644
--- a/tests/qemu-iotests/157.out
+++ b/tests/qemu-iotests/157.out
@@ -4,19 +4,19 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
 === Setting WCE with qdev and with manually created BB ===
 
 Testing: cache='writeback' wce=''
-    Cache mode:       writeback
+"writeback": true
 Testing: cache='writeback' wce=',write-cache=auto'
-    Cache mode:       writeback
+"writeback": true
 Testing: cache='writeback' wce=',write-cache=on'
-    Cache mode:       writeback
+"writeback": true
 Testing: cache='writeback' wce=',write-cache=off'
-    Cache mode:       writethrough
+"writeback": false
 Testing: cache='writethrough' wce=''
-    Cache mode:       writethrough
+"writeback": false
 Testing: cache='writethrough' wce=',write-cache=auto'
-    Cache mode:       writethrough
+"writeback": false
 Testing: cache='writethrough' wce=',write-cache=on'
-    Cache mode:       writeback
+"writeback": true
 Testing: cache='writethrough' wce=',write-cache=off'
-    Cache mode:       writethrough
+"writeback": false
 *** done

-- 
2.56.0.rc0.29.g47ce80527c56


