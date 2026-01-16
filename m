Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4C94D4A5E2
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 01:47:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgYvH-0000uh-K3; Thu, 15 Jan 2026 20:46:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1vgYvE-0000tc-FD
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 20:46:44 -0500
Received: from k62.kb8c70eb.use4.send.mailgun.net ([204.220.184.62])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1vgYvC-0000NO-Pm
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 20:46:44 -0500
X-Mailgun-Sid: WyI4ZDFlNiIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjk3NjA3ZSJd
Received: from mail.yodel.dev (mail.yodel.dev [35.209.39.246]) by
 e135ba6b4eaabb3a718321876b3d4c1b0ef20ef0d8c1d5c55b022d32c50c63c2 with SMTP id
 69699879834a10b0f0ab8bf4; Fri, 16 Jan 2026 01:46:33 GMT
X-Mailgun-Sending-Ip: 204.220.184.62
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yodel.dev;
 s=rsa2048; t=1768527992;
 bh=PcA0PqFcyi/WpunFKVQepOyGOWTMA5jeNU6hH1h2BCc=;
 h=X-Mailgun-Dkim:From:To:Cc:Subject:Date:Message-ID:MIME-Version:
 Content-Transfer-Encoding:From:Reply-to:Subject:Date:Message-id:To:
 Cc:Mime-version:Content-type:Content-transfer-encoding:In-reply-to:
 References;
 b=jNxzqk4VmxidolHOz8st/EXMyXOCIlPgxBaG1R3mEccvgDDt9KudtYAJSNUlrbghR
 e5Vd8JufhRFP8J+zxPlrFrphH9h/40BCh4uMHCzQU7SLWd7ye84OdgAkpbU+2PYcmw
 yH18A5s7z2scAoewTZMZ9iCZr9nlEf0WJkZvGt2xhoaLuX/huIf9BFyWU3tpZff72g
 i796tgeOTCCP3xuqS3SbudWBWOwBXKsgT6EI4/De2Iu+psk/NIZlvdvoUj+1pOLxZb
 Q+VqAcms/jEx7mVACrLy5zJ9JxElmWO6oSFVK/SDPjWY1Do9IJ3GqSpHUZZeNfbDXi
 VgOSrK24PhtaA==
X-Mailgun-Dkim: no
X-Mailgun-Dkim: no
From: Yodel Eldar <yodel.eldar@yodel.dev>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Dominik Disconnect3d Czarnota <dominik.b.czarnota@gmail.com>,
 Yodel Eldar <yodel.eldar@yodel.dev>
Subject: [PATCH v3 0/3] gdbstub: Export helper to use GDB errno values
Date: Thu, 15 Jan 2026 19:46:09 -0600
Message-ID: <20260116014612.226183-1-yodel.eldar@yodel.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=204.220.184.62;
 envelope-from=bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev;
 helo=k62.kb8c70eb.use4.send.mailgun.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Currently, F reply packets in gdbstub/user-target.c emit the host's
errno values [1], but to facilitate host<->target independence the GDB
File-I/O protocol defines its own set of supported errno values that
should be used in replies instead.

Patch 1 adds two GDB File-I/O errno values that were previously
undocumented despite having support.

Patch 2 exports a mapping helper function statically defined in
m68k-dependent code by declaring it in include/gdbstub/syscalls.h
with the GDB File-I/O errno values, and moving the definition to
gdbstub/syscalls.c.

Patch 3 passes the host errnos to the newly global mapping function
before emitting the result in F reply packets. This is the only patch
that still needs review, although it is somewhat similar to the v1
version that Alex reviewed.

I'm resending instead of just pinging, because there were DKIM-signing
issues last time, and that led to From-munging of the emails which could
be problematic for tooling. I believe that problem's resolved now.

Besides the DKIM-signing issue, the bashism in the commit title of Patch
1 was getting mangled with a spurious space presumably by Mailman, so
I've also changed it, despite my partiality for bashisms as that also
would've caused DKIM verification failure and possible munging.

Thanks to Richard for the reviews in v2 and for having written that nice
helper function exported and used in this series.

Thanks to Alex for the review of v1 that is now Patch 3. I wanted to
collect your R-b, but the patch underwent nontrivial change in v2, so I
left it out in case you had objections to those changes.

Changes in v3:
No functional changes
- Rebase on mainline (no conflicts)
- Collect R-b's (Thanks, Richard)
- Minor rewording of commit messages

Changes in v2:
- New patch adding two errno values
- New patch exporting helper function that maps errno values

Link to v2:
https://lore.kernel.org/qemu-devel/20251017211149.163762-1-yodel.eldar@yodel.dev/
Link to v1:
https://lore.kernel.org/qemu-devel/20251015162520.15736-1-yodel.eldar@yodel.dev/

[1] https://gitlab.com/qemu-project/qemu/-/issues/2751

Thanks,
Yodel

Yodel Eldar (3):
  include/gdbstub/syscalls: Add EIO and ENOSYS GDB File-I/O errno values
  gdbstub: Export host_to_gdb_errno File-I/O helper function
  gdbstub/user-target: Convert host errno to GDB File-I/O errno

 gdbstub/syscalls.c         | 36 ++++++++++++++++++++++++++++++++++++
 gdbstub/user-target.c      | 13 +++++++++----
 include/gdbstub/syscalls.h | 11 +++++++++++
 target/m68k/m68k-semi.c    | 29 -----------------------------
 4 files changed, 56 insertions(+), 33 deletions(-)

-- 
2.52.0


