Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77144F364AD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 17:54:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAtZu-0000iX-U4; Thu, 09 Apr 2026 13:54:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dblanzeanu@linux.microsoft.com>)
 id 1wAtZj-0000RT-2S
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 13:53:58 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dblanzeanu@linux.microsoft.com>) id 1wAtZg-0006Zv-Ne
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 13:53:54 -0400
Received: from laptop.localdomain (unknown [86.121.140.85])
 by linux.microsoft.com (Postfix) with ESMTPSA id E532020B710C;
 Thu,  9 Apr 2026 10:53:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E532020B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1775757228;
 bh=w0Qqe82/wbT+bUcoIpJvTT1fltVMgrdDozzPGcEzmr0=;
 h=From:To:Cc:Subject:Date:From;
 b=guw+nmDHoCsEqZzVgxpMKb8mXK/3dijquS5dQyZGXlF42zK3EdI+73Wo9a4t0n/9D
 ekf02r089Wf6AWBacGIhfOljhMX6YPBuEujZewUSyPlanGfy86OIHwSkFw7+Su1qbc
 87WNr5ySVQ/RA49DLhvewsIcvAy2D1Y7kpUT5NQo=
From: =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Wei Liu <wei.liu@kernel.org>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PATCH 0/1] target/i386/mshv: fix read and write memory across the
 page boundary
Date: Thu,  9 Apr 2026 20:53:33 +0300
Message-ID: <20260409175334.181249-1-dblanzeanu@linux.microsoft.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=dblanzeanu@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_MED=-2.3,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This fixes the guest memory reading and writing spanning multiple pages for mshv Port I/O.

Currently, the read_memory and write_memory functions only translate GVA-to-GPA once per buffer.
In case the buffer is bigger than a page, the translation is only valid for the first page.

Doru Blânzeanu (1):
  target/i386/mshv: fix read/write memory across the page boundary

 target/i386/mshv/mshv-cpu.c | 71 +++++++++++++++++++++++++++----------
 1 file changed, 52 insertions(+), 19 deletions(-)

-- 
2.53.0


