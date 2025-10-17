Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4402CCD199
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 21:13:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9rka-0003px-Hh; Fri, 17 Oct 2025 17:12:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+c033f0.33e920-qemu-devel=nongnu.org@mail.yodel.dev>)
 id 1v9rkV-0003pH-O3
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 17:12:32 -0400
Received: from pc232-62.mailgun.net ([143.55.232.62])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+c033f0.33e920-qemu-devel=nongnu.org@mail.yodel.dev>)
 id 1v9rkT-0005kp-2S
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 17:12:31 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mail.yodel.dev;
 q=dns/txt; s=pdk1; t=1760735538; x=1760742738; 
 h=Content-Transfer-Encoding: Content-Type: MIME-Version: Message-ID: Date:
 Subject: Subject: Cc: To: To: From: From: Sender: Sender; 
 bh=XXG6XyRvvWWJM2g6tmrow053fnjUzMhW3R28qYPomZY=;
 b=mADzAIfV38xb8iitKSgxRfNQ34C8LSz38+gHvsjsq01EW/8CJT2zUwfKSiiWiu1f3IU/vjwcMAok5NtjLpHrKbd1Unb1uO6P6dva8NxelypuQdMfrTSWNi6gJA2BnApWw3E+L/MjL2pyhRE3wsRsSAt9nNnBzSRfRSMxWgYVD3cKBar+Y2AO5mD+4N7RJk/gffuV1robYZwxXyvVWW1Krs8hGucRvs8QDLDjreFq3IGNnAXAFcL04wE3pt2ZV29Ty9MpYblpmbBr8rONXM2tXl6bz7uA58XFcM3qFvtMxIw4Dm/MG365WGytAhfUkhUG6lR3qxNKylJabrnwMbWtvg==
X-Mailgun-Sid: WyJjZmM4NiIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjMzZTkyMCJd
Received: from mail.yodel.dev (mail.yodel.dev [35.209.39.246]) by
 103c014fc94d69143aaea30297fe13644379dd6e036d047744d4acfe9a9dfef0 with SMTP id
 68f2b13201f5cfbfc24094da; Fri, 17 Oct 2025 21:12:18 GMT
X-Mailgun-Sending-Ip: 143.55.232.62
To: qemu-devel@nongnu.org
Cc: Yodel Eldar <yodel.eldar@yodel.dev>
Subject: [PATCH v2 0/3] gdbstub: Export helper to use GDB errno values
Date: Fri, 17 Oct 2025 16:11:42 -0500
Message-ID: <20251017211149.163762-1-yodel.eldar@yodel.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1927; i=yodel.eldar@yodel.dev;
 h=from:subject; bh=pDlO0OF00whh1Hhef+ufJPLx+POzU7c981l7OIPzs0w=;
 b=owGbwMvMwCU29Z3/drNU3zWMp9WSGDI+rWCpfxCTcX+/9qvTWp/zJh955qVTmfwzTHj91S2sz
 C6MMYz7OkpZGMS4GGTFFFkun5U465C7uytt5Y/7MHNYmUCGMHBxCsBEWCQZ/tkWzJ1/Sb/jLeeE
 uGf/lxyf1mCxt6DHt+DNgj0NOywnuzEwMvTGfuA5UScU1nOgrvF3iEaN0+MbIsK6Nz893N/51cd
 7EzcA
X-Developer-Key: i=yodel.eldar@yodel.dev; a=openpgp;
 fpr=D3CD18CD406DBB8A66A9F8DF95EE4FB736654DAC
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=143.55.232.62;
 envelope-from=bounce+c033f0.33e920-qemu-devel=nongnu.org@mail.yodel.dev;
 helo=pc232-62.mailgun.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Yodel Eldar <yodel.eldar@yodel.dev>
From:  Yodel Eldar via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Currently, F reply packets in gdbstub/user-target.c emit the host's
errno values [1], but to facilitate host<->target independence the GDB
File-I/O protocol defines its own set of supported errno values that
should be used in replies instead.

This series sees to that by:
Patch 2: Exporting a mapping helper function statically defined in
m68k-dependent code by declaring it in include/gdbstub/syscalls.h
with the GDB File-I/O errno values, and moving the definition to
gdbstub/syscalls.c.
Patch 3: Passing the host errnos to the newly global mapping function
before emitting the result in F reply packets. Please note that this
patch resolves the final task remaining in GitLab issue #2751.

Patch 1 adds two GDB File-I/O errno values that were previously
undocumented despite having support.

To Alex Bennée: Thanks for reviewing v1! I deliberately left out the
Reviewed-by git trailer, because the patch underwent nontrivial
changes, and I did not think I could include it in good faith. Your
comment about the existing File-I/O errno values led me to the helper
function in the target-dependent code.

Thanks!

Changes in v2:
- Split into multiple commits
- Use existing mapping function (host_to_gdb_errno) via exportation

Link to v1: https://lore.kernel.org/qemu-devel/20251015162520.15736-1-yodel.eldar@yodel.dev/

[1] https://gitlab.com/qemu-project/qemu/-/issues/2751

Yodel Eldar (3):
  include/gdbstub/syscalls: Add GDB_{EIO,ENOSYS} errno values
  gdbstub: Export host_to_gdb_errno File-I/O helper function
  gdbstub/user-target: Convert host errno to GDB File-I/O errno

 gdbstub/syscalls.c         | 36 ++++++++++++++++++++++++++++++++++++
 gdbstub/user-target.c      | 13 +++++++++----
 include/gdbstub/syscalls.h | 11 +++++++++++
 target/m68k/m68k-semi.c    | 29 -----------------------------
 4 files changed, 56 insertions(+), 33 deletions(-)

-- 
2.51.1.dirty


