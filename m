Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A14606A31E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 17:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ifN4UBZn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVXPo-0004gX-7C; Mon, 23 Nov 2026 12:01:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xVXPY-0004f9-TS
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 12:01:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xVXPX-0007Vz-6f
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 12:01:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795453258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2g+eMbeEHk21iXkE27GPxRM6KET8yb8h5VfvUgzcLSg=;
 b=ifN4UBZnp47R3l+5C/SbD/mdBJyxUBCiPr0MpV97fuLLHll1rqLuyWWhx5a7++ewG6MErs
 /nNi3bk5ojDKw1LtK2phIOWUzaDnUuBaI+tp8CXa/ewKHKf5sYY0jzH3LiEpbvcw9EDJX/
 3v2WLxkh3H3WvTlnw8mdUPPK3p8hZpA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-397-z9fS_FNqMcCxmHuDp-dbVA-1; Mon,
 23 Nov 2026 17:00:55 +0000
X-MC-Unique: z9fS_FNqMcCxmHuDp-dbVA-1
X-Mimecast-MFC-AGG-ID: z9fS_FNqMcCxmHuDp-dbVA_1795453254
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A2905195D00C
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 17:00:54 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9448118004FC; Mon, 23 Nov 2026 17:00:53 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 1/6] crypto: avoid overwriting Error object erasing keyslot
Date: Mon, 23 Nov 2026 17:00:45 +0000
Message-ID: <20261123170050.4166517-2-berrange@redhat.com>
In-Reply-To: <20261123170050.4166517-1-berrange@redhat.com>
References: <20261123170050.4166517-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/block-luks.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/crypto/block-luks.c b/crypto/block-luks.c
index 0926ad28f0c..c6ac3b2e29b 100644
--- a/crypto/block-luks.c
+++ b/crypto/block-luks.c
@@ -1148,14 +1148,12 @@ qcrypto_block_luks_erase_key(QCryptoBlock *block,
     slot->active = QCRYPTO_BLOCK_LUKS_KEY_SLOT_DISABLED;
 
     ret = qcrypto_block_luks_store_header(block, writefunc,
-                                          opaque, &local_err);
+                                          opaque, errp);
 
-    if (ret < 0) {
-        error_propagate(errp, local_err);
-    }
     /*
-     * Now try to erase the key material, even if the header
-     * update failed
+     * Note: errp may be non-NULL from this point onwards,
+     * as we carry trying to erase key material even in the
+     * face of errors
      */
     for (i = 0; i < QCRYPTO_BLOCK_LUKS_ERASE_ITERATIONS; i++) {
         if (qcrypto_random_bytes(garbagesplitkey,
@@ -1169,6 +1167,7 @@ qcrypto_block_luks_erase_key(QCryptoBlock *block,
             if (i > 0) {
                 return -1;
             }
+            local_err = NULL;
         }
         if (writefunc(block,
                       slot->key_offset_sector * QCRYPTO_BLOCK_LUKS_SECTOR_SIZE,
-- 
2.56.1


