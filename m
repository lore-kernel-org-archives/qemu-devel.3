Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00DF9C7115B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 16:17:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSHwQ-0001do-7t; Thu, 19 Jun 2025 12:16:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uSHvk-0001M1-7W
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 12:16:01 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uSHve-0003ev-2b
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 12:15:57 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-748f54dfa5fso647801b3a.2
 for <qemu-devel@nongnu.org>; Thu, 19 Jun 2025 09:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750349749; x=1750954549; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Td/YUYw5heI8txP6K6TrHnrdIOXWESZt2huN/q0tVNY=;
 b=dg92/WBlHm2UatRXKG02asE6qVqVYHfJha5QMR2FB72LhxuEf806jmDwAxPr4rn3I5
 kkgb6+hPQc6JzulS+SwvjXPjK6ZtDd2l0jqR1gFyv0SvGvrG8ejWkb3uua+8Npl9rGJz
 rTsu3A/4XNn7Tfb7PFKKACyDmZkp9TWroKHuT2bP28ONxVXjGX272xxuVoPyN52T48Qp
 6p15OZXFwYHEsSUMYKDn10s2fxHWMyEdAp9tu39zYbsg3JhezxB6GuwDcoAEaIJAYF74
 fnqDv3UZHvdkUQTLpLz10+c8J8UPOMoq0m/scwRonp8lP+eB1OjLeDXt+/L5z9r8fFDJ
 ykaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750349749; x=1750954549;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Td/YUYw5heI8txP6K6TrHnrdIOXWESZt2huN/q0tVNY=;
 b=eIaOewDllDeJTxy2beVKfJIfGy+u+OKMIzEvHm8K95CGs0wCrDTYp48JdB1AUbO5v0
 0ZMD+hSDcTgeGArPlLT6WPP127iLzwDdb5D+IUdu6rLnlvqoZUvL6WIhrdv3JfQ0TUsI
 sBd02BbZ+f4YfgWlqe3fHxSQzY2zVXBQBD7M2yDdMOqYtze4Xhwbw/Gwq91cw6Tbnfdf
 NB9JqRQkQ/MFTk0DlW6rw00rr3Z0jGzZcxuIR7NG3by9xRsCz7Le/EGebsdkvwPQOV7m
 CWJsC1bKFWR/z2tWjF+MCLU5V0zyeRwuVG+csc7mtWaDkyndNVuX5UbJlgewQJ1HeG/t
 WnnQ==
X-Gm-Message-State: AOJu0YzRrAROQzIHL2UEVsvqtctHoH9nnJNuEvDJlMA/ZSjzXoeMmsGb
 0sf01SUgCt9ic1sWBaERFfkgJzMCiBtz6zXJNkoYK/9FY+qamInnvDqrNoN9FQMT
X-Gm-Gg: ASbGncs3ZwQLpPWzG+95hpjrK/kj9rIXvPw+8Er3i1Ha3nEsaxaBiyoLpWFwfrUfET+
 i69QWfG6BEP86VwqMNYbBcDx+EjTXcy/9B29coTgQB+ZHAw/+ej8LLx32KM2QusAzPp6zPYZ6eu
 GWoIpDm5VgR5dMHxMFHW2besAlVaGLsk0KlbhiOAtcLIK13n49eGjX7CFvM5dtimbd9XopXPJUM
 tvDxJ6ijto3QGCoZ2BNEeYJqZtL3F9x7/E2CE89YtlPS7SyCw9gApSGE/MbNUPq3AFAvydyw3Nv
 BDTXq5FsDpx7lZHbMKbc01kAM8aL2+gRbyjUkgy96mHeV2myLmZSzjEU4bg59Q==
X-Google-Smtp-Source: AGHT+IFScIdW2fYfuexlI12ErQLDiph1olOdBQhm/TafJ253VFCOQhd3MlQl/2UAAfjfS7v5Bm3teA==
X-Received: by 2002:a05:6a21:3298:b0:1f5:83bd:6cc1 with SMTP id
 adf61e73a8af0-21fbd32afa3mr35211996637.0.1750349748750; 
 Thu, 19 Jun 2025 09:15:48 -0700 (PDT)
Received: from shemhazi.lan ([50.46.174.34]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b2fe168a0f8sm13168683a12.53.2025.06.19.09.15.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Jun 2025 09:15:48 -0700 (PDT)
From: Rowan Hart <rowanbhart@gmail.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Rowan Hart <rowanbhart@gmail.com>
Subject: [PATCH v13 0/7] Add additional plugin API functions to read and write
 memory and registers
Date: Thu, 19 Jun 2025 09:15:40 -0700
Message-ID: <20250619161547.1401448-1-rowanbhart@gmail.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=rowanbhart@gmail.com; helo=mail-pf1-x434.google.com
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

v8 reverts a mistake I made extending the size of arrays of TCGHelperInfo
structs, as I misunderstood their sizes. It preserves adding an explicit
zero as the last entry for clarity, however.

v9 fixes qemu_plugin_read_register to return -1 on parameter or flag state
error instead of 0.

In v10, I relaxed the restriction on when the register r/w functions can be
called, allowing all them to be used from any callback where the CPU is not
currently executing, with additional notes in the documentation for exceptions
(atexit and flush, which do not operate on a specific CPU and in which
current_cpu is not set).

v11 makes the cb flags functions inline and fixes a typo where cpu was asserted
but current_cpu was actually accessed.

v12 removes the hypercalls plugin because the functions it tested are also
tested by the patcher plugin, making it redundant. We'll circle back on a
hypercalls API in the future as a part of the plugin API, not as a plugin
itself.

v13 fixes up some issues Alex pointed out with the patch test. Now, the patch
target only runs with libpatch.so, and libpatch.so only runs with the patch
test.

Rowan Hart (1):
  plugins: Add enforcement of QEMU_PLUGIN_CB flags in register R/W
    callbacks

novafacing (6):
  gdbstub: Expose gdb_write_register function to consumers of gdbstub
  plugins: Add register write API
  plugins: Add memory virtual address write API
  plugins: Add memory hardware address read/write API
  plugins: Add patcher plugin and test
  plugins: Update plugin version and add notes

 accel/tcg/plugin-gen.c                    |  30 +++
 gdbstub/gdbstub.c                         |   2 +-
 include/exec/gdbstub.h                    |  14 ++
 include/hw/core/cpu.h                     |   1 +
 include/qemu/plugin.h                     |  15 ++
 include/qemu/qemu-plugin.h                | 176 ++++++++++++++--
 plugins/api.c                             | 135 +++++++++++-
 plugins/core.c                            |  33 +++
 tests/tcg/Makefile.target                 |   7 +-
 tests/tcg/plugins/meson.build             |   2 +-
 tests/tcg/plugins/patch.c                 | 241 ++++++++++++++++++++++
 tests/tcg/x86_64/Makefile.softmmu-target  |   7 +
 tests/tcg/x86_64/system/patch-target.c    |  22 ++
 tests/tcg/x86_64/system/validate-patch.py |  39 ++++
 14 files changed, 705 insertions(+), 19 deletions(-)
 create mode 100644 tests/tcg/plugins/patch.c
 create mode 100644 tests/tcg/x86_64/system/patch-target.c
 create mode 100755 tests/tcg/x86_64/system/validate-patch.py

-- 
2.49.0


