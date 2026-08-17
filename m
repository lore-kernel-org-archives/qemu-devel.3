Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D56A9C5DF80
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 19:02:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww2ao-0000j1-7o; Mon, 17 Aug 2026 15:01:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1ww2ZG-0006Of-Lz
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 15:00:31 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1ww2ZD-0006Vv-Q2
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 15:00:18 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4994c49f588so2365185e9.0
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 12:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1786993214; x=1787598014; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ja0e38s/qENhcuVZ7qPwvVptslecPabtUXFO8ATqnYI=;
 b=Nll/cPDkKfPDGvMj5IAcK/ae2H0PXJxcJjF5krjcjwxIPJXu1j4q2KGVVYl1eEZ7km
 RWzwIywb4Ddautoa+Hc9STiNRtXIx3ENUtZLhuVeoX6STUo6IB7KD5DxjNdDJhK7FolV
 eC7FXs3gqk3Qp6NGrBar6Dk0O3FcnfJwQm4JYa5skgPOcd7K5y3lYhmCf8UFk0Euoi7e
 TBLgcZAmACT0jqcewMG+9fhjX4L939DT77THhkYMrfv8Tyv9UKgM/+ZleuVZ5J0vVGqq
 pFjt11wNwevXQTt20nNY/m21Y4psuAx+0K5G+/tNtpyLjLaTwW4RXYeygSbblCqkcpkk
 cY+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786993214; x=1787598014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ja0e38s/qENhcuVZ7qPwvVptslecPabtUXFO8ATqnYI=;
 b=K5WSVfhc9VlYR7Iu5EqREyvMl47IqaF6PIBQu4awc8QnXtPs2zFBNHVcPDeKpU1ctp
 lN99MXZ40UDJKiHPVRGp+zhTMXBz50KTJSFC41pyuO+F2fGl0+Ll3b+bPWVde1zgW+Gj
 xzg7SXM//zJNDZQ61QhB8e61sg4eZgClVcb6MKIUrxXkkoHcuAFi+6mfHYjnBNvPy1I2
 eNaLRe6O/zrLYBNpQmygcy3aUg3kOM06ZpLfL6L505IiyY4AWgtyiZAd6T6lwR0lE4RX
 dC/TeiXdm9CkNiFrgMix2ruQ1Ax+k0gZbT3ZIIO5/sI4DXJTlZOIZARfffzcfciNo1G0
 VQLw==
X-Gm-Message-State: AOJu0Ywm0Kuxj1bZb1Di6k2gjCnFU72ZWZUGGwAAJSA90fEyurMqk0BN
 S7iUAXxvccVZOCaCh2JNbEU3E1xWGqnJUTMKqqoHLv+YdjMDrHKVyc8gR3JS2C69fimxMJflOjU
 IkWeq
X-Gm-Gg: AR+sD13zTVrS6UD3SY/zkntfF0rS5UOHZZdpxGFp/hAVibdwBeh68LE+12WrZ2pMAaO
 oVhMtTpeVimzGK6o05YMyuIUT1lMs7B/NxsRiLh6yS2NxkjNYn2TVDANXaS9Us46o5YUVvI7Kxk
 J/KMwkR5RQLLK4B87U0ZBFDNBQ6pgMjFEO9ZfIMnzY6ienv12ayKwzS6ZtohLN6CfVrBE18xg2E
 4RU9yV57uuVJQOSOK5R8Fz7qVEpxE7KZbcbas/tsiex978Q1DMu1nA6AZyPyH5k0DUVtnIT9cii
 zCEi6CoRGur8J9pgzhBNueB2kAiOP+v9DmmE20dvx3zaHn9JuZmSXw0nOa/2pJowZDUXLaxxwnW
 vFNFjcpKfqYYex2ojyB9i/Ub1p69yaYsZD5tEmvOKHsvpt3bhwX1JpH3c+/k+jAeix6zDJAbpxu
 vxsh0A71d/GPTgqre+a/dXMV0Gx/T9w8IOd3XROIXASBPlkS8YeE4=
X-Received: by 2002:a05:600c:4fcc:b0:493:f783:c46a with SMTP id
 5b1f17b1804b1-499a1f56bbfmr426865e9.6.1786993213725; 
 Mon, 17 Aug 2026 12:00:13 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:f6f8:884c:b162:eaeb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49996188217sm381011085e9.13.2026.08.17.12.00.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 12:00:13 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH v6 25/25] tests: Add parallels format support to image-fleecing
Date: Mon, 17 Aug 2026 20:59:42 +0200
Message-ID: <20260817185942.1065143-26-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817185942.1065143-1-den@openvz.org>
References: <20260817185942.1065143-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=den@openvz.org; helo=mail-wm1-x32c.google.com
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
index 5e3b2c7e46..7e7dafcf19 100755
--- a/tests/qemu-iotests/tests/image-fleecing
+++ b/tests/qemu-iotests/tests/image-fleecing
@@ -28,7 +28,7 @@ import iotests
 from iotests import log, qemu_img, qemu_io
 
 iotests.script_initialize(
-    supported_fmts=['qcow2'],
+    supported_fmts=['qcow2', 'parallels'],
     supported_platforms=['linux'],
     required_fmts=['copy-before-write'],
     unsupported_imgopts=['compat']
@@ -61,12 +61,18 @@ def do_test(vm, use_cbw, use_snapshot_access_filter, base_img_path,
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
@@ -75,7 +81,7 @@ def do_test(vm, use_cbw, use_snapshot_access_filter, base_img_path,
         qemu_img('create', '-f', 'qcow2', fleece_img_path, '64M')
 
     if push_backup:
-        qemu_img('create', '-f', 'qcow2', target_img_path, '64M')
+        qemu_img('create', '-f', iotests.imgfmt, target_img_path, '64M')
 
     for p in patterns:
         qemu_io('-f', iotests.imgfmt,
@@ -130,7 +136,7 @@ def do_test(vm, use_cbw, use_snapshot_access_filter, base_img_path,
         }
 
         if bitmap:
-            fl_cbw['bitmap'] = {'node': src_node, 'name': 'bitmap0'}
+            fl_cbw['bitmap'] = {'node': src_node, 'name': bitmap_name}
 
         log(vm.qmp('blockdev-add', fl_cbw))
 
-- 
2.53.0


