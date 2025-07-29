Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F174BC83F26
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 11:14:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugiGb-0008Q8-Ur; Tue, 29 Jul 2025 07:13:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ugiG9-0007eG-HD
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 07:12:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ugiG6-0001DT-F5
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 07:12:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753787556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=dt6qkMkh+MC47d4SdeRqjp6FPKdZAsysmAqVxMrrdaE=;
 b=BGPO25lSKl6R1sUkBqBQP8g5174QqsPPkaqvqEFg+P2LiOJe2AJsTGFPOhMIwOoew4Gp71
 J1uSHju3EctW/J458Vo79qf3yqjPNwtJBW3Gyoqbc8F8lio97z5vDI/B857os1TD8y8ihI
 QkeQnAF+MsKU1cJH4S6i4KIilg/I95A=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-674-GzHVl2qGNsKllHguYOxZow-1; Tue,
 29 Jul 2025 07:12:32 -0400
X-MC-Unique: GzHVl2qGNsKllHguYOxZow-1
X-Mimecast-MFC-AGG-ID: GzHVl2qGNsKllHguYOxZow_1753787551
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 99F66180036F; Tue, 29 Jul 2025 11:12:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.14])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 992E119560A2; Tue, 29 Jul 2025 11:12:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DE77B21E6A27; Tue, 29 Jul 2025 13:12:26 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 edgar.iglesias@gmail.com, xen-devel@lists.xenproject.org,
 qemu-trivial@nongnu.org
Subject: [PATCH] hw/display/xenfb: Replace unreachable code by abort()
Date: Tue, 29 Jul 2025 13:12:26 +0200
Message-ID: <20250729111226.3627499-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

xenfb_mouse_event() has a switch statement whose controlling
expression move->axis is an enum InputAxis.  The enum values are
INPUT_AXIS_X and INPUT_AXIS_Y, encoded as 0 and 1.  The switch has a
case for both axes.  In addition, it has an unreachable default label.
This convinces Coverity that move->axis can be greater than 1.  It
duly reports a buffer overrun when it is used to subscript an array
with two elements.

Replace the unreachable code by abort().

Resolves: Coverity CID 1613906
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/display/xenfb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/display/xenfb.c b/hw/display/xenfb.c
index 22822fecea..5e6c691779 100644
--- a/hw/display/xenfb.c
+++ b/hw/display/xenfb.c
@@ -283,8 +283,7 @@ static void xenfb_mouse_event(DeviceState *dev, QemuConsole *src,
                 scale = surface_height(surface) - 1;
                 break;
             default:
-                scale = 0x8000;
-                break;
+                abort();
             }
             xenfb->axis[move->axis] = move->value * scale / 0x7fff;
         }
-- 
2.49.0


