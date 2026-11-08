Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C931D606A31A
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2026 06:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rispop.dev header.i=@rispop.dev header.a=rsa-sha256 header.s=protonmail header.b=KBwTJfH4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPwgk-00029r-OT; Sun, 08 Nov 2026 01:47:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rishab@rispop.dev>) id 1xPwgh-00028I-C9
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 01:47:35 -0500
Received: from mail-05.mail-europe.com ([85.9.206.169])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rishab@rispop.dev>) id 1xPwgd-0006WT-Rh
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 01:47:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rispop.dev;
 s=protonmail; t=1794120444; x=1794379644;
 bh=FBRLPQ0QOXpftu9ohtsd+3bgmQ9GxiSiJIdfyScD/OE=;
 h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=KBwTJfH4NZLI1HBFgd4WvhUnUfh6eRh8dn40PqB5OzTim14ZaKzp3B/0o+Dk4FqIq
 km7opgt8b4iCe/qnUFXVHaEEgD88VMIi0wAcT5wYzlpJZVYqT3t0D88cyQnGpkqBMW
 /mZHSZ7mk4cidsDoFeKjiVDSoA1kDeWs0U1cXjOkQNeMMc4Oqrk903JZMO7pCg1bPo
 1vqrjgGk1NnPevkd30HKZBB/PLC1/X+cRqtDo24/IG7MIgreNdetwtyX8wNtaZ4A8E
 FRKkSaGytetGFQiyojGpourDyHUmAXdaMJ9V8s7Q5YO5oxFZbosBsEK+Ys2uwl4eMl
 a6CGyVQ8B2KAA==
X-Pm-Submission-Id: 4jMk483zJMz2ScP4
From: Rishab Pradeep <rishab@rispop.dev>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Tarun Patanjali <tarun.patanjali@utexas.edu>,
 Chris Elwood <christopher.elwood2024@gmail.com>,
 Rishab Pradeep <rishab@rispop.dev>
Subject: [PATCH v2 0/2] target/riscv: Apply pointer masking to SSPUSH/SSPOPCHK
Date: Sun,  8 Nov 2026 00:46:39 -0600
Message-ID: <20261108064641.179764-1-rishab@rispop.dev>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=85.9.206.169; envelope-from=rishab@rispop.dev;
 helo=mail-05.mail-europe.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SSPUSH and SSPOPCHK form their effective address from ssp rather than
a GPR, so they bypass get_address() and never apply the pointer-masking
ignore transformation. With pointer masking enabled, a tagged ssp
raises a store/AMO page fault, whereas Spike, Sail and Whisper mask
the access.

Patch 1 factors the address adjustment out of get_address() and
get_address_indexed() into gen_pm_adjust_addr(), with no functional
change. Patch 2 applies it to the SSPUSH/SSPOPCHK address. ssp is still
written back unmasked, and the SSPOPCHK value comparison is unchanged.

Tested with the reproducer from the issue; all four cases now match
Spike.

v1 -> v2:
  - Patch 1: Collected Reviewed-by from Daniel Henrique Barboza.
  - Patch 2: Cite Privileged Architecture Specification, Section
    17.1.2.6 ("Memory Accesses Subject to Pointer Masking"), in the
    commit message, per Daniel's review.

v1: https://lore.kernel.org/qemu-devel/20261029183751.11143-1-rishab@rispop.dev/

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4758

Rishab Pradeep (2):
  target/riscv: Factor out pointer-masking address adjustment
  target/riscv: Apply pointer masking to SSPUSH/SSPOPCHK addresses

 .../tcg/insn_trans/trans_rvzicfiss.c.inc      |  8 +++++--
 target/riscv/tcg/translate.c                  | 21 ++++++++++---------
 2 files changed, 17 insertions(+), 12 deletions(-)

-- 
2.56.0


