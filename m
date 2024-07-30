Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37D69C3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 02:19:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYcRz-0007nD-Mo; Mon, 29 Jul 2024 22:18:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYcRx-0007g5-NN
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 22:18:53 -0400
Received: from mail-qv1-xf34.google.com ([2607:f8b0:4864:20::f34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYcRw-00063A-2z
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 22:18:53 -0400
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6b95b710e2cso24937716d6.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 19:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722305931; x=1722910731; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ul3diKbfJ0YtSu2RbIW4OgRaUQs29Fzjq5o0+nxb3ag=;
 b=fXM14EpAA4yc+DgrZ8C8O7ODFM47yQHoJGzfs/omu1/qCgWVRGVGdcfi0ugC9wlT/r
 Ja9DuhhEvS3j1DT0MmcIN+F/W5DSjoAfaF6nHkEuBB+9L35yZiiTHEeyE6qNXEt0+Dif
 /df9ltMueAyMinK4TAcpQV4DA9qudmUPmruT5MVaGTYFFfy4DmOgTqqVg5bi6Nc3i65N
 OXl6hXYtdxrLDXV/A/RJjidgXxaGmh69U/TU3YXRa6wQSKaZ0czaODb0//GL1VghNzuZ
 qVLkvDsnaQwbH24k6uxoxXcUHpx8u2c+edxaJ7MniZ52xh3RI/36dXFmKG8Kemj9sCLu
 /mCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722305931; x=1722910731;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ul3diKbfJ0YtSu2RbIW4OgRaUQs29Fzjq5o0+nxb3ag=;
 b=moie+FyLsT2bhdyGJVCOm6VJS6rl1OxLKSmgjnJi0bPlvWBmiSJRva7fNt6jtc1M+V
 BbrCqs6NJf9HOX3afvPZ13O29HZMAn+6I2ESuNUufgznD1d12dHITNPd8tmPE0Hb4RZ3
 2wt9vR8Jkapfa4xvd+2ntCFk8CNiYS8f3K1fGow+dT6OxZbaeLnlVhovVfCddJO+gaym
 I18EgzwBFGK7as0wnX8vevXp7E8yuvKFu6TgaLkPWygJ8tXZVtV1p7oIbwsiQIiflZz2
 MKpGyyno7LMvWUAf4pqq4zw3tL1Ez7/J2UfeW8DdPjPru07/mGSiEVFFWPuRDCbZK9rb
 YnVg==
X-Gm-Message-State: AOJu0Yz9L6KuG5XoscJ53/EPFDMvI+cFENkcFGIougFQDMdD5tsfETNz
 Vjcapf9QDpPjULrF0HidcdxsxG+e9TaYf1GSP6p1RPOckS343dyLqthQsfVljISJrN4Vj9Qmbdx
 TYnI=
X-Google-Smtp-Source: AGHT+IHug14QlIlSsaTWpvPTQ4GiFL49VBWS6vxiCqtUSjAIp5krF/eKZNUm6O/iNjmuVaoxOVu6xA==
X-Received: by 2002:a05:6e02:156b:b0:398:ca2b:2537 with SMTP id
 e9e14a558f8ab-39aec2c9cffmr102748305ab.3.1722301928196; 
 Mon, 29 Jul 2024 18:12:08 -0700 (PDT)
Received: from stoup.. ([203.56.128.103]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7a9f7c6ff4bsm6750206a12.4.2024.07.29.18.12.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jul 2024 18:12:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/5] misc patch queue
Date: Tue, 30 Jul 2024 11:11:56 +1000
Message-ID: <20240730011202.480829-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f34;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf34.google.com
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

The following changes since commit 93b799fafd9170da3a79a533ea6f73a18de82e22:

  Merge tag 'pull-ppc-for-9.1-2-20240726-1' of https://gitlab.com/npiggin/qemu into staging (2024-07-26 15:10:45 +1000)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-misc-20240730

for you to fetch changes up to d9b019e0a05cbbaa184815dd201b25006950c6d7:

  linux-user: open_self_stat: Implement num_threads (2024-07-30 07:59:23 +1000)

----------------------------------------------------------------
util/getauxval: Ensure setting errno if not found
util/getauxval: Use elf_aux_info on OpenBSD
linux-user: open_self_stat: Implement num_threads
target/rx: Use target_ulong for address in LI

----------------------------------------------------------------
Brad Smith (1):
      util/cpuinfo: Make use of elf_aux_info(3) on OpenBSD

Fabio D'Urso (1):
      linux-user: open_self_stat: Implement num_threads

Richard Henderson (1):
      target/rx: Use target_ulong for address in LI

Vivian Wang (2):
      util/getauxval: Ensure setting errno if not found
      linux-user/main: Check errno when getting AT_EXECFD

 linux-user/main.c      |  3 ++-
 linux-user/syscall.c   | 10 ++++++++++
 target/rx/translate.c  |  3 ++-
 util/cpuinfo-aarch64.c |  9 ++++++---
 util/cpuinfo-ppc.c     |  5 +++--
 util/getauxval.c       |  9 +++++++--
 meson.build            |  8 ++++++++
 7 files changed, 38 insertions(+), 9 deletions(-)

