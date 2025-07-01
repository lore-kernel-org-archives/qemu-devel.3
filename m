Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4D8AC83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 14:57:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWcCL-0000v9-NR; Tue, 01 Jul 2025 10:43:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcCI-0000ZN-Pl
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:42:58 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcC6-00071Z-Ub
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:42:53 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4538bc1cffdso32594625e9.0
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 07:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751380962; x=1751985762; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NlBOE8V4jVPken7WCnMtNpY/1Zbf/V//8TkK0yzKABw=;
 b=qdC6myM4BtOz7rNBS4HkDPNXNf/DSIU/n3ik3HyU8VaY7zh3xNQf/okSpxfscnNWg0
 Z5fgupG5fz1xKFppjv5Q+ncNSmMsFjjYzd34BqMBEP29Vw8NLd74MnYVJxk/g6ODsOs7
 EcpBPNZV3tc+AtFEyWjCIjrNjFyVifrCcozdtC95yoHsN590hQuV2xQw4f+TlDCG9yFC
 gxO0nfGEAif/6bDU3ln4B5OYJIMoBTUWNTXhL1k9m401lHNNYTOqLj7UcwA0QuGQ/TP6
 qPC0REXZ8/1Haba0nks40kIX2rFj42jyDZWrXTglyUz7aqg9YBo22HokwvyZhric0+wI
 P3YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751380962; x=1751985762;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NlBOE8V4jVPken7WCnMtNpY/1Zbf/V//8TkK0yzKABw=;
 b=w2rA2Eo+JFXywgO3DbRNVp7psKqT98H/jW1pE2JbQ4lOeyFiYG6tB0xWxSSopVatMT
 Wn2RItQSvcnGnJHgtkxZGU42l+0DmA8wG/OUYDvuUTT1G9UxAUY/zEuQkquKrpPNrXLj
 cV7ACnPnbqQtQig/hPfWdcBiIHPTnDuDlmk1koeli5oFZq+BLn9+jQK9MWWhlJJmJ0wR
 1zlAmVQAYYFUlevQ74XaK4CWkQIw0evwq/fSE1fBUcaYKMdhO8yIxO1pDlYO+DBM4ovJ
 kSeYGS30tU86LaACUiMB2pfe1ehBegVBQiYZ7Hh5WdB1buO/34HiHEj6kQOZElRekAwF
 JAuw==
X-Gm-Message-State: AOJu0YxQ2QXijI7cOlsi2uHXFMXJX/tnB5gec76oAYPu/RFsz8QrHU+9
 euqPFJ+oKT08dBoc2PnKrZ9IaCWYR4Bg/Ywp9rGm8kRtdexXspMqdoASM4GT5KmLW9BYKNw3NIH
 AZT5x
X-Gm-Gg: ASbGncuMJF71vMTilKqNl9jJKa1BobDdb0CW5oxVfDQU/2c9AiSAwfrZ62aMg93siFV
 ljMqjdCajZIUw46MPvT4/iEZn8gdtqvgmfqf7HhqNuQgsnSJzBEflTVfGs7sE1+ZCdzeHV92s8o
 1E80KXglC+5BdtfRtr/E8puvT1Ki/Szb65y7qE1y8AXnuFs4tyowp+tD9co+7rP+OEiwaI49Gd1
 4fvIBIMH7jOThyCWxeXgIikD11OBolzvrwk12S89nQJxoxaka1Nryz0RNHyYd98Can8jCsD1YAV
 BC+NoxUWAd6pXLkraGxenrwK7YulKE5/7n+MPETsMLqtuXNwlbJZ3k/3vMZvCoMFMHUSh3EvAq0
 Ebxs3Jv7KP4/mhMlBFEsCHsFGpiuzH9+2mupy
X-Google-Smtp-Source: AGHT+IEwTRDJbNzYZH79wUbixBg5SHr84V0InY6n3JHu9/TmxHzTiuujDwOiBoHzOImgvvfDI15Mfg==
X-Received: by 2002:a05:600c:3b01:b0:453:745:8534 with SMTP id
 5b1f17b1804b1-4539605125bmr142294465e9.12.1751380961666; 
 Tue, 01 Jul 2025 07:42:41 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c7e7518sm13271565f8f.2.2025.07.01.07.42.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Jul 2025 07:42:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 26/68] accel/tcg: Implement get_[vcpu]_stats()
Date: Tue,  1 Jul 2025 16:39:34 +0200
Message-ID: <20250701144017.43487-27-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250701144017.43487-1-philmd@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-all.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index ae83ca0bd10..d49d2b3b0fa 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -239,11 +239,17 @@ static int tcg_gdbstub_supported_sstep_flags(AccelState *as)
     }
 }
 
+static void tcg_get_stats(AccelState *as, GString *buf)
+{
+    tcg_dump_flush_info(buf);
+}
+
 static void tcg_accel_class_init(ObjectClass *oc, const void *data)
 {
     AccelClass *ac = ACCEL_CLASS(oc);
     ac->name = "tcg";
     ac->init_machine = tcg_init_machine;
+    ac->get_stats = tcg_get_stats;
     ac->allowed = &tcg_allowed;
     ac->supports_guest_debug = tcg_supports_guest_debug;
     ac->gdbstub_supported_sstep_flags = tcg_gdbstub_supported_sstep_flags;
-- 
2.49.0


