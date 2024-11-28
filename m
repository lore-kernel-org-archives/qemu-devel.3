Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3CE9D70DEE
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 19:05:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGjoC-0007U7-Gf; Thu, 28 Nov 2024 14:04:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tGjo4-0007RG-1S
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 14:04:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tGjo1-00013R-AZ
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 14:04:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732820639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=46P5fCc+o6hH7ZVFiMBoQudmq3399lviu/5ndRrwzBo=;
 b=KXJaSC9r5vGCZjjNtmE+CKWzph8fAR3AFwF8jRoHcdUPr4G/LEdpdo+Zcu/uYsqa6I4JSN
 bv/HhmCqBeTyNIDwYUrg/wo7ttc/QQG4T3s8+ZTrE6ql3i1o7PS6QTOiGPvaDPEe53bI2M
 C5+UcbZF4nzPyrDPCi3g1us8mwESD9w=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-p0_k8p6INoG8bGKn2L_aOQ-1; Thu, 28 Nov 2024 14:03:58 -0500
X-MC-Unique: p0_k8p6INoG8bGKn2L_aOQ-1
X-Mimecast-MFC-AGG-ID: p0_k8p6INoG8bGKn2L_aOQ
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-434a876d15cso11565235e9.0
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 11:03:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732820636; x=1733425436;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=46P5fCc+o6hH7ZVFiMBoQudmq3399lviu/5ndRrwzBo=;
 b=pT+TqSxd1A1YyJ5l11KWPfrsL6v3mrsT3sM/KSlOqPolbL7dzJ8e4JnBKWFslwDd9D
 didJw8SyluXGn42RDn9LfQwjC0C74dgw8eWBQWHnFM0o4eUfpLSa9lnFoUJAlCHb54z7
 hWVxjJldTjQ3g38RDWQ81Nd/pSzznVYPsS2NyZ5Ymz9OXH71aBERZRiWciHCUcUW5sSp
 GuTrC86aknCCmYV4/PNpODor5XoOi7DiM8VoP9wDQvrlHZlwR0EV0p5pfdRiJbfEFdb6
 Nnx3EScUsspnnWPlHQ/1EvT7Pj5xyouWm5mLZW7p1Yd1O7aK9a99k7YHFIljNy9JYXN4
 2yGg==
X-Gm-Message-State: AOJu0YwSZD7lG4pI9iapP6z0L/LbPVlqzrUGP0JNahMPPpHcLkqHfWLP
 29IS9cnEJPy/RiIgMfijKbsrM841NtuS2GcEtrH/Fb51b6V1dEO7el1hF6B1w5IaMwUHnVeDNB7
 iyKXnlwTmh7nzSlMwRMqmGluLY3A29mgkw0pOJAlwXsbBY8EEx1ToCP9Cco98I6cV47mhJEsJkL
 gIrSjs/ik6umrFzafLOm9zt6fqCKtUmLOJgwO1
X-Gm-Gg: ASbGncvvFMs0ivAwT8Ij4MTxYmgUJqFvlpCdjyqSvzSxy2XoGXND2jKyrBzpjfaT3eV
 H/itNaEs/O447cJgmXh98iUaBIRA+7pHarKMPiXtfZTyQcizOACFVfu5gYtXTzo4KNjIVB+UxH/
 YqYdMqvQ8nfh9nl8SEMbTz7W1GjnF1zhntAXf86H1gNk3Omeg4ZWhHro+NufKAFayhpuYa9C6zn
 KanZlFo54mXBhSyVU89x/HyR3MqvRdILwzWXqCHhQ8mRJpVBSsRGqk=
X-Received: by 2002:a05:600c:1c0a:b0:434:9fca:d6c3 with SMTP id
 5b1f17b1804b1-434afb9efa7mr36440855e9.9.1732820636431; 
 Thu, 28 Nov 2024 11:03:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFcIQhAjRqi1hRvhTolooHgF97VGizS/qP5LafGKxgrVGBnHyDwMQRN59plKOBPByk8tMX3oQ==
X-Received: by 2002:a05:600c:1c0a:b0:434:9fca:d6c3 with SMTP id
 5b1f17b1804b1-434afb9efa7mr36440205e9.9.1732820635502; 
 Thu, 28 Nov 2024 11:03:55 -0800 (PST)
Received: from [192.168.10.47] ([151.49.236.146])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434b0dc6831sm30003565e9.20.2024.11.28.11.03.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 11:03:54 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
 Akihiro Suda <akihiro.suda.cz@hco.ntt.co.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PULL 2/3] hvf: complete 1G page support
Date: Thu, 28 Nov 2024 20:03:48 +0100
Message-ID: <20241128190349.541014-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241128190349.541014-1-pbonzini@redhat.com>
References: <20241128190349.541014-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Alexander Graf <agraf@csgraf.de>

Hvf on x86 only supported 2MiB large pages, but never bothered to strip
out the 1GiB page size capability from -cpu host. With QEMU 8.0.0 this
became a problem because OVMF started to use 1GiB pages by default.

Let's just unconditionally add 1GiB page walk support to the walker.

With this fix applied, I can successfully run OVMF again.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1603
Signed-off-by: Alexander Graf <agraf@csgraf.de>
Reported-by: Akihiro Suda <akihiro.suda.cz@hco.ntt.co.jp>
Reported-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Phil Dennis-Jordan <phil@philjordan.eu>
Link: https://lore.kernel.org/r/20230420225258.58009-1-agraf@csgraf.de
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/hvf/x86_mmu.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/target/i386/hvf/x86_mmu.c b/target/i386/hvf/x86_mmu.c
index 649074a7d24..579d0c3a4cc 100644
--- a/target/i386/hvf/x86_mmu.c
+++ b/target/i386/hvf/x86_mmu.c
@@ -38,6 +38,7 @@
 #define LEGACY_PTE_PAGE_MASK        (0xffffffffllu << 12)
 #define PAE_PTE_PAGE_MASK           ((-1llu << 12) & ((1llu << 52) - 1))
 #define PAE_PTE_LARGE_PAGE_MASK     ((-1llu << (21)) & ((1llu << 52) - 1))
+#define PAE_PTE_SUPER_PAGE_MASK     ((-1llu << (30)) & ((1llu << 52) - 1))
 
 struct gpt_translation {
     target_ulong  gva;
@@ -96,7 +97,7 @@ static bool get_pt_entry(CPUState *cpu, struct gpt_translation *pt,
 
 /* test page table entry */
 static bool test_pt_entry(CPUState *cpu, struct gpt_translation *pt,
-                          int level, bool *is_large, bool pae)
+                          int level, int *largeness, bool pae)
 {
     uint64_t pte = pt->pte[level];
 
@@ -118,9 +119,9 @@ static bool test_pt_entry(CPUState *cpu, struct gpt_translation *pt,
         goto exit;
     }
 
-    if (1 == level && pte_large_page(pte)) {
+    if (level && pte_large_page(pte)) {
         pt->err_code |= MMU_PAGE_PT;
-        *is_large = true;
+        *largeness = level;
     }
     if (!level) {
         pt->err_code |= MMU_PAGE_PT;
@@ -152,9 +153,18 @@ static inline uint64_t pse_pte_to_page(uint64_t pte)
     return ((pte & 0x1fe000) << 19) | (pte & 0xffc00000);
 }
 
-static inline uint64_t large_page_gpa(struct gpt_translation *pt, bool pae)
+static inline uint64_t large_page_gpa(struct gpt_translation *pt, bool pae,
+                                      int largeness)
 {
-    VM_PANIC_ON(!pte_large_page(pt->pte[1]))
+    VM_PANIC_ON(!pte_large_page(pt->pte[largeness]))
+
+    /* 1Gib large page  */
+    if (pae && largeness == 2) {
+        return (pt->pte[2] & PAE_PTE_SUPER_PAGE_MASK) | (pt->gva & 0x3fffffff);
+    }
+
+    VM_PANIC_ON(largeness != 1)
+
     /* 2Mb large page  */
     if (pae) {
         return (pt->pte[1] & PAE_PTE_LARGE_PAGE_MASK) | (pt->gva & 0x1fffff);
@@ -170,7 +180,7 @@ static bool walk_gpt(CPUState *cpu, target_ulong addr, int err_code,
                      struct gpt_translation *pt, bool pae)
 {
     int top_level, level;
-    bool is_large = false;
+    int largeness = 0;
     target_ulong cr3 = rvmcs(cpu->accel->fd, VMCS_GUEST_CR3);
     uint64_t page_mask = pae ? PAE_PTE_PAGE_MASK : LEGACY_PTE_PAGE_MASK;
     
@@ -186,19 +196,19 @@ static bool walk_gpt(CPUState *cpu, target_ulong addr, int err_code,
     for (level = top_level; level > 0; level--) {
         get_pt_entry(cpu, pt, level, pae);
 
-        if (!test_pt_entry(cpu, pt, level - 1, &is_large, pae)) {
+        if (!test_pt_entry(cpu, pt, level - 1, &largeness, pae)) {
             return false;
         }
 
-        if (is_large) {
+        if (largeness) {
             break;
         }
     }
 
-    if (!is_large) {
+    if (!largeness) {
         pt->gpa = (pt->pte[0] & page_mask) | (pt->gva & 0xfff);
     } else {
-        pt->gpa = large_page_gpa(pt, pae);
+        pt->gpa = large_page_gpa(pt, pae, largeness);
     }
 
     return true;
-- 
2.47.0


