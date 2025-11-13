Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C144CD5BBB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 10:27:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJUWY-0008En-LL; Thu, 13 Nov 2025 05:25:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vJUWV-00085s-7K
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 05:25:51 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vJUWJ-0007MG-Jt
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 05:25:50 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-64312565c10so954768a12.2
 for <qemu-devel@nongnu.org>; Thu, 13 Nov 2025 02:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763029538; x=1763634338; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ookYlMgqelv1akkEQQg8dNQyfrcFRJWhuosml8n/iQE=;
 b=O1QOPGcAH39RFJfVQSbVnf4SB01xUIrFcIqmNSKdN4AsX2zgL22d04XJqKIo94vfzs
 enrSQqnMU4VCR4gMB140xfbLePOYq1G2yU0b1KHKPaGblmebFGfT+4T8WYZoQhsm+toT
 Sn52pnOODrsduK593eri7bqv2lo7I90jrrVbXKF3fHu4BsKrzRlYVrsejoC9VOm+ydhn
 d51OyfEqhWgenQhiJ6RgqBW4Kxx/Vlf2ecwiSkZ+QgGHYkJYvm+C7in+y1gfyzthGDS2
 Lvhwn/whodUoVN7i+f/c9Fc/qZLtR67CrQ3NQI1lXjdZpRGEu6hvTY3YkBxeIIqNVQid
 5UvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763029538; x=1763634338;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ookYlMgqelv1akkEQQg8dNQyfrcFRJWhuosml8n/iQE=;
 b=TPeFCNDOi7M7jakmv7z3VG6ZY5vFXS6kr/HZGsF7M+iVpwzTy5HM39bviSUNYQ+eJI
 qYCLnNobKoVNp695dLNiq5glPmG1ezy+OlwfVR2u7obefSyfCc08tBunUSyrq7jV9+LZ
 F2dAJYKSv8EfQKzrlIO5BSA4a1G2ECEOaNlzl1inULihSwlNsXYZ8791zjQQXvjyPoOV
 XiG8FHgfhO9HaprNccFSJHNzTIS2bbKuux+k5wVqUyQb4iwYpfgz3hKEmFGi1/OGQGjU
 BB5JCx+ra/8Ijf53HbVhvLhFE4PmwDT7VxkYf26La9YVHhmoIzOJSr/o5L1PEgBf9pG7
 ZzqQ==
X-Gm-Message-State: AOJu0YyrVcTe6Qp+slvr18YuWT5iAnfNT4jLLmmkkDev3qQEw5MEaCdr
 Bsch0xq52AuqQYS5UrPX47TPowDI/TDY3e7q0LGjtS62Ay4p8NwwUwz4eQLjRLA+ZRA=
X-Gm-Gg: ASbGncvjbl5ts5PPMRTFML8DwW8hqoKj4TsExQnrbVWJ6VCgGmnCO6zjAeJHCdcIDcZ
 l7F6N5+N3+fi/17XYV1zIw3jzLn41XAK0KB6Uixh4xrvYI14ddaDHh0yG2cJXMSmau+LxyEMm4S
 pKZrwj5ttGUA88VkDEsqjkrkniVVs4pkuthkYW6gxCKgZKYZKTv6Lit/xUXH/oZACshEFhsD/VF
 yEdF/IBDw0Oe2yPp7ebjM7Qk9l8C0l6vqmrGPHgTVx+Gs28Wvg94uvHAuKHlXlI1AUM2hlU2bqY
 EgLDY030ZDVAPSHipudsk9gXMOnBn9FPsxGAD+j6EDbEtITjA5T0NFT2DtlWEkD+RWOX33nR4Tu
 bO4jEZXHjF9SeyRt8l33VEoN9P2nwLFNtlOuNKOmszMAmoUm8h/g5EelIlvZ4gl/DpRZWZVBI3r
 Sr
X-Google-Smtp-Source: AGHT+IGN5rn3IkITx8pU1gBFIPR+aCxJh/HcSkRUTXui4DXx/wg0EFxNep2T6leo1ZgNotjn3qcj5A==
X-Received: by 2002:a17:906:730f:b0:b6d:5363:88a9 with SMTP id
 a640c23a62f3a-b733196865dmr595103066b.9.1763029537912; 
 Thu, 13 Nov 2025 02:25:37 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b734fad43dfsm135287366b.20.2025.11.13.02.25.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 02:25:35 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7057A60DA8;
 Thu, 13 Nov 2025 10:25:27 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paul Durrant <paul@xen.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Thomas Huth <thuth@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org, Li-Wen Hsu <lwhsu@freebsd.org>,
 David Woodhouse <dwmw2@infradead.org>, Ed Maste <emaste@freebsd.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 15/18] gitlab: suppress custom runners being triggered by
 schedule
Date: Thu, 13 Nov 2025 10:25:21 +0000
Message-ID: <20251113102525.1255370-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251113102525.1255370-1-alex.bennee@linaro.org>
References: <20251113102525.1255370-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x535.google.com
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

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .gitlab-ci.d/custom-runners/debian-13-ppc64le.yml    | 2 +-
 .gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml | 2 +-
 .gitlab-ci.d/custom-runners/ubuntu-24.04-s390x.yml   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/.gitlab-ci.d/custom-runners/debian-13-ppc64le.yml b/.gitlab-ci.d/custom-runners/debian-13-ppc64le.yml
index 80706c7a956..6492d013de8 100644
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
index 6f950baee0d..c8adb8171c0 100644
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
diff --git a/.gitlab-ci.d/custom-runners/ubuntu-24.04-s390x.yml b/.gitlab-ci.d/custom-runners/ubuntu-24.04-s390x.yml
index 32e12188873..fcb49ae884d 100644
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


