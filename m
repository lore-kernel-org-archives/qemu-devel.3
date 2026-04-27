Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFD9BFF8867
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 19:45:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHRsc-0002tm-MM; Mon, 27 Apr 2026 15:44:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHRsN-00025Q-F6
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:44:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHRsL-0007xy-U2
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:44:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777319052;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v2nUewpRlfcuzS7BbkUxVYKnJ4w1wM50RV/7mph3xcA=;
 b=fkx/Zy5WfWK4mZqFUvistrD5+81JpLHxiV/ZjY1qGERcGF2RtYVlN4VlbScYee1PUibSwo
 XhnUIkNgj0UQjzmmHfld809oX96aFTtyI1QtFQNbueYVPA6p9uHADj4vaFQzi2wiV8OBAW
 3IuUTwehxDdOIZI96PvPre4E76duQe4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-e-SwKzz6PNeMLCmtQLU5RQ-1; Mon,
 27 Apr 2026 15:44:09 -0400
X-MC-Unique: e-SwKzz6PNeMLCmtQLU5RQ-1
X-Mimecast-MFC-AGG-ID: e-SwKzz6PNeMLCmtQLU5RQ_1777319048
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8C8D718005AA; Mon, 27 Apr 2026 19:44:08 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 425C319560AB; Mon, 27 Apr 2026 19:44:06 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Apr 2026 23:42:16 +0400
Subject: [PATCH 17/41] hw/core/resetcontainer: free children array on
 finalization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260427-qom-tests-v1-17-c413f3605311@redhat.com>
References: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
In-Reply-To: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=860;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=fxwKGK8u2FdwGWFYQyu8CRzaHlO9/OVt+VeAwfQGL24=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp77wVfJXC1LbJJWXnRmWRMGAyvK8GB4FK7DzjC
 tSzk0nQIJ+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCae+8FQAKCRDa6OEJdZac
 5a5PEAChPy4deRq3TzLpjQ+SVu6xW03+o2sv9DrCGqsRyGVDaxaToqQK1j3o/RtIVwjdmuXTlO+
 Ixu0Osf3e1n/S1zElORKGIQ/hQZDH0kyjwBaWrGcbJOHKEmWzaUMnT8vCQfbMG4HCqsSfad3y8j
 kT1HHkE5I3S9Z7lwZwdW/JJS4QK+p+Pj/QRAOXp+Zpmte4zvztAlIrF3SVReXSrx3A4pxYxNtIG
 F3TQ1INFpvAr2qVStClHuv/iH4hIP9tR0y+BAI97bG7IuUojdBj/5+ydKIWYz1IN5ZWkQjVOgc2
 nzrtNIZmEMHO2H2TGVZ/Ppsi4s/WoMu9MjCLvZUnKzrLFGOrg/Z7r1Vz4ODaNYO/yQVNSrASREm
 SupO9EAIzNNxe42/IsNcSgLfU7WVAhhuRvZC8vdlhZJXKX+gBtM06kkzHM4m/aBjyZlzyVgxl9l
 S+OYg1imbUxB3HgdJRAVASXkxuoq1240m+uzZhyEeWCBiTFw+GqkliJGkFh9yYarBMLv1e72X9m
 ABMcwY2c3t+AEpLfvP12nm6SCahWwtl7ZOE/bY0mvjSZZnlnOyjunvbGo/WoEO2wq7DfhnuYZAb
 vQsDyOgDx2w7Ef9YDsyktaNqf69kYT333M+RTVRP0N407Y3wWWABTGvd328zT4I5Dg8DPfFtomP
 7vNpfUpJrPlOrKg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

resettable_container_init allocates a GPtrArray for children, but
resettable_container_finalize was empty and never freed it.

Fixes: 4c046ce37af0 ("hw/core: Add ResetContainer which holds objects implementing Resettable")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/core/resetcontainer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/core/resetcontainer.c b/hw/core/resetcontainer.c
index ef84aa2374a..a4a6476a036 100644
--- a/hw/core/resetcontainer.c
+++ b/hw/core/resetcontainer.c
@@ -66,6 +66,9 @@ static void resettable_container_init(Object *obj)
 
 static void resettable_container_finalize(Object *obj)
 {
+    ResettableContainer *rc = RESETTABLE_CONTAINER(obj);
+
+    g_ptr_array_unref(rc->children);
 }
 
 static void resettable_container_class_init(ObjectClass *klass,

-- 
2.53.0


