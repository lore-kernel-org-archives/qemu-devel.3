Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5EF9C98304
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:30:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x971d-0006sY-IL; Tue, 22 Sep 2026 16:23:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x970r-0002v6-8q
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:22:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x970p-0000JS-KW
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:22:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108567;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3bDmFYUs/x08CWZsQUX0w/mf6oNg/SybCHy3tyzihKU=;
 b=N/D8Y8uCwcZyg9uzNN0VDMPuR0tZ8SBxd/i11c2pxtV+lmQV319T9GVf8Jr4zVjvoCUopG
 mIXDUAmG20IdtZWIXA+XfLYpNildqmSIqepp65py/tle8+EWzVp+vVEDTW6CmPFw3Mv6eW
 OAg6w1sCotlz6DjwUX2eJ/yboetsRZc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-54-R_fPO-OJM865VgXp7jNyVw-1; Tue,
 22 Sep 2026 16:22:45 -0400
X-MC-Unique: R_fPO-OJM865VgXp7jNyVw-1
X-Mimecast-MFC-AGG-ID: R_fPO-OJM865VgXp7jNyVw_1790108564
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 87FE319772EE; Tue, 22 Sep 2026 20:22:44 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7E8623000223; Tue, 22 Sep 2026 20:22:43 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:18:07 +0400
Subject: [PATCH 60/88] qemu-iotests/102: migrate away from HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-60-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=2706;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=3yUAha34BoNWc8nsQWp4lnPh9BerL6wj9EeguM5KeGk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqsuKyGyG06ta9BHUy0tNGk9XBr/Cg6BC375r5l
 4KeC93pvFGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarLisgAKCRDa6OEJdZac
 5YSEEACOxXFNAI9cNwKMhEGwslRF63ONsjL4W8AO7nWCD/0+EqoBJacRb9uyhCmg0lPX6C6kxcB
 fxaHYTQCIwCzIW+wWjJJY95JYr4qGXtaV7+vuLfoIvtk0HC5d1fiFi3tt+CGFCiScIYVjzjl1bR
 rsYs4QtjaRO0K1lNxbV7CUOYLigICVim/+TGvvBYi4Zl8kfEqj49DOYMNwoKzdHn52bzy5ni851
 q4JJTAKre6Onb5Kw9EiN8ZUN+35oLKfSHzdQ+dX3JDuZWwVhdK3/5l+n2zulLYzv9vwYPHsiZ6s
 6kMdF+ZUwBovxsdM2dRZkj60J7cEJ8vj7Aoxtpfr525IubWbsrcbDVAdYo0ipEACxZ1WIzs63UQ
 cB2xb95R6hhigpVj5YyJ9JtOyMAmjJ1+beINSKWavjUVJFxFeUCpEOR4zHX9ZtccFCy9smjJGuP
 WEkhHqCGx1kD0cvydXHmYVTXgLXrzagdm6jck4MaSjuDF27DTA9a1PQNi9pKpWMtvxs3uI4EqPj
 CTiwifmeEBxg6LD/JgnRP4JhSIpS8x8Vl4w3IEBs+TLFUhCkpiV9cNGSDhS5YPbFdHJUhH09J/H
 r8s4rrVEqlGdanPzuAPmrHRjWlpCfXGFJ8WOsOZzky5cY9nT7V5W7nqAIwu7//xHlINyw8sS+cH
 zFUpJmUgmBh8Hdg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

No need to substitute qemu-io command.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qemu-iotests/102     | 21 ++++++++++++++-------
 tests/qemu-iotests/102.out | 12 ++++++++----
 2 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/tests/qemu-iotests/102 b/tests/qemu-iotests/102
index 5db8180d3bb7..b70053eee302 100755
--- a/tests/qemu-iotests/102
+++ b/tests/qemu-iotests/102
@@ -41,7 +41,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt qcow2
 _supported_proto file fuse
-_require_hmp
 
 IMG_SIZE=64K
 
@@ -67,18 +66,26 @@ echo
 _make_test_img $IMG_SIZE
 $QEMU_IO -c 'write 0 64k' "$TEST_IMG" | _filter_qemu_io
 
-qemu_comm_method=monitor _launch_qemu -drive if=none,file="$TEST_IMG",id=drv0
+_launch_qemu -drive if=none,file="$TEST_IMG",id=drv0
 
-# Wait for a prompt to appear (so we know qemu has opened the image)
-_send_qemu_cmd $QEMU_HANDLE '' '(qemu)'
+_send_qemu_cmd $QEMU_HANDLE \
+    "{ 'execute': 'qmp_capabilities' }" \
+    'return'
 
 $QEMU_IMG resize --shrink --image-opts \
     "driver=raw,file.driver=file,file.filename=$TEST_IMG,file.locking=off" \
     $((5 * 64 * 1024))
 
-_send_qemu_cmd $QEMU_HANDLE 'qemu-io drv0 map' 'allocated' \
-    | sed -e 's/^(qemu).*qemu-io drv0 map...$/(qemu) qemu-io drv0 map/'
-_send_qemu_cmd $QEMU_HANDLE 'quit' ''
+_send_qemu_cmd $QEMU_HANDLE \
+    "{ 'execute': 'x-qemu-io',
+       'arguments': { 'device': 'drv0', 'command': 'map' } }" \
+    'return'
+
+_send_qemu_cmd $QEMU_HANDLE \
+    "{ 'execute': 'quit' }" \
+    'return'
+
+wait=1 _cleanup_qemu
 
 # success, all done
 echo '*** done'
diff --git a/tests/qemu-iotests/102.out b/tests/qemu-iotests/102.out
index 320ed5a52ba9..13dee5bdecd6 100644
--- a/tests/qemu-iotests/102.out
+++ b/tests/qemu-iotests/102.out
@@ -15,9 +15,13 @@ Offset          Length          File
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=65536
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu)
+{ 'execute': 'qmp_capabilities' }
+{"return": {}}
 Image resized.
-(qemu) qemu-io drv0 map
-64 KiB (0x10000) bytes     allocated at offset 0 bytes (0x0)
+{ 'execute': 'x-qemu-io',
+       'arguments': { 'device': 'drv0', 'command': 'map' } }
+{"return": {"human-readable-text": "64 KiB (0x10000) bytes     allocated at offset 0 bytes (0x0)\n"}}
+{ 'execute': 'quit' }
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 *** done

-- 
2.56.0.rc0.29.g47ce80527c56


