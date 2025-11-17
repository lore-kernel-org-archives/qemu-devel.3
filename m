Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19C03CE8D6B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 16:01:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL1ew-0000o4-IO; Mon, 17 Nov 2025 11:00:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vL1e5-0000WV-Px
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 11:00:08 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vL1e0-0001QD-Qd
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 10:59:58 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-42b38693c4dso1982011f8f.3
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 07:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763395194; x=1763999994; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VPocHTMce2ZquThh4geYRtJxROYwjyITY7vsP6Zm4RE=;
 b=c/3UclCPebMwdNdkwMCOzW85VIxcIhX6qQzljsdKYk3TcTgnKfKb4r0zf7E5ZvILJh
 p9W/GF0D4ZeCppVQtvpiz0Avcn4zhzo1Gg2I69PL/BuTlPZmOZbekYjYl6d5lFbPVHLA
 tp8pZL7vpEG47BXKWLZ6b6cXm/y9Q6iI7kQVC514vQ98Pz88eR7Jff2V7saBAWIXyI0Y
 Fa6QIu5pIRxMX0Qa+UqZtVXTHjQG+84st4x7OIH5iGjeBakcLAZECJ96q5nsiRwh5+wr
 9TQQvBYLNSjpXQ4bJNAVOrXVUmU6iXIcm1hoMtti6WcjbeRRHwnoH++wttpQi3Zab9bE
 enPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763395194; x=1763999994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VPocHTMce2ZquThh4geYRtJxROYwjyITY7vsP6Zm4RE=;
 b=IbRkmQ5a0RrUYA2d5VISiXPPOHG3zEk7WV2DKypDzXlMCODPtmRIa/J2jaUXhG5l90
 bH4SaDYMvHz5OesS77rN55somwHFG4dJ0MYn011vjWiwf05EKiE5vie+PPb4W4XqZDe6
 89icGITCb92F/H0ZumxhP93BWfH0hl/jP6eaL57M8mjPqqCGWo7hnvAPXOki1WMdFNCp
 zSwOprLLsGKX5QrqWZsFrGVWlN0uypOB3xKoJFlogiI4VOX+viVUpOSrTg68SWvHLHgj
 AJlqhQ68DUzlWJEZHMDmgsjgdcu22jVEgZRYpex4GLLZJx8Qw0PVzAqnHdo7yPe7ziL3
 rEkw==
X-Gm-Message-State: AOJu0YzPseAUVGWEMnq79vmBlqrpcnOLk3wb88TxuErVzZ+JLwu+Zsdj
 XLO8HZsBdPwleqx1NBsDxQsuEmKTcSVr9FofNLQNav7HqRnLN2UiGdTpWzI6GWy941c=
X-Gm-Gg: ASbGncsIkHA5iJ4lDzegQtEPPScGWMPvvPY6wABhbHUAlaUiPW6FhnyouZUtxXMAsLy
 U9DvilMwBiUXPfl3644fUwD8CsBoYxTHcyJ/JoMahvMsBiCSv61rN4amAGZdnwtqdLU8SQrPGVi
 KOqBRLp6hcF+oWr+qK439G0JWP+UI3dzkLCQKB2nXySlzVthNZ5es/t1yTmXvIsXVeolpGIRHhf
 u67RLbm9SKVN2yb2SvxS3PHU/+n8fshWyDd59gDLN+VCJlcoT0CH5opLKA0fAtvOh6kQMc3K26t
 3fkKHK/UdFDtKEafC4iUQRLM6cJma9LCL1QyBkJDZcnBHt85nk4ssseo52MUiWNu8aG3yghGpPh
 Ft+gnqqAsi4g6qA9wuEYSS6QqcXUEzlyAFTWyKlpWGOZaVSJQYvssDeOC+bZM9ojQGfLbR2Cfr8
 mALt4pqTBjSxM=
X-Google-Smtp-Source: AGHT+IE2qNr/q30ebycmhMlceAGc2dajThHvJTU7MJ5qh87QI3nwZsyZCdscUI0PK2zOi8h7LAHF+Q==
X-Received: by 2002:a05:6000:3109:b0:42b:3b55:8929 with SMTP id
 ffacd0b85a97d-42b5935040cmr11772863f8f.19.1763395194100; 
 Mon, 17 Nov 2025 07:59:54 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53f17291sm26858932f8f.32.2025.11.17.07.59.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 07:59:52 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B7FA05F76E;
 Mon, 17 Nov 2025 15:49:49 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 14/18] gitlab: simplify the ubuntu-24.04-aarch64 rules
Date: Mon, 17 Nov 2025 15:49:43 +0000
Message-ID: <20251117154948.4122164-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251117154948.4122164-1-alex.bennee@linaro.org>
References: <20251117154948.4122164-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
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

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20251117115523.3993105-15-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

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


