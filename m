Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BD16C43602
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 22:17:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wegl0-0003dY-Pk; Tue, 30 Jun 2026 18:16:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <devnull+shankerwangmiao.gmail.com@kernel.org>)
 id 1wegkz-0003cz-Au
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:16:41 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <devnull+shankerwangmiao.gmail.com@kernel.org>)
 id 1wegkv-0000vM-Qu
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:16:40 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 6F601409B6;
 Tue, 30 Jun 2026 22:16:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4AE53C2BCB9;
 Tue, 30 Jun 2026 22:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1782857768;
 bh=Jnac3Vd6PcQZNcrRe2BiSO47pzYJgNbV2+RTOfGAG7I=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=nbAwTUnKvFuvXDX7ddFwe6bu4ZjNhXmy2zU9Vhi9m8yPeWkC2R+wu+pYo4lnbGdU+
 bjqONzOrERvZ4BPZz5Rx+FZ1TQ55OuxEI7Go1KpIFaYAYjSx+maapXezRlIg37KJgu
 B6aXtGwbpT6lSqMzS2SbwqO8fXj2Q3wWUP9/BYovPfrdxLn6CJ75ISFOmY4Et+FUlj
 56BPG+ofxrCuSJ8/K3wxXkfTs+Z7JSCRaIINgL8VwuZpQ2Cz+jmPGRC7ByryoqAExf
 TuFL1ESwIRL2M1Yl+ibKuuS7/9SYaaDPD9cGJq1ZN+XlgZ89abQDjf8ISe/pwweGZU
 CjW/j3kK9me2A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 30DFDC43458;
 Tue, 30 Jun 2026 22:16:08 +0000 (UTC)
From: Miao Wang via B4 Relay <devnull+shankerwangmiao.gmail.com@kernel.org>
Subject: [PATCH 0/6] target/loongarch: Fixes for endianness problems in
 vector instruction emulation
Date: Wed, 01 Jul 2026 06:15:54 +0800
Message-Id: <20260701-loong64-be-v1-0-9c7d65e00697@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABpARGoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDcwND3Zz8/Lx0MxPdpFTdxJQ0i0RDUzNz0zRDJaCGgqLUtMwKsGHRsbW
 1AKAknoVcAAAA
X-Change-ID: 20260701-loong64-be-adf8a15675f1
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>,
 Miao Wang <shankerwangmiao@gmail.com>, b4-sent@kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2079;
 i=shankerwangmiao@gmail.com; s=20250715; h=from:subject:message-id;
 bh=Jnac3Vd6PcQZNcrRe2BiSO47pzYJgNbV2+RTOfGAG7I=;
 b=owEBbQKS/ZANAwAKAbAx48p7/tluAcsmYgBqREAex2BVC3kw/lfZqZlNNiDPz2E4t0UUuggLg
 NFVv1+819WJAjMEAAEKAB0WIQREqPWPgPJBxluezBOwMePKe/7ZbgUCakRAHgAKCRCwMePKe/7Z
 buKhEAC8Z3FQm8oLIiC2K4tfioKYidmkdwU+AoJpNEl6sJfxtMIaymRjl8h+bDkTAnUPXbHVBcL
 kDdlzs6gQdqxQbVLS+jhuRC2KX9MaS9zhzjmSgkFa/E37toERta3iWnhCJ7kerxupnUUm7oFx61
 lalPS6ElXxa7HLCVkBOkBFmdnwKduMuRUt4LffNHYQ37i3bPua797t2ks7W3CtXl+CtofpxQ6u0
 J6hv814ZfFdJuKqUD1pAw+S4ZNfoAA7EiS9BGsbgZA4m9H7W77O4oVQ0g/p0+dbnOwwEFIIUP6q
 DwN4ciUmhWXwsU8RY5cLdposqr6afEUs0e7exOl8J9JpAlszd0tIF73taJ9dgc9er/MQylPe9pM
 XpsSAOiAH4LOKVELZ48CvxSSwmc1nP//GzxOm1j5U0CP84e5rYzVrpAeebKngCkj3aI050OKPrW
 z7ZLyEsvGFGLnkrHvN3bCiy+ViQl4wpypki0hazjubdV91xzNoTStoDZPdhn3M3QF4b+cfrdTB7
 +t6cwqQLBiI0LKIODEjsxDVLCe1kpUT7bi+weCC6Fz52bS7HzbscxZGvDYzvXlmVzPVkgLGgUex
 R3KOq00Sg2oLKOcWzA6FUpC6TNYhKehtvxwZvSrFziezdWS67YLr7u4Ywxn4qAdkQMeKngV9Esu
 vjQe2h2uzYW3W0A==
X-Developer-Key: i=shankerwangmiao@gmail.com; a=openpgp;
 fpr=6FAEFF06B7D212A774C60BFDFA0D166D6632EF4A
X-Endpoint-Received: by B4 Relay for shankerwangmiao@gmail.com/20250715
 with auth_id=462
X-Original-From: Miao Wang <shankerwangmiao@gmail.com>
Received-SPF: pass client-ip=172.234.252.31;
 envelope-from=devnull+shankerwangmiao.gmail.com@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_FORGED_REPLYTO=2.095, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: shankerwangmiao@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The current implementation of vector instruction emulation in loongarch
target works illy on big endianness hosts. It can be reproduced using
the test cases from gcc [1]. One can cross-compile the target
loongarch64-linux-user for s390x and use qemu-s390x to run the compiled
qemu to test loongarch64 emulation on big endian hosts.

Possible reproduce steps are:

1. Install s390x cross toolchains and qemu-s390x
2. Compile qemu using ./configure --target-list=loongarch64-linux-user --cross-prefix=s390x-linux-gnu-
3. Install loongarch64 cross toolchains to compile the test cases. To
   get an accurate result, the test cases should be compiled using -O0.
   To make the error output of the test cases readable and meaningful,
   printf() should be replaced with a version without any vectorization
   optimizations, since the endianness problems will prevent printf()
   with lsx optimizations from working correctly
4. Use qemu-s390x ./qemu-loongarch64 /path/to/test_case.exe to test the
   cases on big endianness hosts.

With this patch series, all the tests in [1] can pass.

[1]: under gcc/testsuite/gcc.target/loongarch/vector in the gcc source

Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
---
Miao Wang (6):
      target/loongarch: make VReg aligned to 16 bytes
      target/loongarch: Fix offset calculation in vector registers
      target/loongarch: gen_vreplve: Fix offset calculation
      target/loongarch: gen_xvreplve0: Fix elem0 offset calculation
      target/loongarch: do_vldrepl_vl: Fix endianness when reading from guest memory
      target/loongarch: vstelm: Fix reading from vector registers

 target/loongarch/cpu.h                          |  2 +-
 target/loongarch/tcg/insn_trans/trans_vec.c.inc | 39 +++++++++++++------------
 target/loongarch/tcg/translate.c                |  6 ++--
 3 files changed, 25 insertions(+), 22 deletions(-)
---
base-commit: 30e8a06b64aa58a3990ba39cb5d09531e7d265e0
change-id: 20260701-loong64-be-adf8a15675f1

Best regards,
-- 
Miao Wang <shankerwangmiao@gmail.com>



