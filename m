Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE245E7545C
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 15:23:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYQhO-0000YH-GL; Wed, 24 Dec 2025 10:22:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYQhF-0000XM-D9
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 10:22:41 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYQhB-0004by-57
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 10:22:39 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-64b9d01e473so7531659a12.2
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 07:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766589754; x=1767194554; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LEvDE3B5Gu5UNxZmrWuHR20YlbHMtfAkLmTQrUNsEUM=;
 b=H09mEchkLf3EQAik4W3Ct38ubp6JKMK89lgYtNfQ2JcTuw3rFWZ1EaR0pYT/2gT3GK
 XpYJ0lhFTe9rYEB4JG/p/vOZ2WI6Llocbeq8qdNuJWgiCV+HkPGyIEFciRrEryuRRa7N
 2K88UsHefbBglRY2L8dl/7SZCHsg9jrl/ceJrImYMKas/WRoiYC7dRKaXFEOpMkBLSZl
 m1/Y8aghJhngl5JeRRLLaqU9agBDtcWL7KV0BYlHHUxGTtFhkfoyHN0k00WbGr5jPHHf
 pxrjlnBhHnQkI6q14sW80XO1Cr/Pv2irThcDHtNhlURG7D7YEYOOi94FPz37w6qQ6+B8
 p/0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766589754; x=1767194554;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LEvDE3B5Gu5UNxZmrWuHR20YlbHMtfAkLmTQrUNsEUM=;
 b=cWjLedBQpXGk6S5FizjYN6pIbRTyr/bP/+lz2KitsNqvGtzTN0I7JEbI7M1+NB/w3H
 G/97HAKznJaqSTdnEJ7Yuje09syqO3oCpQEMtAZ8Ind0RQNDXXGdPgTT6mLKyLnGR4Ta
 yq5Z5acge7krkn1trLZM9rHeMoHfz3hl6nlW5qr5jGGVCkvnTlAVElVUfjSHD1ZfD2D4
 juDJ+vmwxZerKn68L+QmrUe1FzMvCF4yEil9BmijapSJSbbcbRDAvX0hDrE7aEQoExmX
 HQ0yrU3gr/pReXMOr0eWmurU+hZa7yF6tBGn0U6lv7qWlRK2Tm3FhixBmSBi0WJNGqmL
 R1Ag==
X-Gm-Message-State: AOJu0Yx6EoAcLPHhVog4G/DR2R1E0NhHfZqAT6a3PUASTLDYQKRG77Ui
 xF4eHZipykgyd4RQ+7cJzEhB74xPERwtJEapm/3LBmI/QNQ6dp5Az9/7Z5BPIiJmPNFvbesRUyw
 +mgPZjWk=
X-Gm-Gg: AY/fxX6W7fkEX/kM4zYr6LIbJps2u7p99g7607A2pu0dZl5ll7jL4XQUOrU4XmzM4Mo
 Sev+/iXTKKSfVbV1DPP9kP3FbSip2nKB5/YNOW40rgRY83reLHxW2xPLl1IsVtxV/i/SBo8xjLw
 MQdUPp7EzJsnEO+M+Joq8NvWc2kURylHLJMeNRuxIuHH2kUUsVT6JB0tKAysF9dSuiPzUaX9IYW
 orz9Mi/EXl8B3Bc78d6QzeD2SK2jN5KGN/vNdJpNbcbHsnm1mg0tVtduUdtGMopsZ2Mynmg/str
 OgjgGsffR3jIAGaNfeGNdqzoac0wO/PD5qrX0z+NulAebp5ve3yivnHWkZpj6DarBKiDUmpKIW2
 khn5RHl4oueLpWpDo/j1lV6lTbF8C8mcrEsX+dw/DvySh5vHz6sT4HZqBKtCEGAMlUcO4ATYVwU
 72ev+T0+kWco8SJrDhUl+VrkK8IhcCW4u+q9UUgp/7S835IUaChUCiNaj8jLEN
X-Google-Smtp-Source: AGHT+IEZoqs0gLoI6WtdXWdfXWitTGn2kquDWsWYeNr3VeeWGtxi+ZBccX9rcVtfLpqt7YOtlCb99g==
X-Received: by 2002:a05:6402:1ecf:b0:64d:3550:4bb6 with SMTP id
 4fb4d7f45d1cf-64d35504e3dmr11787489a12.33.1766589753771; 
 Wed, 24 Dec 2025 07:22:33 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-64b90f53c51sm17340147a12.3.2025.12.24.07.22.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 07:22:33 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@kernel.org>
Subject: [PATCH v3 02/25] system/physmem: Convert DEBUG_SUBPAGE printf() to
 trace events
Date: Wed, 24 Dec 2025 16:21:45 +0100
Message-ID: <20251224152210.87880-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224152210.87880-1-philmd@linaro.org>
References: <20251224152210.87880-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x530.google.com
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

Defining DEBUG_SUBPAGE allows to use raw printf() statements to
print information about some events; convert these to tracepoints.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 system/physmem.c    | 29 ++++++-----------------------
 system/trace-events |  6 ++++++
 2 files changed, 12 insertions(+), 23 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index 1292f49095f..7e914ecf648 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -91,8 +91,6 @@
 
 #include "memory-internal.h"
 
-//#define DEBUG_SUBPAGE
-
 /* ram_list is read under rcu_read_lock()/rcu_read_unlock().  Writes
  * are protected by the ramlist lock.
  */
@@ -2903,10 +2901,7 @@ static MemTxResult subpage_read(void *opaque, hwaddr addr, uint64_t *data,
     uint8_t buf[8];
     MemTxResult res;
 
-#if defined(DEBUG_SUBPAGE)
-    printf("%s: subpage %p len %u addr " HWADDR_FMT_plx "\n", __func__,
-           subpage, len, addr);
-#endif
+    trace_subpage_read(subpage, len, addr);
     res = flatview_read(subpage->fv, addr + subpage->base, attrs, buf, len);
     if (res) {
         return res;
@@ -2921,11 +2916,7 @@ static MemTxResult subpage_write(void *opaque, hwaddr addr,
     subpage_t *subpage = opaque;
     uint8_t buf[8];
 
-#if defined(DEBUG_SUBPAGE)
-    printf("%s: subpage %p len %u addr " HWADDR_FMT_plx
-           " value %"PRIx64"\n",
-           __func__, subpage, len, addr, value);
-#endif
+    trace_subpage_write(subpage, len, addr, value);
     stn_p(buf, len, value);
     return flatview_write(subpage->fv, addr + subpage->base, attrs, buf, len);
 }
@@ -2935,10 +2926,8 @@ static bool subpage_accepts(void *opaque, hwaddr addr,
                             MemTxAttrs attrs)
 {
     subpage_t *subpage = opaque;
-#if defined(DEBUG_SUBPAGE)
-    printf("%s: subpage %p %c len %u addr " HWADDR_FMT_plx "\n",
-           __func__, subpage, is_write ? 'w' : 'r', len, addr);
-#endif
+
+    trace_subpage_accepts(subpage, is_write ? 'w' : 'r', len, addr);
 
     return flatview_access_valid(subpage->fv, addr + subpage->base,
                                  len, is_write, attrs);
@@ -2964,10 +2953,7 @@ static int subpage_register(subpage_t *mmio, uint32_t start, uint32_t end,
         return -1;
     idx = SUBPAGE_IDX(start);
     eidx = SUBPAGE_IDX(end);
-#if defined(DEBUG_SUBPAGE)
-    printf("%s: %p start %08x end %08x idx %08x eidx %08x section %d\n",
-           __func__, mmio, start, end, idx, eidx, section);
-#endif
+    trace_subpage_register(mmio, start, end, idx, eidx, section);
     for (; idx <= eidx; idx++) {
         mmio->sub_section[idx] = section;
     }
@@ -2986,10 +2972,7 @@ static subpage_t *subpage_init(FlatView *fv, hwaddr base)
     memory_region_init_io(&mmio->iomem, NULL, &subpage_ops, mmio,
                           NULL, TARGET_PAGE_SIZE);
     mmio->iomem.subpage = true;
-#if defined(DEBUG_SUBPAGE)
-    printf("%s: %p base " HWADDR_FMT_plx " len %08x\n", __func__,
-           mmio, base, TARGET_PAGE_SIZE);
-#endif
+    trace_subpage_init(mmio, base, TARGET_PAGE_SIZE);
 
     return mmio;
 }
diff --git a/system/trace-events b/system/trace-events
index 82856e44f2e..6d29a823f04 100644
--- a/system/trace-events
+++ b/system/trace-events
@@ -35,6 +35,12 @@ find_ram_offset_loop(uint64_t size, uint64_t candidate, uint64_t offset, uint64_
 ram_block_discard_range(const char *rbname, void *hva, size_t length, bool need_madvise, bool need_fallocate, int ret) "%s@%p + 0x%zx: madvise: %d fallocate: %d ret: %d"
 qemu_ram_alloc_shared(const char *name, size_t size, size_t max_size, int fd, void *host) "%s size %zu max_size %zu fd %d host %p"
 
+subpage_register(void *subpage, uint32_t start, uint32_t end, int idx, int eidx, uint16_t section) "subpage %p start 0x%08x end 0x%08x idx 0x%08x eidx 0x%08x section %u"
+subpage_init(void *subpage, uint64_t base, uint64_t len) "subpage %p base 0x%08" PRIx64 " len 0x%08" PRIx64
+subpage_accepts(void *subpage, char access, unsigned len, uint64_t addr) "subpage %p %c len %u addr 0x%" PRIx64
+subpage_read(void *subpage, unsigned len, uint64_t addr) "subpage %p len %u addr 0x%" PRIx64
+subpage_write(void *subpage, unsigned len, uint64_t addr, uint64_t value) "subpage %p len %u addr 0x%" PRIx64 " value 0x%" PRIx64
+
 # cpus.c
 vm_stop_flush_all(int ret) "ret %d"
 
-- 
2.52.0


