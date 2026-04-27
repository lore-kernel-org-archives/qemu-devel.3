Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5466BFF886D
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 19:44:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHRsa-0002cQ-UZ; Mon, 27 Apr 2026 15:44:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHRrw-0001Uv-TB
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:43:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHRrv-0007uJ-AO
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:43:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777319026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=obrpckS7iH34v1YoqBhaWwTyK91hVQnXne3ur+tLSJo=;
 b=NkDcNg8M6r3pBeha6zuiVdGdFYoYLLHgMcaXFrB1yEt9s9GOYFvccUc+OF3LcjkprS8q5u
 cwIRsYU99Ka+6J62hbaM0td3uyUnyACYx/HlkNtfdAuucvRYJXBhZs2uNvhRHQEpOBIa+2
 bOUHo7UCQ3KSklVcWG7Y3tVPXBo2Vg0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-9-PYToC1IyOp-NuJRWFJdgYA-1; Mon,
 27 Apr 2026 15:43:45 -0400
X-MC-Unique: PYToC1IyOp-NuJRWFJdgYA-1
X-Mimecast-MFC-AGG-ID: PYToC1IyOp-NuJRWFJdgYA_1777319024
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0AF3E19560B7; Mon, 27 Apr 2026 19:43:44 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A746519560AB; Mon, 27 Apr 2026 19:43:42 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Apr 2026 23:42:12 +0400
Subject: [PATCH 13/41] RFC system/ioport: move embedded memory region
 cleanup to portio_list_destroy
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260427-qom-tests-v1-13-c413f3605311@redhat.com>
References: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
In-Reply-To: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Xu <peterx@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1706;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=RVIgJ+CKJPiIQNDTIeDKy6h8zXHge6yaQ/kw2SNexDY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp77wUCbYdI8sm3Wl/Y+5ecL5Qob5gxsyoKCyy5
 3yEyxiGPbmJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCae+8FAAKCRDa6OEJdZac
 5YaCD/oCF7F8ll2wVQMUzZqrg6AW2iVPjgGlqrRMkntM5VLZhJqNZ9DtyFxGtmIw8LYV+srL23b
 D8pbqBPqZu3AY8WerwAoHrFWNkqkeCxZaaBuX4YfcMqFIaJ3/+iIh/ZuV/J6OSs4sUollMrNZPr
 u/CV6h4+yL/ttBtneEMFpSYcBZd+hmk9JBa8VLTZroeoLmJ3bZ3I6nTLbPjn8UUj4hmdDnxvA2n
 yjO0x5hCcyC2k+QyIVjMchTjYMK1SJv1GpFkCR+a8hSHy+SX+xSQUzKG01GwehOlH6437psbHka
 6zWPrTbviuPEK+Ns30O9lTDus8+xG2Xec4MWY5Jck+1E0sRWJ+A96GfyDnEMLLtCM4F/ncO2BS6
 8p7/ksvM9jFEjixp8AMD0DWOCVt9oez6Li9BzqBgIbAiiOthPubdYYg5yHR5T2xPvULeDbsUSWM
 B+f0OSa663ZVlQ+tglnpJW9/K827U8j9xgb4TXG7iiV1yAiUvdVD6N8H1jzPMbhbQJ1cOeZXz0p
 3qlghv7p8HYS5xPDoGqT85gG9FknSM8fH1Ic1px64+gMIt+IOkjPp4FuzeEiSsjtRQXWMqgav5/
 3887DjDbQV0ZndsrE4zE1qNSayW4RSOenABUvCi6KUCuHZ4hcC8rTJdCT64kDZKSJDp2E4Yl/g3
 xlz/3XcOJFv2xPg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

memory_region_portio_list_finalize() unconditionally calls
object_unref() on the embedded MemoryRegion, but when the object was
created via bare object_new() the MemoryRegion was never initialized
and has a refcount of 0, triggering an assertion failure.

The unref in finalize drops the keep-alive reference added during the
reparenting in portio_list_add_1(). Move it to portio_list_destroy()
where the cleanup belongs, and assert the refcount is zero in
finalize.

This is an alternative to "system/ioport: Fix qom-list-properties crash
on portio list obj" patch, hence the RFC.

Fixes: 690705ca0b0f ("softmmu/ioport.c: make MemoryRegionPortioList owner of portio_list MemoryRegions")
Cc: peterx@redhat.com
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 system/ioport.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/system/ioport.c b/system/ioport.c
index 9209bff2eab..aa8f3229804 100644
--- a/system/ioport.c
+++ b/system/ioport.c
@@ -145,6 +145,7 @@ void portio_list_destroy(PortioList *piolist)
     for (i = 0; i < piolist->nr; ++i) {
         mrpio = container_of(piolist->regions[i], MemoryRegionPortioList, mr);
         object_unparent(OBJECT(&mrpio->mr));
+        object_unref(OBJECT(&mrpio->mr));
         object_unref(mrpio);
     }
     g_free(piolist->regions);
@@ -346,7 +347,8 @@ static void memory_region_portio_list_finalize(Object *obj)
 {
     MemoryRegionPortioList *mrpio = MEMORY_REGION_PORTIO_LIST(obj);
 
-    object_unref(&mrpio->mr);
+    /* dropped by portio_list_destroy(), or never initialized */
+    assert(!mrpio->mr.parent_obj.ref);
     g_free(mrpio->ports);
 }
 

-- 
2.53.0


