Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 192C6C71136
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 23:26:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPUnr-0007Yj-4j; Wed, 11 Jun 2025 19:24:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uPUnn-0007Xb-Ip
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 19:24:16 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uPUnl-0001jD-KF
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 19:24:15 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-236192f8770so2596745ad.0
 for <qemu-devel@nongnu.org>; Wed, 11 Jun 2025 16:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749684251; x=1750289051; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TL4+suZYLVsvb3ZxJJn9tFZ7ZGdzqaOhS9PvmAWhkIA=;
 b=CA8OfJofdtGQRCXACdJ2P0XaR1/zNWpEJBxaPjqKmLEmhebCF3wVnu9ai+FQexVdf0
 Z0XGeVxOTybtBRgiAhAwb5U6voWzyd85irVUcP8X6JVGk/83c+tC7W5Gim/DVhUdcS2H
 zP0wOlVD9jGjHST63Em4HXFne8gzjjZcIspKer6f8yKFjxtQMe//4nD+aG5S+UtpOPfT
 ZfdhQ2UYIuwWp/sySs8YwwwgV7q1b1tLYjdAJyNhWcM00S3KW/fZSBN0diKTr8KG4wwL
 EiWIuBJfh+TuIecRREY8NAPsxRBBB5zNMU0jJMO6VBNsPmpBt4CDbS9LsRM6Mn3LMT3g
 GXPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749684251; x=1750289051;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TL4+suZYLVsvb3ZxJJn9tFZ7ZGdzqaOhS9PvmAWhkIA=;
 b=a0LOqhL9v3iOv7yniB9F0+OCEU7iI420DAuhShGEpRG0WX2etP9yKHLU9TiWoSLEYX
 tblXMz9OIjzB2FLBoDTBW/VLlpqlYbQk4b0R8/Uz0FNTaV0JsLeylTjWcrXElIMtq0oc
 OM//3X/Mej0Vr2M1s0K9Bsaxg02XNuq3lziOFSS5AipAQ7xpAjHSlrofrppDVH6+LGVu
 gNGXNFWGtkVvxIZJkWDHAOkmvCbkC0/R0n1LcgeuvkJ5QrR88COiPfjiGucGIUGeB2s+
 ytmPxaFkT5jYGpIM0wyS5ggqR8MkLHMmQ4jn84FLT/bOTmK1xgocaRg6lzGlmdaDHQ9B
 eJZw==
X-Gm-Message-State: AOJu0YwWLcQOqqDDXoHjXt7y+pyg0NFgvBeP8R1b44vn6PZpDmJ5uehn
 9D0pG6bQHh/35+i1T5y0lIKDhsJnsq6gCiY0ELXC9jAsx+DePBi1glYNglcQX9ot
X-Gm-Gg: ASbGncsCUMdzYzL3BlmVnSzy2UOVKDY7z51yxfuRwea2ZBAw/x/yy3xC2Bu8wRRutpr
 IdplA3wOKuIe6mrwh6cHx53YkKDDs176rUMwhhGH/12USpO5bta3SSuHIH2Uas3JB9ZW6ZKqbs2
 9bmxnoKqJ380HkZvJC0+pnFvu/y86c0yvqQ9jfpDUaopv4IJfjDtIEcNi/ASU4HPsnXqEOhJfDQ
 jNp395fe0BhJzqswq8svqyFBxOj66fk8EgzHjWy0HArJQEjWcSFq2RzC0/ueTkKKEEMFH42//SL
 aAoPf3hFKU0zlpcwNGIVWemXSQF7boIdllUVPabfI/K3+KSwL1mxO8A6TLFF2Q==
X-Google-Smtp-Source: AGHT+IFG/ehguqtiBrDQc1B10hORbN+YVP7Gj2G2h/yC5xuDHA07xnx2WYGU3oJjuIL7Z/RX9r/Vgw==
X-Received: by 2002:a17:902:f706:b0:234:9fe1:8fc6 with SMTP id
 d9443c01a7336-2364cec90d6mr17057575ad.18.1749684251012; 
 Wed, 11 Jun 2025 16:24:11 -0700 (PDT)
Received: from shemhazi.lan ([50.46.174.34]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2364e6d9c86sm1220295ad.101.2025.06.11.16.24.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Jun 2025 16:24:10 -0700 (PDT)
From: Rowan Hart <rowanbhart@gmail.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Zhao Liu <zhao1.liu@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>, Rowan Hart <rowanbhart@gmail.com>
Subject: [PATCH v12 0/7] Add additional plugin API functions to read and write
 memory and registers
Date: Wed, 11 Jun 2025 16:24:02 -0700
Message-ID: <20250611232409.2936521-1-rowanbhart@gmail.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=rowanbhart@gmail.com; helo=mail-pl1-x633.google.com
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
 tests/tcg/Makefile.target                 |   1 +
 tests/tcg/plugins/meson.build             |   2 +-
 tests/tcg/plugins/patch.c                 | 241 ++++++++++++++++++++++
 tests/tcg/x86_64/Makefile.softmmu-target  |  32 ++-
 tests/tcg/x86_64/system/patch-target.c    |  27 +++
 tests/tcg/x86_64/system/validate-patch.py |  39 ++++
 14 files changed, 725 insertions(+), 23 deletions(-)
 create mode 100644 tests/tcg/plugins/patch.c
 create mode 100644 tests/tcg/x86_64/system/patch-target.c
 create mode 100755 tests/tcg/x86_64/system/validate-patch.py

-- 
2.49.0


