Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D4E6C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 05:01:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trVEa-0003Id-0O; Mon, 10 Mar 2025 00:59:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trVEP-0002wX-39
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 00:59:13 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trVEL-0008HV-OV
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 00:59:12 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-22401f4d35aso65269595ad.2
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 21:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741582748; x=1742187548; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ca5XHIZHBD7tCKLnU5sMNG3rMchaOW2xdNGbrtAeUuA=;
 b=ySc+Fjh76uAWjQo2Kxax9o8asbpc5/1bAbd8ms9coFa2CNsf/RJN0+6GvgYS++0KVT
 +aY4ky90rvuW5F6oWXegFtw1prJ9FTInQpDQPRS7OFjoGTkEfZ4zHpLpIvz3m21fWY40
 RPQFCFHkHy8oi1fi1WDh0mp1UFvwv/e6WBxa8SpaL/ES1L8Isr7Vt9VCtxiaIn8v+U+3
 PLS6ZcaW7AfhbEd9arVI2NWPQNu8IncNv5ABd4yEc5gWrqIEoi5xCLmnPTnzYNt1i5Rw
 Lqr5nYGeHvrap8bHgY57vhQC+S3SGBJJWFBebqwXrEavmVoXRqgF5Hqzuzqv2DGN/32u
 AMoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741582748; x=1742187548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ca5XHIZHBD7tCKLnU5sMNG3rMchaOW2xdNGbrtAeUuA=;
 b=cXHZftJehrvt0GaQsACfyyRtBMXlhIGt2SdV5cLPDw1W3FYrqktGM6yWYs0cefm/54
 4W1I8H9Mew2RQC9JSZtCr8l6yhKI1fuHowzE/J4ZlMbF1Y19f8jkJGK7HU/6rX64rU+J
 vBqQtjfALf18b/ADhb0PjVggFWmvZkft6UemyymEkotF09AUn9OAUNgY8KcJjBitnLmz
 DVchPxm/diVsfzjg+tidYXVn8zRg0h1DlgaaLu+PtihxpJaslon2ZMGGWM/oOcfwRbYd
 3bK73v3duWK4Fbo7ih5fHPo9U0nW/gJBSSc1H8zMUVj1z9Vjfaf4rZuKNffkruxZ4ctP
 oJ4g==
X-Gm-Message-State: AOJu0YxzMT29JDtCuid8UmgOLQkCqKu2VzYjtsQbgMkk7U7HxCWyYXSR
 WRWgVjwP80LnjsX1UbSy0Ki5U7iQ4XfDYKLgSt3i+dFmJ01QOxLgAEqaW60mnAx96eHY4kNPyxg
 mzbg=
X-Gm-Gg: ASbGncv2Nx54VJnS4wR+HGE8CdXzPAbhQoPEK0Y4vHcI71GmMPnB/b0epxVLXBlR1hj
 sQC2bZC4KPL188N6eyQrDsIPuPxRj/QiD4A+8fF1mswIkQjpF/vQwV7CFuWvNFu3d3sypVT5yL/
 QROjBp4njnlxo9dvaJG60jj+miOU3HyrJaCy2jffKvk/e7myNA/x2219EpdXp+72ajJoHKb2v47
 r3TmTK+GvOKuAPYjccv4qxafZZhm3cVA9EJQnZVtspAGFU+PK0UpHGJu5q+PcR4u7bOGSAmn+ig
 mU09GJZuiNKU/GeuvJu7bHkMqoOd6DP88Xmo/8bGrL0j
X-Google-Smtp-Source: AGHT+IHOxR50kjFp3DQk9gSBOkNND2h3Drx9YEHpcRm5j+6hJ+poi1niGnSE9oReFoFKVWczKyJ1NQ==
X-Received: by 2002:a05:6a00:2315:b0:730:7600:aeab with SMTP id
 d2e1a72fcca58-736aa9fea71mr18336179b3a.13.1741582748003; 
 Sun, 09 Mar 2025 21:59:08 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736d2ae318csm1708308b3a.53.2025.03.09.21.59.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Mar 2025 21:59:07 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, alex.bennee@linaro.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, kvm@vger.kernel.org,
 Peter Xu <peterx@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 David Hildenbrand <david@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anthony PERARD <anthony@xenproject.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 manos.pitsidianakis@linaro.org, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 15/16] system/memory: make compilation unit common
Date: Sun,  9 Mar 2025 21:58:41 -0700
Message-Id: <20250310045842.2650784-16-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250310045842.2650784-1-pierrick.bouvier@linaro.org>
References: <20250310045842.2650784-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 system/memory.c    | 22 +++++++++++++++-------
 system/meson.build |  2 +-
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/system/memory.c b/system/memory.c
index 4c829793a0a..b401be8b5f1 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -355,11 +355,11 @@ static void flatview_simplify(FlatView *view)
 
 static bool memory_region_big_endian(MemoryRegion *mr)
 {
-#if TARGET_BIG_ENDIAN
-    return mr->ops->endianness != DEVICE_LITTLE_ENDIAN;
-#else
-    return mr->ops->endianness == DEVICE_BIG_ENDIAN;
-#endif
+    if (target_words_bigendian()) {
+        return mr->ops->endianness != DEVICE_LITTLE_ENDIAN;
+    } else {
+        return mr->ops->endianness == DEVICE_BIG_ENDIAN;
+    }
 }
 
 static void adjust_endianness(MemoryRegion *mr, uint64_t *data, MemOp op)
@@ -2584,7 +2584,11 @@ void memory_region_add_eventfd(MemoryRegion *mr,
     unsigned i;
 
     if (size) {
-        adjust_endianness(mr, &mrfd.data, size_memop(size) | MO_TE);
+        if (target_words_bigendian()) {
+            adjust_endianness(mr, &mrfd.data, size_memop(size) | MO_BE);
+        } else {
+            adjust_endianness(mr, &mrfd.data, size_memop(size) | MO_LE);
+        }
     }
     memory_region_transaction_begin();
     for (i = 0; i < mr->ioeventfd_nb; ++i) {
@@ -2619,7 +2623,11 @@ void memory_region_del_eventfd(MemoryRegion *mr,
     unsigned i;
 
     if (size) {
-        adjust_endianness(mr, &mrfd.data, size_memop(size) | MO_TE);
+        if (target_words_bigendian()) {
+            adjust_endianness(mr, &mrfd.data, size_memop(size) | MO_BE);
+        } else {
+            adjust_endianness(mr, &mrfd.data, size_memop(size) | MO_LE);
+        }
     }
     memory_region_transaction_begin();
     for (i = 0; i < mr->ioeventfd_nb; ++i) {
diff --git a/system/meson.build b/system/meson.build
index 9d0b0122e54..881cb2736fe 100644
--- a/system/meson.build
+++ b/system/meson.build
@@ -1,7 +1,6 @@
 specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: [files(
   'arch_init.c',
   'ioport.c',
-  'memory.c',
 )])
 
 system_ss.add(files(
@@ -14,6 +13,7 @@ system_ss.add(files(
   'dma-helpers.c',
   'globals.c',
   'memory_mapping.c',
+  'memory.c',
   'physmem.c',
   'qdev-monitor.c',
   'qtest.c',
-- 
2.39.5


