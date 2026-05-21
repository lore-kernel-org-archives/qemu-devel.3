Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A580ECD343F
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 05:57:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPwPE-0004JQ-LX; Thu, 21 May 2026 01:57:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wPwPD-0004JI-Sk
 for qemu-devel@nongnu.org; Thu, 21 May 2026 01:57:15 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wPwPC-00053s-6C
 for qemu-devel@nongnu.org; Thu, 21 May 2026 01:57:15 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-651c5d525f6so5906756d50.3
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 22:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779343032; x=1779947832; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9WgwWsBQpiwXGC6wPWiI27XHB3HRkpy73BshEssfsZg=;
 b=pHxigMdhw3HkbSrQSSJYUOP04tJsskQR9cFN5rLpU6mruXo+kzgz8qCWi5OOPBKycb
 cP6i2WmQdz6/K6/Dyo6pfHdVMqKo1caZTF6/STZ7apuQQsX4y908IIpInMWuJEhswIyg
 9/JaVYZ9ZaPWVytFp5yvR9dOxrmwPBey8Zg8fZM02iYxHNzuOd4+kj7CYN2Uv12vHc2T
 apNQ649eBLI3DvZzwOHm0KSjEGHt5A3Z8s9yD/wBNlwHwVWWOxQ27HBltdLg0V2aDdu6
 vrWPFxoBHqwsi5/GzyHYgJehOpF6Mk24uQypHNp0Ug8X069VmdMnhTd05YypfWsqSDCl
 sJzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779343032; x=1779947832;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9WgwWsBQpiwXGC6wPWiI27XHB3HRkpy73BshEssfsZg=;
 b=pqn7k2P6feJ239ozqG6VTH7FGPBQ7y+VkYEDFr7Vj9J2R+NHKaUf0GcNxAzZw6B4YE
 gr9C47xhO+6FxGY8j790SEmwB/FR4cAQFEAD5c9ny96T9TEPfs+LCEaUDoxa5LTkaPVU
 qGe/jHMtCPKkn0qsoNe6Q0HcFZuvTXxwP98fB2hv4wbJOZwj/LZW3cCuxc8/qkmvVBVi
 /Nq1LNp+Kpm5K6VR2poMjc2UmRukC69brnOzDnDLaCt8g7YhuEbcitko+28hd2SATSOg
 5CwwOy6HaBMQWWno9qM2tmcDLowKsLg/PB/U75xczBL0JgfXZgrKbtHjBxq6GX51fMDA
 0hQQ==
X-Gm-Message-State: AOJu0YydflZsJlenveFx30VItk1eQA8rrTeFavE/YOQ5fNQ/pboS73Sg
 co6jZjrjQvBYPiw1rKBQZW2I65LsUGDfL5Ph/bIIBdfsDW2p/fEvWwMqNQzmlixo
X-Gm-Gg: Acq92OFDTf2XbYXPCTLPq9FzRPAzWT+c1u0stLffMl2LxRKJwwL6Dv3aNh9kJVO11OI
 ilTqWyrnMy+zcKBAcHXCdT29JgIpr/01AYmiGF0shK6NcvP7fFyaJnBtmWwMC0SldFpgfx/WCA6
 AuQOTna2tpOHMZttOZ5ybex/53rHxOJhRfjTVlF0ONB710EK91qFNcOpct53mzadmkd+FghyG1s
 OLPs19TRfPLWpl/VUx83yJtMNJCg582oxM3q8lpTdQVTZIfd68LYkZtohiR2Kw8NIeCSN/WIwAz
 eckvke9hP18N3+ebHPI0Ya5EbAJ+CSScnBY48GQ31wsPc25vfmcs7YS3P1zuNwI+HNPWgNR0Nyg
 LtDONR2Gc1W5fmgjIDehB7UUI/qxdEt/TOt2ZNHgVJs11MppDFZl0KG5k51CPrtePx1o9kE40nZ
 3FXEMYgWETUYwvtKew3Eaf3upSz61r+b7kQAYZByLp7UR8bJbMYUiLsNoDmVGthz1qL1IvcX93M
 kA2sjWFRoWYXw==
X-Received: by 2002:a05:690c:d19:b0:7bd:7b55:ebe1 with SMTP id
 00721157ae682-7d20a99c3bcmr15884957b3.1.1779343032530; 
 Wed, 20 May 2026 22:57:12 -0700 (PDT)
Received: from localhost (107-220-129-194.lightspeed.chrlnc.sbcglobal.net.
 [107.220.129.194]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-7cc9cda1fbbsm62814057b3.44.2026.05.20.22.57.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 22:57:11 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matt Turner <mattst88@gmail.com>
Subject: [PATCH] linux-user/hppa: add coredump support
Date: Thu, 21 May 2026 01:56:45 -0400
Message-ID: <20260521055707.1380061-1-mattst88@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=mattst88@gmail.com; helo=mail-yx1-xb12d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Add HAVE_ELF_CORE_DUMP, target_elf_gregset_t (80 entries matching
arch/parisc/include/uapi/asm/ptrace.h), and elf_core_copy_regs().

The struct layout matches the kernel's struct user_regs_struct:
  gr[0..31]    at indices [0..31]   (PSW in gr[0])
  sr[0..7]     at indices [32..39]
  iaoq[0..1]   at indices [40..41]  (instruction address queue)
  iasq[0..1]   at indices [42..43]
  sar          at index   [44]      (shift amount / CR11)
  iir          at index   [45]      (interrupt instruction register)
  isr          at index   [46]      (interrupt space register)
  ior          at index   [47]      (interrupt offset register)
  ipsw         at index   [48]      (interrupt PSW / CR22)
  cr0          at index   [49]      (recovery counter)
  cr24_31[8]   at indices [50..57]
  cr8_15[6]    at indices [58..63]
  pad[16]      at indices [64..79]

elf_core_copy_regs() saves GRs, IAOQ (front/back), and SAR.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
I don't know if this is something that can go to stable?

 linux-user/hppa/elfload.c    | 13 +++++++++++++
 linux-user/hppa/target_elf.h | 21 +++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git ./linux-user/hppa/elfload.c ./linux-user/hppa/elfload.c
index 7f7ece6dc1..3354e1b840 100644
--- ./linux-user/hppa/elfload.c
+++ ./linux-user/hppa/elfload.c
@@ -16,6 +16,19 @@ const char *get_elf_platform(CPUState *cs)
     return "PARISC";
 }
 
+void elf_core_copy_regs(target_elf_gregset_t *r, const CPUArchState *env)
+{
+    int i;
+
+    memset(r, 0, sizeof(*r));
+    for (i = 0; i < 32; i++) {
+        r->gr[i] = tswapal(env->gr[i]);
+    }
+    r->iaoq[0] = tswapal(env->iaoq_f);
+    r->iaoq[1] = tswapal(env->iaoq_b);
+    r->sar     = tswapal(env->cr[CR_SAR]);
+}
+
 bool init_guest_commpage(void)
 {
     /* If reserved_va, then we have already mapped 0 page on the host. */
diff --git ./linux-user/hppa/target_elf.h ./linux-user/hppa/target_elf.h
index 76930c9369..e1c5033242 100644
--- ./linux-user/hppa/target_elf.h
+++ ./linux-user/hppa/target_elf.h
@@ -12,6 +12,27 @@
 #define ELF_MACHINE             EM_PARISC
 
 #define HAVE_ELF_PLATFORM       1
+#define HAVE_ELF_CORE_DUMP      1
+
+/*
+ * Matches struct user_regs_struct from arch/parisc/include/uapi/asm/ptrace.h.
+ * ELF_NGREG = 80; register indices match those used by libunwind and gdb.
+ */
+typedef struct target_elf_gregset_t {
+    abi_ulong gr[32];      /* gr[0..31]; PSW in gr[0]            [0..31] */
+    abi_ulong sr[8];       /* space registers                    [32..39] */
+    abi_ulong iaoq[2];     /* instruction address offset         [40..41] */
+    abi_ulong iasq[2];     /* instruction address space          [42..43] */
+    abi_ulong sar;         /* shift amount register (CR11)       [44] */
+    abi_ulong iir;         /* interrupt instruction register     [45] */
+    abi_ulong isr;         /* interrupt space register           [46] */
+    abi_ulong ior;         /* interrupt offset register          [47] */
+    abi_ulong ipsw;        /* interrupt PSW (CR22)               [48] */
+    abi_ulong cr0;         /* recovery counter                   [49] */
+    abi_ulong cr24_31[8];  /* cr24..cr31                         [50..57] */
+    abi_ulong cr8_15[6];   /* cr8, cr9, cr12, cr13, cr10, cr15  [58..63] */
+    abi_ulong pad[16];     /* pad to 80 elements                 [64..79] */
+} target_elf_gregset_t;
 
 #define LO_COMMPAGE             0
 #define STACK_GROWS_DOWN        0
-- 
2.53.0


