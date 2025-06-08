Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFEC0C67861
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Jun 2025 23:09:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOP7q-0005r9-1s; Sun, 08 Jun 2025 19:08:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uOP7o-0005qY-1N
 for qemu-devel@nongnu.org; Sun, 08 Jun 2025 19:08:24 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uOP7m-0004aq-70
 for qemu-devel@nongnu.org; Sun, 08 Jun 2025 19:08:23 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-235d6de331fso44139265ad.3
 for <qemu-devel@nongnu.org>; Sun, 08 Jun 2025 16:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749424100; x=1750028900; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Su9cLDj5vrjdDFPIPvdmXxTbluw+kYjNW80Y6MYbCcs=;
 b=HZEm4phdLgMLgUXJZN/0JKgzi7H2enxCPPV5Enqwc6N3kSFpWrFd0xZqfwkVSt6Z7W
 +ahdkZkZHcHtF0kwp7EhqNrfAKaJcGjfmgHR5Lz6q9YzwbRlexp6XgKiA4FvsGoEVcMY
 8J0kcTaqYop/NVcy9IivJ5J6Y99fZC0kE0BJd/wogRbWVtPSSVp954N8aboY/J4vFol+
 eY8BKTCB5xlzzhMYWAkKIFGrTsKNe0JKpmapkurkw8Sg5bokkg+/kM7tgrUiLs+ywsk8
 ywFN2JHb4d7+S2IskuhVOrhk3MM6DAhMawOLSdZN2a1xvz3UNnMtXzohYXOb0eikmdi/
 M9Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749424100; x=1750028900;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Su9cLDj5vrjdDFPIPvdmXxTbluw+kYjNW80Y6MYbCcs=;
 b=WBKTc9/ts/fHVu4jf72inO3Eo+rFYvmI5fI5+Yi0kGK8O4AzZAlEJ1HEDa1sd+MCqS
 cCpxNsL0k015U4esUaDuhULhcUhPXEqM9Fpda43df5Pu/HkeHNgb8tRN4PujNWIaddD+
 28ZI3yCicHSYQPrP6tTZuEWbz8yfmwqr6QSrKSTyk+SolMh9mdHzmMXZNCHvyqaqgji8
 PT/qVOBDnaxAPj7qUCafhWqj36Nj78f46XkbhL1QYqkvG2BCc+v8Ruoy1UNXR1hxVhs4
 gAz8qUHRyieqKPM2fjmGWbKTegEWbz9SndCihsJfJFAZcJ0IZqdMdiJAJZd5i3KrYyFK
 R6Jw==
X-Gm-Message-State: AOJu0YyY95WdRRAGNMQhqT58/D6kTk+fK9fq2SnwgtG9thJZStgPD9xb
 d3XRndy5QQ+ViQRW6vhnZHG3E4NLXzeZqnFkSgJJ0ghEsPslbHiwNSqnzwK5LHDNkXU=
X-Gm-Gg: ASbGncvL9hIuxgMqDb/HZzDwtuu9xYqjzfvEVlVcqtwiAg8R1u6pbxaozSHAbL4jw4c
 K+ZbamTMT5W/QM/E94ytrxjwZsrXijZexTOeL1GHcWgxkvKKgg3oluFAoxxFezmdo9UWnkxBCp2
 7/Dg706YMJO3VLBfdgcGi2Fc0Lh6Tyww2mSH7ahGYHS/X2zc/Cd2VxN/tnzioEOmAypXGQca70S
 XPIyj2EC2hQVxfNP1DRF08TY8eHuNItxY7BJPebIgKdw24ROP2eHIeN90WsKIbdg13P0LxkKkg4
 uILNrRwiVMQCCH/lQFDXRPTxBc7CQojC9iq92JuGdss0WDxUgSM=
X-Google-Smtp-Source: AGHT+IG8dLykXIC6c3D5nHr9nWOSrf+/3fc/3l0kxGRKRN3f72cKBcoT0Sjj9XvXdx5wVhFNbd1evw==
X-Received: by 2002:a17:902:ea0d:b0:235:eb8b:9968 with SMTP id
 d9443c01a7336-23601d71213mr162651405ad.36.1749424100418; 
 Sun, 08 Jun 2025 16:08:20 -0700 (PDT)
Received: from shemhazi.lan ([50.46.174.34]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23603504f09sm43421325ad.223.2025.06.08.16.08.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Jun 2025 16:08:20 -0700 (PDT)
From: Rowan Hart <rowanbhart@gmail.com>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Rowan Hart <rowanbhart@gmail.com>
Subject: [PATCH v9 0/9] Add additional plugin API functions to read and write
 memory and registers
Date: Sun,  8 Jun 2025 16:08:10 -0700
Message-ID: <20250608230819.3382527-1-rowanbhart@gmail.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=rowanbhart@gmail.com; helo=mail-pl1-x636.google.com
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
 plugins/core.c                                |  20 +
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
 18 files changed, 1380 insertions(+), 44 deletions(-)
 create mode 100644 tests/tcg/plugins/hypercalls.c
 create mode 100644 tests/tcg/plugins/patch.c
 create mode 100644 tests/tcg/x86_64/system/hypercalls-target.c
 create mode 100644 tests/tcg/x86_64/system/patch-target.c
 create mode 100755 tests/tcg/x86_64/system/validate-hypercalls.py
 create mode 100755 tests/tcg/x86_64/system/validate-patch.py

-- 
2.49.0


