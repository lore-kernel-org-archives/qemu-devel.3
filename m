Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F03EDC54E90
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 09:44:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHfzI-0002eq-3o; Wed, 21 May 2025 05:43:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uHfzE-0002cU-04
 for qemu-devel@nongnu.org; Wed, 21 May 2025 05:43:44 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uHfz7-0001bO-RL
 for qemu-devel@nongnu.org; Wed, 21 May 2025 05:43:43 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-72d3b48d2ffso6222726b3a.2
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 02:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747820614; x=1748425414; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SDigpLEHOcASBPQ+h37bW4+TaTXAuMf9WqxXXMh2500=;
 b=Ekh8tlRL1rGUst+ZsrcX0vF2tto6tbCEVuKy+5eN94JLI5V7OUzhvj6ETnYBSib+bd
 9wt5WaW09MfG0vB1AZSTzbjsWYpQ+5iM2OKZHhsXSvUbBBdG+I7mFX1MpF5ojfed2too
 N80Y3RYl+hbrYZumzoqB/gEqaoVPuP64cq0bq2ZVhnxXYbxpbC0KxyPfEMdBZ+ipxPya
 Y1eb0Q9J8FixpEoKTTmKImOHDNSezskCWxKzs4rZciprJtua9vCmwRsZ6OGeFAPnvfUP
 1dQQik3D0fUgecmuNWOv9Izp2jgd+zMNHRMlkQk2F+aWTXBRNkmpQ+kNU81HTfuk5gEm
 SKfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747820614; x=1748425414;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SDigpLEHOcASBPQ+h37bW4+TaTXAuMf9WqxXXMh2500=;
 b=A3iY77g9NPP7jdkepHX0kG9bVChcF7yPs1QV2fPdziqQPJr5Ff12WXmvNjCaqzagU3
 uacOWTyb8wXqQRutJ3xEVkdZvdP2bIbbPJWjydhEFcS55dH9ATJ6xyy3jDuuh3zBkjgi
 Qta6FM7bUS3dBgR6F0AnuHRypmlDu0NgbOgqdC570hkCihraYXk8vnDiIGbpMhGqMKd9
 8VY7CrERMnkPVPp19NM9tQALZuh68j97wmwuJM8jE+8yeqh6fkMy3wvbeHNXiszmNAGu
 w2+uEPR8xSfDP2VA13JeevYHPA6MN+cwUlcH72o9WcUMlZYAeivtr3SN5mpO1gsUbIUb
 bTsg==
X-Gm-Message-State: AOJu0Yyje4LH16TKXdouAMva1BBZVhUakVhmc8zLyWFRENAZka1jvP3G
 AVyBqmyFJZbY1KbxKhifNUDvv2AsPgdEBB5Yc0EtlCW+C90qX8xRI/sKf+t8r4PwKEI=
X-Gm-Gg: ASbGncvBQPc1eRDRcq5BdcJ2q0N6S4uu2S9QrEx/TVapLH7c+Tm2sGb6HPoznAPR6Zd
 4Pc36iEJS8W+O73eqz6BCpsUbyEf8y60KYLhNeC2UlxJmfMV0Qjtv12Fea3V/tv1fijkRmkZG5H
 xw4UFatePeOlRjOc3TQ9kdVGL1CKNkF2jbAFDq7Pcx3SNuQ+gNbrCKPr3J90NQqgIY77IAtcoHJ
 jk1orMH0f9pLEvRQT51+en7BcumNmwd2j1AGlDKqHn5ObG0EU5ZO9S9dUfSMQZm/4+VcTZcqcBl
 PUo9L0CjbMGCSFQzGjZyNZ4GEY40+8ZL6er5o9Xc6wdqSGY+owY=
X-Google-Smtp-Source: AGHT+IHbTOLquIwk8cMtecFBdkLbEmvI1IH40vsbZCx7BhaNqP4pIxQ7GCyNKYr5pCDA7V6UwA/P6Q==
X-Received: by 2002:a05:6a00:2396:b0:742:a111:ee6f with SMTP id
 d2e1a72fcca58-742accc578emr24204467b3a.10.1747820614142; 
 Wed, 21 May 2025 02:43:34 -0700 (PDT)
Received: from shemhazi.lan ([50.46.174.34]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742a9829b87sm9255668b3a.114.2025.05.21.02.43.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 02:43:33 -0700 (PDT)
From: Rowan Hart <rowanbhart@gmail.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Rowan Hart <rowanbhart@gmail.com>
Subject: [PATCH v3 0/8] Add additional plugin API functions to read and write
 memory and registers
Date: Wed, 21 May 2025 02:43:24 -0700
Message-ID: <20250521094333.4075796-1-rowanbhart@gmail.com>
X-Mailer: git-send-email 2.49.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=rowanbhart@gmail.com; helo=mail-pf1-x42b.google.com
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

novafacing (8):
  Expose gdb_write_register function to consumers of gdbstub
  Add register write API
  Add address space API
  Add memory virtual address write API
  Add memory hardware address read/write API
  Add patcher plugin and test
  Add hypercalls plugin and test
  Update plugin version and add notes

 gdbstub/gdbstub.c                             |   2 +-
 include/exec/gdbstub.h                        |  14 +
 include/qemu/plugin.h                         |   6 +
 include/qemu/qemu-plugin.h                    | 217 ++++++-
 plugins/api.c                                 | 213 ++++++-
 tests/tcg/Makefile.target                     |   2 +
 tests/tcg/plugins/hypercalls.c                | 552 ++++++++++++++++++
 tests/tcg/plugins/meson.build                 |   2 +-
 tests/tcg/plugins/patch.c                     | 324 ++++++++++
 tests/tcg/x86_64/Makefile.softmmu-target      |  36 +-
 tests/tcg/x86_64/system/hypercalls-target.c   |  45 ++
 tests/tcg/x86_64/system/patch-target.c        |  32 +
 .../tcg/x86_64/system/validate-hypercalls.py  |  40 ++
 tests/tcg/x86_64/system/validate-patch.py     |  39 ++
 14 files changed, 1501 insertions(+), 23 deletions(-)
 create mode 100644 tests/tcg/plugins/hypercalls.c
 create mode 100644 tests/tcg/plugins/patch.c
 create mode 100644 tests/tcg/x86_64/system/hypercalls-target.c
 create mode 100644 tests/tcg/x86_64/system/patch-target.c
 create mode 100755 tests/tcg/x86_64/system/validate-hypercalls.py
 create mode 100755 tests/tcg/x86_64/system/validate-patch.py

-- 
2.49.0


