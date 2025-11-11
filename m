Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FE53CCFA1A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 17:23:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIs4f-00032L-EN; Tue, 11 Nov 2025 12:22:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vIrzz-0005po-1J
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 12:17:43 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vIrzr-0003yj-Kx
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 12:17:42 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6419e6dab7fso3276414a12.2
 for <qemu-devel@nongnu.org>; Tue, 11 Nov 2025 09:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762881454; x=1763486254; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2QDQ4kffpq2WZHg9gsRHpbpFNV16GXaUIYy7pK8ULY4=;
 b=t77uAlXEU8RqYXqcuLkxB1j4QpLDLNz+n/J8weORceSgTaLqmW3R7XmIpwHXYj4SIS
 Pj1+inHBMiOwJUagIayeBVninHQdBslWaKj9ThbQWO/eNKEzecVyXT1nfk6qV4o0EdzN
 c9wIcrkzBLS/wg7tCU+WFKENnNJ6z3VQz0MyyIXzaR0p8b3kdnzv9KdI/xYyCqCOCoi7
 t6WSqYqW+XBqzCd8zk3+y5mWo+VpkghMzMmU+bQYwUWODcKO2Tfn3wAas2paOD8ohQDN
 r392Bvfnv5XPRZTciCeuIQ00nh3O8TnL3TOxVVA0z7O/6HwOofqTbYXLGiR1KBSrMLVq
 TV/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762881454; x=1763486254;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2QDQ4kffpq2WZHg9gsRHpbpFNV16GXaUIYy7pK8ULY4=;
 b=XxTR/YycGQtBgO+WPrSKPrEw3TK3XxiNMvoY9ZXjUxOwaS6w0oRKTvDtP90rh3Mv3O
 TlLjTyEdQyUR/0xsyQ7FyynCTxbufk1GmRJJGHtXwEJc+PsOlJqhH8VU/1S0+RLai792
 6rYYJNVzdYlBVTwIBK1uq9Ni+l8xv8ltNCXAcmbx14jlgbWxQFQ1kjM74aRgij3C1/L/
 WRHsiRI3rs+UrFpcjWUdnHtdCbkw2dQA5gto3rEPnoPrJWqYsPvnFg6t0ysdCAqKojiF
 RR5kAUklYjIn4OZbm8Pg7chFttXTf0dSr1NkVPU6c4cWtG4IUIRHk3Wit1ngOJ3JTCqo
 0Ujw==
X-Gm-Message-State: AOJu0YyW3nqdIs8OqqXyDkrQsbnWt3DPl3B+jaWMGro2BxDb2YppczAz
 nGUYwfMGPhz+v2qpucpx2nXmCc2qgXVyZOeNEVmsE+eexycyiliJjNXGN5oayAZOFjU=
X-Gm-Gg: ASbGncsuUKLu+j0twuVdp0+7kMXur6qKGOzwFuaHO6lqn7n5Vbnppp0sEXpuR/mN9v+
 uGDmgquAfhRgWzKORBmKLMKUnhgiri5ysgOMlgjQP1o5z1iOIWitmb+XQ3tkuvs6yLBXFQvjCUU
 ov82G9ebHeAqKVnljgbSrZgD3unPzwvIgB1Zjo4aHUS0GfYVdHI5IwP8ofcP2zrJEz2X5NnuaIY
 hrLISibP3En2JYsI5Zyn3u2ogMkcmm5WUJGtNab8SO+f4cD6mNQSqsx0PgRiVmx0PmzQ0KH21r1
 Q74PR9QMyxlrLTnmMO+BqN2pg67V7tWU5CaTkK/9irEIaCZmajfVrQksrx/1FWUaJXtkuwDThbo
 IlszVxKb7qNONFF8AepKvvXUonkIuCtPX9leYCipSC/rAVcAwTuY4DSgrdVDZXx7CPl6fpOphA6
 DiQQowJv3oWro=
X-Google-Smtp-Source: AGHT+IE+RDj0TwfDoOTOklwVl+Igl7p37eF5Bxw8scuz9kTvOQEBuwZ1beKkOlM6q7bqG6/P92dsNg==
X-Received: by 2002:a05:6402:40c5:b0:640:be87:a858 with SMTP id
 4fb4d7f45d1cf-6415e80a8d3mr11552134a12.27.1762881453962; 
 Tue, 11 Nov 2025 09:17:33 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6411f862cd7sm13899520a12.30.2025.11.11.09.17.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Nov 2025 09:17:30 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DF83D5F8FC;
 Tue, 11 Nov 2025 17:17:25 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Ed Maste <emaste@freebsd.org>, Paul Durrant <paul@xen.org>,
 David Woodhouse <dwmw2@infradead.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Thomas Huth <thuth@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Gustavo Romero <gustavo.romero@linaro.org>
Subject: [PATCH 14/16] gitlab: suppress custom runners being triggered by
 schedule
Date: Tue, 11 Nov 2025 17:17:21 +0000
Message-ID: <20251111171724.78201-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251111171724.78201-1-alex.bennee@linaro.org>
References: <20251111171724.78201-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52a.google.com
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

Otherwise the mere presence of the RUNNER env vars is enough to
trigger the jobs.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .gitlab-ci.d/custom-runners/debian-13-ppc64le.yml    |  2 +-
 .gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml | 12 ++++++------
 .gitlab-ci.d/custom-runners/ubuntu-24.04-s390x.yml   |  2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/.gitlab-ci.d/custom-runners/debian-13-ppc64le.yml b/.gitlab-ci.d/custom-runners/debian-13-ppc64le.yml
index 6733a8e0dae..9d87268194e 100644
--- a/.gitlab-ci.d/custom-runners/debian-13-ppc64le.yml
+++ b/.gitlab-ci.d/custom-runners/debian-13-ppc64le.yml
@@ -11,7 +11,7 @@
     - ppc64le
   rules:
     - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
-    - if: "$PPC64LE_RUNNER_AVAILABLE"
+    - if: '$PPC64LE_RUNNER_AVAILABLE && $CI_PIPELINE_SOURCE != "schedule"'
   before_script:
     - source scripts/ci/gitlab-ci-section
     - section_start setup "Pre-script setup"
diff --git a/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml b/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml
index ee13587d99e..86bca7800ea 100644
--- a/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml
+++ b/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml
@@ -11,7 +11,7 @@
     - aarch64
   rules:
     - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
-    - if: "$AARCH64_RUNNER_AVAILABLE"
+    - if: '$AARCH64_RUNNER_AVAILABLE && $CI_PIPELINE_SOURCE != "schedule"'
   before_script:
     - source scripts/ci/gitlab-ci-section
     - section_start setup "Pre-script setup"
@@ -50,7 +50,7 @@ ubuntu-24.04-aarch64-all:
     - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
       when: manual
       allow_failure: true
-    - if: "$AARCH64_RUNNER_AVAILABLE"
+    - if: '$AARCH64_RUNNER_AVAILABLE && $CI_PIPELINE_SOURCE != "schedule"'
       when: manual
       allow_failure: true
 
@@ -63,7 +63,7 @@ ubuntu-24.04-aarch64-without-defaults:
     - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
       when: manual
       allow_failure: true
-    - if: "$AARCH64_RUNNER_AVAILABLE"
+    - if: '$AARCH64_RUNNER_AVAILABLE && $CI_PIPELINE_SOURCE != "schedule"'
       when: manual
       allow_failure: true
 
@@ -82,7 +82,7 @@ ubuntu-24.04-aarch64-clang:
     - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
       when: manual
       allow_failure: true
-    - if: "$AARCH64_RUNNER_AVAILABLE"
+    - if: '$AARCH64_RUNNER_AVAILABLE && $CI_PIPELINE_SOURCE != "schedule"'
       when: manual
       allow_failure: true
 
@@ -95,7 +95,7 @@ ubuntu-24.04-aarch64-tci:
     - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
       when: manual
       allow_failure: true
-    - if: "$AARCH64_RUNNER_AVAILABLE"
+    - if: '$AARCH64_RUNNER_AVAILABLE && $CI_PIPELINE_SOURCE != "schedule"'
       when: manual
       allow_failure: true
 
@@ -107,5 +107,5 @@ ubuntu-24.04-aarch64-notcg:
   rules:
     - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
       when: manual
-    - if: "$AARCH64_RUNNER_AVAILABLE"
+    - if: '$AARCH64_RUNNER_AVAILABLE && $CI_PIPELINE_SOURCE != "schedule"'
       when: manual
diff --git a/.gitlab-ci.d/custom-runners/ubuntu-24.04-s390x.yml b/.gitlab-ci.d/custom-runners/ubuntu-24.04-s390x.yml
index ef8db2750ac..69f10198725 100644
--- a/.gitlab-ci.d/custom-runners/ubuntu-24.04-s390x.yml
+++ b/.gitlab-ci.d/custom-runners/ubuntu-24.04-s390x.yml
@@ -11,7 +11,7 @@
     - s390x
   rules:
     - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
-    - if: "$S390X_RUNNER_AVAILABLE"
+    - if: '$S390X_RUNNER_AVAILABLE && $CI_PIPELINE_SOURCE != "schedule"'
   before_script:
     - source scripts/ci/gitlab-ci-section
     - section_start setup "Pre-script setup"
-- 
2.47.3


