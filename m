Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44B47CFC287
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 10:42:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0ewt-0006kP-Cn; Tue, 15 Oct 2024 06:38:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0ewY-0006gO-Fm
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 06:38:22 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0ewU-0005xB-AD
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 06:38:22 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-37d538fe5f2so2931360f8f.2
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 03:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728988697; x=1729593497; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AAgujXpX2gYXqhZkrhcPFNZmS/QvAosO9xPCDtYgfm8=;
 b=FdHsd/3q9jBbc3Qp55DRokEl+A+1haycYJcdMd0hvrT/9iqpFRO2zL36uT2JSLpNzg
 oUwsEkjbtBbCK3W6FbbGi385ZQ+45MC/VIi5aLC4HdS6533hTKi/RZEkMNCebHP1CQqV
 VIExRibA/agypO2YaN74K4/rGdz55/Bjk/maIzVsj2q1uqt9c4Sm+874zakERsVILnYe
 JxNTDoIJnKQSzcoDFCFF3O4yhJIWQS59Y5PPz7Xwz5yKIV99UvR8BvNxcMFn9PbP8mXZ
 61pgq1v+OxBrufjlKxaj+rwp6J92OQxIu8RAAv4f6/z160c7uQQgg48unPrVhagSg+vE
 9+Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728988697; x=1729593497;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AAgujXpX2gYXqhZkrhcPFNZmS/QvAosO9xPCDtYgfm8=;
 b=sFHPfpRIeYLVh130VarBwQnQpM8p5QTbGfpVSxQSeXrXiJopzoYtVc54pdkDDRWE86
 +YURQCqTW4+DMx4K3UWqfafj8zOYXJ0NYfZpe8F7IOzBsdiux6Il3Hgc94tAh5HCsMtP
 kNQ1f7HAOBalJu41DkwdMb1uXh+DACNSPnU3V+HUsCaEM1tmfcp03Qh8cKSac+2BBdgD
 AaHQGgaDNJvSxvTxNUiYzO0W0xSaFHw+SPofmiSZx0fj90B5Q8FbuaXogEzAL1T3NQVt
 kpxk3cavwLvJbtwco6OYK3KYEOhBA5E8EjT4QwX//k35wc5lmXqEWEhQk4dxC7VHbqE9
 hlFA==
X-Gm-Message-State: AOJu0Ywoj6x1gzIAg3jZDEentolRgiISqHvMyIniC/xJR1TbeuFQMFsW
 CWbY/PxjbXZdg9zajIUGk3Ob4AQ63uppcc9v5k5ljEjL96ttihuzaIpGvLUO78Shu5NUShXgb1F
 f
X-Google-Smtp-Source: AGHT+IEljiPYfmWT/bWi9PQZVOIrbMnOVeVabN+jsufU2FUX/MXARpI6/y5PFnh7MsC2JD0+qapffQ==
X-Received: by 2002:adf:e88b:0:b0:37d:4cd6:6f2b with SMTP id
 ffacd0b85a97d-37d551d2566mr8846389f8f.14.1728988696492; 
 Tue, 15 Oct 2024 03:38:16 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d7fa7a06dsm1241635f8f.5.2024.10.15.03.38.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 03:38:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/28] docs/devel/blkdebug: Convert to rST format
Date: Tue, 15 Oct 2024 11:37:54 +0100
Message-Id: <20241015103808.133024-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241015103808.133024-1-peter.maydell@linaro.org>
References: <20241015103808.133024-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Convert blkdebug.txt to rST format.  We put it into index-build.rst
because it falls under the "test" part of "QEMU Build and Test
System".

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-id: 20240816132212.3602106-2-peter.maydell@linaro.org
---
 MAINTAINERS                     |   1 +
 docs/devel/blkdebug.txt         | 162 -----------------------------
 docs/devel/testing/blkdebug.rst | 177 ++++++++++++++++++++++++++++++++
 docs/devel/testing/index.rst    |   1 +
 4 files changed, 179 insertions(+), 162 deletions(-)
 delete mode 100644 docs/devel/blkdebug.txt
 create mode 100644 docs/devel/testing/blkdebug.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index 5cd661c9f9d..d4eb221b88c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3967,6 +3967,7 @@ M: Hanna Reitz <hreitz@redhat.com>
 L: qemu-block@nongnu.org
 S: Supported
 F: block/blkdebug.c
+F: docs/devel/blkdebug.rst
 
 vpc
 M: Kevin Wolf <kwolf@redhat.com>
diff --git a/docs/devel/blkdebug.txt b/docs/devel/blkdebug.txt
deleted file mode 100644
index 0b0c128d356..00000000000
--- a/docs/devel/blkdebug.txt
+++ /dev/null
@@ -1,162 +0,0 @@
-Block I/O error injection using blkdebug
-----------------------------------------
-Copyright (C) 2014-2015 Red Hat Inc
-
-This work is licensed under the terms of the GNU GPL, version 2 or later.  See
-the COPYING file in the top-level directory.
-
-The blkdebug block driver is a rule-based error injection engine.  It can be
-used to exercise error code paths in block drivers including ENOSPC (out of
-space) and EIO.
-
-This document gives an overview of the features available in blkdebug.
-
-Background
-----------
-Block drivers have many error code paths that handle I/O errors.  Image formats
-are especially complex since metadata I/O errors during cluster allocation or
-while updating tables happen halfway through request processing and require
-discipline to keep image files consistent.
-
-Error injection allows test cases to trigger I/O errors at specific points.
-This way, all error paths can be tested to make sure they are correct.
-
-Rules
------
-The blkdebug block driver takes a list of "rules" that tell the error injection
-engine when to fail an I/O request.
-
-Each I/O request is evaluated against the rules.  If a rule matches the request
-then its "action" is executed.
-
-Rules can be placed in a configuration file; the configuration file
-follows the same .ini-like format used by QEMU's -readconfig option, and
-each section of the file represents a rule.
-
-The following configuration file defines a single rule:
-
-  $ cat blkdebug.conf
-  [inject-error]
-  event = "read_aio"
-  errno = "28"
-
-This rule fails all aio read requests with ENOSPC (28).  Note that the errno
-value depends on the host.  On Linux, see
-/usr/include/asm-generic/errno-base.h for errno values.
-
-Invoke QEMU as follows:
-
-  $ qemu-system-x86_64
-        -drive if=none,cache=none,file=blkdebug:blkdebug.conf:test.img,id=drive0 \
-        -device virtio-blk-pci,drive=drive0,id=virtio-blk-pci0
-
-Rules support the following attributes:
-
-  event - which type of operation to match (e.g. read_aio, write_aio,
-          flush_to_os, flush_to_disk).  See the "Events" section for
-          information on events.
-
-  state - (optional) the engine must be in this state number in order for this
-          rule to match.  See the "State transitions" section for information
-          on states.
-
-  errno - the numeric errno value to return when a request matches this rule.
-          The errno values depend on the host since the numeric values are not
-          standardized in the POSIX specification.
-
-  sector - (optional) a sector number that the request must overlap in order to
-           match this rule
-
-  once - (optional, default "off") only execute this action on the first
-         matching request
-
-  immediately - (optional, default "off") return a NULL BlockAIOCB
-                pointer and fail without an errno instead.  This
-                exercises the code path where BlockAIOCB fails and the
-                caller's BlockCompletionFunc is not invoked.
-
-Events
-------
-Block drivers provide information about the type of I/O request they are about
-to make so rules can match specific types of requests.  For example, the qcow2
-block driver tells blkdebug when it accesses the L1 table so rules can match
-only L1 table accesses and not other metadata or guest data requests.
-
-The core events are:
-
-  read_aio - guest data read
-
-  write_aio - guest data write
-
-  flush_to_os - write out unwritten block driver state (e.g. cached metadata)
-
-  flush_to_disk - flush the host block device's disk cache
-
-See qapi/block-core.json:BlkdebugEvent for the full list of events.
-You may need to grep block driver source code to understand the
-meaning of specific events.
-
-State transitions
------------------
-There are cases where more power is needed to match a particular I/O request in
-a longer sequence of requests.  For example:
-
-  write_aio
-  flush_to_disk
-  write_aio
-
-How do we match the 2nd write_aio but not the first?  This is where state
-transitions come in.
-
-The error injection engine has an integer called the "state" that always starts
-initialized to 1.  The state integer is internal to blkdebug and cannot be
-observed from outside but rules can interact with it for powerful matching
-behavior.
-
-Rules can be conditional on the current state and they can transition to a new
-state.
-
-When a rule's "state" attribute is non-zero then the current state must equal
-the attribute in order for the rule to match.
-
-For example, to match the 2nd write_aio:
-
-  [set-state]
-  event = "write_aio"
-  state = "1"
-  new_state = "2"
-
-  [inject-error]
-  event = "write_aio"
-  state = "2"
-  errno = "5"
-
-The first write_aio request matches the set-state rule and transitions from
-state 1 to state 2.  Once state 2 has been entered, the set-state rule no
-longer matches since it requires state 1.  But the inject-error rule now
-matches the next write_aio request and injects EIO (5).
-
-State transition rules support the following attributes:
-
-  event - which type of operation to match (e.g. read_aio, write_aio,
-          flush_to_os, flush_to_disk).  See the "Events" section for
-          information on events.
-
-  state - (optional) the engine must be in this state number in order for this
-          rule to match
-
-  new_state - transition to this state number
-
-Suspend and resume
-------------------
-Exercising code paths in block drivers may require specific ordering amongst
-concurrent requests.  The "breakpoint" feature allows requests to be halted on
-a blkdebug event and resumed later.  This makes it possible to achieve
-deterministic ordering when multiple requests are in flight.
-
-Breakpoints on blkdebug events are associated with a user-defined "tag" string.
-This tag serves as an identifier by which the request can be resumed at a later
-point.
-
-See the qemu-io(1) break, resume, remove_break, and wait_break commands for
-details.
diff --git a/docs/devel/testing/blkdebug.rst b/docs/devel/testing/blkdebug.rst
new file mode 100644
index 00000000000..63887c9aa9c
--- /dev/null
+++ b/docs/devel/testing/blkdebug.rst
@@ -0,0 +1,177 @@
+Block I/O error injection using ``blkdebug``
+============================================
+
+..
+   Copyright (C) 2014-2015 Red Hat Inc
+
+   This work is licensed under the terms of the GNU GPL, version 2 or later.  See
+   the COPYING file in the top-level directory.
+
+The ``blkdebug`` block driver is a rule-based error injection engine.  It can be
+used to exercise error code paths in block drivers including ``ENOSPC`` (out of
+space) and ``EIO``.
+
+This document gives an overview of the features available in ``blkdebug``.
+
+Background
+----------
+Block drivers have many error code paths that handle I/O errors.  Image formats
+are especially complex since metadata I/O errors during cluster allocation or
+while updating tables happen halfway through request processing and require
+discipline to keep image files consistent.
+
+Error injection allows test cases to trigger I/O errors at specific points.
+This way, all error paths can be tested to make sure they are correct.
+
+Rules
+-----
+The ``blkdebug`` block driver takes a list of "rules" that tell the error injection
+engine when to fail an I/O request.
+
+Each I/O request is evaluated against the rules.  If a rule matches the request
+then its "action" is executed.
+
+Rules can be placed in a configuration file; the configuration file
+follows the same .ini-like format used by QEMU's ``-readconfig`` option, and
+each section of the file represents a rule.
+
+The following configuration file defines a single rule::
+
+  $ cat blkdebug.conf
+  [inject-error]
+  event = "read_aio"
+  errno = "28"
+
+This rule fails all aio read requests with ``ENOSPC`` (28).  Note that the errno
+value depends on the host.  On Linux, see
+``/usr/include/asm-generic/errno-base.h`` for errno values.
+
+Invoke QEMU as follows::
+
+  $ qemu-system-x86_64
+        -drive if=none,cache=none,file=blkdebug:blkdebug.conf:test.img,id=drive0 \
+        -device virtio-blk-pci,drive=drive0,id=virtio-blk-pci0
+
+Rules support the following attributes:
+
+``event``
+  which type of operation to match (e.g. ``read_aio``, ``write_aio``,
+  ``flush_to_os``, ``flush_to_disk``).  See `Events`_ for
+  information on events.
+
+``state``
+  (optional) the engine must be in this state number in order for this
+  rule to match.  See `State transitions`_ for information
+  on states.
+
+``errno``
+  the numeric errno value to return when a request matches this rule.
+  The errno values depend on the host since the numeric values are not
+  standardized in the POSIX specification.
+
+``sector``
+  (optional) a sector number that the request must overlap in order to
+  match this rule
+
+``once``
+  (optional, default ``off``) only execute this action on the first
+  matching request
+
+``immediately``
+  (optional, default ``off``) return a NULL ``BlockAIOCB``
+  pointer and fail without an errno instead.  This
+  exercises the code path where ``BlockAIOCB`` fails and the
+  caller's ``BlockCompletionFunc`` is not invoked.
+
+Events
+------
+Block drivers provide information about the type of I/O request they are about
+to make so rules can match specific types of requests.  For example, the ``qcow2``
+block driver tells ``blkdebug`` when it accesses the L1 table so rules can match
+only L1 table accesses and not other metadata or guest data requests.
+
+The core events are:
+
+``read_aio``
+  guest data read
+
+``write_aio``
+  guest data write
+
+``flush_to_os``
+  write out unwritten block driver state (e.g. cached metadata)
+
+``flush_to_disk``
+  flush the host block device's disk cache
+
+See ``qapi/block-core.json:BlkdebugEvent`` for the full list of events.
+You may need to grep block driver source code to understand the
+meaning of specific events.
+
+State transitions
+-----------------
+There are cases where more power is needed to match a particular I/O request in
+a longer sequence of requests.  For example::
+
+  write_aio
+  flush_to_disk
+  write_aio
+
+How do we match the 2nd ``write_aio`` but not the first?  This is where state
+transitions come in.
+
+The error injection engine has an integer called the "state" that always starts
+initialized to 1.  The state integer is internal to ``blkdebug`` and cannot be
+observed from outside but rules can interact with it for powerful matching
+behavior.
+
+Rules can be conditional on the current state and they can transition to a new
+state.
+
+When a rule's "state" attribute is non-zero then the current state must equal
+the attribute in order for the rule to match.
+
+For example, to match the 2nd write_aio::
+
+  [set-state]
+  event = "write_aio"
+  state = "1"
+  new_state = "2"
+
+  [inject-error]
+  event = "write_aio"
+  state = "2"
+  errno = "5"
+
+The first ``write_aio`` request matches the ``set-state`` rule and transitions from
+state 1 to state 2.  Once state 2 has been entered, the ``set-state`` rule no
+longer matches since it requires state 1.  But the ``inject-error`` rule now
+matches the next ``write_aio`` request and injects ``EIO`` (5).
+
+State transition rules support the following attributes:
+
+``event``
+  which type of operation to match (e.g. ``read_aio``, ``write_aio``,
+  ``flush_to_os`, ``flush_to_disk``).  See `Events`_ for
+  information on events.
+
+``state``
+  (optional) the engine must be in this state number in order for this
+  rule to match
+
+``new_state``
+  transition to this state number
+
+Suspend and resume
+------------------
+Exercising code paths in block drivers may require specific ordering amongst
+concurrent requests.  The "breakpoint" feature allows requests to be halted on
+a ``blkdebug`` event and resumed later.  This makes it possible to achieve
+deterministic ordering when multiple requests are in flight.
+
+Breakpoints on ``blkdebug`` events are associated with a user-defined ``tag`` string.
+This tag serves as an identifier by which the request can be resumed at a later
+point.
+
+See the ``qemu-io(1)`` ``break``, ``resume``, ``remove_break``, and ``wait_break``
+commands for details.
diff --git a/docs/devel/testing/index.rst b/docs/devel/testing/index.rst
index 45eb4a71814..9e772c7fd1d 100644
--- a/docs/devel/testing/index.rst
+++ b/docs/devel/testing/index.rst
@@ -14,3 +14,4 @@ testing infrastructure.
    acpi-bits
    ci
    fuzzing
+   blkdebug
-- 
2.34.1


