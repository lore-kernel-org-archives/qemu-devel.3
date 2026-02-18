Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06FD4E9A02C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 13:34:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vshfl-0004Or-TD; Wed, 18 Feb 2026 08:32:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vshfi-0004IY-Gg
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 08:32:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vshfg-0006FD-Pl
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 08:32:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771421572;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V9XxWeIBv2c1tdmnmag9Jzf/vBSh0dtlPyj8GrQc20M=;
 b=MptuV2QkR/JnP5YfGsLv/5V4AElPD/GGJvGeXP9D5UBnKK3AALM1Iakg+MZswK+xBo6guc
 WvzuqCQb6CSnZuR/xfGHJ7d0rGa+16pdL20pd5BcPyqH0EDRq0Mw1aq0gTuul8vubilhbP
 Fqh6wX8n3nlCYegziq2k2g/F21X8AbM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-UZEsV54wMe-N1uNB_beKNA-1; Wed, 18 Feb 2026 08:27:45 -0500
X-MC-Unique: UZEsV54wMe-N1uNB_beKNA-1
X-Mimecast-MFC-AGG-ID: UZEsV54wMe-N1uNB_beKNA_1771421264
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-4376ecafb7fso3352010f8f.2
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 05:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771421264; x=1772026064; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V9XxWeIBv2c1tdmnmag9Jzf/vBSh0dtlPyj8GrQc20M=;
 b=FUHAJtutqMyqNDBEnE+UdP88BMDRukkR7ZC7dDnXssZnVVVenqfnld0EIdQbxTL9kE
 uPPzkvgl5DexmX2a89/+/MUiONQldLtDsYVKSwsU+NZjbWVxAWodfSZQBjf7l48CZpYZ
 hLtp7QN/OxYmedXnv0/iWUok9qt96bEPYpDxCsa87s2Ahz8/36CQRbrFgceH5mT26V9J
 RQs86JMpCqEhCE5dhZG3yJcu5ZI0GRrsTSkXYmsz8uqr0IqjTL9RFhBBtOgGTkpucWtS
 BBTC/NFSx3YpKgygkDRHdGssjOA6lMxRSQnxtBo1BwZA9hStKFO6nx6LXZfIeS5c9qp7
 LoxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771421264; x=1772026064;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=V9XxWeIBv2c1tdmnmag9Jzf/vBSh0dtlPyj8GrQc20M=;
 b=bIAhNZRF7BOLXIQG0SNohkfj+qRs5toRW40MVGVhGAfzvEoR+ksneO3mHEyqVTI8xM
 LO/QIuzzWa267eYpYE6ICQYQs4YcJyfpcwtHE4JtqIYIWMiddAX2tj6GXYK5RC/DGvba
 SE++MM4a4Yb+pfmhoL6ypKmWPHeJDVca5JCasQenXza7z4Dx4a9ZbRacHBN3yS679hGz
 GpFxqa3S8LSHlflMyk62aRc8aPa6N7ddnSngreogpj18lA7rq7dQw5ObpY0MT9tqlC1J
 kO3CP+UomRbe9WV6JsSQbwBQ+D2O+rLc7aLjpDgg9Jv6LPCc0WEiSt2U7cGT/3ho6kci
 TtBw==
X-Gm-Message-State: AOJu0Ywa+oo77N3RDC1B+ruQFjVG+2SmX8lIgS52I9KSGkNqxawTfH7v
 b8ZC2L1RJjI+tAsDg79X20r2jCIFoghQP2V+ZHr3yHLPZWhOaajDVwioe0myq2WlI8okzC0GGti
 g/nbdIXpkxsHXxJTCWFQotyt+W5rxfKs7dEY7u9/ANZlF3ahdLty5Uhly
X-Gm-Gg: AZuq6aJWb2qcgdo04yDomEymcsD0vyoNCwzyXg7/8oIVosWW5Ck+Oz13opO9SpneL5F
 I1KFpyW17Pn/D6aeRcDf3S3j0UaCsrSjSBeA01EicNuff7tO+BW3i8C3ztJ7ToK+QM4v6vwEbcq
 0QF5rHtvjX6tQk5pxR0f6CTvBsF5oC7LfVuJRecNog47lXqrCjhTJfgU6DkHGL+DoKX4vcTDVaS
 +z8zxM3+H0qXI4bcUKqO5zosDUiiZuDzV0O0ARb25PXWUs57atHX93PRRetYUX3oJeMUjUAT/BB
 lVB6K79bQyVD0zEStyQeprY9G7FyTMI09OQNglaL2268L9OaNz9OkCpEp/y67vc07g1b/rKK83D
 NU79VdYmTNn2m/psZRqoe4ef/FIMGzUX1fVLiGj1Q4TENfqi1RVR2jcd+3ssZEF53IqY4g0SBE6
 Y3X0eN
X-Received: by 2002:a5d:5f82:0:b0:437:6aca:d1c6 with SMTP id
 ffacd0b85a97d-43958e3bed1mr3347703f8f.33.1771421263921; 
 Wed, 18 Feb 2026 05:27:43 -0800 (PST)
X-Received: by 2002:a5d:5f82:0:b0:437:6aca:d1c6 with SMTP id
 ffacd0b85a97d-43958e3bed1mr3347644f8f.33.1771421263180; 
 Wed, 18 Feb 2026 05:27:43 -0800 (PST)
Received: from localhost
 (p200300cfd737d029edef7b8da7441ac2.dip0.t-ipconnect.de.
 [2003:cf:d737:d029:edef:7b8d:a744:1ac2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796acf5b9sm40227691f8f.34.2026.02.18.05.27.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 05:27:42 -0800 (PST)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: [PATCH v4 24/24] iotests/308: Add multi-threading sanity test
Date: Wed, 18 Feb 2026 14:26:33 +0100
Message-ID: <20260218132633.29748-25-hreitz@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260218132633.29748-1-hreitz@redhat.com>
References: <20260218132633.29748-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Run qemu-img bench on a simple multi-threaded FUSE export to test that
it works.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 tests/qemu-iotests/308     | 51 ++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/308.out | 56 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 107 insertions(+)

diff --git a/tests/qemu-iotests/308 b/tests/qemu-iotests/308
index a83c6fc01f..f4a06a522e 100755
--- a/tests/qemu-iotests/308
+++ b/tests/qemu-iotests/308
@@ -441,6 +441,57 @@ $QEMU_IO -c 'read -P 0 0 64M' "$TEST_IMG" | _filter_qemu_io
 
 _cleanup_test_img
 
+echo
+echo '=== Multi-threading ==='
+
+# Just set up a null block device, export it (with multi-threading), and run
+# qemu-img bench on it (to get parallel requests)
+
+_launch_qemu
+_send_qemu_cmd $QEMU_HANDLE \
+    "{'execute': 'qmp_capabilities'}" \
+    'return'
+
+_send_qemu_cmd $QEMU_HANDLE \
+    "{'execute': 'blockdev-add',
+      'arguments': {
+          'driver': 'null-co',
+          'node-name': 'null'
+      } }" \
+    'return'
+
+for id in iothread{0,1,2,3}; do
+    _send_qemu_cmd $QEMU_HANDLE \
+        "{'execute': 'object-add',
+          'arguments': {
+              'qom-type': 'iothread',
+              'id': '$id'
+          } }" \
+        'return'
+done
+
+echo
+
+iothreads="['iothread0', 'iothread1', 'iothread2', 'iothread3']"
+fuse_export_add \
+    'export' \
+    "'mountpoint': '$EXT_MP', 'iothread': $iothreads" \
+    'return' \
+    'null'
+
+echo
+$QEMU_IMG bench -f raw "$EXT_MP" |
+    sed -e 's/[0-9.]\+ seconds/X.XXX seconds/'
+echo
+
+fuse_export_del 'export'
+
+_send_qemu_cmd $QEMU_HANDLE \
+    "{'execute': 'quit'}" \
+    'return'
+
+wait=yes _cleanup_qemu
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/308.out b/tests/qemu-iotests/308.out
index ebeaf64b48..580cc94e92 100644
--- a/tests/qemu-iotests/308.out
+++ b/tests/qemu-iotests/308.out
@@ -217,4 +217,60 @@ read 67108864/67108864 bytes at offset 0
 {"return": {}}
 read 67108864/67108864 bytes at offset 0
 64 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=== Multi-threading ===
+{'execute': 'qmp_capabilities'}
+{"return": {}}
+{'execute': 'blockdev-add',
+      'arguments': {
+          'driver': 'null-co',
+          'node-name': 'null'
+      } }
+{"return": {}}
+{'execute': 'object-add',
+          'arguments': {
+              'qom-type': 'iothread',
+              'id': 'iothread0'
+          } }
+{"return": {}}
+{'execute': 'object-add',
+          'arguments': {
+              'qom-type': 'iothread',
+              'id': 'iothread1'
+          } }
+{"return": {}}
+{'execute': 'object-add',
+          'arguments': {
+              'qom-type': 'iothread',
+              'id': 'iothread2'
+          } }
+{"return": {}}
+{'execute': 'object-add',
+          'arguments': {
+              'qom-type': 'iothread',
+              'id': 'iothread3'
+          } }
+{"return": {}}
+
+{'execute': 'block-export-add',
+          'arguments': {
+              'type': 'fuse',
+              'id': 'export',
+              'node-name': 'null',
+              'mountpoint': 'TEST_DIR/t.IMGFMT.fuse', 'iothread': ['iothread0', 'iothread1', 'iothread2', 'iothread3']
+          } }
+{"return": {}}
+
+Sending 75000 read requests, 4096 bytes each, 64 in parallel (starting at offset 0, step size 4096)
+Run completed in X.XXX seconds.
+
+{'execute': 'block-export-del',
+          'arguments': {
+              'id': 'export'
+          } }
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_EXPORT_DELETED", "data": {"id": "export"}}
+{'execute': 'quit'}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 *** done
-- 
2.53.0


