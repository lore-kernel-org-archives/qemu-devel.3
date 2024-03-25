Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4361C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 12:36:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rojYY-0002K7-B1; Mon, 25 Mar 2024 08:36:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rojYU-0002I0-FN
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 08:35:58 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rojYS-0005dr-Ky
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 08:35:57 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-341cf77b86dso587407f8f.2
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 05:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711370155; x=1711974955; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/WSvWBDSQi9Zqsw2htT0Fim8jLY3dFWtGJXr5FhGHxs=;
 b=BayrhtsBTCfrZbhVKJa0LFq58Iqk9wuEYLr/pQ9qBg4xQXhLN02zQFToiNK/7cvkDy
 W75XTh6XxBkBZRyWBBDVpMgEbt00NTUxZ3NP8vx6Abfs1Od7iBp8aqyhijDjczgIjKH8
 5tc7iGfwv+nb6OrJQOmCaUihiUxT08icF/1LMLtBMxwvu/E6HpfXPV8Vvf1KtKNfUu/a
 VBUO17rCZggcaMxy6gkgoEXv6Uob9PszU8Q2pP85F1fb/TDQX12gXAUkcgc8h5KT+5e0
 sPjdXPQxqI/YEJzsYDqeP4GcTkJiiGEyi3FG93sRZ89JBUVBC3am+7jXo2LwfuQPl3Ce
 PsaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711370155; x=1711974955;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/WSvWBDSQi9Zqsw2htT0Fim8jLY3dFWtGJXr5FhGHxs=;
 b=hk5FA0mUFFi7OGm3vu9aTAQvcXY4k73CmzurE+sGKzX/q/MM9X6dUCTdiUk83qBqwV
 ILRCSAAYXAHdhltxsikPj9Hf4uZ/ZozVNhsaCmtSVG5YsX4wV44LWGyoTxDLX5w+9fSY
 nAG37DEM5oKKhXthO44mC65SP/Hr3t61yW3OqglWtw3wP+pX7mxTe6m5Y21KFZANewnU
 /qz4PzJbFLMHUYUh7d1Ipnf6WbOZGc9ACQzlM1S32tQ6wG/1tp20W4mfb406ceYZEECl
 Oxc493s/Nd41NcvfzJxNgZaZOunwwNuNAIM4ktQGxv+TMZp2gY/noHcH+dYkdyHAiQSZ
 Umwg==
X-Gm-Message-State: AOJu0YzpnZnOxF4Pmn8FSFiTLNILTtz+CirmvZ642SrU4uVoBCHpMZMf
 knnyoq2sK7kD1/R6n9DtYBfucNbquM/Ew7toAUPPjaBEbyMEzu5m08sWtDYWiyULeCc3C+DKGm1
 s
X-Google-Smtp-Source: AGHT+IFQCwP4G4LBhoPnrbmqDFOYafMaA8dAEqdDlcAQJeSwLkndXPWybUnIJPVdU5zXUFUjHvPhQQ==
X-Received: by 2002:a05:6000:dc8:b0:33e:8b95:b350 with SMTP id
 dw8-20020a0560000dc800b0033e8b95b350mr6243896wrb.7.1711370155091; 
 Mon, 25 Mar 2024 05:35:55 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 o19-20020a05600c339300b00414041032casm2303877wmp.1.2024.03.25.05.35.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Mar 2024 05:35:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 7/7] tests/qtest/libqtest.c: Check for g_setenv() failure
Date: Mon, 25 Mar 2024 12:35:50 +0000
Message-Id: <20240325123550.1991693-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240325123550.1991693-1-peter.maydell@linaro.org>
References: <20240325123550.1991693-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

Coverity points out that g_setenv() can fail and we don't
check for this in qtest_inproc_init(). In practice this will
only fail if a memory allocation failed in setenv() or if
the caller passed an invalid architecture name (e.g. one
with an '=' in it), so rather than requiring the callsite
to check for failure, make g_setenv() failure fatal here,
similarly to what we did in commit aca68d95c515.

Resolves: Coverity CID 1497485
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240312183810.557768-8-peter.maydell@linaro.org
---
 tests/qtest/libqtest.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index f33a2108610..d8f80d335e7 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -1814,7 +1814,11 @@ QTestState *qtest_inproc_init(QTestState **s, bool log, const char* arch,
      * way, qtest_get_arch works for inproc qtest.
      */
     gchar *bin_path = g_strconcat("/qemu-system-", arch, NULL);
-    g_setenv("QTEST_QEMU_BINARY", bin_path, 0);
+    if (!g_setenv("QTEST_QEMU_BINARY", bin_path, 0)) {
+        fprintf(stderr,
+                "Could not set environment variable QTEST_QEMU_BINARY\n");
+        exit(1);
+    }
     g_free(bin_path);
 
     return qts;
-- 
2.34.1


