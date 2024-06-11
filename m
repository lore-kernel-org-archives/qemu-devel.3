Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 800F1C25B76
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 14:30:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sH2Rx-0007ff-Ah; Tue, 11 Jun 2024 10:26:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sH2Rv-0007et-Um
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 10:26:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sH2Rr-00069X-Al
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 10:26:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718115965;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rQnhyJHOYc6PbobfpSJAuqarcSa0epwhWillMHhZ5N0=;
 b=AqaHaMQOZeYPoMAsPYhaLIBMblDUi+SSACqzItfN+RXGfonk9j7DrWwAKacRhTxygjLoND
 KTjseAHCnX/jfIN6e8g9pfpgRtsw/Uj1NiBOdztHZmupneFGHO2+wLE16Rb0nE1ArDWfGk
 0Q+91pXmAu6UARp1vf5cYeQPMgkZEB0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-tbZP321RM4Ghl7a3W669Zw-1; Tue, 11 Jun 2024 10:26:03 -0400
X-MC-Unique: tbZP321RM4Ghl7a3W669Zw-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a6f2d98f41fso58627966b.2
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 07:26:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718115962; x=1718720762;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rQnhyJHOYc6PbobfpSJAuqarcSa0epwhWillMHhZ5N0=;
 b=DcG+e7G/pF2o10vlbCA52wNImnescIrwyjtPRDZA0xN/zAZYz0WCkSPjLmpl9ZeUuN
 tU0mhim8LO2zW6hulEdQ+PqlfrFr+W9e48qhxKDOG94EB3DqFjJAG5AS9/y4TLGkDlKX
 FNBV9vmb+Y20124TD9v+zilA12IvbDy9IcosLjP5FhXPozYTpBF7/imIn5GXVGSQQl87
 sLfW+0X+1FW9gmqvlATDzQ3MoBTrjwCI0ykk0StRwna4lDN2rKtl4MuHVYQLEk+iUhyx
 PDO3efMITSqH+iVyLxStb23MJUIm+I7KpmFMtW7S/wJ2dJtcj4cOCaI9gjx8oYs9cwlP
 a4Ug==
X-Gm-Message-State: AOJu0YyEHMmKO6rfSxq5oEjWRL7oHlLHA8MgW2Jj6Et0tNSjbWjkQPaz
 c0QmF8f5xHOFBPn9Vp1ttwrZAF6Ecwm1qvLa9+Yv11FTyJhwV/u3hmK4ixj7X9aZhEF1aHcGZoK
 GIHDYVX51x9hwatEI6O/SqUlO0/60MZx6JwPzIBA4/3da3C4U1eFENO21Gq+5HU0ZfnIx+g92Al
 E4uJnwWDO/6bOPP9OHeF0Xc9U5Eb/bbO4UzNHN
X-Received: by 2002:a17:906:378b:b0:a6e:fe2b:7d2c with SMTP id
 a640c23a62f3a-a6efe2b7fa4mr588943266b.23.1718115962299; 
 Tue, 11 Jun 2024 07:26:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjjWbrqJ6yT/Z5oAje+0rNZUZhSN10UkYorx/rKv3V4TdlK5dgvbcTZNzqmEFGF8ds8FONqw==
X-Received: by 2002:a17:906:378b:b0:a6e:fe2b:7d2c with SMTP id
 a640c23a62f3a-a6efe2b7fa4mr588941766b.23.1718115961979; 
 Tue, 11 Jun 2024 07:26:01 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f1c69b15csm294942566b.168.2024.06.11.07.25.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 07:26:00 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 17/25] target/i386: split X86_CHECK_prot into PE and VM86 checks
Date: Tue, 11 Jun 2024 16:25:15 +0200
Message-ID: <20240611142524.83762-18-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240611142524.83762-1-pbonzini@redhat.com>
References: <20240611142524.83762-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


