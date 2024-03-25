Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB909CD11DF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 12:36:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rojYT-0002Hr-TE; Mon, 25 Mar 2024 08:35:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rojYR-0002Gj-FE
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 08:35:55 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rojYP-0005d9-Tb
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 08:35:55 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-414881d8956so6228445e9.3
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 05:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711370152; x=1711974952; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eRU+7TF6IV9xXJWV5nC1V9vP/PTuItRJkSSU0GlEqY4=;
 b=KA3xNX8BX+47r6wLM9A/TRQGbSVGqsJxc7a3hE8P9MAnp+yqc20Q4RbsjUkm0Svv8u
 V1va3bo3TG8edlH2M3bUoflGAg8YdajqtZdHLILFxbg/bVSuVPiA4DJRjjniheRupDqO
 W7FkosTIX19Cvs9cHlGwUVccvyO1chC45L/zMHbEDidDVVn0jZoLCD2Fl9o6NJArmnw8
 Dz59jdD7GAX6N2H3vL63ep4l07yaR9dQyOEmsBR4EJRy+UpOTL4M9Gf0b7vSPU0cFcko
 aazzWUr3P6WbgWVx1Dlh6W6mynQkgsBybgTu3xQ7CGWka50qFk58Gh/8zUpIQkOYZL7L
 RKTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711370152; x=1711974952;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eRU+7TF6IV9xXJWV5nC1V9vP/PTuItRJkSSU0GlEqY4=;
 b=D4NPjt9tbn2CmjzBxdtL51fQCtilgnmuyiNOMd2d1LejZbLATrurQ60W9+I98IG91T
 4zvVxxithzJq5FgmmZ41CwP0+DkIJyywWEeCniA8/PQUF1eHFnUN2LwQumrQXPJmeJ3C
 8Qnaynojr88n1GL7hMDzBVw/nP7JuT+wpHi9xqiqsEdFKuPOz9sAUwFsaKn70SQJhcFZ
 7pOoaPLzqIF9wD711KdKwYy5SIpe15dUxc8D82ZFDJXX+Fx2WbtNZUVYM6MoLpFQAR2g
 jVUvNbESPN5Y1uK4evi2+YukRqMlfq+lJ8gqARo3kaThV0K8CEF0WKjR439mkhf97bmD
 7pXg==
X-Gm-Message-State: AOJu0YzYs207OqBD9eigOluz4ZZyiEV7ibdej+dTq+IWQe/ox1Q5wVyo
 k6DLh/IMR2NPHMqK3h7qRlsOPgIPnMlGGOA+WZpaI1uKCyjWSEyTRPEEmw23+dXOZyk+Z5lWdSZ
 y
X-Google-Smtp-Source: AGHT+IFoMfoHxiqlGYKuoTxF82tL++pY7rtbug1wkAAQqvD7baWgjqqKtJdy1EjtEi4ND29X+2BHAw==
X-Received: by 2002:a05:600c:55c6:b0:413:fea7:bd19 with SMTP id
 jq6-20020a05600c55c600b00413fea7bd19mr4688293wmb.15.1711370152524; 
 Mon, 25 Mar 2024 05:35:52 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 o19-20020a05600c339300b00414041032casm2303877wmp.1.2024.03.25.05.35.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Mar 2024 05:35:52 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 1/7] tests/qtest/npcm7xx_emc_test: Don't leak cmd_line
Date: Mon, 25 Mar 2024 12:35:44 +0000
Message-Id: <20240325123550.1991693-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240325123550.1991693-1-peter.maydell@linaro.org>
References: <20240325123550.1991693-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

In test_rx() and test_tx() we allocate a GString *cmd_line
but never free it. This is pretty harmless in a test case, but
Coverity spotted it.

Resolves: Coverity CID 1507122
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-id: 20240312183810.557768-2-peter.maydell@linaro.org
---
 tests/qtest/npcm7xx_emc-test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/npcm7xx_emc-test.c b/tests/qtest/npcm7xx_emc-test.c
index 63f6cadb5cc..2e1a1a6d702 100644
--- a/tests/qtest/npcm7xx_emc-test.c
+++ b/tests/qtest/npcm7xx_emc-test.c
@@ -789,7 +789,7 @@ static void emc_test_ptle(QTestState *qts, const EMCModule *mod, int fd)
 static void test_tx(gconstpointer test_data)
 {
     const TestData *td = test_data;
-    GString *cmd_line = g_string_new("-machine quanta-gsj");
+    g_autoptr(GString) cmd_line = g_string_new("-machine quanta-gsj");
     int *test_sockets = packet_test_init(emc_module_index(td->module),
                                          cmd_line);
     QTestState *qts = qtest_init(cmd_line->str);
@@ -814,7 +814,7 @@ static void test_tx(gconstpointer test_data)
 static void test_rx(gconstpointer test_data)
 {
     const TestData *td = test_data;
-    GString *cmd_line = g_string_new("-machine quanta-gsj");
+    g_autoptr(GString) cmd_line = g_string_new("-machine quanta-gsj");
     int *test_sockets = packet_test_init(emc_module_index(td->module),
                                          cmd_line);
     QTestState *qts = qtest_init(cmd_line->str);
-- 
2.34.1


