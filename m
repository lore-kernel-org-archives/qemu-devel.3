Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C70606B953
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 11:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ehjhINWI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLIdF-0004uI-Vd; Mon, 26 Oct 2026 07:12:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xLIdC-0004tl-Ta
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 07:12:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xLIdB-00081h-5y
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 07:12:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793013163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UtXIYy9AbDnrn2vQQJFkgsku1eLEBJoW63gHam0njOc=;
 b=ehjhINWI31ouwog9mfxyz2J4AsIYcN4IO3/9+mR3OWjrejpLgEUTsmkOH7s+J8OvZzrx0P
 f1CQT9bjNBHtCr+5zO6OKwmXcAS2KGNhwPSr564ZLSx6z/fnrPkvF7q8K+RN+cR9W1W8aB
 mJsZgWRNjOld3DzY2fj22cfNBuA8ozQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-354-f2kQnQ4ZMdW-MHBJDoPOzw-1; Mon,
 26 Oct 2026 07:12:42 -0400
X-MC-Unique: f2kQnQ4ZMdW-MHBJDoPOzw-1
X-Mimecast-MFC-AGG-ID: f2kQnQ4ZMdW-MHBJDoPOzw_1793013161
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 673B61800595
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 11:12:41 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 466DA30000E3; Mon, 26 Oct 2026 11:12:40 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 1/2] crypto: avoid overwriting Error object erasing keyslot
Date: Mon, 26 Oct 2026 11:12:36 +0000
Message-ID: <20261026111237.660633-2-berrange@redhat.com>
In-Reply-To: <20261026111237.660633-1-berrange@redhat.com>
References: <20261026111237.660633-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When erasing a keyslot we deliberately ignore some errors and
carry on trying to erase as much as possible. This results in
overwriting Error objects and triggering an assertion. Don't
pass in the &local_err, if errp is already set.

Fixes: https://gitlab.com/qemu-project/qemu/-/work_items/4697
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/block-luks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/crypto/block-luks.c b/crypto/block-luks.c
index 0926ad28f0c..277a5110607 100644
--- a/crypto/block-luks.c
+++ b/crypto/block-luks.c
@@ -1152,6 +1152,7 @@ qcrypto_block_luks_erase_key(QCryptoBlock *block,
 
     if (ret < 0) {
         error_propagate(errp, local_err);
+        local_err = NULL;
     }
     /*
      * Now try to erase the key material, even if the header
@@ -1169,6 +1170,7 @@ qcrypto_block_luks_erase_key(QCryptoBlock *block,
             if (i > 0) {
                 return -1;
             }
+            local_err = NULL;
         }
         if (writefunc(block,
                       slot->key_offset_sector * QCRYPTO_BLOCK_LUKS_SECTOR_SIZE,
-- 
2.56.0


