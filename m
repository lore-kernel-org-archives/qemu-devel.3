Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27CDDC9833F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 13:06:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBB3E-000807-Ie; Mon, 28 Sep 2026 09:05:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xBB1c-0005pI-0g
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 09:04:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xBB1Z-0004TQ-0A
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 09:04:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790600644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qJZgU3W0RveYmLxeMJIWjQDyvcHKKhLkzMIjkNgRmEc=;
 b=abeFmhyfn2KxacCjJkhOf3nlfidIWtqc6XtkYB+BTzYRnbp8TAmheecWdDDd01FQI1nrr6
 gbfg6IhTR1oxWA01Iv3zGVEg9sNvilniNVQGaafz0mG2pU4hNSMBolrO0uohBPRUFfuRiz
 c1Pe1jmF063XGB754m+hu4g8UMlXOdU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-HU1c53wyPjCjsqvC3-cPHw-1; Mon, 28 Sep 2026 09:04:02 -0400
X-MC-Unique: HU1c53wyPjCjsqvC3-cPHw-1
X-Mimecast-MFC-AGG-ID: HU1c53wyPjCjsqvC3-cPHw_1790600641
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49953abe51fso19912835e9.1
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 06:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790600641; x=1791205441; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qJZgU3W0RveYmLxeMJIWjQDyvcHKKhLkzMIjkNgRmEc=;
 b=DmzUWFxKJWxoxAF5CnKQZmTqg3vfP09rjWIKMJPQ5lf9ZVu3Rtb5eULazetzriT/Yl
 ubCNgpx2Csghn2IBMWTRj0AEZfTJ2NdwCfIyB43dd6nfkv97rekU5sP8gqVy4cRHSHGX
 vX45+8OgFvKwCWDxXhwJLGtJzJ6kGqW2mHGAVhzB9n3EZ4YowXhAVMyyrvN3vNp/VQ1T
 NY2CTBS4LxGIsrzcyVgoPc4PUzQ6EQH4P9MPcYvZVmOL2Hj+JRUgcWWuP1rwcNpIn+ni
 rHWf44NJ6L7Jo88GAymeYTzeNAZ89Dennu8gYZ/y+irrl72e1/DNALOZLqGbVV8qrvGg
 yIeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790600641; x=1791205441;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qJZgU3W0RveYmLxeMJIWjQDyvcHKKhLkzMIjkNgRmEc=;
 b=kibXYQUTE4hvpEqpOPBnMaCwErU/eO/BLOr463KWStXGksj8tDgwqitvX7xJ3kbboG
 lUhhA86IQpd4AsrsvDH4tiyLr46XuF+UNiYntoWSvs+gBamQMyaHF5VVI5LpINf4nac7
 jqTwuKNjY05a9OIB2GYCmNat+yA5flgcg82qLWohQecL+p+leV3oPjMpUz1TbyGHVyac
 aRHGud85YSgd3cQU0WsOozyaEiG588vQ7s2klf2UT52dUMd2Df2QpnRZAiyV7WnLKRz4
 o/+bZOynDfp99vbgJcp3N5RIV/4ovXKrxDZ19mvsr26BSnjdf/PpNQ77fClaPVy8YvIY
 3nOQ==
X-Gm-Message-State: AFuF++lf5arjmBFmQj8kas91WvxTjd4+4ScTjyRHs/BzlMLqZushtS4n
 Axq4W16T6NO74xnZ5lYEZAWmEpHA9p9FPQ8mPyM2B8EZqHydg+C9EL5EPF3Ztd98C355D86kp6S
 Bw5bG9yj+CqnR3GxTiXMOJpZT60lM68WySkVpUpSL1bExOAqwiSjmYWewn77ZZBgy/rKc0XZ6VW
 mjB43dTfNGR09lj59RFOlywfIzyd/zn6lqc49LMQuB
X-Gm-Gg: AYBFou3N0a74ReXoecE3MGIVROTrRIQSgiiMKhy0am5YTOSw0XH7bIIKELNOVJ95+17
 ygoU/nSAKnbF+OoRlVSVUmbDT2NGNdGlzziX2zISyYo1IHVqvrrfUXAqV3HJBviw4Wod4Pl6xEb
 cnH1On/68yNoVOMnHf7nqDLkiqjR9LgEhGqjD8SF0LFWmIi7j81PVHUzPJ8JecCSzKmfG4CR+zD
 8LQCLSQ4qJXztkLO5Vz6kgA8A79Dc8T5AB+0MuHA+YyXjOyTEUZtLxdCmFNXzHu95bfsjUL7Os5
 /CYeHopTbyztKHGjJ2l0lZbKZ/585CI8bYIwDJ95bE27u0Os5BPGkBs6KLK879X9TuUOgDEaN1k
 kRKGsSdH8z0V+lwbo5kqWLmpj/eogq6osoz1rs5NZRpUqaXK4/SAHSlap8nYgVgGCASVyNNa1Hb
 8/2aci
X-Received: by 2002:a05:600c:190b:b0:4a0:53e:b7d6 with SMTP id
 5b1f17b1804b1-4a0053eb977mr41080645e9.16.1790600640801; 
 Mon, 28 Sep 2026 06:04:00 -0700 (PDT)
X-Received: by 2002:a05:600c:190b:b0:4a0:53e:b7d6 with SMTP id
 5b1f17b1804b1-4a0053eb977mr41080245e9.16.1790600640220; 
 Mon, 28 Sep 2026 06:04:00 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a355d96sm29410236f8f.17.2026.09.28.06.03.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 06:03:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 30/30] agents: Add a skill for finding your way around QEMU
Date: Mon, 28 Sep 2026 15:02:28 +0200
Message-ID: <20260928130228.877003-31-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928130228.877003-1-pbonzini@redhat.com>
References: <20260928130228.877003-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.238,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


