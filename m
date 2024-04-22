Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0203AC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 12:43:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryt02-0005ve-BU; Mon, 22 Apr 2024 08:42:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ryt00-0005uw-F8
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 08:42:20 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ryszv-00041v-AB
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 08:42:20 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-5171a529224so5589703e87.0
 for <qemu-devel@nongnu.org>; Mon, 22 Apr 2024 05:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713789732; x=1714394532; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Z8tunMkN/tO/jeUxNDLWeanK4s9RFq375E0sg1AGANM=;
 b=WjAkbm/WrhuyFapwoRju/dMm+etjYN3q6Qit0ApT2xuV58uuZxB1TsrJhQoAkKS110
 HCncTakfJRYsxSnTZQh2wrSjkUh6FU2ONDwXlqk7+4P9lKSZeDfXt1oP71LyHoAEw7Ni
 CrApRDmyC+aPns4nPm9Jc9o2wtfHLBFVrdFJIbj74ZpADKgmzWuSbVst3gjggIrbhxnk
 PQn2rLCnYH/NkyiPjLsn+FpI42xwRpDklkZalZ+gnYZX1reEOe6uFcmNzl36teI053as
 aATvANWpgVpRapxLKLlH4RcW54dbvzNFjQehw2px+klL6qK2tnRZ0nvT64/VCfWyRP8A
 3poA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713789732; x=1714394532;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z8tunMkN/tO/jeUxNDLWeanK4s9RFq375E0sg1AGANM=;
 b=qZPNM4W7CoE1NVa3xUTMe4RTNfsm2gkUkczaS3j48TiPGcBHNCzUCXZH2LZLjK+N7v
 fPk6h4X14tJh8avHEn3DSXhQr74/3FuIPl4nZEyeyLxGmyaWTTYTt/HskG1dYL54eL+P
 b+pW54BzOQ96g2bo1cqOjfoOif64MhgvZgSxBJdNHmw5uzCbT64ouwqRJXx65bjDfqYh
 5zhCeKtP+LAy32g2oN8RHe2dQZmgblBDrPwiQ8XCnyRRE/U2qKU7Dq8Loko1iw4jTO7k
 jpd9LKp3Idxkd3RX4xYYdNkmVqBD8EofqLe3/1LOtQeghyxUnE3zySfSp05BT2kEOk4F
 WMbQ==
X-Gm-Message-State: AOJu0YxpwhcjGVW07x5QB0wO4d6Ifzo50ZXC+7X83bfqjwn+c9GYpNh8
 T2lIJX2tNm7sr1IF/WWCH7qzYoNUy0qAraWbRD9/TdAvlN8zNzmV/86RCKyDBkiKCxpWsnp//cO
 o
X-Google-Smtp-Source: AGHT+IFjgkuEnpQXZ8bxvuUy0vOJzGYS8CeKxE61TzDCiLYFGuUCvXqdI+dAV8gVKbhqTK88cWbfrg==
X-Received: by 2002:a05:6512:34d8:b0:51b:b7:a14c with SMTP id
 w24-20020a05651234d800b0051b00b7a14cmr2805033lfr.20.1713789732236; 
 Mon, 22 Apr 2024 05:42:12 -0700 (PDT)
Received: from localhost.localdomain (adsl-53.37.6.0.tellas.gr. [37.6.0.53])
 by smtp.gmail.com with ESMTPSA id
 bb6-20020a1709070a0600b00a55b020a821sm1727233ejc.13.2024.04.22.05.42.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Apr 2024 05:42:11 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] docs/devel: fix minor typo in submitting-a-patch.rst
Date: Mon, 22 Apr 2024 15:41:28 +0300
Message-ID: <20240422124128.4034482-1-manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lf1-x12f.google.com
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

s/Resolved:/Resolves:/

Cc: qemu-trivial@nongnu.org
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 docs/devel/submitting-a-patch.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/devel/submitting-a-patch.rst b/docs/devel/submitting-a-patch.rst
index c641d948f1..83e9092b8c 100644
--- a/docs/devel/submitting-a-patch.rst
+++ b/docs/devel/submitting-a-patch.rst
@@ -177,7 +177,7 @@ add an additional line with "Fixes: <at-least-12-digits-of-SHA-commit-id>
 
 If your patch fixes a bug in the gitlab bug tracker, please add a line
 with "Resolves: <URL-of-the-bug>" to the commit message, too. Gitlab can
-close bugs automatically once commits with the "Resolved:" keyword get
+close bugs automatically once commits with the "Resolves:" keyword get
 merged into the master branch of the project. And if your patch addresses
 a bug in another public bug tracker, you can also use a line with
 "Buglink: <URL-of-the-bug>" for reference here, too.

base-commit: 62dbe54c24dbf77051bafe1039c31ddc8f37602d
-- 
γαῖα πυρί μιχθήτω


