Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5A3FC2BA18
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 09:56:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKEV6-0002Gp-E9; Thu, 20 Jun 2024 05:54:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKEUz-0002GO-T0
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 05:54:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKEUy-0005SH-A7
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 05:54:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718877270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=La0Xgc4fXhE2dqcStb1IyrP1obFxek+qtw925qAODeo=;
 b=J16EaIhU7fROjSW7lNAxw6f8cuJMU+j2ZE2mE/P6RDAmWKFoq1ORuc7hkEEowsYZRBWe0x
 ts/DEa6DISZZPkqTqv+KLhPL5SUyUKJgHK0/LKPukrAT2hi7+njP9TPX8uMVcbqNTULO9g
 QUt7GwsQk62rzUvNoHY3Z2G/NLct7z0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-8tHcPaGIMPyyc8Cu_MVO1A-1; Thu, 20 Jun 2024 05:54:29 -0400
X-MC-Unique: 8tHcPaGIMPyyc8Cu_MVO1A-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a6efbb08949so27506666b.0
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 02:54:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718877267; x=1719482067;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=La0Xgc4fXhE2dqcStb1IyrP1obFxek+qtw925qAODeo=;
 b=YByiYPNjMdf1QrYYV1oRbQnrxjPT2khRPgXMqeb5ckiMXvl0vwA+lif9nbPgXnzQq7
 BsDFM09Ox/QksvVRKs+skZcQ0gs+n5vbHuYcXtAfwVuuHXYJb25/abnRAI+/64e0HdNO
 UP1YZdP0kLSWlnGmLRcUaXxzFQvp+bLgX/WUNinSaXijpWfzm384sbTRBoYWc7Dx1MPT
 27iWe3f7xV1LmT1cWmw9wTISOL0SOAskpb9Rdi9zLFDPwffu5fEIilr3Mnc3jkMw+WfX
 fefVcGL5oR2rOdZmA9TZX9MI1DID0TfLUICi06BhngubLLOm9rHM9kEKJnDimnJLyGW4
 OybQ==
X-Gm-Message-State: AOJu0YxnnXFts6d4RlttAtKkTVGaK8gZbYA53G/8/aYhya7mmA7rMhGp
 PMSR0q4y+1YVZQDxbh9Ox5VgXi1x6BbNOSQQCmQQ/IyvChwXOSD6APbP3rRT+syUd8RyYFZ1eSz
 il5+uSxREEKz0x+lE4nvhHPM1WGpee05pZXgoBCJcq3XTJ5XOVCgBK4DXjsIc8E5QySI8T8A2lK
 L73DnJ0r+jviTBHgJW5leNnpMxj/PFmpyXRaU+
X-Received: by 2002:a17:907:c713:b0:a6f:61c7:dead with SMTP id
 a640c23a62f3a-a6fab61398amr398709666b.17.1718877267087; 
 Thu, 20 Jun 2024 02:54:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEr3KynHYAXEID1ikOd8o6kXYGfX+u9zYgoVOSH0PUwdB3yn1j/Uvc3Uci/PK1bQUVc1xmNcQ==
X-Received: by 2002:a17:907:c713:b0:a6f:61c7:dead with SMTP id
 a640c23a62f3a-a6fab61398amr398707566b.17.1718877266735; 
 Thu, 20 Jun 2024 02:54:26 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f8cc20663sm297636966b.190.2024.06.20.02.54.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 02:54:26 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/10] target/i386: give CC_OP_POPCNT low bits corresponding
 to MO_TL
Date: Thu, 20 Jun 2024 11:54:11 +0200
Message-ID: <20240620095419.386958-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240620095419.386958-1-pbonzini@redhat.com>
References: <20240620095419.386958-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

Handle it like the other arithmetic cc_ops.  This simplifies a
bit the implementation of bit test instructions.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h           | 13 +++++++++++--
 target/i386/tcg/translate.c |  3 +--
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index f54cd93b3f9..8504a7998fd 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1275,6 +1275,7 @@ typedef enum {
     CC_OP_ADCX, /* CC_DST = C, CC_SRC = rest.  */
     CC_OP_ADOX, /* CC_SRC2 = O, CC_SRC = rest.  */
     CC_OP_ADCOX, /* CC_DST = C, CC_SRC2 = O, CC_SRC = rest.  */
+    CC_OP_CLR, /* Z and P set, all other flags clear.  */
 
     CC_OP_MULB, /* modify all flags, C, O = (CC_SRC != 0) */
     CC_OP_MULW,
@@ -1331,8 +1332,16 @@ typedef enum {
     CC_OP_BMILGL,
     CC_OP_BMILGQ,
 
-    CC_OP_CLR, /* Z set, all other flags clear.  */
-    CC_OP_POPCNT, /* Z via CC_DST, all other flags clear.  */
+    /*
+     * Note that only CC_OP_POPCNT (i.e. the one with MO_TL size)
+     * is used or implemented, because the translation needs
+     * to zero-extend CC_DST anyway.
+     */
+    CC_OP_POPCNTB__, /* Z via CC_DST, all other flags clear.  */
+    CC_OP_POPCNTW__,
+    CC_OP_POPCNTL__,
+    CC_OP_POPCNTQ__,
+    CC_OP_POPCNT = sizeof(target_ulong) == 8 ? CC_OP_POPCNTQ__ : CC_OP_POPCNTL__,
 
     CC_OP_NB,
 } CCOp;
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index f32cda4e169..934c514e64f 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -1019,8 +1019,6 @@ static CCPrepare gen_prepare_eflags_z(DisasContext *s, TCGv reg)
                              .imm = CC_Z };
     case CC_OP_CLR:
         return (CCPrepare) { .cond = TCG_COND_ALWAYS };
-    case CC_OP_POPCNT:
-        return (CCPrepare) { .cond = TCG_COND_EQ, .reg = cpu_cc_src };
     default:
         {
             MemOp size = (s->cc_op - CC_OP_ADDB) & 3;
@@ -3177,6 +3175,7 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
         case CC_OP_SHLB ... CC_OP_SHLQ:
         case CC_OP_SARB ... CC_OP_SARQ:
         case CC_OP_BMILGB ... CC_OP_BMILGQ:
+        case CC_OP_POPCNT:
             /* Z was going to be computed from the non-zero status of CC_DST.
                We can get that same Z value (and the new C value) by leaving
                CC_DST alone, setting CC_SRC, and using a CC_OP_SAR of the
-- 
2.45.2


