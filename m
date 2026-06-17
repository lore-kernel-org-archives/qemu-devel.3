Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCC3BCD98E4
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 10:09:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZnDD-0006nI-DU; Wed, 17 Jun 2026 06:09:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wZnDB-0006lH-NR
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 06:09:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wZnDA-0000Wr-1B
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 06:09:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781690971;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dbx41Y72VzFLQNCt4JmQgUHw7W4y3x2CCAIVw+avYl4=;
 b=TdWJvrP9m4loMd73J38LcVT4K1JnMJqR9ceJPisQZ9yZtdxHrosfb2t6u3Py7hIfc23jQT
 uws/dlinH84g0lEAdOZO+YBqiJnLmiq3iy7DvQQtbgAAgRQQXP2PmJgZAcULSITZORgZY3
 BTaTDSjxMqSy4E0QgQifS+c/dCgvtYY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-533-zsvnjRSJPU2tFY1QHOnzFg-1; Wed,
 17 Jun 2026 06:09:27 -0400
X-MC-Unique: zsvnjRSJPU2tFY1QHOnzFg-1
X-Mimecast-MFC-AGG-ID: zsvnjRSJPU2tFY1QHOnzFg_1781690966
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7BF12180AB37; Wed, 17 Jun 2026 10:09:26 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.48.13])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8D595180049F; Wed, 17 Jun 2026 10:09:25 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id EA7E81801A83; Wed, 17 Jun 2026 12:09:22 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Luigi Leonardi <leonardi@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 2/3] igvm: replace raw uint32_t with igvm library types
Date: Wed, 17 Jun 2026 12:09:21 +0200
Message-ID: <20260617100922.1302000-3-kraxel@redhat.com>
In-Reply-To: <20260617100922.1302000-1-kraxel@redhat.com>
References: <20260617100922.1302000-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Luigi Leonardi <leonardi@redhat.com>

Use IgvmVariableHeaderType and IgvmHeaderSection in QIGVMHandler and
qigvm_handler() instead of plain uint32_t, so that each field's purpose
is clear from its type.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260609-igvm_optional-v2-1-b1f1f08dc40e@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 backends/igvm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/backends/igvm.c b/backends/igvm.c
index 9b889f04287e..3ccbafe9b90c 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -102,8 +102,8 @@ static int qigvm_initialization_guest_policy(QIgvm *ctx,
                                        Error **errp);
 
 struct QIGVMHandler {
-    uint32_t type;
-    uint32_t section;
+    IgvmVariableHeaderType type;
+    IgvmHeaderSection section;
     int (*handler)(QIgvm *ctx, const uint8_t *header_data, Error **errp);
 };
 
@@ -132,7 +132,7 @@ static struct QIGVMHandler handlers[] = {
       qigvm_directive_madt },
 };
 
-static int qigvm_handler(QIgvm *ctx, uint32_t type, Error **errp)
+static int qigvm_handler(QIgvm *ctx, IgvmVariableHeaderType type, Error **errp)
 {
     size_t handler;
     IgvmHandle header_handle;
-- 
2.54.0


