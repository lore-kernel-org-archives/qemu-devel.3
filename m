Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11A91CD8C8C
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2026 05:17:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVjOl-0002HT-6I; Sat, 06 Jun 2026 01:16:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wVjOg-0002Gb-44
 for qemu-devel@nongnu.org; Sat, 06 Jun 2026 01:16:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wVjOe-0008Es-PZ
 for qemu-devel@nongnu.org; Sat, 06 Jun 2026 01:16:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780722996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dZGdjRx4Qw+v9eLFJQiN10KyvdIUABstP/cGPr21HaY=;
 b=PuiQ7DRKnIm0Q/CSX9jrPWbi75P4yBBc78x2jLOm3/H2DIMopRbIBUPtsKpWWlAXe+co6K
 p1AMljoB/XM5taQkznTpErRuhX8krb1cE2xw2BA7fsHLDB/9uz3Xnt/Ek7zVIAiDxz4X6Z
 o7wchQUH8g6eVuv4uvR3oAwPGrWJxLs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-191-lA737s4_OSaD9iI2mRGcPw-1; Sat,
 06 Jun 2026 01:16:34 -0400
X-MC-Unique: lA737s4_OSaD9iI2mRGcPw-1
X-Mimecast-MFC-AGG-ID: lA737s4_OSaD9iI2mRGcPw_1780722993
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7A3FA18003FC
 for <qemu-devel@nongnu.org>; Sat,  6 Jun 2026 05:16:33 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0222B180049F; Sat,  6 Jun 2026 05:16:31 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 06 Jun 2026 09:15:42 +0400
Subject: [GIT PULL v2 10/23] system/ioport: minor code simplification
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260606-qom-tests-v2-10-55832d978a9f@redhat.com>
References: <20260606-qom-tests-v2-0-55832d978a9f@redhat.com>
In-Reply-To: <20260606-qom-tests-v2-0-55832d978a9f@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
X-Developer-Signature: v=1; a=openpgp-sha256; l=1020;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=mmxLPf/mf/HIopy5JjPU/FWz41zXebmAxd8a1saOMJU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqI6z03VaXpE+GI694XMGML00UbEihzGNxAK3d1
 CR1RIflaoWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaiOs9AAKCRDa6OEJdZac
 5dWmEACmxhLbrUoNQkdleZN1BtUxXQ9tfquEJf8oq10qThjbh334CXo4XGzCdqznVhPTfa+iwYk
 1YsyAuCDOFEAdbMnMLXX++6EY8dD5p+x2xvqT//h/gMIne9otYeZmKnhJ6HT8BJfKua4S5zv8H2
 ag1lV3b142LA9gBfz0deEoLsSy5tiOr/lgokC6AGk/nPOqWDsDr2DBKvbBA2IB7gs8ondqwJUrT
 OhBUz+40JuMxOcoUqJOgrrmPYDQDveUycIE2fJ4rKMhpoSEmqLP7bQJp+hR9BDP4UibpqBhXtOD
 Qv2dFrndpMAI371RVcYqAiynvOi8yQpsw4RJpUZGfeMJztJcXL4spJbs17TfGolLggZZ14H2AJe
 HaxUHXyK3aR1DkyIQCl7YW+aiNFEEkJWNAJOR8CXzoMwVN/yOGoL+a+40gif1++1c79WO5Sm3Ae
 7p4eIFMNJxlUgErMu8TyfgotRoNVO+qa91C7CGNX1YkUUhQQ6V/FoKkYZhmtprMKb/vwyxe3qww
 ljM2CV8I+ND7wII1nFNkk0QaJzE8jDzA+LkEdUNZK+dyLNG2lirrwCx0zdyqpJI5vv3xFk20T9C
 jbm736wu1cZ5nDa7NUx3bHMjgNYKBNlGIa/In5QUdCYysVSpt4u7+kyHlAurJx6fG0MEX1g4SCn
 bFDlqJjG5qbeoOg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
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


