Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4DEAEB26E7
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 16:35:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpqgb-0003Vv-Mt; Tue, 10 Feb 2026 11:34:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vpqgZ-0003Us-NB
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 11:33:59 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vpqgX-0000Vr-SS
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 11:33:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=W7Aeogg4CIwzLlM9lsAicNoeiOBoghUBP2imT9yVJkw=; b=p8iLAJ5gqg6fSAY
 +e3O2HXDe4ouAAOqwsmAIr+y95F4f2/WPOBhgO7WfcmvAifhfqwpci6D00xq9tuIauqtqWLYuMHgS
 5D0r/nBC/frVkWxp31avk6kiC/HytVC22uhoJwZoyYItmYt6zouj0nivIfLgard8YIuMJZWwshHGZ
 mE=;
Subject: [PATCH v2 0/4] hppa: Add simple C3600 machine with PA-8600 CPU
Date: Tue, 10 Feb 2026 17:37:14 +0100
Message-Id: <20260210-hppa-c3600-v2-0-9ca09c677012@rev.ng>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22PQQ6CMBBFr0Jmbc20tJS48h6GmApT2g1gi42Ec
 HcrLNy4fJP8N/+vECl4inApVgiUfPTjkEGcCmidGXpivssMAkWFgiNz02RYW1aIzNZYa41klNK
 QA1Mg69+77NYcHOj5ys75OP6U+QMKxTlKNrkl3k3XBfZAKzWZErk0lyTh63A+zmNY9n6J75J/V
 RJnyAzX1KraoirtNY85Dz0027Z9ACs5aJHlAAAA
X-Change-ID: 20260210-hppa-c3600-f808770ea557
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, 
 Helge Deller <deller@gmx.de>, Anton Johansson <anjo@rev.ng>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770741450; l=2138;
 i=anjo@rev.ng; s=20260210; h=from:subject:message-id;
 bh=RLA+Bic8QQ1BAHVQqfdUCotI28NtGvRf7H5eFZU3OQE=;
 b=hh+I/JLqdnwMD/EydGjYkECgevayDoL22zhum8mcPHjuE+i+KCvkMLqBVXJT1CZ2lnybhDah4
 gHKj/25sd89DDHHSKNDYETqs/3jyzFYeIUd4nWOzttG9X3568FNo5Bl
X-Developer-Key: i=anjo@rev.ng; a=ed25519;
 pk=dKsZvj/g3kgDxnV1/SWg8a0YNGSpWtFGNsWIepQYKow=
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This patchset tries to address a discrepancy between the C3700 machine
in QEMU/SeaBIOS and the documentation (chapter 5)

  http://ftp.parisc-linux.org/docs/whitepapers/PA-8700wp.pdf

where 40 bits of physical address space are used in SeaBISO compared
to the 44 bits specified in the documentation.

A PA-8600 CPU with 40 bits of physical address space is added along with
a C3600 machine using it by default.  AFAICT there are no major
differences from QEMUs side between the PA-8600 and 8700 aside from the
physical address space size.  The PA-8700 machine can then be
moved to using 44 bits.  To account for the discrepancy with SeaBIOS, the
functional tests now run a C3700 but with a PA-8600 CPU.

CPU model definitions now inherit from a TYPE_HPPA_CPU base class and
use a HPPACPUDef sturct to provide model specifics, similar to the SPARC
and RISCV targets.  This hopefully makes it easier to add other models,
such as the 8800/8900.

Based on:
  PATCH v4 0/8] single-binary: Drop TARGET_PHYS_ADDR_SPACE_BITS
  (20260210-phys_addr-v4-0-725a589e83c8@rev.ng)

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
Changes in v2:
- Missed a reference to the old "hppa" CPU model, updated to
  "pa-7300lc".
- Link to v1: https://lore.kernel.org/qemu-devel/20260210-hppa-c3600-v1-0-a17ec58f053f@rev.ng

---
Anton Johansson (4):
      hppa: Prepare for additional CPU models
      hppa: Introduce HPPACPUDef
      hppa: Get physical address space bits from CPUHPPADef
      hppa: Add C3600 machine with PA-8600 CPU

 target/hppa/cpu-qom.h                 |  8 ++++-
 target/hppa/cpu.h                     | 35 ++++++++++++++++----
 hw/hppa/machine.c                     | 62 +++++++++++++++++++++++++++--------
 hw/pci-host/astro.c                   |  2 +-
 linux-user/hppa/elfload.c             |  2 +-
 target/hppa/cpu.c                     | 52 ++++++++++++++++++++++-------
 target/hppa/mem_helper.c              | 40 +++++++---------------
 tests/qtest/machine-none-test.c       |  2 +-
 tests/functional/hppa/test_seabios.py |  3 ++
 9 files changed, 141 insertions(+), 65 deletions(-)


