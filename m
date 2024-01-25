Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6347CC47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 11:58:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSyLT-0003I6-F2; Thu, 25 Jan 2024 06:56:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <davydov-max@yandex-team.ru>)
 id 1rSyLS-0003HK-Mu
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 06:56:34 -0500
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <davydov-max@yandex-team.ru>)
 id 1rSyLP-0004yt-1X
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 06:56:34 -0500
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c29:fcc6:0:640:eb21:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id D9DFB60BE8;
 Thu, 25 Jan 2024 14:56:24 +0300 (MSK)
Received: from davydov-max-nux.yandex-team.ru (unknown
 [2a02:6b8:b081:1220::1:4])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id AuSJvL1IYeA0-Od5fa4m9; Thu, 25 Jan 2024 14:56:24 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1706183784;
 bh=KAQ7bIK/33QGf3xImcTyGRwGSGrbYVHgYfFl9Kfrcqg=;
 h=In-Reply-To:Cc:References:To:Message-Id:Date:Subject:From;
 b=Pc2ORTfGKT+9VwS0A7QQ9Fo9ORX+OVSI5GEMD1Q7kGfvFgKyZPIMnAg2bQHYVvg7C
 yBKl+/30nQIon8/hp2gR9vQerSlE7ordRpFkR29jBVBhFpV0tYiubfZvmeGdmBGdj2
 nY2/7geXnIoiSbsfPRYLNYb5SU0yFbTWppdd7Kyc=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Maksim Davydov <davydov-max@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, jsnow@redhat.com, eblake@redhat.com,
 armbru@redhat.com, pbonzini@redhat.com, berrange@redhat.com, alxndr@bu.edu,
 davydov-max@yandex-team.ru, vsementsov@yandex-team.ru,
 alexander.ivanov@virtuozzo.com, den@virtuozzo.com,
 michael.labiuk@virtuozzo.com
Subject: [PATCH v8 1/4] qom: qom-list-properties: add default value
Date: Thu, 25 Jan 2024 14:56:07 +0300
Message-Id: <20240125115610.23697-2-davydov-max@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240125115610.23697-1-davydov-max@yandex-team.ru>
References: <20240125115610.23697-1-davydov-max@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=davydov-max@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

qmp_qom_list_properties can print default values if they are available
as qmp_device_list_properties does, because both of them use the
ObjectPropertyInfo structure with default_value field. This can be useful
when working with "not device" types (e.g. memory-backend).

Signed-off-by: Maksim Davydov <davydov-max@yandex-team.ru>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 qom/qom-qmp-cmds.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
index 7c087299de..e91a235347 100644
--- a/qom/qom-qmp-cmds.c
+++ b/qom/qom-qmp-cmds.c
@@ -212,6 +212,7 @@ ObjectPropertyInfoList *qmp_qom_list_properties(const char *typename,
         info->name = g_strdup(prop->name);
         info->type = g_strdup(prop->type);
         info->description = g_strdup(prop->description);
+        info->default_value = qobject_ref(prop->defval);
 
         QAPI_LIST_PREPEND(prop_list, info);
     }
-- 
2.34.1


