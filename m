Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79CD0C3DA41
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 15:31:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPkuB-0005pp-Uf; Fri, 05 Jul 2024 11:31:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPku9-0005oZ-2Q
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 11:31:21 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPku0-0000Ra-NP
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 11:31:20 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a7527afa23cso214712066b.2
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 08:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720193467; x=1720798267; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FV/c21quCr2VaXyJq0rrCWTuAfHB+Xc6e4tf9YOx3HA=;
 b=xbiw100lxVheZOvQJxpgsyiVU047ySljYn6rsgc7Gm3wlyQVYbtyGf9QBUnxiu9xSa
 PluvtmYTwGCCRJOS7e9OkPFYbVHfahQl642rB/H96kDcm9hfUPOrnVB1PyexLSokxqeX
 cymJmGZLXYYR44/0YhZUUHuEXq/6iHU7xfvZYotNO3FdSCcj1U9gIZH7RYn5wg6wx0Y7
 Hd8hHKLVjs16LOUmfP9WkH2TgSZlUjB+WJOOkHTq5i3bP6uYflhXeNUfgfi/A265GEkB
 NzQao6rgUz3zOKz1b+etSdbwmDEV1epdyQsgMOKOqrCAA9QM/cwppT7IGTbeUkcIEklr
 B1ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720193467; x=1720798267;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FV/c21quCr2VaXyJq0rrCWTuAfHB+Xc6e4tf9YOx3HA=;
 b=OE03YyFGOKE1nUoks7/B2XOtVZsvYtS+nXPwAsJcVp7aVMNuEmUKd1NNJNA+bnECdj
 MucJD0nleA4riOnr7clRjQdCFiriC0rooSXSjDZ38iAiAAn3iLFXil5ssFbpJFQlITCN
 0vDrjf2j9A/b3hzV2EsLYb2xswqkC6aYvF4PG18lCooy4tSbnxYG9IPN8fPIo/X0javq
 2a68FkJPe4Wq9kgApe1GO2JhxuqlL4L35C4c7N9yIA0QGcZV904r0hofrUqnlfgXLhdS
 ABw41MF62xPL0j348lTO/odFXCSxuix6Rvm9E1jKURsgl9tCXZaLXFasIndT5GYZmq/E
 F5cQ==
X-Gm-Message-State: AOJu0YyEmK+N5mKYigIrFVjrSzjnpxCb5WzHPnS4P/XOqSbpWQRRiwie
 YjAhdpfq+L5fH52kXtXIxJ9k8ee77Z/pq7zbGzkV19TwJdCxCROkcN5+6X+KAvIDAtJ58YUpfcX
 H
X-Google-Smtp-Source: AGHT+IGbI/prXsD4sS4V/tCTlMQAVAoGENYkY1umeErSiqMOHC6m50YqmLRZ5AngPVzFaj9PBxrZ2w==
X-Received: by 2002:a17:906:4818:b0:a6f:4e1f:e613 with SMTP id
 a640c23a62f3a-a77ba48e4c4mr310842966b.37.1720193466737; 
 Fri, 05 Jul 2024 08:31:06 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a77d56ccb8csm46718666b.200.2024.07.05.08.30.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 08:31:04 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8B4C56211A;
 Fri,  5 Jul 2024 16:30:54 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [PULL 16/40] tests/tcg/arm: Manually register allocate half-precision
 numbers
Date: Fri,  5 Jul 2024 16:30:28 +0100
Message-Id: <20240705153052.1219696-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705153052.1219696-1-alex.bennee@linaro.org>
References: <20240705153052.1219696-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

Clang does not allow specifying an integer as the value of a single
precision register.  Explicitly move value from a general register.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
[rth: Use one single inline asm block.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20240630190050.160642-12-richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240705084047.857176-17-alex.bennee@linaro.org>

diff --git a/tests/tcg/arm/fcvt.c b/tests/tcg/arm/fcvt.c
index 157790e679..d8c61cd29f 100644
--- a/tests/tcg/arm/fcvt.c
+++ b/tests/tcg/arm/fcvt.c
@@ -355,7 +355,12 @@ static void convert_half_to_single(void)
 
         print_half_number(i, input);
 #if defined(__arm__)
-        asm("vcvtb.f32.f16 %0, %1" : "=w" (output) : "x" ((uint32_t)input));
+        /*
+         * Clang refuses to allocate an integer to a fp register.
+         * Perform the move from a general register by hand.
+         */
+        asm("vmov %0, %1\n\t"
+            "vcvtb.f32.f16 %0, %0" : "=w" (output) : "r" (input));
 #else
         asm("fcvt %s0, %h1" : "=w" (output) : "w" (input));
 #endif
-- 
2.39.2


