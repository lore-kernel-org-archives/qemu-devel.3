Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 902E0CEBF61
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 15:55:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL1VD-0003xu-IT; Mon, 17 Nov 2025 10:50:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vL1US-0003eN-8A
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 10:50:13 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vL1UO-0007zd-SD
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 10:50:02 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-429c48e05aeso2685217f8f.1
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 07:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763394599; x=1763999399; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZxOA8K37oMKBuFRoD1DV4AZeTuJKB37x4dFLBjKeJfc=;
 b=vP7SLwLF63FYAe77ylm252FZGsrvyjdFouGsqd0rPzgE+t2DrCUd6nhvMpOlyrlRf1
 wZSmkqWy/oOiZqu0UyluGj8IOZE7MPmI/0O8Yskg6smtCD6dnoWkcZ6B1Lb1izncbV0z
 ka6wRSXnTVVtZKphumzjMGJb0vgnFmZ/0vDHwuHbrlZPt1qHdAmYyW4VjXOTduEe7st1
 ECy0cl3dl/8Wi+/4ySwG4V0hyiysXhD+eXmAHy3JADbtmqr3FUHKwhZRNJLJf/MP4pXj
 zpDucjhp5a8R4ihsen46Lr+19Ui9Dalr7GeL6eVcuonxZTTjRUsldOyrs4sbSjKUV9oZ
 58Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763394599; x=1763999399;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZxOA8K37oMKBuFRoD1DV4AZeTuJKB37x4dFLBjKeJfc=;
 b=G6ziGvw4atcWj2jIz2+rcJx112kBEY1/9T7EPRNT4/KlhhxSE5iAN4fCSv3a/iRt6E
 Ef+iAQ0mZSMef4UUrFNp7b6RlCZDtkvdtEnfKboiZv1j9SR19BEoSEb+onXxP3aGrpyS
 tDXK3HKUdLZav67TvkHgxC1oXtTKbhivskk0gm9aWVajRt/nnWKNbww4YkCHUDKt4zIt
 6j4rFV8Xr1F9y+7e3lEljug8R6Q8g6XdzBV4/OlEFyHEnD/McUZxLyg076A9Kb6oK1JX
 b3RSChj4zN5m6cKrcOTYAtsEs2JOlNk54KnaZM440rEgkF2aHUYxCWSnKEvredK8bzL6
 mRxQ==
X-Gm-Message-State: AOJu0YzwsDkhrvo/7lT1azZvlc7k+BhKDu5v5untUXtXMszqHE0WOI7q
 hFD9iux0BuNYIUudX8ySv7CYaX07aWuGX56XQyX5EzmSIYZNjcZQg9djtRbCV2Wf7mo=
X-Gm-Gg: ASbGncsF22tIgm1233WIYdXPWku+stmz4cS6gAiAW5h1orJzGuNEKYDXICcxL/g2fBm
 oGzf1RUjAeKugjRbTmSBB/DffdKOibuPJ+mSLChkn7qSQGOqZjA5e9/tftazsBz9uxY+N9DRUwi
 fWyskYikJjoYYYmo0dgw2I+UiIkYrfsefAXvqDSmG8DpcBXRLt3DoqgjZlYFNb2fglRROBQhalO
 gJq7AkOxeTSD8qN5WiVsgdVWXi0LuWxv51ceadEHIBjip61/pxfAYyYQbNqYimRwEJyEyuJOFM7
 Jrqzk0RW4Q2Xup5WwQr9L9rPrDYiTD1Fe+5rNzXpUhgNLCYzZDlm3095nFp+hNwjjwlhFh7Dkq1
 L1TMAQu+yHzHSN2UpRalt65oEmc9772i7QETfFDI3GQuEl0t+AuX5jA+BW5f3402HkeCOHcx8H9
 2dY1d/gyHjvZg=
X-Google-Smtp-Source: AGHT+IGex0etjWIWHBLeOVUlCxQjYIFklNqCi9KLBU7jereDCv8koUq3JttyTd2LSdqyBeSR6kN19A==
X-Received: by 2002:a05:6000:2911:b0:429:cc35:7032 with SMTP id
 ffacd0b85a97d-42b52821778mr17468407f8f.23.1763394599212; 
 Mon, 17 Nov 2025 07:49:59 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53f0b617sm26577444f8f.31.2025.11.17.07.49.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 07:49:56 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0B0AD609CA;
 Mon, 17 Nov 2025 15:49:50 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 17/18] gitlab: make the schedule rules a bit more general
Date: Mon, 17 Nov 2025 15:49:46 +0000
Message-ID: <20251117154948.4122164-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251117154948.4122164-1-alex.bennee@linaro.org>
References: <20251117154948.4122164-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
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

By default no jobs should run under the schedule and then we can be
more explicit for the ones that we need to. Otherwise I trigger all my
custom runners every time I do a scheduled run.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20251117115523.3993105-18-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/.gitlab-ci.d/base.yml b/.gitlab-ci.d/base.yml
index 60a24a9d14d..921c5620008 100644
--- a/.gitlab-ci.d/base.yml
+++ b/.gitlab-ci.d/base.yml
@@ -45,8 +45,8 @@ variables:
     - if: '$CI_PROJECT_NAMESPACE == $QEMU_CI_UPSTREAM && $CI_COMMIT_TAG'
       when: never
 
-    # Scheduled runs on mainline don't get pipelines except for the special Coverity job
-    - if: '$CI_PROJECT_NAMESPACE == $QEMU_CI_UPSTREAM && $CI_PIPELINE_SOURCE == "schedule"'
+    # Scheduled jobs should explicitly enable the run in their job rules
+    - if: '$CI_PIPELINE_SOURCE == "schedule"'
       when: never
 
     # Cirrus jobs can't run unless the creds / target repo are set
-- 
2.47.3


