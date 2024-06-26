Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C485C27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 23:24:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMbyc-0000e6-Cu; Wed, 26 Jun 2024 19:22:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sMbyS-0000bu-Hs
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 19:22:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sMbyQ-0002o3-P0
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 19:22:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719444165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jfQJxByF537maeh28QrLuBFXZ6VbAkdiEnJmU2XF764=;
 b=BUwnoeQBQoNCyuIjlwugWG8QP6LoKEqd46gXJ7ActzhLurDT78yU4HTt/iRdqqO5faQudU
 cv4oPcErhaUq4C/XnYvVdDHomxNnmAWnp8ePz+UO6NyFDqL3tLdCQSGW6ocpzVKpa4foYU
 gH6lUwWqdHLdIyfDl2t8O5Re6GVft4Q=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-484-nD3S8_iuN0uSaecsajQtgg-1; Wed,
 26 Jun 2024 19:22:42 -0400
X-MC-Unique: nD3S8_iuN0uSaecsajQtgg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 41D4519560AA; Wed, 26 Jun 2024 23:22:41 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.16.58])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9E0AE1956087; Wed, 26 Jun 2024 23:22:36 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH 1/4] python: linter changes for pylint 3.x
Date: Wed, 26 Jun 2024 19:22:27 -0400
Message-ID: <20240626232230.408004-2-jsnow@redhat.com>
In-Reply-To: <20240626232230.408004-1-jsnow@redhat.com>
References: <20240626232230.408004-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

New bleeding edge versions, new nits to iron out. This addresses the
'check-python-tox' optional GitLab test, while 'check-python-minreqs'
saw no regressions, since it's frozen on an older version of pylint.

Fixes:
qemu/machine/machine.py:345:52: E0606: Possibly using variable 'sock' before assignment (possibly-used-before-assignment)
qemu/utils/qemu_ga_client.py:168:4: R1711: Useless return at end of function or method (useless-return)

Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/qemu/machine/machine.py      | 1 +
 python/qemu/utils/qemu_ga_client.py | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/python/qemu/machine/machine.py b/python/qemu/machine/machine.py
index f648f6af451..ebb58d5b68c 100644
--- a/python/qemu/machine/machine.py
+++ b/python/qemu/machine/machine.py
@@ -335,6 +335,7 @@ def binary(self) -> str:
 
     def _pre_launch(self) -> None:
         if self._qmp_set:
+            sock = None
             if self._monitor_address is None:
                 self._sock_pair = socket.socketpair()
                 os.set_inheritable(self._sock_pair[0].fileno(), True)
diff --git a/python/qemu/utils/qemu_ga_client.py b/python/qemu/utils/qemu_ga_client.py
index 9a665e6e990..cf0fcf9a8bb 100644
--- a/python/qemu/utils/qemu_ga_client.py
+++ b/python/qemu/utils/qemu_ga_client.py
@@ -174,7 +174,7 @@ def suspend(self, mode: str) -> None:
             # On error exception will raise
         except asyncio.TimeoutError:
             # On success command will timed out
-            return
+            pass
 
     def shutdown(self, mode: str = 'powerdown') -> None:
         if mode not in ['powerdown', 'halt', 'reboot']:
-- 
2.45.0


