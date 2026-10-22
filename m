Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F48C606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 07:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=itx.no header.i=@itx.no header.a=rsa-sha256 header.s=mx.itx.no header.b=jZfs/dwO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJmoF-0002uu-F5; Thu, 22 Oct 2026 03:01:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stian@itx.no>) id 1xJmnj-0002oM-MJ
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 03:01:25 -0400
Received: from itx-kvm-14.itxnorge.no ([91.189.121.228] helo=mx.itxnorge.no)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stian@itx.no>) id 1xJmni-0005vo-3x
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 03:01:23 -0400
From: Stian Halseth <stian@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
 t=1792652469;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vxriTHHowpsSZLR87NAuAdPjs7ttJqW/KlYeswRB0m4=;
 b=jZfs/dwOCTMpzIcE+gRmaUs6O6YMx57X5KG+R42on1A1Faon2ALVvp04TgGm9rwYxL63u0
 nOLmjqVLv+mO+PkmV6j6V5Ih25wMCcXxmto0wSnMe8cXLS4LgRVCnCWp2PsCxLLXi2Icy0
 VkpENjewdQ8vQlpNyLSswJ89TrZ+k2A=
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Biggers <ebiggers@kernel.org>, Stian Halseth <stian@itx.no>
Subject: [PATCH v3 7/8] target/sparc: Allow block-init stores when the CPU has
 the crypto feature
Date: Thu, 22 Oct 2026 09:00:58 +0200
Message-ID: <20261022070059.3861291-8-stian@itx.no>
In-Reply-To: <20261022070059.3861291-1-stian@itx.no>
References: <20261022070059.3861291-1-stian@itx.no>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=91.189.121.228; envelope-from=stian@itx.no;
 helo=mx.itxnorge.no
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The next patch reports HWCAP_SPARC_CRYPTO to linux-user guests.
A multiarch glibc then picks its niagara4 memcpy/memset, which
store with ASI 0xe2. QEMU only allows that store on CPUs with
HYPV, so every dynamically linked program dies with SIGILL.

The crypto opcodes exist only on T4 and later, and all of those
have the block-init ASIs.

Reproduced with Gentoo sparc64 stage3 sysroot:
qemu-sparc64 -L <stage3 root> -cpu \
TI-UltraSparc-IIi,+crypto <stage3 root>/usr/bin/dd --version

Signed-off-by: Stian Halseth <stian@itx.no>
---
 target/sparc/translate.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 921ffd2d1b..931fc006ce 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1863,8 +1863,12 @@ static void gen_st_asi(DisasContext *dc, DisasASI *da, TCGv src, TCGv addr)
         if (TARGET_LONG_BITS == 32) {
             gen_exception(dc, TT_ILL_INSN);
             break;
-        } else if (!(dc->def->features & CPU_FEATURE_HYPV)) {
-            /* Pre OpenSPARC CPUs don't have these */
+        } else if (!(dc->def->features &
+                    (CPU_FEATURE_HYPV | CPU_FEATURE_CRYPTO))) {
+            /*
+             * Pre-OpenSPARC CPUs lack block-init stores. Crypto instructions
+             * imply T4 or later, which supports them.
+             */
             gen_exception(dc, TT_ILL_INSN);
             break;
         }
-- 
2.43.0


