Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C085BC28B2F
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 14:35:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsNB4-0000WL-1a; Wed, 12 Mar 2025 10:35:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tsNB1-0000WA-Gn
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 10:35:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tsNAz-0004Gy-Ou
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 10:35:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741790115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=+XF4Buja5Ez75o/C0gSBDedk4To1zxmdlGJIVdZ5YlU=;
 b=MsP7MRn6MQN5BE9kHOkwsZJHCDa+X5mNo0TG+Ecjf09Hot1GKc/t7F3tJjoCJTJLC8Zsn0
 448iVvBLlcnGZfBN1nx9Q7Woh9/KCndtHnDyG6mOcNqc6CBWxd5CjwqENV/bzC41c4yzZ3
 XJGAUSWAnFPkFKahlyRxLm6EGalBMMo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-206-a7M_WNPKM16q_t6k_JhpEQ-1; Wed,
 12 Mar 2025 10:35:10 -0400
X-MC-Unique: a7M_WNPKM16q_t6k_JhpEQ-1
X-Mimecast-MFC-AGG-ID: a7M_WNPKM16q_t6k_JhpEQ_1741790109
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E1BAB180AF66; Wed, 12 Mar 2025 14:35:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3884918001EF; Wed, 12 Mar 2025 14:35:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 57BC621E675F; Wed, 12 Mar 2025 15:35:04 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: gaosong@loongson.cn,
	vladislav.yaroshchuk@jetbrains.com
Subject: [PATCH] error: Strip trailing '\n' from an error string argument
Date: Wed, 12 Mar 2025 15:35:04 +0100
Message-ID: <20250312143504.1659061-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Tracked down with scripts/coccinelle/err-bad-newline.cocci.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 net/vmnet-common.m | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/vmnet-common.m b/net/vmnet-common.m
index 54d900ba67..ab33ce2b0c 100644
--- a/net/vmnet-common.m
+++ b/net/vmnet-common.m
@@ -94,7 +94,7 @@ ssize_t vmnet_receive_common(NetClientState *nc,
 
     if_status = vmnet_write(s->vmnet_if, &packet, &pkt_cnt);
     if (if_status != VMNET_SUCCESS) {
-        error_report("vmnet: write error: %s\n",
+        error_report("vmnet: write error: %s",
                      vmnet_status_map_str(if_status));
         return -1;
     }
-- 
2.48.1


