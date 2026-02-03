Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7A65E87845
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 15:59:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnInj-0003K0-Q1; Tue, 03 Feb 2026 10:58:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vnIni-0003Jb-Rt
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:58:50 -0500
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vnInh-0006s6-9C
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:58:50 -0500
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:fa2:0:640:41ee:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 13CBC80853;
 Tue, 03 Feb 2026 18:58:46 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:52d::1:1f])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id iwqMTU0A5Cg0-Vnoilc0G; Tue, 03 Feb 2026 18:58:45 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1770134325;
 bh=ITKLPfEWvif/NBoy2o3GYhZ5/mbQm9knzdHS8q9BIRs=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=ubLGO97nPgYeAjvQU9RPgjaj4AOpwQV6yR7WziuT9/3quc+8nVegjafTunAv4QO/7
 z/5ie4hxH4g0rtOHJTGvsWf1NspoLEhVbGrWjlABoAh62/KzUwAu4LxnSZanyI03i1
 qCQ7aFk9HTFoGlbII6pQj9ZM4CQzzgYQStLzPPI0=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: stefanb@linux.vnet.ibm.com
Cc: qemu-devel@nongnu.org, armbru@redhat.com, peterx@redhat.com,
 vsementsov@yandex-team.ru
Subject: [PATCH v3 0/3] follow-up for tpm_emulator errp story
Date: Tue,  3 Feb 2026 18:58:40 +0300
Message-ID: <20260203155843.79043-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
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

Hi all!

Here are fix and small enhancements, following comments on
already merged "tmp_emulator: improve and fix use of errp"
by Markus.

v3: fix compilation
02: remove forgotten %s from error message
03: remove unused "int ret"

Vladimir Sementsov-Ogievskiy (3):
  tpm_emulator: print error on error-ignore path
  tpm_emulator: drop direct use of errno variable
  tpm_emulator: tpm_emulator_set_state_blobs(): move to boolean return

 backends/tpm/tpm_emulator.c | 59 +++++++++++++++----------------------
 1 file changed, 24 insertions(+), 35 deletions(-)

-- 
2.52.0


