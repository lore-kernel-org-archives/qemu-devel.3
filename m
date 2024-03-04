Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5942C54E41
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 13:01:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh7wQ-0000zu-Ki; Mon, 04 Mar 2024 08:01:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rh7wC-0000nG-GD
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 08:01:03 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rh7w9-0000Vm-9S
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 08:00:59 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a44628725e3so552069166b.0
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 05:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709557253; x=1710162053; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vt3WH01e9OeOZTYYqNhO1zrBMunPPC2f5o+P5PGgSEE=;
 b=Y9vHPHkevmBxXI0hrmotxluQP3p8SZ63H46vOxYjedHJarNSqwF3RgqIHe/NLka658
 RaP47GPtxMBYuHMOmTt28QmSP43X8Y2FX6SwVFs9VL3l+W1ZyIhWrKFAM8X/JW6Lg5xs
 ihZYkIPqRg4ZMDyi9fnVU2dDzt8Agj/Y2wYp5xURS+4otc/6+PjJ1Hv6N9sO4Eere8l0
 vDNiVRtY+bJYcCW3k9GDiBY/pLtrHHs5D65LoNoTL00ivXcHBuapno5BKAHpx2Gl95+f
 ojfQi1UEJAl6OetAC0LdUie84fMRDkeTiSi23GOSiQ/iz3z0X+3GUhi095qCGW8/dTSB
 oNzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709557253; x=1710162053;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vt3WH01e9OeOZTYYqNhO1zrBMunPPC2f5o+P5PGgSEE=;
 b=L6bveU6RBV6IljrFN4idDGtBrdeQ+KeEHE2YBj0/4HaFZpCA1phPLeXE+SJqO8Tz28
 Togta+yO66LUVX6HWKvm+BCpn2410c60drn033Opp1gStasPyPOmLcxMjN41rDn+m1bu
 Nx6KTPc59mSO+7F3O31khP10KGfHqF+zlJvGCdeU/crQuLLgkMh3VEzeQDQQBXZvqAOV
 PPGDgTfMMr/zf6ow53Dtx6Rowazij5RvxmtZjVX0qnXMBxf965qpdwvk8Z6bNZWNFW73
 t7qJIAv8x/oFcS3BWyvaVztvphzowrALY2Efqi28rBK9ukM+TbBe0xx0hQT9TughkYmr
 kExw==
X-Gm-Message-State: AOJu0YxuZ6AId8Dhul54xgUvxHWVekDKmaHG5I8eHY+G4W9Vekk8DtTJ
 IhSAIGONGeo/Xwy0z5aUURxqBFnX2mvDMl/8kPdXFrQThLsuguDclxl7AbJVHERz5MdXT/zstzr
 3Htc=
X-Google-Smtp-Source: AGHT+IFswqIELTg9TYpfal70zsgZPei1NlMWF10c+eXTdljowgawyidoJvhH1f6aqEhOB9tY3hc39A==
X-Received: by 2002:a17:906:4c54:b0:a45:6e43:4cf4 with SMTP id
 d20-20020a1709064c5400b00a456e434cf4mr962807ejw.60.1709557252893; 
 Mon, 04 Mar 2024 05:00:52 -0800 (PST)
Received: from debian.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 tj7-20020a170907c24700b00a413d1eda4bsm4806136ejc.87.2024.03.04.05.00.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 05:00:52 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v7 00/12] TCG Plugin inline operation enhancement
Date: Mon,  4 Mar 2024 17:00:24 +0400
Message-Id: <20240304130036.124418-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-ej1-x629.google.com
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

v7
--

- Fix parameters for plugin test (make check-tcg)

v6
--

- fix test/plugins/mem.c double count
- rebase on top of master, now that register api was merged

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
 tests/plugin/mem.c           |  46 ++++++---
 plugins/qemu-plugins.symbols |  13 ++-
 tests/plugin/meson.build     |   2 +-
 tests/tcg/Makefile.target    |   2 +-
 15 files changed, 709 insertions(+), 218 deletions(-)
 create mode 100644 tests/plugin/inline.c

-- 
2.39.2


