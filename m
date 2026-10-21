Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079EF606A322
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 16:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FM6JtLnq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJZFJ-0007Uy-1X; Wed, 21 Oct 2026 12:32:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1xJZFG-0007TY-I2
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 12:32:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1xJZFC-0006Uv-3R
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 12:32:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792600369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gLTZUdvM7A2N0fyJWg2lNT3PdveXqvyLDgdRIcYomkY=;
 b=FM6JtLnqftmNi2uNGtWBl/ccXZk7r3ViN6kaOHaIAerSki8KcXg4VUYRQfwhEzCD4BMFl/
 whcMPc9OXp2y2DX5NMeh1E28YUB9gCbECCCYP7ukGbfGnW9JxHjD3d2IEzhKr0dEzDDV6G
 tr02HGoSI59L0Nm/sD/rTLjpOqSjMfM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-361-eafSKQN9MK6VQ6x3s3WKaQ-1; Wed,
 21 Oct 2026 16:32:46 +0000
X-MC-Unique: eafSKQN9MK6VQ6x3s3WKaQ-1
X-Mimecast-MFC-AGG-ID: eafSKQN9MK6VQ6x3s3WKaQ_1792600364
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C07FD19560B9; Wed, 21 Oct 2026 16:32:44 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.48.54])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 78A1118005B7; Wed, 21 Oct 2026 16:32:44 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 0885A1827595; Wed, 21 Oct 2026 18:32:40 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Stefano Garzarella <sgarzare@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Martin Pitt <martin@amutable.com>,
 qemu-stable@nongnu.org
Subject: [PULL 07/10] hw/uefi: fix ContentInfo detection in wrap_pkcs7()
Date: Wed, 21 Oct 2026 18:32:35 +0200
Message-ID: <20261021163239.1131460-8-kraxel@redhat.com>
In-Reply-To: <20261021163239.1131460-1-kraxel@redhat.com>
References: <20261021163239.1131460-1-kraxel@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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
X-Spam-Status: No, score=-21.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Martin Pitt <martin@amutable.com>

Fix wrap_pkcs7()'s detection for an already present PKCS ContentInfo
envelope: It previously compared byte 15 with 0x0a (ASN.1
ENUMERATED) instead of 0xa0 (the [0] EXPLICIT context tag of
ContentInfo.content). See the original edk2 function [1] where this was
taken from.

Due to that typo, an already wrapped signature got wrapped a second
time, and gnutls_pkcs7_import() rejected it. This breaks Secure Boot key
enrollment with .auth files carrying the envelope, as created by
systemd's "bootctl --secure-boot-auto-enroll".

[1] https://github.com/tianocore/edk2/blob/8f8372439d8ec5f565dbda1548c18deb068e0080/CryptoPkg/Library/BaseCryptLib/Pk/CryptPkcs7VerifyCommon.c#L68

Fixes: 3e33af2cb306 ("hw/uefi: add var-service-pkcs7.c")
Cc: qemu-stable@nongnu.org
Signed-off-by: Martin Pitt <martin@amutable.com>
Message-ID: <atUllV8bSaHylfKv@piware.de>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/uefi/var-service-pkcs7.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/uefi/var-service-pkcs7.c b/hw/uefi/var-service-pkcs7.c
index 8a1f1395a2fb..a47f36492ff8 100644
--- a/hw/uefi/var-service-pkcs7.c
+++ b/hw/uefi/var-service-pkcs7.c
@@ -80,7 +80,7 @@ static void wrap_pkcs7(gnutls_datum_t *pkcs7)
         pkcs7->data[4] == 0x06 &&
         pkcs7->data[5] == 0x09 &&
         memcmp(pkcs7->data + 6, signed_data_oid, sizeof(signed_data_oid)) == 0 &&
-        pkcs7->data[15] == 0x0a &&
+        pkcs7->data[15] == 0xa0 &&
         pkcs7->data[16] == 0x82) {
         return;
     }
-- 
2.56.0


