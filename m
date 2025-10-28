Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E84B0CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 13:08:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDjQl-0000Kd-A5; Tue, 28 Oct 2025 09:08:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vDjQW-0000Ii-8F
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 09:07:52 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vDjQS-0000v5-Ir
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 09:07:51 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:7394:0:640:5a8a:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 16BDDC029C;
 Tue, 28 Oct 2025 16:07:41 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:582::1:19])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id d7duxl1L2qM0-XK8TrJkr; Tue, 28 Oct 2025 16:07:40 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761656860;
 bh=DcwQV2ju/59hKGbYQiZxTL5TrgLJXlFfEjQrz++ri7s=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=FN7lJPg36L3nZNJj2GhHVKg0tjT/kuLffoak/KZ/O+e9nSyP5ZQRqd6DesXXtrTI/
 JEDIEBQXNWLV2Uh20wf8od0yTn75JK66e6i5F6YuBeIr74cdpqYL1/QnwFfXR/2Kn9
 Us5wt+3OOLSOHFlTE9cH2FIz9kUu9UI+lAQb0xqo=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com
Cc: stefanb@linux.vnet.ibm.com, farosas@suse.de, qemu-devel@nongnu.org,
 armbru@redhat.com, berrange@redhat.com, vsementsov@yandex-team.ru,
 armenon@redhat.com
Subject: [PATCH v4 0/2] migration: vmsd errp handlers: return bool
Date: Tue, 28 Oct 2025 16:07:36 +0300
Message-ID: <20251028130738.29037-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
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

Hi.

Finally, I understood, that there is no real benefit in converting
these new APIs to bool, as it will break plans of converting all
other handlers to new API.

So, only unrelated fixes are kept in the series, maintainers may
pick them in separate if convenient.

v4:
01: add r-b by Stefan
02: rework to better patch (and fix one more similar issue)

Vladimir Sementsov-Ogievskiy (2):
  migration: vmstate_save_state_v(): fix error path
  tmp_emulator: improve and fix use of errp

 backends/tpm/tpm_emulator.c | 63 +++++++++++++++++++++++--------------
 migration/vmstate.c         |  1 +
 2 files changed, 40 insertions(+), 24 deletions(-)

-- 
2.48.1


