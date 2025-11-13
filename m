Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B1CBCD5BBC
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 10:28:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJUWX-0008AB-43; Thu, 13 Nov 2025 05:25:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vJUWT-00081v-K9
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 05:25:49 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vJUWI-0007Ld-VU
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 05:25:49 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-64175dfc338so1151766a12.0
 for <qemu-devel@nongnu.org>; Thu, 13 Nov 2025 02:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763029537; x=1763634337; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/vImDf2hGFxVneHc+mjP6tqwz3wXsUppLPT1D+FNgTI=;
 b=OLNbSFV+5iq+Pg7o9prkERblTKqQk5cZRIyk0f6S9r1IhTnEf7Ng7UqOltV5W0p6Ts
 1WnoQuzhjEjbYj5k5m9i/7N8FkpjH+iIcmsq0Z3YcwNAD2wLvr4y3xNyEqDui07TMBH8
 M/Echp+kbcE7kRDXtc6Fo3B3LHzjjV402PZr0VvHmDOys62cT25gCOB/UvDv9UL2hrOo
 srDccNrC1Uv+4BLoAZD+3uoiRvVTPUPvlgxxkq4mZB52PaF7XTYcgoX2KJvACQgarRhc
 7NZxa1n+hpGZM86r4H2YJmI9qqSa20rO/6lPtRjI5qXItoRTWbkmll4L+mpss9vBNlhC
 ZjZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763029537; x=1763634337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/vImDf2hGFxVneHc+mjP6tqwz3wXsUppLPT1D+FNgTI=;
 b=mOjnCrozCv396Zux1wOca968CkBu65ibr/+CUc33qt/9siw5G6V0nifpx1n/Wfjtql
 GK5R1Vjz8i5TDGMqnpRMjuTTY94fBVocByXYcaFz4vVtOnduYCEt/u17irNu38UDPZdr
 WpYsRnHS//EWby8ZoL0BpZR2HKNa2smloIz/xv0kV+nN8zD+0/Hw3S3g9U6dy8CJHEwB
 707DbXlsqK5PDnuT4M80NNK1eDKjXumVDRXhysF4z7JSdfOvUWx1LwTtFgTZDJQOqG/0
 a8DStsnomqRo13afJgbmL7M3M3NtI1iIQpYwM6MD3/XpASSZNkbDsQl6yIpHpH4La5TF
 CEjw==
X-Gm-Message-State: AOJu0YwGBq38g1VbuNs18plE1Ujq75M6LUbIukXlOmX2Qc74wYTeoxfE
 5Q3x8ovj7R8a2j4KF/ZFLiColrd49t8b75fx+faKXhAOAi4aONFNdi9MC/tJQXGenrQ=
X-Gm-Gg: ASbGnct4XO00pJ+OafVoEKV5KaN16sW0C2T57pwYk0yBYor6ryCO82y+8wYcsRHFi7t
 SokpUPpmImv7Ymo3HFZ7Kq/VrUAJd3dWcBK7sxL8PMg74t1Kgyn7s0EOrUMEryStssq3zQikJlf
 GotFlQ1e86qhH7mvGbETqPogO+uC8EvloTlQuroFdoZ+JJm87xdp/9jAmyvMOniESJ9yFiYQjzE
 G0OPxgK1fPFc0bAVJQP/8VaeYE44dqaw5EqbuiP/Dq579TNnr5DMNaRa0BJ6QvzIWIOSfcqlnYA
 b2qtz2fk5U/860FAj1Q4s5vBK+0I3b35xM9gV3hdl6+NhQffou599qeSv5cI5MA0GBEvrOMk63y
 o6G5AHrjRNFqypIwPSvoSzqH4P0xu4G69XkUZ7G6uqk34v0Poq/NTNue9NmOoaKrC1rxALN8yBP
 g8
X-Google-Smtp-Source: AGHT+IEec2tckrlUyUqwxIIXF54QshFUpMVxliZXuvgaLCJUvyy2QaqWxYDeHZLo0wGauI8LL8lhFA==
X-Received: by 2002:a05:6402:40cd:b0:640:96fe:c7b8 with SMTP id
 4fb4d7f45d1cf-6431a49ab90mr5255269a12.2.1763029536722; 
 Thu, 13 Nov 2025 02:25:36 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6433a497f27sm1167660a12.17.2025.11.13.02.25.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 02:25:35 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 570BF60804;
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
 David Woodhouse <dwmw2@infradead.org>, Ed Maste <emaste@freebsd.org>
Subject: [PATCH v2 14/18] gitlab: simplify the ubuntu-24.04-aarch64 rules
Date: Thu, 13 Nov 2025 10:25:20 +0000
Message-ID: <20251113102525.1255370-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251113102525.1255370-1-alex.bennee@linaro.org>
References: <20251113102525.1255370-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x533.google.com
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

We don't need to duplicate the if rules to get the allow_failure and
manual behaviour we want. Clean that up to keep all the rules in the
same place.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .../custom-runners/ubuntu-24.04-aarch64.yml   | 43 +++++--------------
 1 file changed, 10 insertions(+), 33 deletions(-)

diff --git a/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml b/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml
index ee13587d99e..6f950baee0d 100644
--- a/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml
+++ b/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml
@@ -46,26 +46,16 @@ ubuntu-24.04-aarch64-all:
   extends: .ubuntu_aarch64_template
   variables:
     MAKE_CHECK_ARGS: check
-  rules:
-    - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
-      when: manual
-      allow_failure: true
-    - if: "$AARCH64_RUNNER_AVAILABLE"
-      when: manual
-      allow_failure: true
+  allow_failure: true
+  when: manual
 
 ubuntu-24.04-aarch64-without-defaults:
   extends: .ubuntu_aarch64_template
   variables:
     CONFIGURE_ARGS: --disable-user --without-default-devices --without-default-features
     MAKE_CHECK_ARGS: check
-  rules:
-    - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
-      when: manual
-      allow_failure: true
-    - if: "$AARCH64_RUNNER_AVAILABLE"
-      when: manual
-      allow_failure: true
+  allow_failure: true
+  when: manual
 
 ubuntu-24.04-aarch64-alldbg:
   extends: .ubuntu_aarch64_template
@@ -78,34 +68,21 @@ ubuntu-24.04-aarch64-clang:
   variables:
     CONFIGURE_ARGS: --cc=clang --cxx=clang++ --enable-ubsan
     MAKE_CHECK_ARGS: check
-  rules:
-    - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
-      when: manual
-      allow_failure: true
-    - if: "$AARCH64_RUNNER_AVAILABLE"
-      when: manual
-      allow_failure: true
+  allow_failure: true
+  when: manual
 
 ubuntu-24.04-aarch64-tci:
   extends: .ubuntu_aarch64_template
   variables:
     CONFIGURE_ARGS: --enable-tcg-interpreter
     MAKE_CHECK_ARGS: check
-  rules:
-    - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
-      when: manual
-      allow_failure: true
-    - if: "$AARCH64_RUNNER_AVAILABLE"
-      when: manual
-      allow_failure: true
+  allow_failure: true
+  when: manual
 
 ubuntu-24.04-aarch64-notcg:
   extends: .ubuntu_aarch64_template
   variables:
     CONFIGURE_ARGS: --disable-tcg --with-devices-aarch64=minimal
     MAKE_CHECK_ARGS: check
-  rules:
-    - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
-      when: manual
-    - if: "$AARCH64_RUNNER_AVAILABLE"
-      when: manual
+  allow_failure: true
+  when: manual
-- 
2.47.3


