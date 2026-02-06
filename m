Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29F60EE6B43
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 18:05:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voQCs-0007yL-Ah; Fri, 06 Feb 2026 13:05:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1voQCq-0007wc-Bl
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 13:05:24 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1voQCn-0001QY-DU
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 13:05:24 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6582e8831aeso4130722a12.1
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 10:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770401119; x=1771005919; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5Zz+rNGH/Nf5KQWfwbH2Wczx0QoSWFsfc3orZ3scO6c=;
 b=nEaI4ScaPeZBQ1p2haQWqeMJQllWP7WGJHIsc8nXYvL1Ak4zY8ld+A9WQXWN4OyfMg
 f/vE41Gw/j65WiQm7TMjaMQBOM8Gy8BwEAwMWbFi9x2vglzNechAVLKVLLSu2/0oQ+94
 ooz9fLnTomQjb4QGK3AdWeEQz3/0qtqMqNBQ/aQ1ps7SC3P1UC0BiwGEQPvrWs+R6uat
 qBX4wwp8/53rGWEiq5gh44QVBPRpHClbBiLr3xbJpIPmKmx0dKYdRiV/4e/qBUITJGNG
 MgvLE26dTH/uafhaWKhW3L43K2Ub5X73+o4v+pB3+o0sz8hTzyZKeZaaktWo6lkmcg52
 rVyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770401119; x=1771005919;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5Zz+rNGH/Nf5KQWfwbH2Wczx0QoSWFsfc3orZ3scO6c=;
 b=r2YGvhjwKnmRfWCxpiv4wnRjI5OPjqfeQrfw2/kYAolp+dLy1oldqyYMx+yu2P9Jzt
 yTAnXpDTSokwmRX4ZfmM5+RwOEm7lm9a80HwAHS31fxTuqAKP5+Pdb1HaIr6J1jjr2N5
 aj8XVXOU10c2q4ITl1CSYjznI2nLxXpnrfRzBi9HNoFCqWV6nU6DdpuDiWl5nTpdUajx
 B6JmrxcdIRlbfmIqsVxkFWS78/zGugmC45s4rDzXlX3Z6YMSNxwL6kAQFxzWUI01z8hj
 /7BddRh16Rt0CEJ7MkeV4K9WcNs533JP97b3sofKlt+UbjSlKVMmlKzx91JoAQn9I2q/
 kTvw==
X-Gm-Message-State: AOJu0YxYabe6DapBO/dXKV4sa3AihUoZEv6opVuPr/9pdAunkx9ivESX
 euqKoDcjttKWZ9Sq9aUjdBJMu4EbOxyc/52lCzT0GbxoD9FZ7UxHv9vpGiTrd8BrnN0=
X-Gm-Gg: AZuq6aKJq/8DaAajGCh/XftEIYMpcGPFZRC3p0OOdK/9J4ofkO9rh5ibdpJo/hoNaWk
 NhqIabKByWnN+Lvf7PxlZma48rojhpJkaEw19nD2HlnxFJfUnyZF4ODrNhDQbd61Fsa1BMq8jeb
 OH+Xo3sJ9oiqMkNWIacsTjWGb2Iu8jBNFb3+fGX6BKjElgZoaNeyZ1rr1iEd96O+DIsqwpxPqsd
 VY1uKYoo5hZ16rjtCvzEAM3HfasH6K5lp2MzJ0fPfJRyQ1SZDTpshfFaLuWQL4H8L+z52Hl8/Nf
 o1t0qMOgQcb5JSVJEMfRvGgVhUNGk+rYrnwOB2vjUSx98Crymnm1tz0YalSN9CLJE1UVCB9kIBj
 sweGLMkXbVrU4sbKFsuUBgtApAEwfjshCLfqhnFyjoPdLi6Krz4daF3fidVwJE+8NBlsW9FR86S
 S2S/8Uk3kHxdc=
X-Received: by 2002:a17:907:d18:b0:b88:32a4:6123 with SMTP id
 a640c23a62f3a-b8edf23efcemr217337666b.21.1770401119238; 
 Fri, 06 Feb 2026 10:05:19 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8edacb18d0sm98730766b.40.2026.02.06.10.05.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Feb 2026 10:05:18 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B9EB75F806;
 Fri, 06 Feb 2026 18:05:17 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 00/10] gdbstub updates
Date: Fri,  6 Feb 2026 18:05:07 +0000
Message-ID: <20260206180517.1335861-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x529.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The following changes since commit cd5a79dc98e3087e7658e643bdbbb0baec77ac8a:

  Merge tag 'for_upstream' of https://git.kernel.org/pub/scm/virt/kvm/mst/qemu into staging (2026-02-05 13:54:50 +0000)

are available in the Git repository at:

  https://gitlab.com/stsquad/qemu.git tags/pull-11.0-gdbstub-updates-060226-1

for you to fetch changes up to db13b4e262bfcd7b5f66a303bcb4b81d71029cfc:

  gdbstub/user: rename and use bool for running_state (2026-02-06 12:43:07 +0000)

----------------------------------------------------------------
gdbstub updates:

  - don't duplicate gdb help text in configure
  - re-build meson-buildoptions.sh if the python updated
  - re-factor stop packet handling
  - add EIO and ENOSYS errno defines
  - move host_to_gdb_errno into common gdbstub code
  - return GDB errno values for F packets
  - bool-ify user's running_state state

----------------------------------------------------------------
Alex Bennée (7):
      meson-buildoptions: Remove duplicated entry of --gdb in the help text
      Makefile: add python script dependency for meson-buildoptions.sh
      gdbstub: remove the need for goto cleanup
      gdbstub: extract stop reply message construction
      gdbstub/user: localise variables for reading gdb socket
      include/gdbstub: tweak language
      gdbstub/user: rename and use bool for running_state

Yodel Eldar (3):
      include/gdbstub/syscalls: Add EIO and ENOSYS GDB File-I/O errno values
      gdbstub: Export host_to_gdb_errno File-I/O helper function
      gdbstub/user-target: Convert host errno to GDB File-I/O errno

 Makefile                      |  2 +-
 gdbstub/internals.h           | 10 ++++++++++
 include/gdbstub/commands.h    |  2 +-
 include/gdbstub/syscalls.h    | 11 +++++++++++
 gdbstub/gdbstub.c             | 45 ++++++++++++++++++-------------------------
 gdbstub/syscalls.c            | 36 ++++++++++++++++++++++++++++++++++
 gdbstub/system.c              | 11 +++++++++++
 gdbstub/user-target.c         | 13 +++++++++----
 gdbstub/user.c                | 40 ++++++++++++++++++++++++--------------
 target/m68k/m68k-semi.c       | 29 ----------------------------
 scripts/meson-buildoptions.py |  9 ++++++++-
 scripts/meson-buildoptions.sh |  1 -
 12 files changed, 132 insertions(+), 77 deletions(-)

-- 
2.47.3


