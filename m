Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE360C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 15:41:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0Nfy-0001qk-69; Fri, 26 Apr 2024 11:39:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s0Nfu-0001oK-Vb
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 11:39:46 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s0Nfs-0003na-6C
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 11:39:46 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-571ba432477so2523911a12.1
 for <qemu-devel@nongnu.org>; Fri, 26 Apr 2024 08:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714145982; x=1714750782; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2t8caeHG/hvE4xW05s4K/jE+OqOrT7ireK4cX6BKhYk=;
 b=vqoUEd+znWzEVmIOC2UUSIWuwglx7jhyWTaTj9+0c6Vlra6VNSHWBRb4XUfX7M4why
 chYlsl6dUTLm64QcGhxJ5L189o2a+DQYysWNjjh7ME4WyDqPs93F7uUfiFhTQgd9Lmze
 vYsQ+WaTgzm127hspPFm6O+9bVNCQD+HEUsyqtw8jvaksGw2OYEwki0hagE8tdaG0VL3
 pUwah4eM3zbssf6eqzguJkMNe9W6yLIKSsy/9vCYsrFfTto77WssHGr25QAvF3w2i7kS
 a1IuWJoXflZKQfLSnXD6q1MW84nKn+0Ex0CldpbuM2jH/xEtyzMuCji2fdmDMwQFJPJs
 WoZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714145982; x=1714750782;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2t8caeHG/hvE4xW05s4K/jE+OqOrT7ireK4cX6BKhYk=;
 b=A1aG67XT2rZmGullmlWDM/PwiDvGPHBXgqlpQLpRHnYOOyoU8EGjnUoBp3FQkR48f6
 WVCyYBjnIjkVeU3XTvFUuFtwgKFzaCFPeiDexhF8qXYKI67hSSuhuJNgN9AvnscqWxtN
 +jVlwj+Au2JMRdjg7GtztwJMeTTku6nXV8L5wEcCX3IdFPrmi0m57sI63PtyD+Lrnik6
 zckEr6mWDtC5dvvy9aHhf0a1Oi2A+/+IfkBrMTpMgcxDTIcYVrHmc0x0L3H8bBXwnCgf
 7yj5GZBeabeBM6RzCBH6PABMqUIs+AwVLdRD+WgjcxJmHBn2dhTb/mjdulLMjIhUMywP
 apoA==
X-Gm-Message-State: AOJu0YzcB2rswV6npx3x4ZHCZSlZvpRdfRgRLkTuem0R3fxWw/lrSTUE
 ZaOKLrXsoPJirQSzCOIBczCqDi4SF3OOFRMC3l8/XXhZlkNA+bqxis/ZsXuaueo=
X-Google-Smtp-Source: AGHT+IFDld2HDYWcjx121NV2ZWCF0PgImU9WsM4NLtfO+T4utCsthW/wgNEphd0r2DXC1HLg4z18og==
X-Received: by 2002:a50:cd15:0:b0:56d:c40d:b921 with SMTP id
 z21-20020a50cd15000000b0056dc40db921mr2091875edi.20.1714145982028; 
 Fri, 26 Apr 2024 08:39:42 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 u7-20020a509507000000b005722d871e4csm3542662eda.90.2024.04.26.08.39.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Apr 2024 08:39:40 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3238B5F94C;
 Fri, 26 Apr 2024 16:39:39 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Joel Stanley <joel@jms.id.au>, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Cleber Rosa <crosa@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 3/3] gitlab: remove stale s390x-all-linux-static conf hacks
Date: Fri, 26 Apr 2024 16:39:38 +0100
Message-Id: <20240426153938.1707723-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240426153938.1707723-1-alex.bennee@linaro.org>
References: <20240426153938.1707723-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x534.google.com
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

The libssh bug references 18.04 which we are no longer running. We
don't need to disable glusterfs because a linux-user build shouldn't
be trying to link to it anyway.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .gitlab-ci.d/custom-runners/ubuntu-22.04-s390x.yml | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/.gitlab-ci.d/custom-runners/ubuntu-22.04-s390x.yml b/.gitlab-ci.d/custom-runners/ubuntu-22.04-s390x.yml
index 85e2809573..105981879f 100644
--- a/.gitlab-ci.d/custom-runners/ubuntu-22.04-s390x.yml
+++ b/.gitlab-ci.d/custom-runners/ubuntu-22.04-s390x.yml
@@ -13,11 +13,9 @@ ubuntu-22.04-s390x-all-linux-static:
  - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
  - if: "$S390X_RUNNER_AVAILABLE"
  script:
- # --disable-libssh is needed because of https://bugs.launchpad.net/qemu/+bug/1838763
- # --disable-glusterfs is needed because there's no static version of those libs in distro supplied packages
  - mkdir build
  - cd build
- - ../configure --enable-debug --static --disable-system --disable-glusterfs --disable-libssh
+ - ../configure --enable-debug --static --disable-system
    || { cat config.log meson-logs/meson-log.txt; exit 1; }
  - make --output-sync -j`nproc`
  - make --output-sync check-tcg
-- 
2.39.2


