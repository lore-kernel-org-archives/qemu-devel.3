Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE0E606A31D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 12:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=bXyHjuOk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJrZx-0007U4-CC; Thu, 22 Oct 2026 08:07:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fangyu.yu@linux.alibaba.com>)
 id 1xJrZi-0007TM-MO; Thu, 22 Oct 2026 08:07:15 -0400
Received: from [115.124.30.99] (helo=out30-99.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fangyu.yu@linux.alibaba.com>)
 id 1xJrZa-0001gN-7m; Thu, 22 Oct 2026 08:07:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1792670796; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=FJ6yTtzWshNsLQmFV/ajSLAfbp+yhrn+FsSCSUUgRmk=;
 b=bXyHjuOknePj87EvPBI1DTdUSdKmyavdxr/NlCofgkho6N/AXEysXFahJ+/zBoAU0FVTSs/NKfeUlyh5FcG3gmbfIXLtd/5ymUIpva3I7EtTlCuxaqTXne57h53ypuwvzf5/TX1CH1cosgyYoN6U7W77H4ihAPe69bxYaP/zvKA=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R601e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037033178;
 MF=fangyu.yu@linux.alibaba.com; NM=1; PH=DS; RN=7; SR=0;
 TI=SMTPD_---0XDJ9.P-_1792670475; 
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com
 fp:SMTPD_---0XDJ9.P-_1792670475 cluster:ay36) by smtp.aliyun-inc.com;
 Thu, 22 Oct 2026 20:01:17 +0800
From: fangyu.yu@linux.alibaba.com
To: daniel.barboza@oss.qualcomm.com
Cc: alistair.francis@wdc.com, chao.liu.zevorn@gmail.com, liwei1518@gmail.com,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com
Subject: Re: [PATCH 1/2] target/riscv/csr.c: do not allow mstatus MPV/GVA
 writes
Date: Thu, 22 Oct 2026 20:01:11 +0800
Message-Id: <20261022120111.24298-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260514194537.2416243-2-daniel.barboza@oss.qualcomm.com>
References: <20260514194537.2416243-2-daniel.barboza@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.99 (deferred)
Received-SPF: pass client-ip=115.124.30.99;
 envelope-from=fangyu.yu@linux.alibaba.com;
 helo=out30-99.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

>The priv spec states the following about mstatus.MPV:
>
>"The MPV bit (Machine Previous Virtualization Mode) is written by the
>implementation whenever a trap is taken into M-mode."
>
>And, about mstatus.GVA:
>
>"Field GVA (Guest Virtual Address) is written by the implementation
>whenever a trap is taken into M-mode."
>
>Both are written during riscv_cpu_do_interrupt().  They're not supposed
>to be written by userspace.  As far as write_mstatus goes these fields
>are read only.  The same applies for mstatush.MPV/mstatush.GVA.
>
>Fixes: 03dd405dd5 ("target/riscv: Support MSTATUS.MPV/GVA only when RVH is enabled")
>Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
>---
> target/riscv/csr.c | 5 +----
> 1 file changed, 1 insertion(+), 4 deletions(-)
>
>diff --git a/target/riscv/csr.c b/target/riscv/csr.c
>index e1cd4a299c..74f5f868f0 100644
>--- a/target/riscv/csr.c
>+++ b/target/riscv/csr.c
>@@ -2040,9 +2040,6 @@ static RISCVException write_mstatus(CPURISCVState *env, int csrno,
>     }
>
>     if (xl != MXL_RV32 || env->debugger) {
>-        if (riscv_has_ext(env, RVH)) {
>-            mask |= MSTATUS_MPV | MSTATUS_GVA;
>-        }

Hi Daniel,

Could you share the motivation for making MPV/GVA read-only here? Was
this based on a real misbehavior, or mainly on the spec wording.

I noticed that the current OpenSBI code modifies MPV in several places
(sbi_hart_switch_mode, sbi_trap_redirect, sse_event_resume). With this
patch, those writes are dropped.

Thanks,
Fangyu

>         if ((val & MSTATUS64_UXL) != 0) {
>             mask |= MSTATUS64_UXL;
>         }
>@@ -2079,7 +2076,7 @@ static RISCVException write_mstatush(CPURISCVState *env, int csrno,
>                                      target_ulong val, uintptr_t ra)
> {
>     uint64_t valh = (uint64_t)val << 32;
>-    uint64_t mask = riscv_has_ext(env, RVH) ? MSTATUS_MPV | MSTATUS_GVA : 0;
>+    uint64_t mask = 0;
>
>     if (riscv_cpu_cfg(env)->ext_smdbltrp) {
>         mask |= MSTATUS_MDT;
>--
>2.43.0

