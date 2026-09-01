Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DD06C61DD3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 08:27:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1JpQ-0003Hg-9s; Tue, 01 Sep 2026 04:26:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1x1JpP-0003HT-06
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 04:26:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1x1JpN-0003LO-HN
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 04:26:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788251205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qcBH9MRu+UyWrEdPkSpzYMK+ELNZvt65WCUQRlcZetQ=;
 b=V3wPuRr9alqVJT9ydtd4vsgjAthmZFAQ2S1jKQH8rZu4ZGvTo1J5yJVDNtYWAaXoo+t97Q
 7a0zvGleoTr1p/NFfe6xBepD6B21yCgoq7Bcc3Fi+7tBuOxSBmjRoLgewcRR+0HVKRe9Nm
 PXvK7SVI+ft1wL4XIGu5091Y28YrrHg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-190-yZNeiHhZNbCgD3UFJL-2sQ-1; Tue,
 01 Sept 2026 04:26:30 -0400
X-MC-Unique: yZNeiHhZNbCgD3UFJL-2sQ-1
X-Mimecast-MFC-AGG-ID: yZNeiHhZNbCgD3UFJL-2sQ_1788251189
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9CC0419560B2; Tue,  1 Sep 2026 08:26:29 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.48.41])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4289418001CF; Tue,  1 Sep 2026 08:26:29 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id A93881808E14; Tue, 01 Sep 2026 10:26:01 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Ani Sinha <anisinha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL 13/13] hw/misc/vmlaunchupdate: do not clear control bits upon
 fw-cfg select op
Date: Tue,  1 Sep 2026 10:25:46 +0200
Message-ID: <20260901082554.804169-14-kraxel@redhat.com>
In-Reply-To: <20260901082554.804169-1-kraxel@redhat.com>
References: <20260901082554.804169-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Ani Sinha <anisinha@redhat.com>

The control bits define the behavior of the interface and clearing the bits
upon reading or select operation will break that behavior. For example, after
CTL_HOST_IGVM is set by the guest through a write and then subsequently, if the
guest tried to read back the values from the fw-cfg interface, the read would
clear CTL_HOST_IGVM. This would break restoring the host IGVM upon subsequent
reset.

Fixes: 30688c02a76e50e4 ("hw/misc/vmlaunchupdate: Introduce hypervisor fw-cfg interface support")
Signed-off-by: Ani Sinha <anisinha@redhat.com>
Message-ID: <20260825124139.6900-1-anisinha@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/misc/vmlaunchupdate.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/misc/vmlaunchupdate.c b/hw/misc/vmlaunchupdate.c
index afa2d278aefc..847d2d963f10 100644
--- a/hw/misc/vmlaunchupdate.c
+++ b/hw/misc/vmlaunchupdate.c
@@ -41,7 +41,6 @@ static bool vmlaunchupdate_supported(void)
 static void init_vm_launch_update(VMLaunchUpdateState *s)
 {
     s->launch_update.capabilities = VM_LAUNCHUPDATE_FORMAT_IGVM;
-    s->launch_update.control = 0;
 
     if (s->disabled) {
         s->launch_update.control |= VM_LAUNCHUPDATE_CTL_DISABLE;
-- 
2.55.0


