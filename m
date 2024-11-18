Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 346ADD43FEE
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 08:39:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCxGm-0001Z5-Sx; Mon, 18 Nov 2024 03:38:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tCxGd-0001Y0-UV
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 03:37:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tCxGc-00045w-F2
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 03:37:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731919073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BFAzC/3A8VNELRadQtvx21DMF/FHqh9bzHESjVSr+tw=;
 b=HLWu/VUyIHlp20pk+e89UAGWWglHPvutouo5BzzgZ/17RDx6whZw1Gbz0II4NHL8xqDqFp
 t8z4QxNVH3VGfiwUUADvGwH9EmF1/AcOfaYM5Q5Wfz9dYf442Vn517Cc9JVvJnWi7C2Pgi
 FEhl05wqEgLjfX3LVM+2P59bPVgSYJA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-465-AWsNTAW4PlyJaXdnTyh_IQ-1; Mon,
 18 Nov 2024 03:37:46 -0500
X-MC-Unique: AWsNTAW4PlyJaXdnTyh_IQ-1
X-Mimecast-MFC-AGG-ID: AWsNTAW4PlyJaXdnTyh_IQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5223D19560B2; Mon, 18 Nov 2024 08:37:45 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.9])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A6E481956054; Mon, 18 Nov 2024 08:37:43 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 2/3] vfio/igd: fix calculation of graphics stolen memory
Date: Mon, 18 Nov 2024 09:37:36 +0100
Message-ID: <20241118083737.174219-3-clg@redhat.com>
In-Reply-To: <20241118083737.174219-1-clg@redhat.com>
References: <20241118083737.174219-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Corvin Köhne <c.koehne@beckhoff.com>

When copying the calculation of the stolen memory size for Intels integrated
graphics device of gen 9 and later from the Linux kernel [1], we missed
subtracting 0xf0 from the graphics mode select value for values above 0xf0.
This leads to QEMU reporting a very large size of the graphics stolen memory
area. That's just a waste of memory. Additionally the guest firmware might be
unable to allocate such a large buffer.

[1] https://github.com/torvalds/linux/blob/7c626ce4bae1ac14f60076d00eafe71af30450ba/arch/x86/kernel/early-quirks.c#L455-L460

Signed-off-by: Corvin Köhne <c.koehne@beckhoff.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Fixes: 871922416683 ("vfio/igd: correctly calculate stolen memory size for gen 9 and later")
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
[ clg: Changed commit subject ]
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/igd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index c5282827ec9112be3c53fbef953abed0bac64298..4047f4f0717f82f48f8e255873f9895a157e210a 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -501,7 +501,7 @@ static int igd_get_stolen_mb(int gen, uint32_t gmch)
         if (gms < 0xf0)
             return gms * 32;
         else
-            return gms * 4 + 4;
+            return (gms - 0xf0) * 4 + 4;
     }
 }
 
-- 
2.47.0


