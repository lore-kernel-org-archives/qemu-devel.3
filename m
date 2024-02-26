Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78131C54E49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 09:15:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reX4g-0003LZ-TG; Mon, 26 Feb 2024 04:15:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1reX4e-0003KV-Mp
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 04:15:00 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1reX4c-0004xV-HF
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 04:15:00 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-412a882bd4eso979975e9.1
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 01:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708938896; x=1709543696; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FImTm6qKTdCcZYAmETBmxyqd65HCb3woMk0KDYn9l7w=;
 b=ThyBWpUm9rUlWwxPTuUvh3E+eoJoBmuu2cl5T16u6hodXI/mk+Po+TIdKoHWeRenLC
 NXWHcNGs1WYVlNR0FepZKPqpmdNuGjvF/TsPSgke4BwKLOOsF52NE10p2HDF1iDvNTnj
 iUkk2VVLRn78kmyy6xDBs7wjOQN6PyI+HfrxZs0gnEGEdhOFOLnlzwCyNeX8qeqdB824
 zFxZG8fCVgrsinDKU7PIwe/KgvZKiv0Gx5R9ZyYw87IvoCPzS6A6ByrmXzKgTLRr/ODx
 Py8MN85FH+JE2A3K+1guWvr0ubQn19tOgZVDL7E4LZ5RQ8DhdKGMFuyNYSeYpgy+y0yV
 2MNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708938896; x=1709543696;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FImTm6qKTdCcZYAmETBmxyqd65HCb3woMk0KDYn9l7w=;
 b=sBR/xZpEseKmEdjrpP5pdDCiUlesIHhMEC74y1fDuVhb+D5MqWEs1TSdCweRuHBObq
 azeJLT/VtZRjMD6V2Vp5znWRo66+4rIvJrOJvwUH9uAnIudlEWxBfgkye8gk/z/BCwaf
 vpF74xPf89CeyvWHFlJoSr8DnC//ArxUfvFVjWDfamEXlCKe/PPb2CnCMaRNIlb95zCy
 bVKMBQCEnB/XjMFqNdEcX87T8DCEL1bdx85nwlHl1lZCCKO645frrH8YhjKkqG33u23k
 4L794DpbkaWkNEg2/U5z6XyXqr6UoMig6dKcB9NnaYEdCPTnab5zVYBAjqt+sgUOriU/
 BXKg==
X-Gm-Message-State: AOJu0Ywi7C5zFIux6b6KIK6KD5TFfaWiUpxpEHRVP5KGXk82yhwAdDMr
 yoWeQGX/MQie87tR0kacbuE6XiehKebaxl+j50ukr+odbYkGipEzeWAp9ZDOsTNpSe9wCHfQDhp
 4QnJQYQ==
X-Google-Smtp-Source: AGHT+IGPlmDB8tDgpbvouLXbbBvKKpiS1lVJ3gmnTbn47g22bl49t1h19Xf4DuVzSe2kd0XxtM7neg==
X-Received: by 2002:adf:efc5:0:b0:33d:746b:f377 with SMTP id
 i5-20020adfefc5000000b0033d746bf377mr4306649wrp.45.1708938896557; 
 Mon, 26 Feb 2024 01:14:56 -0800 (PST)
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 g7-20020adfe407000000b0033d2ae84fafsm7578814wrm.52.2024.02.26.01.14.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 01:14:56 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v5 00/12] TCG Plugin inline operation enhancement
Date: Mon, 26 Feb 2024 13:14:32 +0400
Message-ID: <20240226091446.479436-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x32b.google.com
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

This series adds a new thread-safe API to declare inline operation
inside plugins. As well, it removes the existing non thread-safe API,
and migrates all existing plugins to use it.

Tested on Linux (user, system) for i386, x86_64 and aarch64.

To give some context, this a long term series of work around plugins,
with the goal to be able to do basic operations in a more performant and
accurate way. This will mean to add more inline operations and
conditional callbacks.

One final target of this work is to implement a plugin that implements
the icount=auto feature, and allow QEMU to run at a given "frequency"
based on number of instructions executed, without QEMU needing to keep
track of this.

Another final target is to be able to detect control flow changes in an
efficient and elegant way, by combining inline operation and conditional
callbacks.

v5
--

- fix bound for qemu_plugin_u64_loop
- skip double API bump for plugins
- rebase on top of 20240223162202.1936541-1-alex.bennee@linaro.org

Only existing plugins changes still need a review.

v4
--

- split scoreboard/qemu_plugin_u64 patches
- use list instead of hash table to keep track of scoreboards
- remove immediate in tcg code gen

v3
--

- introduce qemu_plugin_num_vcpus (how many cpus were initialized)
- fix order of plugin init/idle/resume callbacks
- scoreboard:
  - renamed qemu_plugin_u64_t -> qemu_plugin_u64
  - some functions rename for scoreboard api
  - qemu_plugin_u64 has only value based function (vs address before)
- various cleanup thanks to review of previous series

v2
--

Implement scoreboard API (cpu local storage), so plugins don't have to deal
with how many cpus are used.

Since plugins have been modified again, I didn't transfer any reviewed-by on
those commits.

Pierrick Bouvier (12):
  plugins: scoreboard API
  plugins: define qemu_plugin_u64
  plugins: implement inline operation relative to cpu_index
  plugins: add inline operation per vcpu
  tests/plugin: add test plugin for inline operations
  tests/plugin/mem: migrate to new per_vcpu API
  tests/plugin/insn: migrate to new per_vcpu API
  tests/plugin/bb: migrate to new per_vcpu API
  contrib/plugins/hotblocks: migrate to new per_vcpu API
  contrib/plugins/howvec: migrate to new per_vcpu API
  plugins: remove non per_vcpu inline operation from API
  plugins: cleanup codepath for previous inline operation

 include/qemu/plugin.h        |   7 ++
 include/qemu/qemu-plugin.h   | 142 ++++++++++++++++++++------
 plugins/plugin.h             |  17 +++-
 accel/tcg/plugin-gen.c       |  69 ++++++++++---
 contrib/plugins/hotblocks.c  |  50 ++++++----
 contrib/plugins/howvec.c     |  53 +++++++---
 plugins/api.c                |  92 ++++++++++++++---
 plugins/core.c               |  79 +++++++++++++--
 tests/plugin/bb.c            |  63 +++++-------
 tests/plugin/inline.c        | 186 +++++++++++++++++++++++++++++++++++
 tests/plugin/insn.c          | 106 ++++++++++----------
 tests/plugin/mem.c           |  40 +++++---
 plugins/qemu-plugins.symbols |  13 ++-
 tests/plugin/meson.build     |   2 +-
 14 files changed, 702 insertions(+), 217 deletions(-)
 create mode 100644 tests/plugin/inline.c

-- 
2.43.0


