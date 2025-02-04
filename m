Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73013C02196
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 12:52:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfIOA-0000Pv-79; Tue, 04 Feb 2025 07:50:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfINo-0008Nv-5M
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 07:50:29 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfINg-0002Bj-U8
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 07:50:25 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-38a8b35e168so3312628f8f.1
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 04:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738673419; x=1739278219; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+/BkF7oHf/xZr0+f8qz/0hceFUupsWr4MwchLEbF1vs=;
 b=qxwQyeWS1uy9jkjxU2eQr48GV4uo+iddewszvXdyFc9ySkYthH+zLUVUH9RFV3KrwM
 9sbKnHCzIBLF6H/8u/vCVTIS972wuvNPyyQNA4M8uYYsrS4CZY8mYm2Z7ryydZ98vs87
 v5iaZ0sDu3DlLvZrdngEZTJlPRsURDzTQlVdf4zMljuYDCbT++LUNf+IwNTU6PAF46OM
 j+qhA0BPudSv94xeNbcJBgCzPjc4AFswcmwNchid2ZzyyxAjXAIAUPijKe0i6gtmfuc+
 FznX6N4w3KwcFwDFqvIxdYnheGavJz8biL8zS2FHzkc0x7UZW7+XoF6m2/CTSu/8M691
 llQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738673419; x=1739278219;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+/BkF7oHf/xZr0+f8qz/0hceFUupsWr4MwchLEbF1vs=;
 b=qJWA2EmIuyZlLLhIo4lbCFeflP+9ZJlHTITXFc9MhuhTX591UL27DBdVMmPopfFUap
 ibJ2kU2zqfTWvC9SYb0E+Wze4c9AIUtCEixSDR6NjQB3fGiRxijCEHeSFWzA7DQNlZmV
 fmxoo7BrNC6eztydsgr3oiQA5EQ+cqxsq1wu8RFRKeUfO8MGebGKAULVsS6ChSHadnYS
 Akz+Qz0LhzGxAfw2VlCD/F7gyxufEluddl+RbzIijB7dvnRko0tlJ8nsQIBncucUHI/E
 7Sa0eehSBCZwGUXlLLBzjoQ7JxnLoChuxNquq9jWw0RbQCdEOUj1BZRk5Gq5rN1i4JeH
 IZAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjHUg6vR2OZNZB6I+DwUiJkOJVDue9jWtRMgN0kBh17tJSB8zVS8aMRnYoKL/Nmq6qqPgnGS43fCWL@nongnu.org
X-Gm-Message-State: AOJu0YzRo3iPrnomHeRKnJ36b+6jQNqnW0gZTyupaF3P2ABKwRkoeJOV
 F1KhGnGpMjsGaAfuhOzXteKo+1x32A3eJS0LUb+V1pMOKB3sNNOrPcLEmti7Cfw=
X-Gm-Gg: ASbGncsrxKz9bM8VbNTOOUdntfnyyaVZ1y2J6Y0TfIpEXs7Z6BzbgSQLTvks5ZysJ9t
 r/M1plNMBLriwKrX6zrxNF8hsONSXOqP3FZmhbM7zJG0HW9UJyopIsNOdxyzR42kn9FOz5Hc1xg
 CagDZPbSQOa8cQcEpo1/4Jf3EiN62BhOQesqKPGnaXUVKY3uqXrZYJX0RerjmQ3pS+yEypEVj2y
 BnjD/9yeYtfh1OkFAylTtKDfWDd77EC5RBV/qunM0jXlV97+mYaO9nbDNGDQIZ5tti4fy/TcFeO
 YqvmF6t5XzpMaS0IdcWuqw==
X-Google-Smtp-Source: AGHT+IFPtxEvx565bOiiwHo/qxME4TNBFj6Fwm855XBGv0XfOM+j12lnOJeHgG+QZfljwrZKb8/htQ==
X-Received: by 2002:a5d:64a8:0:b0:38b:d807:f3be with SMTP id
 ffacd0b85a97d-38da5386429mr2278587f8f.3.1738673418819; 
 Tue, 04 Feb 2025 04:50:18 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c122465sm15757919f8f.47.2025.02.04.04.50.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 04:50:18 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 7/9] target/arm: document the architectural names of our
 GTIMERs
Date: Tue,  4 Feb 2025 12:50:07 +0000
Message-Id: <20250204125009.2281315-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250204125009.2281315-1-peter.maydell@linaro.org>
References: <20250204125009.2281315-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

From: Alex Bennée <alex.bennee@linaro.org>

As we are about to add more physical and virtual timers lets make it
clear what each timer does.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
[PMM: Add timer register name prefix to each comment]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/gtimer.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/arm/gtimer.h b/target/arm/gtimer.h
index 0e89b8e58d0..d49c63cbf87 100644
--- a/target/arm/gtimer.h
+++ b/target/arm/gtimer.h
@@ -10,11 +10,11 @@
 #define TARGET_ARM_GTIMER_H
 
 enum {
-    GTIMER_PHYS     = 0,
-    GTIMER_VIRT     = 1,
-    GTIMER_HYP      = 2,
-    GTIMER_SEC      = 3,
-    GTIMER_HYPVIRT  = 4,
+    GTIMER_PHYS     = 0, /* CNTP_* ; EL1 physical timer */
+    GTIMER_VIRT     = 1, /* CNTV_* ; EL1 virtual timer */
+    GTIMER_HYP      = 2, /* CNTHP_* ; EL2 physical timer */
+    GTIMER_SEC      = 3, /* CNTPS_* ; EL3 physical timer */
+    GTIMER_HYPVIRT  = 4, /* CNTHV_* ; EL2 virtual timer ; only if FEAT_VHE */
     GTIMER_S_EL2_PHYS = 5, /* CNTHPS_* ; only if FEAT_SEL2 */
     GTIMER_S_EL2_VIRT = 6, /* CNTHVS_* ; only if FEAT_SEL2 */
 #define NUM_GTIMERS   7
-- 
2.34.1


