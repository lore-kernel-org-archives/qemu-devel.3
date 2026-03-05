Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95C78F47CD4
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 20:53:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyFgC-0006d4-W6; Thu, 05 Mar 2026 15:52:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyFgB-0006c5-2Q
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 15:52:19 -0500
Received: from mail-qk1-x72b.google.com ([2607:f8b0:4864:20::72b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyFg9-00068M-75
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 15:52:18 -0500
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-8cb20bcff5aso830393185a.3
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 12:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772743936; x=1773348736; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p6mDXSrb7ToWNoTFIymyzkj+yFpEDh3jkj4Tmoji/Us=;
 b=J1QawMArSSM2XYmafnVYiEoOzPc7TMBHUL7flZSmlukNCz3UwUGhSZ3A6aoKlRaxbf
 yCO4ho9pJTeIUB7T1YQacnxbFCNbpjodVOQ268bx9klvBZd38CmGEXfN2gkdbhAHmCbC
 OjYF6Z64MHnfYkjmU/dRcGESEg3aCXjfy9MmrdJDJcS8Wb6GtFPdoPJm0R7mrWXb4T1e
 SZVtCJsWOQS4RQ9reIxXWljzR33Zh0I9yPmHknYJ234A8muV0a8dLjg9jtqYT14LwGWi
 bL+tEyVwRvRlz8P3k9AFS9i2DlrXpwtlktuGmfMShzaiX663ytVOa8SOOo2qSHpZCLcB
 Tbfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772743936; x=1773348736;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=p6mDXSrb7ToWNoTFIymyzkj+yFpEDh3jkj4Tmoji/Us=;
 b=ioNx87ZgrcrqIB765SQ4pw3lnkaGI8tNBwEvWkVQmhKDo27X35mS3Ue6b88hUfrVtz
 vz99hwgLGRwy6bex3GkSPsGQTtUEWc7/HEWAjrRcbRzq7ugWy1Bh9B/pAdex3y9aNT2/
 2xWC6T0nYpzYlm4XbjI+XIkmbY/etk4rvmd5pEkSo2seRCB2Aawj2q/rpI8sHrHE7Zt0
 m37Afy+ji40YizFR+QZSGbk3+dOoE2EcYY57hkdtK1BkArpzbffF6RlbDtqayw2142Gn
 fsQflaXmGJfJ1w2CCCMXe2fCbHFOT+KK2q//Pr1c7hmN7pCueUKKEaFamantfjD98/0e
 Ao1A==
X-Gm-Message-State: AOJu0YzWDjopwQtCxUkei79t5lcAeqaNLE2YAg/xxqT1AaHB7sZA14Uv
 PlcC45376nPR8aBtQsQZ4i0rV40Pcx6giUiwcDRPfxt3NVjVZIC9HtOqCd+QCSJwPCnafIZzWsX
 VJNuv
X-Gm-Gg: ATEYQzwiDIOVgSXaTtkEmcoE90QOkVo3HcEwlgZpD5Wf1OwCXM3teiLv9YE7ARIEQQG
 2CAcjmfZZeu8JCHn5RW28swW04LX36y4EjGrytcwJa88JAKB1X+jy+Pb3vIPUUqCFe6GwS28YE8
 xfQC7YQ0kvGV5TX4+U9Rtpg+ohJzJIAy7EcKIdL+7awY2ttmMmOMY8F/GuLev9Sjht6LY9CHdGH
 OHfNTj315lmseIv5tDGyHXBXCVbKE45scngAiQR1ALCJe54qI/zP2auDuoL3bQtwux4MwOJ3FJp
 9B9CmtVPGith7oLLes4aRBj4wmtEm+17jzCpmJR1kHaJFfeS8rUGqp1/P8MgwHL2ZF7YQkvj3ct
 Y8/x2K95WnwB7DOUZy5kw/9G6TlcsO9umrljOb1PiA1/kqWzNJ8wVHmYZd7NUpaAvgvWpcHVG7Y
 2lGQ5RUsaC0U56rW9NVGkzY8bbb0tS/JRC1kM8CM8y0W5yXMCZuzutqgy04WPwnCC0GtVHm5Kpt
 S/S
X-Received: by 2002:a05:620a:31a4:b0:8ca:3c67:891e with SMTP id
 af79cd13be357-8cd5af804a7mr885482585a.42.1772743935696; 
 Thu, 05 Mar 2026 12:52:15 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a0e31b035sm65559396d6.17.2026.03.05.12.52.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 12:52:15 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@linaro.org
Subject: [PULL 10/12] tests/tcg/plugins/mem: Don't access unaligned memory
Date: Thu,  5 Mar 2026 12:51:50 -0800
Message-ID: <20260305205152.2121854-11-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260305205152.2121854-1-pierrick.bouvier@linaro.org>
References: <20260305205152.2121854-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-qk1-x72b.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

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
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260305161531.1774895-2-peter.maydell@linaro.org
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 tests/tcg/plugins/mem.c | 71 +++++++++++++++++------------------------
 1 file changed, 30 insertions(+), 41 deletions(-)

diff --git a/tests/tcg/plugins/mem.c b/tests/tcg/plugins/mem.c
index 7d64e7018f2..f3992abc8fb 100644
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
2.47.3


