Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FEE5D2444F
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 21:52:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sz14M-0000jp-30; Thu, 10 Oct 2024 17:51:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sz14J-0000Yy-Uy
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 17:51:36 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sz14H-0004in-IS
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 17:51:35 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-71dfe07489dso1194015b3a.3
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2024 14:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728597092; x=1729201892; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V6jI3Hb8cDTjWIG5wWIDeEXHuhyNcqfxsew5z5VFIho=;
 b=acoxWrdrpuF1MrbOujxrIZTG4zOLarCXb5AjkDZjKuWE7hIfNI2xVsF+oE3eC0UDE8
 IbuE2A/2zZwcPaa9funKy9JYoAKSs4ui8N9nfmIUWvGRSNwj35qOEWFVmJ5XOkyAodI3
 0L1ripEyfwk/7d0vu6E5azkLzqJuAiGUZfvutT7bTHFzzCr8EqnM4ErE2a8KVOWZQgju
 zGKzIHZ0UPRUMkbT0qaBznFL0ambFIXVbtU90JVznx0XCkCAhHuj/ol15/HCpFiMY6KJ
 pZ3NBpf4rkVgAlFDNr5p/TqgWDtIFLTpuEtil8OcTJKecd+wDkjnf5ytH+r7/A8kLaPw
 v0Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728597092; x=1729201892;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V6jI3Hb8cDTjWIG5wWIDeEXHuhyNcqfxsew5z5VFIho=;
 b=xLvG+wXyVGtjou60KLrQQcJS4gjhDDT9XadugaDO5iZOpnifKE8buIra2mCOtZp4e9
 nrKPHKdNuqXlvFWDtgBTCv2AV8kOPfoGz+3fR7Um05IU6mT/NspPfeyKEfWD5SiNqm7k
 wqwz57NYg/QJjVi6Ot/O1xhrvM1TzenFkTHGkbMTXT9fEVAhDHbm/0yTtf0//jCEmUdJ
 E2SiXcXpIo+hCFzmPtnb1tzQlklThbU3y/2D5oivy7UbhgEMh0eXivERR42rV2d7Wonr
 y6Z6Oo76/xul5xPUt97OKNPdLNoPN45wk13j+6o6yAzW/djv0phdu2X1+cYwFFLo2PmF
 obtQ==
X-Gm-Message-State: AOJu0YxGxXmQdgloRxEOKE43E9r00syNAwnUH89FjptOEvLqhONTOs49
 H0DKusLKCkg0bwzLXDA6iebmzl7ee9HPnrXWXyQkIVmKF/0idL73bALef5mYaY09nmgqVRVaVNo
 i
X-Google-Smtp-Source: AGHT+IGEm/DlC+rHZHqhnqxsx50mIMmZSe94PHoiDsAt2nhsCU2Q8VIF/VW4VaGuVDS6yO/NG5AGmg==
X-Received: by 2002:aa7:88c6:0:b0:71e:6ed:9108 with SMTP id
 d2e1a72fcca58-71e37e2f59cmr842753b3a.2.1728597091698; 
 Thu, 10 Oct 2024 14:51:31 -0700 (PDT)
Received: from localhost.localdomain ([45.176.89.169])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ea4495a450sm1240935a12.70.2024.10.10.14.51.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 10 Oct 2024 14:51:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v2 09/16] target/mips: Introduce mo_endian() helper
Date: Thu, 10 Oct 2024 18:50:07 -0300
Message-ID: <20241010215015.44326-10-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241010215015.44326-1-philmd@linaro.org>
References: <20241010215015.44326-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-pf1-x435.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Introduce mo_endian() which returns the endian MemOp
corresponding to the vCPU DisasContext.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Tested-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 target/mips/tcg/translate.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/mips/tcg/translate.h b/target/mips/tcg/translate.h
index c55f90e741b..49ff6b8cd80 100644
--- a/target/mips/tcg/translate.h
+++ b/target/mips/tcg/translate.h
@@ -240,6 +240,11 @@ static inline bool disas_is_bigendian(DisasContext *ctx)
     return extract32(ctx->CP0_Config0, CP0C0_BE, 1);
 }
 
+static inline MemOp mo_endian(DisasContext *dc)
+{
+    return disas_is_bigendian(dc) ? MO_BE : MO_LE;
+}
+
 static inline MemOp mo_endian_rev(DisasContext *dc, bool reversed)
 {
     return disas_is_bigendian(dc) ^ reversed ? MO_BE : MO_LE;
-- 
2.45.2


