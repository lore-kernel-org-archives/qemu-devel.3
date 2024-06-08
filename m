Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96710C27C65
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 08:43:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFreJ-0002vq-JU; Sat, 08 Jun 2024 04:42:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFreI-0002rp-Hm
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:42:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFreG-0001R3-Oo
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:42:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717836124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YUHTlJC/b6fqf2H4PcUhXB3c6Og29MZO04uYtYnBckQ=;
 b=BOqCDiJKPHBfNBNJiD0bTZDiIFS5TciV3c0o5oHjW0O6c2kehEhwI+j0t40MEt7K+VtA3s
 uy7CPUCT/Aim3BxaXlh1AmEUCxT1RDrze/hRcusuF7/IDCgVlccUami1Y0WmucQ1L41gVb
 rpKaiyDA9yIFd2Eoa4Ku3kSbBbOz+Jk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-Kv1c3SOZM5S8bUG2RmMNlQ-1; Sat, 08 Jun 2024 04:42:01 -0400
X-MC-Unique: Kv1c3SOZM5S8bUG2RmMNlQ-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-57c5216e486so819149a12.0
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 01:42:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717836119; x=1718440919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YUHTlJC/b6fqf2H4PcUhXB3c6Og29MZO04uYtYnBckQ=;
 b=VKlH1rhm3o5O8bsGJyxn9BJh5KNPFw/Y1DENea642lWHFWaLI7lwBC8rAZ8y4PeQJP
 aN6NKGd5YS+p5pfV70UYpSAtDuinv2zgPz4HPXJXj3FNOtguKOCpvcGSjUnlNSFZJ6fr
 /gwLAf1Pc9qdjQwn3sJZJcMz4l7dOOUAiIgd1aOgsoxgdhzylHZDn6Q/43+EsqEdYJkG
 76oc3aaBlyfMJUPpcMS3IiinVA3PJTRcnoJ8cZrtywsgsC+d7FLCCU11QFzH6sXYVm4s
 zLYLb0cuF3q8DRoCknzudK4W58ujX53xE/6BJ2pG6IHabttX6xX5H2OIApKnlUK0t53D
 4DWQ==
X-Gm-Message-State: AOJu0YwC4ZC+34DNaNs0PvWMoIDekaOdFfw4xe1vooeydHbSIJV5zIHT
 ga/BDr+4IBngPLCIh0S0LZS+HSIWzEUVTVA0X7QqHVjm9H7ss4pBL0AVncHv2TjsYWP2kI2q6YC
 Ym3sb+vFe3pcOC6VC0bETN5zskJ88EGDEPC3vKt4C7M5Pv1KqX33oxAOMuj9ZpxdVYOjtPqc85x
 BbPJzTfAsxtlLFYwK5+bVh9LCSmb5HAIVNegkG
X-Received: by 2002:a50:cc9a:0:b0:578:5851:b0da with SMTP id
 4fb4d7f45d1cf-57c5099a2famr2796338a12.36.1717836119035; 
 Sat, 08 Jun 2024 01:41:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtvJth3KNOtWifwme71r7PA2RpVzYxTh/153YSn2uMDXEiPCPVuhW3IOCJU8HT//zFiFce2Q==
X-Received: by 2002:a50:cc9a:0:b0:578:5851:b0da with SMTP id
 4fb4d7f45d1cf-57c5099a2famr2796329a12.36.1717836118734; 
 Sat, 08 Jun 2024 01:41:58 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57aae13faccsm3971676a12.54.2024.06.08.01.41.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Jun 2024 01:41:56 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 12/25] target/i386: split X86_CHECK_prot into PE and VM86
 checks
Date: Sat,  8 Jun 2024 10:41:00 +0200
Message-ID: <20240608084113.2770363-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240608084113.2770363-1-pbonzini@redhat.com>
References: <20240608084113.2770363-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

SYSENTER is allowed in VM86 mode, but not in real mode.  Split the check
so that PE and !VM86 are covered by separate bits.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.h     | 8 ++++++--
 target/i386/tcg/decode-new.c.inc | 9 +++++++--
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/target/i386/tcg/decode-new.h b/target/i386/tcg/decode-new.h
index 5577f7509aa..b46a9a0ccb3 100644
--- a/target/i386/tcg/decode-new.h
+++ b/target/i386/tcg/decode-new.h
@@ -149,8 +149,8 @@ typedef enum X86InsnCheck {
     X86_CHECK_i64 = 1,
     X86_CHECK_o64 = 2,
 
-    /* Fault outside protected mode */
-    X86_CHECK_prot = 4,
+    /* Fault in vm86 mode */
+    X86_CHECK_no_vm86 = 4,
 
     /* Privileged instruction checks */
     X86_CHECK_cpl0 = 8,
@@ -166,6 +166,10 @@ typedef enum X86InsnCheck {
 
     /* Fault if VEX.W=0 */
     X86_CHECK_W1 = 256,
+
+    /* Fault outside protected mode, possibly including vm86 mode */
+    X86_CHECK_prot_or_vm86 = 512,
+    X86_CHECK_prot = X86_CHECK_prot_or_vm86 | X86_CHECK_no_vm86,
 } X86InsnCheck;
 
 typedef enum X86InsnSpecial {
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 1c6fa39c3eb..f02f7c62647 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -2558,8 +2558,13 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
                 goto illegal_op;
             }
         }
-        if (decode.e.check & X86_CHECK_prot) {
-            if (!PE(s) || VM86(s)) {
+        if (decode.e.check & X86_CHECK_prot_or_vm86) {
+            if (!PE(s)) {
+                goto illegal_op;
+            }
+        }
+        if (decode.e.check & X86_CHECK_no_vm86) {
+            if (VM86(s)) {
                 goto illegal_op;
             }
         }
-- 
2.45.1


