Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4AC7CEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 12:05:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKxz3-0003FN-0a; Mon, 17 Nov 2025 07:05:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vKxyc-00039K-8f
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 07:04:58 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vKxyZ-00087z-9C
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 07:04:57 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-47789cd2083so28874635e9.2
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 04:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763381092; x=1763985892; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GWtPUQ+JvZ/prmIoJ1f37Bqg2O5E6FcG1RkmlqBd/5E=;
 b=UpJuSGzAislC56d4aU3cGPJkbiH7mWVnREG3grEkPXd9+5sebAKwAgOihx16T4Wjla
 ppUjousx/oPwhK0oahuax+aeUaLvZoqUxRJFOx/AUI5mYocdlYPIgSUbn7Wu89zXeBHh
 uixH2nsk5aXFRYuCx8gkTeW+Us3qTMM/XLurqnGtJE5+cjRVp/C4ycRt4LRl/fGf1Gdm
 jKld86n6MIWyjpXWgxhlcslwZjUzp7jx/G0YrEsvF0E6TfPlw1BwgwDlNUTPfzOT8qDu
 0Vq44GUsuIgCrXjm27HF3rnfwqQ/G6l4uxRBfNdB6imuCZPE9ho13cTYjn9yTYz7Q2AS
 YF1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763381092; x=1763985892;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GWtPUQ+JvZ/prmIoJ1f37Bqg2O5E6FcG1RkmlqBd/5E=;
 b=B1bi5wk6xGVUxgwOpTnT7C1ayT9XMrdYlZxzSpAkgqImF4xORMzMVjhNb8AqhzUPvF
 u4K50HwZoz821zHCtFO5lXneJKbATfb/2gQgKB8NmPtSVCKsenC/TMz/AZBT2lmOtgSa
 E93AbGaftI+MiTvf6r+IpZzUjUsA2kC1Hr6pOFdiTUYaX7xu45X69RDgf4CwrnS1l6zD
 FUI3ihHIouQLavDrbuA9g3iRNrcXGCi8flNUj48y/abXr3Ewr7o4plU1zwaF/rPYCYoz
 H8rSDVakukWQ8am2E8QwV3JigCrR/Zw8/tHQ4MpIIWjEblWwo3qWZyAzxX8OsC67L1vK
 xbOw==
X-Gm-Message-State: AOJu0YykOvRLz6qrprClYQWPonAscMmTmeEpOK7pBJYl4Hi513Cb0qiE
 c6rgp3F90bXeo5r7vzRfGB+U6VrXZA8+on0JLH3VZbntS91PZn2YO6p7D9YjbBkZHWw=
X-Gm-Gg: ASbGncv34VlFqOPHNFiwz1sVR9044PuHLGDI/CBoLSeU2MOGpR+QxOyBTwABeuCU0qd
 HFpHxBWcB5UiWDOY21W0fuBakKGzoitpZNIs1A87/QJXW7SDbJBlH8ue5L4P/UT5haFth+QuLvC
 a7vcF3c5uZQq24Fh8A7npEcFu53+YvDXoIZwA9+gf/OdqNoTzHzxFS08HBfmjaPw18CD69iI90s
 9t/9c7eNak4trpQlFRmf7lVciSMbAKJ5mFcuTjfhzpx1pJOj/DKLxnyxtVeCt2XOCb9Q1pmGkJb
 30QP/i/dWhxLuZU+VTn8zGMiNtOMH4YMajjgZ6UeHA8HXrFWYRufv13MeNmyhEM10V6Z2njuxzk
 VABttVAhLm64w5HEQcpqBlMy9rTD7vrWYFq1iMsrnWu4LXlRh3OyIPRUepF0vs0L2QuNHiS6b6Y
 fFlVt8t3xgCGs=
X-Google-Smtp-Source: AGHT+IFCwmelVS+JD/DBlQuEeW3Kyn5qMTw18g9IFSJsT9L+Y5Lb8F8HDxSjBLpCLzq2O4hv0SUbkg==
X-Received: by 2002:a05:600c:3b19:b0:477:8a2a:1244 with SMTP id
 5b1f17b1804b1-4778fe5c5f9mr108077645e9.11.1763381092058; 
 Mon, 17 Nov 2025 04:04:52 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477988060e8sm59902035e9.5.2025.11.17.04.04.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 04:04:51 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F4016609ED;
 Mon, 17 Nov 2025 11:55:25 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ed Maste <emaste@freebsd.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Thomas Huth <thuth@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, qemu-arm@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 17/18] gitlab: make the schedule rules a bit more general
Date: Mon, 17 Nov 2025 11:55:22 +0000
Message-ID: <20251117115523.3993105-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251117115523.3993105-1-alex.bennee@linaro.org>
References: <20251117115523.3993105-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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

By default no jobs should run under the schedule and then we can be
more explicit for the ones that we need to. Otherwise I trigger all my
custom runners every time I do a scheduled run.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20251113102525.1255370-18-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .gitlab-ci.d/base.yml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

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


