Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95B96E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 22:40:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNgD6-0005Kv-4z; Tue, 17 Dec 2024 17:38:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNgD5-0005KP-1j
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 17:38:35 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNgD3-0008Pt-Bd
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 17:38:34 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2166651f752so61715885ad.3
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 14:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734475110; x=1735079910; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wKE1SG5VSYuhZuklrKuA4VbC5NooL41X3SNYBAaJD6c=;
 b=pklA1ci6QfX1GkgLUauBXdNjS+ul9WPksx43VPNU867z0BMIc+Ied+SEcMM8PuGH/B
 tbiF8SAMvSeAU95z3Sxa6N30vYPqFmSHlpHBfIJ1PD0qLEJ0ihnp9LTPsLRqofNI687Q
 FeQCigDipby3tL1EwQ5toWxpDFg+F2EIM3oc8R/VORamboZVJp9mERSumx+jMTTTJacz
 GRe7BhsCz2u3wffPunRQ9VQfS1fXJeKY9f8qb44aHvTGFLuUP+H5IF4CmRtUJ5P7e/Ox
 k/AmGpwSE+2T3RPhfc1JrjnYBMVyTyIbv9uLg1Prn/hWAjm0OkjDymxocbdk4jZYZxFs
 /Lvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734475110; x=1735079910;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wKE1SG5VSYuhZuklrKuA4VbC5NooL41X3SNYBAaJD6c=;
 b=iLS9gmKuA7LL3bBsLT8pHj7yblDv8+kkSxUJYieVKINdq8dYPp1flUC3vVJ1dAq9UG
 qgwxX9JB+vdgXhpzytFRWko/aOJlcbqIDyG09xTVtRbbvaoq2BhAwKrGBxXvp1s2tcHm
 1GnuxyYsaX0F0bYSM2FfZd9X/qLC+8ZspUy/2ugth9OtL/z1Ghls2crODnYADSZ1vLMq
 8D9Syoqq8e/qC/3jDWxTKZeuY1qWXiTA1y14ig5ZhyBcciLFe0jggLFzw2HgGZ9RZMTl
 gIKqyUmR4wQ1j6ortVdFl68a1ewfoFoXkX2eMFv1zrRL+iNWZZ6HBsluhdqegYN4P42s
 /klg==
X-Gm-Message-State: AOJu0Yy+OL+WMEHIHEcBbVgCJNpoTy2rEPkKhJYXHnjJKYIXnJ8ROlrM
 793PUEeVJmVPnDJNSAEavkmlVmH6OigqeD4vs5X/8l2GPRLsdjWh/niB/vlvsFEpF7cM+RC4tMk
 9omQ=
X-Gm-Gg: ASbGncsoSI8n38NTUKCMUzdn8L0UXpzjt3YIiAZPmeCRFinNY0klEQP/ouvjlIuHQgL
 lC7gYkBv+Yz3nwGVjlirsHlYlV9UDTGg//gfQb6vqcSXr48H1g+8qdrgoLG96JQHKwIF3N61Bhv
 QiBR6U1pUNP8ZznYnkhODEWT/wI2PR4+OTxGBOjlu913t2Y+qrKSwus/sE2ZUHcX2Ht5Gefqiof
 TLRx9NhNY9iA4ZaGIf0/xNGPywSyFqyaIcq4pRdiVK3qeCF7EgU5EJJ
X-Google-Smtp-Source: AGHT+IEWhmTlQWgz0IRAftLjAMx59XPUbM1qB19/nqaAHFULkB6Q1TKCnSfEIFGE52heonThPGmG5A==
X-Received: by 2002:a17:902:da8b:b0:215:3fb9:5201 with SMTP id
 d9443c01a7336-218d7252a53mr6990775ad.44.1734475110603; 
 Tue, 17 Dec 2024 14:38:30 -0800 (PST)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-218a1dccb03sm64869465ad.98.2024.12.17.14.38.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 14:38:30 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, philmd@linaro.org,
 Mahmoud Mandour <ma.mandourr@gmail.com>, richard.henderson@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH v2 00/11] Fix 32-bit build for plugins
Date: Tue, 17 Dec 2024 14:38:14 -0800
Message-Id: <20241217223825.2895749-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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

Since 9.2.0 release, we are building contrib plugins using the QEMU build system
(before, it was external makefiles). When building for 32-bit host platform,
some warnings are triggered and build fail.

Thus, at the time, the decision was to not fix those plugins, and
disable by default plugins for 32-bit host platforms (see cf2a78cb).

This series fix plugins to have the same behaviour on 32-bit and 64-bit
platform, and reenable plugins for 32-bit platforms.

There are two portability issues:
- we use hash tables, and use data as key directly. As key has a pointer size,
  it limits its size for 32-bit platform.
  The fix is to use pointer as a key, and point to allocated 64-bit data. The
  change is pretty straightforward for concerned plugins, and does not imply a
  memory overhead, as hash table entry is already heap allocated usually.
- we use plugins callback data to pass a pc. This does not work on 32-bit
  platform, as we are limited to a pointer size.
  To avoid doing memory allocations, we simply we simply use
  inline operations and a scoreboard to achieve the same result.

Tested (for every plugin modified) on i686 and x86_64.
The behaviour before and after this series was checked as well, and there is no
difference, apart from bug fixing (some pc were clipped at 32-bit values, even
on the 64-bit platform).

v2:
- do not modify qemu_plugin_insn_haddr signature
- fix cache plugin to use a correct hash/equal function

Pierrick Bouvier (11):
  tests/tcg/plugins/insn: remove unused callback parameter
  contrib/plugins/howvec: ensure we don't regress if this plugin is
    extended
  tests/tcg/plugins/syscall: fix 32-bit build
  tests/tcg/plugins/mem: fix 32-bit build
  contrib/plugins/stoptrigger: fix 32-bit build
  contrib/plugins/cache: fix 32-bit build
  contrib/plugins/hotblocks: fix 32-bit build
  contrib/plugins/cflow: fix 32-bit build
  contrib/plugins/hwprofile: fix 32-bit build
  contrib/plugins/hotpages: fix 32-bit build
  configure: reenable plugins by default for 32-bit hosts

 configure                     | 21 +--------------
 contrib/plugins/cache.c       | 18 +++++--------
 contrib/plugins/cflow.c       | 17 ++++++++-----
 contrib/plugins/hotblocks.c   | 29 +++++++++++++++++----
 contrib/plugins/hotpages.c    |  6 ++---
 contrib/plugins/howvec.c      |  7 ++---
 contrib/plugins/hwprofile.c   | 27 ++++++++++++--------
 contrib/plugins/stoptrigger.c | 48 ++++++++++++++++++++---------------
 tests/tcg/plugins/insn.c      |  4 +--
 tests/tcg/plugins/mem.c       |  6 ++---
 tests/tcg/plugins/syscall.c   |  6 ++---
 11 files changed, 99 insertions(+), 90 deletions(-)

-- 
2.39.5


