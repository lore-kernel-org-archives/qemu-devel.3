Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BDDACA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 11:52:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut33k-0006Xw-1x; Mon, 01 Sep 2025 07:50:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ut31j-0003td-D1; Mon, 01 Sep 2025 07:48:48 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ut31b-0001uK-AP; Mon, 01 Sep 2025 07:48:47 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-24a95f9420aso13826085ad.0; 
 Mon, 01 Sep 2025 04:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756727307; x=1757332107; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wrau3B2sXx6DsPs6H2dSpeAMNFagRpH9CKQrGL827lA=;
 b=RHsGJMIZRUHnXUznUs4IEstOlb0NmJ+pdLrAgzx0KdUVQZ2Shy4eBOjf8Si/D6A56h
 9ZRyfL97Ivh5G5zWyQltlZ2HkOMCmE0Rz7mDpaaPgkJ9g9ur1dXczr1RkyjQE1ZodznX
 4uQByE9rkNW/0XYnjWcb4ziDF3KRVZGvlJKca+TzW3BPcTrIcgISUQPugPzAhQskzC/B
 JQxd8H71Tqa4Hl/tJNi4VwBFra6tvHYvjdMQtH5yL6M+c4YhuJ8GS6xbGxstJlg8Iy2I
 URJ5uPh8oGMSqr3yjNQUxuzOfABA6GoY2PFgIe4MKaMIxVa6RIHSg7KKQt3dlZXxnyuh
 4ZOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756727307; x=1757332107;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wrau3B2sXx6DsPs6H2dSpeAMNFagRpH9CKQrGL827lA=;
 b=rSyCqMz2Y5d0Oc+iOQR/UyIWF02tmPeN0KckklQ3oz+yxYKW43PAnioqRlDnDNONAy
 VmM9zVFJS49pvWkmBt+nIfuwPDJYukKxmRQho90y9SUmaYmCIY6RLaLJN3KVbN6vx7Rz
 ebITC6m4Km09uqb8M4OhSqIAHn8sUCU3GZ75pWDfvFiVhsckbqb7Pg4ToEGP7sEyM7j9
 nacYQ342rFcjIFMlJ9uzOu/zTiTCtNEFh8i1RaHahmx78gInxqtax4VKzYVJOoNgcS1v
 ltJihnsaB+9kgRdpaFCpHerWB7SKZ2n17vxCzN8N8wDZRXsadsPQCluVOKJ6fOXTsskP
 3nQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXW1TZT77zgjxtLzreAli4we3tD/IZWP5nKZePCuou+fUDrHG2P7rBmVS/t/9ZdV2ui3dHEFrHj0g==@nongnu.org,
 AJvYcCXneeWKzAsazLEzvBjbC3+jjytYaLcKOwuuIpjdYZNcDjD3jKkIcekdqLp0iuPvDqBJg4p4qafYauAcBQ==@nongnu.org
X-Gm-Message-State: AOJu0YxiH6/122gOg9nFpM1JXPtmmvVWQzrh8dpVY9ymIcXYGYqKUBCX
 turB/KUJnsmMSHRFXlT/Vw1KRX0JvWRYTtM1qfUIHO6oZjIp0SEO5dPjqO+bWA==
X-Gm-Gg: ASbGncunif9t4rEr1VFp6aoocEnsMmKJzEg4NCn5MjRvCSQl9cFz45FpQcJqIaK2DDG
 +Tv0AVYrjHFDHaDP6vyjboHD3iTXGnVPqduddrYkyCCvJYmcdEzt18JlVD8uvfhzKkZE647WOal
 IBxJ7Gf+PfO86wFEemSGZD8Mt8lFjh1bFpA6uVeteezIHgG2vHN8AZc1VorijxtWoZ1zJP9FPIQ
 h9oYu+/l//E9p2jz06FPe+oSH7Cu9yMHZmg1+erHe13SuMHQOBXS3Sn5BWSzBk18iB9QDqevZUA
 uNVEeeEK7blvAOV71kIw23g1NJAcoaGnDgV/y0cRTjHzrctO3Bp7scSyH2yfsxh3cvijcrdmIBi
 I2NA/UH8noBkCzzlsNozywLPNC+B1KMpi
X-Google-Smtp-Source: AGHT+IG8nxtpQ6bZRaZmbY6USeemcji1i292PRaIKJxgcusJVAX6OGtb50F2NtrzhiDNx3dQCmUXdg==
X-Received: by 2002:a17:903:28d:b0:249:2c40:51b2 with SMTP id
 d9443c01a7336-24944b8143dmr101218695ad.59.1756727306740; 
 Mon, 01 Sep 2025 04:48:26 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:750a:cb0b:f0f9:68f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-249065a8036sm103038775ad.129.2025.09.01.04.48.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 04:48:26 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 WANG Xuerui <git@xen0n.name>, Aurelien Jarno <aurelien@aurel32.net>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Stefan Weil <sw@weilnetz.de>,
 qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, ktokunaga.mail@gmail.com
Subject: [PATCH v3 32/35] tcg/wasm: Add tcg_target_init function
Date: Mon,  1 Sep 2025 20:44:34 +0900
Message-ID: <e54f87bfc2c59e953ae66ba7273b259e440b3605.1756724464.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1756724464.git.ktokunaga.mail@gmail.com>
References: <cover.1756724464.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

This commit adds tcg_target_init, aligning it with the Wasm backend's
register and stack usage.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm/tcg-target.c.inc | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/tcg/wasm/tcg-target.c.inc b/tcg/wasm/tcg-target.c.inc
index 25691307b4..3bb4864da5 100644
--- a/tcg/wasm/tcg-target.c.inc
+++ b/tcg/wasm/tcg-target.c.inc
@@ -2812,3 +2812,32 @@ static int tcg_out_tb_end(TCGContext *s)
 
     return 0;
 }
+
+static void tcg_target_init(TCGContext *s)
+{
+    /* The current code uses uint8_t for tcg operations. */
+    tcg_debug_assert(tcg_op_defs_max <= UINT8_MAX);
+
+    /* Registers available for 32 bit operations. */
+    tcg_target_available_regs[TCG_TYPE_I32] = BIT(TCG_TARGET_NB_REGS) - 1;
+    /* Registers available for 64 bit operations. */
+    tcg_target_available_regs[TCG_TYPE_I64] = BIT(TCG_TARGET_NB_REGS) - 1;
+    /*
+     * The TCI "registers" are in the local stack frame and
+     * cannot be clobbered by the called helper functions. Additionally, Wasm
+     * modules for a TB and QEMU itself (i.e. helpers) are separated so also
+     * those variables aren't clobbered by the called helper functions.
+     * However, the TB assumes a 128-bit return value and assigns to
+     * the return value registers.
+     */
+    tcg_target_call_clobber_regs =
+        MAKE_64BIT_MASK(TCG_REG_R0, 128 / TCG_TARGET_REG_BITS);
+
+    s->reserved_regs = 0;
+    tcg_regset_set_reg(s->reserved_regs, TCG_REG_TMP);
+    tcg_regset_set_reg(s->reserved_regs, TCG_REG_CALL_STACK);
+
+    /* The call arguments come first, followed by the temp storage. */
+    tcg_set_frame(s, TCG_REG_CALL_STACK, TCG_STATIC_CALL_ARGS_SIZE,
+                  TCG_STATIC_FRAME_SIZE);
+}
-- 
2.43.0


