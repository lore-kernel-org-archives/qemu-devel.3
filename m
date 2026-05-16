Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A46C3CD4F21
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2026 08:00:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wO9ww-00068j-6S; Sat, 16 May 2026 04:00:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wO9ws-0005xn-2M
 for qemu-devel@nongnu.org; Sat, 16 May 2026 04:00:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wO9wq-0007eE-N9
 for qemu-devel@nongnu.org; Sat, 16 May 2026 04:00:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778918436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7Zb/FpFPrbLibrxoVP3tYb6acmE/CqanuyqC4h8y5uk=;
 b=WvnWBSdCB4YpLdM6FZJzGwtPPNHBFRIpKUAar/mFr0cJL+nKoYJJOubEV8a74Hc4dK4clc
 CIgcw2+ZbdV46c3qpaJW6d3gexwRI/E1i484+pt9AdWaYJsgq0NheJvU8uVn5Sq3efnog5
 x2soQaxRJCbQZraGky9FrgxRjVbWwIg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-1-pFJs5tZoOOuHmtgu4eyEOA-1; Sat,
 16 May 2026 04:00:34 -0400
X-MC-Unique: pFJs5tZoOOuHmtgu4eyEOA-1
X-Mimecast-MFC-AGG-ID: pFJs5tZoOOuHmtgu4eyEOA_1778918433
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4702F180035D
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 08:00:33 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0413030001A2; Sat, 16 May 2026 08:00:31 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 16 May 2026 11:59:12 +0400
Subject: [PATCH v3 13/24] net/filter: free old values in property setters
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260516-qom-tests-v3-13-3f20c3a029a7@redhat.com>
References: <20260516-qom-tests-v3-0-3f20c3a029a7@redhat.com>
In-Reply-To: <20260516-qom-tests-v3-0-3f20c3a029a7@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=946;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=0eCsezpNELUdUnbutLXfx310v4EwSLLeUmGSWbqSBBA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqCCPPeRayCQ/ur6ynVil2TDtgWKFhjbCe+SyIX
 VS/ByV/btCJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaggjzwAKCRDa6OEJdZac
 5V+6EACt4DHIHrVo7ACjK7JnCE35N0KDVgxyEzDcr0hLYX9Qzp9Z3xzKHv1459XRkv2xpCLx4m2
 /BJKiTDnXnG6asMNxlT+lfYjqNgb2XiDUmnvKcZse96DRlDqgj0mdvrZgrgQSn5RQJHrW+7wNCn
 Acd5rBfAJY56abLVux69jbpPDkzFaHgRw/WHrISqi5piePM7GEq6vuc5tePL9YYrWDPGfL6o9KQ
 On+WcKqTK3GsuC836pb5t5tNJ9AsC+OAUsef/uzrpnGoZQnoFmtgiBCervorSA3DeE3FgKbEdCx
 vUzRKWkJ4WN7+IohOCSzCD6UmgSSHdyvFffMneHB5noy04TeqLMExh3en1ZY0ohhu512hwpLcz3
 29OR9Tbo+/+y7rihROAw0O9As0z4ZJ6ibaPauRMLHHLoXaLatxEvzE70CxhQh+F3iLikHGGsSfb
 xnI/ekBbAO2Ge6zjBFnRYkkgneFWDfNhMRwDG1/+I0/25T09iDlFULBTmS7heJbhwgFgBkjK6yS
 Cye34gkGaIW3Z+mYoIIqEEo1PbnJiFyB5c/TisZaTpeYb3Ho9kF+ERcCA9yaFuNMTTJR3Izsl+h
 NanUCrFTy4cy8PLybqG6VhkvsOBb9Xhiw+v/78obmqdL5/rmfAHcPRmOsgAVoXdNFim4Myq7wZB
 +6u3vnIeWVzCGLQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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
2.54.0


