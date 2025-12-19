Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9C83D78770
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 16:20:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWdDQ-0006A8-SS; Fri, 19 Dec 2025 11:20:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWdDJ-00060h-MZ
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 11:20:21 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWdDH-0005xA-LD
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 11:20:21 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4775ae77516so18278395e9.1
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 08:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766161218; x=1766766018; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LEvDE3B5Gu5UNxZmrWuHR20YlbHMtfAkLmTQrUNsEUM=;
 b=yzZXBiaIhq/PIimvcZNeV8sMMorGg/MVHNTW7Hwifqxq9m6hzjUw36TQ8QiJhj2paa
 Ukhrl8W5VgpsqOrz3q6LiJIjtw5pWkKLdeqvZryigM5jS3MsGwsn2sPrp9otjkAzSraU
 S7APCrz03LYLK2ZkTcqts5xqzsI+I/eJrW+W+dl2kBAn+LD9dVGqcjFwo+nDgbk7he9G
 dQ1JMI4tur3G7TZMKmrmUEgaiRkPRG4CSrEP9rUuZV/KNzXhpyqFfkgI6GgeRmcvxnKF
 V8QzYwL4qw0u9RRY4Ov4aJ7JTKUaBAAJ+8e18pGCpRTadzud5QDssozvibpIVaWVMzNa
 xvdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766161218; x=1766766018;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LEvDE3B5Gu5UNxZmrWuHR20YlbHMtfAkLmTQrUNsEUM=;
 b=vmwbP4pPNtHXKe85Kd6RaaTtcWmB/9PCwBNgX+dMyAaurCreu8/Qv9ZZ1iGgqG6gCI
 3L2WBckEWLw6E07yHe64sFYtCryFbfgrSyRY6Zbh8SBIc42MxnNX87kJ52DwU9m2Fl0C
 SZ0B5ixlZvd74k/p+pcXK5sEadgzd9lV0aM9/rxWojABJj5RkPwlrZBY6YnUEk8UkRIU
 GkiZcZXMz7vjivW6lsguY9AOvjZjnbHr6lsxEBVufD3LHlr7Q/PI+jU4OOk4xaGbtMSX
 QiV0CIX0QgR9ncvFphM1NcZjM040JQLGixNRxK/C0hFYHOuQFGCinSzHMyzX11y1uRJz
 rbKw==
X-Gm-Message-State: AOJu0Yw6lrsxg4P9W+C0et868LZW676QszwvlwpHPezD2klvjvQQgvPw
 4CWHA2jU+7/h0CqkiCDahDmH1xmc/UV66PYA5DXLsm4nEKmz4RpY4QCyAccLjn1jYGKYsxXgrje
 aY4OfVVc=
X-Gm-Gg: AY/fxX50NcmBEDyaBb5SgidxNzOtIZij08/lleybggv1G7UQhlcLk0dxZvf/yDiAGdB
 VyHR9EhibNmxtdAVBrEwpYUODlGcboxO3QjDeM6EVBRiYyNRin08VR0F6otsqoCkhlw547yx6LH
 3ou9eudPeIrtKEtACtk0OMWWVmAfdiDrfKQNFRsUPjLyQ3Rw2KvA/sDqFI2CTnp44Czl/ApfBCi
 I8NV3ntZIxruAcqYQbMV6TJaoo3esc9CIhqh1Vqt6+qFlpqIj6lyI2+ySy5eIS8TK6vsdeZv89q
 BOmaqx4CpbA4c/6dsmVokDMq1xTpeQvCB5nQztx0Fmh02TrOjQ3IaVaib7huK7kvv7uDhrrt3Xa
 C/ORw+SV/fu4E+0fKvVndNTk09GNlQJFbGTELiLadX3ddER8mXvdlknZtysdDwdm8hbqAjDV4mG
 56fYh9rx758UJx9VeuZ3A1BJQ5GfEuuu7Shm4l4ontzTN6XYw0aI9s2/yVteit
X-Google-Smtp-Source: AGHT+IH6+FhWDAiyt15vIG+85wrVo/LPfB8xxODpVr5Or0G80hpeRmqcdVLaH2w91oN8VAIldk9TOg==
X-Received: by 2002:a05:600c:8718:b0:45d:f83b:96aa with SMTP id
 5b1f17b1804b1-47d1956eba9mr27156495e9.7.1766161217777; 
 Fri, 19 Dec 2025 08:20:17 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d193cba81sm50153235e9.10.2025.12.19.08.20.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Dec 2025 08:20:17 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, David Hildenbrand <david@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 03/24] system/physmem: Convert DEBUG_SUBPAGE printf() to
 trace events
Date: Fri, 19 Dec 2025 17:19:30 +0100
Message-ID: <20251219161953.72724-4-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251219161953.72724-1-philmd@linaro.org>
References: <20251219161953.72724-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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


