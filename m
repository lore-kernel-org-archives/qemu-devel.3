Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07ADA606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 12:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZGMabR5Y
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWug3-00028f-P0; Fri, 27 Nov 2026 07:03:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1xWufr-00025G-JS
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 07:03:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1xWufp-0001lK-Lh
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 07:03:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795781008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6+1iGFRmZ06OygTEoyoxzguFgaj4epqCzWKEod0oT+8=;
 b=ZGMabR5YWxlCqWNmkEJlwmxuSQT4n6h0EBceIeWoBcrmaH9KU8aUBSOW8TZX0cuLB9RDgD
 fpaYNYv6b4dkbkJYXZaxi0Eip1PzDOYck2yMTwKEOiLAnxkJjLoMMix52BEwhV4dHsK0Xf
 Nf7mIg4YPwkwrBGXfB3NbbYMsHMmMdE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-EOA9aVPDMX6mHcduCIaJzg-1; Fri,
 27 Nov 2026 12:03:24 +0000
X-MC-Unique: EOA9aVPDMX6mHcduCIaJzg-1
X-Mimecast-MFC-AGG-ID: EOA9aVPDMX6mHcduCIaJzg_1795781003
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ED6B81955F07; Fri, 27 Nov 2026 12:03:22 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.48.13])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F027C34E; Fri, 27 Nov 2026 12:03:21 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id C52241800395; Fri, 27 Nov 2026 10:37:41 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
	Martin Pitt <martin@amutable.com>
Subject: [PULL 1/1] hw/uefi: accept a PK enrolled in setup mode
Date: Fri, 27 Nov 2026 10:37:41 +0100
Message-ID: <20261127093741.736618-2-kraxel@redhat.com>
In-Reply-To: <20261127093741.736618-1-kraxel@redhat.com>
References: <20261127093741.736618-1-kraxel@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
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

From: Martin Pitt <martin@amutable.com>

uefi_vars_check_auth_2_sb() returns an efi_status. Commit cc3cf42e618a
changed it to return "true" for the "no self-signed PK is required" code
path. That value 1 is interpreted as EFI_WARN_UNKNOWN_GLYPH, so
uefi_vars_mm_set_variable() rejects the write, and the guest can never
enroll its own PK. Return the correct code to fix this.

Since commit a1b96fcde870 ("hw/uefi: improve default config security")
a self-signed PK is not required by default. This bug can be worked
around by forcing the still working old code path:

  -global uefi-vars-sysbus.require-self-signed-pk=on

Fixes: cc3cf42e618a ("hw/uefi: add require-self-signed-pk config option")
Signed-off-by: Martin Pitt <martin@amutable.com>
Message-ID: <awkUHTIhRM_DHrTR@piware.de>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/uefi/var-service-auth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/uefi/var-service-auth.c b/hw/uefi/var-service-auth.c
index 21fc50f904d5..744c2cc19359 100644
--- a/hw/uefi/var-service-auth.c
+++ b/hw/uefi/var-service-auth.c
@@ -214,7 +214,7 @@ static efi_status uefi_vars_check_auth_2_sb(uefi_vars_state *uv,
             };
             return uefi_vars_check_pkcs7_2(&tmp, NULL, NULL, va, data);
         } else {
-            return true;
+            return EFI_SUCCESS;
         }
     }
 
-- 
2.56.1


