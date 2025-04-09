Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C031DC36002
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 08:44:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2R1o-0001s2-CB; Wed, 09 Apr 2025 04:43:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1u2R1g-0001qb-7N; Wed, 09 Apr 2025 04:43:17 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1u2R1e-000595-6N; Wed, 09 Apr 2025 04:43:15 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c15:2b89:0:640:9815:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 7DF6860DBD;
 Wed,  9 Apr 2025 11:43:06 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:7304::1:2d])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id XgZSKO0FZa60-GBzMoZKN; Wed, 09 Apr 2025 11:43:05 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1744188185;
 bh=IQZ4g57g5jkeKoSBqyYulQwUkv+2ahQTl2r+MicUGlo=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=hVB09vgEKHF9em0Koui1/U0xgxEoEx79bPYkeBJ7sGI6UtL+ppb+bdPtoNzgnuLQa
 XyX+qgcY7Iixg2aAufw38Leh9WN6tC9CrnbyX7fu9kB9ciAjKEsdysRBlNMU04Yx9J
 BEIgTHm8ry9Ix1ernkn9D2agemx13K/yMl8EdO10=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 devel@lists.libvirt.org, pkrempa@redhat.com, michael.roth@amd.com,
 pbonzini@redhat.com, vsementsov@yandex-team.ru
Subject: [PATCH v3 0/2] deprecate some block-job- APIs
Date: Wed,  9 Apr 2025 11:42:29 +0300
Message-ID: <20250409084232.28201-1-vsementsov@yandex-team.ru>
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
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

This is for 10.1, of course.

v3: fix wording, typos
v2: Update documentation: add patch 01

v1 was:
[PATCH] [for-10.1] qapi/block-core: derpecate some block-job- APIs
Supersedes: <20250401155730.103718-1-vsementsov@yandex-team.ru>

Vladimir Sementsov-Ogievskiy (2):
  qapi: synchronize jobs and block-jobs documentation
  qapi/block-core: deprecate some block-job- APIs

 docs/about/deprecated.rst | 31 +++++++++++++
 qapi/block-core.json      | 91 ++++++++++++++++++++++++++++-----------
 qapi/job.json             | 30 ++++++++++++-
 3 files changed, 125 insertions(+), 27 deletions(-)

-- 
2.48.1


