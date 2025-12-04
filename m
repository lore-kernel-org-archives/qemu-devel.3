Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE079D2A530
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 20:28:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRFur-0006gx-1u; Thu, 04 Dec 2025 15:27:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vRFuo-0006fb-9x
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 15:27:02 -0500
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vRFum-0003Ep-B6
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 15:27:02 -0500
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:1a8f:0:640:2fa2:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 251B5C0211;
 Thu, 04 Dec 2025 23:26:56 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:83c::1:2e])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id sQswCW0FbOs0-YWblbuZV; Thu, 04 Dec 2025 23:26:55 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1764880015;
 bh=fOczTCyCygGuKRW2vUntmGa4QZ8eLoQ0NdivdZNyoxY=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=nmU4vb/TGZSwQ5OPvSSkHNt5mR1qBIo++uBdS9EDes+HgSwMinp5OE7g/U9f6m8MF
 160dFUX3dVu+i+2tRwbl93I/UmpALkhdPnieOw69y94HMbfvQDH3wVcqPPr2ZUP9jX
 xAQxxwEbU5MSj7tONeP69IewtKKRRKfZqvX+MDTI=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: marcandre.lureau@redhat.com
Cc: pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com,
 berrange@redhat.com, vsementsov@yandex-team.ru, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru, qemu-devel@nongnu.org, philmd@linaro.org
Subject: [PATCH v2 0/3] char: add option to inject timestamps into logfile
Date: Thu,  4 Dec 2025 23:26:45 +0300
Message-ID: <20251204202653.597319-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

Hi all!

The ability to correlate the QEMU log and the guest log can be useful
for investigating problems. So, I suggest an option to inject timestimps
into logfile while writing it.

v2: do not make real_time_iso8601 static inline

Vladimir Sementsov-Ogievskiy (3):
  char: qemu_chr_write_log() use qemu_write_full()
  error-report: make real_time_iso8601() public
  chardev: add logtimestamp option

 chardev/char.c              | 73 +++++++++++++++++++++++++++++--------
 include/chardev/char.h      |  2 +
 include/qemu/error-report.h |  6 +++
 qapi/char.json              |  6 ++-
 util/error-report.c         |  3 +-
 5 files changed, 71 insertions(+), 19 deletions(-)

-- 
2.48.1


