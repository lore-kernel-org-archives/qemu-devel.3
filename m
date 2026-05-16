Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F6D5CD4F25
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2026 08:01:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wO9wi-0005f6-QB; Sat, 16 May 2026 04:00:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wO9wg-0005d2-Lx
 for qemu-devel@nongnu.org; Sat, 16 May 2026 04:00:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wO9we-0007V6-Ug
 for qemu-devel@nongnu.org; Sat, 16 May 2026 04:00:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778918423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yus4S2SYQUMLq1BDWUFN2FdE2j7nuREFMtVonW6qulI=;
 b=LAl67H8O3WvQvy3YUXyeYfqlRe0uw+We3MeFFlvGt/F/NE4ZizakNV+lkhe+6AZiS761C+
 nk3oPlFaWEjcYtdUc7fdZmA8QvkwXuGaQ30jTTNzjet2yXnmnjyUtfluo/km6Na8INDp75
 lcq1wMWZ9tLBwgmYHArgbnvexx48qwM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-423-4GgyQVPHPuiWYhPMFZaWLA-1; Sat,
 16 May 2026 04:00:22 -0400
X-MC-Unique: 4GgyQVPHPuiWYhPMFZaWLA-1
X-Mimecast-MFC-AGG-ID: 4GgyQVPHPuiWYhPMFZaWLA_1778918421
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 879DF180044D
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 08:00:21 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4A1B11956053; Sat, 16 May 2026 08:00:19 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 16 May 2026 11:59:10 +0400
Subject: [PATCH v3 11/24] system/ioport: minor code simplification
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260516-qom-tests-v3-11-3f20c3a029a7@redhat.com>
References: <20260516-qom-tests-v3-0-3f20c3a029a7@redhat.com>
In-Reply-To: <20260516-qom-tests-v3-0-3f20c3a029a7@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=964;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=2PuZ/fAeys+M9YO5aUenOHdoFB4NeVEhYzeigXek6MU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqCCPP0Jth6b2xjBk2JXtWayEHtuRBcdNJSdyGh
 EQ+JmSXrLeJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaggjzwAKCRDa6OEJdZac
 5VpoEACQK5kb2zosHNXR3d39lOPLUvDxG+8mTpche/WUYWnhzzDES9Cy+r9eJATi4e9FZisQ/X9
 vr+kwwPrCom7J/qF7WIBktbbmm3qJt0bTRSWhWmIiI1yiSpJ3TXY3JqgoyQ9rJIAQx47oqF8OIO
 3Ug908nU4mdN+QTIjcpMena5+/vbacobRWAtcEZBpS+I/xNidvJFCbztCBkenUxDXdaILXFyb9q
 enJ86RRJ45KFj0u9FuimFvdCROre7BsDlA7ebjXTLQ2UzQ/mA4prsX3hbSA41Ab5i5S5FIOpaI4
 vjVsJEj3RC0fzH0t+7tnTLPqxkEAnhBUnroANGq6A4WfowYhhyWD1+D1G4snHZGHxEIH2ara/2Q
 XcIPJsO8XakNgc0vjk9Je0agfU3ap43jqdqJHoX6R0v4E7PGpt60E3AXD+jX0bsOUN32xsA+x9A
 fKPsm0ya2UmerKhaUlrfpTATf+XgeJH1tHQo8/M+3h7T5dEy349Nut+ZUJJxQ26YqvAYihi3ijH
 CLfxp5d+iOnp228gnFpeoWwJrAN6T4/F4VSr8vsBGusCBvB67e9MPhdY6X+oZhecP+aKTrGe0ch
 PPlxV7jbe6MkRqLHE3pKO2B/9y4LQhmxxbW1roKKLslPL6JrN5NlE2WtKcBGtLue/pW3c8JP1dt
 KF4j1LsdWsnvreQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

Drop needless memset() and replace g_malloc0() with g_new().

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 system/ioport.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/system/ioport.c b/system/ioport.c
index 1a0e01fd06b..0a1b80f2994 100644
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


