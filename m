Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D6D1C369DC
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 13:00:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9O57-0007zd-8s; Mon, 28 Apr 2025 08:59:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u9O50-0007sn-I0
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 08:59:27 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u9O4x-00036G-3N
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 08:59:26 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5e8be1bdb7bso7490379a12.0
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 05:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745845160; x=1746449960; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mN1ikYfL3yXWBXqalxA+FshRUzVIN2Sj2/UZDoT8lTI=;
 b=tylNmCFmLogDYmogUz3BZm0NuAHfz9m3o6OA1e9wLCf6OosM1rMxH+botm5cUNTmYW
 TuE7l8dziAvUAuSPCO9I36AFxFmCgW6LboQahPZQM9Wc/HtBgbpP+/YrY60gE9h/XEon
 GxvXrbzacaf/O9owkUQjH0CLJTQ49+Ea76z/dN0Dr+1CmK/rzwDCVD37MGpmhRX435YN
 5QaLvGc/vCfaExGtZQHFuZjGEWhcOtuLkDheZHog9cqnLInHMWxSO4ftTa3/nVv5RjYK
 bUIZS01Q+c+MBjRqtHqVX1cV0/5sMaZ19mufwCXZwqpp1yulmECVreS5P+/mYCkwyvBJ
 0+Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745845160; x=1746449960;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mN1ikYfL3yXWBXqalxA+FshRUzVIN2Sj2/UZDoT8lTI=;
 b=sWuWiURYEBxD0HbZrDPO4uuU4Aq2+5S6RklRNR4bl3iVySEJ3KgtCLv2SdQlwko7iG
 LqQc/VZ/gtO+wnxul/sWfZJaWzSWJdvzIYjHkT263Jbv5ockKw6OxLLVkEktLsHuwfBK
 5DbA6f+o7rd15nsmr7YOiN5kCDNe4hyAaYMK8BVsJ2UzD2LfHRQlZyPWL0HoW0YSULil
 56FceXyfg+E+DKe7ZPloWHdVxJzMcuxaoYjjwrEJTgb1tokNe0Tu1rBFWJo9QpOV99LJ
 k82weNS1mCxYcg3WnDLXJ9zJ8gsRwAzoBxQ0x/XtMKnrdtndB8CpViqTnGjxIeL9oTHY
 +eag==
X-Gm-Message-State: AOJu0YxyNCqReIdbsBE+Vb/YYwv8Ps1gSwartJ65XiE5wilU2PyUuLII
 L04SJJbyFMnzuZ/5HRVJeAV25VahyoMnLNUHFSkGkZikSuMbNiwgczmdxccDTvk=
X-Gm-Gg: ASbGncuguXiiAVSTbjRw3OSfPAtwndnhtu1DLS4yP0nRM24SvoB2YerH73eYNybONGl
 kvokdRAHOKSeGMcb5QVBqsO76yD2MIOePK1FWfvPfSh/eSPtZr+FVncF2yk+A4M860pUdj1COax
 /9TrEsUihc25S9hkX5kZ4qOH+c1dq5tn2hrwj47gaSUvc3wsNWIlz23dI3wYtJBZwsCnJjcjLZ+
 sa5H32XlwvDM6gDcPLM2XJU2ykUgIEkneUN9S0Ff/3eb6Qny5TT5H1CdJOkbFHBrDLqmOyIO9Yl
 wQa2EFgWM0zkI8+05fYT0yL4Mr0cVfgW2bmHTYF7Dcs=
X-Google-Smtp-Source: AGHT+IGYOSjXK7Tijphrt3ThcikSfT3xuI4mqFIQsU/XGGkSxdx3mGRODKWC0OI6BJE+4Y9CA5N0bw==
X-Received: by 2002:a05:6402:35cf:b0:5ed:61c8:adcf with SMTP id
 4fb4d7f45d1cf-5f72297d620mr9563628a12.15.1745845160298; 
 Mon, 28 Apr 2025 05:59:20 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5f808b23ad5sm781881a12.66.2025.04.28.05.59.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 05:59:19 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6FC5E5F9D6;
 Mon, 28 Apr 2025 13:59:18 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH 2/9] gitlab: disable debug info on CI builds
Date: Mon, 28 Apr 2025 13:59:11 +0100
Message-Id: <20250428125918.449346-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250428125918.449346-1-alex.bennee@linaro.org>
References: <20250428125918.449346-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52d.google.com
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

Our default build enables debug info which adds hugely to the size of
the builds as well as the size of cached objects. Disable debug info
across the board to save space and reduce pressure on the CI system.
We still have a number of builds which explicitly enable debug and
related extra asserts like --enable-debug-tcg.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .gitlab-ci.d/buildtest-template.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitlab-ci.d/buildtest-template.yml b/.gitlab-ci.d/buildtest-template.yml
index d4f145fdb5..d9e69c3237 100644
--- a/.gitlab-ci.d/buildtest-template.yml
+++ b/.gitlab-ci.d/buildtest-template.yml
@@ -24,6 +24,7 @@
     - ccache --zero-stats
     - section_start configure "Running configure"
     - ../configure --enable-werror --disable-docs --enable-fdt=system
+          --disable-debug-info
           ${TARGETS:+--target-list="$TARGETS"}
           $CONFIGURE_ARGS ||
       { cat config.log meson-logs/meson-log.txt && exit 1; }
-- 
2.39.5


