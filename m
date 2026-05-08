Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D24ECCD3436
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 15:17:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLMta-0002p9-4I; Fri, 08 May 2026 11:13:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLMtC-0002g9-UH
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:13:20 -0400
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLMtA-0001ic-Ny
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:13:17 -0400
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-42fe552aedeso765181fac.0
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 08:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778253194; x=1778857994; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kczVofHgEYJaoAmIDajEN/Y34NrxWlQw3aj8VsSTaJM=;
 b=oBlGFRtJApCJ8gSMw1XHAQdmnxFgGueExyWyFwB1TG0TJH+w2TN9sEL9LFCg5sVbhm
 TsWVKepiNKvp74x3EjsjM4lkNkEmznp5jqLIYKI6FaoeK/ZluWkgM6tjdgtgHxHT0yA+
 QP8RB5ezs7T28qp0pQf4nDZ6eIrNxxGl7M/8EtVo9uPyZrVWSCl0pUJGazaxkUi5VvNp
 CHZnzMBh6zPbCTj3z+gRGnG35Mij1eNLlb0fxLx5BFtnUcssyNf/u3oI27Ew7oODh6/e
 1G6rrbC4Qe3NYruCPtVdIyUCCC3ElfWbJq2sAAf6+BrfEY6vqyEwhC3W1QNLP2FzCwVP
 jiSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778253194; x=1778857994;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=kczVofHgEYJaoAmIDajEN/Y34NrxWlQw3aj8VsSTaJM=;
 b=ayq8TBSWbE70la0Mi83N5JSNnuiiUlme+p70bYQfYOTO7Tf64hB/xnhpBqpCBTQNeA
 B2s6sSmzaR2Hw2zxCRq+BvxZQV1lMzJluYrsP5kRZj8BD4g2b1TGD8GNxuMm23SyFfVh
 RLEJhxaVjhl1uZ9PldTfOU1LFtam4sODrlGQBPDmGVMt5o40SvIK8HgI3QvRe6zCtmZZ
 m1K5tduprksQKIAbEBjj4ircWfejYu2B/yfXlslo8mCYchciRuNThLz0q+IzH/twVatH
 KkJzZFRlI8GrPBTOGS5vbftc6iWshvoMGOPRWgGQTAai/o8ZuCvBSKfLWG5ASUQX1gZE
 Z5fA==
X-Gm-Message-State: AOJu0YzkF0qguIWJFmZADmkS1opyzwLD+rsCi/VEeq26YFN49MaM2LnW
 ZQ2UkM2n9bkznER+mpdGI/nZhwnS9zOj6O5dOArB7G8gro7tPeA8B4vDNNpZqw==
X-Gm-Gg: Acq92OGF0xVwlMdxiCOO7cZuwLjBUBq/lu6i7Nk3umM5v6yCyhov7tPwwZffKHGq8M+
 wlS2MjxzchaC/JT9shbB0fPHDy/JmR4No2CHmF8GybDaEFYrUlEisD2YF4bK8abUqbBWA1cfmbD
 mOaWD6PufcfZj2Lu4QW+2MV1dJeUYvVXjyVp7obsM+wbDfNjEONyTJV/aw/VIQD9/AbvF8L7ye6
 8+inq+FUD6zaxymAQVVGC+c/vD8DEvuwzmi1DJmovm3Q5DqjyAcZS5sC9WvqwVeGOiybiOTyw4k
 fq3iGdu9aPrHonZgSofjfFQssX6I0Sm0dtkwqGNB8dalFCYgdIsQtzTUZZxRkwJHsU8da1mRoV/
 pPL3rPqA8tiMT0NoKYfvvOlxiGDruJJhp5Mi6vd/StYCjBg0Z+3eVf9I7I2xK53bVMzr8QCuV/p
 deIi6yOATfgDh00hbv1TotQMt5XcIy8UK10s3Tn9VSvGpNvk+Jx2+h1QYyPz17OZJJqQXb438U6
 11mtdZKfPtN5JJsOMXys9WDanox4g8frWL9ikNBtbucpFeUrZmkCesCpYyAqVk/Ji9GtENWb/XS
 +vyDD/QGfMPc7qt40/Swi2mEoFDb//gJVK3e3+dotJj56eZOpPLROMtkpdIYnmXPyj8x0nnacmW
 /+O9NuQ==
X-Received: by 2002:a05:6870:ebc8:b0:435:7e8b:8f1 with SMTP id
 586e51a60fabf-4357e8b5c34mr25470fac.39.1778253194351; 
 Fri, 08 May 2026 08:13:14 -0700 (PDT)
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 (71-218-113-237.hlrn.qwest.net. [71.218.113.237])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43557109b7dsm1897904fac.5.2026.05.08.08.13.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 08:13:13 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 08 May 2026 09:12:16 -0600
Subject: [PATCH v3 16/32] target/mips: add Octeon MTP0 instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-mips-octeon-missing-insns-v2-v3-16-bcbec96357d9@gmail.com>
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
Received-SPF: pass client-ip=2001:4860:4864:20::2f;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oa1-x2f.google.com
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

MTP0 loads the low partial-product pair from rs/rt into P[0] and P[3].

Add the translator storage path so subsequent VMULU/VMM0/V3MULU
operations can consume guest-managed partial products.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - Split MTP0 out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)
---
 target/mips/tcg/octeon.decode      |  1 +
 target/mips/tcg/octeon_translate.c | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 2dadb13845..94dbc356ec 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -45,6 +45,7 @@ SEQI         011100 rs:5 rt:5 imm:s10 101110 &cmpi
 SNEI         011100 rs:5 rt:5 imm:s10 101111 &cmpi
 &r2          rs rt
 MTM0         011100 rs:5 rt:5 00000 00000 001000 &r2
+MTP0         011100 rs:5 rt:5 00000 00000 001001 &r2
 
 &saa         base rt
 @saa         ...... base:5 rt:5 ................ &saa
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 186200036e..5a0ff4dad3 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -270,6 +270,17 @@ static bool trans_mtm(DisasContext *ctx, arg_r2 *a, unsigned int index)
     return true;
 }
 
+static bool trans_mtp(DisasContext *ctx, arg_r2 *a, unsigned int index)
+{
+    TCGv_i64 value = tcg_temp_new_i64();
+
+    gen_load_gpr(value, a->rs);
+    octeon_store_tc_field(octeon_tc_p_offset(index), value);
+    gen_load_gpr(value, a->rt);
+    octeon_store_tc_field(octeon_tc_p_offset(index + 3), value);
+    return true;
+}
+
 TRANS(SAA,  trans_saa, MO_UL);
 TRANS(SAAD, trans_saa, MO_UQ);
 TRANS(LBX,  trans_lx, MO_SB);
@@ -280,3 +291,4 @@ TRANS(LWX,  trans_lx, MO_SL);
 TRANS(LWUX, trans_lx, MO_UL);
 TRANS(LDX,  trans_lx, MO_UQ);
 TRANS(MTM0, trans_mtm, 0);
+TRANS(MTP0, trans_mtp, 0);

-- 
2.54.0


