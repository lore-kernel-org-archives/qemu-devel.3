Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83B85E6BF1E
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 15:15:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlqDO-0001tA-4Q; Fri, 30 Jan 2026 10:15:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vlqDH-0001sR-1I
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 10:15:11 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vlqDF-0001Gi-CW
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 10:15:10 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-42fbc305914so2056827f8f.0
 for <qemu-devel@nongnu.org>; Fri, 30 Jan 2026 07:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769786106; x=1770390906; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HkBTfguhU+3qx3gphjq7Uj0bsYZ9SMsR6FjiXMeW6l4=;
 b=SNDbyBVYQf8tFWTiiGmu1AlMmQ78S1GqgPeQ8yzNb15GmiCm7qCi2t7IJgbJDVwqeE
 bXytzErqDtghoZZqmuzPF+EA144eB2+9GqP5lSZB5rj3Ftu8paPaQdrICQ1hTCDScj7L
 ZPaWsq/qitharaSMu39GnpqokJBJxnfPjgr26LX+2T+IahIIhP1n2bKg4/l6/CIrc5Jj
 z2fHGcyjiZF6YzPBNCaQROK4hoAWoE8EWzi7P0nrYlA3GqWBwKaOJ+Qh+t6pYc5SHLTc
 0MuOnv/93YbnYAXenV2R76MR4pEX0hUEPjjIrOzdJvBa2ryVnFL1K8AiVBXhwxBdCPRB
 8gvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769786106; x=1770390906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HkBTfguhU+3qx3gphjq7Uj0bsYZ9SMsR6FjiXMeW6l4=;
 b=V4zj7aDa8HDq7EY0SbtixUN+BNU7lYG+tzbMddMKFVrfMecQF3wcUUJBEdhlU+02+h
 LkRK9SWWOzPNiorQj0aNYnTBsimKeoCLCZ94YW+bRjIN1zgs//tiA0yH8tCsa3FrLOYQ
 4t8mugYTwJOxUgNhZYYVEt8YIyVzYqubEw2IJMrLJJg64swfvr2cTMrFp3cWU0MsBVi0
 lxDn3FfmJM4J4PMVfGNNWFGL8BToqQrcZ2WflkeiroAeiMVGTHmPJAFVwXB7EbTx8y9+
 g5mnLjozQxbs2l6MeZCcwR+v/6JiZQ3LYk8Vo+LSgKyVAEucb8axB4EuLu4vUkSQCO7R
 a1ww==
X-Gm-Message-State: AOJu0Yy3BMyb2Fi/A7XUGjZEh8zhEmEz9G7fXaWxiMEtz10UtIMi+qhq
 JMQPDMiWiQea5IJhNKJAH9MDkcEJrlOByy+UPyEPCl2l8X4Z1L6DHph7MXjqAjqFk4I=
X-Gm-Gg: AZuq6aKG/PuKagsw8fefVo6rN+KSvvRcTpxNtiPX1sSf5xKVnmv9V3D86dQzSCMi9rl
 +P0Tm1XrO7Ea00VdP31JLAmj68awxUV1uMnZDGOXrgxkaC+ACwU4NOJwm2j6lxhuPlaZ6EC1i80
 RiHpf0Fwv9kL1Vcbmlp6UzSGEwj4Qwg98FoSNXCIJrsI/UjmqDkxZx/SMVfPW1sbDWBEH8EqpMJ
 wPsRfiflJKTVHwSN7nIEQsEqro13hF2o6To8S3xpnChakFqiYleEkRQV8I6G7kXVRAxcDz5HaS6
 C8dloo0qhYLve0iS12YODZ/LNBzSNm3yzk+GGN6ZvYI3MGbO8zFB0GdH0JyRVhO9/kzcO+58+qQ
 tTxNRUCsQBoZGfJOuX3JAXxdclM6PqVga59N1aeqjzv1s7W2VZwzcon1qhP38ta2fNW3YaLpfw3
 8z/EpIddLmcOM=
X-Received: by 2002:a5d:64c6:0:b0:430:f7ae:af3e with SMTP id
 ffacd0b85a97d-435f3ab21bamr5667893f8f.32.1769786106197; 
 Fri, 30 Jan 2026 07:15:06 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e1354d43sm24640195f8f.43.2026.01.30.07.15.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jan 2026 07:15:05 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 80D995F898;
 Fri, 30 Jan 2026 15:15:04 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 1/2] tests/docker: rename wasm cross container
Date: Fri, 30 Jan 2026 15:15:03 +0000
Message-ID: <20260130151504.550929-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260130151504.550929-1-alex.bennee@linaro.org>
References: <20260130151504.550929-1-alex.bennee@linaro.org>
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Now we are 64 bit only there is no need to keep the generic name. This
also fixes a check failure in the weekly container build which was
checking containers based on the expansion of DOCKER_IMAGES which is
based of the dockerfile names.

Remove the DOCKERFILE bits that were added to handle multiple
containers from the same dockerfile.

Fixes: 4203ea0247f (gitlab-ci: Add build tests for wasm64)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20260128105839.3487840-2-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/.gitlab-ci.d/container-cross.yml b/.gitlab-ci.d/container-cross.yml
index d7ae57fb1f5..2a0cea6ce1a 100644
--- a/.gitlab-ci.d/container-cross.yml
+++ b/.gitlab-ci.d/container-cross.yml
@@ -78,4 +78,3 @@ wasm64-emsdk-cross-container:
   extends: .container_job_template
   variables:
     NAME: emsdk-wasm64-cross
-    DOCKERFILE: emsdk-wasm-cross
diff --git a/.gitlab-ci.d/container-template.yml b/.gitlab-ci.d/container-template.yml
index 6eaa2f804df..8c7311cca57 100644
--- a/.gitlab-ci.d/container-template.yml
+++ b/.gitlab-ci.d/container-template.yml
@@ -10,14 +10,12 @@
     - export COMMON_TAG="$CI_REGISTRY/qemu-project/qemu/qemu/$NAME:latest"
     - docker login $CI_REGISTRY -u "$CI_REGISTRY_USER" -p "$CI_REGISTRY_PASSWORD"
     - until docker info; do sleep 1; done
-    - export DOCKERFILE_NAME=${DOCKERFILE:-$NAME}
   script:
     - echo "TAG:$TAG"
     - echo "COMMON_TAG:$COMMON_TAG"
     - docker build --tag "$TAG" --cache-from "$TAG" --cache-from "$COMMON_TAG"
       --build-arg BUILDKIT_INLINE_CACHE=1
-      $BUILD_ARGS
-      -f "tests/docker/dockerfiles/$DOCKERFILE_NAME.docker" "."
+      -f "tests/docker/dockerfiles/$NAME.docker" "."
     - docker push "$TAG"
   after_script:
     - docker logout
diff --git a/tests/docker/dockerfiles/emsdk-wasm-cross.docker b/tests/docker/dockerfiles/emsdk-wasm64-cross.docker
similarity index 100%
rename from tests/docker/dockerfiles/emsdk-wasm-cross.docker
rename to tests/docker/dockerfiles/emsdk-wasm64-cross.docker
-- 
2.47.3


