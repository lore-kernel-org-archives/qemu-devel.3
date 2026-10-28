Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C99606A325
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 12:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=f6TTL0+0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM39d-0001Bo-Da; Wed, 28 Oct 2026 08:53:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1xM39b-000193-Eu
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 08:53:19 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1xM39Z-0003L3-Oh
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 08:53:19 -0400
Received: from DESKTOP-TUU1E5L.fritz.box (p3e9c09f4.dip0.t-ipconnect.de
 [62.156.9.244])
 by linux.microsoft.com (Postfix) with ESMTPSA id E05D320B7166;
 Wed, 28 Oct 2026 05:52:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E05D320B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1793191982;
 bh=d9V14QkvbHFZy3qGpe0q+W6Xm244wrN/Tqh1cR3kHxI=;
 h=From:To:Cc:Subject:Date:From;
 b=f6TTL0+08hlG8eDetlQko8xuXwKSGkArOB73E9xB80UPFo42ZC8nP54hq7h4bcV3h
 CWO3dXmVoEKKyZEtvw/5QY9SzFUA9dcAaKfbKW8W72s3H3HG36oKZdmXzjH/kHgkOk
 oqYNo1pUhLZdyMyEqSjJo3/PG7+XAer8KRNMg0yw=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Wei Liu <wei.liu@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <doru.blanzeanu@microsoft.com>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Wei Liu <liuwe@microsoft.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Magnus Kulke <magnuskulke@microsoft.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 0/4] accel/mshv: add support for PIC interrupt injection
Date: Wed, 28 Oct 2026 13:53:04 +0100
Message-Id: <20261028125308.147630-1-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_PASS=-0.001,
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This change adds support for injecting legacy PIC interrupts for
mshv-accelerated x86 guests. This is relevant e.g. for guest that rely on a
PIT in early boot (e.g. ISOLINUX).

The series carries two provisional patches for
feature to work:

- target/i386/mshv: fix vCPU run result contract

  this has been posted earlier as a standalone patch, but it is required here,
  so we might be able to drop it in an upcoming revision if the standalone
  fix is merged earlier.

- accel/mshv: do not coalesce vCPU kicks

  this is a workaround for a race condition that currently exists in the
  upstream mshv driver, which can lead to interruption requests being lost.
  A new CANCEL_VP ioctl is being tested. It will address this issue, so we
  can drop this workaround once it the new ioctl is available upstream.

Magnus Kulke (4):
  target/i386/mshv: fix vCPU run result contract
  accel/mshv: stop VM on vCPU execution errors
  target/i386/mshv: deliver legacy PIC interrupts
  accel/mshv: do not coalesce vCPU kicks

 accel/mshv/mshv-all.c          |  26 ++++-
 hw/i386/x86-cpu.c              |   9 +-
 include/hw/hyperv/hvgdk_mini.h |  42 +++++++-
 include/system/mshv_int.h      |   1 +
 meson.build                    |   1 +
 target/i386/mshv/mshv-cpu.c    | 183 +++++++++++++++++++++++++++++----
 target/i386/mshv/trace-events  |   7 ++
 target/i386/mshv/trace.h       |   2 +
 8 files changed, 240 insertions(+), 31 deletions(-)
 create mode 100644 target/i386/mshv/trace-events
 create mode 100644 target/i386/mshv/trace.h

-- 
2.34.1


