Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D70CC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 19:09:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1sqy-00054i-OR; Tue, 30 Apr 2024 15:09:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <James.Bottomley@HansenPartnership.com>)
 id 1s1sqw-0004zT-Uy
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 15:09:22 -0400
Received: from bedivere.hansenpartnership.com ([2607:fcd0:100:8a00::2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <James.Bottomley@HansenPartnership.com>)
 id 1s1squ-00017j-FM
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 15:09:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=hansenpartnership.com; s=20151216; t=1714504156;
 bh=siEmCuw1x1PnJ3XH3OVUuQfUp+WHTARIK/zb76qtpFQ=;
 h=From:To:Subject:Date:Message-Id:From;
 b=XV2UpqqcDzU83SPwrnHiPxLdQ0TszoD5ANUrcCd1cNT9UarfqlEvCDNgDe9nQuE8s
 9p0nLFLzu4qpnv1k5oVAS3GWJR6ayRYn3d21EtK+p2ebD5z5HOXa9zjYkL+0itLlMn
 ek+jDlmHEG+778M5fmabZK6aZhW5UdLAMdjwpK18=
Received: from localhost (localhost [127.0.0.1])
 by bedivere.hansenpartnership.com (Postfix) with ESMTP id AB5681280686;
 Tue, 30 Apr 2024 15:09:16 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id izC2P9F4G3mH; Tue, 30 Apr 2024 15:09:16 -0400 (EDT)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
 by bedivere.hansenpartnership.com (Postfix) with ESMTP id E70481280087;
 Tue, 30 Apr 2024 15:09:15 -0400 (EDT)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v10 0/2] tpm: add mssim backend
Date: Tue, 30 Apr 2024 15:08:53 -0400
Message-Id: <20240430190855.2811-1-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:fcd0:100:8a00::2;
 envelope-from=James.Bottomley@HansenPartnership.com;
 helo=bedivere.hansenpartnership.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

The requested feedback was to convert the tpmdev handler to being json
based, which requires rethreading all the backends.  The good news is
this reduced quite a bit of code (especially as I converted it to
error_fatal handling as well, which removes the return status
threading).  The bad news is I can't test any of the conversions.
swtpm still isn't building on opensuse and, apparently, passthrough
doesn't like my native TPM because it doesn't allow cancellation.

v3 pulls out more unneeded code in the visitor conversion, makes
migration work on external state preservation of the simulator and
adds documentation

v4 puts back the wrapper options (but doesn't add any for mssim since
it post dates the necessity)

v5 rebases to the latest master branch and adjusts for removed use_FOO ptrs

v5 updates help to exit zero; does some checkpatch tidying

v7 merge review feedback and add acks.

v8 adds better error handling, more code tidies and adds command
   socket disconnection/reconnection (instead of trying to keep the
   socket open the whole time).  This adds overhead, but makes
   debugging guest kernel TPM issues much easier.

v9 Fix merge conflict with optarg->optstr conversion

v10 Fix more merge conflicts and update API versions

James

---

James Bottomley (2):
  tpm: convert tpmdev options processing to new visitor format
  tpm: add backend for mssim

 MAINTAINERS                    |   6 +
 backends/tpm/Kconfig           |   5 +
 backends/tpm/meson.build       |   1 +
 backends/tpm/tpm_emulator.c    |  25 ++-
 backends/tpm/tpm_mssim.c       | 319 +++++++++++++++++++++++++++++++++
 backends/tpm/tpm_mssim.h       |  44 +++++
 backends/tpm/tpm_passthrough.c |  23 +--
 docs/specs/tpm.rst             |  39 ++++
 include/sysemu/tpm.h           |   5 +-
 include/sysemu/tpm_backend.h   |   2 +-
 qapi/tpm.json                  |  50 +++++-
 system/tpm-hmp-cmds.c          |   9 +
 system/tpm.c                   |  91 ++++------
 system/vl.c                    |  19 +-
 14 files changed, 530 insertions(+), 108 deletions(-)
 create mode 100644 backends/tpm/tpm_mssim.c
 create mode 100644 backends/tpm/tpm_mssim.h

-- 
2.35.3


