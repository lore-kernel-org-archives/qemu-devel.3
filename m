Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EF0DC5478C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 14:42:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh9WV-0005yV-8t; Mon, 04 Mar 2024 09:42:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <davydov-max@yandex-team.ru>)
 id 1rh9WS-0005xx-MJ
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 09:42:33 -0500
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <davydov-max@yandex-team.ru>)
 id 1rh9WN-0005w8-HJ
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 09:42:31 -0500
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2a:3dc:0:640:1e66:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 0C3F460AB1;
 Mon,  4 Mar 2024 17:42:23 +0300 (MSK)
Received: from davydov-max-nux.yandex-team.ru (unknown
 [2a02:6b8:b081:b709::1:23])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 3gfE183i2Sw0-f0EbGa5Q; Mon, 04 Mar 2024 17:42:22 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1709563342;
 bh=gMWnFgy+jGeh21rdnVz9G6WnrlfoX9Gy9Ijx9mgMBUk=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=iub5wRQBHoDQXBUVypRlhqIcus6IX59JtfF785bjriNABfCucZI0aKjrocTwLnnkx
 JjwoJCJ7OiLzApMwQamrWVFeAnkj7Yh7WHk5FPz5vtpGYnmFuVg5VAm81zBpm49/F1
 BipG9+Mw6b4ABBN49On/+5sVTv4e3dVabtLsturQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Maksim Davydov <davydov-max@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: farosas@suse.de,
	peterx@redhat.com
Subject: [PATCH] migration/ram: add additional check
Date: Mon,  4 Mar 2024 17:42:03 +0300
Message-Id: <20240304144203.158477-1-davydov-max@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=davydov-max@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

If a migration stream is broken, the address and flag reading can return
zero. Thus, an irrelevant flag error will be returned instead of EIO.
It can be fixed by additional check after the reading.

Signed-off-by: Maksim Davydov <davydov-max@yandex-team.ru>
---
 migration/ram.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index 45a00b45ed..95d8b19c3b 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3902,6 +3902,12 @@ static int ram_load_precopy(QEMUFile *f)
         i++;
 
         addr = qemu_get_be64(f);
+        ret = qemu_file_get_error(f);
+        if (ret) {
+            error_report("Getting RAM address failed");
+            break;
+        }
+
         flags = addr & ~TARGET_PAGE_MASK;
         addr &= TARGET_PAGE_MASK;
 
-- 
2.34.1


