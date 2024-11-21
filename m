Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF4D4E64002
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 18:30:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEBvh-00085W-4G; Thu, 21 Nov 2024 13:29:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tEBve-00083h-TT
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 13:29:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tEBvb-0000o3-Ra
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 13:29:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732213757;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=46P5fCc+o6hH7ZVFiMBoQudmq3399lviu/5ndRrwzBo=;
 b=SK5ArTaQNEvqprozqmSy/6qi5cZOYeaudjcfVgMUF8EVvpkxkyLLEg9dJ4ODaFhYvgBinW
 UCIiNYSRFqHt23+8pZ5/MsjWsdug7xoj4puQt9XuD0I0PGqx0N06GCEWK/joK39y/YSSQU
 LaDkHWsS2LYBOyz+bJ/4F0PwcaUEj1g=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-woQuvcB6MiWyCsSca3cfWw-1; Thu, 21 Nov 2024 13:29:15 -0500
X-MC-Unique: woQuvcB6MiWyCsSca3cfWw-1
X-Mimecast-MFC-AGG-ID: woQuvcB6MiWyCsSca3cfWw
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-38235e99a53so719642f8f.0
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 10:29:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732213754; x=1732818554;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=46P5fCc+o6hH7ZVFiMBoQudmq3399lviu/5ndRrwzBo=;
 b=T8fRrUrYAV0joo7wkBSQ0aEVNhMREYwAjtOuxSrPGqAwKlS0wh3C0FM79Z3y+JD7aD
 J7EYfcHCojtBbViUtQ0zPmzU5SvzMob0jm9dkFMgq6frEwXOHwW5rdnR2sH8l188JdOx
 1VcnoeJjGOC/F0KQHW/IqQjHSCRukn9difhZAln+rfvjdo5f3q1i2uaIOKdHYpRIn54x
 D/8ib2qD2Na1m6kVUzRGJ3O39jgu9/LEW3lNIiRtYknmLdJ9fHCWAmh7qcvWUPlQ6HCP
 ZAK3l3ny+UgXssUgGq1yzPd1rGu+PMWZo4duCY7mRWrsOCu3Lne4zxjL/tUxvuFN4of9
 0QCw==
X-Gm-Message-State: AOJu0YwlbE0s2unfKe1+VoBF83Go0YjCUWs4EfWxIE1ltXhn9I2tXkh1
 RqMOnHDEOIcMJ4yvZwC2zQivmM4wxOPZH/OY59cJW2RNEBo8B5ItNdnc6kAgkKKS2Sry5Ji+WGD
 MAH+9Fq3eAh5u4BU3ZxUNFzTuV7jsn/b30dfXjN4sSxiAFs43b9+5qi3YXxqYyhn6cHzQcGDrey
 kJkRfHRyuLO3mSGuTmc7yhKWm1P5DgoAEzuHr9
X-Gm-Gg: ASbGncvWTj00qgxE2pFyr2NmCWtF39xElTujp6K6M5fsO0TVW+ZEJYxhIQkNRZCSRuu
 WoX2liOntT7UptuLxqgu7VxVmo0rFXp9mDVAtpNxRblU8/KcGJ+h36lstylr2WMcAxaX5rSTuQB
 MJ85Tst7+Ls8DizH5YiCUj34pbSj99mz9MQItAEWveavCHqyNbKhVyOXcOoRdah0TDkKz2j2vcE
 DpKOxn8shTNxbOQo2UUCKk9f4ndUeP2FOQEhErIQPkAkIkHqMTsuA==
X-Received: by 2002:a05:6000:1f8a:b0:381:f15a:e91 with SMTP id
 ffacd0b85a97d-382604ec295mr194235f8f.11.1732213753645; 
 Thu, 21 Nov 2024 10:29:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGIsK8gAk3mFWKo886ubeJMqXU9zbjRfIWOOjQwo/q9AExN/1IDj2zontDRvfL361KsO8PwHA==
X-Received: by 2002:a05:6000:1f8a:b0:381:f15a:e91 with SMTP id
 ffacd0b85a97d-382604ec295mr194218f8f.11.1732213753189; 
 Thu, 21 Nov 2024 10:29:13 -0800 (PST)
Received: from [192.168.10.3] ([151.62.196.119])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fbedeb3sm222233f8f.95.2024.11.21.10.29.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 10:29:12 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
 Akihiro Suda <akihiro.suda.cz@hco.ntt.co.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH v2] hvf: Enable 1G page support
Date: Thu, 21 Nov 2024 19:29:11 +0100
Message-ID: <20241121182911.272300-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
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


