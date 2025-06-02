Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A70CC5B559
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 19:59:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMBHW-0004JW-VZ; Mon, 02 Jun 2025 15:57:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uMBHU-0004J5-Mg
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 15:57:12 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uMBHR-0004qV-De
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 15:57:11 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-73972a54919so4219801b3a.3
 for <qemu-devel@nongnu.org>; Mon, 02 Jun 2025 12:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748894228; x=1749499028; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IAXt1W/zUR31UqhhUYbswiahGjC6fEsaj/iooiJKKuY=;
 b=P5IDJvY1p2aONOSR5ufm3sKGllYy8S8ey3+yMLB35yyyQARWzx7qwURL50LuElSyt3
 L1J2FvJXwjuV9HpxmjynV+K4XofdmggpaumiBZReRJL+Xupl1SEhKFgGsz5za6++5YJT
 EEopeaTZCyf2c+YUK2u0Kwc8L8ecTSLBr/2IDctaXAYYmgfaloxBzYJL+0Xv9DjnC1VT
 7Sosh2NZ6rkoNPsHB8GRukt2wOOeDOaupnQ01aoqyiEKmziz+PsfRCUH0vGqasJdRBUZ
 QHvAdOxg4ftfNtWtxgoE+X+i+lEzVSsmMGmvMWK4IP5Lkl5FZ+PwHHPzOWmIo/qhmOMg
 92gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748894228; x=1749499028;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IAXt1W/zUR31UqhhUYbswiahGjC6fEsaj/iooiJKKuY=;
 b=VyZv758pS/GzexrPzubYQafnn0QgV82wgtbvvaDbnWO6TAxb5U2NFee2n4/LvUeRO3
 Kj74pKAcKidZA7+qQec/RO18mCYvcEDQy9OPXZr3Y0ccXKmioxVo8puFxmE/E3r1fuu5
 1tm50tl1AScaKi/pFlsr+vjLL/P/QlfOwB2f0qKiPI/+rKKTXNdf54DvabdELRiaf3X1
 cyciyy5E7HZsiECwa9C1tJ68u4fa9wj4AF+N4nthU3JYYdAjuIlpr/i2PRyxs50YraAC
 /nLpRf8skh8Koc5JJ8W7KCF43hUKLyhLLeUYOLqqcFsaDn4DnT1LvsfNu93K8DKKJiYS
 hzvA==
X-Gm-Message-State: AOJu0YxfCnR/R44AzjyyMn3csWHNxPbjOVKDaTZ4f4y+Jch9Iow4k1Yq
 Knqzng7BPbgd/L1sk4bJVLCgit543ChZwRfk+BMEGvFyKlDs2NiWyuJXVj97jIPWGvk=
X-Gm-Gg: ASbGncsM1jke0okEc7cFSwGQaocJpMp7H5veMXyrDu3+8TF88HZhbU0PTQM6S3pG0Hi
 4fE54wjb3eVNk9irYigZTHbX0Y9pNEiU1yZ4/TTsQTVvXEx2yaOCVaBnlf4YUrEDB7HZ5zlHX+C
 XvQrpzEy7JswZL9X393hncUKVA1VzDeJa6+mmbusCG1JglWrZ4ShmNnN7InpMNWkGmK/+quC225
 OetSbhqjhlP1EKswcRwx6w/0Km5jIaD5uhTHaQWl9S7iT2W0rjHb7l0AJ37l9/UzuYBHBl4lPla
 siqZXu4trreFYrZHoWStumzuRa8w9D/iAMESxhISjMwfKJvN4Hg=
X-Google-Smtp-Source: AGHT+IHIT8YW7nYEoHVKT+cKdQccYU9TfFeCnLx2rf+gT1N+bBCvGYzj8D70N8K1mrrAidiVN3RSfw==
X-Received: by 2002:a05:6a00:9292:b0:739:50c0:b3fe with SMTP id
 d2e1a72fcca58-747d18333c9mr13705678b3a.8.1748894227522; 
 Mon, 02 Jun 2025 12:57:07 -0700 (PDT)
Received: from shemhazi.lan ([50.46.174.34]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-747afeab820sm8244575b3a.60.2025.06.02.12.57.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Jun 2025 12:57:07 -0700 (PDT)
From: Rowan Hart <rowanbhart@gmail.com>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Rowan Hart <rowanbhart@gmail.com>
Subject: [PATCH v7 0/9] Add additional plugin API functions to read and write
 memory and registers
Date: Mon,  2 Jun 2025 12:56:57 -0700
Message-ID: <20250602195706.1043662-1-rowanbhart@gmail.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=rowanbhart@gmail.com; helo=mail-pf1-x42c.google.com
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

This patch series adds several new API functions focused on enabling use
cases around reading and writing guest memory from QEMU plugins. To support
these new APIs, some utility functionality around retrieving information about
address spaces is added as well.

The new qemu_plugin_write_register utilizes gdb_write_register, which is now
declared in gdbstub.h for this purpose instead of being static.

qemu_plugin_write_memory_vaddr utilizes cpu_memory_rw_debug much the same as
the existing read_memory_vaddr function does.

The read and write_hwaddr functions are the most different. These functions
use address_space_rw, which works well in most cases. There is an important
caveat that for writes, the page being written will be set dirty by the
write operation. This dirty setting requires locking the page range,
which can contend with an already held lock in page_collection_lock
when called in a tb translate callback with a write to the instruction
memory in the tb. The doc comments warn against doing this, and it's unlikely
anyone would want to do this.

I've also added two test plugins: one that implements a simple hypercall
interface that guest code can use to communicate with the plugin in a
structured way with a test to ensure that this hypercall works and writing
virtual memory works. And one that implements a simple patch utility to patch
memory at runtime. The test for the second plugin ensures the patch applies
successfully to instruction memory, and can use both hw and vaddr methods.

For v3, I've had a few comments from the last submission that I've addressed,
and some that I haven't for one reason or another:

- Enforce QEMU_PLUGIN_CB_ flags in register read/write operations: done!
- Fix my commit messages and add long messages describing commits: done!
- Un-expose AS internals: done! Functions operate on current vCPU, current AS.
- Clean up use of current_cpu: done!
- Make functions take a vcpu_idx: not done. May revisit but it allows footguns.
  Even for translation, seems best to not do this now. We can easily add _vcpu
  versions of these functions in the future if we change our minds!

For v5, I've just updated the enforcement of the QEMU_PLUGIN_CB_ flags to just
use immediate stores, which simplifies the implementation quite a lot and
should be more efficient too. Thanks Pierrick for the suggestion!

v6 is a formatting pass, I left some whitespace that needed removal, some
license text was wrong, and so forth.

Rowan Hart (2):
  plugins: Add enforcement of QEMU_PLUGIN_CB flags in register R/W
    callbacks
  plugins: Remove use of qemu_plugin_read_register where it is not
    permitted

novafacing (7):
  gdbstub: Expose gdb_write_register function to consumers of gdbstub
  plugins: Add register write API
  plugins: Add memory virtual address write API
  plugins: Add memory hardware address read/write API
  plugins: Add patcher plugin and test
  plugins: Add hypercalls plugin and test
  plugins: Update plugin version and add notes

 accel/tcg/plugin-gen.c                        |  30 +
 gdbstub/gdbstub.c                             |   2 +-
 include/exec/gdbstub.h                        |  14 +
 include/hw/core/cpu.h                         |   1 +
 include/qemu/plugin.h                         |   4 +
 include/qemu/qemu-plugin.h                    | 166 +++++-
 plugins/api.c                                 | 135 ++++-
 plugins/core.c                                |  32 +-
 tests/tcg/Makefile.target                     |   2 +
 tests/tcg/plugins/hypercalls.c                | 547 ++++++++++++++++++
 tests/tcg/plugins/insn.c                      |  22 +-
 tests/tcg/plugins/meson.build                 |   2 +-
 tests/tcg/plugins/patch.c                     | 297 ++++++++++
 tests/tcg/x86_64/Makefile.softmmu-target      |  36 +-
 tests/tcg/x86_64/system/hypercalls-target.c   |  40 ++
 tests/tcg/x86_64/system/patch-target.c        |  27 +
 .../tcg/x86_64/system/validate-hypercalls.py  |  40 ++
 tests/tcg/x86_64/system/validate-patch.py     |  39 ++
 18 files changed, 1386 insertions(+), 50 deletions(-)
 create mode 100644 tests/tcg/plugins/hypercalls.c
 create mode 100644 tests/tcg/plugins/patch.c
 create mode 100644 tests/tcg/x86_64/system/hypercalls-target.c
 create mode 100644 tests/tcg/x86_64/system/patch-target.c
 create mode 100755 tests/tcg/x86_64/system/validate-hypercalls.py
 create mode 100755 tests/tcg/x86_64/system/validate-patch.py

-- 
2.49.0


