Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7597BC79F9E
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 15:08:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3xPi-0003pc-Fr; Tue, 08 Sep 2026 11:07:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3xPg-0003pE-RG
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 11:07:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3xPe-0007QS-BX
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 11:07:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788880025;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dIZOSUIBFOeKlAObuoZGWrKTjcRDczF+V5Zcp7j7AHs=;
 b=MCYe+XzIA9zXecBEO7IHuJvvXtAEZLYfj3VYappl2ogFZ6BiqfOqm3yuGx9UYlu8jSivYk
 e9HAJ2T6yXkQuoE/Jfz13Im5vDVk1Cmdwk+bJFYsPcLgUc+E5hDThejFgFlvG0vThh+8iq
 FzVoKqMs7ORTCVyzZ8M5vU4jLIfzxao=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-PYONu3YeMR-lnEFpsx_1eA-1; Tue,
 08 Sep 2026 11:07:03 -0400
X-MC-Unique: PYONu3YeMR-lnEFpsx_1eA-1
X-Mimecast-MFC-AGG-ID: PYONu3YeMR-lnEFpsx_1eA_1788880022
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C5F7F1800644; Tue,  8 Sep 2026 15:07:02 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D8DC530001A2; Tue,  8 Sep 2026 15:07:01 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 08 Sep 2026 19:06:44 +0400
Subject: [GIT PULL 01/15] system/memory: fix "priority" property typename
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260908-qom-qapi-pr-v1-1-a4d75a2573cc@redhat.com>
References: <20260908-qom-qapi-pr-v1-0-a4d75a2573cc@redhat.com>
In-Reply-To: <20260908-qom-qapi-pr-v1-0-a4d75a2573cc@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Xu <peterx@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=969;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=V4M8AN33V0OUntyUyMGpKWtwix8tPy9hXpzCHbwVQtM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqoCSP33ws6NMhZ06QHdhV2yyfG4CZkw8+2O+1m
 PRB+KqgfICJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqAkjwAKCRDa6OEJdZac
 5SF6EACIe7KARxIqsf7QLhRAXtwUQcNZeCX8s1i3ifriUe+DVnn8+4CCXmIuCctr7mGOynvrTgl
 chRkdNo6wtKJsqyDVdY0yN6bUAtN330ueAFKXhixunkXYxeGEqfHvEYcVnZ4pujcDCwI2/pLd2h
 rC8EZUrO/TBUPY5czexcx+wMESMYLqASWs0luJRbKPwUFfcvbpiqp3QXP7A2qqqBRz4OzrhEM8H
 NMuJBbXIzj+ZTNAfBRRRfhigYli8M2hyLfKflAIUuDUpkKg1bApMnLZWtE8vcfPFtQldxcyOfPU
 oVzusF0qbKC71zVgfBN8brrdZvYvNZeIhjztF8QWotNrZr+lU/PBuWrLWKiRe9u8puEwYu6duuH
 rxyp8+8tkFplto8IFE4DKAe3qIMes+1nmzzom+1FsegqcliobacuLsl9/RBJSNNfqBFXY86o8RG
 idKx9Tbidw3n07YPiieVL00T1DjI07vCftgatEp9uLUU+5puxhpUPf38csiNYLGNg/jYAkxfczI
 orU+8qW71ilqcy5+aPqBomivjEG3Abu8BuW/53z5Lemkw8D0zO4rtvV7tT7AXy4wjC2Hy1SWsAN
 z4WW3J9rARY1FOEe7cUThnVkx7ikWGCt8x4iBmV36L3ZhjSB/L1PbFWDf9dvCSZ8pBG3XGkAzt7
 VL7NEk4CZOlqZug==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

The value and the getter are int32.

Fixes: d33382da9ab ("memory: MemoryRegion: Add may-overlap and priority props")
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 system/memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/system/memory.c b/system/memory.c
index 9760721e4550..d4a0a5b81805 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1318,7 +1318,7 @@ static void memory_region_initfn(Object *obj)
 
     object_property_add_uint64_ptr(OBJECT(mr), "addr",
                                    &mr->addr, OBJ_PROP_FLAG_READ);
-    object_property_add(OBJECT(mr), "priority", "uint32",
+    object_property_add(OBJECT(mr), "priority", "int32",
                         memory_region_get_priority,
                         NULL, /* memory_region_set_priority */
                         NULL, NULL);

-- 
2.55.0.543.g5ebe2ebe4ea8


