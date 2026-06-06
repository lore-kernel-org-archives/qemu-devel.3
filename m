Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69EDCCD6E75
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2026 05:18:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVjOy-0002cQ-SB; Sat, 06 Jun 2026 01:16:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wVjOr-0002RW-Py
 for qemu-devel@nongnu.org; Sat, 06 Jun 2026 01:16:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wVjOq-0008FQ-Br
 for qemu-devel@nongnu.org; Sat, 06 Jun 2026 01:16:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780723007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dvtgUw0LsKgXWb3LBOponuFZWLxF4j1rwT2ki82oRjQ=;
 b=dZm7xkM7n31Grmk9Iv8zNJa0WafLIiwGOb2GmZIz/MoJPm5GZLHaq26rHhJvjc/D2+FhqD
 b3M5W7GNbnCGiVPHIN//yAQTHsN0OLTD+5b8WMW65cRyV2bvC9B+l77RrwiFXQ4ksdj9sk
 jh4XVllqxW0la42Y4P2nhzxV3HvmE9g=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-6_-xlt9sOTOCsulcscj0_Q-1; Sat,
 06 Jun 2026 01:16:44 -0400
X-MC-Unique: 6_-xlt9sOTOCsulcscj0_Q-1
X-Mimecast-MFC-AGG-ID: 6_-xlt9sOTOCsulcscj0_Q_1780723003
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 87CEF18004A9
 for <qemu-devel@nongnu.org>; Sat,  6 Jun 2026 05:16:43 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 345EC3000210; Sat,  6 Jun 2026 05:16:41 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 06 Jun 2026 09:15:44 +0400
Subject: [GIT PULL v2 12/23] net/filter: free old values in property
 setters
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260606-qom-tests-v2-12-55832d978a9f@redhat.com>
References: <20260606-qom-tests-v2-0-55832d978a9f@redhat.com>
In-Reply-To: <20260606-qom-tests-v2-0-55832d978a9f@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
X-Developer-Signature: v=1; a=openpgp-sha256; l=1002;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=vSCX1oIavb9OdWbiPaCqHhj5OIrYz9DIRgOhx0so1ts=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqI6z0uT0igtgZTVqKuIeibNSbIBaln2vZQb7rz
 aQiPeYHsH2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaiOs9AAKCRDa6OEJdZac
 5YCvEACkenz0GPDMVGfz4m4M1cM5J1t6FEZ2Ki8nkXkH8XR4OJV/mZ98Y3yMrJmCkX9ZEI3QtL7
 nbay1He7CmJHVDb5D0TUIVA9fLmyrvMjbuFrfbqKSF638cho7wpWrS/BurS12ubh6aOoOo2ZZCE
 zksathB/R3TpwL+MLA+xzR206DM6DQL+wrOud9sc3LKuSD5tHt48NrCB/wnbnKVG7f7f6/1Qpqx
 RpqXJeqEM7FAFqK1BTFgThLMHCM8qjipNQQ/5Z15ywUi6ZeLTHrj4a7KfQOWlW0VCfWzsS4UOqV
 z+7jlNY+c6oUvZtNfF5GbkJKALl4wYRF1RWf9AqzYoRiOIuiglFLV5eZ1S1XbsC+DZM5HI6+YG9
 KXFAj9sXJNkiXQ3oYy/KFf0XaBHkxsn6twFVyw4c0xyO50e3ikK86IKPWzlpf8ddWSijWbf1gqW
 dAt9AoLaEFffMcA2XWI95L2uzj/DRYfBpuLFodrCfXs05w8NhL7aIpzRoCeNPLmyQlcGj6p/mjI
 Tp6tJ0XO6dVe1t+0Jpbdg3inFzRH1c0MiozSHcgU0SuJ1f1ahzNujA9/Ag1pggR+ceBRowiEadA
 h6KBzbJiiBTSV61iTLUGowPkmHhFexWiEe3hvbdIJzZlg5++CUDt5F9eCP+Tl+K1p4YgFsXeoB4
 hj2zZC6gbCeE3ng==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
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

netfilter_set_position and netfilter_set_netdev_id overwrote their
respective fields with g_strdup without freeing the previous value,
leaking memory on each property write.

Fixes: fdccce459621 ("init/cleanup of netfilter object")
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 net/filter.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/filter.c b/net/filter.c
index c7cc6615dc9..389f3b0bfef 100644
--- a/net/filter.c
+++ b/net/filter.c
@@ -130,6 +130,7 @@ static void netfilter_set_netdev_id(Object *obj, const char *str, Error **errp)
 {
     NetFilterState *nf = NETFILTER(obj);
 
+    g_free(nf->netdev_id);
     nf->netdev_id = g_strdup(str);
 }
 
@@ -182,6 +183,7 @@ static void netfilter_set_position(Object *obj, const char *str, Error **errp)
 {
     NetFilterState *nf = NETFILTER(obj);
 
+    g_free(nf->position);
     nf->position = g_strdup(str);
 }
 

-- 
2.54.0


