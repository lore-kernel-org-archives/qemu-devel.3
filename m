Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92468C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 18:39:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk71D-0003Wo-Jz; Tue, 12 Mar 2024 14:38:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rk710-0003N6-8A
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 14:38:19 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rk70x-0000cW-MO
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 14:38:18 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4133100bccdso9412895e9.0
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 11:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710268694; x=1710873494; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=F5TgssMb195QO0ZRrXOaRa+rjmUvH1NGzSH3Wll6Fnw=;
 b=hMfWKLE5AxQwmn41SKLaRp/xO5wwJwTHhSFHLkoSTBACEurGgfsK4OSWP2/WQDzj/o
 xFS8YMg/lqbQ0mYGy9pc3zSvStea9TDx6SwbAcT4ITTevnm0mo50YTNRnQVzzC7cjmGI
 j1eU5RU3MJZcU/GKls4+CsukvBeT23fuh+2SV7JSQ8pl13DhWOvZvVF0AgXnwZsdh2He
 W4xQa2vZsqbtkn18sOuIONjTUbYvLC4q4PdvXFIJWOWHzTwQlcK2ItNR+TlOQFJMukz6
 ERWBb+dAAMu5xeQCSkWJTvDfWHdwN903B2UHSppZv6a4ARLBEvWGQvvjX3c2GwU5i18R
 gF6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710268694; x=1710873494;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F5TgssMb195QO0ZRrXOaRa+rjmUvH1NGzSH3Wll6Fnw=;
 b=Kj0/XY/asZPKMozyFlJmseRST33MJv4+dN5VVGTo0tbnVu1d50yr2QU6XN9eqG7hyO
 cl4Zzc0VS7ixae2TJla8qEvGSlHKAh1i4CnSQVdM2MkpPaCAxo5FJ1VxuF0swKrq1m2j
 kP4har9DK9kzUFGVOrpxt9d49ghglLqlsyrIUAWDqi74xt5/KiY+F8mV3OVLgYZYK8ep
 N1kK+d5dK7TKOp78sS+eK5hZPkZEKrH87C5FmsZpXAVW2xQWKNBap8mTCjDVcKig/Olb
 7Rm+f8iJH0n8qrk2ePWEwHWBoCJx1HnCLg5ubGs8b5bWgEOW3hZU7ht4jRZvSc5sQR8j
 ofMQ==
X-Gm-Message-State: AOJu0YwesTITl9eR1QERaosJTmhSZv/gEMrn1lpLgWdC39lRU6r9tJzF
 6SMPUtV6s6LRkk4WQTHrNxeKNH88ZuqGa0RvUldGEdf19nSO7kvi8oNULClyIDNqIFlxpQEVGjn
 7
X-Google-Smtp-Source: AGHT+IGq9kJXvc10MuvsO5ujDoDaQDnM4ynzQdE718yRq2UBDtH365OgrAlqBCi+sOjH1x64XGNNPA==
X-Received: by 2002:a05:600c:1d12:b0:413:2ea4:1731 with SMTP id
 l18-20020a05600c1d1200b004132ea41731mr3970648wms.15.1710268694341; 
 Tue, 12 Mar 2024 11:38:14 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v17-20020a05600c471100b00412ee8e2f2asm19836337wmo.9.2024.03.12.11.38.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 11:38:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 7/7] tests/qtest/libqtest.c: Check for g_setenv() failure
Date: Tue, 12 Mar 2024 18:38:10 +0000
Message-Id: <20240312183810.557768-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240312183810.557768-1-peter.maydell@linaro.org>
References: <20240312183810.557768-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


