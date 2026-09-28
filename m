Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 230F6C9833F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 13:06:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBB3E-0007sB-6W; Mon, 28 Sep 2026 09:05:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xBB13-0005Vh-Vc
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 09:03:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xBB12-0004PU-87
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 09:03:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790600611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GOGGOosVOXz7SU22mlT+6Pco7bzFoUj282Mj5J/mKI0=;
 b=KawcF2LQ6D+uLhGM5r8OWGEXrniGk3V6NvMU/wLr1rIcez/h7ydKwgmF2EkwAaWsOEr+YJ
 yihiUWBo3mBhogzSjrYzfXjE8YsYO5YHx6Qml3oWI7JE7kLJZ6WIvaSBMmGxJhKKZT5F9m
 SzaNso90fFafn1XeXTMeQ1yTwPLu6FE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-0ejYtkwzM0epfrCYIObjjA-1; Mon, 28 Sep 2026 09:03:28 -0400
X-MC-Unique: 0ejYtkwzM0epfrCYIObjjA-1
X-Mimecast-MFC-AGG-ID: 0ejYtkwzM0epfrCYIObjjA_1790600607
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-c29d3ad6b74so149299966b.3
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 06:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790600607; x=1791205407; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GOGGOosVOXz7SU22mlT+6Pco7bzFoUj282Mj5J/mKI0=;
 b=jl2PJYv7u4oQa6qDIregmM5ncXHRPIsnANKs0LwlFDWrd4Gcz0UmRNszI2/xoNdA71
 gCIge5mqudmlOa1ZuUCSZkM6hk6XH+q+CVeqkUNsXZUxA0vCkRUv5y6z99WBWinB0Ysl
 0xpDVtp1gPhpq2aP84jdWnVoteU6jGOJeykVrurNMy3n7DcYJYdxDZxjTWMUnTde5oIu
 w6aZXd6y8Rvt5t6HSI/Hb8kas2URjhQIj4Vf/7Vyw0EiG3PWrz6aGW3HDmwmxzBgE+PU
 vmbFqrvCwy0YNx3wWpiaBHHh8z0SwlSk0BIXqbfeCq6KahPAyU1XImUkYf4vb3mVK5Q2
 U1Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790600607; x=1791205407;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GOGGOosVOXz7SU22mlT+6Pco7bzFoUj282Mj5J/mKI0=;
 b=aa1+l1CZMCEWjS4ov1T/V0r7bufQ7t12toLrA+pATY3+YboTeBnNaukky8twOhZL+F
 j4RcVzJtyRddyMkgVGBGiYxW0uue2UXGJzvTrVWjzFl/Kp9t1MQRCHmYRv6ILi4EIjBT
 wa5SuA5K/EwP4O7oVv4gpnMX57Om3R5806TTUBWU8Xs+fRBUK1LfLM93Tj1HWfCYPOlf
 nJ30N79ULlwSVRx7uJcOp0YCtldE6Dr2m7Plg6PmEzlL1F/7yk6f8oB0kaFONQiWpAHx
 7qEHOUUGfzePds9ZqEP8KF7HqJf6pWHxkfjKzsTcPnsqZ8rpn0cu5hoYqTy5tCSucjA1
 BRRQ==
X-Gm-Message-State: AFuF++lWO8NAqJZYUEw8ouytYvtFc3uo7Vk2Y/BuVHyxpkvPgrZXyIvS
 bcJUhLicpddlaK0n+aIQG1Kn0Xou0Av9AQXkX+tbU7uGZOkuHmexj1y0xiIMJLFAQSohkR8xSFs
 O7YNLuWjsfppZ3df38vCKtbXaGXBZ6ADyczeoeNihR2Sjw1k4hZBLEt+mrdLd/bnCMRSTQr7dmu
 +YzCPfKNl41dd5kVXIRfE8vljJqmHouBXoeooV+5++
X-Gm-Gg: AYBFou23aX08Qi8XdODMrs3y4/FRaX+3WG1vAJjliUoWwkhnyRkyyZLKo4BeREJHzDM
 zP1ogzuaoa9XMSuHkFDLeplBVzyRfLHb5lfzHpVzhdp0SUvax+8ediGEMmWP+1BrLsvPKsrunkN
 WGJ7OAD1TSUsWc8WsjzbGwmhX0K4/V0+nxIsH/RYDfR3zwZrfiz2E6TvUmzIEvBnVbxFUhxdGQ3
 lPKqJhluRy3/MZviIP2n5SdTvGdYXsMS3CdqxRg1aNrIrgEp2XIKOOwLdLD32xI8kllP4OCKzwd
 TlJoyW7Aec58noPYil7hnUwp3PB811QvZx80koI/wiII/zJB5Lvy+O6nWmnjKmQUK+V8CwozXMM
 zOpn0GzHMhyRiLT3SOc0/qAiaQjCJS/d1XM+fLmIiWJLPwAxt9GgnfYlxBIGGxxi3Q3srHYpNkX
 0mhMoL
X-Received: by 2002:a17:907:9489:b0:c2d:d277:da41 with SMTP id
 a640c23a62f3a-c2dd277de66mr264672766b.38.1790600607415; 
 Mon, 28 Sep 2026 06:03:27 -0700 (PDT)
X-Received: by 2002:a17:907:9489:b0:c2d:d277:da41 with SMTP id
 a640c23a62f3a-c2dd277de66mr264671266b.38.1790600606887; 
 Mon, 28 Sep 2026 06:03:26 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2b0f2f4f53sm359127666b.47.2026.09.28.06.03.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 06:03:25 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 18/30] target/i386/tcg: mark XSAVE* as not allowing REX2
Date: Mon, 28 Sep 2026 15:02:16 +0200
Message-ID: <20260928130228.877003-19-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928130228.877003-1-pbonzini@redhat.com>
References: <20260928130228.877003-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.238,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

Reviewed-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.h     |  3 +++
 target/i386/tcg/decode-new.c.inc | 21 ++++++++++-----------
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/target/i386/tcg/decode-new.h b/target/i386/tcg/decode-new.h
index 1b5a91b4f46..bb686c9efd0 100644
--- a/target/i386/tcg/decode-new.h
+++ b/target/i386/tcg/decode-new.h
@@ -187,6 +187,9 @@ typedef enum X86InsnCheck {
     /* Vendor-specific checks for Intel/AMD differences */
     X86_CHECK_i64_amd = 2048,
     X86_CHECK_o64_intel = 4096,
+
+    /* No REX2 prefix allowed */
+    X86_CHECK_no_rex2 = 8192,
 } X86InsnCheck;
 
 typedef enum X86InsnSpecial {
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 8394924a7ed..194a99a4753 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -486,9 +486,9 @@ static void decode_group15(DisasContext *s, CPUX86State *env, X86OpEntry *entry,
         [1] = X86_OP_ENTRYr(FXRSTOR,    M,y, cpuid(FXSR) p_00),
         [2] = X86_OP_ENTRYr(LDMXCSR,    E,d, vex5 chk(VEX128) p_00),
         [3] = X86_OP_ENTRYw(STMXCSR,    E,d, vex5 chk(VEX128) p_00),
-        [4] = X86_OP_ENTRYw(XSAVE,      M,y, cpuid(XSAVE) p_00),
-        [5] = X86_OP_ENTRYr(XRSTOR,     M,y, cpuid(XSAVE) p_00),
-        [6] = X86_OP_ENTRYw(XSAVEOPT,   M,b, cpuid(XSAVEOPT) p_00),
+        [4] = X86_OP_ENTRYw(XSAVE,      M,y, cpuid(XSAVE) p_00 chk(no_rex2)),
+        [5] = X86_OP_ENTRYr(XRSTOR,     M,y, cpuid(XSAVE) p_00 chk(no_rex2)),
+        [6] = X86_OP_ENTRYw(XSAVEOPT,   M,b, cpuid(XSAVEOPT) p_00 chk(no_rex2)),
         [7] = X86_OP_ENTRYw(NOP,        M,b, cpuid(CLFLUSH) p_00),
     };
 
@@ -3008,15 +3008,14 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
                 goto illegal_op;
             }
         }
-        if (decode.e.check & X86_CHECK_prot_or_vm86) {
-            if (!PE(s)) {
-                goto illegal_op;
-            }
+        if ((decode.e.check & X86_CHECK_prot_or_vm86) && !PE(s)) {
+            goto illegal_op;
         }
-        if (decode.e.check & X86_CHECK_no_vm86) {
-            if (VM86(s)) {
-                goto illegal_op;
-            }
+        if ((decode.e.check & X86_CHECK_no_vm86) && VM86(s)) {
+            goto illegal_op;
+        }
+        if ((decode.e.check & X86_CHECK_no_rex2) && (s->prefix & PREFIX_REX2)) {
+            goto illegal_op;
         }
         if ((decode.e.check & X86_CHECK_VEX128) && s->vex_l) {
             goto illegal_op;
-- 
2.55.0


