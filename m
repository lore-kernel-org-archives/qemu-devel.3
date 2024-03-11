Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86929C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 19:22:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjl80-0005Yg-Pm; Mon, 11 Mar 2024 15:16:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rjl56-0003Qt-TN
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 15:13:08 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rjl4v-0000Nz-V1
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 15:13:03 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4132600824bso9417305e9.2
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 12:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710184372; x=1710789172; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bC+LUFs+cDKcgliQteAEFQtfSzHpjUGJyBcf3ZG4pxI=;
 b=P+k2VVBBKr35AZhwdStCq1bD1vcAtI/myZyGE13GwoRhIZQVSCaxkgFl62g6O1xtQI
 pSd5y9grh8z0YnU2phGKJ9OcPgAa39/BZG33ePr0z2iaSC/dapN4L9Naj/lSIaMQ59eE
 EDVKICcKfamHu9uC3BQuF/rtLkHPv4L09nXH/pCToWQGFnJq6IJhcf+1WsUgGyoi1vVp
 4TKO66aQut2iv3PYV4YJcAyKDBlt+uJvgzjbEXoizX5GrriTAzmod1ZqTaJTQTRUgkev
 wvnYCEuJToy1FxhPMNyaivhJDPtl7PgzBLtUe7i2QrD2VwW6LVT16AU7UKyG1TVEefAa
 jhyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710184372; x=1710789172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bC+LUFs+cDKcgliQteAEFQtfSzHpjUGJyBcf3ZG4pxI=;
 b=KXKq47XNPnU60noTa9M1bQZvNpwEO6ZWuHYDWvSE8qlqNzmxyjlPI9ZCjq2/92Q0HY
 CacXPcdHy6HmzssuiKpNca2cfnN+RvLsrBnbtwOuG5PtY9Qe4zKuSxWWqauo+qj1fAFK
 Hy3i5U4l77YBwj7AiwEGMabnX8mFPy0TYTATONPDr7jLspsJqWNI00g2oeWepON/auWe
 d4g543gy9+w3VaRaeOgAjUsVfMGBC5G4ECws/Xv0Bv1tbVSa3edKl+wQD52yVNDjVYGL
 q1qvj46UuJ/XBlGWyuHl3Ynke3z1qJw9RnEWC9YeDrsDwcG0EB7vb5810uBbCSuGf9+0
 4rRA==
X-Gm-Message-State: AOJu0Yx+D8YqGO5WEQ39HlmAklxr/y/Zu1lPraJM5dBTvk/vEFFEfW1x
 qLX/HS00D7X3WKh8f/HDbLDQioFtIpzc0q57s91tS4NFecU5VS81lORC2npQeKa77Hk336lREj0
 w
X-Google-Smtp-Source: AGHT+IGqHnK9sGWeI3Mn9yAeKAeFFX6c+9vqgQIgLwe0kJ1P1eZvTlX36z9r/dZ0QkH9NgEdyZbJzg==
X-Received: by 2002:a05:600c:5405:b0:413:1921:8698 with SMTP id
 he5-20020a05600c540500b0041319218698mr1076420wmb.41.1710184371875; 
 Mon, 11 Mar 2024 12:12:51 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 t10-20020a05600c450a00b004131388d948sm14425266wmo.0.2024.03.11.12.12.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 12:12:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/20] docs: update copyright date to the year 2024
Date: Mon, 11 Mar 2024 19:12:41 +0000
Message-Id: <20240311191241.4177990-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240311191241.4177990-1-peter.maydell@linaro.org>
References: <20240311191241.4177990-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

From: Ani Sinha <anisinha@redhat.com>

We are already in the third month of 2024 but the copyright notices still refer
to 2023. Update the date to 2024 in documentation and help texts.

Cc: peter.maydell@linaro.org
Cc: qemu-trivial@nongnu.org
Signed-off-by: Ani Sinha <anisinha@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20240311120346.9596-1-anisinha@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/conf.py              | 2 +-
 include/qemu/help-texts.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/conf.py b/docs/conf.py
index 1b2afa241c0..aae0304ac6e 100644
--- a/docs/conf.py
+++ b/docs/conf.py
@@ -88,7 +88,7 @@
 
 # General information about the project.
 project = u'QEMU'
-copyright = u'2023, The QEMU Project Developers'
+copyright = u'2024, The QEMU Project Developers'
 author = u'The QEMU Project Developers'
 
 # The version info for the project you're documenting, acts as replacement for
diff --git a/include/qemu/help-texts.h b/include/qemu/help-texts.h
index d0359f82e08..353ab2ad8b0 100644
--- a/include/qemu/help-texts.h
+++ b/include/qemu/help-texts.h
@@ -2,7 +2,7 @@
 #define QEMU_HELP_TEXTS_H
 
 /* Copyright string for -version arguments, About dialogs, etc */
-#define QEMU_COPYRIGHT "Copyright (c) 2003-2023 " \
+#define QEMU_COPYRIGHT "Copyright (c) 2003-2024 " \
     "Fabrice Bellard and the QEMU Project developers"
 
 /* Bug reporting information for --help arguments, About dialogs, etc */
-- 
2.34.1


