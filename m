Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49C43C5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:44:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwNq5-0002tS-74; Tue, 18 Aug 2026 13:43:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wwNq3-0002sn-JE
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:43:03 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wwNq2-0007vv-3B
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:43:03 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-836c436a6b3so3001627b3.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 10:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787074980; x=1787679780; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WM409keD7J89yEAgYdhBWa8aMMqXlnNUvLTfJiZti+8=;
 b=ftxhQEbFYU6nUPnMbqhb/s1yUFg0S+7mR2yvFkATzcsFCUtNVEn/HJM4ce8gjchaAh
 hZxIJ4ZkHlvGnS5qCS2+w0JZEuyd/j2TmN1WtVcd07BEhUC+cBLlKYos2JUj3bkduy/t
 ITbOagJLeRoFW/FdatU+7VDkpYkSZCNp33m2gA59OygPkKsZgSjCr6hScv65K86nkIqU
 a1Jui5pVCu/KnphHTiqSQFUQl+Z08NjlXliF2HebiV24sGvYO97Be14QOkpGzCTALxC/
 2edsSlyZZACGNk4cc19zNYvCXtdE14dJKrxVItoYBzSlmtY9/WAfQ2k9E9LsYlSWXkEC
 hF5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787074980; x=1787679780;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WM409keD7J89yEAgYdhBWa8aMMqXlnNUvLTfJiZti+8=;
 b=Eoe4sMzVaEjRrKMn1PZ45qVdx0FT19USkwwv3r5BzKh6mkzty7lJ2NsHmegj4lDXcH
 3iiFsn5Cb7tz4nfswnjsRqC3ENNXAXyBl4j6md8/kbn+JcAFBV+Kl4yrU5T7t/PtH0TA
 E7Lca+VDbvDpZzmF1IcP/b9ASqLE0NrKWt0qNzEu/AY1gCEKWXmiGpbsx+vwvJWT5At+
 uhLWe+3w0MruMYIRdhjxHanXT1Ar5flaYwblSdEu6z6RvMtTcIxqDbyLU60P1JzfeoRH
 CPcsFz2DOuPiX9jnL4zIUe6HFBfzpLeRmzdD1vYHW6iiFQhPTdiBae8bKNk66o06yOgE
 fV6A==
X-Gm-Message-State: AOJu0Yxttm4d6JjS0+U6w2PjnJUKW/A4P/0XV20gnydj0zH0ljYTlsvm
 nJwH0FyybU87hJi/jPrgZCXQF58qAvTurZtv7hnS6yOsBPRaHinWdRCCHryxFy0X3oU=
X-Gm-Gg: AR+sD11p3gGIoTAs7b5Gg81jzi/Fun2gTc7jKzlnFeWnjIU8hrU6hFmNTvNfW45RqKS
 kHDAn31+JccHHjKI9wIFKwicNnhRO65vvauximK9JM4vm/dCQDotR5ZVOewdhWxEoGZgo6dTZFZ
 Avgl848kuPxHe/CmZGYQmqn0ZT7xxlPjp0CANs/VXenEnOA08KUaCAWORtcuBAHaaXJi6AQtAo+
 wqSfSMwng+UfD5HirM+9q0+U5zClY8wZPfx+P9sVKoa3aDWXQzHbR/9n43x85pOGLdNkq/JZrjz
 P2h5CccJygAye7cCu3N0eNXLH4XXoCTihY4Rb6v5CZHzgyD9OHFRB0G79oTxoXV/KxVV0vOM6df
 9YdGn/xGKULGq3Lda0V30E/tSsphedEyTA+CubM/RpUJJBJuJkWHfACO/3Ui12em741Roy6TCw9
 2AIFuIbJ1ulh8CiRUPLiU8l6VxPCWi3KpctnCigv1HYe/iu1KSa85oGbCT1jM3
X-Received: by 2002:a05:690c:26c2:b0:814:5f5b:6378 with SMTP id
 00721157ae682-8370dfb3aedmr146926227b3.12.1787074980454; 
 Tue, 18 Aug 2026 10:43:00 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-84068a3b800sm24907847b3.12.2026.08.18.10.42.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 10:42:59 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, pbonzini@redhat.com, philmd@mailo.com,
 zhao1.liu@intel.com, laurent@vivier.eu, deller@gmx.de,
 pierrick.bouvier@oss.qualcomm.com, Matt Turner <mattst88@gmail.com>
Subject: [PATCH 2/8] accel/tcg: enlarge the TB jump cache to 64K entries
Date: Tue, 18 Aug 2026 13:42:41 -0400
Message-ID: <20260818174247.649526-3-mattst88@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260818174247.649526-1-mattst88@gmail.com>
References: <20260818174247.649526-1-mattst88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=mattst88@gmail.com; helo=mail-yw1-x112e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

The per-CPU TB jump cache has held 4096 entries since it was introduced.
That is too small for guests running large programs: an emulated compiler
misses often enough that the fallback qht lookup shows up prominently in
a profile.

Measured with qemu-alpha running an emulated alpha gcc 16.2.0 compiling
the SQLite 3.45.1 amalgamation (255k lines, -O2) on an x86-64 host. The
compile performs 34.2 billion TB executions, of which 8.4 billion take
the indirect dispatch path.

Sizing curve, on top of the preceding patch, instructions retired and
wall clock:

    12 bits (  64 KiB): 1,563,829,403,943          133.13s
    14 bits ( 256 KiB): 1,493,865,985,972  -4.47%  124.89s  -6.19%
    16 bits (   1 MiB): 1,469,729,281,442  -6.02%  120.97s  -9.13%
    18 bits (   4 MiB): 1,462,262,363,257  -6.49%  120.16s  -9.74%

16 bits is the knee. 18 buys another 0.47% of instructions for four times
the memory, and since instructions retired does not account for the data
cache pressure of a 4 MiB table, that 0.47% is probably not real: the
wall clock difference between 16 and 18 bits is 0.67%, against a
run-to-run spread of the same order.

In a perf profile the mechanism is visible directly: tb_htable_lookup(),
which is where qht_lookup_custom() lands once it is inlined in an LTO
build, falls from 5.73% of samples to 1.52%.

The cost is memory: the cache grows from 64 KiB to 1 MiB per vCPU. That
is easy to justify for a single-vCPU linux-user process and less obvious
for system emulation with many vCPUs, so this may want to be sized by
target or made tunable rather than raised unconditionally.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 accel/tcg/tb-jmp-cache.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git ./accel/tcg/tb-jmp-cache.h ./accel/tcg/tb-jmp-cache.h
index c3a505e394..268dacd7ba 100644
--- ./accel/tcg/tb-jmp-cache.h
+++ ./accel/tcg/tb-jmp-cache.h
@@ -12,7 +12,7 @@
 #include "qemu/rcu.h"
 #include "exec/cpu-common.h"
 
-#define TB_JMP_CACHE_BITS 12
+#define TB_JMP_CACHE_BITS 16
 #define TB_JMP_CACHE_SIZE (1 << TB_JMP_CACHE_BITS)
 
 /*
-- 
2.54.0


