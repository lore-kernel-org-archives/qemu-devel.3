Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9488C27C4F
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2024 19:03:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNznP-0004r9-72; Sun, 30 Jun 2024 15:01:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNznL-0004nD-Az
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 15:01:04 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNznF-0007Uv-Uf
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 15:01:02 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2c1a4192d55so1212593a91.2
 for <qemu-devel@nongnu.org>; Sun, 30 Jun 2024 12:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719774055; x=1720378855; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DtGVT1ZHjBzi0X95kSBoZYyuOcUliRAOUA12D0f1mZ0=;
 b=LrS+sYIna8/tBJ6UM1bJ1g8Rl3Mwm9OMbkRBwhaNl0r+4ehZZEh3Wro1ilW9MUNdfu
 uPlryZa4btuNEsXHCCNBA362kdaW2umC/iZ78RUku2A45AEHOFtu2sXfObU7xJiGYqHq
 FnQhYuilY3rNPqTTB3Nkh/CNLTyR5Z0Cmmgu0yvUS4AEQoKsyvplhXC0wVpDKuNNuVHs
 CMEUGPgLQ2l4KRdBQaoP6R0jY+SoizEPo5YYqzZcC8l76t2h0p/rMfjdy89y57UZ385Z
 d04RscuwlA2EAOy4QAvI5kaCQ7TqTX4TyG0P+xYJke09YWFVevPJthlcdL5WCg9yk78a
 T0rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719774055; x=1720378855;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DtGVT1ZHjBzi0X95kSBoZYyuOcUliRAOUA12D0f1mZ0=;
 b=aQd4fSImOEjlJkS+kryPi87UuRAQQMcTnAHgXtA1qMO3NYtvKJpuY2kI6ScdIzYPfP
 G+qATQw2HeIRhJprZjN3LnptAVoGGcZMKfU8lmrisWze+hFnAv4c57i02JMm9qITA2mz
 Cn1Qjd56WT3bnvvRlw1lsp88bo3w9KDmfhhlFFYBfpyrETPoYMq+CWaXvXny8USFCenL
 fOcCef4014GQnUT+oJ5QmO4G+Z3weXfTR3macfBRMRP83xiZJOEBdsFQ+q8fsC8vC7RW
 f3/oAgfINBUHqCz7fkoBrxN78+fr/UNzhjYdpWu0OGMInwhEMuooUtVNHMb98OX78/2Q
 U5SQ==
X-Gm-Message-State: AOJu0Yy9ADXyhN4DuI+KQueJDmFvE5jieFKElxqQcxkJuOj5Mev16VOF
 zAIU26yRu/eUrCc0tiYtSdfIWtb3s2g5/eUNzjm9HMH4h5HdCHng6Fo9uiSmbF8KcBsUu8uFsFi
 s
X-Google-Smtp-Source: AGHT+IGnrCV/2ZsxzpC4JeLWaNNpT33FUx9fjN8NR14jcAoBg35zMzVT9+wf2MU/AHgAwxnrlfde2g==
X-Received: by 2002:a17:90a:9b09:b0:2c4:a7af:4d79 with SMTP id
 98e67ed59e1d1-2c93d6ea90bmr1515235a91.11.1719774052788; 
 Sun, 30 Jun 2024 12:00:52 -0700 (PDT)
Received: from stoup.. (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c91d3e7e4bsm5115641a91.52.2024.06.30.12.00.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Jun 2024 12:00:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: akihiko.odaki@daynix.com,
	alex.bennee@linaro.org,
	qemu-arm@nongnu.org
Subject: [PATCH v4 01/14] tests/tcg/minilib: Constify digits in print_num
Date: Sun, 30 Jun 2024 12:00:37 -0700
Message-Id: <20240630190050.160642-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240630190050.160642-1-richard.henderson@linaro.org>
References: <20240630190050.160642-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

This avoids a memcpy to the stack when compiled with clang.
Since we don't enable optimization, nor provide memcpy,
this results in an undefined symbol error at link time.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/minilib/printf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/tcg/minilib/printf.c b/tests/tcg/minilib/printf.c
index 10472b4f58..fb0189c2bb 100644
--- a/tests/tcg/minilib/printf.c
+++ b/tests/tcg/minilib/printf.c
@@ -27,7 +27,7 @@ static void print_str(char *s)
 
 static void print_num(unsigned long long value, int base)
 {
-    char digits[] = "0123456789abcdef";
+    static const char digits[] = "0123456789abcdef";
     char buf[32];
     int i = sizeof(buf) - 2, j;
 
-- 
2.34.1


