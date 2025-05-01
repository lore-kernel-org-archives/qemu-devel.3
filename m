Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 474A8C369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 09:32:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAQGW-00080y-Ju; Thu, 01 May 2025 05:31:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uAQGT-000808-5A
 for qemu-devel@nongnu.org; Thu, 01 May 2025 05:31:35 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uAQGR-0006YU-0S
 for qemu-devel@nongnu.org; Thu, 01 May 2025 05:31:32 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43d2d952eb1so3470335e9.1
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 02:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746091889; x=1746696689; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YnnJEripG6fIHX0UV+V78VtWh/8PSzhP33cG+P82cHs=;
 b=mnMLHKRct5NOsGoXF+/7+OnuK/8iYF0cwmOF4ihJzo3PLaQussj2mKsBVbiIXW/fbE
 gCRTU6W2J8nxP2HWQrC6bYkCT6yW+EHfsm8CGiHJ/vqgVCTtkRFw1ur10GhEmRkhAPC7
 DUXvJD6puF24H15aauqSkzVsif+QHkMDt51xW7u1DMQULsmuCLwd/JVY67fo6NXTW0oD
 djZWRXEZ1JkbzIc2RniVMksX85N1dAYZ0yMdWkOJpaUhO4UbK5PaC2quDsBmCrqqCSM6
 9ZonGXtdymUKWeD/VnyQ6Ulr7biZfOb9brGyKGlKjqIPVyIbdEPOzU5oPn3JYSExr+dD
 OoJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746091889; x=1746696689;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YnnJEripG6fIHX0UV+V78VtWh/8PSzhP33cG+P82cHs=;
 b=HR9xtQD2Hy0Rchjqoh8NvxeYxvP3g+CJANrENnIp5FfcO87dyo3kAqKTjc/XtAMcAB
 a82gmYEgDSnTQMePTTv5PDigHAiZ+rkwkccBeOkOt6od1H+DlgUcjrTP5VApdKAmKi47
 EdN9KuQAy2fv0EEXJ/2DHhwcefjiAJNFMkbjFDeeAXRte+jhOf6X7DemDzvP5PEj+wxy
 GLTIttnLKNb8QJRM+d4qNUm8r4K0HTL/d5G9SqainUDnGTZ5kI1ZddpwGWmjdT4Cz8z8
 dk3TWW7ji2+5BHLwrL4CWtUpQurP2eqBrI+wbyy4fcwiS5GOVUdgvLx5+czs6RRmuW6+
 zF1g==
X-Gm-Message-State: AOJu0Yxq9o3b9jC35SU2f0arS1w32NJeGnn2qPncLRqxm5ojV2kvD6Ti
 ddrLcXLvnWtyLN4hNPR3V9Jax6tdPX4jDW5OCVuMjIbbnM8jrXla1dt7/Y2li8vzt4gkFu+1H2l
 J
X-Gm-Gg: ASbGnct2j1xHXQ8DKnO/Um5hna0vRdW3sk518ICio2yvBx/B7TWQp1J/kIKYg7ggXD9
 rUEZxlNeuqlIZrftUAAq6tQ1b0f0iwvg/WYWdeDmqsioSsduV6h3jv8SvG7EOxEBofZkUZg7OOY
 6/P4B4MUi2OCbyLyalpNp36yH4F8UqtOoIiQRNC8J/LpdxOk4+a7lTiEpeyDKtkiYkcK0yqxSpS
 G2weOcF5Npwo+PtHsO3HarktD+kOxlE97+iiV80HELYYvaqmRZrUgQ1i1Q0igkDugGPpyNyDVj8
 osfnodWuaXTpbgRKGUXLGdu/Hzxr4aIi17MGn+/tY2EmzKY=
X-Google-Smtp-Source: AGHT+IGy7TBAI89+73ycwvstVqmFPiW1QlujM/+bG4yrqX4n0YgFVPLSjps5J0buPk/uKs2ZTebkPQ==
X-Received: by 2002:a05:600c:cc8:b0:440:67f8:7589 with SMTP id
 5b1f17b1804b1-441b6500646mr23816435e9.16.1746091888919; 
 Thu, 01 May 2025 02:31:28 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b2b28045sm51566235e9.35.2025.05.01.02.31.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 02:31:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Dario Faggioli <dfaggioli@suse.com>
Subject: [PATCH] docs: Don't define duplicate label in
 qemu-block-drivers.rst.inc
Date: Thu,  1 May 2025 10:31:26 +0100
Message-ID: <20250501093126.716667-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

Sphinx requires that labels within documents are unique across the
whole manual.  This is because the "create a hyperlink" directive
specifies only the name of the label, not a filename+label.  Some
Sphinx versions will warn about duplicate labels, but even if there
is no warning there is still an ambiguity and no guarantee that the
hyperlink will be created to the right target.

For QEMU this is awkward, because we have various .rst.inc fragments
which we include into multiple .rst files.  If you define a label in
the .rst.inc file then it will be a duplicate label.  We have mostly
worked around this by not putting labels into those .rst.inc files,
or by adding "insert a label" functionality into the hxtool extension
(see commit 1eeb432a953b0 "doc/sphinx/hxtool.py: add optional label
argument to SRST directive").

Unfortunately in commit 7f6314427e78 ("docs/devel: add a codebase
section") we accidentally added a duplicate label, because not all
Sphinx versions warn about the mistake.

In this case the link was only from the developer docs codebase
summary, so as the simplest fix for the stable branch, we drop
the link entirely.

Cc: qemu-stable@nongnu.org
Fixes: 1eeb432a953b0 "doc/sphinx/hxtool.py: add optional label argument to SRST directive"
Reported-by: Dario Faggioli <dfaggioli@suse.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I have a proposal for how we could permit this link:
 https://patchew.org/QEMU/20250429163212.618953-1-peter.maydell@linaro.org/
but since that adds a new Sphinx extension it's a little heavyweight
to backport to the stable branches, so I thought I'd send out
this "just drop the link" patch as our fix for stable.

 docs/devel/codebase.rst                | 2 +-
 docs/system/qemu-block-drivers.rst.inc | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/docs/devel/codebase.rst b/docs/devel/codebase.rst
index 40273e7d31e..2a3143787a6 100644
--- a/docs/devel/codebase.rst
+++ b/docs/devel/codebase.rst
@@ -116,7 +116,7 @@ yet, so sometimes the source code is all you have.
 * `monitor <https://gitlab.com/qemu-project/qemu/-/tree/master/monitor>`_:
   `Monitor <QEMU monitor>` implementation (HMP & QMP).
 * `nbd <https://gitlab.com/qemu-project/qemu/-/tree/master/nbd>`_:
-  QEMU `NBD (Network Block Device) <nbd>` server.
+  QEMU NBD (Network Block Device) server.
 * `net <https://gitlab.com/qemu-project/qemu/-/tree/master/net>`_:
   Network (host) support.
 * `pc-bios <https://gitlab.com/qemu-project/qemu/-/tree/master/pc-bios>`_:
diff --git a/docs/system/qemu-block-drivers.rst.inc b/docs/system/qemu-block-drivers.rst.inc
index cfe1acb78ae..384e95ba765 100644
--- a/docs/system/qemu-block-drivers.rst.inc
+++ b/docs/system/qemu-block-drivers.rst.inc
@@ -500,8 +500,6 @@ What you should *never* do:
 - expect it to work when loadvm'ing
 - write to the FAT directory on the host system while accessing it with the guest system
 
-.. _nbd:
-
 NBD access
 ~~~~~~~~~~
 
-- 
2.43.0


