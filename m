Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AA4DE7716E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 22:25:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJKFL-0004WD-4T; Thu, 05 Dec 2024 17:22:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tJKFJ-0004VU-QA
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 17:22:53 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tJKFH-0007zs-SY
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 17:22:53 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-215b45a40d8so12867155ad.1
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 14:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733437369; x=1734042169; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fIZCLlFZjn+KeB33XmENBZ2FZNb5x3KZq8MhJwQPh+Y=;
 b=mdCVpx9IGU7V+IamsU2piwcfQNBzDiyW5SFCkSDULvzXFn86NPvs8Dy0RhbNayD9ZK
 lVCS2JqtKsZc+cY7yaRoKv0trnw7tCOZHVvQBVyfsFeWEedjQjVLb+fBmlspV6Lfec1q
 l9jqYHfkM46PlTwO4KdfR2/PqLMJTXGP6+I8DK9Y9Gpg7T2/LLZKpHxEyu7C1LX2DM38
 PXBm3fzl3C8EzqOf98xxKdL3V67gFB98ivKz0UGhVxMN07mlFSXzcKvW/corlTWKna27
 msrymIwAKVwTXsWO7RlQALqM9pjqFRfsiwfhNVwbdX3e69vGQRkRZtgOKyCCCCo+F1TW
 nRFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733437369; x=1734042169;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fIZCLlFZjn+KeB33XmENBZ2FZNb5x3KZq8MhJwQPh+Y=;
 b=pbhWouB7r4d/PBWyw819ZxNAMmikX3/SNldSaEuWddYXplNcprTCSZlKJlkCBQqYw/
 9ntid3m+Q/y9tWzZR88qNpV6j7fE/1rgmFGJjAsH5fC6Z0e2j+VzlVyYaZ0T+txsCR8H
 JspITnNqpGWiaL1BXbfcMkRIaWy891PjNgTtvJbs7+xvUnKSS0suA1udEHCALfAeG0+b
 go1G1/z6zOzcyhDEiIA6YeJlnV+Acpz24hnNo8m1yiyOaoffC/vqE9BPpCU5ZaFWak4s
 zZJ1DwJhgeOeyhNfUBN2Y8mBSmGfiQMiz+M6YOXp3y8SYFKDDK2L0S5dmlG6im938xa7
 Dj8A==
X-Gm-Message-State: AOJu0Yyh65aFOGhyYeP/ocK9hfNDOj/oiBEIqMW0oldE8fsBJbCCd32u
 e34sRZF+xnbTgfhaIXvZvS2wCTkqgv1QYuY3nwRcfaXjq+VqkcghL9l+nmejy8Dq3fthaHjGA4B
 dTEI=
X-Gm-Gg: ASbGncv40eICFXBcr1dPC11GORgNyS7CpcfmtU2ulPFRG5bL7GedC8EfBH0DxWDX0iH
 1pm1wnd1O00odZdyX8PZff9mn0q/puydRz9ZazskKm2iGTGbzfW26eW8VfdixYGHpe3CVEyrlRB
 /Pfm67Kov/Vur4T/XBw9HAmqBux7Ak4PmMpW0ZJ7Is2UbM+tOheZNOmoC7i8wENPUPdPTLVEw0M
 5tBoD9CpBuvdHAC206Z02RtW4LJyEMSSM1/9LFa+nNFG2aj/ULQI+58Nxfg2x/pTqaqjh0bL8xq
 muw66iNH
X-Google-Smtp-Source: AGHT+IHEiRQZWoTzhKGk3kCnrMtff4BEP5jOQOAxVAngR/KhljA0z7CJRxakl0OvWhxNlFm5pVWSfg==
X-Received: by 2002:a17:902:c405:b0:212:40e0:9562 with SMTP id
 d9443c01a7336-21614d54187mr6696405ad.25.1733437368685; 
 Thu, 05 Dec 2024 14:22:48 -0800 (PST)
Received: from pc.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-215f8f0b571sm17310435ad.183.2024.12.05.14.22.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 14:22:48 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 gustavo.romero@linaro.org, Andrew Melnychenko <andrew@daynix.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org, Konstantin Kostiuk <kkostiuk@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Jason Wang <jasowang@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 manos.pitsidianakis@linaro.org, qemu-block@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 0/6] Enhance documentation for new developers
Date: Thu,  5 Dec 2024 14:22:35 -0800
Message-Id: <20241205222241.3789437-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
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
 docs/devel/submitting-a-patch.rst      |  34 ++-
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
 25 files changed, 697 insertions(+), 6 deletions(-)
 create mode 100644 docs/devel/build-environment.rst
 create mode 100644 docs/devel/codebase.rst
 create mode 100644 docs/glossary.rst

-- 
2.39.5


