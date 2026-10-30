Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C948606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 21:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dz5wq/oV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMtvn-0007Hi-7p; Fri, 30 Oct 2026 17:14:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xMtvl-0007Gn-Q4
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 17:14:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xMtvj-0007ov-BL
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 17:14:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793394870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mJ5aOiqYwZfZ+Ixp7ZmiK18KAuNWOjaVAGzcWgxzBRQ=;
 b=dz5wq/oVT9XRTGCL2F6GtgDlQBPpaJAtQi/WampsytytA8wDPPqAeY8SMv3OryIz2MuxuL
 X0y85GfoJrQbjw0EXh1aapJfMaJneKhlIemVMljlN2GvCvG4m27CHkxlT+TEWYGlSq6lsq
 h/7x8Q0yF779jo/b4xMFoTTxlN8x1GQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-572-j7NeSZ1XMNauqxBYjRbOwQ-1; Fri,
 30 Oct 2026 17:14:27 -0400
X-MC-Unique: j7NeSZ1XMNauqxBYjRbOwQ-1
X-Mimecast-MFC-AGG-ID: j7NeSZ1XMNauqxBYjRbOwQ_1793394866
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9898E19560B2; Fri, 30 Oct 2026 21:14:26 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C328A1956088; Fri, 30 Oct 2026 21:14:25 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 31 Oct 2026 01:14:07 +0400
Subject: [GIT PULL 04/10] igvm: release found memory region on success
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261031-nohmp-next-v1-4-9a9fb205cf3f@redhat.com>
References: <20261031-nohmp-next-v1-0-9a9fb205cf3f@redhat.com>
In-Reply-To: <20261031-nohmp-next-v1-0-9a9fb205cf3f@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=912;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=wy3+mg2muu/Lx0OEq9fOWkX0Z4Q4kY3p7I5sNfUeOq0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq5QigtoeUCiK2t96t5fMix1j0WUwhuB4DgzpER
 LavYrz8EYmJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCauUIoAAKCRDa6OEJdZac
 5bJGEACzVVyLd9U5StXpjFCiG4OSzPEixu3CSiAaKgB2YtKpeSBj1ZpMGG04aK2PT/ivPTxRJrg
 U11NCMpSowP/Ze1gGuEVjW9cAP7iTo5L6HC4JZzKdENNyrwPCFSDX3ptSfzY/GlwlHSNBbYtyoy
 JFtr5kzb8KJO2AgaAd1lCwvjhBwsv6EKGFTwLtU25jx1ZPiisXYm3+vn0ocZ+4WVpAuvjGJ8/HR
 YsBE06bwi6pOHdqdOXGxuIz7mbhVQ+AJZSRI01/l2uvD2eJwV/KyPWPj3io5ykJ5/xAj3brB7DV
 Sqgi2ZPRquhIY9G1bAyth7R5wNFE0TM8gruA8M9yyTQYd3MYE4zT2LtRrWhTgJyM753+6KBIQJb
 g9DYhruA1WtD01Q7ueUmlrmwVsuc9qUmdgZ/80JsyYqeSRGEWNjoMrGK/c6bz5dBoIGo/uk7tMw
 eSpyYcG2U4P5Yj4W4HJTJHk2fLDEZ5bR+yTxXkuFDhTpBuuZFHgH/6iklpnIP+N78VaB/5MfahM
 zHif7HZmP/4wzi1oYlkSAm0ASs9gdNN9bM0VA7DdJ/I3kvmN2s4Py88DAl4KscmDoFgUrrYgMml
 pG+Z2kkuvkjv35E7d/ORSt32z5kPwSncE8sNL3wOo6IFXV73DZiQ6o8ocr4tVeMKkdLUiyDEok8
 7S2J93qDr8o3E+Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Tested-by: Gerd Hoffmann <kraxel@redhat.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 backends/igvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/backends/igvm.c b/backends/igvm.c
index cf8b762d824c..a9dc19b73997 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -275,9 +275,9 @@ static void *qigvm_prepare_memory(QIgvm *ctx, uint64_t addr, uint64_t size,
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


