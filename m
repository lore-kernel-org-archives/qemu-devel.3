Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23ED4CCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 16:04:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAsMc-000583-1r; Mon, 20 Oct 2025 12:04:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vAsMX-00054B-47
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 12:03:57 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vAsMT-0007Zv-GL
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 12:03:55 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c10:49f:0:640:b99a:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id AA89A80A0B;
 Mon, 20 Oct 2025 19:03:48 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a51::1:37])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id k3YMa23Nr8c0-SLLqz2aT; Mon, 20 Oct 2025 19:03:48 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760976228;
 bh=hYKc9yrAcV081Z3xfDU4TEAE2MrK6johrTP3i0DPIIU=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=huJI63K/HtntqQsCyqY5XTzs8g5BP+q9eUzWy8RlUL3fqYWVZLKI8qbkWrHnBumHz
 p17Bt9Ndpnhvkdcijq0S9FPcbmjPAImcsIDiglF5MMgus7x3sjVmH+u08XsY8zbTXJ
 W4q+y343bUUYScd5+GveWXZlRzvx4RywcmFdIv2M=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com
Cc: stefanb@linux.vnet.ibm.com, farosas@suse.de, qemu-devel@nongnu.org,
 armbru@redhat.com, berrange@redhat.com,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH v2 1/2] migration: vmstate_save_state_v(): fix error path
Date: Mon, 20 Oct 2025 19:03:43 +0300
Message-ID: <20251020160344.2401137-2-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251020160344.2401137-1-vsementsov@yandex-team.ru>
References: <20251020160344.2401137-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
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

In case of pre_save_errp, on error, we continue processing fields,
unlike case of pre_save, where we return immediately. Behavior
for pre_save_errp case is wrong, we must return here, like for
pre_save.

Fixes: 40de712a89
 "migration: Add error-parameterized function variants in VMSD struct"
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 migration/vmstate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index 81eadde553..fd066f910e 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -443,6 +443,7 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
         if (ret < 0) {
             error_prepend(errp, "pre-save for %s failed, ret: %d: ",
                           vmsd->name, ret);
+            return ret;
         }
     } else if (vmsd->pre_save) {
         ret = vmsd->pre_save(opaque);
-- 
2.48.1


