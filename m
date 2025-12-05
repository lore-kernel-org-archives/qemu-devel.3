Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ECBAD33994
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 16:42:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRYsD-0005W2-0s; Fri, 05 Dec 2025 11:41:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vRYs9-0005UJ-PI
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 11:41:33 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vRYs7-0005jp-VL
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 11:41:33 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-477ba2c1ca2so29664225e9.2
 for <qemu-devel@nongnu.org>; Fri, 05 Dec 2025 08:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764952890; x=1765557690; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0zGaWdP6bu+uZrFtqustVUWUW1vb2Tudl4LtLpMgFZA=;
 b=b90FwYBKdJTqwzkQeZNIAsK91wykGuAxvljiJD+BxL1jdE/5LhQNqIC3p06gZdD+jZ
 4YJko3HsxVFRl5lWc/9R/oKF6S5+v0qiOeRyQXAWOE2RElY1KkoDkp0ZdP5SNvFMWgP6
 CTWf1xtry84qGnOPguhyEM65Ld9E4fl6siyCKpBtXgM4qA3lKrh4LN37D5+W03QGqU4L
 Mvao633AszN0kUyiIDpxCnoVBOYr/gJlGX/5ya0Yu8FOpERPdb5iKNKCFKI+8fDbYMix
 jVfEI9jGRiN45tX6MnRbkzqvosnfSym/pLlyH6ovChTaGkBYdEeC+xh91nlKdQAGylR4
 fg+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764952890; x=1765557690;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0zGaWdP6bu+uZrFtqustVUWUW1vb2Tudl4LtLpMgFZA=;
 b=bif7lffuZOQ6UWShJFLXzy8Xs4PeGW2RSyjLFPkiC9wSEdGLI64CzCm50OpUeisDLI
 bdqW1lijlMc/gbH952EQuHN9BYa6ecrsdekFXxmWx93c32ZMdpVnzQhzgW1xGz3cO1Ol
 HZavCnmfq5TRNPw3pq8frTdVCvzYhNvy6ACHK5nY2/OqWSEFvovn/V8LXLb3OhLwjJTs
 0TheouRPHQ5jXJcMAh/lVVEyUD/ZV7/k0Wd1g5a9AiKHGLuJ2axiAJx/yZCN42oiuqHO
 wlvssDaruzvHbyXX8Z2zif/VqrpsfbP/tNEZxIQfIiKeVEx6pO0VdS4fgCDbHOE7xiAy
 QAUQ==
X-Gm-Message-State: AOJu0YzEK3YBkiKARruVSx+76zyBpTH9aif7EIJysIMkr5b6foLhAfpo
 4g2JTOurNuH27Uj549GLAa1K+Dn6/0sQ27vKrHQ3OnOgldwXUq4FhAdouSCm3rjmZK2kyycaj9G
 Zm4Mz
X-Gm-Gg: ASbGnctrisITsprDTVBGMyRhQwWeaf53x+91JGXfQIk5eci/WhgfnX7tEfF09eGwzdq
 jUOKNKKSxMpZ5ERpt7oJA+sBS6zNzaqEbgwXdI+3m/K9zto9QldFY9/SunTzpP1khe/Rv6W5Mi6
 5j6+KLePjHQGUKNOacYXZhhIokko/RJ4a39041a+vYr5U3F3NsnOuYFvag4ezWjvjvpgwC+fbW4
 wiSlCkc5u/qHf1vV/mAGgM5QGw6JFq2+s+b0ckseDTVbOT1cM2wk4kdq2E5zzR1I2tksX/qNXCw
 z0hrBarkPfUQwAOcjwh2u1SrFNkiFGQ31HSgqPdkfgdVjZTo38jJ13pGP2Qozx9ghXFSJg1arFi
 JEbclt9c40dVW2kvERQDILgphPC20HUQ30tjZii5vjwkjltU7L8zdHJA6Y3PgYib24ILzHv1mw+
 ItxW9ZyGW2UcG7Vn0qVGbJFQ==
X-Google-Smtp-Source: AGHT+IHagn4U0cHIL7+f222868MfltvgxqBpqQCLm71bISCx5COqb5KLsqzSaHOLgBbO2kXUIXWCpg==
X-Received: by 2002:a05:600c:154c:b0:477:1af2:f40a with SMTP id
 5b1f17b1804b1-4792f28b98amr75580415e9.17.1764952889767; 
 Fri, 05 Dec 2025 08:41:29 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-479311e707asm88197635e9.10.2025.12.05.08.41.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Dec 2025 08:41:26 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 16AA55F833;
 Fri, 05 Dec 2025 16:41:26 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 01/14] gitlab: drop --disable-pie from aarch64-all-linux-static
 build
Date: Fri,  5 Dec 2025 16:41:12 +0000
Message-ID: <20251205164125.2122504-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251205164125.2122504-1-alex.bennee@linaro.org>
References: <20251205164125.2122504-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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

Since we have upgraded to 24.04 with its new libc we no longer need
this workaround.

Link: https://bugs.launchpad.net/ubuntu/+source/glibc/+bug/1987438
Suggested-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20251204194902.1340008-2-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml b/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml
index 98d99193457..b4c0faab15d 100644
--- a/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml
+++ b/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml
@@ -41,9 +41,7 @@
 ubuntu-24.04-aarch64-all-linux-static:
   extends: .ubuntu_aarch64_template
   variables:
-    # Disable -static-pie due to build error with system libc:
-    # https://bugs.launchpad.net/ubuntu/+source/glibc/+bug/1987438
-    CONFIGURE_ARGS: --enable-debug --static --disable-system --disable-pie
+    CONFIGURE_ARGS: --enable-debug --static --disable-system
     MAKE_CHECK_ARGS: check-tcg
 
 ubuntu-24.04-aarch64-all:
-- 
2.47.3


