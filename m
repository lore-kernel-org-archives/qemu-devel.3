Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683D4606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 11:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FHwpog35
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJrHw-0006xj-Rv; Thu, 22 Oct 2026 07:48:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJrH5-0006jv-8U
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 07:48:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJrH3-0007GA-LQ
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 07:47:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792669676;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YoMIcrTq/DBPfeDgKUE341Lp+LFX1pQ4X5V2MP4UgNk=;
 b=FHwpog35E2w3GRIMdDxqOpP8pdrKDYCMO46HstimNBMD3/6YEZE6Ab0Si9t+aPhJcsqIZo
 1M5hjcsuqbpR/TfCSiLFNf5eHkd8ZXoerIAR1/lfI9Tl0yhkVJp9vUE2QK7cXt5avBeEqv
 rJlel6xtBmvzpHIUW3L1bcPrTiCsr2Q=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-358-tXewS536Nta-Iw1LkmnDnQ-1; Thu,
 22 Oct 2026 11:47:50 +0000
X-MC-Unique: tXewS536Nta-Iw1LkmnDnQ-1
X-Mimecast-MFC-AGG-ID: tXewS536Nta-Iw1LkmnDnQ_1792669668
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 755861800663; Thu, 22 Oct 2026 11:47:48 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3FC971955F06; Thu, 22 Oct 2026 11:47:46 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 22 Oct 2026 15:47:18 +0400
Subject: [PATCH v3 05/10] migration: tolerate NULL ram_block in
 vmstate_unregister_ram()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261022-nohmp-next-v3-5-8b581b590512@redhat.com>
References: <20261022-nohmp-next-v3-0-8b581b590512@redhat.com>
In-Reply-To: <20261022-nohmp-next-v3-0-8b581b590512@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, Gerd Hoffman <kraxel@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Jared Rossi <jrossi@linux.ibm.com>, Zhuoying Cai <zycai@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Jason Herne <jjherne@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>, 
 Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Peter Xu <peterx@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=774;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=uFGhc+fwoSy8ID6dPKZO4z3ptkoUPaaN9gD46SNzoMQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq2ffNdhuF7xTQvP37RPkORCzqnVHb8RuLX+fpl
 19b5u4iuoGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatn3zQAKCRDa6OEJdZac
 5QY/EACdr8BsHltrdysVGOXA+EdXc6Fu1xO1hNU8LBASboH77pkik588iquoQZuBKUxFD5aPRzA
 jVksU9v87kZcQHeSxWlNlSL9MNR7pJz2slUnSz3SOa4vH0bvowidl0hmLYYdF61d56W1pGkO37q
 FnpsWRPefCTXQG1kULVUf2Ad6znX6ErvUxY36PedOjJly5kN5sJCWUrL/qV6WQL9d7EU9KWDzzU
 p5GlrzfCIj52l9v09kTdRduCiN8VKqfYrt2NGncdnVVcpDQXhMSpGpDKkBB1bjyTdElOmni3CId
 8r9dogECu1daPA822Yi56j6Tf+5ksRZsSPxYiFbzupm2zc3ReQXQ7L9uiS/uYsOSC/ZZkCm0kVX
 +Z7K2Sh852KvCM2MnuS11eV/WLn0dxDrDv4CA5DM0aCyd5e8NBmxs5y3Zw0nByftnFqd3aNVIOK
 6TXL+dVwJjkmQfVYXPJ6UO7a2dHlNYXmOV0IeQHZ1IPGwHmfJL9OlIQb1ydHmXCUAMbo3B0WHe3
 YOdhS837XGGKyQobizuoaujKneFj+R9F5pg9661sFJwO/CqrqVwEWgUztyYf+Y2gUI8Ng9aS69R
 Vk+KFn+mEOGx56UC5VTjj3qa1bY2owmzfMRFT9sH8+7MMdQs4ZmoNQtK/DGWpW9bPCFLxnog4be
 U9HUv46di1WGqNw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Treat a missing RAMBlock as nothing to unregister.
qemu_ram_unset_idstr() already accepts a NULL block.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 migration/savevm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/migration/savevm.c b/migration/savevm.c
index 4b590ea672d2..fe94ba96e432 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -3610,6 +3610,9 @@ void vmstate_register_ram(MemoryRegion *mr, DeviceState *dev)
 
 void vmstate_unregister_ram(MemoryRegion *mr, DeviceState *dev)
 {
+    if (!mr->ram_block) {
+        return;
+    }
     qemu_ram_unset_idstr(mr->ram_block);
     qemu_ram_unset_migratable(mr->ram_block);
     ram_block_del_cpr_blocker(mr->ram_block);

-- 
2.56.0.116.g6de20f6092dc


