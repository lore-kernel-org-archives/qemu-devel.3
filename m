Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EDE0C61CE8
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 19:40:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOiKW-0007Cs-Ne; Mon, 09 Jun 2025 15:38:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uOiKU-0007C0-FY
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 15:38:46 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uOiKS-0004Ct-IC
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 15:38:46 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-742c7a52e97so3968763b3a.3
 for <qemu-devel@nongnu.org>; Mon, 09 Jun 2025 12:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749497922; x=1750102722; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jzYPyM+b6y3+4/rVW9yjlklWx8Vgs6+TlX+AymNKX94=;
 b=PfnFMQJQzWgfFZiFVD1PoPsN8naWmH+N/Qd7lvAAS+l7UfOGn9p1Kpn29q0Qn44GTq
 EaAbnNwzJ9LrHTKGAhtxVPDhspNp4GaXrvMwJpJo2uq45h22HNA9J6cklT3j1HZKunlg
 AuZx9wn2XD2ZuPbfcoct6/hVRc1INzfOt4EGZCCOXn9OkKVoaqED5ONd9rk9goeVGy+5
 /6573z6MW0GVgrsvCXvxz4h7l+Bp+swZSaXFKBJhVHPsdAbsCaVKg6W9igFk9Gse2/W8
 iIsnboAw7wZCpVXQOuE+TFOs3RgsmYsqzfQyBH2Jmdwx05zuM5//xY75W1J7H6ay6hV4
 aojQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749497922; x=1750102722;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jzYPyM+b6y3+4/rVW9yjlklWx8Vgs6+TlX+AymNKX94=;
 b=cMouEsW5TVWFHiTWZcZpGmE3CWGJtahZMQKVg8nkyA37x9+RofzwjTGhbeODpVqssY
 SNcORKp+ILJfJqEZbDPLXEMnPzhJf8p2Q78oU/M3tGXPN+0lbOuyUiTcJxITM8PXr5Zt
 g7uTHfJrPiD2AZ+17J9sEFNpr0E+EPacWO4ukK6flZXATB0k1H/lQEESdjb6Ipkk7w9L
 2j/p5QgjMuQ1exx1hltgXHp3A3tVBYIlTYehpt7MVM34aBmWF8dE1P+CIo7OEpCZdCkz
 layN8RfvOH8F4qKOXlA+8o0m5Gmo6mZcdJl5hcuPjmvip/Lx5jpmv9w/RuwXHysc0MHH
 fZww==
X-Gm-Message-State: AOJu0Yxc/m6HQondogxfimh+w8qWivZfKErLNI/POg+p0xN+q3nNe9JO
 RIv3kYjy0GwJFMcNHjrnanLB540VwzwqPRpCI/mVp04EUybr4unorpNlm4hhMs/A
X-Gm-Gg: ASbGncuUoNWAdrnlLnRShaY1vwH5JKdFxw3OVcuAIEXWwDBinqUVxRqOyX1EhlRBr/Z
 jXL4gbqAO+k5AIeOrNLqIe+mRwVNrwLmkVcTI+y+udd5bFkc8u9N2MeSVFVXARZwQufhUtqlnXQ
 yY65jtu94NuQ+ad9HV9p7WWWgg0rj2clz2AcCnWRiJem4yaGZFtWIojAsQ27EQCKVd0j1RFAiRM
 s6cEf8aeNds/ae4LZC7ZEI/k9w+WJmwEz2hpW0XKAL/9j1ILMdh+IlJCQJcdRwhrQagMxMVeBAc
 YcvYZopQbhz4PkRJcJllJIuoM4DwE4rFm10C8WM1FIwx1qdh6OMApz2ZXB//jg==
X-Google-Smtp-Source: AGHT+IGu+2Dr271Fz3URtKDuHQo/MQXPaz1A6r8tBWiG2+YTucjt7qF69xHFcJ5gqrhAi1zGneiPlw==
X-Received: by 2002:a05:6a00:4652:b0:736:50d1:fc84 with SMTP id
 d2e1a72fcca58-74827f3b46bmr19884263b3a.21.1749497922282; 
 Mon, 09 Jun 2025 12:38:42 -0700 (PDT)
Received: from shemhazi.lan ([50.46.174.34]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7482b083b03sm6095725b3a.83.2025.06.09.12.38.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jun 2025 12:38:41 -0700 (PDT)
From: Rowan Hart <rowanbhart@gmail.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Rowan Hart <rowanbhart@gmail.com>
Subject: [PATCH v11 0/8] Add additional plugin API functions to read and write
 memory and registers
Date: Mon,  9 Jun 2025 12:38:33 -0700
Message-ID: <20250609193841.348076-1-rowanbhart@gmail.com>
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
 include/qemu/plugin.h                         |  15 +
 include/qemu/qemu-plugin.h                    | 176 +++++-
 plugins/api.c                                 | 135 ++++-
 plugins/core.c                                |  33 ++
 tests/tcg/Makefile.target                     |   2 +
 tests/tcg/plugins/hypercalls.c                | 547 ++++++++++++++++++
 tests/tcg/plugins/meson.build                 |   2 +-
 tests/tcg/plugins/patch.c                     | 297 ++++++++++
 tests/tcg/x86_64/Makefile.softmmu-target      |  36 +-
 tests/tcg/x86_64/system/hypercalls-target.c   |  40 ++
 tests/tcg/x86_64/system/patch-target.c        |  27 +
 .../tcg/x86_64/system/validate-hypercalls.py  |  40 ++
 tests/tcg/x86_64/system/validate-patch.py     |  39 ++
 17 files changed, 1413 insertions(+), 23 deletions(-)
 create mode 100644 tests/tcg/plugins/hypercalls.c
 create mode 100644 tests/tcg/plugins/patch.c
 create mode 100644 tests/tcg/x86_64/system/hypercalls-target.c
 create mode 100644 tests/tcg/x86_64/system/patch-target.c
 create mode 100755 tests/tcg/x86_64/system/validate-hypercalls.py
 create mode 100755 tests/tcg/x86_64/system/validate-patch.py

-- 
2.49.0


