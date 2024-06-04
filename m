Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF1DCC27C52
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 06:47:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sENuZ-0002Yg-Ex; Tue, 04 Jun 2024 02:44:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENuX-0002RU-K7
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:44:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENuV-0007Gd-Vj
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:44:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717483483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2wxg0TmdWBIMkB5gATygWJjbihr1KIw55S7JfhXI7Mc=;
 b=XPaabTUkVzWvvilOAiuAe6nsJEwUGKYOj7JuUlvkKO2ZY/kWoDVCUDDn3tapaCByDzaPgr
 MxUYwExcdKnjNEXu7dLtw506Xp3AYcjNyL1yAybgjkVP6fhWH3J1IPAFshLfiLU976Ebc5
 nipKAUdpWoC2sPyLoEJCE++rYn7xDrQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-e5sYnl01Noyjc2C1eSuazw-1; Tue, 04 Jun 2024 02:44:41 -0400
X-MC-Unique: e5sYnl01Noyjc2C1eSuazw-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-57a67830ea4so332735a12.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 23:44:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717483479; x=1718088279;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2wxg0TmdWBIMkB5gATygWJjbihr1KIw55S7JfhXI7Mc=;
 b=NKV+M0tpMSgzR5Es/8M/FjZInvQ2p473ofBrnc+HdbiA3Nru0x3BSWwJb3eCz33zqt
 aMpyrFc4Jdn8zj2YlOd94j5nahRRf1PUKOKGpHe0OMlZwpXsTYGlROUo1u+0bPhvfPa8
 sEpzABMpiIjll49mOFPKNp9DX7PjxeApyHig4iQz441mcFE8fpHYNXgs0MZoDGPvlvcK
 2S86rI9gq4Fy3zjYwDoJ7uPaNhdiH5yDibxWMbv6sV325BzO56Bf8th6uslnIFUU/vnA
 9E2Kru58kivZ4qcPYsfAnhkpJzPuJAHVL1n8mrDC4lh6VbMW0n3IqR5dnJ1WPWdl6TFk
 8OBA==
X-Gm-Message-State: AOJu0YygJXirlRCT86zEtBf8OfhWfeNiSup6oTqtsXmFwCouGGTF9jLO
 W9rGC06/Eo7DI/HkjRrqJYrNc88KIKirFTUHJQvmRyEzESe4G6ftNlSjRiZGnK+dOOeKVfKs6yv
 NokCveWcVKYRMcuYvA0YIZ703Iyw+CHF9udv9dwbHTXu5L9S08TlAtJXAXHkhIU0E8AffFIGwBJ
 RK3Ff+cyRH3ETrQN59OZkK5w56CIn6ocRbZnbP
X-Received: by 2002:a50:99d5:0:b0:579:be37:fa68 with SMTP id
 4fb4d7f45d1cf-57a3638cde3mr8560880a12.20.1717483479652; 
 Mon, 03 Jun 2024 23:44:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF30g8J9XsZnV0Pnh4gKhkP4GeXh3shhTfesLGISVfjr6rLzXVP51rQu6YZYGmEJxCdsNUaMg==
X-Received: by 2002:a50:99d5:0:b0:579:be37:fa68 with SMTP id
 4fb4d7f45d1cf-57a3638cde3mr8560868a12.20.1717483479138; 
 Mon, 03 Jun 2024 23:44:39 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57a31b991b1sm6699965a12.5.2024.06.03.23.44.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 23:44:38 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xinyu Li <lixinyu@loongson.cn>,
	Xinyu Li <lixinyu20s@ict.ac.cn>
Subject: [PULL 09/45] target/i386: fix memory opsize for Mov to/from Seg
Date: Tue,  4 Jun 2024 08:43:33 +0200
Message-ID: <20240604064409.957105-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604064409.957105-1-pbonzini@redhat.com>
References: <20240604064409.957105-1-pbonzini@redhat.com>
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

From: Xinyu Li <lixinyu@loongson.cn>

This commit fixes an issue with MOV instructions (0x8C and 0x8E)
involving segment registers; MOV to segment register's source is
16-bit, while MOV from segment register has to explicitly set the
memory operand size to 16 bits.  Introduce a new flag
X86_SPECIAL_Op0_Mw to handle this specification correctly.

Signed-off-by: Xinyu Li <lixinyu20s@ict.ac.cn>
Message-ID: <20240602100528.2135717-1-lixinyu20s@ict.ac.cn>
Fixes: 5e9e21bcc4d ("target/i386: move 60-BF opcodes to new decoder", 2024-05-07)
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.h     |  3 +++
 target/i386/tcg/decode-new.c.inc | 13 +++++++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/target/i386/tcg/decode-new.h b/target/i386/tcg/decode-new.h
index 51ef0e621b9..1f90cf96407 100644
--- a/target/i386/tcg/decode-new.h
+++ b/target/i386/tcg/decode-new.h
@@ -203,6 +203,9 @@ typedef enum X86InsnSpecial {
     /* When loaded into s->T0, register operand 1 is zero/sign extended.  */
     X86_SPECIAL_SExtT0,
     X86_SPECIAL_ZExtT0,
+
+    /* Memory operand size of MOV from segment register is MO_16 */
+    X86_SPECIAL_Op0_Mw,
 } X86InsnSpecial;
 
 /*
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 0ec849b0035..0ff0866e8f3 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -202,6 +202,7 @@
 #define avx_movx .special = X86_SPECIAL_AVXExtMov,
 #define sextT0 .special = X86_SPECIAL_SExtT0,
 #define zextT0 .special = X86_SPECIAL_ZExtT0,
+#define op0_Mw .special = X86_SPECIAL_Op0_Mw,
 
 #define vex1 .vex_class = 1,
 #define vex1_rep3 .vex_class = 1, .vex_special = X86_VEX_REPScalar,
@@ -1576,9 +1577,10 @@ static const X86OpEntry opcodes_root[256] = {
     [0x89] = X86_OP_ENTRY3(MOV, E,v, G,v, None, None),
     [0x8A] = X86_OP_ENTRY3(MOV, G,b, E,b, None, None),
     [0x8B] = X86_OP_ENTRY3(MOV, G,v, E,v, None, None),
-    [0x8C] = X86_OP_ENTRY3(MOV, E,v, S,w, None, None),
+    /* Missing in Table A-2: memory destination is always 16-bit.  */
+    [0x8C] = X86_OP_ENTRY3(MOV, E,v, S,w, None, None, op0_Mw),
     [0x8D] = X86_OP_ENTRY3(LEA, G,v, M,v, None, None, noseg),
-    [0x8E] = X86_OP_ENTRY3(MOV, S,w, E,v, None, None),
+    [0x8E] = X86_OP_ENTRY3(MOV, S,w, E,w, None, None),
     [0x8F] = X86_OP_GROUPw(group1A, E,v),
 
     [0x98] = X86_OP_ENTRY1(CBW,    0,v), /* rAX */
@@ -2514,6 +2516,13 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
         s->override = -1;
         break;
 
+    case X86_SPECIAL_Op0_Mw:
+        assert(decode.op[0].unit == X86_OP_INT);
+        if (decode.op[0].has_ea) {
+            decode.op[0].ot = MO_16;
+        }
+        break;
+
     default:
         break;
     }
-- 
2.45.1


