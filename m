Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFB0606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 11:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ihc9Y1J2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJrIW-0007Ww-JD; Thu, 22 Oct 2026 07:49:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJrGz-0006jH-Sr
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 07:47:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJrGx-0007Eo-6e
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 07:47:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792669670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2DO8OeMb+C+EUDoAt5gPWzSeCXRyILLDCf3aXuMCRFo=;
 b=ihc9Y1J2YHIZ5AZAbscqpaJJKNySmk3QZ7ukxvgOgEgDs0DMDwgCZ/v952uapNlxrJwvzA
 Qx2KBTKB+7YIEwM7rKLMGal1FZMnlYYO7F7tW9Aw6izrWB5qDCqzzU6pfESnUqBK2V7EeP
 HmkcF7BTT31TG4/uZ7MsPwCgf9wL53s=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-28-EhNRYIhAOrO-ylTcYOmRGw-1; Thu,
 22 Oct 2026 07:47:47 -0400
X-MC-Unique: EhNRYIhAOrO-ylTcYOmRGw-1
X-Mimecast-MFC-AGG-ID: EhNRYIhAOrO-ylTcYOmRGw_1792669664
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C63401956056; Thu, 22 Oct 2026 11:47:44 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EB9D918002B1; Thu, 22 Oct 2026 11:47:43 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 22 Oct 2026 15:47:17 +0400
Subject: [PATCH v3 04/10] igvm: release found memory region on success
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261022-nohmp-next-v3-4-8b581b590512@redhat.com>
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
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=821;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=wBMEnCG6NX/SrNvdiEREVxq3Y1p2VuUlUjKNL1jFJqw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq2ffN+9DaoIeVmXLAJhJvIfXxeAAXKucqrOiw4
 TVWJOtP+GCJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatn3zQAKCRDa6OEJdZac
 5YFCD/96Ky+DPDGreowAlHMied1tiRZIdHRes2ESPbcQbmhFLGsHGuWDuKSfImzVxjrgnJCvKJd
 QIi4GuduiuWfwk5NyXB6Sd7vXNaE0Vpq535K5CT4uZ2EU1Z2LoRRzz0ltxM+DnPbcjG1IUVJ3jV
 If0Zp7xQGKqW4NXNX354QQ6IzMy5QVJMJ3rk3tYLX5cdgsFRuPrf5biJCSHvKZHtTBFPT7/gqeI
 BQBZVdE2FuKx8186unDr3uFRGvvg26kUnkevtOCQkUgoInQQzAPO7bPVWaVUqC9/CNdsRfueUMs
 g8bc5glbAZNDXLXQqN6S94LmfzRcdShXnV4b1NFo9GRGvLGtqSV9CXMqkrylirISeookFRPHuGj
 cjLSi5nk1k3PF9BPfmRiPV8QNJ4ePuyiai0LvFb9shRBVyAF48/80O0SGMpoqBd8VJRK12ld9dd
 MQkS7gOU+ohab6EtWphX3mHr5DeBbD6kC9CmPwVuA38keB2j1qQmu3GRYbSJekQjRcQgFgWk+Ph
 SSxLH59AWnhJ+bm0sdarnGOTwrpo5fvyb2dsrLvYbzh92mjuy438atka67wAHQBIl7IqC/u6OKI
 CJHEzKschdnfBQyX7P4oGFm2TO+eG+whraeg6DhaAzrs+4kJYasjzAadqDkaV5J4GSMsZL+vF0j
 zhIC84Op+AkIknQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Not only in error paths must the mrs.mr be released.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 backends/igvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/backends/igvm.c b/backends/igvm.c
index 58f3097e8518..7aa76441d0d0 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -268,9 +268,9 @@ static void *qigvm_prepare_memory(QIgvm *ctx, uint64_t addr, uint64_t size,
             return NULL;
         }
 
+        memory_region_unref(mrs.mr);
         gpa_region_size = int128_make64(size);
         if (int128_lt(mrs.size, gpa_region_size)) {
-            memory_region_unref(mrs.mr);
             error_setg(
                 errp,
                 "Processing of IGVM file failed: Could not prepare memory "

-- 
2.56.0.116.g6de20f6092dc


