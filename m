Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A352FC30659
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 11:02:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMQPV-0007KK-6C; Wed, 26 Jun 2024 07:01:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sMQPS-0007IC-3j; Wed, 26 Jun 2024 07:01:54 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sMQPO-0003UL-5y; Wed, 26 Jun 2024 07:01:53 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:1c20:0:640:f632:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id D82FF608F3;
 Wed, 26 Jun 2024 14:01:46 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:b645::1:29])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id P1OLrj0IhSw0-fGfY6Lgs; Wed, 26 Jun 2024 14:01:46 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1719399706;
 bh=LcubyWEWFy2+UuOK//gtYKqylWSkxYKpq14G/wxjwKU=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=pDKhIkhxAPwcFDSiJakJmU1TgQLCXK2H4E/S4FLnm5FZPMHlmjw4tZJCos8x+adA9
 63wXpwllBKG+14NGW4RFJWiT5e2duQwN/m3EUvC0+RexiYbu4KCsdtIQ1jNT++nS61
 2RnO6AjltRzxPjoAm1XchhVNezV2y2BGAdHeSC24=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 devel@lists.libvirt.org, hreitz@redhat.com, kwolf@redhat.com,
 vsementsov@yandex-team.ru, jsnow@redhat.com, pkrempa@redhat.com,
 f.ebner@proxmox.com
Subject: [PATCH v2 6/7] qapi/block-core: derpecate block-job-change
Date: Wed, 26 Jun 2024 14:01:23 +0300
Message-Id: <20240626110124.374336-7-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240626110124.374336-1-vsementsov@yandex-team.ru>
References: <20240626110124.374336-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

That's a first step to move on newer job-* APIs.

The difference between block-job-change and job-change is in
find_block_job_locked() vs find_job_locked() functions. What's
different?

1. find_block_job_locked() do check, is found job a block-job. This OK
   when moving to more generic API, no needs to document this change.

2. find_block_job_locked() reports DeviceNotActive on failure, when
   find_job_locked() reports GenericError. Still, for block-job-change
   errors are not documented at all, so be silent in deprecated.txt as
   well.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 docs/about/deprecated.rst | 5 +++++
 qapi/block-core.json      | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index ff3da68208..0ddced0781 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -134,6 +134,11 @@ options are removed in favor of using explicit ``blockdev-create`` and
 ``blockdev-add`` calls. See :doc:`/interop/live-block-operations` for
 details.
 
+``block-job-change`` (since 9.1)
+''''''''''''''''''''''''''''''''
+
+Use ``job-change`` instead.
+
 Incorrectly typed ``device_add`` arguments (since 6.2)
 ''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 9087ce300c..064cad0b64 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3099,9 +3099,15 @@
 #
 # Change the block job's options.
 #
+# Features:
+#
+# @deprecated: This command is deprecated.  Use @job-change
+#     instead.
+#
 # Since: 8.2
 ##
 { 'command': 'block-job-change',
+  'features': ['deprecated'],
   'data': 'JobChangeOptions', 'boxed': true }
 
 ##
-- 
2.34.1


