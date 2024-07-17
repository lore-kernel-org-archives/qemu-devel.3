Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64A64C3DA4B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 06:03:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTxk1-00051Y-2X; Wed, 17 Jul 2024 02:02:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sTxjy-0004v4-2O
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 02:02:14 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sTxjs-0001F8-K3
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 02:02:12 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-70b1207bc22so5362680b3a.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 23:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721196122; x=1721800922; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZMf5aA84rLqw++9CAhqa8G+mFDeuLcUiCA683ccZn6Q=;
 b=UPaobX3T9cqZsaLk/G/eK00FiUS5aipmG6R5aXP8yydURnLfvIRUJhZEnHrdyCVYWg
 UJh43Tw8dopZwVY9n2b2yZHbGRc1A2QL2PQQ/arCEfQ8SRLrYEm1vvL8yHn0BCKXTAAy
 6vt4luwKvChQxYxqcLzuqPhWS/gxS22qvQHR7GoMMriS8cRCOZ1fwJx0iUYUzW4DAn75
 d0lRzdfX9cRANoYLM2M9CMMf2SoVLRJhbkaQQhZ9AkllEbrS1iGr5sf7D6YmTq8FjVY7
 vS06zml+uRenNDeu6pRatGMnqqxO6vfjhpxhEKOhMzZK2o8NwyEP9J8nGylW8hvD+Rxp
 +MrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721196122; x=1721800922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZMf5aA84rLqw++9CAhqa8G+mFDeuLcUiCA683ccZn6Q=;
 b=cTmrkVc8mDvI7iGYHwABUf9vrLkGno0gAFQJOp647yAzBaJTGRbAOPa1TL41FjWsbn
 UDqkCsGeaLQYP+DZCw2k/hI0eWjuTebf9pbaSPpEG2zxveM3mFMha4clwbqsnBR50KSl
 ajccwJtUafRb+AAL1gzQrcg97VV6qN1S1DncFKI5CmP6lML8msBk3iG4W/IowNUaTIfR
 KaXAp5wiCKbj6Y1QFb9HsLB//cvuWAV2fWPfR5WpQwWmz/P+kMYzblKEkElGkF+HK7OE
 X5495d1WXI3ormDz8Q9Y0mpBLLLxvImGbPL1O2TefYs/PAe7rIhuqujeka12QZUMjeow
 91dA==
X-Gm-Message-State: AOJu0YydcoN6LAreliBsAMbnlboF5ANcZh7+Ueaa1f0O9Dd5FXG9Duw8
 1hJUE1oelCWi+EKOMWEdVZwGCY3tiWko2X7uUZ38ZoZU3kJYfwCYNM7wpo9x0d0xnmsobF8Se+l
 oNxg=
X-Google-Smtp-Source: AGHT+IFMwG44JiaRsp7aB3LErrrLsfSpwGrps9gnE1ekF3g46cheDEXccnT+qT28qEzuHlw5KBrQ9A==
X-Received: by 2002:a05:6a20:7348:b0:1c0:f759:9544 with SMTP id
 adf61e73a8af0-1c3fdcd50demr1239258637.11.1721196122385; 
 Tue, 16 Jul 2024 23:02:02 -0700 (PDT)
Received: from stoup.. ([203.56.128.103]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fc0bc27383sm68131575ad.140.2024.07.16.23.01.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 23:02:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Daniyal Khan <danikhan632@gmail.com>,
 qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 1/3] target/arm: Use float_status copy in sme_fmopa_s
Date: Wed, 17 Jul 2024 16:01:47 +1000
Message-ID: <20240717060149.204788-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240717060149.204788-1-richard.henderson@linaro.org>
References: <20240717060149.204788-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

From: Daniyal Khan <danikhan632@gmail.com>

We made a copy above because the fp exception flags
are not propagated back to the FPST register, but
then failed to use the copy.

Cc: qemu-stable@nongnu.org
Fixes: 558e956c719 ("target/arm: Implement FMOPA, FMOPS (non-widening)")
Signed-off-by: Daniyal Khan <danikhan632@gmail.com>
[rth: Split from a larger patch]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/tcg/sme_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index e2e0575039..5a6dd76489 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -916,7 +916,7 @@ void HELPER(sme_fmopa_s)(void *vza, void *vzn, void *vzm, void *vpn,
                         if (pb & 1) {
                             uint32_t *a = vza_row + H1_4(col);
                             uint32_t *m = vzm + H1_4(col);
-                            *a = float32_muladd(n, *m, *a, 0, vst);
+                            *a = float32_muladd(n, *m, *a, 0, &fpst);
                         }
                         col += 4;
                         pb >>= 4;
-- 
2.43.0


