Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A75DDFF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 11:38:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJrbm-0000mr-Fo; Mon, 04 May 2026 07:37:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJrbR-00009T-GQ
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:36:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJrbP-0000yB-Bm
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:36:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777894602;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5Shw0+M1QV2kNpKWt/rvuQRHoFmA4/rBBLUi/fyiGtw=;
 b=CATyFV/BqeA7KkiEKwuS7LInnvwWpA5Qkb3oOeKQjCDMFHlZOBZzwtfrQXQDMaoSdTIXDI
 reiJBhK5KukMmZ9cC6thfKZFOOT91c7qGvsw6jbDtXvxuL1V4jn+xE+s3OXl9bZN0IF2cG
 yIvfSj9UndkfFbx3KxWzJRWzpGFRKhg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-671-GTH2DcJPPtqah5l4BiCOCw-1; Mon,
 04 May 2026 07:36:41 -0400
X-MC-Unique: GTH2DcJPPtqah5l4BiCOCw-1
X-Mimecast-MFC-AGG-ID: GTH2DcJPPtqah5l4BiCOCw_1777894600
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 52FD8195606C
 for <qemu-devel@nongnu.org>; Mon,  4 May 2026 11:36:40 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 08ABF1800347; Mon,  4 May 2026 11:36:38 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 04 May 2026 15:35:03 +0400
Subject: [PATCH v2 15/46] system/ioport: minor code simplification
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260504-qom-tests-v2-15-ef7e3dc94f7a@redhat.com>
References: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
In-Reply-To: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=964;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=XnNTj9CprNc1j312e9lBdRBLP13rqWwWv5O8h5OKvSE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp+IRsAFJDjTy/ub8Mf5oowt9Xsu7g4+h3BMMGn
 qALpjXG8SKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafiEbAAKCRDa6OEJdZac
 5bKFEACGqzdkUZKxraf5d9GRoEXCExkER58dkolT/gCUmGRHoWutXamKWZAtkf1Npw2Zlq3FO90
 RDTzusYcm4CzZuPISaonzefEZpUMSbHKjMg7nWhIXxu4PBhPdbM/HyO9qAJ6cc3f3sFjV4Il4/x
 YQydjuhfstopfp+Gey75TEHi4qi8sWgu0+FdKCiEtEUk/QEPvWrHDt25Euh857vLX+iLo+7Eeto
 17/2s3JLJxfAr3pAwtVj/b37UQnmYVP1nSYd8A3lXqNzjkkQdV4EjakRzqLsNt3mWz5HzUbkcnu
 E13KABdeiyVWQ8m13Dgic8gua93nFLKUMEBElC+0LD0bGjs5PwuEYx/94ERvUXtrvl0/34Mq5dg
 rGQwAmfz4m/H9dMkyycT9S9cwf8Hfy1StbtJFGT2ih4EW3UzSDer0Sj+JAQINJjUjFRmIbmxn8Y
 FrHIobj5/8LbsBKPPagwEsX/5enjzO53P1gobL63IyYzwPh0XgpoGH0p+3FFMBcDSoTiX5P4wwQ
 mlpYlJKaDb3C6xkMqNTm04eVulmZnNVBkgnXMnzFSqtM7Y+xfXD0k+FAjBpR4PtcPXsWPwAxHzO
 lRJj+XheiiwAqtbJOFwQQwjLywZFKZCZb9TNADkVsytzBIJGtfeOCsL1F+75ezNLYbONKM7d1bI
 m+N2foUNg1bfazQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Drop needless memset() and replace g_malloc0() with g_new().

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 system/ioport.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/system/ioport.c b/system/ioport.c
index 9209bff2eab..303fabf063e 100644
--- a/system/ioport.c
+++ b/system/ioport.c
@@ -230,9 +230,8 @@ static void portio_list_add_1(PortioList *piolist,
     mrpio = MEMORY_REGION_PORTIO_LIST(
                 object_new(TYPE_MEMORY_REGION_PORTIO_LIST));
     mrpio->portio_opaque = piolist->opaque;
-    mrpio->ports = g_malloc0(sizeof(MemoryRegionPortio) * (count + 1));
+    mrpio->ports = g_new0(MemoryRegionPortio, count + 1);
     memcpy(mrpio->ports, pio_init, sizeof(MemoryRegionPortio) * count);
-    memset(mrpio->ports + count, 0, sizeof(MemoryRegionPortio));
 
     /* Adjust the offsets to all be zero-based for the region.  */
     for (i = 0; i < count; ++i) {

-- 
2.54.0


