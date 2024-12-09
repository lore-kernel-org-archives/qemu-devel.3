Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1F57E77180
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 18:33:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKiXK-0002Sa-F9; Mon, 09 Dec 2024 13:31:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tKiXI-0002RF-L7
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 13:31:12 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tKiXG-0006t1-4Y
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 13:31:12 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-724d23df764so4357344b3a.1
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 10:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733769068; x=1734373868; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PZqZBHwarWuFysN6iWztZx7iVOB2C8528xQYw/i/7uM=;
 b=a+BO8sw8Z5ApOrt20yDWaBGZXiM6A8HL+WCS2U0IfE7vbEw+JzDB3+JIhreGBZIM7S
 JzHqYfnTd9ZN+gcWBaX8eMhvdB1WtzV/r0ZS+9u44mTyx14DCMufMRUge9XYi2fb2t5t
 0tMXUv24hNEEPvIZ2+Sk+Gkup9QnejPhh8BsdE/W33aNTbukOYyU9B69sijImm0JNDQO
 FKuv5X3QdrSw9DGCfq6O1e2HbZDvlJKO2T9PHeHgRKXxr0K6Rmid6v1jzcaIKLmV/ztE
 BjF7Zrrlxnx+wNGVL/rG90q1Uu7fbW99lDqkTlYAihYT7NJR8p2+l7PReHhlVKHaMdCT
 B4Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733769068; x=1734373868;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PZqZBHwarWuFysN6iWztZx7iVOB2C8528xQYw/i/7uM=;
 b=wkYQWvnCURnLorH7d6lyKT9XQyOi21fZaItFo5lavRKqnXHJHMIV6xbBQ6voZ/JsF2
 Mi2BsebcbZy2SBNVppslNDon77qmfYyo+ZjGm3vh34YCKxsU7CHwSl4fF26SUHLOm+Ig
 RG0ZLFH2jJvwnEk/uDgOHF6UkZ8se8egyDdKICHZCzi9vN3TXEyhF8c2N/nrDbHX+hsa
 FSMoeGdbvaHM8+57FACl+l+HF2qIs6qTwjNXwXLufL6RmYNhUpF3m3pzHIasUOLqxgs6
 /PaG2hjmKi70dCQRgZ4kJZzRKjBlq3Tu4yvjET0YNs8EvhF3p7EVEgCfJlm8m6hLuBPb
 P+ZA==
X-Gm-Message-State: AOJu0YwwqFnhyKpdf8yo7U2Bvu90f3DhiRpLTPrkIcKCaPPJTmxuelof
 +UvKz5Oq8r+ip/ABxcrtuUPsujDTCULuvsP0I5zOiyLklVrR0sctlXWoB9mxMylDm5KtriDjDbe
 H6bw=
X-Gm-Gg: ASbGncuGNj/ZhWjFB2FIOpPufMV2QWDx9TpbChQtPvhcrtgDF4SMGZnFlkFLCIwm/as
 tgorj/cl72YhFF2sr/ogPNwZCIuutTngXAj/fm6rBY3D3m7H8lC3eD04PwlhtwTPKBTC5kvoC6e
 FhI5P5EoXVtrgsAwRbSqm4v+tA438Xmde2llOj0H/7FDTYaaRDErbNE3YfRzIOGUtwhqh1Rhq+I
 m0/GUDJe07Fp2nYsZgJwuMbBTvxwJiIY2KbvShNJHyZfN8R2cMZfTuE1yYBopmYHkYr+g3SiXEG
 fkthQRgU
X-Google-Smtp-Source: AGHT+IFpHUUfQEGoFuUDLNn5zxgwOTzLoQsIq3M53PXqhUwrAI2CmruVHac2HmDdLItmBcpygAm3eA==
X-Received: by 2002:a05:6a00:2d0b:b0:724:6cd2:cdcf with SMTP id
 d2e1a72fcca58-725b81f2d33mr20069380b3a.24.1733769067681; 
 Mon, 09 Dec 2024 10:31:07 -0800 (PST)
Received: from pc.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-725e2388d37sm3322821b3a.73.2024.12.09.10.31.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 10:31:07 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: manos.pitsidianakis@linaro.org, Andrew Melnychenko <andrew@daynix.com>,
 Thomas Huth <thuth@redhat.com>, Michael Roth <michael.roth@amd.com>,
 qemu-block@nongnu.org, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Kevin Wolf <kwolf@redhat.com>, Peter Xu <peterx@redhat.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 philmd@linaro.org, Fabiano Rosas <farosas@suse.de>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, Eric Blake <eblake@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Markus Armbruster <armbru@redhat.com>, gustavo.romero@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 0/6] Enhance documentation for new developers
Date: Mon,  9 Dec 2024 10:30:58 -0800
Message-Id: <20241209183104.365796-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42d.google.com
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

This series extends our documentation with new pages to help developers
onboarding on QEMU. It focuses on providing a big picture of QEMU (to a
modest extend).

As such, it was written to be simple, short, easy to understand, and pointing to
more details. It provides another way to dive into details instead of simply
hitting the "search" box.

The first patches enhance the existing developer section. They provide
information about b4 and git-publish, two important tools that I learnt from my
coworkers, and were not presented anywhere, and were really missing IMHO.

Then, we introduce a new Codebase page, presenting (succintly) the various parts
of QEMU, and what every folder of the codebase contains.
We then add a glossary with the most recurrent acronyms we hear in our daily
conversations on the mailing list.
Finally, we add an "How-to" page which present how to build and test qemu, and
how to contribute a patch. It's definitely a repetition of existing information,
but the goal was to have a self contained page with all the commands I run
daily personally, and that someone would be interested to have.

When reviewing, please keep in mind this is targeting someone who discovers
QEMU, and not someone who contributed to the project for several years. What is
obvious for you will not be obvious for a random young developer.

That said, please free to point if something is "false", or "really incomplete".
It can be hard to summarize in one or two sentences complex parts, but that's
the intent here.

Your feedback on content or organization is very welcome!

Thanks,
Pierrick

v2:
- removed how-to section
- integrated all suggestions from Daniel and Peter (thanks for all your comments)
- Note: build environment keeps mentioning windows-arm64 because we solved the
  issue with gcc_struct attribute. The related series will be merged before this
  documentation.

v3:
- added a comment about git-publish asked by Daniel.

v4:
- add suggestion from Thomas for codebase and message-id.

Pierrick Bouvier (6):
  docs/devel: remove dead video link for sourcehut submit process
  docs/devel: add git-publish for patch submitting
  docs/devel: add b4 for patch retrieval
  docs/devel: add information on how to setup build environments
  docs: add a codebase section
  docs: add a glossary

 docs/about/build-platforms.rst         |   4 +-
 docs/about/emulation.rst               |   2 +
 docs/devel/build-environment.rst       | 118 +++++++++++
 docs/devel/codebase.rst                | 220 +++++++++++++++++++
 docs/devel/control-flow-integrity.rst  |   2 +
 docs/devel/decodetree.rst              |   2 +
 docs/devel/ebpf_rss.rst                |   2 +
 docs/devel/index-build.rst             |   1 +
 docs/devel/index-internals.rst         |   2 +
 docs/devel/index.rst                   |   1 +
 docs/devel/migration/main.rst          |   2 +
 docs/devel/multi-thread-tcg.rst        |   2 +
 docs/devel/qapi-code-gen.rst           |   1 +
 docs/devel/submitting-a-patch.rst      |  44 +++-
 docs/devel/testing/main.rst            |   9 +-
 docs/devel/testing/qtest.rst           |   2 +
 docs/glossary.rst                      | 280 +++++++++++++++++++++++++
 docs/index.rst                         |   3 +
 docs/interop/qemu-ga.rst               |   2 +
 docs/system/arm/virt.rst               |   2 +
 docs/system/images.rst                 |   2 +
 docs/system/qemu-block-drivers.rst.inc |   2 +
 docs/tools/qemu-nbd.rst                |   2 +
 docs/tools/qemu-storage-daemon.rst     |   2 +
 docs/user/main.rst                     |   6 +
 25 files changed, 709 insertions(+), 6 deletions(-)
 create mode 100644 docs/devel/build-environment.rst
 create mode 100644 docs/devel/codebase.rst
 create mode 100644 docs/glossary.rst

-- 
2.39.5


