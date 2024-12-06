Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 697E2E77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 19:30:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJe1S-0002yp-OS; Fri, 06 Dec 2024 14:29:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tJe0o-0002qB-B4
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 14:29:15 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tJe0j-0005Eg-U5
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 14:29:12 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2153e642114so25058995ad.0
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 11:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733513348; x=1734118148; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=msFX+jDD+Hv+ETojsNCSut7+r2zf++AknG8UI2zRaGg=;
 b=CsExJpdHHJO9Tlv10S/m+2+AlqPUSpoxtnaB3t9Wm6D+Lxtmb4Xx2L5KoJsnhlCZXD
 L5sKDqcNCF+KY24YKak5X70BY8Bgkw1nolnBbJZOaEjsItwUPIAjZBISTpSV8SuRk6PX
 /9ZUoW2ANJ+TPUXuv/mtGgld9V8sXs8UEwSi6/pPzMzrxxcAUFg3v9U6GhojJ3idGKBv
 229VNSabYZFaHCzfwVXkwNYLZFkLG8ulB4MoX0NNlapf9CH8HIRvgbX9Dg53/q+DO7z4
 avkItzYrSBh0Krh6Eua36RQt6EQYfCxpR2WnK5KwEgPDkVkpMphmSNJPY0gD2uL1xtN7
 0ISA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733513348; x=1734118148;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=msFX+jDD+Hv+ETojsNCSut7+r2zf++AknG8UI2zRaGg=;
 b=QTcnQbSLz0CNzUTzlNNCeJt92dIWCqnVWo8vpRX3+Z3sKa/LWmdBis8jG3mU7LcY8H
 M7BOGg5Srjyh3l3iH3TjDBXQXPdCpogOZhmkrR5Caw+mZfojlpIpMBaUrXoetEvl/SE4
 gGp2gIYPgpNvZFpGeyLumo9NBe8C9UN1YACjtZ72ZwiCP+taRw1qZfl7udgx9EYHJS7l
 zLIgbCq5ToPTASUdh+/YM2z7wlaC6fxGee3FDUz4s60tcoBrHarvICSIsb+NXAZ+LkmI
 7iCNaGiBd1c/tsoWYTlSyobgpI8chFLHRELc2ce/auHvrVWaxhnZDhYWAUv5GtEMozJR
 NUhQ==
X-Gm-Message-State: AOJu0YyT3P5qxhPpkCJ2QTLZhnlTjOF4fnrBpZMtaml0NSIxAdLH9Aoe
 AO5XvxIpsgFy+tfiVoXjLqSDPNnTfQXc1m2Hn7WfACz8nUIgxU9TsM4Kunb4gw0SVttBSOCOPQq
 NJj8=
X-Gm-Gg: ASbGncuJChNtjkLqbeenWJQYCMLiKcE81VEyBlTxUUGJFkA3FX+ooHdaE75oCOph9+G
 2XSu9AQDfozxWqvP44l8QO1Ph3F+56XjrWC5v62lqtN5TEZM68PhmKcKZoNG4qohlwso4ivmnKG
 s6MBSNSCIYKO1sT13zhYp0NTpm7aKszV7XLPFuSSYTznT7QKMbT+KO3bLB/WH99I59LEMKpBFZX
 Wg/q6Y06NfKYAh8JGbAH8tIEugnQ/55WK4lPCUEmhsDgIN5B/hk2nYaV2HbzahIRlE9MOpfArn2
 3UsYOywd
X-Google-Smtp-Source: AGHT+IG3jZ79VmkhVqrz0FbM7lqJC+BmrEHXrnvAcqMBqroNAulqDdXVSVv/55meQ1lfDfnPoB6SXw==
X-Received: by 2002:a17:903:24d:b0:216:1367:7e3d with SMTP id
 d9443c01a7336-21614d67fc3mr62226725ad.31.1733513348428; 
 Fri, 06 Dec 2024 11:29:08 -0800 (PST)
Received: from pc.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-215f8ef9fcdsm32110205ad.146.2024.12.06.11.29.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 11:29:08 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-block@nongnu.org,
 philmd@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-arm@nongnu.org,
 Michael Roth <michael.roth@amd.com>, Peter Xu <peterx@redhat.com>,
 gustavo.romero@linaro.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Eric Blake <eblake@redhat.com>, Andrew Melnychenko <andrew@daynix.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Jason Wang <jasowang@redhat.com>,
 manos.pitsidianakis@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 0/6] Enhance documentation for new developers
Date: Fri,  6 Dec 2024 11:28:54 -0800
Message-Id: <20241206192900.3893118-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
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
 docs/devel/codebase.rst                | 218 +++++++++++++++++++
 docs/devel/control-flow-integrity.rst  |   2 +
 docs/devel/decodetree.rst              |   2 +
 docs/devel/ebpf_rss.rst                |   2 +
 docs/devel/index-build.rst             |   1 +
 docs/devel/index-internals.rst         |   2 +
 docs/devel/index.rst                   |   1 +
 docs/devel/migration/main.rst          |   2 +
 docs/devel/multi-thread-tcg.rst        |   2 +
 docs/devel/qapi-code-gen.rst           |   1 +
 docs/devel/submitting-a-patch.rst      |  40 +++-
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
 25 files changed, 703 insertions(+), 6 deletions(-)
 create mode 100644 docs/devel/build-environment.rst
 create mode 100644 docs/devel/codebase.rst
 create mode 100644 docs/glossary.rst

-- 
2.39.5


