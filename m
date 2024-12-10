Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3BE8E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 14:02:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL0o9-0007D3-Aj; Tue, 10 Dec 2024 09:01:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tL0o0-0007Bh-3e
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 09:01:43 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tL0ny-00073a-BU
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 09:01:39 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-38632b8ae71so2531827f8f.0
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 06:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733839296; x=1734444096; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RdRScNNnNoENuVLHw8PuiKPoBlDS12DHM2t0d0p1jZs=;
 b=Z3eZGxZpugw7SAMgUYU4V6Grn7mvVijYGMqQw6ByET/josQva5VhI/yvF32yetDCq8
 mHnHM2ApwdOVmZVRPLFLhEXyiXjx9sd20c/fBwyzuaUJgDvd2s0D88DC7Elct178Q7WJ
 DKRjpaGhXvPVMeWoBsVbJfchDaEs3oQ7tEqDQ0nDiWBg8sDc84cL7TLSZbSXM5H3F2ij
 QC9t21uYv8HHI82V+UReTUsR6fmCZrnyvXXFmlQsnb+EsUFi0Dlm7srObu8TktwRbpfe
 ikbpqvdiH9D/YpJhv6N5HnocxMyMixmU3d/Y3szehk2fo7WGwI7QA1VtdVCNGJQ5YhP3
 0eaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733839296; x=1734444096;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RdRScNNnNoENuVLHw8PuiKPoBlDS12DHM2t0d0p1jZs=;
 b=MiIQs1DJwC4aPlBq64w8c1JIDDjfK5FuH3FwZxAbJk5JEK2EWiLVGkLeOvZsrAo3AL
 inmvgds/CO3Xf2vwq8cmAeOB2fRX0cSVhbpotBNOJ1i4fLuKya3EGt49oEc0/j+qQkDf
 aJx9h+frnctuS3ufUZwFilv1rmmuunxkrZVoP2HfGADJqwUAVhvMb/xzcdwwke7nibbh
 6DAP3bjkkLXEw2UxZGXng2+BwiGSeqUk0beFnK1kPdYh1JNNN4ByiRoAPZe5Ush6CFSn
 xldEqEnO87a0acaRFgy9DSaFgUr2nNaZmJSjI+eQPjupJgXdT27jyKw5aPsSv01sIWhw
 rXcw==
X-Gm-Message-State: AOJu0YwTMDMXeZxd9R62nQs1DxyGJUgNz/OFN/z3LfczxbhpKrzZ79hL
 e1cLCnzkdjq/H/Ty+AERrCWSguhCBB8dCMAQVGv4THa/C+iUeatLArxUk8g4lV1D3HnjRSCOMxQ
 wxBM=
X-Gm-Gg: ASbGncul0R2dMqovUWLVD/Yw+zhvObDW6ZMJhkmv5kHENiEqeXrkmbtG2WoxFnU+165
 LfuKMb4xhFqOZbQ7wnE0Sx3wW9BdG1VbTeB3S6tgLEKGOAK7Vhb3YbhYkYZg4kduvz5oa2aYat/
 axiQqIA+OebdkdfaEt103TzVmAdAvAY1nskcgDBNdOCQX2oeXpX1HyMBe4loujqhsDbn64PCT9j
 utp//mq5KmVXhwRKaAvBx1yojH1v4s/CgQu9qd+ncYA72zJIZBrbvnodJBk37G9+kRVaSX6M7A5
 QIaqwF6zYPJy97oNu6i0vuio
X-Google-Smtp-Source: AGHT+IHar9U+KPALI0tVw7uqpNhs8V+dQZQyGT/hntMtI5CD5zWhG0A/69h9I7X7W8Wh9SujyhC9Hg==
X-Received: by 2002:a5d:588b:0:b0:386:3711:ff8c with SMTP id
 ffacd0b85a97d-386453def57mr3183190f8f.23.1733839295816; 
 Tue, 10 Dec 2024 06:01:35 -0800 (PST)
Received: from localhost.localdomain (223.132.22.93.rev.sfr.net.
 [93.22.132.223]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3862294b1e3sm15836567f8f.109.2024.12.10.06.01.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Dec 2024 06:01:35 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 3/3] system: Remove mentions of cpu_physical_memory_rw() API
Date: Tue, 10 Dec 2024 15:01:12 +0100
Message-ID: <20241210140112.43313-4-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241210140112.43313-1-philmd@linaro.org>
References: <20241210140112.43313-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

The previous commit mechanically replaced the legacy
API calls by more recent ones. Finish the cleaning by
manually removing the methods and the few mentions in
the documentation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/devel/loads-stores.rst            | 23 --------------------
 scripts/coccinelle/exec_rw_const.cocci | 29 --------------------------
 include/exec/cpu-common.h              | 12 -----------
 system/physmem.c                       |  7 -------
 4 files changed, 71 deletions(-)

diff --git a/docs/devel/loads-stores.rst b/docs/devel/loads-stores.rst
index 9471bac8599..37000393111 100644
--- a/docs/devel/loads-stores.rst
+++ b/docs/devel/loads-stores.rst
@@ -442,29 +442,6 @@ Regexes for git grep:
  - ``\<ldu\?[bwlq]\(_[bl]e\)\?_phys\>``
  - ``\<st[bwlq]\(_[bl]e\)\?_phys\>``
 
-``cpu_physical_memory_*``
-~~~~~~~~~~~~~~~~~~~~~~~~~
-
-These are convenience functions which are identical to
-``address_space_*`` but operate specifically on the system address space,
-always pass a ``MEMTXATTRS_UNSPECIFIED`` set of memory attributes and
-ignore whether the memory transaction succeeded or failed.
-For new code they are better avoided:
-
-* there is likely to be behaviour you need to model correctly for a
-  failed read or write operation
-* a device should usually perform operations on its own AddressSpace
-  rather than using the system address space
-
-``cpu_physical_memory_read``
-
-``cpu_physical_memory_write``
-
-``cpu_physical_memory_rw``
-
-Regexes for git grep:
- - ``\<cpu_physical_memory_\(read\|write\|rw\)\>``
-
 ``cpu_memory_rw_debug``
 ~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/scripts/coccinelle/exec_rw_const.cocci b/scripts/coccinelle/exec_rw_const.cocci
index 1a202969519..3d94e1e8630 100644
--- a/scripts/coccinelle/exec_rw_const.cocci
+++ b/scripts/coccinelle/exec_rw_const.cocci
@@ -21,13 +21,6 @@ expression E1, E2, E3, E4, E5;
 + address_space_rw(E1, E2, E3, E4, E5, true)
 |
 
-- cpu_physical_memory_rw(E1, E2, E3, 0)
-+ cpu_physical_memory_rw(E1, E2, E3, false)
-|
-- cpu_physical_memory_rw(E1, E2, E3, 1)
-+ cpu_physical_memory_rw(E1, E2, E3, true)
-|
-
 - cpu_physical_memory_map(E1, E2, 0)
 + cpu_physical_memory_map(E1, E2, false)
 |
@@ -62,18 +55,6 @@ symbol true, false;
 + address_space_write(E1, E2, E3, E4, E5)
 )
 
-// Avoid uses of cpu_physical_memory_rw() with a constant is_write argument.
-@@
-expression E1, E2, E3;
-@@
-(
-- cpu_physical_memory_rw(E1, E2, E3, false)
-+ cpu_physical_memory_read(E1, E2, E3)
-|
-- cpu_physical_memory_rw(E1, E2, E3, true)
-+ cpu_physical_memory_write(E1, E2, E3)
-)
-
 // Remove useless cast
 @@
 expression E1, E2, E3, E4, E5, E6;
@@ -93,16 +74,6 @@ type T;
 + address_space_write_rom(E1, E2, E3, E4, E5)
 |
 
-- cpu_physical_memory_rw(E1, (T *)(E2), E3, E4)
-+ cpu_physical_memory_rw(E1, E2, E3, E4)
-|
-- cpu_physical_memory_read(E1, (T *)(E2), E3)
-+ cpu_physical_memory_read(E1, E2, E3)
-|
-- cpu_physical_memory_write(E1, (T *)(E2), E3)
-+ cpu_physical_memory_write(E1, E2, E3)
-|
-
 - dma_memory_read(E1, E2, (T *)(E3), E4)
 + dma_memory_read(E1, E2, E3, E4)
 |
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 638dc806a5f..76906dfd189 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -140,18 +140,6 @@ void cpu_address_space_init(CPUState *cpu, int asidx,
  */
 void cpu_address_space_destroy(CPUState *cpu, int asidx);
 
-void cpu_physical_memory_rw(hwaddr addr, void *buf,
-                            hwaddr len, bool is_write);
-static inline void cpu_physical_memory_read(hwaddr addr,
-                                            void *buf, hwaddr len)
-{
-    cpu_physical_memory_rw(addr, buf, len, false);
-}
-static inline void cpu_physical_memory_write(hwaddr addr,
-                                             const void *buf, hwaddr len)
-{
-    cpu_physical_memory_rw(addr, (void *)buf, len, true);
-}
 void *cpu_physical_memory_map(hwaddr addr,
                               hwaddr *plen,
                               bool is_write);
diff --git a/system/physmem.c b/system/physmem.c
index dc1db3a3846..be7816479f3 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2999,13 +2999,6 @@ MemTxResult address_space_set(AddressSpace *as, hwaddr addr,
     return error;
 }
 
-void cpu_physical_memory_rw(hwaddr addr, void *buf,
-                            hwaddr len, bool is_write)
-{
-    address_space_rw(&address_space_memory, addr, MEMTXATTRS_UNSPECIFIED,
-                     buf, len, is_write);
-}
-
 enum write_rom_type {
     WRITE_DATA,
     FLUSH_CACHE,
-- 
2.45.2


