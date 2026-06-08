Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D2DBCD8CA4
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 19:03:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWfD3-00015h-AY; Mon, 08 Jun 2026 15:00:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wWfCy-00012C-Hm
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 15:00:24 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wWfCv-0006mo-Kf
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 15:00:24 -0400
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7e6f27619e7so3821520a34.2
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 12:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780945220; x=1781550020; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kNDxHYWhTOsNn0OdBaliY8wf/EghWpS60PkiWLVESW8=;
 b=UUzZ+fd8jMfpEA3THVF3kNF4nHtegtKkzGk21sY5mnOiafmj7VRiDmDDLKmC5qF4dj
 aS97qGC0FWmSDN/rTcItZJ2XfKbeBQ24BJM88n/w2xzMpwkCuFrr3sq5M5FBWL6F2J2S
 zN4sZt1ssRgHzVKMZ58ETXruPln1soM9cEJ7lKdryrzEm/GUthqEQGyN408yUUH3qe0I
 FsCip18WoGTkAvKY4Jdqb7zQ9k4i8pFu4EoieLGNM6oIa0f8PRCdmRk4g/pOHLZLU61J
 zmaJ8JVM8CYlNC/Dc809qFLgHJU+oMy2g+6mBZNh4UtsJF6nfTL/kQcnzYuFdtl+T7Tg
 4FeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780945220; x=1781550020;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=kNDxHYWhTOsNn0OdBaliY8wf/EghWpS60PkiWLVESW8=;
 b=CxhowrncyzNw41VluU6Jq6HQaF6lqcbt/mFK5/O9UnIrzAak7hC//yLXY81VBM8H68
 I8yylsLlKw1AbgLvaxuMRGUlAjWlDPR2z6Aoi56r6/pCyDcpqkuN27c1t/BKMxVB9rYV
 A/aKvEi1R5oIN/JAHNY57HcA3jJH6ORN0aUbQord9G1DOo/E+Xy/cKU/xerV20c/oioT
 aUgFRojObjZWrHa/2C5N5bUB9zgqms9EAGZOYMhwyXwt3J3WltnKfVHJdi75cIysPCiM
 tAtQ1TrsismUJGUcsIKfKluufFnn3MR/EQh3tU1ugCrkApZrV2hBgoig5fOSuv+veXiP
 0Bvw==
X-Gm-Message-State: AOJu0YwdE5CbMFuJSVkaazrvlDDy2zHU8/l40VRGxtBFYUn6CD4n8xXa
 6BIhtc/cYE8oAswngDFYMVO6yQTDy/SRfychXWSJL38i1EZ+EuEMZd7PSpFKPT/2hFY=
X-Gm-Gg: Acq92OHZalbukZBbLPXuuVAFvBc0o46eTwYglNeo5FcISg7Iw80hiashKRsK0QBOvUc
 kNeVePTNrCGhvY2KTY+491T75l5PUyZFfXcrYFnM8Y5bjqZfkbb7f/Op7vqy82MHB/ZhkVP36Gu
 GBXS8ovMaHYV8feKOb4TJdoGR1OCUtDmZdFfrQVwBxxi08jbEEH6tjqL6MQeBSJqzFPvC+BfPx3
 pLER2nY0I+oCSP/v9XYiYGLJBrIxhTiVuFYfHEHewvYQfSZur+8fN+t/spHRaP7BnGHaK/6bXkO
 MFsWUWYFf8GH+xlTt72ic4pL1Zk20NAe4xQh6noWtiioiYWpm3VLS5R4hZVcxeNrEuETzITQ+YV
 a7/oDkLVA5ZBNA3pmNezkj922GGqoTVct0gNieILFBe2cvAL9Qa221iqB/9hOTG2Hf8hkoRh4E1
 6tzfyp3uj1KcHOQjEemhedZT6N4Hd0gR2YW3U3all4UPwsFZHpo/956H2DLaHpuj2QjTfeR60yq
 euCGyj62pTimBbiV27Hum0qKDe+f9hlOZvwLFow0NFuDqm9q2ZMTKYmyCMrZHIowvLFb74ERjmZ
 6gjXTV66akH47+h3bu0Lz48eKGUTfQQnewKoNL8YpVE=
X-Received: by 2002:a05:6830:67f7:b0:7e6:eb9c:3781 with SMTP id
 46e09a7af769-7e70c7c99d1mr11288529a34.12.1780945220467; 
 Mon, 08 Jun 2026 12:00:20 -0700 (PDT)
Received: from mac.localdomain (97-118-5-210.hlrn.qwest.net. [97.118.5.210])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e6e75db138sm12397777a34.11.2026.06.08.12.00.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 12:00:19 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 08 Jun 2026 12:59:42 -0600
Subject: [PATCH v16 17/21] target/mips: decode Octeon ZUC and SNOW3G COP2
 selectors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-mips-octeon-missing-insns-v2-v16-17-daef7a0d8b04@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x330.google.com
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
ZUC and SNOW3G COP2 operation selectors.  These stream-cipher selectors
operate on the shared HSH register window state, so dispatch them through
the per-operation helpers added with the corresponding engine support.

Keep stream-cipher decode separate because these selectors share the HSH
register window with unrelated engines.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

---
Changes v9 -> v10:
  - Split ZUC/SNOW3G selector decode out of the monolithic Octeon COP2
    selector decode patch.
  - Kept stream-cipher operation selectors helper-backed because they
    operate on the shared HSH register-window state.
---
 target/mips/tcg/octeon.decode      | 4 ++++
 target/mips/tcg/octeon_translate.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index b1a63b743f..2b27fa205f 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -265,8 +265,12 @@ LDX          011111 ..... ..... ..... 01000 001010 @lx
     CVM_MT_CRC_DWORD_REFLECT             010010 00101 rt:5 0001 0010 0001 0111 &cp2
     CVM_MT_CRC_VAR_REFLECT               010010 00101 rt:5 0001 0010 0001 1000 &cp2
     CVM_MT_HSH_STARTMD5                  010010 00101 rt:5 0100 0000 0100 0111 &cp2
+    CVM_MT_SNOW3G_START                  010010 00101 rt:5 0100 0000 0100 1101 &cp2
+    CVM_MT_SNOW3G_MORE                   010010 00101 rt:5 0100 0000 0100 1110 &cp2
     CVM_MT_HSH_STARTSHA256               010010 00101 rt:5 0100 0000 0100 1111 &cp2
     CVM_MT_SHA3_STARTOP                  010010 00101 rt:5 0100 0000 0101 0010 &cp2
+    CVM_MT_ZUC_START                     010010 00101 rt:5 0100 0000 0101 0101 &cp2
+    CVM_MT_ZUC_MORE                      010010 00101 rt:5 0100 0000 0101 0110 &cp2
     CVM_MT_HSH_STARTSHA                  010010 00101 rt:5 0100 0000 0101 0111 &cp2
     CVM_MT_GFM_XORMUL1_REFLECT           010010 00101 rt:5 0100 0000 0101 1101 &cp2
     CVM_MT_CRC_POLYNOMIAL                010010 00101 rt:5 0100 0010 0000 0000 &cp2
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 5497e5a6ce..b4663b35a3 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -345,6 +345,10 @@ CP2_MT_XOR_I64(CVM_MT_SHA3_XORDAT15, sha3_dat[15]);
 CP2_MT_XOR_I64(CVM_MT_SHA3_XORDAT16, sha3_dat[16]);
 CP2_MT_XOR_I64(CVM_MT_SHA3_XORDAT17, sha3_dat[17]);
 CP2_MT_HELPER_ENV(CVM_MT_SHA3_STARTOP, sha3_startop);
+CP2_MT_HELPER(CVM_MT_ZUC_START, zuc_start);
+CP2_MT_HELPER(CVM_MT_ZUC_MORE, zuc_more);
+CP2_MT_HELPER(CVM_MT_SNOW3G_START, snow3g_start);
+CP2_MT_HELPER(CVM_MT_SNOW3G_MORE, snow3g_more);
 CP2_MT_HELPER(CVM_MT_HSH_STARTSHA1_COMPAT, hsh_startsha1_compat);
 CP2_MT_I64(CVM_MT_HSH_DATW0, hsh_dat[0]);
 CP2_MT_I64(CVM_MT_HSH_DATW1, hsh_dat[1]);

-- 
2.54.0


