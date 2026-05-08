Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2705FCD3447
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 09:56:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLHvx-0007Gn-UK; Fri, 08 May 2026 05:55:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wLHvq-0007FV-Hw
 for qemu-devel@nongnu.org; Fri, 08 May 2026 05:55:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wLHvp-0000dR-4v
 for qemu-devel@nongnu.org; Fri, 08 May 2026 05:55:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778234140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M3FkgRBiYzmZT7k+q8pE8tkNsvK5TREDhYRD6V3EQXU=;
 b=Z7hENdq8CMNE5JeJitRCNVy45b8gmzDOkKIm3bZyFu2R77+CZ+a2LN+E1TCgextBQ1Pcru
 EUAdg92CJP7z2ZQCafRlcSd92EK/C9L/Dzfu0LamUcxpL2HgveWiNh/ZcMtD5ZS0SKX0/h
 wPF/mtzfVwWHcncSFNzq+vbJKwzT7Fw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-139-MQ4ipFVIOOKtYh00Edi1pQ-1; Fri,
 08 May 2026 05:55:36 -0400
X-MC-Unique: MQ4ipFVIOOKtYh00Edi1pQ-1
X-Mimecast-MFC-AGG-ID: MQ4ipFVIOOKtYh00Edi1pQ_1778234135
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4862618002CB; Fri,  8 May 2026 09:55:35 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.50.155])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D2BA61800347; Fri,  8 May 2026 09:55:34 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id C67681800D51; Fri, 08 May 2026 11:55:31 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Katherine Leaver <katherine.j.leaver@gmail.com>
Subject: [PULL 5/6] hw/uefi: verify data size before accessing it in wrap_pkcs7
Date: Fri,  8 May 2026 11:55:30 +0200
Message-ID: <20260508095531.570979-6-kraxel@redhat.com>
In-Reply-To: <20260508095531.570979-1-kraxel@redhat.com>
References: <20260508095531.570979-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
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

Fixes: CVE-2026-41439
Fixes: 3e33af2cb306 ("hw/uefi: add var-service-pkcs7.c")
Reported-by: Katherine Leaver <katherine.j.leaver@gmail.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20260422092910.444997-6-kraxel@redhat.com>
---
 hw/uefi/var-service-pkcs7.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/uefi/var-service-pkcs7.c b/hw/uefi/var-service-pkcs7.c
index 32accf4e44e0..f17ad6872fd2 100644
--- a/hw/uefi/var-service-pkcs7.c
+++ b/hw/uefi/var-service-pkcs7.c
@@ -73,7 +73,8 @@ static void wrap_pkcs7(gnutls_datum_t *pkcs7)
     };
     gnutls_datum_t wrap;
 
-    if (pkcs7->data[4] == 0x06 &&
+    if (pkcs7->size > 16 &&
+        pkcs7->data[4] == 0x06 &&
         pkcs7->data[5] == 0x09 &&
         memcmp(pkcs7->data + 6, signed_data_oid, sizeof(signed_data_oid)) == 0 &&
         pkcs7->data[15] == 0x0a &&
-- 
2.54.0


