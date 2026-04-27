Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BA94FF8868
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 19:45:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHRsb-0002hO-AH; Mon, 27 Apr 2026 15:44:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHRsR-0002AX-Fw
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:44:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHRsP-0007yS-U5
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:44:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777319057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1vODrsVhyVyPcxPKeorFPGsjKDbcWUqmWEDNJlt/Brc=;
 b=hcbZWHYmED1gMsqADEc0om3Knn97SmDde4IWkEacbDMiN71YMN3/wlNE7oKqDVPHGoxTmZ
 yVVV1Tlk8GOYpybcEVXP/uw50e1f9A9xCjQ6iU8iVLKlzqa73dtF/p8oHoBJUwYON7v6Xj
 qwu2GzqheRbARHSrz9fBoEUNa4C4jHs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-77-0lrkFSldMOeP6j2n0Pkgwg-1; Mon,
 27 Apr 2026 15:44:15 -0400
X-MC-Unique: 0lrkFSldMOeP6j2n0Pkgwg-1
X-Mimecast-MFC-AGG-ID: 0lrkFSldMOeP6j2n0Pkgwg_1777319054
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8C7C61956088
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 19:44:14 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 50EB919560AB; Mon, 27 Apr 2026 19:44:12 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Apr 2026 23:42:17 +0400
Subject: [PATCH 18/41] net/filter: free old values in property setters
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260427-qom-tests-v1-18-c413f3605311@redhat.com>
References: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
In-Reply-To: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Jason Wang <jasowang@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=946;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=t0rAI0UZ5Soh2qRGC318tnu7sO3f1cUnwR6syUG2oKk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp77wVWcppFqMLXn0ij9ZMApbly/sE+yM8IvHiB
 1Y+SFmx3aKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCae+8FQAKCRDa6OEJdZac
 5erRD/0XXT4ZyuEVpGlELeWNS3a9VAe4RYLGrS/nReCzsauJFqFCAY/zAFDqiqwxEOBnDHRfMXd
 3l5K4rb/vPouSNaVku4+mzzGVh3he1dFmwuDpy8alnGe6sFMU5s6st+MrcSs1jvH09VpiZjhprv
 GH8GYOI825ecOIuNG47ytPb/OoUNfpExBGuf4V+H6hTi/BvCJddm/UyVmbLLNNSwsCcoSrZV5x5
 RL+in1mvxIw9vrT7dbN2T3jNhTf4lDRdfhNuFCogQ/x9PXaczDAqDcno6HX0tO8jhLoZaReoDTm
 fAH5zWVMX0wX81Bnzrd3AefW57QxJfN+i9kZNl+U+4ISrYE4UbXNLqS/A0WDFGVQVJ8VzW0rljE
 PK4oC5fiXIvHKZSwTqgXWf2YwjwGI8HpR7jK01CjeIz4SZShJZiWVQFZYHkspHmrHx5f1f3C1xL
 onNKrLzElS8fhZEGxEk3l8stOBXKJWDR264Q1j988ccc+yDl5Rjo5pYPV+p6V6FtOZpHWU5zWY3
 l633tZu1fgZjEZoacz2InpP893ljxOfSFpNf7MvV50jjkV21nNd9DbXic6VYFHrhBaxN4W4D37i
 /TJTKFjH8WlXcDPDTzzBCiKjQbXyt2RYyzbpiydidhdXJO06N5heDAMerlxVpIwJx0nakIwSKqf
 x+dwd+wdp/2H9nQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
2.53.0


