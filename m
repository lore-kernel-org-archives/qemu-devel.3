Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBC99C5478C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 13:53:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh8jv-0006Kd-64; Mon, 04 Mar 2024 08:52:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <davydov-max@yandex-team.ru>)
 id 1rh8jr-0006Jc-5q
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 08:52:19 -0500
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <davydov-max@yandex-team.ru>)
 id 1rh8jk-0002JX-Lz
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 08:52:18 -0500
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c14:750a:0:640:e46:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id EC7D560BFA;
 Mon,  4 Mar 2024 16:52:07 +0300 (MSK)
Received: from davydov-max-nux.yandex-team.ru (unknown
 [2a02:6b8:b081:b709::1:23])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id jpeXWn4Id0U0-FztiD8Pr; Mon, 04 Mar 2024 16:52:07 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1709560327;
 bh=hu8jYt4ZexfRPQMt+iDW2pNu8liod6iwXg6FOJKzodI=;
 h=Cc:Message-Id:References:Date:In-Reply-To:Subject:To:From;
 b=n9liXOzW5C3931zbP9XHhz2BoxcIN7UkFHQifAWIadCJrRrgbyE/yYUBCDqbBN5bL
 xofebhSH24FCjysyAjlxtvIELm/5eFjUuVvJuAMtTdMiQxyvD/EZx3o2g+MkJvQaK8
 TdBNPYy31MaHQA19haYci81BbTVjXOYeIND6ZZ0o=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Maksim Davydov <davydov-max@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: davydov-max@yandex-team.ru, vsementsov@yandex-team.ru,
 peter.maydell@linaro.org, jsnow@redhat.com, philmd@linaro.org,
 armbru@redhat.com
Subject: [PULL 3/4] python/qemu/machine: add method to retrieve
 QEMUMachine::binary field
Date: Mon,  4 Mar 2024 16:51:44 +0300
Message-Id: <20240304135145.154860-4-davydov-max@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240304135145.154860-1-davydov-max@yandex-team.ru>
References: <20240304135145.154860-1-davydov-max@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=davydov-max@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Add a supportive property to access the path to the QEMU binary

Signed-off-by: Maksim Davydov <davydov-max@yandex-team.ru>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 python/qemu/machine/machine.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/python/qemu/machine/machine.py b/python/qemu/machine/machine.py
index 31cb9d617d..f648f6af45 100644
--- a/python/qemu/machine/machine.py
+++ b/python/qemu/machine/machine.py
@@ -328,6 +328,11 @@ def args(self) -> List[str]:
         """Returns the list of arguments given to the QEMU binary."""
         return self._args
 
+    @property
+    def binary(self) -> str:
+        """Returns path to the QEMU binary"""
+        return self._binary
+
     def _pre_launch(self) -> None:
         if self._qmp_set:
             if self._monitor_address is None:
-- 
2.34.1


