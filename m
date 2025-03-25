Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAD71C35FFC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 05:01:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twwOH-0004Bj-Lw; Tue, 25 Mar 2025 00:59:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twwO0-0003oe-DB
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 00:59:38 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twwNx-0005t5-L7
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 00:59:35 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2ff694d2d4dso8328503a91.0
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 21:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742878772; x=1743483572; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nPsnrBhccWgusioYoG8wwAVpFwZsZiOnGsl/PTdMWhk=;
 b=QYQ5FLfGYyk0roLRa/859uMqIXXokqW6lfkv7UgrRuTAOGh1VcDHJHc4BBR12dD5Vl
 4fJBglEvMEbo0/MDjcT3uLKKZ4FbGrmY/wnY78EWO27Pj9bMdUQ7I1sTD7y8pHClAEnT
 nJA2LRDzfnnrt8mlHPkeubt6yIKGcPayz+URqXGdcEWSzpXeFXpN6f0T11MeB2wp7MHi
 1aZT1pWnA39n5E4aiJLnxV225XTS/rrjP3mO+fqSErXD7nkJKxcDuJj1VF+HFJpqOuex
 qgbFuEK4BIRnq/MbVs5QCw69MDzRlTtSOq7CO2IqIGmimg5YNn9jOYSJxoqTcbqgjzUV
 w7Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742878772; x=1743483572;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nPsnrBhccWgusioYoG8wwAVpFwZsZiOnGsl/PTdMWhk=;
 b=dp6SU2H/7TynPO+MQr5dc/lAWKrpICEwChNW/bHty5KegyaeXgIuveGYt/zbTtjCGM
 2kXjGbFZrzRzZvrvyAJrLR0LnXa3cqbAYpmrjnNNUivMkGGgLm5C0XS2zcmyzK0+Cgk5
 LgobGo8JlnvNnpW7rQaD7ufpUTL3n/PN4F9ufpCV+9Qxbn0TM3ADs1ksIDBruQMpwagY
 0Xni48IDnfT1k/le2kZZWsKzjfb2ryYoU1a7wDTFaB9i8GmmXTVBJ2o7NF/NHU27Hx3Z
 iY2Hnq+gH949cnsemLhI6Hq/eKBezUypnNjJ7iQP4yrZ5tEJw5GYSvPMb2H2s/rADMLl
 JI6g==
X-Gm-Message-State: AOJu0Yw4uZPwQtE4VnZOqXTZSMrXN4QfO6X3vR3Lpgl2o/anmPBEUTNF
 of/0vQINa1vOol01IHljX+07k1pOfwTgv+yBCjyB7XhoigwiY8ddNOZRvlr53hTWSkKCZFjbbkr
 F
X-Gm-Gg: ASbGnctToc+bayLDfoaMLtI1BFQ+lMdCyPTuQG73ZD7E62WmIN4m4I9R3hbO4Pk7gar
 NqKjphZbGC1AcPSsJxuhGU/YjbTs8ShejSXyaqg6wHJYb489FJEO6W0LxanpadgbmcrVvq1rsOc
 ezhuehlX4yjKFGy669alFS4uOGaYaeJPLgX0mDF6AqEngq9b1KzVRGUgwuHCx/z+5FkXuXJEfQa
 uPQ7h1NUW0Ge555DRF93OW8th/XtRtpacj7ZpH84U1O6TJKNtIaA2EGr7JP4n6Sieum/hbV5AcW
 bDMtuW1U+P5GKCm60OOvBdj7j6VFLBNFigc+QsaZNaoh
X-Google-Smtp-Source: AGHT+IFhBlyML92DzOsb+PMZ24kTM/lrjFJmrSBEIi05/e6tUY8Bh1kxoJuR1Fz5pHuu12ZsWx03WQ==
X-Received: by 2002:a17:90b:4d:b0:2ee:db8a:2a01 with SMTP id
 98e67ed59e1d1-3030ff00e7bmr22295807a91.30.1742878772239; 
 Mon, 24 Mar 2025 21:59:32 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301bf58b413sm14595120a91.13.2025.03.24.21.59.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 21:59:31 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 11/29] accel/tcg: fix missing includes for
 TCG_GUEST_DEFAULT_MO
Date: Mon, 24 Mar 2025 21:58:56 -0700
Message-Id: <20250325045915.994760-12-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250325045915.994760-1-pierrick.bouvier@linaro.org>
References: <20250325045915.994760-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1034.google.com
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

We prepare to remove cpu.h from cpu-all.h, which will transitively
remove it from accel/tcg/tb-internal.h, and thus from most of tcg
compilation units.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 accel/tcg/internal-target.h | 1 +
 include/exec/poison.h       | 1 +
 accel/tcg/translate-all.c   | 1 +
 3 files changed, 3 insertions(+)

diff --git a/accel/tcg/internal-target.h b/accel/tcg/internal-target.h
index c88f007ffb7..05abaeb8e0e 100644
--- a/accel/tcg/internal-target.h
+++ b/accel/tcg/internal-target.h
@@ -9,6 +9,7 @@
 #ifndef ACCEL_TCG_INTERNAL_TARGET_H
 #define ACCEL_TCG_INTERNAL_TARGET_H
 
+#include "cpu-param.h"
 #include "exec/exec-all.h"
 #include "exec/translation-block.h"
 #include "tb-internal.h"
diff --git a/include/exec/poison.h b/include/exec/poison.h
index 4180a5a4895..8ec02b40e84 100644
--- a/include/exec/poison.h
+++ b/include/exec/poison.h
@@ -37,6 +37,7 @@
 #pragma GCC poison TARGET_NAME
 #pragma GCC poison TARGET_SUPPORTS_MTTCG
 #pragma GCC poison TARGET_BIG_ENDIAN
+#pragma GCC poison TCG_GUEST_DEFAULT_MO
 
 #pragma GCC poison TARGET_LONG_BITS
 #pragma GCC poison TARGET_FMT_lx
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index bb161ae61ad..8b8d9bb9a4a 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -43,6 +43,7 @@
 #include "system/ram_addr.h"
 #endif
 
+#include "cpu-param.h"
 #include "exec/cputlb.h"
 #include "exec/page-protection.h"
 #include "exec/mmap-lock.h"
-- 
2.39.5


