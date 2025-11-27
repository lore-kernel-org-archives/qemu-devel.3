Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2D64CFD2F6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 17:35:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOfsg-0004TP-Ek; Thu, 27 Nov 2025 12:34:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vOfsb-0004Rp-UK
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 12:34:05 -0500
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vOfsW-0001Fp-Vd
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 12:34:04 -0500
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:fa2:0:640:41ee:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 04A1680C40;
 Thu, 27 Nov 2025 20:33:55 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:834::1:7])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id rXiJgL0F7Os0-9emaeKjH; Thu, 27 Nov 2025 20:33:54 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1764264834;
 bh=tFRKw0vBWvv++xCEOYc1TZr0psCfpx6qx1pEqp6qrIM=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=HLtrr9B7NtFnqM2zfMGqBDi8RbTfTU3xyMRomcudxubmfliiMOXyKv0IjRSsqcKtf
 xpNr79A2qxd07cl15Nt6hd1Dj/FdssuRocHOOL8lvkuGv0dGTPxRBf5AlFYGFGveJm
 54P1guvgDYRd/Yez9l1ERi6cHaVeTDTbOXnUWk2s=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: dave@treblig.org,
	armbru@redhat.com
Cc: pbonzini@redhat.com, marcandre.lureau@redhat.com, qemu-devel@nongnu.org,
 vsementsov@yandex-team.ru
Subject: [PATCH for-11.0 0/5] some improvements around error reporting
Date: Thu, 27 Nov 2025 20:33:47 +0300
Message-ID: <20251127173352.283731-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi all. The main thing I wanted to do is to enable timestamps
for errer_report() and friends when QMP monitor is active.
Analyzing logs without timestamps is painful.

And some enhancements here and there around.

Vladimir Sementsov-Ogievskiy (5):
  ui/vnc: don't use of error_printf_unless_qmp()
  monitor: remove unused error_printf_unless_qmp() function
  monitor: rework monitor_cur_is_qmp() into monitor_cur_is_hmp()
  error: print error_report timestamp when QMP monitor is active
  error-report: fix doc for vreport()

 include/monitor/monitor.h      |  5 +----
 monitor/monitor.c              | 30 +++---------------------------
 stubs/error-printf.c           |  5 -----
 stubs/monitor-core.c           |  5 +++++
 tests/unit/test-util-sockets.c |  1 +
 ui/vnc.c                       |  9 ++++-----
 util/error-report.c            | 25 +++++++++++++++----------
 7 files changed, 29 insertions(+), 51 deletions(-)

-- 
2.48.1


