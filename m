Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7355B606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 14:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=itx.no header.i=@itx.no header.a=rsa-sha256 header.s=mx.itx.no header.b=cUPmtNBg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJBGc-0003Yy-Ti; Tue, 20 Oct 2026 10:56:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stian@itx.no>) id 1xJBGb-0003Xr-0s
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 10:56:41 -0400
Received: from itx-kvm-14.itxnorge.no ([91.189.121.228] helo=mx.itxnorge.no)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stian@itx.no>) id 1xJBGY-0003KJ-JB
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 10:56:40 -0400
From: Stian Halseth <stian@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
 t=1792508188;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2LlPjc4dBDjov1Ke+hwYVQf4EyEvslXfTfmSsvTlO8s=;
 b=cUPmtNBg9cI807b3E00BRj8bhzzf6VgRhy8HxEdCOu5gksllHqUpLs6enDbvKUNVHG+wxj
 MVZTc6rXVZwwm3TFZJ2qgPJ9LLMza25OupFiRH1DBBM2asJNd1FgnQrWeQjQrwOFFdUTTN
 veiYe6psLiKzcza+c52z0pnuJLdEicE=
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Biggers <ebiggers@kernel.org>, Stian Halseth <stian@itx.no>
Subject: [PATCH 2/7] target/sparc: Return CFR when crypto feature is enabled
Date: Tue, 20 Oct 2026 16:55:25 +0200
Message-ID: <20261020145530.3385376-3-stian@itx.no>
In-Reply-To: <20261020145530.3385376-1-stian@itx.no>
References: <20261020145530.3385376-1-stian@itx.no>
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

ASR 26 returns a Compatibility Feature Register (CFR) when the
crypto feature is on.  Without the crypto feature, a read keeps
strand status as before.

Reports AES, SHA1, SHA256, SHA512, CRC32C.
Guests can read the CFR before using each crypto instruction.

Based on OSA (Oracle SPARC Architecture) 2011:
- 5.5 (Ancillary State Registers), table 5-8
- 5.5.11 Compatibility Feature Register (CFR), table 5-15

Signed-off-by: Stian Halseth <stian@itx.no>
---
 target/sparc/insns.decode |  5 ++++-
 target/sparc/translate.c  | 15 +++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 242ec42016..55f8528ffe 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -106,7 +106,10 @@ CALL    01 i:s30
     RDTICK_CMPR     10 rd:5  101000 10111 0 0000000000000
     RDSTICK         10 rd:5  101000 11000 0 0000000000000
     RDSTICK_CMPR    10 rd:5  101000 11001 0 0000000000000
-    RDSTRAND_STATUS 10 rd:5  101000 11010 0 0000000000000
+    {
+      RDCFR           10 rd:5  101000 11010 0 0000000000000
+      RDSTRAND_STATUS 10 rd:5  101000 11010 0 0000000000000
+    }
   ]
 
   # The v8 manual, section B.30 STBAR instruction, says
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index b93feb074b..00a6988d62 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -3022,6 +3022,21 @@ static TCGv do_rdstrand_status(DisasContext *dc, TCGv dst)
 
 TRANS(RDSTRAND_STATUS, HYPV, do_rd_special, true, a->rd, do_rdstrand_status)
 
+/* CFR bits (OSA 2011, 5.5.11) */
+#define CFR_AES         (1 << 0)
+#define CFR_SHA1        (1 << 5)
+#define CFR_SHA256      (1 << 6)
+#define CFR_SHA512      (1 << 7)
+#define CFR_CRC32C      (1 << 11)
+
+static TCGv do_rdcfr(DisasContext *dc, TCGv dst)
+{
+    return tcg_constant_tl(CFR_AES | CFR_SHA1 | CFR_SHA256 |
+                           CFR_SHA512 | CFR_CRC32C);
+}
+
+TRANS(RDCFR, CRYPTO, do_rd_special, true, a->rd, do_rdcfr)
+
 static TCGv do_rdpsr(DisasContext *dc, TCGv dst)
 {
     gen_helper_rdpsr(dst, tcg_env);
-- 
2.43.0


