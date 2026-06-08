Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF101CD8CAE
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 19:01:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWfD2-00014i-3A; Mon, 08 Jun 2026 15:00:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wWfD0-00013e-30
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 15:00:26 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wWfCw-0006sI-C9
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 15:00:25 -0400
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7e6e21c47e6so2053238a34.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 12:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780945221; x=1781550021; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Itk/+hHnAXi54GejRG9Qzx8wNFURSexUEVLdbkIeDSk=;
 b=h5ELtSIoUd0kETSZjy9q2eSFh2yBowRgqDvqu5QibHA2bu2xmZTRhqFEXp0zoNAc7V
 pyAmA0dUU1MbfABfzO8yviv6szNHJ7iztOIYvEdYqfB9xXZiyYFYN4UFRafZU2anZVZo
 yqTry2HldcMu1yjiXtR6V6F2My1lzbfUQyn0tAXOsIs7ShXN8eSaAzVyqMchnUDXXQnH
 anpd/kMQ0pabZt5d4Pea4NJO/Jnxfu4pPu2ONuwszV+0dXxLcA+viWr6Qt2whTEO8YkH
 cN7Ebou7r3Vz6jkMgHXZWOIl9pekHwuJCb3/85QSsDEF/C5gsKt89CHa6hO0dr+xxl/0
 yrYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780945221; x=1781550021;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Itk/+hHnAXi54GejRG9Qzx8wNFURSexUEVLdbkIeDSk=;
 b=qK8XDAztsdSvEGdTSm4YllWbOLcO+1vhnqBRvzns0VK+XM3M1JfASwwicfL3oLA2FW
 xADwzMex4Q5x7xuH+Ke9QVzT+Wd4+oLbrnUFT3foSiQsKy00iS4gGho1FeYCBL2V1F3H
 7kVlbF0ymrMLbFqbEdDOebJVlyqBsaz0GL5d66PYWuFkqD4P2JgITnCTvvkvYKqAdBGX
 yr1kq28w59gP/utvzffcX6jdFTJtvwl1XtDqejft9JH89kr6qIUnZSDf2JoEqGYQJYkR
 JOfZ+irLKWpmFlruvxrRxvgSaBogCzdP90hOdQu4ZU2S1yelkkB+8PmKc/hgh8n3FB67
 ovyw==
X-Gm-Message-State: AOJu0YzfCFL7LHzhABexMYuin6GuZcJj6HkWleGkuWOSIXqmwTNWUlua
 BCQQomkx2mDRASKLvkARJlHpnlAOW03LopXZG2a4hQSOrxV8zgkdSCzhDsDrJeAW+RQ=
X-Gm-Gg: Acq92OG30kmkn/FYpKMJnC3IXpUeJ3COLI7tHspUf4Xbdb2CdypnWDaN3iNY4jURDZ2
 fLJiYLYcUaWX8lmVGsfIiBsP9ip+9XkqGJ5QF/Bhhws+CCmWvMwxLaPwHrTi6talekL+DJYZXsz
 3irisizbKqJc3J3C5oVyAubxUnxn8A7rYz8gZhk8flygvQLse5nAGLsdQK586E68n/+lyHgMqTi
 kjgdN8Aed9tbYYGrS77jZhowJ/HLcHWeQBihwUqsO8sKD7OHBkvsGbSNlWK0cMz5T1r4vpFMpiB
 K1EidOWIv136moTmXXnNuV29ApWtQT03Fi4b9RVJZXsJ9DeJtuen/WWHawAFeI9QLbTrJQN0gBZ
 L0i+rbSLHPzjSSybw+qVUovXymacIVyPWAM9O+94FqgceRSX4/f2Yp0Jb39zOpL7XoydwoCeVqn
 sZlsacQohDsnuuj5f3b65TGpeKWr95tbC2Y7DvIdc0fYhBSnhnRZDwGySgmF4iIf+t4FGqpduxt
 /v6hGE+OdrLIiW7saPWIBthXTzKqV3fKG7jCf824fKvGDBILOCW0y7BPt33UIWgxyf2N8Y34PtO
 3pTYjjRcQsK1Jzy4+qG/WPLrFKvqPqdi
X-Received: by 2002:a05:6830:83ac:b0:7e5:6d2e:acd9 with SMTP id
 46e09a7af769-7e70ca29eb1mr10149872a34.12.1780945221262; 
 Mon, 08 Jun 2026 12:00:21 -0700 (PDT)
Received: from mac.localdomain (97-118-5-210.hlrn.qwest.net. [97.118.5.210])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e6e75db138sm12397777a34.11.2026.06.08.12.00.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 12:00:20 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 08 Jun 2026 12:59:43 -0600
Subject: [PATCH v16 18/21] target/mips: decode Octeon block-cipher COP2
 selectors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-mips-octeon-missing-insns-v2-v16-18-daef7a0d8b04@gmail.com>
References: <20260608-mips-octeon-missing-insns-v2-v16-0-daef7a0d8b04@gmail.com>
In-Reply-To: <20260608-mips-octeon-missing-insns-v2-v16-0-daef7a0d8b04@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x335.google.com
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

Add explicit decodetree entries and translator bindings for the Octeon
AES, SMS4, 3DES, KASUMI, and Camellia COP2 operation selectors.  These
selectors consume or update engine state, so keep them as per-operation
helper calls while the simple block-cipher register moves remain direct
TCG loads and stores from the earlier register-selector patch.

This completes the block-cipher selector coverage without reintroducing a
generic runtime selector dispatch path.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

---
Changes v9 -> v10:
  - Split AES, SMS4, 3DES, KASUMI, and Camellia selector decode out of
    the monolithic Octeon COP2 selector decode patch.
  - Kept block-cipher operation selectors helper-backed while simple
    register moves remain direct TCG transfers.
---
 target/mips/tcg/octeon.decode      | 17 +++++++++++++++++
 target/mips/tcg/octeon_translate.c | 17 +++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 2b27fa205f..4ac38d264c 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -203,6 +203,8 @@ LDX          011111 ..... ..... ..... 01000 001010 @lx
     CVM_MT_AES_DEC_CBC0                  010010 00101 rt:5 0000 0001 0000 1100 &cp2
     CVM_MT_AES_DEC0                      010010 00101 rt:5 0000 0001 0000 1110 &cp2
     CVM_MT_AES_KEYLENGTH                 010010 00101 rt:5 0000 0001 0001 0000 &cp2
+    CVM_MT_CAMELLIA_FL                   010010 00101 rt:5 0000 0001 0001 0101 &cp2
+    CVM_MT_CAMELLIA_FLINV                010010 00101 rt:5 0000 0001 0001 0110 &cp2
     CVM_MT_CRC_IV                        010010 00101 rt:5 0000 0010 0000 0001 &cp2
     CVM_MT_CRC_IV_REFLECT                010010 00101 rt:5 0000 0010 0001 0001 &cp2
     CVM_MT_CRC_BYTE                      010010 00101 rt:5 0000 0010 0000 0100 &cp2
@@ -264,6 +266,15 @@ LDX          011111 ..... ..... ..... 01000 001010 @lx
     CVM_MT_CRC_VAR                       010010 00101 rt:5 0001 0010 0000 1000 &cp2
     CVM_MT_CRC_DWORD_REFLECT             010010 00101 rt:5 0001 0010 0001 0111 &cp2
     CVM_MT_CRC_VAR_REFLECT               010010 00101 rt:5 0001 0010 0001 1000 &cp2
+    CVM_MT_AES_ENC_CBC1                  010010 00101 rt:5 0011 0001 0000 1001 &cp2
+    CVM_MT_AES_ENC1                      010010 00101 rt:5 0011 0001 0000 1011 &cp2
+    CVM_MT_AES_DEC_CBC1                  010010 00101 rt:5 0011 0001 0000 1101 &cp2
+    CVM_MT_AES_DEC1                      010010 00101 rt:5 0011 0001 0000 1111 &cp2
+    CVM_MT_CAMELLIA_ROUND                010010 00101 rt:5 0011 0001 0001 0100 &cp2
+    CVM_MT_SMS4_ENC_CBC1                 010010 00101 rt:5 0011 0001 0001 1001 &cp2
+    CVM_MT_SMS4_ENC1                     010010 00101 rt:5 0011 0001 0001 1011 &cp2
+    CVM_MT_SMS4_DEC_CBC1                 010010 00101 rt:5 0011 0001 0001 1101 &cp2
+    CVM_MT_SMS4_DEC1                     010010 00101 rt:5 0011 0001 0001 1111 &cp2
     CVM_MT_HSH_STARTMD5                  010010 00101 rt:5 0100 0000 0100 0111 &cp2
     CVM_MT_SNOW3G_START                  010010 00101 rt:5 0100 0000 0100 1101 &cp2
     CVM_MT_SNOW3G_MORE                   010010 00101 rt:5 0100 0000 0100 1110 &cp2
@@ -273,6 +284,12 @@ LDX          011111 ..... ..... ..... 01000 001010 @lx
     CVM_MT_ZUC_MORE                      010010 00101 rt:5 0100 0000 0101 0110 &cp2
     CVM_MT_HSH_STARTSHA                  010010 00101 rt:5 0100 0000 0101 0111 &cp2
     CVM_MT_GFM_XORMUL1_REFLECT           010010 00101 rt:5 0100 0000 0101 1101 &cp2
+    CVM_MT_3DES_ENC_CBC                  010010 00101 rt:5 0100 0000 1000 1000 &cp2
+    CVM_MT_KAS_ENC_CBC                   010010 00101 rt:5 0100 0000 1000 1001 &cp2
+    CVM_MT_3DES_ENC                      010010 00101 rt:5 0100 0000 1000 1010 &cp2
+    CVM_MT_KAS_ENC                       010010 00101 rt:5 0100 0000 1000 1011 &cp2
+    CVM_MT_3DES_DEC_CBC                  010010 00101 rt:5 0100 0000 1000 1100 &cp2
+    CVM_MT_3DES_DEC                      010010 00101 rt:5 0100 0000 1000 1110 &cp2
     CVM_MT_CRC_POLYNOMIAL                010010 00101 rt:5 0100 0010 0000 0000 &cp2
     CVM_MT_CRC_POLYNOMIAL_REFLECT        010010 00101 rt:5 0100 0010 0001 0000 &cp2
     CVM_MT_HSH_STARTSHA512               010010 00101 rt:5 0100 0010 0100 1111 &cp2
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index b4663b35a3..76792c9c87 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -349,6 +349,23 @@ CP2_MT_HELPER(CVM_MT_ZUC_START, zuc_start);
 CP2_MT_HELPER(CVM_MT_ZUC_MORE, zuc_more);
 CP2_MT_HELPER(CVM_MT_SNOW3G_START, snow3g_start);
 CP2_MT_HELPER(CVM_MT_SNOW3G_MORE, snow3g_more);
+CP2_MT_HELPER(CVM_MT_AES_ENC_CBC1, aes_enc_cbc1);
+CP2_MT_HELPER(CVM_MT_AES_ENC1, aes_enc1);
+CP2_MT_HELPER(CVM_MT_AES_DEC_CBC1, aes_dec_cbc1);
+CP2_MT_HELPER(CVM_MT_AES_DEC1, aes_dec1);
+CP2_MT_HELPER(CVM_MT_SMS4_ENC_CBC1, sms4_enc_cbc1);
+CP2_MT_HELPER(CVM_MT_SMS4_ENC1, sms4_enc1);
+CP2_MT_HELPER(CVM_MT_SMS4_DEC_CBC1, sms4_dec_cbc1);
+CP2_MT_HELPER(CVM_MT_SMS4_DEC1, sms4_dec1);
+CP2_MT_HELPER(CVM_MT_3DES_ENC_CBC, des3_enc_cbc);
+CP2_MT_HELPER(CVM_MT_KAS_ENC_CBC, kas_enc_cbc);
+CP2_MT_HELPER(CVM_MT_3DES_ENC, des3_enc);
+CP2_MT_HELPER(CVM_MT_KAS_ENC, kas_enc);
+CP2_MT_HELPER(CVM_MT_3DES_DEC_CBC, des3_dec_cbc);
+CP2_MT_HELPER(CVM_MT_3DES_DEC, des3_dec);
+CP2_MT_HELPER(CVM_MT_CAMELLIA_FL, camellia_fl);
+CP2_MT_HELPER(CVM_MT_CAMELLIA_FLINV, camellia_flinv);
+CP2_MT_HELPER(CVM_MT_CAMELLIA_ROUND, camellia_round);
 CP2_MT_HELPER(CVM_MT_HSH_STARTSHA1_COMPAT, hsh_startsha1_compat);
 CP2_MT_I64(CVM_MT_HSH_DATW0, hsh_dat[0]);
 CP2_MT_I64(CVM_MT_HSH_DATW1, hsh_dat[1]);

-- 
2.54.0


