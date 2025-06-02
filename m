Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13755C5B549
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 05:58:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLyAL-0003Tp-VN; Mon, 02 Jun 2025 01:57:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uLy3H-0001f8-Fv
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 01:49:41 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uLy3D-0007Jq-1i
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 01:49:37 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2301ac32320so35326515ad.1
 for <qemu-devel@nongnu.org>; Sun, 01 Jun 2025 22:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748843358; x=1749448158; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=a0hhMIwrgzioqrXjjHmm2ChOdyusAiyIVrvjIwJzSW4=;
 b=lGrtXzlYngNR8D0WJsc0gmUzTSyG4lDq7lYS0xlxUz5qM1fgm093yCbPYcplhA1iMc
 KVOh3U0eju0JYq93JiEh4KOEL34Yq3tgeSgfLYIsK5v7tXGn5UbrW9znJkbO54muFXoS
 rp5aQpViUW0lqocgSBFBy8vX2WPj2Brapb4FOzF0auoSctmk4uw3dcgeM9vIuNoL+wns
 ssu0YeKnTNQ7ICd9UF4SFw36z/4lqi01XMxhbnm8NsemF2nJpQv+KnWcXBXDph1jhU7+
 kMenbPWy0i5ta/XgsV/sfALut/0RVGMs21T0uyIpVYs1D0t5fZWPXe68BK7by9fItXng
 /tNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748843358; x=1749448158;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a0hhMIwrgzioqrXjjHmm2ChOdyusAiyIVrvjIwJzSW4=;
 b=dO8APaPFvAk6vH4AUkn+jTfnjGpH3lgVs/keshp/HO+dA/ixpHpxAeGhKiLrM+PYIH
 dqj23aKmq1z9d2Yh3fQl82VeXRnbKjR50yKsIcf91DEF4QF3szEGOtfVO5UqZ5Hw2Xcv
 AZ426KABC+pQrssNfGNpDjOc6Ltk1oKTY2IlooYyZksumny0KXsPG8pT+0+U6MA/nlNU
 uD63X6eCYJ1xYa89XIkJBc85skRzz12zEDo80/neBv6ztZPZiMcz9HMuo6MpL3oOMc6g
 wR2gnU+nxRj2Wa2ZoVyV5O9KlDC3ZNEJFi/9fpH1jIGwsA4uF/7PC0nufb1RwxPKFxP8
 cLAA==
X-Gm-Message-State: AOJu0Ywbne6fxVBOFZ+PayFFx323cNUS2TQLSWOQWYzAhfWBBzcrJwLq
 vBIsgTh7jTBZd0iEWCPRACKGWyBGq3O1ueeNSe8/GzbYXqbxtnDPnRXgKiFUa0Le/EI=
X-Gm-Gg: ASbGncuhwPV5SeUDehFTkWG1ONtRe8bk2ICRzMUiz71hYeEmUSwfS5YmOR9uZAIrlpX
 az8GRjpYzlNdOrWsvD1grUGnVn7QlP5noTSlaEFIS4+IILhUpUD5axUKo/k5MApBlbWiPMWmA67
 HMtT/vlOVes3odtJp+Uc2pRjItpdAjVi9N/io2iSfXZHAHBLT61bpINKUdLRw94oXiSjrvaps0U
 80EbBc4Eunm+1TQX/7Fd6eDrX45UkvtDn2a1OipYR9sUBy6MpA6jfpc1btPNvbTr5xzQYD1qW9x
 Q94KDVbQzmkpTPJIWfS0Df/MyRPh/HYyhIcPXnTYrgDuqQ//9dY=
X-Google-Smtp-Source: AGHT+IGNEBNHJJUEeKNQsojWrVDZogPkFjSgevqnWeRVg6TsBX2uMiFrTNGTdeHGDOHaQko/Wz3CLw==
X-Received: by 2002:a17:903:1a4d:b0:223:4d7e:e52c with SMTP id
 d9443c01a7336-235289c82cbmr186485165ad.5.1748843358178; 
 Sun, 01 Jun 2025 22:49:18 -0700 (PDT)
Received: from shemhazi.lan ([50.46.174.34]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23506bdce12sm63464085ad.99.2025.06.01.22.49.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Jun 2025 22:49:17 -0700 (PDT)
From: Rowan Hart <rowanbhart@gmail.com>
To: qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Rowan Hart <rowanbhart@gmail.com>
Subject: [PATCH v5 0/9] Add additional plugin API functions to read and write
 memory and registers
Date: Sun,  1 Jun 2025 22:49:07 -0700
Message-ID: <20250602054917.302638-1-rowanbhart@gmail.com>
X-Mailer: git-send-email 2.49.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=rowanbhart@gmail.com; helo=mail-pl1-x62b.google.com
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

For v4, I've just updated the enforcement of the QEMU_PLUGIN_CB_ flags to just
use immediate stores, which simplifies the implementation quite a lot and
should be more efficient too. Thanks Pierrick for the suggestion!

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
 tests/tcg/plugins/hypercalls.c                | 552 ++++++++++++++++++
 tests/tcg/plugins/insn.c                      |  22 +-
 tests/tcg/plugins/meson.build                 |   2 +-
 tests/tcg/plugins/patch.c                     | 302 ++++++++++
 tests/tcg/x86_64/Makefile.softmmu-target      |  36 +-
 tests/tcg/x86_64/system/hypercalls-target.c   |  45 ++
 tests/tcg/x86_64/system/patch-target.c        |  32 +
 .../tcg/x86_64/system/validate-hypercalls.py  |  40 ++
 tests/tcg/x86_64/system/validate-patch.py     |  39 ++
 18 files changed, 1406 insertions(+), 50 deletions(-)
 create mode 100644 tests/tcg/plugins/hypercalls.c
 create mode 100644 tests/tcg/plugins/patch.c
 create mode 100644 tests/tcg/x86_64/system/hypercalls-target.c
 create mode 100644 tests/tcg/x86_64/system/patch-target.c
 create mode 100755 tests/tcg/x86_64/system/validate-hypercalls.py
 create mode 100755 tests/tcg/x86_64/system/validate-patch.py

-- 
2.49.0


