Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0DD0C77B7F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 11:28:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uV7DE-0005GJ-K0; Fri, 27 Jun 2025 07:25:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uV7D1-00057W-7P
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 07:25:32 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uV7Cr-00078y-24
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 07:25:23 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4538bc1cffdso14228505e9.0
 for <qemu-devel@nongnu.org>; Fri, 27 Jun 2025 04:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751023519; x=1751628319; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=txtxvpFKqLbhHoA+0Zwk16dKiYOy0riI4nuHvojvgGs=;
 b=JGabJglUIZ6Ei/YISpdmEzMfk5LKZpz36KxcM2Mq8fI56aZx1pa0AcD8Y7mMBMShaQ
 UrumqKEZ7x3fBilT+wAkw94NPEGYz3g9MnscKkf0mbJEo0DkCPBcDqnKJvwi2LJU2Qtg
 i4/PrhLacGrnfsDEXU2zRxGwGkPdDWCbVgdGOGORfa5ezuBOlp0aIuvt2wH6iaHBThCv
 LrGTWjjyWKp8EZjW0fYDIbfJ6cvnzJzr0jd3iMQo5zBCsrApMRRNrk5vdAHZTOtWSZCr
 5n9BCp3Q5VwzDjWFgJ1rTzXqXXSs3JPYAdZRZJHrR5R8hW0zCVaxVnt4B7zCAwJ8aaGD
 FUUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751023519; x=1751628319;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=txtxvpFKqLbhHoA+0Zwk16dKiYOy0riI4nuHvojvgGs=;
 b=In69VWFg3xUofLqlpI9tZJ+P/+Eow26rzt3JbB+IZhmwUY5N6dPeiUJmRAsqamXv6J
 p/Wjxu4/XIt/AbuFOjq+2WXlUIxVkbp7qyMU3fljf6tdC1vtam+nUhvVV1s5QLybpPPy
 iAGeAuX9myjqAQ0teBSRcBSRw+dy73FlSXNg+RhQEJtTCa30ILeGYtZZMy+96NNYT6+h
 qjD58JxFLXhsKsDrY2LfGs7inPvbBdLO8es+wSK49D1aMUvDTLfa7EZ5DVsbFVQ32jNB
 kv1b4qUbI8FZNt08Zww6veMktR1hgJ307YA4LNkBd088vBwzSmimYUG7NNl1N9YZAPew
 6i6g==
X-Gm-Message-State: AOJu0Yz+ThaFrAixMOtf1gTr5JnR1o7JX+9uCzl42mz3z0RlbuUwX3Pg
 3rWYNSkPsp52kmdduUYqoVrc/KKYVs73SthoDX767yDB+LJ5X6wBPjwyqXVG4MSdMNc=
X-Gm-Gg: ASbGncsnlpW68oz9TW5q0HL4FXBd/MMqnbPBK/pn8oz5Y9Z1E8PSmyzGPOUGK7mPxoo
 b/Ck9C/yqH/8ggda4X52y8HaBtGbJ1445Ar2XQGUKgiFx427wHP/QRWn7FwqNNY4gIpnFSPxHgo
 AX6C72HbcnPTAztkbTfpLMUvDKxMok+XxtCXYDex9CoXXL7LITBBtVTqf0nuiOOrifA3r4Do+j+
 Ar9legqvdZAlUmBMAlL6DSl70rmwuH/OhjcI5k6Ys05Nc+3VzuCV/TgftQ5w8l9FcylhbtbxSUr
 NXP/jkfFonF20OtWQ5p5HaZy4ZoN9AlnOHxniE70GFGoL7ysbmEDve/u0UncmMo=
X-Google-Smtp-Source: AGHT+IEhVIm8vEHDZm6fAJOpOCs46al681NpBj7cp9gb0EZ9lFbDFa4bvgmk8nEGUiJqRym+ggXQ2g==
X-Received: by 2002:a05:600c:3ba1:b0:450:d04e:22d6 with SMTP id
 5b1f17b1804b1-4538ee565damr29613675e9.7.1751023519193; 
 Fri, 27 Jun 2025 04:25:19 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e5f8a0sm2478892f8f.96.2025.06.27.04.25.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Jun 2025 04:25:13 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4616F5F860;
 Fri, 27 Jun 2025 12:25:12 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 qemu-s390x@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH 01/15] gitlab: mark s390x-system to allow failures
Date: Fri, 27 Jun 2025 12:24:57 +0100
Message-ID: <20250627112512.1880708-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250627112512.1880708-1-alex.bennee@linaro.org>
References: <20250627112512.1880708-1-alex.bennee@linaro.org>
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

The system tests (usually qos-test or migration-test) prove to be very
susceptible on the s390x runners. Although we have boosted memory and
virtual CPUs on the runners problems persist. For now mark test as
allow_failure so the its clear on the CI UI when checking test
results.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .gitlab-ci.d/custom-runners/ubuntu-22.04-s390x.yml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.gitlab-ci.d/custom-runners/ubuntu-22.04-s390x.yml b/.gitlab-ci.d/custom-runners/ubuntu-22.04-s390x.yml
index ca374acb8c..e62ff1763f 100644
--- a/.gitlab-ci.d/custom-runners/ubuntu-22.04-s390x.yml
+++ b/.gitlab-ci.d/custom-runners/ubuntu-22.04-s390x.yml
@@ -31,7 +31,9 @@ ubuntu-22.04-s390x-all-system:
  timeout: 75m
  rules:
  - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
+   allow_failure: true
  - if: "$S390X_RUNNER_AVAILABLE"
+   allow_failure: true
  script:
  - mkdir build
  - cd build
-- 
2.47.2


