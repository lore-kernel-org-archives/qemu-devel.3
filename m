Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6797BC5B552
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 19:25:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOi6B-0007w5-PL; Mon, 09 Jun 2025 15:24:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uOi64-0007sz-Tw
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 15:23:52 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uOi5y-0002Qs-06
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 15:23:51 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-879d2e419b9so3974622a12.2
 for <qemu-devel@nongnu.org>; Mon, 09 Jun 2025 12:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749497023; x=1750101823; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qxWMjtr1fM1T4IMQK/JrfZ1AeXTPMKTKhrkuHqf2sac=;
 b=BnGZuZAK0a9RYLvpFEjeR+LNJwoKsm0koI4BIbleeuoEUf6YmC+MmkKQR1jSYAUVkx
 I/Yul2cQTBfuM66dBTSX4zQlEmo8ooC7cJFu3B8GdWDrZt/a9EqsTO87hvDEBCrh7pTF
 2Y+4DLKZaZpId87ZHQFa44sb+/SlIPVC/CTp76/UHw4jn+09lWKT3lUWm689YCY5S2NG
 8jbeshJglt4WHbMN7zWf2bbmcUR8fIGSsP67vhpzZ+hS5EyDa7pAwYsNfXBfOzzX2ZAF
 D+605J/uTVC4JUgSbLCph8B7OVJf2YWgdKhlROC+IilpsNGwOS7FKFC1iV6N0rZER9Kc
 8ogQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749497023; x=1750101823;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qxWMjtr1fM1T4IMQK/JrfZ1AeXTPMKTKhrkuHqf2sac=;
 b=TxboqzONWSpHsLvlbRPlJ3ic5QL7irnDIAL8WTHVPjZFcXDe4npg4T7bEcO5e91AqV
 wG7INvDTh0gCBS9X/gLR+d0jttGG8o+tQ4q+Rx//sxPYMW393MEFJpwl1oB9qFDO0jv9
 BcOOLtyvk9mhR4ApbnhL56bSGU6Gooraa26kE8Glc3BmK6UnwBz8nGirezecwVZWsciN
 p6UPoTqn8h6oKcLy7TRUfLLxyrUcU0rvP2KwEk60lJU82R/64eXdkVzKG5YmRO49uuuf
 URPIY2nozujJxpnKhfwGg4iCZ+PYiAs6IRmCGXkJKLg7rAt46VWgY+L3ZVtwA1M2SgRr
 HlqA==
X-Gm-Message-State: AOJu0YzMoRwcKWOsaDMDK83HX9A4iNZlIwQzD6oRgK5ghjay2wXWfVth
 lMrXjGcxBUyF4bDWVYhMuvYT9eH4eu980UET40fGBk4B6TDRHZI3OuoYGktuap0L
X-Gm-Gg: ASbGncsiihVrx9K6rMBwXTL4GA3J+1tAU54JBrYK+ugYPtLcIWY8XEtl1IY6TmaYPi3
 MbDslPDXRAZKS6GesBzVuP6LnQTaXiRmWSW9sMyBK9UOkzTiag82iZILPB5yVtkzT32Q5mNlVXo
 K4RPti3rCsbnyoXic33a8JFYnKIg9vSoIDQHaciaps9y8dHKcjWkfCc7yRmilN/iFrOHvXZ9af7
 +G9fs9nD8WyyB5t3iNNRtmTu0/5z6ItJ3wL4+zvmF17jtWL7T2y2O/GS7X567LathfOsOJPyLAx
 JkfbVRpmjklxVhICcwyrYJNLHlr6ge6a63UvcxvyU5cpNbHRtUQRQLfM3YpfjQ==
X-Google-Smtp-Source: AGHT+IF8Wzpvy1cvLHw29iL3xD7M4sPYr3D05VpqjSC/+OlgRM7KCvhdwjv2naK56fUCOGX7Xlq6iQ==
X-Received: by 2002:a17:90b:1d43:b0:311:c970:c9bc with SMTP id
 98e67ed59e1d1-31347077300mr20625274a91.30.1749497023449; 
 Mon, 09 Jun 2025 12:23:43 -0700 (PDT)
Received: from shemhazi.lan ([50.46.174.34]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3134b044ef2sm6057658a91.3.2025.06.09.12.23.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jun 2025 12:23:43 -0700 (PDT)
From: Rowan Hart <rowanbhart@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>,
 Rowan Hart <rowanbhart@gmail.com>
Subject: [PATCH v10 0/8] Add additional plugin API functions to read and write
 memory and registers
Date: Mon,  9 Jun 2025 12:23:34 -0700
Message-ID: <20250609192342.316156-1-rowanbhart@gmail.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=rowanbhart@gmail.com; helo=mail-pg1-x529.google.com
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

Rowan Hart (1):
  plugins: Add enforcement of QEMU_PLUGIN_CB flags in register R/W
    callbacks

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
 include/qemu/plugin.h                         |   6 +
 include/qemu/qemu-plugin.h                    | 176 +++++-
 plugins/api.c                                 | 135 ++++-
 plugins/core.c                                |  45 ++
 tests/tcg/Makefile.target                     |   2 +
 tests/tcg/plugins/hypercalls.c                | 547 ++++++++++++++++++
 tests/tcg/plugins/meson.build                 |   2 +-
 tests/tcg/plugins/patch.c                     | 297 ++++++++++
 tests/tcg/x86_64/Makefile.softmmu-target      |  36 +-
 tests/tcg/x86_64/system/hypercalls-target.c   |  40 ++
 tests/tcg/x86_64/system/patch-target.c        |  27 +
 .../tcg/x86_64/system/validate-hypercalls.py  |  40 ++
 tests/tcg/x86_64/system/validate-patch.py     |  39 ++
 17 files changed, 1416 insertions(+), 23 deletions(-)
 create mode 100644 tests/tcg/plugins/hypercalls.c
 create mode 100644 tests/tcg/plugins/patch.c
 create mode 100644 tests/tcg/x86_64/system/hypercalls-target.c
 create mode 100644 tests/tcg/x86_64/system/patch-target.c
 create mode 100755 tests/tcg/x86_64/system/validate-hypercalls.py
 create mode 100755 tests/tcg/x86_64/system/validate-patch.py

-- 
2.49.0


