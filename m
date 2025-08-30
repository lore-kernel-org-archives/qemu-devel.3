Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D933FCA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:29:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNsT-0003zx-6X; Sat, 30 Aug 2025 11:52:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usCRM-000552-T3
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 23:39:44 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usCRL-00053b-8U
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 23:39:44 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-b4c3d8bd21eso1780034a12.2
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 20:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756525181; x=1757129981; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9TWmHhTT9lCDXC8rOc808nC20bvHDJHpaGHTN65T5bE=;
 b=n8NtsTDbZG6vq9GlCAjqs2qzowTmV0Fa/Z2EWgc59Nle5OCvebaaQCscgiouBNUsDy
 qaLoNaTyfPh+Vks6g69astA3NgW6JXXMbH95j4FokYZklliN6/QYVHjkCJz9Sdb8Wl7d
 H5H2UVPCKHqCL38SIPjrSzF/2icZDIDEwzU8gMtgTCYN3QNqO7SH8G9bVagpnaiC/qCq
 U/xozj7o6/Ge/eZgXC8aj36oyMKaipfb9+Gpv8epfjt+eC+/EMt/2veVY8rinih2F/ah
 vzQlUTr8Q5ATo0KHsbicNMZ4SjDLX9UOSESU8CVCSI3H9jRN7SaGGRTExqj2jqPBU7zG
 EIQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756525181; x=1757129981;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9TWmHhTT9lCDXC8rOc808nC20bvHDJHpaGHTN65T5bE=;
 b=M1AV+N/nUXq0DlPiLOFLLZs1fJ7x+TCnmNowbSdC5qKhoRBOXdBVFQuBLV1DbsktsV
 jixauqT1C5XKn8og+PbvzVua8F2W4VFSJsuj4+vsiJ8LY0DJorQLQLA5HWsDiWRq4Uid
 5XHnticTy9gZ2WXk47/zfF66sDuha1qgCJdRf2XDJMHm0bsfUmAvbu7CX66pcRrnN+ju
 Xah0+rYXSxriNUS4ZVBnKzSemP8s+mGfnK0i+EXvybZLKA9dA4VKUPfvl0ZQ2kLyV55G
 8IvHYHDJRAjh5B8Y7WeR4/UCCYFE0+4RKDViUw5zU9uke72OAEPJOe3UbOgfXAqJDzf2
 B5ww==
X-Gm-Message-State: AOJu0Yy94aOjQC8argygh7su9qsQyEItTK2eZEjTK7zR2W2JMxnVfKca
 igpUXHY5/VS5sVVGN1y+lDNoIuxYbrHPIcfURCmGk8LU2SihqTyGSSk+4Jy9LD8doNGLsMGDs/L
 9yu1Z0Xw=
X-Gm-Gg: ASbGncsfOtCgUDypJv2XdEdV4a2T9QZcN/CCaiCbmMxvI/uBbh0RspzbypvSO1ZN3cy
 tBBpnAzMOIvp+3NHbLL62K0Tl6ZcW1IV+FqLn5IxlBXp4daMN9wF+R7XjLi4/A7M7sIwqT7aOFm
 1LZIlGaJqmvt3YyelhmLaqZP0ikcwoZ9yEdQdpAZyFDwK1hW80JU+35bIeRu+E8rcSzJRaLf9WA
 4TSgPWScH35YiDen5sKcwsk28D+nsfuGSRrPQhRrCkNXokVwFon2yZ3AjmhgNLSJ2Y9zJkPWy1o
 Rs/f8tlIszHB32PUuqBExim7spTktgZcRvgC4MNhH4BT58dgFuHXej1HhGo8/sZ71cipph81dUC
 qUNTz/NzR+bIU3ciL2W/byp/8RDZPzvFyQyCVErnM1U92fdcPjQoMabQiSuSUAJQIvC/ZDs1Abg
 ==
X-Google-Smtp-Source: AGHT+IFqpMHDlVg323HnxQlYmJPEM1UfHNer/qQgj++/BFOiAXmSh4zXqOuUX9BCtHFt1Rx6PMIqdw==
X-Received: by 2002:a17:902:d4cb:b0:249:3049:9748 with SMTP id
 d9443c01a7336-24944a98207mr11179535ad.35.1756525181050; 
 Fri, 29 Aug 2025 20:39:41 -0700 (PDT)
Received: from stoup.. (122-150-204-179.dyn.ip.vocus.au. [122.150.204.179])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24905da4784sm39551685ad.90.2025.08.29.20.39.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 20:39:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 4/5] tcg/i386: Add INDEX_op_x86_vgf2p8affineqb_vec
Date: Sat, 30 Aug 2025 13:39:25 +1000
Message-ID: <20250830033926.372955-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250830033926.372955-1-richard.henderson@linaro.org>
References: <20250830033926.372955-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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

Add a backend-specific opcode for expanding the
GFNI vgf2p8affineqb instruction, which we can use
for expanding 8-bit immediate shifts and rotates.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target-opc.h.inc | 1 +
 tcg/i386/tcg-target.c.inc     | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/tcg/i386/tcg-target-opc.h.inc b/tcg/i386/tcg-target-opc.h.inc
index 8cc0dbaeaf..8a5cb34dbe 100644
--- a/tcg/i386/tcg-target-opc.h.inc
+++ b/tcg/i386/tcg-target-opc.h.inc
@@ -35,3 +35,4 @@ DEF(x86_punpckh_vec, 1, 2, 0, TCG_OPF_VECTOR)
 DEF(x86_vpshldi_vec, 1, 2, 1, TCG_OPF_VECTOR)
 DEF(x86_vpshldv_vec, 1, 3, 0, TCG_OPF_VECTOR)
 DEF(x86_vpshrdv_vec, 1, 3, 0, TCG_OPF_VECTOR)
+DEF(x86_vgf2p8affineqb_vec, 1, 2, 1, TCG_OPF_VECTOR)
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 8260c35edd..efaca0ca67 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -451,6 +451,7 @@ static bool tcg_target_const_match(int64_t val, int ct,
 #define OPC_VPBROADCASTW (0x79 | P_EXT38 | P_DATA16)
 #define OPC_VPBROADCASTD (0x58 | P_EXT38 | P_DATA16)
 #define OPC_VPBROADCASTQ (0x59 | P_EXT38 | P_DATA16)
+#define OPC_VGF2P8AFFINEQB (0xce | P_EXT3A | P_DATA16 | P_VEXW)
 #define OPC_VPMOVM2B    (0x28 | P_EXT38 | P_SIMDF3 | P_EVEX)
 #define OPC_VPMOVM2W    (0x28 | P_EXT38 | P_SIMDF3 | P_VEXW | P_EVEX)
 #define OPC_VPMOVM2D    (0x38 | P_EXT38 | P_SIMDF3 | P_EVEX)
@@ -4084,6 +4085,10 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         insn = vpshldi_insn[vece];
         sub = args[3];
         goto gen_simd_imm8;
+    case INDEX_op_x86_vgf2p8affineqb_vec:
+        insn = OPC_VGF2P8AFFINEQB;
+        sub = args[3];
+        goto gen_simd_imm8;
 
     case INDEX_op_not_vec:
         insn = OPC_VPTERNLOGQ;
@@ -4188,6 +4193,7 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_x86_punpckl_vec:
     case INDEX_op_x86_punpckh_vec:
     case INDEX_op_x86_vpshldi_vec:
+    case INDEX_op_x86_vgf2p8affineqb_vec:
 #if TCG_TARGET_REG_BITS == 32
     case INDEX_op_dup2_vec:
 #endif
-- 
2.43.0


