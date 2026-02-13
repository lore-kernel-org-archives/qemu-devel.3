Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 456BAEF48D8
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 07:12:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqnKR-0002a1-6K; Fri, 13 Feb 2026 02:11:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1vqnKO-0002ZS-Gu
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 02:11:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1vqnKM-0005bM-Td
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 02:11:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770966657;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b20rCQGyrr0CElHyI5DWoeAQC2Icos6G8aSwcR9I31E=;
 b=Rod+xbv3AK2v7DYXfCSa/54OgNLLei4wKSY2pJt2vqBik+3K/HAox9q+s/oL0+BtjPNfRB
 rnRmmrswDhyZEn5qn0OJF819GohY92xMZPRke/gYYimVRkvPM1Fe8iAgWpHA4FQKXWBs1B
 xgeH+jqmU00ogAD2ayxPH5QaojL49Fw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-aqfdaTGSOnS9mUayZnDwYQ-1; Fri,
 13 Feb 2026 02:10:55 -0500
X-MC-Unique: aqfdaTGSOnS9mUayZnDwYQ-1
X-Mimecast-MFC-AGG-ID: aqfdaTGSOnS9mUayZnDwYQ_1770966654
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2A4F81956054; Fri, 13 Feb 2026 07:10:54 +0000 (UTC)
Received: from S2.redhat.com (unknown [10.72.112.33])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DEBE030001B9; Fri, 13 Feb 2026 07:10:50 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com, mst@redhat.com, jasowang@redhat.com, zhangckid@gmail.com,
 lizhijian@fujitsu.com, qemu-devel@nongnu.org
Subject: [RFC 1/5] net/filter: Allow redirector on vhost backends
Date: Fri, 13 Feb 2026 15:08:01 +0800
Message-ID: <20260213071042.3733239-2-lulu@redhat.com>
In-Reply-To: <20260213071042.3733239-1-lulu@redhat.com>
References: <20260213071042.3733239-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Allow filter redirector on vhost backends

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 net/filter.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/filter.c b/net/filter.c
index 76345c1a9d..bbede6b085 100644
--- a/net/filter.c
+++ b/net/filter.c
@@ -255,8 +255,10 @@ static void netfilter_complete(UserCreatable *uc, Error **errp)
     }
 
     if (get_vhost_net(ncs[0])) {
-        error_setg(errp, "Vhost is not supported");
-        return;
+        if (!object_dynamic_cast(OBJECT(uc), "filter-redirector")) {
+            error_setg(errp, "Vhost is not supported");
+            return;
+        }
     }
 
     if (strcmp(nf->position, "head") && strcmp(nf->position, "tail")) {
-- 
2.52.0


