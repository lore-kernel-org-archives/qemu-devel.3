Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55241CD6E7C
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 15:46:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVWk6-0005yq-A6; Fri, 05 Jun 2026 11:45:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wVWje-0005Ww-IN
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 11:45:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wVWjd-0006KA-4C
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 11:45:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780674323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dZGdjRx4Qw+v9eLFJQiN10KyvdIUABstP/cGPr21HaY=;
 b=hD/qI9waCQCqKI5PwWYSxvw7nrIZqG54aOc+AMF1WJgkZdITKS4tMPR040odJXGO1HsqfI
 Di2YXMZz9cTGjb/ihy+44BtDbTlXbkMa4muFMhEHaaJudbSr8ZuHFWwPHD/Pr9XJV8K14S
 6/ZX/S2wbaM871NA2/SpG2DL1ElSBDc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-152-HUv4bXuEMp-Tfd0nxydjxQ-1; Fri,
 05 Jun 2026 11:45:21 -0400
X-MC-Unique: HUv4bXuEMp-Tfd0nxydjxQ-1
X-Mimecast-MFC-AGG-ID: HUv4bXuEMp-Tfd0nxydjxQ_1780674320
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8DFC41944CC5
 for <qemu-devel@nongnu.org>; Fri,  5 Jun 2026 15:45:20 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A33F41955BC4; Fri,  5 Jun 2026 15:45:19 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 05 Jun 2026 19:44:30 +0400
Subject: [GIT PULL 10/23] system/ioport: minor code simplification
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260605-qom-tests-v1-10-3f184f382c2b@redhat.com>
References: <20260605-qom-tests-v1-0-3f184f382c2b@redhat.com>
In-Reply-To: <20260605-qom-tests-v1-0-3f184f382c2b@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
X-Developer-Signature: v=1; a=openpgp-sha256; l=1020;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=mmxLPf/mf/HIopy5JjPU/FWz41zXebmAxd8a1saOMJU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqIu7VYnlL1gq1N5yKmU9QEzDkJizeCByZMjBOi
 4OdoZGRnv2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaiLu1QAKCRDa6OEJdZac
 5ffHD/0ancSUaEAWp+MP/HSPF0IINzLuHuANkfRNbF7I0xORqeT99Z09tIH3thXRKcCC74SrGVx
 DZPVkyfo019aUurjkV+iKR7dawAgprbVOBMMYLtqxV5umM1qvbTD+DEbP3bSZzdgRsukaDTfBGl
 JMqCB9PTW+bzHTfMgkcJyBmKaasa0ClQ69vcMlc8HQmih22xL+ZnCsYl1pPuIkf2FfMq7HtJji5
 vB+xQ32dlIE4Tybm0bnpPJolwY/AnMJ8R9nEXzonDnsUYCa6CJqt/zdHoJ1IS7WN/LHoWTrg2ux
 IJJtmsThZo15P1g1wVn6RoGVMgAzZoq/D25AIJOyWC8yKuO4e8QC7U6/giy2ueO3NUyLC5fd2O/
 XMmUMvARQMNqvSrz9uLQwewdeEoxTPM1L3Gy3TXl5wzcBnwvHLWtct5Ts5mAEBW70qay2MFO+l0
 CdK9BIs1wiaCHzPg8AkwlN5OYZyktLRarodzBNAvlGjhprvwUskp4ZaI4O3f2yb/u3igCS9GKyk
 J+8LyEy06983/657+hlOrem+/CxseHqBxFyh6fP01L8ETzh2AqMYeg7XhnH6hDz25lVHF9P8s9K
 496pMt5P0IXbBY3+2Dzx9CHYGmn8cS6FTrfW1sZ6VjSe00oRtHLvfDfXYg9czvIpkYO79RZMD0o
 rOQGCJi2C1ofbUQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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


