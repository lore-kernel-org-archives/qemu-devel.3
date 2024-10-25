Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DEC5D1170E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 07:36:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4Erg-000879-C7; Fri, 25 Oct 2024 03:36:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1t4ErX-00086m-Uo
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 03:36:00 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1t4ErV-0005Km-Os
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 03:35:59 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c15:2711:0:640:16b3:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 9C96C60FD0;
 Fri, 25 Oct 2024 10:35:48 +0300 (MSK)
Received: from d-tatianin-lin.yandex.net (unknown
 [2a02:6bf:8011:f00:9e1f:69f6:8772:3b7])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id hZPAuP0IWW20-aO3lFtg2; Fri, 25 Oct 2024 10:35:48 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1729841748;
 bh=xGkL980BATm3PL5NNU/aPgieI30tZF+feqTi0/Jotpk=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=oFJhWtr+vd7fMfJgIQkv7GbJAAiFvq+w3Vqte5j4E9hvSETmU08vGnJa8jiMaNRzt
 /88fYa7curYbKFps2l7OIqnbaQAbpg7A66kOu2DD3N5UV7h8OiEYYs36HfEM8SRoft
 +Liye4eVlCy+AX8/hbQpU7eN/2LQSVeTtidgdd0U=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: Daniil Tatianin <d-tatianin@yandex-team.ru>, devel@lists.libvirt.org,
 Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Corey Minyard <minyard@acm.org>, qemu-devel@nongnu.org
Subject: [PATCH 0/2] finalize 'reconnect' deprecation
Date: Fri, 25 Oct 2024 10:35:23 +0300
Message-Id: <20241025073525.976136-1-d-tatianin@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=d-tatianin@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

We've deprecated the 'reconnect' property in c8e2b6b4d7e, but all the
tests, as well as the stream netdev were still left using it. This
series finalizes the deprecation and replaces all local usage and docs
metions of 'reconnect' with 'reconnect-ms'.

Daniil Tatianin (2):
  net/stream: deprecate 'reconnect' in favor of 'reconnect-ms'
  chardev: finalize 'reconnect' deprecation

 docs/COLO-FT.txt              |  4 +--
 docs/about/deprecated.rst     | 10 ++++++++
 docs/system/ppc/powernv.rst   |  2 +-
 net/stream.c                  | 34 +++++++++++++++++---------
 qapi/net.json                 | 13 +++++++++-
 qemu-options.hx               | 46 +++++++++++++++++------------------
 tests/qtest/ipmi-bt-test.c    |  2 +-
 tests/qtest/netdev-socket.c   |  2 +-
 tests/qtest/vhost-user-test.c |  2 +-
 tests/unit/test-char.c        |  8 +++---
 10 files changed, 77 insertions(+), 46 deletions(-)

-- 
2.34.1


