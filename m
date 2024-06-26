Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7040C30659
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 23:39:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMcDV-0007T0-9f; Wed, 26 Jun 2024 19:38:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sMcDH-0007RT-DQ
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 19:38:07 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sMcDE-0007FM-Rr
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 19:38:06 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1fa3bdd91c1so31276515ad.2
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 16:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719445082; x=1720049882; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Vur5FgBBvNrr+CWbFl6sJPPgkraawbsHcuDeXMpGM7c=;
 b=XGZ2FQZvfM++JdarB0EPWFMhLawczOBQU1B/mMoTkYXwzbwKBYDD+PN8t06srPj81V
 2U2a2uhZbA9OYfj/s+gYcR0UEu7iCmhwVDtfghGDlSN6rq8WmujJYYVfRGu6tgHFmPCh
 /qpJrtzXrwYISqWud5Kl77qbTwoXeQzdzjqkP5QHDuTM5T1XnAlg22ZsMUkbGEv6Vtd/
 lU4OW73gV+UwsEId8oBCkI1GQmM2EzzmWNJx2T3T6W+/87BYHRtNxwnAJXf/JeWVyRD/
 N4tn1sqWPx78yAAp+XYffzH/jjr2xEsXkBoDEfPud3UF1TJ2tv7Checqp3CmNbP29KJL
 gk4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719445082; x=1720049882;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Vur5FgBBvNrr+CWbFl6sJPPgkraawbsHcuDeXMpGM7c=;
 b=p2L42PqF/iz//KVw1uEgjjvwV4AujVr2wnvEkC07GVP/FD44QLZRP6bSinWfJTcHeb
 7OMQ6U3RCAC+cZk2vDtl75U6YMNp2GntGJ97mkdwbUJEYHJtr2zD2uar+eG20X3EuuNc
 2bJhbSGHdqs9zPpnSDC7naezfXqLcp2h2mcrDVUYSqjJHsa80VuETewGL5yp5QjvPfGW
 Pba9M+0bHbEaf2915s54duyWvXECY5jq4gTsL5CD/KqgtiuoKP/E/WglfdQSUD6fdbhh
 0IVeK1idVvWDfovNNnWobtESeVViag7YFlz89CkoH6F+k249P+aL0JkUen84le9nYEMe
 HGag==
X-Gm-Message-State: AOJu0YzaIKidWDfcBOCgG8/IjVb9NDw+mkO/Phr8rhKcBGH2k7ofOFZW
 hl8nCeIHK2jODmgJEAYMi5swKL4nQAupGCAXlx2fMBtwLJXs+l/WEZERPQZW8ku4fYwaUte9EuP
 EpqE=
X-Google-Smtp-Source: AGHT+IFDlpDmr9Nkjb4JfIklxj2dlM93XgxqwMBwsfplMm+N10FJkCoR35p1UZHEpzyWrLUikEWaRg==
X-Received: by 2002:a17:902:db10:b0:1fa:104b:36a7 with SMTP id
 d9443c01a7336-1fa23ec3e4fmr145395795ad.17.1719445081503; 
 Wed, 26 Jun 2024 16:38:01 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::2193])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1faac8df624sm563055ad.29.2024.06.26.16.38.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jun 2024 16:38:01 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 0/7] plugins: access values during a memory read/write
Date: Wed, 26 Jun 2024 16:37:50 -0700
Message-Id: <20240626233757.375083-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
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

v2
--

fix compilation on aarch64 (missing undef in accel/tcg/atomic_template.h)

Pierrick Bouvier (7):
  plugins: fix mem callback array size
  plugins: save value during memory accesses
  plugins: extend API to get latest memory value accessed
  tests/tcg: add mechanism to run specific tests with plugins
  tests/tcg: allow to check output of plugins
  tests/plugin/mem: add option to print memory accesses
  tests/tcg/x86_64: add test for plugin memory access

 accel/tcg/atomic_template.h                 | 66 +++++++++++++--
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
 15 files changed, 395 insertions(+), 35 deletions(-)
 create mode 100644 tests/tcg/x86_64/test-plugin-mem-access.c
 create mode 100755 tests/tcg/x86_64/check-plugin-mem-access.sh

-- 
2.39.2


