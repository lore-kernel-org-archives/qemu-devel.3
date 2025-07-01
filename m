Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07D9EC8302F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 11:47:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWZRu-0006qA-1A; Tue, 01 Jul 2025 07:46:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uWZR3-0005m0-9Y
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 07:46:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uWZQu-0003fJ-92
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 07:45:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751370350;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wmi5I5WHYt2gr3ayuHReWJBs0mW0tBonN0/WuhY6EsA=;
 b=SyXhT8BW/5ZiNALaCGkuCc7gP5XpWIiERs4TLUU8Fmls+xmWjD3kNK8GQCtgoRytP9JgDX
 AD39A3lst4J8uXmDqoelOBBYWtwIXxw5qciI6ZV++RKpcYbUfjeFv4dddXuyqg4IfjDZuE
 nRAtBPdogvRL2biUA8QWfTQiPIVEsrU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-AByYE_STNyCoIaApVAB5Pg-1; Tue, 01 Jul 2025 07:45:49 -0400
X-MC-Unique: AByYE_STNyCoIaApVAB5Pg-1
X-Mimecast-MFC-AGG-ID: AByYE_STNyCoIaApVAB5Pg_1751370348
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-451dda846a0so21553825e9.2
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 04:45:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751370348; x=1751975148;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wmi5I5WHYt2gr3ayuHReWJBs0mW0tBonN0/WuhY6EsA=;
 b=s7cQd3T9Hn4YoTtcDVrQzloPTSVMFijrSKkEmAoZm13pUq2sEIZWZArxzYmCXBC4e0
 AOqH77L2O3jEY7CIr1/TVWkq9mJORC813Tki0aqBq0KjFwsW68BbBSZSDe/C+NXLiMZI
 sLrZGy4QfC/JVFUuIWCCWPtfRE/qTiQ+9/bjqn8Oo6+9keqWVoWqPo6i8YEPKh/VccKO
 IUln393kmSOA7m6Hg4DIUcoV8WafPhLnYk2D8IF91+gcL/YzqyZxHUS61jAC4FEZy0WH
 PkAVMrS/mvYXbeT+W7wwahGGlovCFD20W5OG+nQFuSFPYc/OAlU2krGpET41vcggiF3Z
 Jaiw==
X-Gm-Message-State: AOJu0YyKZ1w8xOR6WphcpAAV2MJM9lwivSzjJ5M+1BlovnApXNz/IEao
 k+PBwEnscCcNSQ1IUfChE2DkLMG8RVgStOEYkL4+5pRgGoblfBJr63BGEMERAkhR+kH+3sp9M8W
 o/WDanBieIRzetH5e2whAvWZXpbrlFXgyYkbNYvFE4SbkktYbhB6kJ+Hw
X-Gm-Gg: ASbGncsqfwKbTSE7verK+8lVv+1MnwMRhci9QkQzOQjOQB1EaVmo72pNbqJ4SVZQdCq
 JvDCGIv9i3HOtk27o8ULWdzUAydaJPFZ58BPgZje/zaRYgEMFcQrpdtOZ2ABYMVzIKOlNc0lie9
 7tlccvWSU0/KcGSlgBnuRWsCwj5TasO8gfEhxKsR80i4+pjUyNZVYPhhkrxkcon1JB6U4zJxD9G
 rfwvr/VjkU3mSsWBSWyj7z6xSL3n2un0SphMvcGHgIAKNqkuoXn37RUbbjhUYyVcoWeK8m/p4S3
 enfSmoqM8iwZQDShnNKdCR6s/gSphlzPsqMJngJPzIMqJBFNDPUfBQzI+4W9ptEkdIGUwMiezhB
 jXB7/
X-Received: by 2002:a05:600c:3b0a:b0:453:9bf:6f7c with SMTP id
 5b1f17b1804b1-4538ee5d0b8mr188520015e9.9.1751370348279; 
 Tue, 01 Jul 2025 04:45:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHT+GObbK6oNCknbIHIqRpvMqUDBTM25FlbyxEDP54tbNEMOOgubqChNq1ebJqXelLH5Zx1Ew==
X-Received: by 2002:a05:600c:3b0a:b0:453:9bf:6f7c with SMTP id
 5b1f17b1804b1-4538ee5d0b8mr188519695e9.9.1751370347798; 
 Tue, 01 Jul 2025 04:45:47 -0700 (PDT)
Received: from localhost
 (p200300cfd700f38d3df6a1ca7d40fe1f.dip0.t-ipconnect.de.
 [2003:cf:d700:f38d:3df6:a1ca:7d40:fe1f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453a1914d10sm53734025e9.4.2025.07.01.04.45.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 04:45:45 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: [PATCH v3 20/21] iotests/308: Add multi-threading sanity test
Date: Tue,  1 Jul 2025 13:44:36 +0200
Message-ID: <20250701114437.207419-21-hreitz@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250701114437.207419-1-hreitz@redhat.com>
References: <20250701114437.207419-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Run qemu-img bench on a simple multi-threaded FUSE export to test that
it works.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 tests/qemu-iotests/308     | 51 ++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/308.out | 56 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 107 insertions(+)

diff --git a/tests/qemu-iotests/308 b/tests/qemu-iotests/308
index 033d5cbe22..2960412285 100755
--- a/tests/qemu-iotests/308
+++ b/tests/qemu-iotests/308
@@ -415,6 +415,57 @@ $QEMU_IO -c 'read -P 0 0 64M' "$TEST_IMG" | _filter_qemu_io
 
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
index 2d7a38d63d..04e6913c5c 100644
--- a/tests/qemu-iotests/308.out
+++ b/tests/qemu-iotests/308.out
@@ -207,4 +207,60 @@ read 67108864/67108864 bytes at offset 0
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
2.49.0


