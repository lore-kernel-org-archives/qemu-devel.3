Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DB94C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 12:45:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNAxZ-00069G-PP; Fri, 28 Jun 2024 08:44:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sNAwh-0004tV-OF
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 08:43:23 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sNAwY-0005ip-Ez
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 08:43:13 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-57d2fc03740so698949a12.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 05:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719578589; x=1720183389; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/lQrpNj9Yq6e2VZHJs41tWCzx2SCmT2FMLZDJQM+poI=;
 b=aDSVYpI6TDULZNdIwdKhalEMtN8zslvehkhc7LL62xAXMcCXO+gIMRYYHKQzhc9+lV
 hsVXCgjcv01V0OlphTo6ENmcB+M15Fclgzc8e4TzvxNEF0Xqp0gqsooAW4Ljnvxrh7Bp
 Ri7i0Qv++oWx3DrVQHC22owXLHRW0DN6gpBCNFeBK0FXCGTcwDtdOjfANB7z70zppGRG
 48i/Mof+bnksWoH3L6Aplyrqi4CAunL+lNZS38yL/Hyi3Pw6oAG4wEBjUjt6HDmR1e9t
 BdmmyL8w8bbEskFIWM+Qm+4Rwf2DcD/Ylwy5r7/NLSXxwhMHJxLDuLLjokw2917zBCFz
 kulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719578589; x=1720183389;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/lQrpNj9Yq6e2VZHJs41tWCzx2SCmT2FMLZDJQM+poI=;
 b=KRfixRe4hRrrX4GhW+UFkTOLOHG20IS5HX9ypOBKfpq4jPqVoFLs9x8qnvO138rYvE
 joSHn9zQEgoxPjvqp1cifY+rOodIstihLZJ6jwaT9rXduV+Z795x+sQUgxbif79J70G6
 hVMvQvXncPYaJWDMYSMfsI9iH4rr6qn763rMJJcJbm6wCPKCzUNN3r7gz9NdWMRxrJcD
 CZUp9JP7kOYcjOldzZFZIdlTeAnZRJXOXpOwimYsfHdYyX695mi6aQhastV3aMY0j+DB
 DXc84Rdpx9gxQBm3MtFsZ9kvEIUKWmzc9K6Yl/UDwcDdkfj59PbZ8Ca7nljnb3yRqBgu
 wA2w==
X-Gm-Message-State: AOJu0YwVKRWcgWDHj3zBGZbW5NsKDpj14nFeI63lMPw4zORqdvFRH0to
 vSd10omxSENCKAWbze9z1+zd74XU6ARy46qHArXs895uSODWcQ0QoZ8WgONCIT8=
X-Google-Smtp-Source: AGHT+IGMunC04TdtPY6LkRLCf0WZt9814RwPekLOjvRi1GtNFOE3UfHThvaqo1gknzXR9el/Nzk8RA==
X-Received: by 2002:a50:9e84:0:b0:57c:60f0:98bc with SMTP id
 4fb4d7f45d1cf-57d4bd69fa4mr11371811a12.11.1719578588583; 
 Fri, 28 Jun 2024 05:43:08 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-58613816055sm980993a12.46.2024.06.28.05.43.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 05:43:03 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 08A0A5FA38;
 Fri, 28 Jun 2024 13:43:00 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-arm@nongnu.org,
 Peter Xu <peterx@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH 11/23] plugins/lockstep: mention the one-insn-per-tb option
Date: Fri, 28 Jun 2024 13:42:46 +0100
Message-Id: <20240628124258.832466-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240628124258.832466-1-alex.bennee@linaro.org>
References: <20240628124258.832466-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52e.google.com
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

This really helps with lockstep although its super slow on big jobs.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 contrib/plugins/lockstep.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/plugins/lockstep.c b/contrib/plugins/lockstep.c
index 761bcdf363..353bf12dfb 100644
--- a/contrib/plugins/lockstep.c
+++ b/contrib/plugins/lockstep.c
@@ -14,7 +14,8 @@
  * particular run may execute the exact same sequence of blocks. An
  * asynchronous event (for example X11 graphics update) may cause a
  * block to end early and a new partial block to start. This means
- * serial only test cases are a better bet. -d nochain may also help.
+ * serial only test cases are a better bet. -d nochain may also help
+ * as well as -accel tcg,one-insn-per-tb=on
  *
  * This code is not thread safe!
  *
-- 
2.39.2


