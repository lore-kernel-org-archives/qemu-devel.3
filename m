Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EABFCD484E
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 20:24:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMX9y-0007JP-IG; Mon, 11 May 2026 16:23:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wMX9q-00075J-FO
 for qemu-devel@nongnu.org; Mon, 11 May 2026 16:23:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wMX9p-0002OA-1r
 for qemu-devel@nongnu.org; Mon, 11 May 2026 16:23:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778530996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8aba+qFzYsHGkPbwLo4SW8FwkLx2wbf3WzHyH/pckGA=;
 b=iX7Kt4mcsoanSjzHTyV1Mdc9VmJonl6zzt208k7GhxhVLjzmQPr800D9jxJyJnmNSTWjsU
 deCY2sCKIA92HjBFVKYgrzlGnHauoZTJDNRJpd3ckj+kgEv1Lu4Q1m5UARLuwBOyq8mDBL
 dfnnz6oxiDUJc4UNoSA+4haH8J343dI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-92-fIVp7ejzNz2kCj2RyqSC6A-1; Mon,
 11 May 2026 16:23:12 -0400
X-MC-Unique: fIVp7ejzNz2kCj2RyqSC6A-1
X-Mimecast-MFC-AGG-ID: fIVp7ejzNz2kCj2RyqSC6A_1778530991
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 346DC19560A1; Mon, 11 May 2026 20:23:11 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 394E63002D31; Mon, 11 May 2026 20:23:09 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Aditya Gupta <adityag@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 qemu-ppc@nongnu.org (open list:PowerNV Non-Virt...)
Subject: [PULL 21/24] hw/ppc/pnv: drop extra ref on PHB after adding as child
Date: Tue, 12 May 2026 00:21:07 +0400
Message-ID: <20260511202111.3091440-22-marcandre.lureau@redhat.com>
In-Reply-To: <20260511202111.3091440-1-marcandre.lureau@redhat.com>
References: <20260511202111.3091440-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

object_new() returns an object with refcount 1, and
object_property_add_child() adds another reference. The initial
reference must be dropped so the parent becomes the sole owner,
otherwise the PHB objects leak when the chip is destroyed.

Fixes: 0d512c7120a2 ("ppc/pnv: turn chip8->phbs[] into a PnvPHB* array")
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/ppc/pnv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 9ed918fa6a1..8306754d9ad 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1696,6 +1696,7 @@ static void pnv_chip_power8_instance_init(Object *obj)
              */
             object_property_add_child(obj, "phb[*]", phb);
             chip8->phbs[i] = PNV_PHB(phb);
+            object_unref(phb);
         }
     }
 
-- 
2.54.0


