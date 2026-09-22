Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4607DC98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:30:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x971S-0005nf-GD; Tue, 22 Sep 2026 16:23:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x970m-0002uu-0X
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:22:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x970k-0000It-EA
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:22:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108561;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iLmncJkTuaO8OiV1Z6WGTW7ToYzktVHhyIoIa0hQkTY=;
 b=L8k4kBKSQyRf5ySrtqL83Btn3BIfc1gpFOWmke/V07IRtrUARZSzOhdPfkuNJE1DspLvOP
 KpkwzmWkX8IEXxV14VKapgJYBtoynWlIwYSURcuygoNnaNkT9+NnG4j88cWnSX7cVRQhFP
 ZJedaL+/XsKV8HO7pj5mkJ6UQZoJR8E=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-231-lzsKE4_nNveb8gyYcPELWw-1; Tue,
 22 Sep 2026 16:22:38 -0400
X-MC-Unique: lzsKE4_nNveb8gyYcPELWw-1
X-Mimecast-MFC-AGG-ID: lzsKE4_nNveb8gyYcPELWw_1790108557
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8F9361828AC5; Tue, 22 Sep 2026 20:22:37 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E6F881956095; Tue, 22 Sep 2026 20:22:35 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:18:05 +0400
Subject: [PATCH 58/88] qemu-iotests/071: migrate away from HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-58-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=4015;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=zMVUUohbio/jDSQJvutRU7usXRmpt1kSpc4NTAIWYds=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqsuKy1mK/r+JHPQ3MkMcIfljgU/Bnu29FZAhCX
 hqeUZ9ZvaSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarLisgAKCRDa6OEJdZac
 5Y2JEACU3hLrXtintSHAMOp83bYnWuh6ebpJl2tPXT2tBvRnV60prkjzhomUoLGzMnSgf7jQbtN
 V+BjN+HtnJZpKVe2dQvsVTnkmPHOOraAJLrMfupEXWsLjouKlnGKQayZeCb7v9r2LWDA7rk2Lxf
 sXkf34KZKZeUKrh3/huU2UovmKnBr6DhE+FGEnbYRXt8F2ZaQqE7QBFxNbrFiAQV/2a0qnNBf7B
 u/9hZQKMFmMoTBOuwcwE1ZOj+5r131h5QtUdAyrB16+4xGqIZzcsZPA/KwxZ1+lQPs9+oe6MfUc
 JCh5HGyckWONcyAmu1nQS7jWhEJR8q9nwrSyZxwTnGuKl1kXEY5AZMIJhTg+zYzhbWpnIrZwnz9
 rywaqvLLfNuuTJ4Mv0Pw1lF32NkH8oeXLmvE3lToBEGBCQ5mSdTD+bYJ8vWB0IyLJDIaY1H6WxJ
 Y55mNkQeugiJX9khOeHW6H3gsK1w0MnvRTkkWjknkoVA+chJFZ2adIN9ZBYssgyJ7BoebAIfBG+
 C9pciiRyXmBni+V+PimKQ0dOgE6Uwd3GnjB6RRR1lQWEDOw+I4og5r0Qc2gj0IByLzjoOCqr/0N
 QXhSmPswOQTkQyVdgp3dv+FNFWVQzVGdjQAdwX6q2TMNaNwul26PaR+3Y2eTY7hDD+z+LJxcpXj
 WbjaD97sV5iCHLg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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
 tests/qemu-iotests/071     | 31 ++++++++++++++++++-------------
 tests/qemu-iotests/071.out | 12 ++++--------
 2 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/tests/qemu-iotests/071 b/tests/qemu-iotests/071
index 83c4ce6314c5..463f5c02349c 100755
--- a/tests/qemu-iotests/071
+++ b/tests/qemu-iotests/071
@@ -43,7 +43,6 @@ _require_drivers blkdebug blkverify
 # blkdebug can only inject errors on bs->file, not on the data_file,
 # so this test does not work with external data files
 _unsupported_imgopts data_file
-_require_hmp
 
 do_run_qemu()
 {
@@ -140,9 +139,10 @@ run_qemu <<EOF
         }
     }
 }
-{ "execute": "human-monitor-command",
+{ "execute": "x-qemu-io",
     "arguments": {
-        "command-line": 'qemu-io drive0-debug "read 0 512"'
+        "device": "drive0-debug",
+        "command": "read 0 512"
     }
 }
 { "execute": "quit" }
@@ -175,9 +175,10 @@ run_qemu <<EOF
         }
     }
 }
-{ "execute": "human-monitor-command",
+{ "execute": "x-qemu-io",
     "arguments": {
-        "command-line": 'qemu-io drive0-verify "read 0 512"'
+        "device": "drive0-verify",
+        "command": "read 0 512"
     }
 }
 { "execute": "quit" }
@@ -210,9 +211,10 @@ run_qemu <<EOF
         "raw": "drive0"
     }
 }
-{ "execute": "human-monitor-command",
+{ "execute": "x-qemu-io",
     "arguments": {
-        "command-line": 'qemu-io drive0-verify "read 0 512"'
+        "device": "drive0-verify",
+        "command": "read 0 512"
     }
 }
 { "execute": "quit" }
@@ -249,19 +251,22 @@ run_qemu <<EOF
         }
     }
 }
-{ "execute": "human-monitor-command",
+{ "execute": "x-qemu-io",
     "arguments": {
-        "command-line": 'qemu-io drive0-debug "read 0 512"'
+        "device": "drive0-debug",
+        "command": "read 0 512"
     }
 }
-{ "execute": "human-monitor-command",
+{ "execute": "x-qemu-io",
     "arguments": {
-        "command-line": 'qemu-io drive0-debug "write 0 512"'
+        "device": "drive0-debug",
+        "command": "write 0 512"
     }
 }
-{ "execute": "human-monitor-command",
+{ "execute": "x-qemu-io",
     "arguments": {
-        "command-line": 'qemu-io drive0-debug "read 0 512"'
+        "device": "drive0-debug",
+        "command": "read 0 512"
     }
 }
 { "execute": "quit" }
diff --git a/tests/qemu-iotests/071.out b/tests/qemu-iotests/071.out
index 15353aba08b9..1e956d4bc1ec 100644
--- a/tests/qemu-iotests/071.out
+++ b/tests/qemu-iotests/071.out
@@ -43,7 +43,7 @@ QMP_VERSION
 {"return": {}}
 {"return": {}}
 {"return": {}}
-{"return": "Error: read failed: Input/output error\r\n"}
+{"error": {"class": "GenericError", "desc": "read failed: Input/output error"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 {"return": {}}
 
@@ -75,13 +75,9 @@ QMP_VERSION
 {"return": {}}
 {"return": {}}
 {"return": {}}
-read 512/512 bytes at offset 0
-512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-{"return": ""}
-wrote 512/512 bytes at offset 0
-512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-{"return": ""}
-{"return": "Error: read failed: Input/output error\r\n"}
+{"return": {"human-readable-text": "read 512/512 bytes at offset 0\n512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)\n"}}
+{"return": {"human-readable-text": "wrote 512/512 bytes at offset 0\n512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)\n"}}
+{"error": {"class": "GenericError", "desc": "read failed: Input/output error"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 QEMU_PROG: Failed to flush the L2 table cache: Input/output error
 QEMU_PROG: Failed to flush the refcount block cache: Input/output error

-- 
2.56.0.rc0.29.g47ce80527c56


