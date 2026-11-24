Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B375F606A322
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 04:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kenjo.org header.i=@kenjo.org header.a=rsa-sha256 header.s=mail header.b=OnbFTy2e
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVhvS-0006Tc-Eq; Mon, 23 Nov 2026 23:14:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ken@kenjo.org>)
 id 1xVfeE-0008Lr-6k; Mon, 23 Nov 2026 20:48:42 -0500
Received: from h-155-4-163-233.a498.priv.bahnhof.se ([155.4.163.233]
 helo=mail.kenjo.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ken@kenjo.org>)
 id 1xVfeC-0000SB-Uw; Mon, 23 Nov 2026 20:48:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kenjo.org; 
 s=mail;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:
 To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=YefQLDHicp2ZjQf8OJG+kxbR743ehZnCBzSD+M5Ohy8=; b=OnbFTy2eMi27jfC3JJ0os44lGN
 vsP9NENCRfxb3pgYJBIKjZdXvrU/BqqsNgs/lJrD0SH/u/WJ5rWyCZdW9KHa2kt0zJWhvSm8JFcVU
 IQ8LgYBJ4N7AUlx5b/RVd/rFadFJaRLdwhTKVsmQIruMOwaPnaZmpu67iSeQ+Ic5BEiU=;
Received: from brix.kenjo.org ([172.16.2.16])
 by mail.kenjo.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.98.2)
 (envelope-from <ken@kenjo.org>) id 1xVewr-00000004FUo-36eD;
 Tue, 24 Nov 2026 02:03:53 +0100
From: Kenneth Johansson <ken@kenjo.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Kenneth Johansson <ken@kenjo.org>
Subject: [PATCH 0/2] io-uring missed wakeup.
Date: Tue, 24 Nov 2026 02:03:49 +0100
Message-ID: <20261124010351.3166118-1-ken@kenjo.org>
X-Mailer: git-send-email 2.51.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=155.4.163.233; envelope-from=ken@kenjo.org;
 helo=mail.kenjo.org
X-Spam_score_int: 19
X-Spam_score: 1.9
X-Spam_bar: +
X-Spam_report: (1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, PDS_RDNS_DYNAMIC_FP=0.01,
 RDNS_DYNAMIC=0.982, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 TO_NO_BRKTS_DYNIP=3.026 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 23 Nov 2026 23:14:35 -0500
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
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When running code under qemu-system-arm a timer calibration loop early
in the startup that takes a few milliseconds on hardware took 4-7s and
sometimes over 60 seconds to finish.

This stall did go away if qemu was compiled with --disable-linux-io-uring.
This is an attempt creating a testcase showing the issue and a fix.

Problem looks to be present for about a year. introduced in
commit ded29e64c6f3 ("aio-posix: integrate fdmon into glib event loop")

Kenneth Johansson (2):
  tests/unit/test-aio: aio_notify() after aio_poll() in the glib loop
  fdmon-io_uring: submit re-armed poll sqes after dispatching handlers

 include/qemu/aio.h    | 10 ++++++++++
 tests/unit/test-aio.c | 33 +++++++++++++++++++++++++++++++++
 util/aio-posix.c      |  4 ++++
 util/fdmon-io_uring.c | 15 +++++++++++++++
 4 files changed, 62 insertions(+)

-- 
2.51.0


