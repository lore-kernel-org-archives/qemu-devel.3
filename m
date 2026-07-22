Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22AEDC4453C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 17:06:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmaOE-0005EG-0s; Wed, 22 Jul 2026 13:05:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wmaO5-0005Co-Hh
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 13:05:41 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wmaO3-0001Zw-78
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 13:05:41 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4954a2e73a9so36469695e9.3
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 10:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1784739938; x=1785344738; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7pAFxtzfR1kXmS5OJ99MnGy/nFG6E2fuCMA2MDYotSI=;
 b=rNuPAx453FfBIvjARgpu4wf93+8uoVdf2jexSPMm51qvam1e5cPupH1tasBuL4qQL0
 CaoRr/CxZ1s9HofRO8NjxRaLz0Qk118mbYPvK9Z2JkvbLDJQV5eSfXQe4tfZBK2wBNEz
 BTMf9KNRjFiJ0AEEAz/95Xk+HutoSGb+C/ojL5kCLFPxBttatJGjVGoOjVqKkkJHwHQG
 Zwj8/MV6Me0dussx+oSU7gXYy3W7NfWlE3THuPYn4JjyKQGGLJWDZsDt09d8V5F0sAO0
 qrl/4duaHU0st9dI6FfGHeXwjbPy4oRntWl08P3/7eDSyCKgU7nVy6yFvf3IEazrmd4O
 JKAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784739938; x=1785344738;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7pAFxtzfR1kXmS5OJ99MnGy/nFG6E2fuCMA2MDYotSI=;
 b=Km6ct+QIIjTHf6L9eBP7d1FPoLt1Ji1d865XVPxYPDamYSEnHGbHDIYjzmzPcghTk0
 w5NarzmwPVJtPzmILJf8DcFtBDFnAcaFVWg1I+0Te2hb6qjQ99Yr9hYQGvOPAhNl4yvC
 15aYEX9vZ2TCwKBYYbXO7Z60cO1cHg/B8TK4fnjhhq7OKmDLopUE9t+Xf3CUiyv/WQSa
 q04bQS0q15V18SlOeqL/hilBG6fOknb8RFO7XwY9pg0NGWJwuI5IDu0BCgOVwvZ9mbi+
 9Qof2EOBydGBexc7DfECU5S6S03m8td162tXTRGpCzKh+AGm7mpLW6nyQHD38GVNEOWH
 XpyQ==
X-Gm-Message-State: AOJu0YzYbri2S4WBKdsqgfaAWeUMBFY3memDuxSBhGI3L9lfww3OBpoK
 NzXiNskemrFsft+suzz2XD6Oo83I+FmTHaxMeMd4JmAn/uqrkouj42keo4M4xJjSTZ0Pe9522OO
 6vSUx
X-Gm-Gg: AR+sD12Jxy1i6xgSDcKsDNsGPDeeOj8aL4Ptjb3JUDeiYIM32I7KcF9Q3ada0F+qMDc
 6HfDPs23MSmOhroPNGz+uMFc2dbyuEfxCjQy+G9AL51zwcinF/ROE0vr9hooGazlCkdKtBlQ7qV
 5R6ODFFeA+dGYO8ch2PcvS26Rtj92kd0D2fCbZIimW0tascm84E99ESQs423t/QBNXALHSoRvE1
 0cmFJOCXcpO5kLh7WCiAjFKgHMPcdHLGrPoPtnjXMXqo5elZaMdLHpgcsv/3mu8X7rWW4UBodup
 wFq1c0lOipmU/q/QnYk0IzQzEw4DcJ6TpYhbhBaA/SGNl4Nh95jE4JMvHYVWHUraZoCIVjKSwmB
 HZrmSWi+JeYwrr1/Hf9FrjTNUE2A8iGnTFQYwdVg2uHAujprlCIIJYX3IUJ+Yg3Ys2ekOe9zVjU
 p4SXNSYH29mg==
X-Received: by 2002:a05:600c:574d:b0:492:4a50:41fe with SMTP id
 5b1f17b1804b1-4954a405e58mr190434835e9.22.1784739937725; 
 Wed, 22 Jul 2026 10:05:37 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:9c54:c407:8170:580d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956b7483f0sm63993215e9.3.2026.07.22.10.05.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 10:05:37 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Cc: den@openvz.org, Thomas Huth <thuth@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 6/9] parallels: skip loading a genuinely empty bitmap L1 table
Date: Wed, 22 Jul 2026 19:05:24 +0200
Message-ID: <20260722170527.2593225-7-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260722170527.2593225-1-den@openvz.org>
References: <20260722170527.2593225-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=den@openvz.org; helo=mail-wm1-x335.google.com
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

parallels_load_bitmap_data() unconditionally calls
bdrv_dirty_bitmap_deserialize_finish() even when there is nothing to
deserialize, which hits an assertion in hbitmap
(hbitmap_iter_init: 'pos < hb->size') when the bitmap itself has
zero size, i.e. the disk is a zero-sector image.

Skip allocating, populating and loading the L1 table entirely when
l1_size == 0. This is safe only because the previous commit already
guarantees l1_size == 0 exclusively means the disk has 0 size.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Thomas Huth <thuth@redhat.com>
CC: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/parallels-ext.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/block/parallels-ext.c b/block/parallels-ext.c
index 97744c9696..704e16e1de 100644
--- a/block/parallels-ext.c
+++ b/block/parallels-ext.c
@@ -168,14 +168,17 @@ parallels_load_bitmap(BlockDriverState *bs, uint8_t *data, size_t data_size,
         goto fail;
     }
 
-    l1_table = g_new(uint64_t, bf.l1_size);
-    for (i = 0; i < bf.l1_size; i++, data += sizeof(uint64_t)) {
-        l1_table[i] = ldq_le_p(data);
-    }
+    if (bf.l1_size != 0) {
+        l1_table = g_new(uint64_t, bf.l1_size);
+        for (i = 0; i < bf.l1_size; i++, data += sizeof(uint64_t)) {
+            l1_table[i] = ldq_le_p(data);
+        }
 
-    ret = parallels_load_bitmap_data(bs, l1_table, bf.l1_size, bitmap, errp);
-    if (ret < 0) {
-        goto fail;
+        ret = parallels_load_bitmap_data(bs, l1_table, bf.l1_size, bitmap,
+                                         errp);
+        if (ret < 0) {
+            goto fail;
+        }
     }
 
     /* We support format extension only for RO parallels images. */
-- 
2.53.0


