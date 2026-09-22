Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B12FAC98304
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:29:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x971Z-0006RN-1M; Tue, 22 Sep 2026 16:23:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x970a-0002Ys-Oo
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:22:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x970Z-0000HP-31
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:22:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PeX3kkBwg9WAY+tSUXvhckcEyrx/JVu/CcYU+8EtmK8=;
 b=JpYnhBxweNpJvpKnHtgXJCKCJCH6IUtfI32HC7bEnsAzlevgsjV+L8YeKlL4Hihb7E4Luy
 L3ly4i0lAB/iQxELp5A2x2lFJNKQ+rmyuKul50Qvh7CTJfmnO174Nq0o/h7EAQZGY84YyR
 r9tFQz06qOKVBu3YZ6cVpUTG3yftb9Y=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-83-PPJOlRMMNBGNAYDBhJu9Mw-1; Tue,
 22 Sep 2026 16:22:26 -0400
X-MC-Unique: PPJOlRMMNBGNAYDBhJu9Mw-1
X-Mimecast-MFC-AGG-ID: PPJOlRMMNBGNAYDBhJu9Mw_1790108546
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 167AA195D02A; Tue, 22 Sep 2026 20:22:26 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 42E271956095; Tue, 22 Sep 2026 20:22:24 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:18:02 +0400
Subject: [PATCH 55/88] qemu-iotests/117: migrate away from HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-55-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1978;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=odxVq0Kgp7ps3FcquMX0FkIHe/fyOXOcYNg4lzb9hA8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqsuKynsq8CocEMkp1xcKQGetyZKDkC+Gfw7EUZ
 KGOtUzBxnOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarLisgAKCRDa6OEJdZac
 5RI2D/wN2RidkCmB3lIT4sj8g3Ztlept6iWAXS+x9RWi0yLEed+tYSPMYbE1L6wS5aUXMsKEbPj
 k0f4lgO9PdpJ2uHGQ64Lzu7gZxI/2fNLfxjpWppkEQLSINC4SJMlJdOZyHv+9Y2VUjap2BQ65kp
 6OW1CXB5DEkp/Xst5TRHPAqe2Qcl/pJ2BNCzEXT8PYwF8FuAqeUKwtJ2tteiGsFpcVr00JNgPCS
 6yuhpVIFtvMM6z2EHZJwMA0CsKNPH2kEhLgFEFjwB7N1JWQxpwAhBtAfksfK1qrup8FS40PePwu
 FljpRDWbrXwMCB1AESxU3JBo5cCdgj3PLu+hmLSsUL7vN2pj/pPc3zupQG/dHKNdtiCVEGaWc5a
 n91LzJhKWXvMI/ha6LuzxQqx3Wol8iB9wxLqPM6+w5MaveojyP3eAQdyfG6sGr+YhIVJh9Lqfr1
 REYF+Datn1fymfKhyjPC4dtybhmMMAkvR7C/ixF4fpavmgEb02sQGgw/Bk0qYS3hBJIYNv+rWaL
 dSPQzl17OqI7YppPKmt1JQrqmO8PIrwSUiSeLpWqT4+9qdYXuEX1lISAujvI86oVt3BoGZFcxD8
 H0t6+dhtRoPvvuP7toumXBlJy+7OvFu67fOE5pc+ae/IyQHfylIQcYZ5vTrqPazGRkQjO2sQTrM
 NxRGF6XHmMNikTw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qemu-iotests/117     | 5 ++---
 tests/qemu-iotests/117.out | 8 +++-----
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/tests/qemu-iotests/117 b/tests/qemu-iotests/117
index 5cc9433f4a67..69d3a862d5e5 100755
--- a/tests/qemu-iotests/117
+++ b/tests/qemu-iotests/117
@@ -41,7 +41,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt qcow2
 _supported_proto file fuse
-_require_hmp
 
 _make_test_img 64k
 
@@ -66,8 +65,8 @@ _send_qemu_cmd $QEMU_HANDLE \
     'return'
 
 _send_qemu_cmd $QEMU_HANDLE \
-    "{ 'execute': 'human-monitor-command',
-       'arguments': { 'command-line': 'qemu-io format \"write -P 42 0 64k\"' } }" \
+    "{ 'execute': 'x-qemu-io',
+       'arguments': { 'device': 'format', 'command': 'write -P 42 0 64k' } }" \
     'return'
 
 _send_qemu_cmd $QEMU_HANDLE \
diff --git a/tests/qemu-iotests/117.out b/tests/qemu-iotests/117.out
index 1cea9e021730..af2a30be9e84 100644
--- a/tests/qemu-iotests/117.out
+++ b/tests/qemu-iotests/117.out
@@ -12,11 +12,9 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=65536
                       'driver': 'IMGFMT',
                       'file': 'protocol' } }
 {"return": {}}
-{ 'execute': 'human-monitor-command',
-       'arguments': { 'command-line': 'qemu-io format "write -P 42 0 64k"' } }
-wrote 65536/65536 bytes at offset 0
-64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-{"return": ""}
+{ 'execute': 'x-qemu-io',
+       'arguments': { 'device': 'format', 'command': 'write -P 42 0 64k' } }
+{"return": {"human-readable-text": "wrote 65536/65536 bytes at offset 0\n64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)\n"}}
 { 'execute': 'quit' }
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 {"return": {}}

-- 
2.56.0.rc0.29.g47ce80527c56


