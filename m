Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BA83C53200
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 09:32:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp0dp-000593-Q9; Wed, 29 Jul 2026 05:31:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wp0dn-00057E-MV
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 05:31:55 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wp0dk-0007kr-QN
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 05:31:55 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (postfix) with ESMTPS id DF5C7C0A60;
 Wed, 29 Jul 2026 12:31:50 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:484::1:24])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id kVacraKWFGk0-rsGCUJt7; Wed, 29 Jul 2026 12:31:50 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1785317510;
 bh=YpjAEe6FHdcRJ7cUU4WELDQ/GHvOIgjYgh73uTALw1E=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=xKdfr1VaqRknF1TamZWK/AUR6gui51XsbV1YuUrs8oik8XANwTH8UBO4n6Xydm1pt
 Da50dMEpoChbkrVaDFyvSQDNxRSMA9+hEwP+Kehy9PYMTOOvQEQW1pRNz4xXx1sYOd
 loliv1xMZ2cNle/UcuMfP2QtUXi1j68vUABIri4o=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com,
	mst@redhat.com
Cc: armbru@redhat.com, peterx@redhat.com, farosas@suse.de,
 raphael.s.norwitz@gmail.com, bchaney@akamai.com, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org, berrange@redhat.com, pbonzini@redhat.com,
 yc-core@yandex-team.ru, mark.caveayland@nutanix.com,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>
Subject: [PATCH 3/5] python/machine.py: store qemu console fd before closing
Date: Wed, 29 Jul 2026 12:31:43 +0300
Message-ID: <20260729093146.1893719-4-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729093146.1893719-1-vsementsov@yandex-team.ru>
References: <20260729093146.1893719-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
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

We'll need it soon to implement test for cpr-exec mode of
tap-fd-migration.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 python/qemu/machine/machine.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/python/qemu/machine/machine.py b/python/qemu/machine/machine.py
index 00154b8591f..14ba8e80aac 100644
--- a/python/qemu/machine/machine.py
+++ b/python/qemu/machine/machine.py
@@ -159,6 +159,7 @@ def __init__(self,
         self._sock_pair: Optional[Tuple[socket.socket, socket.socket]] = None
         self._cons_sock_pair: Optional[
             Tuple[socket.socket, socket.socket]] = None
+        self._cons_sock_saved_fd: Optional[int] = None
         self._temp_dir: Optional[str] = None
         self._base_temp_dir = base_temp_dir
         self._log_dir = log_dir
@@ -388,6 +389,7 @@ def _post_launch(self) -> None:
         if self._sock_pair:
             self._sock_pair[0].close()
         if self._cons_sock_pair:
+            self._cons_sock_saved_fd = self._cons_sock_pair[0].fileno()
             self._cons_sock_pair[0].close()
 
         if self._qmp_connection:
-- 
2.43.0


