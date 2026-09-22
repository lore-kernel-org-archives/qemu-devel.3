Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AA55C98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:29:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x971h-0007JY-7I; Tue, 22 Sep 2026 16:23:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x970x-0002ve-7d
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:22:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x970v-0000K9-OY
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:22:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108572;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mkdniCriR77U7hKX74lx3bmC7dS9jW3MaQ5Y3lghhlw=;
 b=CFQcQVJAiCBY1RWrxgyaOras1xadtjUV1aKFn8V9j8L6rOGHFBDqI6LGJZmXHOTJshFzVr
 INQgWSw7WjQgKx6FNSo+I5h68lKhuIpX+mrP0M1cbiq/zJ2NlxX2A/4imRlo0FMxOV2Tlw
 rLSEmoDScB1k7UIroMa+FLKqDDzw7sc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-194-sjUqAHZ1NnyQ9adafL2sow-1; Tue,
 22 Sep 2026 16:22:49 -0400
X-MC-Unique: sjUqAHZ1NnyQ9adafL2sow-1
X-Mimecast-MFC-AGG-ID: sjUqAHZ1NnyQ9adafL2sow_1790108568
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 66ABE18558A1; Tue, 22 Sep 2026 20:22:48 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 620671800446; Tue, 22 Sep 2026 20:22:47 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:18:08 +0400
Subject: [PATCH 61/88] qemu-iotests/091: migrate away from HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-61-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=2806;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=19WJCvs1BlLgwDnaaKhFfxknvjgxpYumnQuOjA12XsI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqsuKyAqBrYWDowmfnF4gExPKs5mkF4qdfBoIOa
 6eqLaPW5MSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarLisgAKCRDa6OEJdZac
 5WOVD/4wqmg+zf/jJ0EzUVzYzQpMTicm+zB68gAcjNTL1cC+rqFvoZ09aSzc4Y2ho8NJk+FEpeD
 cxYhieRxGPG0WgC0gICKdazCIOxOBNa1n3ooHQeh51d4khCigdclAIujcdLhQFQLfOxLTm+52ga
 7s8dYEdJpNIgOefL65NyUoLoiCJCK6VLk299ELgeIhgDQ+BdKN/WFGJFPcwFVLrCm2ZBQz4TCHJ
 Mg4x8/8xESOMBh62QWT4EpEoArR7Zh4SP1YMYCsZxNaLW+Cxzaz8CH3WJgg6VYIs98WbokGQA6k
 hPZT+QFKqwJw2QfLe5GcPxfsRtzOF2s+Cti3RBMzqvBp0T1RQenT9b4u+DIxy8/yuVIo5d9+2yx
 HLXuiSyrulW8q/UvtxNbQMVuhypKESmG3XsIoxviRa0Jk/xCxJ6isaUDwL6nXY88P8s84ZVki49
 MW8a96sHqtRKnOkzna8oqzJtl0HZ9S4aYUAN1kP7Bt/KzKm/pbszTaRVOoq7RbEtDByUeXajqT5
 XfRIhUb/7S8kPmduH64W6bvDijAcoYyLqm45ns6H+kev7aJHOJMkHutfu9E5XFC49jeIrqhe2rN
 5Pdms0cnVLEZ3g3N5kCPd+R5Cml+H9HpBExTzurjcxHSVtXxyV7MQKv1HuM1Jovrm1dyTiZAXyB
 E9LMyypW0lVIlag==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qemu-iotests/091 | 45 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 35 insertions(+), 10 deletions(-)

diff --git a/tests/qemu-iotests/091 b/tests/qemu-iotests/091
index 626203d6fc93..d777f94e00e9 100755
--- a/tests/qemu-iotests/091
+++ b/tests/qemu-iotests/091
@@ -48,7 +48,6 @@ _supported_fmt qcow2
 _supported_proto file fuse
 _supported_os Linux
 _supported_cache_modes writethrough none writeback
-_require_hmp
 _default_cache_mode none writeback
 
 size=1G
@@ -61,7 +60,6 @@ echo
 echo === Starting QEMU VM1 ===
 echo
 
-qemu_comm_method="monitor"
 _launch_qemu -drive file="${TEST_IMG}",cache=${CACHEMODE},aio=${AIOMODE},id=disk
 h1=$QEMU_HANDLE
 
@@ -77,26 +75,53 @@ echo === VM 1: Migrate from VM1 to VM2  ===
 echo
 
 silent=yes
-_send_qemu_cmd $h1 'qemu-io disk "write -P 0x22 0 4M"' "(qemu)"
+_send_qemu_cmd $h1 \
+    "{ 'execute': 'qmp_capabilities' }" \
+    'return'
+_send_qemu_cmd $h2 \
+    "{ 'execute': 'qmp_capabilities' }" \
+    'return'
+
+_send_qemu_cmd $h1 \
+    "{ 'execute': 'x-qemu-io',
+       'arguments': { 'device': 'disk', 'command': 'write -P 0x22 0 4M' } }" \
+    'return'
 echo "vm1: qemu-io disk write complete"
-_send_qemu_cmd $h1 "migrate \"exec: cat > '${MIG_FIFO}'\"" "(qemu)"
+_send_qemu_cmd $h1 \
+    "{ 'execute': 'migrate',
+       'arguments': { 'uri': 'exec:cat > ${MIG_FIFO}' } }" \
+    'return'
 echo "vm1: live migration started"
-qemu_cmd_repeat=20 _send_qemu_cmd $h1 "info migrate" "completed"
+qemu_cmd_repeat=20 _send_qemu_cmd $h1 \
+    "{ 'execute': 'query-migrate' }" \
+    '"status": "completed"'
 echo "vm1: live migration completed"
 
 echo
 echo === VM 2: Post-migration, write to disk, verify running ===
 echo
 
-_send_qemu_cmd $h2 'qemu-io disk "write 4M 1M"' "(qemu)"
+_send_qemu_cmd $h2 \
+    "{ 'execute': 'x-qemu-io',
+       'arguments': { 'device': 'disk', 'command': 'write 4M 1M' } }" \
+    'return'
 echo "vm2: qemu-io disk write complete"
-qemu_cmd_repeat=20 _send_qemu_cmd $h2 "info status" "running"
+qemu_cmd_repeat=20 _send_qemu_cmd $h2 \
+    "{ 'execute': 'query-status' }" \
+    '"status": "running"'
 echo "vm2: qemu process running successfully"
 
 echo "vm2: flush io, and quit"
-_send_qemu_cmd $h2 'qemu-io disk flush' "(qemu)"
-_send_qemu_cmd $h2 'quit' ""
-_send_qemu_cmd $h1 'quit' ""
+_send_qemu_cmd $h2 \
+    "{ 'execute': 'x-qemu-io',
+       'arguments': { 'device': 'disk', 'command': 'flush' } }" \
+    'return'
+_send_qemu_cmd $h2 \
+    "{ 'execute': 'quit' }" \
+    'return'
+_send_qemu_cmd $h1 \
+    "{ 'execute': 'quit' }" \
+    'return'
 
 wait=yes _cleanup_qemu >/dev/null
 

-- 
2.56.0.rc0.29.g47ce80527c56


