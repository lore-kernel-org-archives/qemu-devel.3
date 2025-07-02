Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 093D7C7EE30
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 10:44:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWuwZ-0006fv-HX; Wed, 02 Jul 2025 06:44:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uWuwR-0006e0-Gg
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 06:43:52 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uWuwI-0001IQ-59
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 06:43:51 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-ae0ccfd5ca5so603056966b.3
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 03:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751453018; x=1752057818; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D4wxQdFgaAl/kwo8ASXJ9vsmD0ZBYPLir6xKV4La3T8=;
 b=Mqa6EyXsNXj82/gbQboh9HEgxi5tjk5VLYSdrV3FI83gkmVier5gjPA11QgTthIvXz
 mNV+iGRk0vSD/X1v4yahYDaFH3r3TsYGBnrOlNxkJwgNUq4zQ+Anv0OuA14AF0k7iryy
 Z0Fd0MHC6FSNywuAN28yZE/sZjAXaEdNHbhZY8FrV93W9QXVo2UtH7XmbYGWa0j/ZMQH
 L/6qmczRqiL0xA4lVLOlz35JQYTzyygorqvtJpPjTgCscG4g0qzVkhMJp/fP0yYllohB
 ffk4HBDnnaJlFbEZwHIxmz64PnCup3wWxB5TK/NX0lM6L7DPi766fC/NBqKhFvdWUePC
 8deg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751453018; x=1752057818;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D4wxQdFgaAl/kwo8ASXJ9vsmD0ZBYPLir6xKV4La3T8=;
 b=uCs8WNTSiFNzV9SM+nUfA4O1EiRt1cuwtJoHg0YDclvXcA0Gd345um6JIaIgrpHmNy
 FS87MhFlSXugTZNSxPh29XnbTKlNu9F+QOTaFTu6EM/o4h9BOwFWyiNafswVF+GkN5Qs
 fjeIsUBEFrn7G4r5jwhYQcKGQMe9Mvs1ZDr1afMB38s+M8tSvfbSWf2Tc3MlU/mG0dc6
 m+O0uM1jFdM4E+VtoVc4vY+eSOTuhTzx21xS7Juq9nCuLLV6UIsNo3ibJA/qUK5rqBDf
 X3XZOE1HEe6An6Ar+IlRvBJJYVN1yKAp5Aed4WXjmlr92lEi7tuoExlT1CcQ8DwmPW8+
 J7dQ==
X-Gm-Message-State: AOJu0Yxa0IIA7/Wgx1ZabFTP8IudWiRqtdqz8HiDEDKZjnz7g/qCfOBk
 1WwE5O9fvrsESt/U44mK5ttDQ2ocbO+u2LS4M9uojyYdHvu1stUG0zZy/8VpDKhCIFgyhhnLJm3
 7104QeKc=
X-Gm-Gg: ASbGncvdxowJJf+cNBaxj2boCli6KzQoYK7tKj6Jevyh2i5gOPnhDOqeFaG6Cni3xkg
 BkZ4R151DvnMZq5F0gg5fTxQzAE20BRXdeJ1B2E33Z3rh5ynQ1kOW4nKezERfxv+bBOclQ5sO1C
 9YTxbMABRl4ekqEiXZttoS51uaHxkL/nCeirskZwZD7dhxJpsDfw4kMswXtVHINqEKbdBQ1DXxi
 8TSFzNHghc9vedclIQRDhAWl4Kl8orDFYRySXVy/mqEBD+ai9UgCcVSY2UzUE5l/JuXig1lBMdk
 d+bkqlifwkRx1dJzXgqHq7vmxeO5UYhy4rqiTm1/hHDd5b4x9aQ7krYYjYM9Ixs+C81lQbk3gA=
 =
X-Google-Smtp-Source: AGHT+IGhizsv7EuZB/OZ4VjjrIeCLCYCs86E2WG6PyvB5pniwtCqfq4oSAE21h7HXux0SoluE0y2CQ==
X-Received: by 2002:a17:907:96a8:b0:ae3:6390:6acc with SMTP id
 a640c23a62f3a-ae3c2c02390mr253811266b.27.1751453018328; 
 Wed, 02 Jul 2025 03:43:38 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae353c6bea1sm1055953866b.146.2025.07.02.03.43.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 03:43:37 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D20005F8CC;
 Wed, 02 Jul 2025 11:43:36 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org (open list:S390 general arch...)
Subject: [PULL 01/15] gitlab: mark s390x-system to allow failures
Date: Wed,  2 Jul 2025 11:43:22 +0100
Message-ID: <20250702104336.3775206-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250702104336.3775206-1-alex.bennee@linaro.org>
References: <20250702104336.3775206-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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
Message-ID: <20250627112512.1880708-2-alex.bennee@linaro.org>

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


