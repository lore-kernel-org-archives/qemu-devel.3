Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B5BCC282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 18:40:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuFJY-00053E-QB; Mon, 17 Mar 2025 14:35:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuFJG-0004nX-NM
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 14:35:34 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuFIX-0006Dk-Cy
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 14:35:34 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-225df540edcso61416755ad.0
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 11:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742236484; x=1742841284; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EBRugwqnxw4q7Phz2P050i5IjB6Zbf1WGwdoEilqtkY=;
 b=wtclrS1vnQKrSCKG+duhvTktAa8YXsFt61dGfLCWkZk6A7N/ihYAKedibD9NuwR3+E
 S4kRL31mReks20wi5pcKJnTg3ccZt9LSwAwtnwd11YC6lCJX8b88Z78KIVAA5CDS+SPh
 kOYVSVaMpofKNoMd0rtqtcgXFtUieNIAgrjA9za4q6CR8nsC3XlFi9FR8DXxktnkGp5W
 LK3dVHPSyiD7Pa+hHP/V+cHAQSXpIjkz87QOo4cb9vVssRSqeI8FfiGyUtK6hi+aeLwx
 S+O0cFFMUsUzJhZf3gQNrameNDfsIf2aRAqDAm2DCk9mrau/KPc9QZ5Q4y7Oq63qtyqD
 3gXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742236484; x=1742841284;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EBRugwqnxw4q7Phz2P050i5IjB6Zbf1WGwdoEilqtkY=;
 b=IpeHbaA21jMEn9OXurOHzxqNyFgSj7xB4F0DSpDbnvPVgHGpQgfuxSG1BtAtUU6FkH
 ErjkPh5eQ2l/LAVwSOr+xx+SbbJoIFXp9gFP9lSXgHpJfgrtl+DqVKhZIkAf7XIE1tzu
 bfXsCJHC07pLoR6zQJnDNx2amU13kXFu1NOsyZ3k/GB2hIvhU10eH5mEcKEFXj6bJdBA
 2ax2PFJDwYZHmwdNHVm99QrEgpfZTktntt8e1x8i+I5Ffc4EnG0eJkAwhrgkAx80MNV2
 LA3l7mdOzc0Dmpo7gxRJ0YxZJ8wklVYUKJt1N7FbPOsLcowU6D/VQwqxd8OXV42bfRx7
 7rsA==
X-Gm-Message-State: AOJu0YxeR74E2s21oEVT2qEMSpNAPubDbR+9SKe/OhVSgZhH5WQ1M1o+
 f3pSG54qNagvAFHFSSfiKY2C5ZmiodunLjp/sHuoKEX3FM0RSjNcvzL507VS4klSKlU0EzrCOoi
 8
X-Gm-Gg: ASbGncucWWimqkg9TJXwUeaadNuxNxnMPoUDeUHqcNaTWMbZ4C3cAsTMMNSSb9NGNbV
 3gm82/htRT0Sy0Ob2Inh+kT2n7F98fUtYeLq0hPxYCDGMHqP/FAyUsGR/boqeyJXdO/tEwBHFe+
 2YWFQ8pq5X6Lz3tntaII5X4ZqwvfvrYTVDTyLCIC+QEBheBtphvuLGrv3SzkAcvcHaDi3fE8alb
 j7F1ZacJbVKDwirD9lwrxRQ2mY4EerCtG78JFyvR6Xas9ip08Z+S4eLsryCPh0mpBZYUphVDV7P
 n2zwlGMZBwt+1mcd4pIx+RGgNf7HV+yERmdiBtonD4ls
X-Google-Smtp-Source: AGHT+IHaIWG93SjaignFKD4IVBdMoq9cQTxlUlmFhZIj0sg1/yp4Pm5Fp9URm2R1oo2C+UJzak1b5Q==
X-Received: by 2002:a05:6a00:2e84:b0:736:476b:fccc with SMTP id
 d2e1a72fcca58-737577c60dcmr700300b3a.8.1742236484037; 
 Mon, 17 Mar 2025 11:34:44 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73711695a2esm8188770b3a.144.2025.03.17.11.34.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 11:34:43 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paul Durrant <paul@xen.org>, xen-devel@lists.xenproject.org,
 David Hildenbrand <david@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-riscv@nongnu.org,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, alex.bennee@linaro.org,
 manos.pitsidianakis@linaro.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, kvm@vger.kernel.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Peter Xu <peterx@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Anthony PERARD <anthony@xenproject.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 17/18] system/memory: make compilation unit common
Date: Mon, 17 Mar 2025 11:34:16 -0700
Message-Id: <20250317183417.285700-18-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250317183417.285700-1-pierrick.bouvier@linaro.org>
References: <20250317183417.285700-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 system/memory.c    | 17 +++++------------
 system/meson.build |  2 +-
 2 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/system/memory.c b/system/memory.c
index 4c829793a0a..eddd21a6cdb 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -353,15 +353,6 @@ static void flatview_simplify(FlatView *view)
     }
 }
 
-static bool memory_region_big_endian(MemoryRegion *mr)
-{
-#if TARGET_BIG_ENDIAN
-    return mr->ops->endianness != DEVICE_LITTLE_ENDIAN;
-#else
-    return mr->ops->endianness == DEVICE_BIG_ENDIAN;
-#endif
-}
-
 static void adjust_endianness(MemoryRegion *mr, uint64_t *data, MemOp op)
 {
     if ((op & MO_BSWAP) != devend_memop(mr->ops->endianness)) {
@@ -563,7 +554,7 @@ static MemTxResult access_with_adjusted_size(hwaddr addr,
     /* FIXME: support unaligned access? */
     access_size = MAX(MIN(size, access_size_max), access_size_min);
     access_mask = MAKE_64BIT_MASK(0, access_size * 8);
-    if (memory_region_big_endian(mr)) {
+    if (devend_big_endian(mr->ops->endianness)) {
         for (i = 0; i < size; i += access_size) {
             r |= access_fn(mr, addr + i, value, access_size,
                         (size - access_size - i) * 8, access_mask, attrs);
@@ -2584,7 +2575,8 @@ void memory_region_add_eventfd(MemoryRegion *mr,
     unsigned i;
 
     if (size) {
-        adjust_endianness(mr, &mrfd.data, size_memop(size) | MO_TE);
+        MemOp mop = (target_words_bigendian() ? MO_BE : MO_LE) | size_memop(size);
+        adjust_endianness(mr, &mrfd.data, mop);
     }
     memory_region_transaction_begin();
     for (i = 0; i < mr->ioeventfd_nb; ++i) {
@@ -2619,7 +2611,8 @@ void memory_region_del_eventfd(MemoryRegion *mr,
     unsigned i;
 
     if (size) {
-        adjust_endianness(mr, &mrfd.data, size_memop(size) | MO_TE);
+        MemOp mop = (target_words_bigendian() ? MO_BE : MO_LE) | size_memop(size);
+        adjust_endianness(mr, &mrfd.data, mop);
     }
     memory_region_transaction_begin();
     for (i = 0; i < mr->ioeventfd_nb; ++i) {
diff --git a/system/meson.build b/system/meson.build
index bd82ef132e7..4f44b78df31 100644
--- a/system/meson.build
+++ b/system/meson.build
@@ -2,7 +2,6 @@ specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: [files(
   'arch_init.c',
   'ioport.c',
   'globals-target.c',
-  'memory.c',
 )])
 
 system_ss.add(files(
@@ -15,6 +14,7 @@ system_ss.add(files(
   'dma-helpers.c',
   'globals.c',
   'memory_mapping.c',
+  'memory.c',
   'physmem.c',
   'qdev-monitor.c',
   'qtest.c',
-- 
2.39.5


