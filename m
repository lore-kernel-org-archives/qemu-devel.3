Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A293C98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:27:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x972T-0001Nn-Eg; Tue, 22 Sep 2026 16:24:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x971V-00062c-3e
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:23:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x971T-0000PK-21
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:23:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mfbMgMV4azljAgltI1vhifC9l9nHWI+d3UI2pmdhqXs=;
 b=TcQv6RifeRafdwQN3IV5jDhNLHvIP0N2GinGDYDwaAR3/Au4RCFtSbSU13mYyvUVqcpimV
 B1o0vP7R3BTBPqxcsin+8M8TQJGXWqjdayIiaFhVyN4Kt2Oqf8KRZqpAepWPJ5geWA1GKJ
 qiPEaKUsYtahEipuxJEcL50eek/2tU0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-468-nr1abh7ON_KpI4rRfXCtMw-1; Tue,
 22 Sep 2026 16:23:24 -0400
X-MC-Unique: nr1abh7ON_KpI4rRfXCtMw-1
X-Mimecast-MFC-AGG-ID: nr1abh7ON_KpI4rRfXCtMw_1790108604
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 032BF195FCF9; Tue, 22 Sep 2026 20:23:24 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F39C01800446; Tue, 22 Sep 2026 20:23:22 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:18:18 +0400
Subject: [PATCH 71/88] qemu-iotests/274: migrate away from HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-71-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=2900;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=rzHiNLUbPaKLIpJuXfTIUWXUNuL24MxzcF3PDJ25jUE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqsuKz0xasVDBeY9NXMkYBMTV8InNeR3pMQeejG
 UWTXKrCCe6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarLiswAKCRDa6OEJdZac
 5QZPD/9wMJsMSCQ4t0JZKMb+3WxVDcvBsG0NjZAfBKdzEYzbTprIxtoTNvSBFYi+/Y9/mu4Ukqc
 MQNfn9J5Xh4QKGCwVqxyOOj0BpnS6t+QKx49pK5haJWQ8dWoHj9qGiHkYQoymlgj+QoLQPjODrL
 A2cPpaZxVD+x7yald+y2ckhg7dpx/1YTE/upOCQR1sjUj4UCUvAvR6AEXihZrMGXnqOjlwy6L10
 kkLVlMrszBEoWxykeAYOhjnXX1PxETqLzCwfiekuOEChRDWV4Z8o6ZErU9W3945X6ZB68U6RrR6
 DQugavRpquTpZdzRCg4F1eR+m1uw2bmDeBEnuta+FMHWzPN87vm+sQ7MfEOsq8LvJZN2wEO/sZE
 K2ZRuIIFCputexPfiMjIGKJrx76tK90sk3zizPDgnD0ggI87AZcxBScgvp4nxl/pHe3OYTOgCVe
 iY9AZ8gQyuuw2RD/AY5hTdZ5kEtQpVzkKC7+CkiozAySOxij4PD5zdTxgB1rccHHu9+sVmBFICh
 4lp1C1fnWF0JKtiUEiwl1P2kRG1f9MjAsNL569kXhMDmlFLQLI0XXMMwFS2egxOd33BDyDY1D6K
 +NTa5v8YpaPLThGgN2oKY1J1gBjcl22bvIhbbTNYi221M6UWm9vJQkUhvsEr19zz6GgtW9eBmjx
 8BOhcSXeNx31QGw==
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

Drop the quite redundant HMP code path.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qemu-iotests/274     | 14 +-------------
 tests/qemu-iotests/274.out | 26 --------------------------
 2 files changed, 1 insertion(+), 39 deletions(-)

diff --git a/tests/qemu-iotests/274 b/tests/qemu-iotests/274
index d91c11c70d2e..917982ec63bf 100755
--- a/tests/qemu-iotests/274
+++ b/tests/qemu-iotests/274
@@ -24,8 +24,7 @@ import iotests
 
 iotests.script_initialize(supported_fmts=['qcow2'],
                           supported_platforms=['linux'],
-                          unsupported_imgopts=['refcount_bits', 'compat'],
-                          require_hmp=True)
+                          unsupported_imgopts=['refcount_bits', 'compat'])
 
 size_short = 1 * 1024 * 1024
 size_long = 2 * 1024 * 1024
@@ -93,17 +92,6 @@ with iotests.FilePath('base') as base, \
     iotests.qemu_io_log('-c', 'read -P 1 0 %d' % size_short, mid)
     iotests.qemu_io_log('-c', 'read -P 0 %d %d' % (size_short, size_diff), mid)
 
-    iotests.log('=== Testing HMP commit (top -> mid) ===')
-
-    create_chain()
-    with create_vm() as vm:
-        vm.launch()
-        vm.qmp_log('human-monitor-command', command_line='commit drive0')
-
-    iotests.img_info_log(mid)
-    iotests.qemu_io_log('-c', 'read -P 1 0 %d' % size_short, mid)
-    iotests.qemu_io_log('-c', 'read -P 0 %d %d' % (size_short, size_diff), mid)
-
     iotests.log('=== Testing QMP active commit (top -> mid) ===')
 
     create_chain()
diff --git a/tests/qemu-iotests/274.out b/tests/qemu-iotests/274.out
index c2967335ca09..ef1d2d993c9f 100644
--- a/tests/qemu-iotests/274.out
+++ b/tests/qemu-iotests/274.out
@@ -59,32 +59,6 @@ read 1048576/1048576 bytes at offset 0
 read 1048576/1048576 bytes at offset 1048576
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
-=== Testing HMP commit (top -> mid) ===
-wrote 2097152/2097152 bytes at offset 0
-2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-
-{"execute": "human-monitor-command", "arguments": {"command-line": "commit drive0"}}
-{"return": ""}
-image: TEST_IMG
-file format: IMGFMT
-virtual size: 2 MiB (2097152 bytes)
-cluster_size: 65536
-backing file: TEST_DIR/PID-base
-backing file format: IMGFMT
-Format specific information:
-    compat: 1.1
-    compression type: COMPRESSION_TYPE
-    lazy refcounts: false
-    refcount bits: 16
-    corrupt: false
-    extended l2: false
-
-read 1048576/1048576 bytes at offset 0
-1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-
-read 1048576/1048576 bytes at offset 1048576
-1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-
 === Testing QMP active commit (top -> mid) ===
 wrote 2097152/2097152 bytes at offset 0
 2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)

-- 
2.56.0.rc0.29.g47ce80527c56


