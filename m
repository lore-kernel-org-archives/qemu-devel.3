Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8949FCD37A7
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 15:14:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLMuH-0004f8-1Z; Fri, 08 May 2026 11:14:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLMtS-0002lr-Hl
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:13:36 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLMtP-0001nw-96
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:13:32 -0400
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-47c941f7213so1290160b6e.1
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 08:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778253210; x=1778858010; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hJekX8dH52yMvYykB5HOFELCbhNNSoNRaiTZ7e0Y8tM=;
 b=RAuleFFEjxj73QAyOKVmvHXyv+lrcIO17O0OyaDjsyTHWGf427p6+E3ZEgFuhjh9bI
 uw0Z7d99nisQ2JQJRr4HFjlpkl839qGEsaLkKdB18RkRsrSTVDRNyJNT71jeIQU3IQBb
 2whRRst/UIJMN7AeVma4Uo5qOnQQabCyx5K857KiHZUd874VSGuIXpZflu6TXCvo1qXK
 iR30aPaSMSZ1bQDt8K27VDEnvVwPgioq/NKb4jBehleeF1FzMKDB8PGewoDMU6gxx38c
 3Ka9Fh2UQy7XBmk/vfpwT1UnSUdJX0PVRrF+MDHOuV3acUVF2dtz7fprGdWX9YdMiTpY
 U/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778253210; x=1778858010;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hJekX8dH52yMvYykB5HOFELCbhNNSoNRaiTZ7e0Y8tM=;
 b=jhyctLKYUj+3aGK/Z6DSk6Ym0In3opT+8nBj6vF2zRnws3LwT44ArV70BOdAnV0ZPE
 LYyYUSIru+pYbSuHELfJNumdON6A4cAJ+/0sK3Xz9izhLLmpKIIxAVcfSRh1toYlGEuo
 e66K9DAFr7Fas10yJducBVtx0kC52FxevNaIsDftPjX0VOShw0oQQZYccbHPVj0Owa+M
 KpWdDDVxewxt8r6HHhag4r4ZQFV5pShoxYmIFqDdUuVIw5/uTGa8wvp4vO1WmAAFUxAI
 Z7DFsK6Sy+VvAarR33kPDQ9srtiJDs68RzNCW2CM2B4dp7GAD/xLdpd4fCWllCxPdvNm
 9dvg==
X-Gm-Message-State: AOJu0YxVmiA3aH4niwFjmuJl+pcYUhYSaxm2LnDqNcdVeaNE1x47fSIF
 EDd4mMbTkE/yrrCPRmFO8pnN+jQyMreYp5D84ZmErmfo02pszt94HJ/Bd/hwSg==
X-Gm-Gg: AeBDievuD+EO7QYjiS92e07Ggj/l7Ogc6Luuw72O5t2OX6MoU+5xtLNFyGXfdBHx2d5
 P9/jVf7wb93Txt13HOODLx44Y4dYId4ieLGEu1+XJySuErYiUiCaR3ffF0ZGWE82h7HqjSeziCR
 haT59/+1uskt37/y+2MAD4rHxnq49P0Hhc8cs7c9Y0dh+jIG7wifOEQoWCsJa0JLU4ZHHvjpeeR
 3UhlfzNub8EAtr2TlCRO/2A5T8uWpRBFCB/NGsiGrHGScuf4XnDZCSlHXpJMQe23WeHSY+jPqbn
 EhZ46mCOorAvCewF8znG+fa1/hNj1SA0xLP36jddCeWq7qPpUo66B1f5BCLBeL0nvKgyzZhwb7W
 tN5oXcRVVfx/4HcslAwC58r2r5Hway9TMBI1BDXWEK+YFaaDx3ul4uWdKwiK8H9eajSSQTYRLt4
 +HIN5lOHTk52CAjVQrRFXF/Ondq4oUd53fd0ONa+V7Qz6JD2r2np1cj0gEfgayMt7FzJAhhXrH/
 0KmY6qU+WPZ5qrmUDbDMa3IIwYoSHy61c/+G3e0M88meB+vEQWAHQ5/VVXJbvvuZ5BRYwmeDIj9
 WxhusykQ77wX/ijomMwjxepeHvodvpgZIPxI9XzurcIMCH6aUbVfDm3TwKJmbxKIQq9MY2M=
X-Received: by 2002:a05:6808:1a0c:b0:479:72dc:bb6 with SMTP id
 5614622812f47-480424fc6b0mr7291184b6e.44.1778253209943; 
 Fri, 08 May 2026 08:13:29 -0700 (PDT)
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 (71-218-113-237.hlrn.qwest.net. [71.218.113.237])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43557109b7dsm1897904fac.5.2026.05.08.08.13.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 08:13:29 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 08 May 2026 09:12:32 -0600
Subject: [PATCH v3 32/32] target/mips: expose Octeon68XX floating-point support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260508-mips-octeon-missing-insns-v2-v3-32-bcbec96357d9@gmail.com>
References: <20260508-mips-octeon-missing-insns-v2-v3-0-bcbec96357d9@gmail.com>
In-Reply-To: <20260508-mips-octeon-missing-insns-v2-v3-0-bcbec96357d9@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x236.google.com
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

Octeon68XX cores implement CP1. Advertise that in the CPU definition by
setting Config1.FP, enabling the writable Status bits, and providing the
FCR0/FCR31 defaults used by this CPU model.

This lets guests observe the expected floating-point feature bits and
use CP1 with -cpu Octeon68XX.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

---
Changes v1 -> v2:
  - Move this CPU-model correction into a separate final patch.
    (suggested by Philippe Mathieu-Daudé)
---
 target/mips/cpu-defs.c.inc | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/target/mips/cpu-defs.c.inc b/target/mips/cpu-defs.c.inc
index faefab0473..cc1916232f 100644
--- a/target/mips/cpu-defs.c.inc
+++ b/target/mips/cpu-defs.c.inc
@@ -997,7 +997,8 @@ const mips_def_t mips_defs[] =
         .CP0_PRid = 0x000D9100,
         .CP0_Config0 = MIPS_CONFIG0 | (0x1 << CP0C0_AR) | (0x2 << CP0C0_AT) |
                        (MMU_TYPE_R4000 << CP0C0_MT),
-        .CP0_Config1 = MIPS_CONFIG1 | (0x3F << CP0C1_MMU) |
+        .CP0_Config1 = MIPS_CONFIG1 | (1 << CP0C1_FP) |
+                       (0x3F << CP0C1_MMU) |
                        (1 << CP0C1_IS) | (4 << CP0C1_IL) | (1 << CP0C1_IA) |
                        (1 << CP0C1_DS) | (4 << CP0C1_DL) | (1 << CP0C1_DA) |
                        (1 << CP0C1_PC) | (1 << CP0C1_WR) | (1 << CP0C1_EP),
@@ -1011,7 +1012,12 @@ const mips_def_t mips_defs[] =
         .CP0_PageGrain = (1 << CP0PG_ELPA),
         .SYNCI_Step = 32,
         .CCRes = 2,
-        .CP0_Status_rw_bitmask = 0x12F8FFFF,
+        .CP0_Status_rw_bitmask = 0x36F8FFFF,
+        .CP1_fcr0 = (1 << FCR0_F64) | (1 << FCR0_3D) | (1 << FCR0_PS) |
+                    (1 << FCR0_L) | (1 << FCR0_W) | (1 << FCR0_D) |
+                    (1 << FCR0_S) | (0x00 << FCR0_PRID) | (0x0 << FCR0_REV),
+        .CP1_fcr31 = 0,
+        .CP1_fcr31_rw_bitmask = 0xFF83FFFF,
         .SEGBITS = 42,
         .PABITS = 49,
         .insn_flags = CPU_MIPS64R2 | INSN_OCTEON,

-- 
2.54.0


