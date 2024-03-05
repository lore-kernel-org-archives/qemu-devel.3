Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC672C54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 22:10:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhcyp-00079U-W7; Tue, 05 Mar 2024 17:09:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhcyo-00079K-Hd
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 17:09:46 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhcym-0000jG-GW
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 17:09:46 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a3ed9cae56fso39457866b.1
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 14:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709676582; x=1710281382; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NA02dbuxxBM8ntdJrTwv09KJLy37CKMl6WZVwFBG2SM=;
 b=MoDVaA7F6DmKHtez05wuYe2TYOUxAfiA+gfocGXLadGuGGuPkhrpgqhZ2+xFIlZTcL
 o3LNopuJU/bIU7ui0jx+zBDkBWmqJeio0ozbXuSq2irj3EKxZJK1hKDSXhhlORe9QoNL
 3mxaZoX3BzaBaGBqTYiShXkXqkSeTRGCk1yaSBDJU62tad7NnOSSwtu0TFUT1haYXiLT
 xmXeMhOG0HmNFGh41b+5o1epNjry/iee6rX2VQVlP3ZYLiBGnFctK+N2u0xV/OoniAqV
 XGSEWXUvm2qZo8qndHcqeqzNJcLQa+vj2OkeqzejVyW//tJjzlQuJuh0xPXkyY2//STE
 OzQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709676582; x=1710281382;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NA02dbuxxBM8ntdJrTwv09KJLy37CKMl6WZVwFBG2SM=;
 b=BAUNR+WhM111uoIapfNSHd1993g203TRT+iSi+ExXsuZebQVCduAiqmUjrTfgxlclh
 Rop2zRcJzRcHHUlf0fghzdwNLqxfQ4G1l+AnMOlZaw95mLLawz5qDjQ3hT4euxvb6FJa
 +U9Fnt+M4yC2W9Re8+8eiIFsIqjzzOe9O2cBa7FomnO05it4UIgW74Tevev2wmKaoKzF
 4Njr9jh9bj40UiYtqxyYw45L0pnX5JAA5fHVeDjo7ZmHnuUOxmlVcR/KtEwxdKQm/B4N
 UA9Y06+ZYS+SA0ZG5qdmxjninS2G0Jp8aDsuqG1tCODQpExITuZlZuKGoUWkINOjb4w7
 JKXA==
X-Gm-Message-State: AOJu0YyYzL64Uqa3StEzuboXVuN8YhwOy3j0xbWOb/ngSJPjr6pAQ0Yq
 ap4x6HKPJBRcPIBfvY+rpTvCorhvMhxFc5i5r8Ot/ib2pXbF3oJDqDJ33xuZPSzUlAjkDV9snzY
 0lMI=
X-Google-Smtp-Source: AGHT+IE4HtZXFhnRHWhzpvFCOayOrsJ3ZH7nRndQwIc6AYo5qBn6gFmPl/0Sz7B8R+tw1j5EtZI40A==
X-Received: by 2002:a17:906:b59:b0:a45:1ff5:9f3a with SMTP id
 v25-20020a1709060b5900b00a451ff59f3amr3970025ejg.33.1709676582100; 
 Tue, 05 Mar 2024 14:09:42 -0800 (PST)
Received: from m1x-phil.lan ([176.187.210.193])
 by smtp.gmail.com with ESMTPSA id
 s7-20020a170906a18700b00a44ba5557c1sm4801965ejy.131.2024.03.05.14.09.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Mar 2024 14:09:41 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 0/2] target: New binary to prototype heterogeneous machines
Date: Tue,  5 Mar 2024 23:09:36 +0100
Message-ID: <20240305220938.85410-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Since v3:
- Rename binary (Manos, danpb, mjt, armbru)
- Protect distros with complicated ./configure option (danpb)
- Do not install (Manos)

Since v2:
- Run check-qtest instead of check-unit in CI (Alex)

Almost 2 years later we got hundreds of cleanups patches
merged, so we can get this patch in. Building the 'any'
target has to be explictly requested in ./configure
target-list argument.

This binary will be use to rework QEMU startup code,
paving the way toward dynamic machines. It might also
allow experimenting with multiple TCG target frontends
and possibly prototyping concurrent HW/SW accelerations.

The corresponding CI jobs takes <3min!!!
https://gitlab.com/philmd/qemu/-/jobs/6177909577
Duration: 2 minutes 50 seconds

v1: https://lore.kernel.org/qemu-devel/20220215002658.60678-1-f4bug@amsat.org/
v2: https://lore.kernel.org/qemu-devel/20240209152945.25727-1-philmd@linaro.org/

Philippe Mathieu-Daudé (2):
  meson: Make qemu-system binary installation optional
  target: Add system emulation aiming to target any architecture

 configure                               |  6 ++++++
 configs/devices/any-softmmu/default.mak |  9 +++++++++
 configs/targets/any-softmmu.mak         |  3 +++
 meson.build                             | 25 ++++++++++++++++++-------
 qapi/machine.json                       |  2 +-
 include/sysemu/arch_init.h              |  1 +
 target/any/cpu-param.h                  | 13 +++++++++++++
 target/any/cpu-qom.h                    | 12 ++++++++++++
 target/any/cpu.h                        | 24 ++++++++++++++++++++++++
 .gitlab-ci.d/buildtest.yml              | 21 +++++++++++++++++++++
 hw/any/meson.build                      |  5 +++++
 hw/meson.build                          |  1 +
 meson_options.txt                       |  3 +++
 scripts/meson-buildoptions.sh           |  5 +++++
 target/Kconfig                          |  1 +
 target/any/Kconfig                      |  4 ++++
 target/any/meson.build                  |  7 +++++++
 target/meson.build                      |  1 +
 tests/qtest/meson.build                 |  6 +++++-
 19 files changed, 140 insertions(+), 9 deletions(-)
 create mode 100644 configs/devices/any-softmmu/default.mak
 create mode 100644 configs/targets/any-softmmu.mak
 create mode 100644 target/any/cpu-param.h
 create mode 100644 target/any/cpu-qom.h
 create mode 100644 target/any/cpu.h
 create mode 100644 hw/any/meson.build
 create mode 100644 target/any/Kconfig
 create mode 100644 target/any/meson.build

-- 
2.41.0


