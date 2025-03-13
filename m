Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 563AAC282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 03:50:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsZWa-0004oE-Qw; Wed, 12 Mar 2025 23:46:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsZWQ-0004kX-8q
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 23:46:14 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsZW8-0007qG-Aa
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 23:46:13 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-22409077c06so13185645ad.1
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 20:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741837554; x=1742442354; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NlesW0T0yCTWXBKRDt6pLfqvUeDW1NYxkb6NRcPiDCQ=;
 b=KhFCI8mOAJTzaz0PllJXrJ2QaP7qAh8PL/DnL6xCPR3+bdPIJ2Spmk8BHBVg7H9gu+
 Sg8UOdGiB6vH7XzXDrZBJ8BaeHXMloXoWR+ljwoHA+J/CKMF5Cot/CYrexL5/wFBy/QA
 ImkDHiSeRhMnBeoaMbqZgZMtwUmwBQ7JfZihItthyLNKJ0/T3CjaCf+ZAKgtLEoIsKkW
 CVhQ5alTljXe+I/Ks/2NCBcHru3z+RKG97E1Jm9XGrDs7eEc6+TAuQW248oAVoLvMnb2
 aPpdHE+0Y88Eoi3Ovm+Z871c/57bJlvDzcMzlLoOtV6O4K7odH4Tfp0Q1oW0D3uYDrRC
 5aBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741837554; x=1742442354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NlesW0T0yCTWXBKRDt6pLfqvUeDW1NYxkb6NRcPiDCQ=;
 b=w7sCrUcTulVMJC2EFjXtH3Ab0BiQLfizzXG5F3cpBdLgE6960bVtS8540aWdK24q8k
 8sBQ9g61pw7p+/ERdxXUeqyxptZj4H9xNABeBuxfvs8fcKE2/8AVh8ewetLBn61RgAvm
 PjX6LkMB9IfQMj3M9/Url9ubd0aQgiK8t+tnbL3iaqed3ND9Zpdw9tmkN/ULpP4HjA3D
 mpaDVip6q2DSTAwEcGgoeK2RnRMTmGDM2Q36XkW5oCziG0C0F6KJFBlfePkoX1EYr4o2
 LIP+v7wL26VMymm0d8cBzbia88EQKKGTZIDU+B4u3XhtrZrzPedYuYYn/1DzC1czCDQu
 o+Bw==
X-Gm-Message-State: AOJu0YxaeZoL0+XWhsZ8i4Bg+gJkcgrJCo4ijY+OpwgzMxRZopMcxI9a
 sl+/IMsZm/K+mwERQaiPKpjroAcDpYNNX2tsEDuiTWKVXufnLLf84J+Hx0wFYpk5eq0Dsb5pvyZ
 C
X-Gm-Gg: ASbGnctzmCHE0Q/v/5z9YlZxqab1sSXCexDXB9b6EX3WV2ibcZ2Flv2Ut0gD1IllD2N
 Hen1OX1qTTKWUtVuUB3nL4Fwr4Qjy30SNw4+osL9203VngPRxw3o5rMEsBgIY7zO9l2U8GaFkYE
 W/hdaueWaODFDcwY1WVZGz1E0rulZbRM/XN/STCAel6mENsSiPuGEjSFkv7pdY0qDXe1DAKAp1n
 N/WaU1CWe8V817MkldBieMtGwM3Vm+OCEosBh9EfJFtyngm7tbV7XSUC5FFAg3ID9dX5UxGnkrp
 +GeP7YEqxx4beSipBNzBvFbWVO5O00pXWv1Iq7j0Cf7GecOcmJySNa52M7guqOKClYnjIR3mDOz
 uCW+g2i3Peik=
X-Google-Smtp-Source: AGHT+IElFig+ktrmFAP/uhmybZ13Duqmsyn6nqgBo0bbpp+iMprmrIJ2gQGpZvQxvL3W3PCZ3v6JwA==
X-Received: by 2002:a05:6a00:2d01:b0:736:35d4:f03f with SMTP id
 d2e1a72fcca58-736aaa1b7a8mr33072889b3a.6.1741837553722; 
 Wed, 12 Mar 2025 20:45:53 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7371167def8sm316781b3a.90.2025.03.12.20.45.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 20:45:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	pbonzini@redhat.com,
	philmd@linaro.org
Subject: [PATCH 34/37] include/system: Remove ifndef CONFIG_USER_ONLY
Date: Wed, 12 Mar 2025 20:45:14 -0700
Message-ID: <20250313034524.3069690-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250313034524.3069690-1-richard.henderson@linaro.org>
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

This is include/system, so CONFIG_USER_ONLY will never be true.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/system/cpu-timers.h | 2 +-
 include/system/qtest.h      | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/system/cpu-timers.h b/include/system/cpu-timers.h
index 64ae54f6d6..f10cb5e7d4 100644
--- a/include/system/cpu-timers.h
+++ b/include/system/cpu-timers.h
@@ -30,7 +30,7 @@ typedef enum {
     ICOUNT_ADAPTATIVE,
 } ICountMode;
 
-#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
+#ifdef CONFIG_TCG
 extern ICountMode use_icount;
 #define icount_enabled() (use_icount)
 #else
diff --git a/include/system/qtest.h b/include/system/qtest.h
index 6ddddc501b..84b1f8c6ee 100644
--- a/include/system/qtest.h
+++ b/include/system/qtest.h
@@ -23,7 +23,6 @@ static inline bool qtest_enabled(void)
     return qtest_allowed;
 }
 
-#ifndef CONFIG_USER_ONLY
 void G_GNUC_PRINTF(2, 3) qtest_sendf(CharBackend *chr, const char *fmt, ...);
 void qtest_set_command_cb(bool (*pc_cb)(CharBackend *chr, gchar **words));
 bool qtest_driver(void);
@@ -33,6 +32,5 @@ void qtest_server_init(const char *qtest_chrdev, const char *qtest_log, Error **
 void qtest_server_set_send_handler(void (*send)(void *, const char *),
                                  void *opaque);
 void qtest_server_inproc_recv(void *opaque, const char *buf);
-#endif
 
 #endif
-- 
2.43.0


