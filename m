Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3020C88E41
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 01:03:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4pfT-0000Ts-NR; Thu, 10 Sep 2026 21:03:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x4oQV-0001rV-Cm
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 19:43:41 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x4oQF-0007J4-IR
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 19:43:30 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49d1fb0cf5eso2907195e9.3
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 16:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1789083782; x=1789688582; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2rJYFRyBF3ve93GuQi7uuw0NLh/T3juFuRfoIczr1YA=;
 b=NEMgJKZivp+wHOJj+SO9xdYhCTS55scSLU82aX+NyIfMNsSemheGapq5eLfEONOwgj
 37St28KLDl56HIK0SCiHbJ5BJ1erC4JKWEf/Zge30xipJL4n7SfyArwhq1SaVY3JTw5Z
 B4FhEpUGLNMuXoLHaeujw2TkFQvRHuDtADOVB0ftBK1orFC2n3QIp2HPyO4ap0wv03ow
 mDp8koDhlmN5BOjtSTBuKEdWAhEphhk/zpb10aNN8C53Kdq4HixaJljoei9d0wORkL4G
 QA5/3fSM+E/aGAyLLd6/d9u+aXpkf8dw0cu4Wds5zHktc75xOcONzGpHn+qtgzH6f785
 XjHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789083782; x=1789688582;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2rJYFRyBF3ve93GuQi7uuw0NLh/T3juFuRfoIczr1YA=;
 b=q2EyHZXt3xpEP4ZDEnJD29nYSeNYAIBQtJBE3N3Osqvxrd4wJ8n7zfI6qz7grKd3nV
 htw2jK47ocMr3cFgd4iZYk8QzT/fsBfxI8WfOD6As/oqld3kMLYq4SG56z0r5WmVG+0V
 A1QXdcONYOlCJIdM6BFkwDmrAJ/Rc4OzJBpg6ru29bHl0CbEJPKr6S0rJKDiamw/LjiJ
 mFUuoZlG90wdfFHZ2Ycw2gefF1tFqKhl0g4UtzB7qlWKiafHRWiS2DZ6R/DQZIynpsHV
 6sqNeFzL9bDANkxU6FWkkLqxplPBdOoRDAkqATGYkmJN3Nr/oaBnrYZaMIp/x/0RQQbX
 p/Tw==
X-Gm-Message-State: AFuF++mUWT2Dadxtc7d4CUi2aohV5hoqmwQynsvJRWkjCx6znQOM99vw
 +ArCmZct0OkVUMliL7SIDFbubDaQI3ClcT0nDkGkVTAetEbRB0gWA2NEB5GMENsk2Kw=
X-Gm-Gg: AYBFou35nU3/C74j4YlZ7v7PHrVQneQZdDOX9WQdq3YdkXx+uPkXl5FrVkGXN349Gsf
 EgN8dNY2Ri6h1TlCzpgRU+WtxIt+GpEgoxmcupTmX7OiSwIG8VMO0pnLMGdaytb2JGGIu7ifYp2
 MU8rP60W+KCq38noxzRNHEIWQKl8EFLzjphokB/EeHNspyPtBc1LVhPt8DNmqiJ6+MGyhITfjGD
 Y8HJtIqu9VM1c3jY7Ul+2O+WPrOPt/AZLuiIWWhjjgJoZ+rTS3fnGESwU5pgj/EHmCvhkq/szJe
 LakaVLbBTT4pkaMsq2N8ZE9aCBHLSsrqmYwbI+Q12dj6wyMFkEp6veQBl8s3DTrUk8dJzVhUegE
 YOdt9qv5HnyQoAkzRIq2lYzyTaeorxoFwMw0U3GZzQJJ/JNOtcjDt3mQyV2i6e8vu296LmarHkV
 EdoqzHjNxgIOQ7HcayyE9qxGl+G/4j3gryBjgJeeIxgegQPghzZSMyY8m9EdWZTwldxX0w
X-Received: by 2002:a05:600c:1d08:b0:49d:2450:68ac with SMTP id
 5b1f17b1804b1-49e619b57admr29752575e9.5.1789083782218; 
 Thu, 10 Sep 2026 16:43:02 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:54f3:cc87:964b:3604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e62231360sm7726775e9.4.2026.09.10.16.43.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 16:43:01 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PULL 29/29] tests: Add parallels format support to image-fleecing
Date: Fri, 11 Sep 2026 01:42:22 +0200
Message-ID: <20260910234222.3039975-30-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910234222.3039975-1-den@openvz.org>
References: <20260910234222.3039975-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=den@openvz.org; helo=mail-wm2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Denis V. Lunev <den@openvz.org>

Use a different bitmap name for parallels images, as the format has its
own ID format and can not hold an arbitrary string.

Replace the hardcoded 'qcow2' target format with iotests.imgfmt.

Add 'parallels' to the supported formats.

Based on the original work from Alexander Ivanov.

Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Signed-off-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 tests/qemu-iotests/tests/image-fleecing | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tests/qemu-iotests/tests/image-fleecing b/tests/qemu-iotests/tests/image-fleecing
index b42aa6967f..0142289843 100755
--- a/tests/qemu-iotests/tests/image-fleecing
+++ b/tests/qemu-iotests/tests/image-fleecing
@@ -28,7 +28,7 @@ import iotests
 from iotests import log, qemu_img, qemu_io
 
 iotests.script_initialize(
-    supported_fmts=['qcow2'],
+    supported_fmts=['qcow2', 'parallels'],
     supported_platforms=['linux'],
     required_fmts=['copy-before-write'],
     unsupported_imgopts=['compat'],
@@ -62,12 +62,18 @@ def do_test(vm, use_cbw, use_snapshot_access_filter, base_img_path,
     if push_backup:
         assert use_cbw
 
+    # parallels stores a bitmap name as the UUID identifying it in the image
+    if iotests.imgfmt == 'parallels':
+        bitmap_name = '00000000-0000-0000-0000-000000000000'
+    else:
+        bitmap_name = 'bitmap0'
+
     log('--- Setting up images ---')
     log('')
 
     qemu_img('create', '-f', iotests.imgfmt, base_img_path, '64M')
     if bitmap:
-        qemu_img('bitmap', '--add', base_img_path, 'bitmap0')
+        qemu_img('bitmap', '--add', base_img_path, bitmap_name)
 
     if use_snapshot_access_filter:
         assert use_cbw
@@ -76,7 +82,7 @@ def do_test(vm, use_cbw, use_snapshot_access_filter, base_img_path,
         qemu_img('create', '-f', 'qcow2', fleece_img_path, '64M')
 
     if push_backup:
-        qemu_img('create', '-f', 'qcow2', target_img_path, '64M')
+        qemu_img('create', '-f', iotests.imgfmt, target_img_path, '64M')
 
     for p in patterns:
         qemu_io('-f', iotests.imgfmt,
@@ -131,7 +137,7 @@ def do_test(vm, use_cbw, use_snapshot_access_filter, base_img_path,
         }
 
         if bitmap:
-            fl_cbw['bitmap'] = {'node': src_node, 'name': 'bitmap0'}
+            fl_cbw['bitmap'] = {'node': src_node, 'name': bitmap_name}
 
         log(vm.qmp('blockdev-add', fl_cbw))
 
-- 
2.53.0


