Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F30051091904
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 19:11:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3Ila-00009P-Gr; Thu, 19 Mar 2026 15:10:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3IlZ-00009G-G9
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 15:10:45 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3IlX-0008RV-71
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 15:10:45 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-486fc4725f0so7818695e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 12:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773947441; x=1774552241; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=urtBToIHoqmm7zXCsb5LBhu17lqcZ4qoLoYRqjsR7h0=;
 b=L2vBLHpR8PxQoLpaqYBn2JQwf4PvBhDyNv80+ulTiJug2kE0GNfJZy3rxoTax167ek
 wTzK6w2ZHBWqz20C2PRpy7aIYKVBpyoefGZckUVgVMRiYlIsCMfzQzjTkru4cMI8/x4s
 JLbjJuxegvvZxsltpnC6xecDmIt/4isdJZ3gzrtodslOUOgYn/FE3zEow1Ig3iRSTxvt
 MfWHOcyXbPO6vEVpyOYWpOuFDsdViACNs5dgwEka3OsiIx/rFYGUEvHnxQdZuqudiPEM
 EzUC4bUtKplpwc38jfJLuNfgndopP2erqi1f0Dv4J7hZTq10jFko6uAhi9Ddnc5deENk
 i+GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773947441; x=1774552241;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=urtBToIHoqmm7zXCsb5LBhu17lqcZ4qoLoYRqjsR7h0=;
 b=aqDyOjPe+DwiS4fyY84qbrE2QEWLE9cV2hQRrtjVV7Nw6BPUgm6+MBVLPb2Moxq96e
 l02JfcEA2YXgfhfRXZw9NZJ8Y9sLSi7GMc9WfRrwG4c1+1BWBTGhoU0O+RuzCIK7YAK9
 sG8jYcDiSn9aJoxvKvoqE0Nw9jxaB4aF7OgB+hqYaCiole1ZMKfwHkbS+8gKKjpOmWyC
 Rqcczp0lp6ZyuiMIZ49VaEvUAv4bUnJV8J2UWhByBPo++ZUk+iPSiG8CKBHrEeQulEF0
 6gyx/L0Flt6zO/y8I4+CjWBWQlcSPhnvJVOwLiXz/RsMF1WCBZK5v1qJCIhyj2x/Xs8X
 gnBA==
X-Gm-Message-State: AOJu0Yz13Ysg/s0rlRhISW4thhfOFdsFWVMFzEHVQ9s3SkxUS9MR59C1
 C6utoxQG7FrkpugufBECnGFvG/4aL5COyp7WZBoDG/b6rFykWPrKmFPpKmXSL21SAxSC6KPzpC8
 KzUxsn70=
X-Gm-Gg: ATEYQzzfHPr0WrFtgaZRkR7qeZH0gy8Cn9NQA8ulYS0K/ZViHKW6vy2J73xpL5A/i20
 W2TF4lCTerv84QW5EOtSvQzo4NhNuOG1rTVovQYjl0pMLfVk/ULO08RmDv9mKTg3j176Sl59IqK
 pZH8dhhbNMijdZ/Qvg5h10+uXt+xcX84hupxAR3hQ+Ebrvv7nk/iSQAqRG9B1RO8PmfR2zD26z6
 Su7UahHjiw0+LhBb3fR+hmpm9JikUCQLjLe2auAlGnnGqfnDEKnlWhfp9c8nOXEkVQFaagzsoj5
 8dopQNBtioj/zoevnceux37pAROk6iPq186WcaqzGoAX9Y4kXpMloZw4q5HdVl0OzXHbcC0TqXw
 Iu90mUE8kjWAwOuIuztdDJBwWG5ODROiX4xjfexCUFcaKitNRWToBY8Bf6Dgut+Pu6v08nNaNwY
 AVrLTTberAjZDWQu8XpWo69DV+WkqRBZDtpiQ1KFObH+HtJOf4/NtPMVGJZC36tNgUgUjJx2L9
X-Received: by 2002:a05:600c:350b:b0:485:3f58:da2 with SMTP id
 5b1f17b1804b1-486fe8fcf64mr7383985e9.16.1773947441003; 
 Thu, 19 Mar 2026 12:10:41 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486ff109b95sm1697385e9.1.2026.03.19.12.10.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Mar 2026 12:10:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-11.1 3/8] system/memory: Constify various AddressSpace
 arguments (xlat)
Date: Thu, 19 Mar 2026 20:10:12 +0100
Message-ID: <20260319191017.12636-4-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319191017.12636-1-philmd@linaro.org>
References: <20260319191017.12636-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Mark the AddressSpace structure const when it is only accessed read-only.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/memory.h |  4 ++--
 system/physmem.c        | 10 ++++++----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index 858dc40dc5f..38e4f7b25e5 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -2783,7 +2783,7 @@ void address_space_flush_icache_range(AddressSpace *as, hwaddr addr, hwaddr len)
 /* address_space_get_iotlb_entry: translate an address into an IOTLB
  * entry. Should be called from an RCU critical section.
  */
-IOMMUTLBEntry address_space_get_iotlb_entry(AddressSpace *as, hwaddr addr,
+IOMMUTLBEntry address_space_get_iotlb_entry(const AddressSpace *as, hwaddr addr,
                                             bool is_write, MemTxAttrs attrs);
 
 /* address_space_translate: translate an address range into an address space
@@ -2804,7 +2804,7 @@ MemoryRegion *flatview_translate(FlatView *fv,
                                  hwaddr *len, bool is_write,
                                  MemTxAttrs attrs);
 
-static inline MemoryRegion *address_space_translate(AddressSpace *as,
+static inline MemoryRegion *address_space_translate(const AddressSpace *as,
                                                     hwaddr addr, hwaddr *xlat,
                                                     hwaddr *len, bool is_write,
                                                     MemTxAttrs attrs)
diff --git a/system/physmem.c b/system/physmem.c
index 23ea6b69255..bbcbcedda15 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -528,19 +528,21 @@ static MemoryRegionSection flatview_do_translate(FlatView *fv,
 }
 
 /* Called from RCU critical section */
-IOMMUTLBEntry address_space_get_iotlb_entry(AddressSpace *as, hwaddr addr,
+IOMMUTLBEntry address_space_get_iotlb_entry(const AddressSpace *as, hwaddr addr,
                                             bool is_write, MemTxAttrs attrs)
 {
     MemoryRegionSection section;
     hwaddr xlat, page_mask;
+    AddressSpace target_as = *as;
+    AddressSpace *ptarget_as = &target_as;
 
     /*
      * This can never be MMIO, and we don't really care about plen,
      * but page mask.
      */
     section = flatview_do_translate(address_space_to_flatview(as), addr, &xlat,
-                                    NULL, &page_mask, is_write, false, &as,
-                                    attrs);
+                                    NULL, &page_mask, is_write, false,
+                                    &ptarget_as, attrs);
 
     /* Illegal translation */
     if (section.mr == &io_mem_unassigned) {
@@ -552,7 +554,7 @@ IOMMUTLBEntry address_space_get_iotlb_entry(AddressSpace *as, hwaddr addr,
         section.offset_within_region;
 
     return (IOMMUTLBEntry) {
-        .target_as = as,
+        .target_as = &target_as,
         .iova = addr & ~page_mask,
         .translated_addr = xlat & ~page_mask,
         .addr_mask = page_mask,
-- 
2.53.0


