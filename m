Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9CEFC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 15:07:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1p4T-0000zG-D4; Tue, 30 Apr 2024 11:07:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1s1p4N-0000yH-0T
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 11:07:00 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1s1p4J-00009G-EG
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 11:06:58 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-57225322312so7743964a12.1
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 08:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714489613; x=1715094413; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=l6rKvmRL4gsTcoq0SA7Yj4kOTSeo/cETlee74uFfkWo=;
 b=iJNnmVKW9ZYNeN48AkLuu4yGj9IBkVqRvaWZEx8tNf1YIME7Qk3igPN+Ql0ACnlS9r
 wGkrNpzWPlAKu74zqTyP8/OgkppKu4Jo+TTTOn5Kqk+wx9/2QJTxueoff3bAkJG1ns7r
 kV+aHXnfUmLA4Vdzb2KUgCT9L5W1uVE9lKpv7XH6n7I4Kz09r1nqVSaL442WXSTXT5Xv
 0Pp9mcOP4rJRggIbJhhpfXyduDqyg+kL+vje8uKxS/1MYmysf1H8WKhnt6EIlE86k10D
 OHEmczo9r7cqh/TS0yFjHiDpohoDoVLrx+8Zw1Di0N+O6bHny/YBxNKiiGxtjzeC3VzE
 /6qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714489613; x=1715094413;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l6rKvmRL4gsTcoq0SA7Yj4kOTSeo/cETlee74uFfkWo=;
 b=cv0YT4Q+HMKgd/17BeTLjhxlhdW2qRJTL/hl6GcMkdX327+f4h4s59I8qGB5M7ovlT
 vqY954PxcvJgdA6IppSuCbdkup07y1HZqh1hfPyT142dehqklEiUqoSUc85TcYtj8Wcz
 60quf4vqthWeqPYGzgKVBwcWbpbHukKJRLqsv7fJcF6O7mgHRerVw84k107XQVLWC6/v
 7u/UvL/zOvPxjmMFILbiMQUBlhDnO4rNuTeTb8usq+jOfpg9/9SZ9MduH3k6xfDMkZxx
 i0hH6LV0CCKgbVi2eHAxAI9swpgfSbaCPvxCk9CqYdxMY5VMLG+tc5c3dukljysYg4e+
 Busw==
X-Gm-Message-State: AOJu0YyPElBogGEOv2GasotIF3w6POujRYqMMWDobRZye6Wsp96Nv2PR
 PGDIyWjpdow6ODL+FLP3xBxQ4sfT2FbIq6TUOZNW8a2mDwdbyJJPibqdhQ==
X-Google-Smtp-Source: AGHT+IHwUcflWzCSJnO4X8MplGmb/0Babt4PcKVx+zhCkxNI9UscwU4L01SJA+B2rEX26Q2KbqJb6A==
X-Received: by 2002:a50:d556:0:b0:572:a6f5:bc91 with SMTP id
 f22-20020a50d556000000b00572a6f5bc91mr39321edj.24.1714489612456; 
 Tue, 30 Apr 2024 08:06:52 -0700 (PDT)
Received: from archlinux.. (pd9ed788d.dip0.t-ipconnect.de. [217.237.120.141])
 by smtp.gmail.com with ESMTPSA id
 11-20020a0564021f4b00b005727e826977sm2345741edz.19.2024.04.30.08.06.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 08:06:52 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Sergio Lopez <slp@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 0/6] This series changes the "isa-bios" MemoryRegion to be
 an alias rather than a
Date: Tue, 30 Apr 2024 17:06:37 +0200
Message-ID: <20240430150643.111976-1-shentey@gmail.com>
X-Mailer: git-send-email 2.45.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

region which matches real hardware and which some real-world legacy bioses =
I'm=0D
running rely on. Furthermore, aliasing in the isa-bios area is already the=
=0D
current behavior in the bios (a.k.a. ROM) case, so this series consolidates=
=0D
behavior.=0D
=0D
For migration compatibility the aliasing is only performed on new versions =
of=0D
the q34 and pc machine types.=0D
=0D
v2:=0D
* Don't leak bios memory regions (Phil)=0D
* Add compat machinery (Michael)=0D
=0D
Testing done:=0D
* `make check` with qemu-system-x86_64 (QEMU 8.2.2) installed. All tests=0D
  including migration tests pass.=0D
* `make check-avocado`=0D
=0D
Best regards,=0D
Bernhard=0D
=0D
Bernhard Beschow (6):=0D
  hw/i386/x86: Eliminate two if statements in x86_bios_rom_init()=0D
  hw/i386: Have x86_bios_rom_init() take X86MachineState rather than=0D
    MachineState=0D
  hw/i386/x86: Don't leak "isa-bios" memory regions=0D
  hw/i386/x86: Don't leak "pc.bios" memory region=0D
  hw/i386/x86: Extract x86_isa_bios_init() from x86_bios_rom_init()=0D
  hw/i386/pc_sysfw: Alias rather than copy isa-bios region=0D
=0D
 include/hw/i386/pc.h  |  1 +=0D
 include/hw/i386/x86.h |  7 ++++++-=0D
 hw/i386/microvm.c     |  2 +-=0D
 hw/i386/pc.c          |  1 +=0D
 hw/i386/pc_piix.c     |  3 +++=0D
 hw/i386/pc_q35.c      |  2 ++=0D
 hw/i386/pc_sysfw.c    | 17 ++++++++++------=0D
 hw/i386/x86.c         | 45 ++++++++++++++++++++++---------------------=0D
 8 files changed, 48 insertions(+), 30 deletions(-)=0D
=0D
-- =0D
2.45.0=0D
=0D

