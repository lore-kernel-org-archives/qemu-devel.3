Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50F40E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 17:06:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLmdF-00019y-8h; Thu, 12 Dec 2024 12:05:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <James.Bottomley@HansenPartnership.com>)
 id 1tLmdD-00019b-Ho
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 12:05:43 -0500
Received: from bedivere.hansenpartnership.com ([2607:fcd0:100:8a00::2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <James.Bottomley@HansenPartnership.com>)
 id 1tLmd8-0002xn-Gk
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 12:05:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=hansenpartnership.com; s=20151216; t=1734023131;
 bh=lDCU1Rq+2zQ6nPfPzYVO8tJfau7h7+88PXR18QsNeCA=;
 h=From:To:Subject:Date:Message-Id:From;
 b=eKBK3OSodNPgYr6M62FUyNKvCQ85HyShGVKv3IVbqKKRQxTG2+RU551Oq9cfcmRjt
 7fkYd3kABvNBpPDWOJAgtW1H8RevUpyA68Hf4kZmQvEw9zv7Om0l844RMbrO04LJTX
 mufh5gHGgL7y+XRh1oLsvxkQMEhQCc5BX1srmOI8=
Received: from localhost (localhost [127.0.0.1])
 by bedivere.hansenpartnership.com (Postfix) with ESMTP id D24AB128B0FF;
 Thu, 12 Dec 2024 12:05:31 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id cxe7zRgaTrFo; Thu, 12 Dec 2024 12:05:31 -0500 (EST)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
 by bedivere.hansenpartnership.com (Postfix) with ESMTP id D8356128B0FE;
 Thu, 12 Dec 2024 12:05:30 -0500 (EST)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v11 0/2] tpm: add mssim backend
Date: Thu, 12 Dec 2024 12:05:26 -0500
Message-Id: <20241212170528.30364-1-James.Bottomley@HansenPartnership.com>
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
threading).

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

v11 Fix another merge conflict and correct a warm reboot problem where
    the TPM isn't getting reset (meaning the PCR values are wrong).

James

---

James Bottomley (2):
  tpm: convert tpmdev options processing to new visitor format
  tpm: add backend for mssim

 MAINTAINERS                    |   6 +
 backends/tpm/Kconfig           |   5 +
 backends/tpm/meson.build       |   1 +
 backends/tpm/tpm_emulator.c    |  25 +--
 backends/tpm/tpm_mssim.c       | 335 +++++++++++++++++++++++++++++++++
 backends/tpm/tpm_mssim.h       |  44 +++++
 backends/tpm/tpm_passthrough.c |  23 +--
 docs/specs/tpm.rst             |  39 ++++
 include/sysemu/tpm.h           |   5 +-
 include/sysemu/tpm_backend.h   |   2 +-
 qapi/tpm.json                  |  50 ++++-
 system/tpm-hmp-cmds.c          |   9 +
 system/tpm.c                   |  91 ++++-----
 system/vl.c                    |  19 +-
 14 files changed, 546 insertions(+), 108 deletions(-)
 create mode 100644 backends/tpm/tpm_mssim.c
 create mode 100644 backends/tpm/tpm_mssim.h

-- 
2.35.3


