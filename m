Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33A75C7EE2A
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 17:55:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uU7qZ-00033p-Mf; Tue, 24 Jun 2025 13:54:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uU7qL-0002x1-CH
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 13:54:01 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uU7qH-0002lm-7I
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 13:54:00 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-73972a54919so4443273b3a.3
 for <qemu-devel@nongnu.org>; Tue, 24 Jun 2025 10:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750787633; x=1751392433; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=N6BRfAQFkVAoPWiGigXYDEjYpDmpp8gw4u19/+JOvLQ=;
 b=kIXWXHpzCFjEabAoAtnEVOzjjP73hfGw0zae/qNQt5f+Uzn/zqVsLBwB6Toc3ChEQu
 eIVoqM/3qB0v/EkvjUjAah2EXM83njb43Weu7KGAD2MlYe6T1iP7Artwkf4hwuIa3F86
 oGerVqjLV8ANo63Wx2gBEeytIfDe6S+bXk6Xgt8rfJpvVV53dSiGdhs79V16M2FfEm71
 CKiyo6Fg0NL9aP3q+3axkHN5X6mD0tkYGMarem/5Puyu/b0SzxTumAtJ4GOY6a9MDAZH
 j6g0DtQKK4BlCBgFWZExYXCZGjF+nl+K2OL8iHqFldmJWQey/TyprJqrvRbrhURu/o9j
 wQwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750787633; x=1751392433;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N6BRfAQFkVAoPWiGigXYDEjYpDmpp8gw4u19/+JOvLQ=;
 b=a9TaAwDGb8MKS7Q4x2/mY1krrGFeLfk0HwdIDwa3KTqoccZ/zZJ4d74CzRadrKj/g7
 Lbx0WLLjZNozKl/tMNWkyWpy1myyK0jk701YXDvjHfQR6Qkv73dnnWIbZfS3ADQQdxyn
 YSHfhzpcEB3CpBu/Httl7VHXiiwLPX/NSerOOBJRFihb+oL13b9/eOxrAxvUcJ/ENdSC
 l20mKZve/HNI6GCjOuzWdyF3mSzdZTHZ0atQksZv5zwvbOQxYB2keo+zm7MOY7YLFWvi
 Jfwu9DDD2Z4Ts8Cey4WkT7Er6XI3qPP/rvTM113epMpLVyoFRAgUBFgkyHHTrwWncDUZ
 oV1g==
X-Gm-Message-State: AOJu0Yy2+v1QlxUC6rsm3gJMEoZn9PdIz9wOxaiEbY1LlPBzT8lgzZMi
 amA5m0KfWvqLXA3mgtNqSdgfh/TX8oeFcnfT+aUTP2hz3P+g4lFiBt4slBv3sXgiCgQ=
X-Gm-Gg: ASbGncsDZLKvOtaBmssec+qNIGC+BZ+459+GhPraghjTxWFI07T0iIQ44IqKzSe6+y5
 3Qnq+rbuP5ACz7mD3M6UfjEFD8JJIRcM7XkJceaE+2DYbxbZNt1PaR/L7eee7+p7q8YkjVPVN+i
 QCJa9X+6/SAi/KimxPFx23gE2ZdVd49KTxCQMHPb4WE9xwfxt56iYW3f7K7mfgdB8D/dHl7ccJU
 xN8XSY8UzT9LJ1Qod3ST2CeCjnTEMCrK1wkmKEC/AB5qbFiTpzvO3tt0dv6yvM7oy37k1kO6nRc
 kFy1QGEI+4kaLLVxV6ZpF72Eyec2zQXff2Zr2k7S+Y73EfXaSx+Iy1+ecuh/ew==
X-Google-Smtp-Source: AGHT+IHZhzpH+JiePvWShzpGGXavWzZRpik3UDwzxjPi0NvKe+HpKilJL/WrMuQSJLU1fe+N61P13Q==
X-Received: by 2002:a05:6a20:430b:b0:216:1476:f5c with SMTP id
 adf61e73a8af0-22026f66c0cmr26913881637.25.1750787632944; 
 Tue, 24 Jun 2025 10:53:52 -0700 (PDT)
Received: from shemhazi.lan ([50.46.174.34]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b31f12427b7sm9318153a12.40.2025.06.24.10.53.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Jun 2025 10:53:52 -0700 (PDT)
From: Rowan Hart <rowanbhart@gmail.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Rowan Hart <rowanbhart@gmail.com>
Subject: [PATCH v14 0/8] Add additional plugin API functions to read and write
 memory and registers
Date: Tue, 24 Jun 2025 10:53:43 -0700
Message-ID: <20250624175351.440780-1-rowanbhart@gmail.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=rowanbhart@gmail.com; helo=mail-pf1-x436.google.com
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

v14 addresses a build issue Alex pointed out with the patch test, and removes
a few vestigial lines according to Alex's suggestion. I split this out into
another commit as it's not actually coupled to the patch test.

Rowan Hart (8):
  gdbstub: Expose gdb_write_register function to consumers of gdbstub
  plugins: Add register write API
  plugins: Add enforcement of QEMU_PLUGIN_CB flags in register R/W
    callbacks
  plugins: Add memory virtual address write API
  plugins: Add memory hardware address read/write API
  tests/tcg: Remove copy-pasted notes and from i386 and add x86_64
    system tests to tests
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
 tests/tcg/x86_64/Makefile.softmmu-target  |  19 +-
 tests/tcg/x86_64/system/patch-target.c    |  22 ++
 tests/tcg/x86_64/system/validate-patch.py |  39 ++++
 14 files changed, 710 insertions(+), 26 deletions(-)
 create mode 100644 tests/tcg/plugins/patch.c
 create mode 100644 tests/tcg/x86_64/system/patch-target.c
 create mode 100755 tests/tcg/x86_64/system/validate-patch.py

-- 
2.49.0


