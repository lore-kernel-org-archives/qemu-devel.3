Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D375CD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 16:22:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPjg8-00066d-8L; Wed, 20 May 2026 12:21:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wPjfy-0005t0-U6
 for qemu-devel@nongnu.org; Wed, 20 May 2026 12:21:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wPjfu-0008VJ-GU
 for qemu-devel@nongnu.org; Wed, 20 May 2026 12:21:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779294094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G2jImiozVJErYq/ci1rD78+LwSY/Bi8CoEEiY61D/BM=;
 b=V6K1kFU8+69TFVoI0eCuYKQgo2LXx98+3O1OpxcOGNxWJ8KYiSWvQNM0aA02lvFZZcdAK3
 2h7hQHyNkFNjdPZHxx+SAs+HWsT4macZV3t56qMkkhur3+lPUU1fYQPpo2SHWAtuQZa9ln
 Vce5aJiTiz/VjIonIDFxYSBrG0+jFnM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-360-388Ge3HTPZCtIoasIQUFZg-1; Wed,
 20 May 2026 12:21:30 -0400
X-MC-Unique: 388Ge3HTPZCtIoasIQUFZg-1
X-Mimecast-MFC-AGG-ID: 388Ge3HTPZCtIoasIQUFZg_1779294089
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A4F4A18005BB; Wed, 20 May 2026 16:21:28 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.34.136])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DEF4319560A7; Wed, 20 May 2026 16:21:26 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: GuoHan Zhao <zhaoguohan@kylinos.cn>, John Levon <john.levon@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 04/11] vfio-user: reject malformed migration capabilities
Date: Wed, 20 May 2026 18:21:08 +0200
Message-ID: <20260520162115.1613601-5-clg@redhat.com>
In-Reply-To: <20260520162115.1613601-1-clg@redhat.com>
References: <20260520162115.1613601-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
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

From: GuoHan Zhao <zhaoguohan@kylinos.cn>

check_migr() sets an error when the migration capability is not an object,
but still returns true.  This lets version negotiation continue with an
Error set and reports the wrong capability name in the diagnostic.

Return false for the malformed capability, and report the migration
capability name.

Fixes: 36227628d824 ("vfio-user: implement message send infrastructure")
Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
Reviewed-by: John Levon <john.levon@nutanix.com>
Link: https://lore.kernel.org/qemu-devel/20260424031259.289211-1-zhaoguohan@kylinos.cn
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio-user/proxy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
index 314dfd23d8af385532bb87219fb3153961942cba..8b7cc36231ab276493e252064b560dcea13ae749 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -1190,8 +1190,8 @@ static bool check_migr(VFIOUserProxy *proxy, QObject *qobj, Error **errp)
     QDict *qdict = qobject_to(QDict, qobj);
 
     if (qdict == NULL) {
-        error_setg(errp, "malformed %s", VFIO_USER_CAP_MAX_FDS);
-        return true;
+        error_setg(errp, "malformed %s", VFIO_USER_CAP_MIGR);
+        return false;
     }
     return caps_parse(proxy, qdict, caps_migr, errp);
 }
-- 
2.54.0


