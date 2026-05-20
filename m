Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3EEDCD4F5E
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 04:39:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPYhb-0001hJ-FN; Wed, 20 May 2026 00:38:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPYh5-0001J8-KQ
 for qemu-devel@nongnu.org; Wed, 20 May 2026 00:38:07 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPYh3-0003vM-Vx
 for qemu-devel@nongnu.org; Wed, 20 May 2026 00:38:07 -0400
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7dca00c1591so1190294a34.3
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 21:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779251882; x=1779856682; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zee+lfC/9IdY1ifvacpwHvWZSgyZgmsCPfmoYiMY/lI=;
 b=iF5qmsA3tfX0ckDOYJ/Lc+1Z/70u9nUHNb2JbCvW6V5zIMdnz0+Wd954c+S5eM3RUb
 lMxaXmL7wUkvfMtl7dbRyDN4YErH2AXGTXB5LEf9M7DgJM+diEBG8JVDa2LpB5+82dfE
 iJO4RGBQLpjerHT7z8VOXstTEPTsRNbdbGDVOiXeakgc6SnPZYRV4oiBzVG32pd+U0vB
 SM6tsYS5Xs4y0+3ifV1X/fHGwoirg4KFMcRRJNYnlZF9csJtmspG4s+2U04sc9Tdp8v0
 U1xdkfeefQSxK4ORYyJPPACKHmF+GfJ5cV+IUFFtq18keI9QdOs/lR2VwqtvCWgUexie
 iJPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779251882; x=1779856682;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zee+lfC/9IdY1ifvacpwHvWZSgyZgmsCPfmoYiMY/lI=;
 b=gaEY/XL3mTxX78qusz5mjyBLesemPnhigS1JTz14PKqw2VszDPXzzLLyk9lNR4gJBM
 Yct2yRiuhf3QsLctYVSbtBPeF7RNfMS7Hxm7jRlef+5hRMsh72dmpNp3wwpaNu66MMU5
 f40gME/yVydVI1pQ1d6TnlvDi83bO//Rm7kc705CNtLBtaXinXGbaRomFiRktceVIi/Q
 jCuH9M+IDo1Ejd8BmBAgweVmGTxYLiXT04bY9RNnmnmEpzt7OBMAIAWwv3PqReD6OvEw
 2ll7larR2l05tlXAL/sg17pWC98UJklwfIFxv1HwItXHgFg/zIpZW+mtSPpAl+PrCVtL
 ARtA==
X-Gm-Message-State: AOJu0Yx7DiuUTvOjg3aVxkfxUOCRbzv7hvbaLF9duPI51i8/xL/ufiB2
 56NDm9n3DMKBXvRw0kOAw4JKOLAxrb9Vk7aCLJnSM4YVtX786zrN2lq/
X-Gm-Gg: Acq92OE2Z/S3OwgTo+tbH8ndGtG98i4iXxebNdECLR9pcIFS47YJAC2YPUkBp2d8v2P
 iGOpCGpGj0Ft42bjVYbnKZ8vAQwWKvf9barrcId512dJgCGE3NAcjdDRhRvwQ7SCnvtnz7zO7Tw
 1kD17WNpdS7KueAz6F3BrZ14gE7fexqg+0DDkf/gL/ZxrE00KC4Cbq7OmiWTz6ad1R+af4I8fOB
 9PHBr9VQGXxIuPfJd5bqewLgggO2giMTK7WFRPy+d8xwARK+KUDcWI67hrxft+MgqsXXTVQ47/d
 MxFgSBfkQ5F3lnY4dEK/7Bn6oK7vGj4WnEXmuaEmHxCw4dIj7BNF+QelUF/7th34czbt5PwRMnb
 NjGsYQpEI6aBCI0k8A+H8hIwxsjy4jhTSPDtLxd0GRLZWNHsr7yJ0WQinQZCx2Ck4q+t3bsPOJl
 d5Pbj0ayUIWpGc6S91MuccT17m/vvG71j/2+5t9eE1DljeGcLV5tsaMp9OXljlqElUp+OAFHbHp
 4YIXswDquVhBqqmH+E9TGB1Uk9B8Ykz5UZe0QwlkBQqq9/JxluirovHVj5xx4XaDbsJ
X-Received: by 2002:a05:6830:6d2e:b0:7d7:ea9f:c0f9 with SMTP id
 46e09a7af769-7e4de650958mr15258688a34.0.1779251881900; 
 Tue, 19 May 2026 21:38:01 -0700 (PDT)
Received: from mac.localdomain (184-96-146-19.hlrn.qwest.net. [184.96.146.19])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55bc4f04fsm11574634a34.27.2026.05.19.21.38.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 21:38:01 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 19 May 2026 22:37:34 -0600
Subject: [PATCH v10 40/45] target/mips: decode Octeon ZUC and SNOW3G COP2
 selectors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-mips-octeon-missing-insns-v2-v10-40-306f9edfe15b@gmail.com>
References: <20260519-mips-octeon-missing-insns-v2-v10-0-306f9edfe15b@gmail.com>
In-Reply-To: <20260519-mips-octeon-missing-insns-v2-v10-0-306f9edfe15b@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
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
---
 target/mips/tcg/octeon.decode      | 4 ++++
 target/mips/tcg/octeon_translate.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index f224cdc7a3..662fa25321 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -257,8 +257,12 @@ LDX          011111 ..... ..... ..... 01000 001010 @lx
     CVM_MT_CRC_WRITE_DWORD_REFLECT       010010 00101 rt:5 0001 0010 0001 0111 &cp2
     CVM_MT_CRC_WRITE_VAR_REFLECT         010010 00101 rt:5 0001 0010 0001 1000 &cp2
     CVM_MT_HSH_STARTMD5                  010010 00101 rt:5 0100 0000 0100 0111 &cp2
+    CVM_MT_SNOW3G_START                  010010 00101 rt:5 0100 0000 0100 1101 &cp2
+    CVM_MT_SNOW3G_MORE                   010010 00101 rt:5 0100 0000 0100 1110 &cp2
     CVM_MT_HSH_STARTSHA256               010010 00101 rt:5 0100 0000 0100 1111 &cp2
     CVM_MT_SHA3_STARTOP                  010010 00101 rt:5 0100 0000 0101 0010 &cp2
+    CVM_MT_ZUC_START                     010010 00101 rt:5 0100 0000 0101 0101 &cp2
+    CVM_MT_ZUC_MORE                      010010 00101 rt:5 0100 0000 0101 0110 &cp2
     CVM_MT_HSH_STARTSHA                  010010 00101 rt:5 0100 0000 0101 0111 &cp2
     CVM_MT_GFM_XORMUL1_REFLECT           010010 00101 rt:5 0100 0000 0101 1101 &cp2
     CVM_MT_CRC_WRITE_POLYNOMIAL          010010 00101 rt:5 0100 0010 0000 0000 &cp2
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index c494eb9383..64f549f5ec 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -285,6 +285,10 @@ CP2_MT_HELPER(CVM_MT_SHA3_XORDAT15, sha3_xordat15);
 CP2_MT_HELPER(CVM_MT_SHA3_XORDAT16, sha3_xordat16);
 CP2_MT_HELPER(CVM_MT_SHA3_XORDAT17, sha3_xordat17);
 CP2_MT_HELPER(CVM_MT_SHA3_STARTOP, sha3_startop);
+CP2_MT_HELPER(CVM_MT_ZUC_START, zuc_start);
+CP2_MT_HELPER(CVM_MT_ZUC_MORE, zuc_more);
+CP2_MT_HELPER(CVM_MT_SNOW3G_START, snow3g_start);
+CP2_MT_HELPER(CVM_MT_SNOW3G_MORE, snow3g_more);
 CP2_MT_HELPER(CVM_MT_HSH_STARTSHA_COMPAT, hsh_startsha_compat);
 CP2_MT_HELPER(CVM_MT_HSH_DATW0, hsh_dat0);
 CP2_MT_HELPER(CVM_MT_HSH_DATW1, hsh_dat1);

-- 
2.54.0


