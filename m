Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01E4AC61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 14:46:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x28fL-0002zd-OF; Thu, 03 Sep 2026 10:43:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x28fI-0002wx-1s
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 10:43:44 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x28fF-00049V-Pr
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 10:43:43 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-482e067e908so2162692f8f.2
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 07:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1788446620; x=1789051420; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cwUTQMhe74SR6t67iKwOiGBl/CWJ7OZ0wscikZLVil4=;
 b=PqUDkrnlyzMXi2sL/WqZtEkvGQeJ2NVqXv02NBVl/RSBzJO+XkOlPJu67YjnJoD8ey
 jU/AJzkEJoORfr6lqxVQl9B/AqdQHRF/UBw+MryGDJJSx/ojRvT3S7LVz5xJfLhbbyw4
 DYpu218U2dUxxozBppF19RdTinSMVFzF1v7s44YtLRlL71tGP3MOvO2vzH9s4uqno08n
 EOcbqyiuB0gcEB/h7nkq2Fy2PXTV9Go5AWM3RXuSBDoRwgMwHpnVaqviMqEN84ySAOZ9
 uPPFCdny7MfSeCA85w6mVgzv0oEg3hr7+6Ckj9U+iM2feocUNyHJ+vmUcO8UuJVGYCmr
 McsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788446620; x=1789051420;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cwUTQMhe74SR6t67iKwOiGBl/CWJ7OZ0wscikZLVil4=;
 b=rVJAiCJcNzOsj0O3fq2m3mpddd51p6PgrFbwZgOzsS7nJfHO8v818SSs4iVKAyUNCl
 /qk9UnfIbhjej8+1XOXGQfEkf5baBvFjNIEI2EXPx8Ow1L8JITiNYiutwsqf71bdTb18
 4dPv21W/dT42r72Vk6RviIQiapkUbI/UW0AiXq/gqLWU0SGjIkCGajqeNJA1o3AuA0aR
 n2lb+r65/2k9BoPwZ1mia9BnAl9IlExIt6JeJdMCC06SIGQxJI/CBJUiqoXk8QdK7l8X
 0G2tEZLogK9zgQ/IPNG48OF18mcjd4dRTuYtsnOYf/9FPnUCrIgwivyNsVjHk6vm0JTY
 qH+w==
X-Gm-Message-State: AFuF++msMoh8p1hr5Q0gkhZbcNFJbbo2w+D7+8qQ959eTk2k4Jee8KJs
 0+siBIlVWOY9RUXEXt/u9j+ZzOty+fXumEUO9ZQ+Ex81xv4mHlopO+1tMSW6acL4c6BKAqkgUqU
 Q0jen
X-Gm-Gg: AYBFou2kIoRsZvvdBuYr6qAIzqZi3Y4MIqR1st3u2vfCsCMtTao/UeA91n5tVpLOX5B
 tAa2XbJr4O8R+h2Y2OTbgE5FEv2qRSekiWfadjxK5iqI5gy3EBrqRpIb1LmkVnA9LJTzOYYLBZm
 0esGIz8PhmludMpuCphD6ZRvGNSyXuqmWAWOmGIuMoUNi3PudxoNpJIefvmXK4QcC9jFBpn3Rv5
 qDFR5qQE7mGkX4FHPFLbbpWpZKpSmsv1G6yfQYIThCOadICDpV30swN0Ce3hhuYJMvB9dd66u7W
 6R3rj8iOlnFcfGRLq9kcJ5YBTFcaxAv5wbr0JfZVHSFWfEizyoq/yDnTRgcKX9mvjDUpVt4EVDo
 ruWKnD3+QkxLyFLyCsIwd4e5icpf6u5VCAqkviqsWnk7LArL/aTpTPA9yURbHp8jNAksy1lwWY5
 xdtMgl/Y7fZtkkI+hYm6iolDI0BXYWEgr+00L6tHKgx2U0IPrbz3z663nNqu4+T+RbfNI=
X-Received: by 2002:a05:6000:490e:b0:484:478e:e19f with SMTP id
 ffacd0b85a97d-4847b6266a6mr25383404f8f.0.1788446620095; 
 Thu, 03 Sep 2026 07:43:40 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:83cc:ab98:cda9:7dc])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448ee9cf7sm15165483f8f.25.2026.09.03.07.43.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 07:43:39 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH v7 25/25] tests: Add parallels format support to image-fleecing
Date: Thu,  3 Sep 2026 16:41:43 +0200
Message-ID: <20260903144143.2328870-26-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903144143.2328870-1-den@openvz.org>
References: <20260903144143.2328870-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=den@openvz.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


