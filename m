Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53AF4F3D31A
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 16:17:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyBMX-00089C-Py; Thu, 05 Mar 2026 11:15:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyBMQ-00088F-Fq
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 11:15:43 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyBMO-0004Wd-MB
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 11:15:38 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48329eb96a7so55113355e9.3
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 08:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772727335; x=1773332135; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sFqivDor1d74CstpMnj+DHrBSaSDA8Y/O0yQwkVicTo=;
 b=krsQJuN0NB+daVIsm3omDQtyzF7uy+MJwCMQbkhzvCQmWkD5xEKMEfmFh1CUMlBwmu
 JN1i6PIWToRCcQJKhr+qUxn5ybd2cETfTgRkPDCdB30QMQUbHxLkfvuYfsf6nsmExYRM
 0iIU5FWrY/rg3LUCGB+sqyjuYBx5g35G+NXEFWaDuZOxNOHPfjQhT7KNNOJxXZCv2WVZ
 sujRxkXu5mTwadkGnLy27Y80q4kxu7L1eCrBb/3wizMvqKHAQEocB8XvflqOEFfyHdpP
 LGyGvmhiFMiM3zpLv3SFISKC0LB8Ht3xxyecxZ1etc7Ddm7Gl2T33xEN2B5mU21EXfvs
 m+bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772727335; x=1773332135;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sFqivDor1d74CstpMnj+DHrBSaSDA8Y/O0yQwkVicTo=;
 b=thC5466FTUH3YO1llQD2fUNOgE+J1wR3g+iBPTVjnjgTtsbSkjLtkOpvthBehluKA+
 ClzGOFuckKL4F2yuIxorVJOq1G+4UzSuRQM9EsJQ358xOkgZ+BGu5ztzQ04r3vk3bDUD
 m95pJJYGH2pUukJGWA8Ca2B2sIkTXZffWZtb7vYGPmm44mkkvemSUFi7bFnQhpXAc7Vt
 Zs9PAFR9nGb1egfriGHnNnekUO1XzH1J1U/ycq9wl8B4ImdQaLO800F37f4oepaptm5V
 9cGpEGp/3op+Db2WQm1LripXE21azrbqOhIhuT2CoF7OKVQ43LtEXMuefaU6HNKcMXKX
 2ppw==
X-Gm-Message-State: AOJu0YwwdZ8eD5J94UTnxmxmAssQlk+H2K8ZVRsDoyOjTGiNK+lYnI7Y
 AyQeB+qJV2lKuswbanmWachKypbqeShJUheuM4HHRAGIGPJGf4xEknRJy195u1t/LBpu9fnEz87
 fMeEr
X-Gm-Gg: ATEYQzxCSfe88vf1f7KSnszPDg7GDdx0NVV5dzTnOZg5eztJ3NcLghfrisa8DdIkFsk
 /B1Gn9Oz5/bpg+g1O8KKgxpto2lRPeb8/ZoKENPeUFhD4KXs4W4jtlTvRJPRgACr69MZCYKLQ3s
 ObqPpIJcY87sS99lxRo7ogGZrcppIos3uCL3f0/tKirC5Nj5GeZY0Kr5DxleODMysBAKN1cnFzd
 HpyckitL+Gukk31ZoW2fc/QRZ8wVqAXpdk98EmV3Dg1FEECLrpzNXZUGoTFjWkmHwiLOsgOpatA
 wneWmljkQNq31ZMhEa+jTybWJUpp7+o6ZAfzsYzjdJ5tj/8tceWOQY9khgbed1mCdhvl+0iDdKj
 2X0y+irwN/bX+Ce/TDHEPZq7NbGo6g02yCOqKHx0b8oiA41v8MvRMjunsUhLofQgllyeUlOW3j5
 EJ19XUN7AkO+XFtJ5OUk/g1PRd3IZfuHtien/Prdv2Nk9xe8zF3tP3QhB9xZg6C0kSxIuISip8u
 xgyy1bCXqBPIDcb84Uz52hazNVObKXfdJMysL9UMQ==
X-Received: by 2002:a05:600c:1f85:b0:47e:e4ff:e2ac with SMTP id
 5b1f17b1804b1-485198a3b5amr117961185e9.33.1772727334814; 
 Thu, 05 Mar 2026 08:15:34 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851fad01d2sm53466465e9.3.2026.03.05.08.15.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 08:15:33 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH 1/3] tests/tcg/plugins/mem: Don't access unaligned memory
Date: Thu,  5 Mar 2026 16:15:29 +0000
Message-ID: <20260305161531.1774895-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260305161531.1774895-1-peter.maydell@linaro.org>
References: <20260305161531.1774895-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

In commit eb3f69cac62670 we removed the dependency of this mem plugin
on the QEMU headers, but in doing that we introduced undefined
behaviour when the plugin accesses unaligned memory.  This shows up
if you build with the gcc or clang undefined behaviour sanitizer
(--enable-ubsan) and run 'make check-tcg', in numerous warnings like:

../../tests/tcg/plugins/mem.c:167:27: runtime error: load of misaligned address 0x7f1f300354b1 for type 'uint16_t' (aka 'unsigned short'), which requires 2 byte alignment
0x7f1f300354b1: note: pointer points here
 00 00 00  00 01 02 03 04 05 06 07  08 09 0a 0b 0c 0d 0e 0f  10 11 12 13 14 15 16 17  18 19 1a 1b 1c
              ^
SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior ../../tests/tcg/plugins/mem.c:167:27

Fix this by rearranging the data reads and writes to use
memcpy() instead.

Fixes: eb3f69cac62670 ("tests/tcg/plugins/mem.c: remove dependency on qemu headers")
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/tcg/plugins/mem.c | 71 +++++++++++++++++------------------------
 1 file changed, 30 insertions(+), 41 deletions(-)

diff --git a/tests/tcg/plugins/mem.c b/tests/tcg/plugins/mem.c
index 7d64e7018f..f3992abc8f 100644
--- a/tests/tcg/plugins/mem.c
+++ b/tests/tcg/plugins/mem.c
@@ -123,6 +123,9 @@ static void update_region_info(uint64_t region, uint64_t offset,
     bool is_store = qemu_plugin_mem_is_store(meminfo);
     RegionInfo *ri;
     bool unseen_data = false;
+    void *val_ptr;
+    unsigned int val_size;
+    qemu_plugin_mem_value swapped_value;
 
     g_assert(offset + size <= region_size);
 
@@ -144,61 +147,46 @@ static void update_region_info(uint64_t region, uint64_t offset,
     }
 
     void *ri_data = &ri->data[offset];
+
+    swapped_value.type = value.type;
     switch (value.type) {
     case QEMU_PLUGIN_MEM_VALUE_U8:
-    {
-        uint8_t val = value.data.u8;
-        uint8_t *p = ri_data;
-        if (is_store) {
-            *p = val;
-        } else {
-            unseen_data = *p != val;
-        }
+        swapped_value.data.u8 = value.data.u8;
+        val_ptr = &swapped_value.data.u8;
+        val_size = 1;
         break;
-    }
     case QEMU_PLUGIN_MEM_VALUE_U16:
-    {
-        uint16_t val = be ? GUINT16_FROM_BE(value.data.u16) :
-                            GUINT16_FROM_LE(value.data.u16);
-        uint16_t *p = ri_data;
-        if (is_store) {
-            *p = val;
-        } else {
-            unseen_data = *p != val;
-        }
+        swapped_value.data.u16 = be ? GUINT16_FROM_BE(value.data.u16) :
+            GUINT16_FROM_LE(value.data.u16);
+        val_ptr = &swapped_value.data.u16;
+        val_size = 2;
         break;
-    }
     case QEMU_PLUGIN_MEM_VALUE_U32:
-    {
-        uint32_t val = be ? GUINT32_FROM_BE(value.data.u32) :
-                            GUINT32_FROM_LE(value.data.u32);
-        uint32_t *p = ri_data;
-        if (is_store) {
-            *p = val;
-        } else {
-            unseen_data = *p != val;
-        }
+        swapped_value.data.u32 = be ? GUINT32_FROM_BE(value.data.u32) :
+            GUINT32_FROM_LE(value.data.u32);
+        val_ptr = &swapped_value.data.u32;
+        val_size = 4;
         break;
-    }
     case QEMU_PLUGIN_MEM_VALUE_U64:
-    {
-        uint64_t val = be ? GUINT64_FROM_BE(value.data.u64) :
-                            GUINT64_FROM_LE(value.data.u64);
-        uint64_t *p = ri_data;
-        if (is_store) {
-            *p = val;
-        } else {
-            unseen_data = *p != val;
-        }
+        swapped_value.data.u64 = be ? GUINT64_FROM_BE(value.data.u64) :
+            GUINT64_FROM_LE(value.data.u64);
+        val_ptr = &swapped_value.data.u64;
+        val_size = 8;
         break;
-    }
     case QEMU_PLUGIN_MEM_VALUE_U128:
-        /* non in test so skip */
-        break;
+        /* none in test so skip */
+        goto done;
     default:
         g_assert_not_reached();
     }
 
+    /* ri_data may not be aligned, so we use memcpy/memcmp */
+    if (is_store) {
+        memcpy(ri_data, val_ptr, val_size);
+    } else {
+        unseen_data = memcmp(ri_data, val_ptr, val_size) != 0;
+    }
+
     /*
      * This is expected for regions initialised by QEMU (.text etc) but we
      * expect to see all data read and written to the test_data region
@@ -213,6 +201,7 @@ static void update_region_info(uint64_t region, uint64_t offset,
         ri->seen_all = false;
     }
 
+done:
     g_mutex_unlock(&lock);
 }
 
-- 
2.43.0


