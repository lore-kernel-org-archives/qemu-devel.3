Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34A9ED64072
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 17:40:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9SwY-0003sg-Ih; Fri, 08 Nov 2024 12:38:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t9SwW-0003ow-TW
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 12:38:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t9SwV-0007aK-Bv
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 12:38:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731087522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xJEvnVPMWDdQ2tnHSvFER1PvS665SI7hrD6PrD0x/g4=;
 b=OW7mvDH+s1XWrlQk8P5HyKSvAk3qF2PDcLZBvd2Ey2aPUvw+OsE82ybE5H7Ez/FablAZuJ
 NR9t4zfKGfUdvOY2QtPoggVH6slFTAjh/PXKbVRDWmH/qHU69yv/DExInRfA9q4YUaYGhz
 JnzuS5wJdlZBnYkXLVPeHr+Ot0PgdIw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-ji5ktCbnOMOO9C2GXKki0A-1; Fri, 08 Nov 2024 12:38:40 -0500
X-MC-Unique: ji5ktCbnOMOO9C2GXKki0A-1
X-Mimecast-MFC-AGG-ID: ji5ktCbnOMOO9C2GXKki0A
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37d5016d21eso1254410f8f.3
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 09:38:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731087518; x=1731692318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xJEvnVPMWDdQ2tnHSvFER1PvS665SI7hrD6PrD0x/g4=;
 b=OvbYDim5/xjKZoVNgSaTMOVDTaVerWsTJYQY7qI+m8oPl99rHs4xvvLH3uUZQu+rok
 guEKnbfG55Q0yc3iYZTv6OXnvmq/huvv40OL4YgQnwGu4tXISO5gFeAgdofSPJRNFpZS
 k75mpQsOBIRCCtisD3vfOWzD5fGx44hDeo8SBSCkyTqoURECY+5+Q2Prr3007y+UYzDy
 7AJddO9gsiRxJ4AXXeKY5zanM1MA/cksM6phQijxWX9FQg050V4+wBDZ+d+cI8cC4u5v
 0XH/WBP54pWeIPde6iPHwxYdKVkSmVzHpncWLso1FzKuORZjGoktyowhuF4Y5DRyNemx
 bpvQ==
X-Gm-Message-State: AOJu0Yx5zechyWokXBUTXLM82luKKL7ZdRbFOv6vL3sow4dGQRvJqPrL
 OEfZg2WOxv0yqCt0g3X83Qr8PELIlro5A4DrhByDFsvgKUb2VLwkFcZrcQ6qQjxSYEPwcCUxVDD
 uxgA+hEHcDRX4wt8xEPU4AWZsDWOBkj5DA5lEbqlQR5FefBWJQIDqE/6k2hgo192FXT2BuqEb1E
 Ks4/IfnjEQavtVutOKSzD0xftJj88Mld8ePak6D/c=
X-Received: by 2002:a05:6000:1f8f:b0:37d:52b5:451e with SMTP id
 ffacd0b85a97d-381f186fc20mr3235568f8f.33.1731087518078; 
 Fri, 08 Nov 2024 09:38:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGx4EmICFX4IVoHrpc8DtTR2DRB5m2xG4vVSTEW5EbhlHgcDwccJU8VogmTNekl8bW+xQW8iA==
X-Received: by 2002:a05:6000:1f8f:b0:37d:52b5:451e with SMTP id
 ffacd0b85a97d-381f186fc20mr3235540f8f.33.1731087517621; 
 Fri, 08 Nov 2024 09:38:37 -0800 (PST)
Received: from [192.168.10.47] ([151.49.84.243])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432b05302e1sm75862525e9.9.2024.11.08.09.38.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 09:38:36 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <graf@amazon.com>, qemu-stable@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 04/13] target/i386: Fix legacy page table walk
Date: Fri,  8 Nov 2024 18:38:19 +0100
Message-ID: <20241108173828.111454-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241108173828.111454-1-pbonzini@redhat.com>
References: <20241108173828.111454-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Alexander Graf <graf@amazon.com>

Commit b56617bbcb4 ("target/i386: Walk NPT in guest real mode") added
logic to run the page table walker even in real mode if we are in NPT
mode.  That function then determined whether real mode or paging is
active based on whether the pg_mode variable was 0.

Unfortunately pg_mode is 0 in two situations:

  1) Paging is disabled (real mode)
  2) Paging is in 2-level paging mode (32bit without PAE)

That means the walker now assumed that 2-level paging mode was real
mode, breaking NetBSD as well as Windows XP.

To fix that, this patch adds a new PG flag to pg_mode which indicates
whether paging is active at all and uses that to determine whether we
are in real mode or not.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2654
Fixes: b56617bbcb4 ("target/i386: Walk NPT in guest real mode")
Signed-off-by: Alexander Graf <graf@amazon.com>
Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Link: https://lore.kernel.org/r/20241106154329.67218-1-graf@amazon.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h                    | 1 +
 target/i386/tcg/seg_helper.c         | 2 +-
 target/i386/tcg/sysemu/excp_helper.c | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index b65eedb6178..4c239a6970f 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -346,6 +346,7 @@ typedef enum X86Seg {
 #define PG_MODE_PKE      (1 << 17)
 #define PG_MODE_PKS      (1 << 18)
 #define PG_MODE_SMEP     (1 << 19)
+#define PG_MODE_PG       (1 << 20)
 
 #define MCG_CTL_P       (1ULL<<8)   /* MCG_CAP register available */
 #define MCG_SER_P       (1ULL<<24) /* MCA recovery/new status bits */
diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
index 02ae6a0d1fc..71962113fb8 100644
--- a/target/i386/tcg/seg_helper.c
+++ b/target/i386/tcg/seg_helper.c
@@ -94,7 +94,7 @@ static uint32_t popl(StackAccess *sa)
 
 int get_pg_mode(CPUX86State *env)
 {
-    int pg_mode = 0;
+    int pg_mode = PG_MODE_PG;
     if (!(env->cr[0] & CR0_PG_MASK)) {
         return 0;
     }
diff --git a/target/i386/tcg/sysemu/excp_helper.c b/target/i386/tcg/sysemu/excp_helper.c
index da187c8792a..02d34864211 100644
--- a/target/i386/tcg/sysemu/excp_helper.c
+++ b/target/i386/tcg/sysemu/excp_helper.c
@@ -298,7 +298,7 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
         /* combine pde and pte nx, user and rw protections */
         ptep &= pte ^ PG_NX_MASK;
         page_size = 4096;
-    } else if (pg_mode) {
+    } else if (pg_mode & PG_MODE_PG) {
         /*
          * Page table level 2
          */
-- 
2.47.0


