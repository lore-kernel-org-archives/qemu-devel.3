Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27B8EC5B549
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 13:32:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMoBv-0001Gn-DV; Wed, 04 Jun 2025 09:30:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uMoBX-0007tt-Oq
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 09:29:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uMoBW-0004td-7R
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 09:29:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749043776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UfHABRhEpJbzl+h+fF4eiSS2JzvgRNxvoo7U6hpnH8I=;
 b=IrQnrHwD8QZepKSMPLTZUgAOTKhccDlVdY785Lbj/xE8EN9ep6qCDyKRK+Eg7bBQLHTxeS
 fDwXiSHgFsFYvzbjVltUNZDC1jAtORVL8Sqrbu28+VPi8FFaG3gSIBvBXgSg8PindBOQWR
 UIljnfWUANev8ATvlQboBJno1iKBHH8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-zW96bo7DMs-ypcGPPhyZ2g-1; Wed, 04 Jun 2025 09:29:34 -0400
X-MC-Unique: zW96bo7DMs-ypcGPPhyZ2g-1
X-Mimecast-MFC-AGG-ID: zW96bo7DMs-ypcGPPhyZ2g_1749043773
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a523ce0bb2so245883f8f.0
 for <qemu-devel@nongnu.org>; Wed, 04 Jun 2025 06:29:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749043773; x=1749648573;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UfHABRhEpJbzl+h+fF4eiSS2JzvgRNxvoo7U6hpnH8I=;
 b=r8pps4ltRFPzVEpPUFVj2SL6jE7X1Vc8Dn/WjIYkitsHpgOtniPmfzgK0ARVBMLs1l
 zZKlS3szxaHVqzga+0VTFauU8oRSRFMz6ma7Q51nizurKFObYSzamyUonhyZsy2OUjGY
 lEb6qrMoElG/G7Gt8iRChCsjtnabzFwHJ/EjY753OSCH9pOoClbB9ykP2X0rKGFYV2++
 hzDbDLTmN0Sv95buq3aO1j/ulLF5cP12cfoq10en1+xsz8mhkEWSKTYbvxSVyfwIlnwT
 oiRVJZAz4KtCUYkl74BK0OLqtKIN19eEzcyADQkjaKsq+TThuScaw4TyrYCPVWFMXljF
 ZRLA==
X-Gm-Message-State: AOJu0YykZxnu6J6tqP5+qMxikHQz4/5ZAcwtOkdYfMWTl267SeOavcOx
 hlk4GkUVj9s65xk85q5ZrYDhc8Im6do9Ra7TOZ1qfHWeJbHZXneEGP6TmZppWHXL237/mnhbwFP
 xs+jHsX0FLGC9DePaMRRA4s9Sgp0XAe+BGtmCko/WG3dbBawRQyh3KMLR
X-Gm-Gg: ASbGncuA8bg6UMxWtYoD9OvHWoDRYB5lU4axuwZxcnn8yTI0BeLSyKLuekr2M600LF8
 4lsnMFxIMKe9vMBgm+b4QlPZP0eEtxAt1x+zwNe07ao94Upe+S9u3kRCYQ5zvc4ymfgBcHocJ3o
 8u4pgdtUxXA2cbZtnWyo2rwFE1H0fgPrB7KPwoyKUYJoerUTRaHOsH2C5siA/QDB3Cyx1RrAhnl
 7t/HgMjz2cl9/ymEeJN7E0rgDgIajtGdgKHQAtc4RX5G9bMMIlfa+Q19mQKXPboE4+BAGm2Bm4f
 qyhMTGg00A1h+teUfSGSCbP389KEQMlOLhX5Nh1G36JTKZaAqkG2uIEtduet7qzgKZo8qw==
X-Received: by 2002:a05:6000:2207:b0:3a4:f2ed:217e with SMTP id
 ffacd0b85a97d-3a51d9806e6mr2255124f8f.42.1749043772906; 
 Wed, 04 Jun 2025 06:29:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGszrO/jdkZKFcplGki235Sx92rigfNCiBCTAOXZqbzJ6yQrTe5KvcCJ6rJRjtMEvggLM1hSQ==
X-Received: by 2002:a05:6000:2207:b0:3a4:f2ed:217e with SMTP id
 ffacd0b85a97d-3a51d9806e6mr2255100f8f.42.1749043772474; 
 Wed, 04 Jun 2025 06:29:32 -0700 (PDT)
Received: from localhost
 (p200300cfd700f306503d3c798c1bf214.dip0.t-ipconnect.de.
 [2003:cf:d700:f306:503d:3c79:8c1b:f214])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a5236d4466sm1072300f8f.100.2025.06.04.06.29.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Jun 2025 06:29:30 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: [PATCH v2 20/21] iotests/308: Add multi-threading sanity test
Date: Wed,  4 Jun 2025 15:28:12 +0200
Message-ID: <20250604132813.359438-21-hreitz@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250604132813.359438-1-hreitz@redhat.com>
References: <20250604132813.359438-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


