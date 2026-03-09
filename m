Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37D85F4180E
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 15:11:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzcFq-0002G4-42; Mon, 09 Mar 2026 11:10:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vzcFP-0001h1-CH
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:10:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vzcFH-0000KW-1l
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:10:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773069010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V9XxWeIBv2c1tdmnmag9Jzf/vBSh0dtlPyj8GrQc20M=;
 b=Y93YJ+oGt7FvqQ8uoS8S8Te2lYowEqBIDDjxBRmDMuVpdBk/fQamcO1Vvg8p6xrFi4qeQc
 x/+K3iw4AGePiB94IUzMluAZ0n/sYpVMdRu0tsewwz6rdMYnTIDKAPN/PoIiIgQHiUSyqx
 porVhPMZZj9sCEXgGU3rKe+E1GFbpVU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-9s71jmydOhOo-wSGFQ_d-A-1; Mon, 09 Mar 2026 11:10:09 -0400
X-MC-Unique: 9s71jmydOhOo-wSGFQ_d-A-1
X-Mimecast-MFC-AGG-ID: 9s71jmydOhOo-wSGFQ_d-A_1773069008
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-48378df3469so81845605e9.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 08:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773069007; x=1773673807; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V9XxWeIBv2c1tdmnmag9Jzf/vBSh0dtlPyj8GrQc20M=;
 b=NMnwyVDbF6bjaYnjBgk4muAa144na2u/fIHBmkd47W95pWmgwP4Bm9s3Do/EeuMbSG
 4LRKMidCUOQAY7DmegR7OzPc8RPcfOEXYw5YjI+t90YdT39u5mm8mH1L1UcCOSTH/W10
 Mbg+4IV8aj9NO35Q/qWfpl3bpaxsolDM3D5dqTRc+0wIRpgqTBkwqaSwhkSFDuqs7MNh
 tjmS/8Tf6pwuAvLHlaNuk50cnvmpzwSxWjHI2DxhW10k2AUck5L7lDPMvTGmXjFTOT/w
 7xtVHsP7xvan8K2JhuOTGP4HTHyoiEG+1xypMr/E1WhpavIuShXNytPvxDMBPp2ocoiP
 A1IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773069007; x=1773673807;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=V9XxWeIBv2c1tdmnmag9Jzf/vBSh0dtlPyj8GrQc20M=;
 b=jfX3k/BDaouGZHDDCKszr0RGPtwj4VwX9P0WFWsbeYXDHirmf1ZG2l/x2GLAJdJfmS
 3AEtyDSi5rQP6o3iVnUT+evd81c6d8iNophJF2GhOHdM6kedV4//cvDnsI/BpplOfMS/
 0QsM3LqKd1F6JwaceITB/wkflRRr4PM+3qNbazbofsHkEotIBsV8fju0/VKXsDxQJoCv
 Eigz0m5w4Vi0lPljAlPaLasM3V+ifb1ggBNPWi4LFUPzEJ5D2fjtNm1HhUIkcTrEvhcR
 OxsiBScYtS8aH1wmBIDqcu1hj28/jERFfpYUBASqZkpvaLdsZdbc/B4bMoHZJMopfsgb
 7AgA==
X-Gm-Message-State: AOJu0Yy76+8cVvGxoSwzPRTL6y2iyLASWaik8lobf8PGzPyzO5tYlvxk
 KDbdI/wL8b2BP1X0+XQXfAb9kqwWdKZr+1s/1eS55xvpcmyEsBOgbLgAy62PrqvPt1CR/eNmvE8
 Z+6OI1oSYoC0U5WknosgRlpUedqd/Dcn/7aR4ph9WTecmy9fWb1h0iiqfEdsUJP0K
X-Gm-Gg: ATEYQzz0mwiLNtO4CEWzBU+RbcDwuNLZcgorSKZ5vCQgh+BkIl00XskNh9aIs3Llla1
 n9JQkXlyH/01hpqvuzZx7F6hSZE28umn+vgGqqllPhDL/GvQW/b/FoVqUQ2Eva/W97rZJ0SBXzQ
 bZ9zGQXhic81gfoYIzyJLCjgszKl9j1uBySx1vGxldTlcJxQVxOqpOsWwAjnyjLxjiDaHXnwcFT
 ycirCBu3SwEzRUxDDlFzMR53u+hHrWADzcupCrx2NNsJadTde7FX+AthoOVU4mdJxD6Px/LeIM8
 sbaukssH+05wCcMmCGzOLoWKxdoVDtvzInJYOV7Yy7AmWAdpilC3Vo0GJZOKYgNYyliX8AtL/Hq
 V8lVz7m0u9JqY0+G3WsxdeRsUUTBqzJ5/dAYrw09psjYYdVX45wJHixRgCDUtHJZfutwro3zdgt
 eFawDa
X-Received: by 2002:a05:600c:64c7:b0:47e:e59c:67c5 with SMTP id
 5b1f17b1804b1-4852671d9c3mr179495695e9.8.1773069007468; 
 Mon, 09 Mar 2026 08:10:07 -0700 (PDT)
X-Received: by 2002:a05:600c:64c7:b0:47e:e59c:67c5 with SMTP id
 5b1f17b1804b1-4852671d9c3mr179495145e9.8.1773069006952; 
 Mon, 09 Mar 2026 08:10:06 -0700 (PDT)
Received: from localhost
 (p200300cfd737d0cf29d515fbd6051d53.dip0.t-ipconnect.de.
 [2003:cf:d737:d0cf:29d5:15fb:d605:1d53])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4853588758fsm75122675e9.4.2026.03.09.08.10.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 08:10:06 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: [PATCH v5 25/25] iotests/308: Add multi-threading sanity test
Date: Mon,  9 Mar 2026 16:08:56 +0100
Message-ID: <20260309150856.26800-26-hreitz@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309150856.26800-1-hreitz@redhat.com>
References: <20260309150856.26800-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


