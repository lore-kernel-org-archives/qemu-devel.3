Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C10DC55174
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 09:07:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrXaT-0008PP-AM; Wed, 05 Aug 2026 05:06:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengrong_li@linux.alibaba.com>)
 id 1wrXaO-0008Dj-HQ
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 05:06:52 -0400
Received: from [115.124.30.101] (helo=out30-101.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengrong_li@linux.alibaba.com>)
 id 1wrXaI-0007yb-HN
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 05:06:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1785920782; h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
 bh=qLk2yLSVJSNKEDiHnUyixHtNyqLugXySZdFWlzNHoT4=;
 b=ULR2FzvnpnV9HBxN2voPqOntWX1hLEpPvqw6X0XRg4YCCmJjP++7klxSRXQkEyh6wBCbJqjuw/hVsfaxjHMcFlsJx44tGLQqAQG+3FkAKW8Uu7qe2yj694BiIaGJ/RC6x20yYMpJNUozmGsNBh7T0Z0dbm7u4S2qms9VCOFPS3U=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R701e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037033178;
 MF=zhengrong_li@linux.alibaba.com; NM=1; PH=DS; RN=4; SR=0;
 TI=SMTPD_---0X8QqhXZ_1785920776; 
Received: from U-92DF4J33-2338.local(mailfrom:zhengrong_li@linux.alibaba.com
 fp:SMTPD_---0X8QqhXZ_1785920776 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 05 Aug 2026 17:06:21 +0800
From: Zhengrong Li <zhengrong_li@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: akihiko.odaki@daynix.com, viktor.prutyanov@phystech.edu,
 zhengrong_li@linux.alibaba.com
Subject: [PATCH v2 0/3] Identify faulting CPU in Windows crash dumps
Date: Wed, 05 Aug 2026 17:05:58 +0800
Message-ID: <178592075881.15274.7510279315190894277@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.101 (deferred)
Received-SPF: pass client-ip=115.124.30.101;
 envelope-from=zhengrong_li@linux.alibaba.com;
 helo=out30-101.freemail.mail.aliyun.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

When a Windows guest crashes and generates a memory dump, the dump
file does not indicate which CPU triggered the panic. This series
adds support for recording the crash_occurred flag in the QEMUCPUState
structure and using it in elf2dmp to identify the faulting CPU.

Thanks to Akihiko Odaki for reviewing v1 and pointing out these issues.

Changes since v1:
  - Revert QEMUCPUSTATE_VERSION bump (tools check size, not version)
  - Fix -Werror=3Dunused-variable on i386 by moving crash_occurred check outs=
ide #ifdef
  - Add size-based field detection in elf2dmp for forward compatibility
  - Set header context before best-effort guest memory operations
  - Use LIVE_SYSTEM_DUMP when BugcheckCode is zero
  - Use PRIx32 for BugcheckCode format specifier
  - Use linux.alibaba.com identity consistently

Zhengrong Li (3):
  runstate: set crash_occurred on guest crashloaded
  dump: add crash_occurred flag to QEMUCPUState
  elf2dmp: fill ContextBuffer with faulting CPU context

 contrib/elf2dmp/kdbg.h     |  9 +++++++
 contrib/elf2dmp/main.c     | 50 ++++++++++++++++++++++++++++++++++++--
 contrib/elf2dmp/qemu_elf.c | 20 +++++++++------
 contrib/elf2dmp/qemu_elf.h |  3 +++
 system/runstate.c          |  5 ++++
 target/i386/arch_dump.c    |  6 +++++
 6 files changed, 84 insertions(+), 9 deletions(-)

--=20
2.43.0


