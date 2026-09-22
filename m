Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABABAC982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:21:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x96yP-0005E7-73; Tue, 22 Sep 2026 16:20:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x96y5-0004Z7-Dt
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:19:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x96y1-00085p-2m
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:19:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yARMUEhkTm0zm/EPFmK122huIjj8b+N7QlWf0oDLLas=;
 b=GOGzr0dmBuVz9VeY+Gwks5DCKKZLmBRwlPPqovbQhFFhqhU16ymqvDPg6pJdsjW+s+86YE
 0ogvvLQ1R4i77rU+uA8ELk3GbCHy2ObJ0fm1W+h5JsTLH9V6BiYHT2JV+23YhVT1Y6pcxq
 UE6aLnwqwdLfhAAiZ0Dzu0k5T0gv4XY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-12-zF9PnEVvNnSef7abJPyjzQ-1; Tue,
 22 Sep 2026 16:19:50 -0400
X-MC-Unique: zF9PnEVvNnSef7abJPyjzQ-1
X-Mimecast-MFC-AGG-ID: zF9PnEVvNnSef7abJPyjzQ_1790108389
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 150131956069; Tue, 22 Sep 2026 20:19:49 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1553141B; Tue, 22 Sep 2026 20:19:47 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:17:18 +0400
Subject: [PATCH 11/88] tests/qemu-iotests: filter all generated node ids
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-11-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=602;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=4bUuyWgCp4E6JwbHdJqjJiq4iDjRvflm3JhsS+TJ7Go=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqsuKuHHVlZyQDX+DrMiA30TDioxz9yUznNAx6H
 8gNc01onyCJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarLirgAKCRDa6OEJdZac
 5fn3D/46cXLUK6hQ88vfSGjq4DiWu7P5kB9TaALFFAQAMgCjKbRLqNv+nPBbe9M2xQk8++N1QP1
 lCpudCAF44lGJGZhECDofQbnT36AeIZDqhdBtugnrG47A62qpWl4mu6o0k16ziaFCKh1T52XoWm
 wIV1QLo6anxIksVZTXVqaxYZWdBVTD+ZMWPTo8sYVZ2EJynZS5lp8bdKAC5921j2NS2f9dJ2nEH
 Yyx1xfQgjNGzGS4Eee86YgC6mQgISQJ9K6ueWZYUS/WnPg7Luxgxp9Yve28UiyXlT86dw5uoF9f
 xRmiAaJADFVNm8YHa5yONYlPilCkpNDao85TaZAscm8gsaeG1bES1BYjOxW3eJ9kUBuPQR7hTXa
 iY1inhVkCMcOdxM/q9UK0DwNny1vc2AQUK7X/GzpGXLmpIMrFIrnQFN5XTnjiWwM8MogIHOtS5i
 Wusl+0r3tS+Vt3fKNBmV7iOYmQh1wkzpKARTls9qMR83bfXnVlDaGfIJZuYNLRxdZVVtv2iFrwE
 e+thgW/WZvcNMVHcjMehMnRBEY0rC8rLU5u5NDJ7wE7TlDh+hyV6P+B+7PlFLmbbPeHlpmkKY1f
 6dkisDB2x0vXfdL+rIV4hNriYI42/5qEcyS8NuiUJDpSBBQenqk0csxz96VepTFIqMQEk7nHyG8
 jxpQGVzTuNdk/og==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qemu-iotests/common.filter | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/common.filter
index ce4213cb974a..f6d94f993691 100644
--- a/tests/qemu-iotests/common.filter
+++ b/tests/qemu-iotests/common.filter
@@ -32,7 +32,7 @@ _filter_vmstate_size()
 
 _filter_generated_node_ids()
 {
-    sed -Ee 's/\#block[0-9]{3,}/NODE_NAME/'
+    sed -Ee 's/\#block[0-9]{3,}/NODE_NAME/g'
 }
 
 _filter_qom_path()

-- 
2.56.0.rc0.29.g47ce80527c56


