Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63BB9CCF9F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 14:50:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vETyS-0000gS-EN; Thu, 30 Oct 2025 10:50:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vETyK-0000Yz-VG
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 10:49:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vETy9-0001P5-57
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 10:49:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761835776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zl1F1h/cTdYd+yfEU5oHb4PBW5Tv4gvZzJamHqxtuXg=;
 b=CJ6dMm4uLu6PuB9X4EOrlPBln7m2Z/SKCeqr86sDpaNtho5mGB25Lh12gcDS8ROvZxBxdq
 /JwXXSNPx471nHzezHX46tFMvg/ppTn/pFK1PD4yrW9Aehn3u4G0+NbCYEOOiOiMMMULG5
 ODe7kQqlbcJErK8GUmZCRM/0Nju8m3c=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-22-vpfPoIRzMcW6DnFbIP3XPA-1; Thu,
 30 Oct 2025 10:49:35 -0400
X-MC-Unique: vpfPoIRzMcW6DnFbIP3XPA-1
X-Mimecast-MFC-AGG-ID: vpfPoIRzMcW6DnFbIP3XPA_1761835774
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2FB66180AEBC; Thu, 30 Oct 2025 14:49:34 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.122])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CDA6130001A6; Thu, 30 Oct 2025 14:49:32 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 devel@lists.libvirt.org
Subject: [PATCH 02/21] crypto: add missing free of certs array
Date: Thu, 30 Oct 2025 14:49:08 +0000
Message-ID: <20251030144927.2241109-3-berrange@redhat.com>
In-Reply-To: <20251030144927.2241109-1-berrange@redhat.com>
References: <20251030144927.2241109-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/tlscredsx509.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/crypto/tlscredsx509.c b/crypto/tlscredsx509.c
index 847fd4d9fa..75c70af522 100644
--- a/crypto/tlscredsx509.c
+++ b/crypto/tlscredsx509.c
@@ -550,6 +550,7 @@ qcrypto_tls_creds_x509_sanity_check(QCryptoTLSCredsX509 *creds,
     for (i = 0; i < ncerts; i++) {
         gnutls_x509_crt_deinit(certs[i]);
     }
+    g_free(certs);
     for (i = 0; i < ncacerts; i++) {
         gnutls_x509_crt_deinit(cacerts[i]);
     }
-- 
2.51.1


