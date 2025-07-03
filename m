Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A97C4C83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 11:06:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHeZ-0005xx-9x; Thu, 03 Jul 2025 06:58:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHcg-0004FT-QT
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:57:02 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHca-0001O3-TU
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:56:56 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4539cd7990cso5150645e9.0
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 03:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751540211; x=1752145011; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Etx308N3I1KijyhBGAM+HBbz94lNBN0h4vUS6IObI1U=;
 b=DHVOL1vKkJMH+nFn2pInL+OSIqgodm96JxLxd5QRCOFj86rHaDwLWBhZoq+OnKEh/6
 CPK/QIiUimZOfUXiyeATn527gWnv8K83hGAgXxUXpeL3GWfMlmBk9Xo7fgHaaD6nPN81
 zDpFMSrkOAiaskQFdsjkXe7mm/rlkr56FzrM1VfgCJ2MqTNHVjGhQCMZhP9UG2XmqT92
 9qEA5GZRTXfoikL3DaW5TLpBL0nXy+6Y78ptuLZY1e1dDSKwhtuI48x/CK70CKY85ha2
 FRn676kHNlyogU5f7p665E9XGi2yVIh6h4tNBIp+o4Hvetebx3ZUqfZBoJwJFG+Firji
 vQ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751540211; x=1752145011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Etx308N3I1KijyhBGAM+HBbz94lNBN0h4vUS6IObI1U=;
 b=CGhXvoemyJGQHeBEdjDeSO538h/6nnuf2m4kzU++WahX0Z2nbr9Auz8BmNKsbtEg26
 FwEAtLo5lG0rymw5k+uAllNtPmPowp/PNlpmMBsIPuF98c+DaeYk+87+FkNhM1jeXb0R
 VZQkr186LO+8o2khmKMBS12GdZAxLwN60XiLq7EEGsmRGUa5YGNGBaZVJSS7CM30XVfc
 qeXmGQpYb628drw9l2UZ91tgFT9UbEALCFgTMYL7PM7x5RFQGAk55vbTbgLMJosbTX/p
 CPxminj6jSogDH6bkVil2ZigcOreNmwMNEsQZID3vyOZGewh53S0hlZ2nvIl5MjouXy9
 HIzA==
X-Gm-Message-State: AOJu0Yy3feFeLQZlM48+iaxfYYytho/ruG9vjb69OjGeihmJtZiwLxVa
 kD3GqzkiG4TjfU0eLnQQ38OhlaD5FRieef+ItPy9kZQ12MsqCm4Goq4Ic+1WY2QP/Oz3fEUDwM+
 I0q4I7NA=
X-Gm-Gg: ASbGncuQT8GKcQNeDaPBj7l6lt7bQ+RKxEc+0EXIhwyUM10oC/lSarISCLgEKQYPY2I
 6Vnbaz0lZctLRj+HaRxH0rM2meycoqwe2m6VI806Lepb2DKPn7gDUzYb45X0m5XLt+ls06Lj1gC
 755eIbDaeUFM/pNHikbWYprrPNyj6jtXuIN7vU52wg7eBdjhQpPnlXuMeH+TTqmqNcoiBNiK21U
 6RdoQi5wVl1xL15CHSioMazVQtOQlnaejRF1ndJYi/e2qcFNCV+kwz49t1wKE4ZbPstthc0CgVf
 Co94rQw2xohXYKEY8OncsbNlQreMVBD2e1F7W1edODHi6x4ilC15mp5VQ4wTzZsXnWqCY1X87Ip
 W8APErDLlHyc=
X-Google-Smtp-Source: AGHT+IFDMhcqD9OD8PTNB4St7Q2h+FxmR1znYA477JI4wwctyCKqRNqqzjvxSeSTmu7diYiHb036qg==
X-Received: by 2002:a05:600c:8b23:b0:453:69dc:2621 with SMTP id
 5b1f17b1804b1-454ab34b49bmr23227735e9.12.1751540210986; 
 Thu, 03 Jul 2025 03:56:50 -0700 (PDT)
Received: from localhost.localdomain ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a9966919sm24286555e9.7.2025.07.03.03.56.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 03:56:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 13/69] accel/tcg: Prefer local AccelState over global
 current_accel()
Date: Thu,  3 Jul 2025 12:54:39 +0200
Message-ID: <20250703105540.67664-14-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703105540.67664-1-philmd@linaro.org>
References: <20250703105540.67664-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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
 accel/tcg/tcg-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index d68fbb23773..c674d5bcf78 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -82,7 +82,7 @@ bool one_insn_per_tb;
 
 static int tcg_init_machine(AccelState *as, MachineState *ms)
 {
-    TCGState *s = TCG_STATE(current_accel());
+    TCGState *s = TCG_STATE(as);
     unsigned max_threads = 1;
 
 #ifndef CONFIG_USER_ONLY
-- 
2.49.0


