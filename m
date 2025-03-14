Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51F5BC282EC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 17:39:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt8tu-00063G-IT; Fri, 14 Mar 2025 13:32:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tt8tL-0005gW-9L
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 13:32:16 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tt8tF-0008JT-E5
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 13:32:14 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-225df540edcso18254665ad.0
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 10:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741973524; x=1742578324; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EBRugwqnxw4q7Phz2P050i5IjB6Zbf1WGwdoEilqtkY=;
 b=bq/hioWF6BlpZB8kw8QqycHbjAXtdCj5BaYZo6e3k5D3JcMCaMdBNPAhlLh9uT3jDG
 RuUaiiKvnOg9JOgbGcLU0TDLoeEPHYXtNlFx+JRsHyAYfpFlI3s3C2fgvt5ItCj7bEcg
 9XKJuOF9cxcdt5qYt2bwfl+c7hwU3ryCMhRbsISzlcvdNkRpnSL1TQ83YMtVYB5HFh9F
 hoxZZWMDW1R618UFlR8xkT4MkOV0KfFma5d0AZz+Rq9BcH2TX6LguNJ3DVEg3DdUFzEG
 J6vEVGWVL6AO/4Z0gYQVITCgIHwS2xwVbQrNdF/QKNUWvmibQZz2lhqomL4l6SNzCGUC
 hb4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741973524; x=1742578324;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EBRugwqnxw4q7Phz2P050i5IjB6Zbf1WGwdoEilqtkY=;
 b=n4thnmdXFa/OzN+U07s8CZJ9Pxm94avCKEi7sBfSyKInVtcCJs4KjnC0r7BLe0NA//
 qizUqjxmiXgi9YotS7q6ipyKT+LS6i7QlTLUzBbQYX1mCqP0nIONKPhv3wxkY73CyrRO
 YrshyjagjWj0Q4qZFlV5LkA+rDHwWSYehj+vG9X1V9U3tDl3hLROm2U1RO73mwm8FtgT
 iQQyXbmerlEg6tG8d0hcheVi2iSjWrFcmHL4jlMNp90VODPErL5FS1mZ/57e7jEw/qHR
 InLRKQ2vFXWhRbJtCqPUgjPm8fmLblLtv6awf1GUreez1u0hChhSixIZKljl8Utoia63
 v3xg==
X-Gm-Message-State: AOJu0Yz2iDgzhwGSxUOfbykH5OkxNVV5BM1QTFlSI36hTTn2NrfcGApd
 DOlUdKbdWDFwO6/4eJ4Pu6yqm/xvHm/MvanpBTBubCgMmZp6iyPzOUPKBmEw/5fvKAxxOQxczve
 fKuo=
X-Gm-Gg: ASbGncto5i4Xgx1WU3q45CsFwrPrtXW1xsv8JRahcxpAaFaCwb0+z0D+E6PV/LJw6FT
 2SmfX/++AptpPqLpME0qipXFpIwAULwZ0pF2mT9EBbbn5etrpQeF6ovaCXDnuHXVFjT151OMIpl
 gKAHQfOaXjHjCEGa2LqTD7/75PvW7MhOHInQp6jwAZdP1KxWvxJFcBQmQvfjm5t+eCJ/THGqeu9
 qovkUTfYp/qJIM7k+SOQbuQ7I7EYz9V6rQy2BwdIvqDG3xjWSp410kd/tVcP/WbxDtGM4Vpl1XH
 9aH7lglH6ue/FCHT5DIIVdH/dYx3WkbFm26UtyOihepQ3kuWgapFeRU=
X-Google-Smtp-Source: AGHT+IFTScYSX7clzsDQUywbpsrF2iPQsXcqATUvOkRpCep5DuIqTnkqpSfhY4o7FVAe26d7sGjRdg==
X-Received: by 2002:a05:6a21:1583:b0:1e1:a449:ff71 with SMTP id
 adf61e73a8af0-1f5c279ef94mr4638551637.1.1741973523678; 
 Fri, 14 Mar 2025 10:32:03 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56e9cd03bsm2990529a12.8.2025.03.14.10.32.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 10:32:03 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Paul Durrant <paul@xen.org>, Peter Xu <peterx@redhat.com>,
 alex.bennee@linaro.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-riscv@nongnu.org,
 manos.pitsidianakis@linaro.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Anthony PERARD <anthony@xenproject.org>, kvm@vger.kernel.org,
 xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 16/17] system/memory: make compilation unit common
Date: Fri, 14 Mar 2025 10:31:38 -0700
Message-Id: <20250314173139.2122904-17-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250314173139.2122904-1-pierrick.bouvier@linaro.org>
References: <20250314173139.2122904-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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


