Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE2EDC25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 12:53:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9Ozj-0003GB-9c; Tue, 21 May 2024 08:53:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s9Oza-000329-DS
 for qemu-devel@nongnu.org; Tue, 21 May 2024 08:53:22 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s9OzV-0005g7-UD
 for qemu-devel@nongnu.org; Tue, 21 May 2024 08:53:22 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-51fdc9af005so7445846e87.3
 for <qemu-devel@nongnu.org>; Tue, 21 May 2024 05:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716295996; x=1716900796; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=r6JaNsmC4o9vkpza+xEC9TnSr02nDpoRGnxGgkMjwl4=;
 b=HdNei5OgcdHBSbOqMReJPK1PvkjVzD6NfQQ1CPoltqSR7uMSX2NAOKmuK6v0dUFMGr
 NBkoAB7j15PhIdk9yjEmjVfJZ6K+1UPvgufzH58Fi00mQ6GcLM1JOucgLI13z0cEFrh9
 fzR2bcNaVTH32ms+YvJl+le8V7wssP05WAbTRtD6iRKV3dyp5JWgi7EXmf8XAx0J6a0b
 LfhpZQAvG4Za1zdws581OTVtTSZg1XHlJ1H0YsZ/f+rSMK+qvUyhn93G+eLVyKmY62rg
 uCNlYJf8SGMZGzFXwTW0GEbix6PszNANJGi1aHcmb8wAVxoD6Vcu97ahOorG0EJl1qTi
 x4cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716295996; x=1716900796;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r6JaNsmC4o9vkpza+xEC9TnSr02nDpoRGnxGgkMjwl4=;
 b=O6w6OzqgrnX1Jv1p0b0dz9qHef0RdBen9v4RyvrXeRM4mJWY/PflKIUJ9fr5eG5qfr
 TxhHJwvgJTxY+jPK5Pz4uNfddvZoJg9Zb01M5h2wSQzzUnzoUZ1CajUpq3BvWEb4QIhP
 azwgLDbMlBvEeZJhY0OpqbgGc1ZbnS9u9LFyrS/NmCzDvgIhq4wZVt333vKu7VzQLSgJ
 eBIclI7mEWGqO+xha72DyG43R8Gf87FWw/xc7aFHpGKtnv6/i7Y+zxNHdo71Tnc73yD8
 CAhVADlpNO65xVytObg8qzqliEA92SIFgpW/vbdTjlAA+x5qtbk2/PTiMs2pcd8eQlgE
 se5A==
X-Gm-Message-State: AOJu0Yxz85GGyf6CvxzDqcHX3BzZqLL+9fBM1xhqxGbAEZSDMhyu7C36
 2d1iKjCFdkaid+kcbz6D8ss9dOdNVtu28kzK+eGpbbkIiaU7TSOmEyAODKZdKNI=
X-Google-Smtp-Source: AGHT+IFN31ap5yhrqkE3R4kUqmxPvNx7ZbPjSizCcTjS5K1ymfDGCoVbuxXubpgqcUWY8vbLGU1kQA==
X-Received: by 2002:a05:6512:689:b0:525:32aa:443e with SMTP id
 2adb3069b0e04-52532aa4e3dmr1667066e87.17.1716295996002; 
 Tue, 21 May 2024 05:53:16 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a179c7d7csm1627709666b.140.2024.05.21.05.53.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 May 2024 05:53:15 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BFDA15F8B0;
 Tue, 21 May 2024 13:53:14 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Beraldo Leal <bleal@redhat.com>, qemu-s390x@nongnu.org,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Joel Stanley <joel@jms.id.au>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Aurelien Jarno <aurelien@aurel32.net>, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 0/4] testing/next: purging remaining centos 8 bits
Date: Tue, 21 May 2024 13:53:10 +0100
Message-Id: <20240521125314.1255403-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x131.google.com
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

There are a few more bits referencing centos8 in the tree which needed
cleaning up. After this we can remove the dedicated runner from the
gitlab registration. If we want to keep a dedicated Centos runner then
we can add back the bits needed to set it up (although arguably we
could have a single build-environment setup that handles all distros
and integrates with lcitool).

Alex.

Alex Bennée (4):
  ci: remove centos-steam-8 customer runner
  docs/devel: update references to centos to later version
  tests/vm: update centos.aarch64 image to 9
  tests/vm: remove plain centos image

 docs/devel/ci-jobs.rst.inc                    |   7 -
 docs/devel/testing.rst                        |   8 +-
 .gitlab-ci.d/custom-runners.yml               |   1 -
 .../custom-runners/centos-stream-8-x86_64.yml |  24 ---
 .../org.centos/stream/8/build-environment.yml |  82 --------
 .../ci/org.centos/stream/8/x86_64/configure   | 198 ------------------
 .../org.centos/stream/8/x86_64/test-avocado   |  65 ------
 scripts/ci/org.centos/stream/README           |  17 --
 tests/vm/Makefile.include                     |   1 -
 tests/vm/centos                               |  51 -----
 tests/vm/centos.aarch64                       |  10 +-
 11 files changed, 9 insertions(+), 455 deletions(-)
 delete mode 100644 .gitlab-ci.d/custom-runners/centos-stream-8-x86_64.yml
 delete mode 100644 scripts/ci/org.centos/stream/8/build-environment.yml
 delete mode 100755 scripts/ci/org.centos/stream/8/x86_64/configure
 delete mode 100755 scripts/ci/org.centos/stream/8/x86_64/test-avocado
 delete mode 100644 scripts/ci/org.centos/stream/README
 delete mode 100755 tests/vm/centos

-- 
2.39.2


