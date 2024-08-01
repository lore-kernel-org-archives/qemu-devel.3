Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78939C3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 17:02:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZZBO-0003FK-UZ; Thu, 01 Aug 2024 13:01:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sZZBL-00033Q-0B
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 13:01:39 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sZZBG-0003PE-DZ
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 13:01:38 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-428119da952so46113795e9.0
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 10:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722531693; x=1723136493; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZYslOvdpteYQ2jvRo0kuy3ybTbbgO2ynHOwUzqgT4UU=;
 b=rr6zmsDU0IoWK/8HH/r1+ChWYzDU4GbQ8gKAB6CO5BzVQhoxW5ugto6SkUofyVBLqj
 zb/l16hriQWG32Ll3437C3c/c3rn3oQ2MUASwg0SLmAmKm5FaJDicbJM6yqVcI8+/tHa
 jzjmcRp/67imVwWeCn0T3XGIEGLfdQSDYds2mzgtWqxq4ULgMOb2XKW2oiatgQA4YFjg
 SnVlaly+CZ6Nuv4GIxA/FYyaKoFJdf2fvmabHNvMm3GruYvYHfcIYqkT3hMuH4JNwOi4
 3rw4l92bjdXNKAJQif2DYp0aNHm3RkFXVaFTnYEJHW1oLZSALiYNgL/uEHMhCbvuzBke
 u9pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722531693; x=1723136493;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZYslOvdpteYQ2jvRo0kuy3ybTbbgO2ynHOwUzqgT4UU=;
 b=GFv2uZyfCYMdjILEcLC4dhVVoPchGuczwifwbQKnHlDwT1SnWhGaeQEaP8b2vMaPqp
 OJkFKCpk1LwVIOrJEg116VaEYJpCmpgHJroO0eLMhXlL5xSZZHrzh9qxz58IbtyDe9Z0
 2XepgNtNWec2Jr5+YF+S7Eefb2qVZ5Jdww6QWx/F7qPYC78xSCh8ikJ4WHiBRD1GDE4Z
 gHemfQxow7EYoP2XjxR09PO42hCkJDb9DHqj2qGDmKvSTwdMgEFd550zmHZyOaMu8oFo
 I3I6SMjs8H1l/KfH8gCZjgW+JXL6XwPiFD6iYyg25AzD9gRrpooYkkuPT51/bvExkwbb
 l1CA==
X-Gm-Message-State: AOJu0YzNlN0I6MdSXIq21qcDMC4pEjutrZCN+wkMSUbG0vgAtDv3l1Zy
 Wyr1bxbxDUCN7qd/sZW/jVwxnLzNEr4dJ0CzDIYsFz+MmsbN9LQsgm5N6kYjFGv//d58PXUly7P
 B
X-Google-Smtp-Source: AGHT+IFoIx1pT4QrDgf+L59yOOHuZczVMx3mB2vpKGBlDP40SJhg0pP4eFV7ui3vSpmw2h3+NeMVaQ==
X-Received: by 2002:a05:600c:5102:b0:427:d72a:6c26 with SMTP id
 5b1f17b1804b1-428e6af2e18mr4163285e9.6.1722531692496; 
 Thu, 01 Aug 2024 10:01:32 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-428e24c2b4csm30385255e9.31.2024.08.01.10.01.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 10:01:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 Jiri Pirko <jiri@resnulli.us>
Subject: [PATCH 0/5] docs: more conversions from txt to rst
Date: Thu,  1 Aug 2024 18:01:26 +0100
Message-Id: <20240801170131.3977807-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

This patchset converts four files in specs and interop
from plain text to rST format. Technically this wouldn't
be a bugfix but I think it's probably reasonable to put
them in to 9.1 if they get review.

thanks
-- PMM

Peter Maydell (5):
  docs/specs/rocker.txt: Convert to rST
  docs/interop/nbd.txt: Convert to rST
  docs/interop/parallels.txt: Convert to rST
  docs/interop/prl-xml.txt: Convert to rST
  docs/interop/prl-xml.rst: Fix minor grammar nits

 MAINTAINERS                                   |   7 +-
 docs/interop/index.rst                        |   3 +
 docs/interop/nbd.rst                          |  89 ++++++++
 docs/interop/nbd.txt                          |  72 -------
 docs/interop/{parallels.txt => parallels.rst} | 108 +++++-----
 docs/interop/prl-xml.rst                      | 192 ++++++++++++++++++
 docs/interop/prl-xml.txt                      | 158 --------------
 docs/specs/index.rst                          |   1 +
 docs/specs/{rocker.txt => rocker.rst}         | 181 +++++++++--------
 9 files changed, 438 insertions(+), 373 deletions(-)
 create mode 100644 docs/interop/nbd.rst
 delete mode 100644 docs/interop/nbd.txt
 rename docs/interop/{parallels.txt => parallels.rst} (72%)
 create mode 100644 docs/interop/prl-xml.rst
 delete mode 100644 docs/interop/prl-xml.txt
 rename docs/specs/{rocker.txt => rocker.rst} (91%)

-- 
2.34.1


