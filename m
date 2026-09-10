Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 512CEC79FB9
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 07:53:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4ZbT-0000QE-MH; Thu, 10 Sep 2026 03:53:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x4ZbO-0000Pl-WD
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 03:53:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x4ZbN-0000q7-4N
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 03:53:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789026823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=qJZgU3W0RveYmLxeMJIWjQDyvcHKKhLkzMIjkNgRmEc=;
 b=T7eHS3W36DiSyy/kZMJEE6ZKUhHnvboKlxZOcae9k7NMeFowx2HNb5veLCPDUWTgIIKMZ2
 snfi0uORbcRAQMLy7iIN+FO/Jlv1nTgLutQSV2cL3sKdXLjdtfuJI/XK7RcYBE/3PqIC1k
 CioBMS6WMD3BwejDJx6zCRfXPoxUFj4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-2pmXPpxKPi2jaFcxkEwivA-1; Thu, 10 Sep 2026 03:53:42 -0400
X-MC-Unique: 2pmXPpxKPi2jaFcxkEwivA-1
X-Mimecast-MFC-AGG-ID: 2pmXPpxKPi2jaFcxkEwivA_1789026821
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-499b99a8a10so4806775e9.0
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 00:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789026821; x=1789631621; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=qJZgU3W0RveYmLxeMJIWjQDyvcHKKhLkzMIjkNgRmEc=;
 b=qZ68Zdeo/i3dq61mNZ6SbcqWF1dDAx2H8zqKz7y+kQ5hYm3wGVNubXyJ/inxOjphEk
 f7zD6bErv01JmW6xbaQjH4oxZG7Jl6aoODKaxRVC/H3EQJa58hHMnrsvWyTbgFDjpBi3
 ymDhCs6KNjPrwT/JdgddFddC3483ML3xqnsgMaAWNgfXLAwXGNPA3dMeZVuQYFeWAD5V
 Ob5xkFXzS25KNpzXCknSKfPIbjwNQg14ZG+HqD4f3s2JN0lMYdlXIWXCFNpm8yfETX8f
 INRoTAvbGEjBBXivKoIpK921hXXrlgS981M/JlXYVp8uzVNK9hgqlnUhVzpY0pH67HzV
 QRKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789026821; x=1789631621;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qJZgU3W0RveYmLxeMJIWjQDyvcHKKhLkzMIjkNgRmEc=;
 b=GADMSdXm/fzzacWUavqAMkVIkkMhed+pOgydOSGlL98K8Ts7G6HHcqPFqb9rOBM7T0
 oOMZLB3rlqEcug5HLp9+YKhg4+6OBGQBaO4zQ5FHlxEhwjF7QYmTOXZrtQVVujTn1jOb
 cfXUGnDh7Kg2u5hmu6OpKdUHggOOq+p9L89mZMDihqnaa+JhER+NYwAmN9oWxQC86oM0
 xAvFfKVQ2Tp+Wahi7foRDr0XCVI2heiZgg6wFTk4J+/cumuFIFVXwaddhKjRUDisLhG+
 c26CTkH3nL0KBF7VwEhsQMAvZ6/PPUPNKUoSIUFhPWEGVcLNsyGfXgjmZXz459lxWSFU
 JpcQ==
X-Gm-Message-State: AFuF++kbzaW8RuJIDHIFu7hy6N1LOFFFnclXvAlMJiW8rqK7qE/0ZeT1
 VyuWXZdC2o5NSsnglvWQc+BgRgLCcPGZEEssNwUJCarkGhMX3uJPTmX4jg8cls6emIPW/rZsJrW
 BDhNlXzkeaxlvlQJ9X2OB6BA9wP0wWrRmPEazJnXd8xrn4/na22rbv3w5R1XYY60Iw1uHOZlJv8
 4jfi4+AS16iet1qnyGeciikvI6bUi3T7O2OZkVEJcB
X-Gm-Gg: AYBFou0QpFp/xrRskyomsQnCg0VcuJHHDzrmgOfiWLmMu948QOA2SKNxAicgm5SRaeZ
 yL/mzVBnkpLscw9vLUUctmlC1/UoiMs/fynWpRuLad7i59CVh205lOzusWOGAF6jzMQSsLK2qT8
 NAlCCLdR7YwH2FSXicMstfO4UXqO5N8M8RA/9llXQkgHHYyjLWmhGaZilOMrhjEVeiW2QhHQpME
 VB9uZn9kL2P6g93MLmNQN2JKCo+bnvO6KGdRhCFzlaQ73sl9dbKd+0nr7BUXEnzngFOI7Xqlqse
 2uHBl7wpB27YVjKk4jCO/9n5PRAr6QFOUI9dzJdYxNWpo/40WrSp5kJDmZ/cQKUPUYoR2jE4VzW
 cQdHHJmCeTfk/fpl06fwOQk/bPdG0lumMJY2Ude/kpCj+Hil1954D4MpMv7Qz5ZnCCq2eWl4hFU
 ZfdWw+
X-Received: by 2002:a05:600c:4e03:b0:49c:e37e:4389 with SMTP id
 5b1f17b1804b1-49d26d9dd0fmr29646115e9.4.1789026820789; 
 Thu, 10 Sep 2026 00:53:40 -0700 (PDT)
X-Received: by 2002:a05:600c:4e03:b0:49c:e37e:4389 with SMTP id
 5b1f17b1804b1-49d26d9dd0fmr29645725e9.4.1789026820283; 
 Thu, 10 Sep 2026 00:53:40 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d26c1bfb5sm61171105e9.5.2026.09.10.00.53.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 00:53:39 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org,
	berrange@redhat.com
Subject: [PATCH v3] agents: Add a skill for finding your way around QEMU
Date: Thu, 10 Sep 2026 09:53:38 +0200
Message-ID: <20260910075338.139437-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

As a side effect, establish scaffolding for the .agents/.claude/.gemini
directories, as a base for future patches to build on.

Some parts of this skill are based on
https://lore.kernel.org/r/20260529101437.410181-4-alex.bennee@linaro.org/.

Co-authored-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .agents/skills/qemu-codebase/SKILL.md | 59 +++++++++++++++++++++++++++
 .claude/skills                        |  1 +
 .gemini/skills                        |  1 +
 3 files changed, 61 insertions(+)
 create mode 100644 .agents/skills/qemu-codebase/SKILL.md
 create mode 120000 .claude/skills
 create mode 120000 .gemini/skills

diff --git a/.agents/skills/qemu-codebase/SKILL.md b/.agents/skills/qemu-codebase/SKILL.md
new file mode 100644
index 00000000000..559f0075976
--- /dev/null
+++ b/.agents/skills/qemu-codebase/SKILL.md
@@ -0,0 +1,59 @@
+---
+name: qemu-codebase
+description: >-
+  Route broad or unfamiliar QEMU tasks to relevant subsystem,
+  documentation, build, and test entry points. Do not use for work
+  where the files, subsystems and abstractions are already known.
+---
+
+# Finding your way around QEMU
+
+Use this skill for orientation, not as a general prerequisite for QEMU
+work. Start from the code and nearby tests when the request already
+identifies a file, function, subsystem, or commit.
+
+## Finding the subsystem
+
+For a broad request, use `grep`/`rg` and `MAINTAINERS` to locate
+likely code and subsystem boundaries. Use `scripts/get_maintainer.pl
+--nogit -f <path>` when the maintainance status matters.  Read
+`docs/devel/codebase.rst` only when the top-level directory or execution
+mode is unclear.
+
+## Focused documentation
+
+Read documentation only when the task involves the corresponding
+abstraction or its invariants:
+
+- QOM types, properties, composition, or lifecycle: `docs/devel/qom.rst`.
+- qdev realize/unrealize, buses, GPIO, or hotplug: `docs/devel/qdev-api.rst`.
+- Device or machine reset behavior: `docs/devel/reset.rst`.
+- MemoryRegion topology, transactions, mappings, or dirty tracking:
+  `docs/devel/memory.rst`.
+- TCG frontend/backend boundaries or IR: `docs/devel/tcg.rst`; for the TCG IR,
+  also read `docs/devel/tcg-ops.rst`.
+- RCU lifetime, grace periods, or atomic ordering: `docs/devel/rcu.rst` and
+  `docs/devel/atomics.rst`.
+- AioContext migration, iothreads, or block/device concurrency:
+  `docs/devel/multiple-iothreads.rst`.
+- BQL ownership or code running outside the BQL: `include/qemu/main-loop.h`
+  and nearby callers.
+
+Prefer source declarations and nearby callers when they answer the
+question more directly. A `kernel-doc::` directive points to comments
+in the source; inspect those comments without building the documentation.
+
+## Building and testing
+
+QEMU builds out of tree and a checkout may have several build
+directories. When building or testing, find the applicable configured
+tree from context (for example, directories containing `meson-info`)
+instead of assuming one. Use that build directory's `run` wrapper for
+`meson test` so its environment and Python paths are active.
+
+For C changes, run `scripts/checkpatch.pl` on the patch; for Rust changes,
+consider `make clippy` and `make rustfmt`.
+
+Choose the narrowest test that exercises the behavior. Use `make
+check-unit`, `make check-qtest`, `make check-functional`, or `make
+check-rust` only when a suite-level run is justified.
diff --git a/.claude/skills b/.claude/skills
new file mode 120000
index 00000000000..a7540c24423
--- /dev/null
+++ b/.claude/skills
@@ -0,0 +1 @@
+.agents/skills/
\ No newline at end of file
diff --git a/.gemini/skills b/.gemini/skills
new file mode 120000
index 00000000000..a7540c24423
--- /dev/null
+++ b/.gemini/skills
@@ -0,0 +1 @@
+.agents/skills/
\ No newline at end of file
-- 
2.55.0


