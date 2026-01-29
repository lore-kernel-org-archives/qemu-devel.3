Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54652D6101A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 14:59:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlTUL-0006OY-Eq; Thu, 29 Jan 2026 09:59:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1vlTUK-0006OP-Ec
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 09:59:16 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1vlTUI-0008Rf-KP
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 09:59:16 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-81dab89f286so544643b3a.2
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 06:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769698753; x=1770303553; darn=nongnu.org;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yivPCZj7fslW/z8Bc/1Iycw3YFsb6mN5KgOeLh+mWhU=;
 b=CWOvdeii2i+VJF52ILSGDNF1aJA5hf3KhkXxqOObEnfVMyBz7sdPHOkyVUNtZ5/1uS
 2TX/9bc5UDLPR52Wim39GCZZ7EUHsUwo3q7ZARxqYlknC8V/XDxMAJ7K7cqc2OmJY0Cl
 ALvoEGiysg9sLlc8Kntaj3zlK0JWlIaURUXIzgQAoC2Rrt3fnGaJxex3KL7Kt37ZVIrp
 WfSdTSQYM87pu3+jUb4e8hk2bW5yqzDu+Klmm66SzWlhF9edAWPkI3BFdGQja6lk0o8V
 RTTU5/B3fnpvuZXEza6IM/dr7z5wOfhwOCwRqb/CbpGFJ0/bO0sbnJG0kHDlaVBaYju2
 MU2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769698753; x=1770303553;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yivPCZj7fslW/z8Bc/1Iycw3YFsb6mN5KgOeLh+mWhU=;
 b=JUY0mJHaGwRs+jsaq/pgoQj+Bf5mCr0ByVwqXAfwf/UYEFupwBI+ZBMUsRzcCk3Muh
 TR9TSkBWN4nY95++4kqvR9x+QM5jQpkqlM/FOVd4YRwHe++KRSo5IWav4jf+KJI74Dz2
 EYHHq967xtkm300omYjJ4YseSiZPOxXwnsFnvVwt7uYcxL9RBvy1U70h+J16N4oBpzP/
 BTe5S53UqsPjcMCAjzNYGhjSgnXZidIDwNtyz3N+FkhLk52d04IqmI0WUs6gYtHhdqTr
 b/mdtzMG7O2SlLxLkKysdc6CVePx9EvxVoz6uBz9hNzPPDB9rVGNjFFmNA6PqaY/MjLc
 sDpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvi+mOff25vLXiOQOBju2+id2sjHUTzbvNXl+H2vZgX/Li1+THTO4+UvxfV4+cGyi7OCCENLypuCYy@nongnu.org
X-Gm-Message-State: AOJu0Yz7YPZF2NR2CmQlEsTGCUTF+7Khzh0nwq30Gr4nMp3l7krZ+uPZ
 6oZKvM/OVn827mv8BmGcwQnuc8otCLlXn+aZ9auXmFAids+WFUs58ODH
X-Gm-Gg: AZuq6aIYUbWIsnKtGZbvPwESRouZDxMEtIKUXalwP+050uJ8N/cIEfx7iaGNMUORN5R
 GJ+VtLoTv05WmDlIs28xNTcnVpoEm8INH44xFAgcTwlqZoetn/NJgIcWH942brQals7xnWPBwB2
 cUzojyRpFR6P5sV3HX1iRZPwkaGNvtvSPCFXRKgUXrdgki7Bb/lWK7qyPKzuELOR8/StuvMujpI
 3OO5U8LKiWGpUBh518Y6r7Eui9d4fGIQMHBu0Ao/0X1cvamGCbow3dfpXB4Zwy0xtxTUrKce0yr
 lr+ZQVe2RXBtduBQJUlho2wj8DmLp3jaEWSFQAcR3hIu3/YaBwtEDy5OGr3zRWJr+hqNExv3khS
 tfp+12BxhVRugW/198BNt9tFz67KrB5JNEQWlg2j1SNa/U0xC8jStXNk56RsWRX1kF9ZVE9hhBL
 F0daf6JB0J18iG2mGnJmCg0YZlj4Qc5ONu+ObOYbShXAeeovWbqcVtjR6dBA==
X-Received: by 2002:a05:6a00:14d3:b0:821:7307:44cf with SMTP id
 d2e1a72fcca58-8236916f853mr8245258b3a.15.1769698752719; 
 Thu, 29 Jan 2026 06:59:12 -0800 (PST)
Received: from ?IPV6:240d:1a:3b6:8b00:7e35:5def:769a:b72f?
 ([240d:1a:3b6:8b00:7e35:5def:769a:b72f])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82379c22459sm5567860b3a.48.2026.01.29.06.59.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jan 2026 06:59:12 -0800 (PST)
Message-ID: <c63c7a2e-0a68-48d4-872f-706cc7d2bb2f@gmail.com>
Date: Thu, 29 Jan 2026 23:59:10 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: alex.bennee@linaro.org, qemu-devel@nongnu.org
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Subject: Re: [PATCH 1/2] tests/docker: rename wasm cross container
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi Alex,

Thank you for fixing this.

 > Now we are 64 bit only there is no need to keep the generic name. This
 > also fixes a check failure in the weekly container build which was
 > checking containers based on the expansion of DOCKER_IMAGES which is
 > based of the dockerfile names.
 >
 > Remove the DOCKERFILE bits that were added to handle multiple
 > containers from the same dockerfile.
 >
 > Fixes: 4203ea0247f (gitlab-ci: Add build tests for wasm64)
 > Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
 > Message-ID: <20260127092745.2978371-1-alex.bennee@linaro.org>
 > Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
 >
 > ---
 > v2
 >   - also revert the DOCKERFILE bits that are no longer needed.
 > ---
 >  .gitlab-ci.d/container-cross.yml   | 1 -
 >  .gitlab-ci.d/container-template.yml  | 4 +---
 >  .../{emsdk-wasm-cross.docker => emsdk-wasm64-cross.docker}    | 0
 >  3 files changed, 1 insertion(+), 4 deletions(-)
 >  rename tests/docker/dockerfiles/{emsdk-wasm-cross.docker => 
emsdk-wasm64-cross.docker} (100%)
 >
 > diff --git a/.gitlab-ci.d/container-cross.yml 
b/.gitlab-ci.d/container-cross.yml
 > index d7ae57fb1f5..2a0cea6ce1a 100644
 > --- a/.gitlab-ci.d/container-cross.yml
 > +++ b/.gitlab-ci.d/container-cross.yml
 > @@ -78,4 +78,3 @@ wasm64-emsdk-cross-container:
 >    extends: .container_job_template
 >    variables:
 >      NAME: emsdk-wasm64-cross
 > -    DOCKERFILE: emsdk-wasm-cross
 > diff --git a/.gitlab-ci.d/container-template.yml 
b/.gitlab-ci.d/container-template.yml
 > index 6eaa2f804df..8c7311cca57 100644
 > --- a/.gitlab-ci.d/container-template.yml
 > +++ b/.gitlab-ci.d/container-template.yml
 > @@ -10,14 +10,12 @@
 >      - export 
COMMON_TAG="$CI_REGISTRY/qemu-project/qemu/qemu/$NAME:latest"
 >      - docker login $CI_REGISTRY -u "$CI_REGISTRY_USER" -p 
"$CI_REGISTRY_PASSWORD"
 >      - until docker info; do sleep 1; done
 > -    - export DOCKERFILE_NAME=${DOCKERFILE:-$NAME}
 >    script:
 >      - echo "TAG:$TAG"
 >      - echo "COMMON_TAG:$COMMON_TAG"
 >      - docker build --tag "$TAG" --cache-from "$TAG" --cache-from 
"$COMMON_TAG"
 >        --build-arg BUILDKIT_INLINE_CACHE=1
 > -      $BUILD_ARGS
 > -      -f "tests/docker/dockerfiles/$DOCKERFILE_NAME.docker" "."
 > +      -f "tests/docker/dockerfiles/$NAME.docker" "."
 >      - docker push "$TAG"
 >    after_script:
 >      - docker logout
 > diff --git a/tests/docker/dockerfiles/emsdk-wasm-cross.docker 
b/tests/docker/dockerfiles/emsdk-wasm64-cross.docker
 > similarity index 100%
 > rename from tests/docker/dockerfiles/emsdk-wasm-cross.docker
 > rename to tests/docker/dockerfiles/emsdk-wasm64-cross.docker

Reviewed-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>

Regards,
Kohei Tokunaga


