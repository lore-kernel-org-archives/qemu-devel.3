Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04BB9FD8FF4
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 18:54:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvgUa-0008Ru-EG; Thu, 26 Feb 2026 13:53:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vvgU5-0008Cr-Cd
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 13:53:14 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vvgU2-0003XK-Bm
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 13:53:12 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-65a43a512b0so1528965a12.3
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 10:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772131989; x=1772736789; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Oi5+N/x5xAvSZ7dTjPMAxsIhN66/aeUbNGSs4qe4/hc=;
 b=O3XqqpUN+dOjwCvwqQALRIEoQhVi4hkAEBLWEgDL6oBbLGQByAyvc6JyNhjgFUG5NO
 AKNNRH/jm+ju5GSdammqFji9B1OAynd878C2uNIaJnw2W1z0N0uZuTvymDPlJOr1TKA9
 LmTCitNJgXIrgA8i5iz6PNoVyFiWH3hnygx82sb70H8NR03FAA4d8GPL0oJpuML6PP/q
 hscwJHPE5R22Dr9d1mDNBYnjxtwgdgYIPAWKlubcKVAHBSL/05O0YqRtHny5RrEmWmJa
 MObf2DfLZEkxtqqPyoqdzaJuD3aINK7b1BIiPUjxeYujqSl+PNRo7dpaa8XAmEWTlvXG
 OEGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772131989; x=1772736789;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Oi5+N/x5xAvSZ7dTjPMAxsIhN66/aeUbNGSs4qe4/hc=;
 b=vMLs7iM3ecCdTlW4HUY3Uqz03Xlcx6GX850re1/pEccTsgRziLws9Uf/lOfKE3jNAJ
 nZtxKbgPQOTAOGYoRZyTwkra+x3jVFV8r30QPgdJ8Tcgk59msClwFPTd8lJTLsoBa2XY
 c11UnY3tiRZBoTrP2KaiSYM7OOeXo2yWONBfpNY0oJWyResdQvX46tfV4h0x+Byd4lf0
 t5Khw66VgJpoLJ/PuCdTIVWA4x/8/aTxBP1xkSq1ZftXP7aeCPO6oNjFnBuM7xoHV5Pb
 zCwGgEayYuZPFz62hhtK/EW6gbf/eGBc+8SUn1wPvGYqQp44V//V4OPHwmCUlLe38K1D
 1QHQ==
X-Gm-Message-State: AOJu0YxRkvfZqxidPIAAtfqziT/n3v++4Z1K1REh8MZO/ZKjfixeykrF
 KtOjt3hw1F6NnQd62vaC0sfMi+tPdQ0m+McmO/ALWKcjudvE3hnOpnqoqPiSU8xI6xQ=
X-Gm-Gg: ATEYQzyl05vK856bs+OSk1Ln/T+ObG5h7n14MmfWN8DlWa9O7Ul1k221xaXyRTov7QX
 18hubw/hnKGBSW5DzpHoLj8Vj2aJmzozVwGQzqqtzDyMq/co6/vCwV7tsgf29jA7uxYIAThuQru
 yq0SVcXFM+IlShMIv+ltbKikPywOoOnbw5ljPVyDDLJIomQrb5lr6sRrcLueoLFAUoGe/gKOu2L
 E83PuxJjPkINQX+BiEt1uT945GDwFuVsfFbyEoSSTuD+gmh0ngfB8oKwHPLKlFHisDcPdi0SBT/
 lUXpLY/cTKPleCWAh/Z2tx392PwFL6/l1mVfZv4fQc7K3qZ9j/GnBGAlij+qc1z7ZtFzeODzAPE
 +arCW+RcGGaI+TJtkxLaQkKT9+N2q3LvJdFPXCyzQ8PurKE2C3EIsuXEt4tTz7Pm2UFoz9ZKRva
 18bRl63wvODVdsgODXQNH4a2o=
X-Received: by 2002:a05:6402:42c4:b0:65c:2170:67d2 with SMTP id
 4fb4d7f45d1cf-65fddcebdcamr232929a12.16.1772131988829; 
 Thu, 26 Feb 2026 10:53:08 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-65fac07c09fsm718547a12.32.2026.02.26.10.53.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 10:53:07 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DFF1F5F8D3;
 Thu, 26 Feb 2026 18:53:03 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 Brad Smith <brad@comstyle.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Warner Losh <imp@bsdimp.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 5/7] tests/vm: fix interactive boot
Date: Thu, 26 Feb 2026 18:53:00 +0000
Message-ID: <20260226185303.1920021-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260226185303.1920021-1-alex.bennee@linaro.org>
References: <20260226185303.1920021-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52d.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

For reasons still not clear to me passing the single dashed
-interactive would confuse the argument parsing enough we tried to
pass "nterative" as a string to the launch command causing failure and
head scratching.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20260213154859.1551283-5-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/vm/Makefile.include | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index 8a5aaedce7a..0a53dc9fdd6 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -154,6 +154,6 @@ vm-boot-ssh-%: $(IMAGES_DIR)/%.img $(VM_VENV)
 		$(if $(EFI_AARCH64),--efi-aarch64 $(EFI_AARCH64)) \
 		$(if $(LOG_CONSOLE),--log-console) \
 		--image "$<" \
-		$(if $(ROOT_USER),--interactive-root,-interactive) \
+		$(if $(ROOT_USER),--interactive-root,--interactive) \
 		false, \
 		"  VM-BOOT-SSH $*") || true
-- 
2.47.3


