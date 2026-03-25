Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD6E8106B504
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 21:19:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5Vbd-0000lj-9G; Wed, 25 Mar 2026 17:17:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w5Vbb-0000kD-Ha
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 17:17:35 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w5VbZ-0000ov-1I
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 17:17:35 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-43b48ac2727so155823f8f.3
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 14:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774473451; x=1775078251; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DFkvAmpBgcXLjhSJ6HtykShHmLYUUVqXKJXM3fP38co=;
 b=atgaFd/WHrXBr+JYcrIRodlp/jVrV9hD2UorLg1NxHOX/joG6e+pYs3N9f8WWY9VjY
 OUq0dZ5o0delJqnW8NMYuTrBoz9Kke51hpDFfyjMyQMwznpKJO/XtXJdYwCU+TwrzwX6
 EPg9HXe556mBf55UAbjQ2HepRTE8bn5/Op5KTpX+p5F3yGBQbv2sm+JVsKrM8VvTb0Ka
 yJnJw108KNRYt1Rf1CT7Nw122i0HgOwiajynfXT54t3+3QgOy87dhPsvN1Ziub8s/sJ5
 e+ObsTowNTv+qmI6YKxu+ZsQpFNeSgYhE5hFc2yH7TimA7EbSQLOqEgniHwGb7/QM3Pl
 qhqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774473451; x=1775078251;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DFkvAmpBgcXLjhSJ6HtykShHmLYUUVqXKJXM3fP38co=;
 b=sTR9o0hq19+YtnLCnMEj6jGVRW3iqawcNxv6P2uNuohiWkQ6RCt/5XPtANJ2SCMC1v
 zeUOb+DS1vdwtljgIu0wsL5YmhWrldceowrOlX6qVN/iA6RtnAALFfY254egzYZ0F/Kk
 t2xvC7nwdbqf+D6/x/m0IcSrUbN5j5zpeFXDy6JQT5rqlL0j3SmJaPhYpBh1gjP0UTA+
 lNiXR0qqq5WfjQ32R2PFB9DdDdyhrmm6AbhzJt2s5RU3tncKfhHZsrDGr2AER+VfE5Pg
 knMfO097giMan1if4v1qpdCWuvsJSwxRY3ti8UhRDyaDJd5H8hNfmDQYKUqieQ7PC5p4
 wf0A==
X-Gm-Message-State: AOJu0YyZVZDRj92yFxW6lMYBUFNEEouVpSbEsHMRFOUBB2Zp7hjMhAMM
 5+zbwFMmYDM1NceyL5ojeI2oOekpURcRGGvKx732FCeUxEUbPApFJ4nFrtLbueBIJrfW4ZxUTKK
 Pr22iO9U=
X-Gm-Gg: ATEYQzxuEKIILHQEkhI+sn1E39C0QZ1W3F52ZmgXAU6aE96BeFwgezLybYz87BwaT8r
 242Y3fMglv+A/4V8MoCQ3pZyU/DhtjnxjRtB1QXhTGjfzpwdYqtJncQFfL3PtP04JeETu/eQF6h
 RtyY/TmZWc2UgVIxYFl9zs1YWtmhWWaNRX7bRGuAHbWP9fblNTR6RGOThvBNQFr3dadSZgoekqY
 GQOJkpgJ4KSo9ot7wYj9RRv8SxhlctZ8Qxk0Hn0zCCLJOEX68mc5ln5qx87UK0ls5gS6j27tQLi
 nCQnVh7rU/T2Fta+XgMQgJPh3yj3EK2Txagm6VG22H0BNks78UQ8UmLK8n9NbJ+cxokEfGdhCgY
 ckZNCJZxiXcH+hGUcTLxX2iOS6kvxMmZ+6noSumSpjm/w3gOsIgjLk70nWbT7ayxsIG/ObVpzHG
 Nr3XjhY3wYmmTDG5M334UccZ45mE4wiVNgnvftX0Q/0/a3DqJ1mm3E/IzX4Sorr4q6WkXE5o8o
X-Received: by 2002:a05:6000:26c6:b0:439:beee:43aa with SMTP id
 ffacd0b85a97d-43b889b2667mr7372819f8f.16.1774473451098; 
 Wed, 25 Mar 2026 14:17:31 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919cefd7sm2462474f8f.17.2026.03.25.14.17.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Mar 2026 14:17:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Glenn Miles <milesg@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>,
 Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-11.1 00/10] migration: Reduce uses of target-specific
 macros
Date: Wed, 25 Mar 2026 22:17:18 +0100
Message-ID: <20260325211728.89204-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

For the single binary (read heterogeneous emulation) project
we are trying to remove the uses of the 'target_ulong' type
in common code (or code that should be common code but is
compiled a target-specific one).

This series aims to reduce the use of migration target-specific
macros. Since there is still a lot of work to be done, we
introduce the TARGET_USING_LEGACY_MIGRATION_VMSTATE_UINTTL_API
definition to protect the targets which are already not using
these legacy migration macros.

Except for the SPARC targets, there should be no functional
change.

Philippe Mathieu-Daudé (10):
  target/avr: Avoid target-specific migration headers in machine.c
  target/loongarch: Avoid target-specific migration headers in machine.c
  migration: Revert "Add VMSTATE_UINTTL_2DARRAY()"
  migration: Remove unused target-specific macros
  target/sparc: Inline qemu_get/put_betl()
  target/mips: Inline qemu_get/put_betls()
  target/i386: Expand VMSTATE_UINTTL_SUB_ARRAY for APX registers
  target/i386: Inline VMSTATE_UINTTL_SUB_ARRAY() macro
  target/sparc: Replace VMSTATE_VARRAY_MULTIPLY -> VMSTATE_UINTTL_ARRAY
  migration: Restrict legacy VMSTATE_UINTTL() macros to few targets

 configs/targets/i386-softmmu.mak     |  1 +
 configs/targets/mips-softmmu.mak     |  1 +
 configs/targets/mips64-softmmu.mak   |  1 +
 configs/targets/mips64el-softmmu.mak |  1 +
 configs/targets/mipsel-softmmu.mak   |  1 +
 configs/targets/ppc-softmmu.mak      |  1 +
 configs/targets/ppc64-softmmu.mak    |  1 +
 configs/targets/riscv32-softmmu.mak  |  1 +
 configs/targets/riscv64-softmmu.mak  |  1 +
 configs/targets/sparc-softmmu.mak    |  1 +
 configs/targets/sparc64-softmmu.mak  |  1 +
 configs/targets/x86_64-softmmu.mak   |  1 +
 include/migration/cpu.h              | 59 ++++++----------------------
 include/migration/vmstate.h          | 22 ++---------
 migration/vmstate.c                  |  4 --
 target/avr/machine.c                 |  3 +-
 target/i386/machine.c                |  8 +++-
 target/loongarch/machine.c           |  2 +-
 target/mips/system/machine.c         | 14 ++++++-
 target/ppc/machine.c                 |  1 +
 target/sparc/machine.c               | 24 +++++++----
 scripts/make-config-poison.sh        |  1 +
 target/avr/meson.build               |  3 +-
 target/loongarch/meson.build         |  2 +-
 24 files changed, 67 insertions(+), 88 deletions(-)

-- 
2.53.0


