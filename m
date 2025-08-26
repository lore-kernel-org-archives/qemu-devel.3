Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30491CA0FE7
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 16:21:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqwK2-0000e0-RV; Tue, 26 Aug 2025 12:14:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uqwJb-0007FK-Cf; Tue, 26 Aug 2025 12:14:36 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uqwJS-0008Fw-Cb; Tue, 26 Aug 2025 12:14:30 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-76e6cbb991aso5098932b3a.1; 
 Tue, 26 Aug 2025 09:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756224856; x=1756829656; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wrau3B2sXx6DsPs6H2dSpeAMNFagRpH9CKQrGL827lA=;
 b=CPWbq6dV4JcigODrMWvBVD/77DL3t7noQSta4cYlmmzLN5sTdeakEGJZaRN5+CEzlY
 C1pGtk67PtCXMLzyUzAAH/dxLLnKBAIN8QlvaCW82skWXPgdiPUE30BDLYifyRQ4h2t+
 TAH8J5TY+SG7h0+S1BpzH2ZqmRkddwfYz909Qz5Ow31j4CQrw0WQyHCc3CWHmvQuCInu
 XyCxfwMZ/1zLTL9Ph3RYmOgFy5QS4ik68EJ/beSLajlM3x5oXpNPs9Nrg9+4Q/jRFLLf
 NRm4aGF3HxEQzgHq8tb75xp76zWriwbPFZxHvomXl4euzYIPuWP+ihghtRKcsHebLEO/
 +FwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756224856; x=1756829656;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wrau3B2sXx6DsPs6H2dSpeAMNFagRpH9CKQrGL827lA=;
 b=ngfwoWhm9CXh6GvXkuzH/iZh6zCs0zNNpsOPP6TDRsYaQsVTPwNmMNrOiqNg/o2OyW
 o1+KknqNyZhcUAskyU20rfj5nyFJ5zIEl8MJm3ru6fDjGbYfDb510gsFVUX+0ZJBc7Jy
 jp8oMCQkBku5qQdYvSxqJjm4LEqbV4B8Zl5WJQOakb6VM7WRnJqnShHhlJX5amVK+nbN
 IlbG0djHLXWJEilfGj5l6kEGbu/2AefigCyW333GXRexaZGUivMpRK/2JOiQiHAqpmME
 5cI5nWISGq/q3w9R/i+czpJ4Ds+YzKwiD2Lm3LZPTZnKDseB1SE5q570o+6b5PrFTnxZ
 TL6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWanmrtsW0tdHAAgV1/3ix+aX40BJ7YctzLldThkZEesYENqiIk2tQaxXNa4B5TDlOwhvC93yJmxCPUqg==@nongnu.org,
 AJvYcCXYXqezzp4T9IxVj6ITeB27nRpGdX5T2hU6fdEaPynhDBUn94Dg2CqISczeWa6BMKA+7DTo7tNfvg==@nongnu.org
X-Gm-Message-State: AOJu0Yybf353DSTEKmBOgW2QSIk9AlHWAnWwNLw8Bs7I8qN14B8WL5eI
 0Kxb6T16Jut9YbvbQ8oIlRYbdIEPgtn6geEV4wLy4z4s1Hvc7HSnhzmt0zCMBQ==
X-Gm-Gg: ASbGncvOf0/i3aNdBeBuOlnd0v15EDDuGiqYhUoZ2M8wqnzbY3pcLUGaU2FtG9W5v0q
 dn4qAFmIXdxpumMEPoDEghG1UPCyRCBSVfxEK3zAa0YDGNMgFvNQrNNJj/ItsGcI/8VLNfV/4FF
 jKqpzZ0IkL3PTM2MJgs2AX6bXKB4QmCrDcI4UsOVTjhEKfcxnugXzmRuuehIKTk1GbwcWKzK4Mo
 RtX02n9kzgk7xlsEskKJYBAbcdJRbWq5d0OjbMbAKXTvyeK/uFygis4xmGldPBWk/I/IzelTH7i
 dfyEOlRArLVHLmWdf3+pEM8w3zNhHqLDw2kjIW9xOgA45Uu6EdIFYdMCuDoWZs7s3XDw3I6v9Vr
 a3hLwlf6nshywY2cpRfULCA==
X-Google-Smtp-Source: AGHT+IFfLnhxV+0KAbflXQ/QJphrDCH2PqDiIamfWYse84PX3na3b9ijzRmIgfzwhY1Buf1pYw+g0A==
X-Received: by 2002:a17:902:d48c:b0:246:96bf:c919 with SMTP id
 d9443c01a7336-24696bfd54amr145211945ad.10.1756224855986; 
 Tue, 26 Aug 2025 09:14:15 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:561f:1400:11f5:714b])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-32750bc341asm1749747a91.19.2025.08.26.09.14.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 09:14:15 -0700 (PDT)
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
Subject: [PATCH v2 32/35] tcg/wasm: Add tcg_target_init function
Date: Wed, 27 Aug 2025 01:10:37 +0900
Message-ID: <efa69378f0d2d98d7df2da0c3303982e542d4b2f.1756216429.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1756216429.git.ktokunaga.mail@gmail.com>
References: <cover.1756216429.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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


