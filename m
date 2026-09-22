Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8927EC982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:30:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x972R-0001KM-5V; Tue, 22 Sep 2026 16:24:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x971Q-0005f7-Rt
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:23:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x971O-0000Ob-Qv
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:23:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108602;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qN/aB0TU2Y4wIbghtKuvYsoO89RsxCzfr+5AjzyyZb0=;
 b=VqCj60cnneOqZoQQJzNBHlosdtYnu67fb2O4MrJOzX7ul4eKsOptM32drHzfMIaO7TdaB3
 FNJZeuxMP6jiKhZfCNepgTBODIZ8BZKWAUYZjzGh8vTTauEnI8NTf/30fy55ztwU2eTdIp
 c8iZjryQT14ewd21r/vOHI0UM7cq818=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-GMxoCDGyNumYsU-IiDmxrA-1; Tue,
 22 Sep 2026 16:23:17 -0400
X-MC-Unique: GMxoCDGyNumYsU-IiDmxrA-1
X-Mimecast-MFC-AGG-ID: GMxoCDGyNumYsU-IiDmxrA_1790108596
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C3BA6185BE98; Tue, 22 Sep 2026 20:23:16 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C50F0180057E; Tue, 22 Sep 2026 20:23:15 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:18:16 +0400
Subject: [PATCH 69/88] qemu-iotests/185: migrate away from HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-69-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=3039;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=7mJorKSl6IzOhE89QpcBPtTlZ5VdE05yu5pSZ8fKPGw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqsuKzNKeLz6M/uWMDyYsk8LgTiviJRMaBtRJLP
 XMX9QydvLuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarLiswAKCRDa6OEJdZac
 5VflD/9lpy9qiX1oDOwOITcqiASKiC29XfE14QrdCHk0UEBoBb6/eK3C9B8v4QQwjPShy9Mtsh0
 wyQpp2Qg4AbjABbRVbM6skotyFrm//ZIFza7Ju/J1FTrfyAhClVopjeFXFDDkr7bamOS+nr8WBM
 OGr7nwTdgBSJ3yhNVT3VUZXniCfNvONzNxyShyfuwaVw1Wx3BPsdOQABIG9rWLmVS1V8D9fTRl/
 PyasTau69OpWrs+ir8KtW8EMv4TLvtsiC6hu4Fk05598/w7m5KTrJZvj25g89MplqbW+o+MBnFL
 Dh5Y/vCG/1N5bRnP1uacNMkijWYH9Ru4QyOeXgplMqjk6fJbSlP1IUK8RDr3I09eqSTgsfWRdoa
 ukHDgAh6Ubjbpj8lSlZme+pDAchyzUauPZDIad1Q7eEGIL0DwGsrAOTQKlqp/GClIUbVoCXnWvh
 MB0xQLaw9I3CgaCh2a7lVEbLzvixCDWSvi3irbeex/Y8Mn/a5iu0565FxCqvKE0TG9fXAaznuLJ
 JLLY64/RdfAlorIz2omLdtDH948cilYGzomwEMuA41Ah3XwopoZEE37MPKG347QZrhooRUf3znA
 6J8uDAEBv850KWnGkZoxBz2btuBjKUUhw4bH2UbJ5ZUtTE4Rf3QKXJ+RJCzrOYKiWtlgs2ZKLOV
 DXdce6aDD5J2Hfw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qemu-iotests/185     | 15 ++++++---------
 tests/qemu-iotests/185.out | 10 ++++------
 2 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/tests/qemu-iotests/185 b/tests/qemu-iotests/185
index bb577a9cc999..c43d579676eb 100755
--- a/tests/qemu-iotests/185
+++ b/tests/qemu-iotests/185
@@ -50,7 +50,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt qcow2
 _supported_proto file
 _supported_os Linux
-_require_hmp
 _flaky_test https://gitlab.com/qemu-project/qemu/-/issues/3270
 
 size=$((64 * 1048576))
@@ -80,9 +79,9 @@ _send_qemu_cmd $h \
     "return"
 
 _send_qemu_cmd $h \
-    "{ 'execute': 'human-monitor-command',
-       'arguments': { 'command-line':
-                      'qemu-io disk \"write 0 4M\"' } }" \
+    "{ 'execute': 'x-qemu-io',
+       'arguments': { 'device': 'disk',
+                      'command': 'write 0 4M' } }" \
     "return"
 
 _send_qemu_cmd $h \
@@ -307,15 +306,13 @@ wait_for_job_and_quit() {
     echo '--- Writing data to the virtio-blk device ---'
 
     for ofs in $(seq 0 $step $((size - step))); do
-        qemu_io_cmd="qemu-io -d vblk/virtio-backend "
-        qemu_io_cmd+="\\\"aio_write $ofs $cluster_size\\\""
-
         # Do not include these requests in the reference output
         # (it's just too much)
         silent=yes _send_qemu_cmd $h \
-            "{\"execute\": \"human-monitor-command\",
+            "{\"execute\": \"x-qemu-io\",
               \"arguments\": {
-                  \"command-line\": \"$qemu_io_cmd\"
+                  \"qdev\": \"vblk/virtio-backend\",
+                  \"command\": \"aio_write $ofs $cluster_size\"
               }}" \
             'return'
     done
diff --git a/tests/qemu-iotests/185.out b/tests/qemu-iotests/185.out
index 6af0953c4d68..d05f359080b9 100644
--- a/tests/qemu-iotests/185.out
+++ b/tests/qemu-iotests/185.out
@@ -15,12 +15,10 @@ Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=67108864
                       'mode': 'absolute-paths' } }
 Formatting 'TEST_DIR/t.qcow2.mid', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=67108864 backing_file=TEST_DIR/t.qcow2.base backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
 {"return": {}}
-{ 'execute': 'human-monitor-command',
-       'arguments': { 'command-line':
-                      'qemu-io disk "write 0 4M"' } }
-wrote 4194304/4194304 bytes at offset 0
-4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-{"return": ""}
+{ 'execute': 'x-qemu-io',
+       'arguments': { 'device': 'disk',
+                      'command': 'write 0 4M' } }
+{"return": {"human-readable-text": "wrote 4194304/4194304 bytes at offset 0\n4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)\n"}}
 { 'execute': 'blockdev-snapshot-sync',
        'arguments': { 'device': 'disk',
                       'snapshot-file': 'TEST_DIR/t.IMGFMT',

-- 
2.56.0.rc0.29.g47ce80527c56


