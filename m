Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F25F0CD342C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 11:37:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJrc9-0001Ra-DO; Mon, 04 May 2026 07:37:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJrby-0001B9-W4
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:37:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJrbx-00013L-4V
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:37:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777894636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7Zb/FpFPrbLibrxoVP3tYb6acmE/CqanuyqC4h8y5uk=;
 b=TMojME30pCRS7TUG1j/K9ESFYnQajhja7/wCqUWSgcNx1DTazwLhsMfbAhFl6e1DzJWBaj
 l9FfkpdqhokwxiEgmOtFd0QXYbyqrbrxqFFjP5DAw2yhKFOHYjxHrzaNoFMTsBVj9PNm9H
 n5Vi8DrXB1na8SG2wZ21P5q5qg5Z18M=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-458-9ukkhWDoNoOaDgV4odR6-w-1; Mon,
 04 May 2026 07:37:15 -0400
X-MC-Unique: 9ukkhWDoNoOaDgV4odR6-w-1
X-Mimecast-MFC-AGG-ID: 9ukkhWDoNoOaDgV4odR6-w_1777894634
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 616771956076
 for <qemu-devel@nongnu.org>; Mon,  4 May 2026 11:37:14 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1B60C1953952; Mon,  4 May 2026 11:37:12 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 04 May 2026 15:35:09 +0400
Subject: [PATCH v2 21/46] net/filter: free old values in property setters
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260504-qom-tests-v2-21-ef7e3dc94f7a@redhat.com>
References: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
In-Reply-To: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=946;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=0eCsezpNELUdUnbutLXfx310v4EwSLLeUmGSWbqSBBA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp+IRt/N9h3CTfx/HpuRc4Qtd4rIZcx1yEBslKf
 qC1hjwvlpKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafiEbQAKCRDa6OEJdZac
 5TiSD/4uovqyJFwbCy/vqaPcdiHe1MW6zqpbjuzou5mTA3gFLOMxjxA2eZf49Ue2aQarZ1lXRzM
 W6k/heh0pzHbXVvW6+yhjOV6Hj8njQ8e29rRES/Yn3+cVMuQjNMnaaUdlG6tq2QpdWQHZQHcpGr
 zp8GLPG7/cEwyCYawIFyQOVwYefgALMZ5zAXEE2Yoz5IRy8N2AcW9fcGevuzVMxxAF4aFzIPJMY
 ik7w5Agf0y+D4S9jXglgmnJPRzDuJu9Z9Pk7pxnNkHZVEIrHih0GPkR8/4aHpVm9YXd2xy9doJg
 o+rWZBcIeNZoAPx+x4aaxdyFhEGDQLUPMlNgYb4cfbSF76GbzvUY2yoEyN8AHhtRLr+GTZiAAU9
 KA3ANnkWHr2cLQdrloKnAT6xxgqouQ2dnpN4qtfjQTotGGUDGmO2HqEADgZgkqmdH+Wx9u9IB8F
 PQ5NCTfEISJSEtd7afz6VzfZI4jqJ6hWBghkrcDDvlzvvt1GnVwJuIpSWdX86MDm4O7hHl4sn3c
 375eCMuuPp9FkxmGXN6kxsJlLC+Bl8ImVM7kvdCj2u/Jo1zOFS9saZY/bEJyCEofNtPzgBtnzST
 uy/br4S27hu4AevWvmurYk4e0qaZ3y+UnAbTMFQQSDF8nE0jc+IsvKznBdVGKrZ08ltdoLIS6Df
 u+xAqsxAIKA10cQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
2.54.0


