Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65F3BC27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 23:13:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMbp3-000385-5o; Wed, 26 Jun 2024 19:13:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sMbp1-00037n-Lx
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 19:13:03 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sMboz-0000O5-T5
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 19:13:03 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1fa244db0b2so37305145ad.3
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 16:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719443579; x=1720048379; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bWHbxHSxdgz6rxef5BbyKktjuRNkDnV5c7BTIo2gVmA=;
 b=d3JOm+583S+wc24q1Zbd9IdlC2wtrKSgUeE5seJ5GnDkKdXHBTBg8NJMilB6PtbeT5
 CvKBPuiMnJCAdwc24PRbNF28VrB/AOC4BlG/WI2mCjKEpUPgugyv86FGOk3sFr+CKlCg
 kEfDV2Kg0OhWko898hF+FdYG/97e8d+2Hz42z+O+BjG9Ix8YNazT0xFwZ0oAsbVmflMh
 3PNVLOKZkpn9KCEw6dOjIdw59lb5Vl3vbhqQuerYLQTAmVpxORq6SRuSmfJSNTSN9X/N
 cNWU3BZ+B3XgInB/j6sdOFFRpKyOc74iWNkx19HMkkcDOG+gvq1aZ9yYsBR3SKX001Bc
 5gZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719443579; x=1720048379;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bWHbxHSxdgz6rxef5BbyKktjuRNkDnV5c7BTIo2gVmA=;
 b=xClck4jMYEl7nMLJNqHHxLk5bpd3aJQld+9ZSQEC+wVmbNHTr0OK1ECNEjnW547bTv
 thhk9bm2XXZosfbASdnfyyuUuEhHRCQENVLb5sHanNahvB5XMu3qGxfK5C5ydRNSoj3y
 czrNtjR9l1fKZpTnWYBvfbB4h8b5jyAd1qx71bqlDcO4y3r0n0+G/UkJKoTc6l82gk3x
 BGCONeWOotzNraoXEiQ4MbtdqNNmNopP7STVQaeNTpDQcRUzX41VWU25781yc32ftrjj
 iHRWksyTw/ZPNL9pBt1LYtIhiR3ev9JDfa8SwoqN/1IDxBHhoHMueuZGZprZUTvbljT2
 SyxQ==
X-Gm-Message-State: AOJu0Yy64DqFgaX0c5dv5DlDLhZaTsOM6my7KSMMbx4I2bf7Udud2Kv+
 qx9ZzYmmWvHVJI35cdtHUvhi4faU1m7vEYF40hVsymny8rU9Hcew6uHlGn4zWyxledMpOeXTt4I
 55Os=
X-Google-Smtp-Source: AGHT+IHnj1bZc/iY5DKxumsXlV/JxiO/FwBhe7Go5CHiUOi07+y7/otssDt05aMGmHIhkzIq632mhw==
X-Received: by 2002:a17:902:d4c7:b0:1fa:128c:4315 with SMTP id
 d9443c01a7336-1fa15937ac6mr135336835ad.44.1719443578738; 
 Wed, 26 Jun 2024 16:12:58 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::2193])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1faac82cd3bsm478215ad.0.2024.06.26.16.12.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jun 2024 16:12:58 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 0/7] plugins: access values during a memory read/write
Date: Wed, 26 Jun 2024 16:12:48 -0700
Message-Id: <20240626231255.339353-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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

This series allows plugins to know which value is read/written during a memory
access.

For every memory access, we know copy this value before calling mem callbacks,
and those can query it using new API functions:
- qemu_plugin_mem_get_value_upper_bits
- qemu_plugin_mem_get_value_lower_bits

Mem plugin was extended to print accesses, and a new test was added to check
functionality work as expected. A bug was found where callbacks were not
called as expected.

This will open new use cases for plugins, such as following specific values in
memory.

Pierrick Bouvier (7):
  plugins: fix mem callback array size
  plugins: save value during memory accesses
  plugins: extend API to get latest memory value accessed
  tests/tcg: add mechanism to run specific tests with plugins
  tests/tcg: allow to check output of plugins
  tests/plugin/mem: add option to print memory accesses
  tests/tcg/x86_64: add test for plugin memory access

 accel/tcg/atomic_template.h                 | 64 +++++++++++++--
 include/qemu/plugin.h                       |  8 ++
 include/qemu/qemu-plugin.h                  | 20 +++++
 accel/tcg/plugin-gen.c                      |  3 +-
 plugins/api.c                               | 21 +++++
 plugins/core.c                              |  7 ++
 tcg/tcg-op-ldst.c                           | 72 +++++++++++++++--
 tests/plugin/mem.c                          | 28 ++++++-
 tests/tcg/x86_64/test-plugin-mem-access.c   | 89 +++++++++++++++++++++
 accel/tcg/atomic_common.c.inc               | 13 ++-
 accel/tcg/ldst_common.c.inc                 | 38 +++++----
 plugins/qemu-plugins.symbols                |  2 +
 tests/tcg/Makefile.target                   |  8 +-
 tests/tcg/x86_64/Makefile.target            |  7 ++
 tests/tcg/x86_64/check-plugin-mem-access.sh | 48 +++++++++++
 15 files changed, 393 insertions(+), 35 deletions(-)
 create mode 100644 tests/tcg/x86_64/test-plugin-mem-access.c
 create mode 100755 tests/tcg/x86_64/check-plugin-mem-access.sh

-- 
2.39.2


