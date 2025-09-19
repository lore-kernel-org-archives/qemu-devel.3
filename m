Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6160ECAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 10:40:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzYVd-0003VX-DX; Fri, 19 Sep 2025 06:38:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uzYVU-0003V5-RC
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 06:38:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uzYVQ-0001Y4-Tt
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 06:38:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758278296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7XjclplzOoT9HlKMaFXi1n+00/uRj1dJyMesNr1dMyY=;
 b=cSmQKP+3jwKN81zf/C7yUVtMWrNBZ50dC8FjZltHW34E8/gq2EPFh0WM4CMuU7ijNTKH2J
 B6oHFi6XrqLentuwsaaXu17IEeZPFv0MYREUabRQItBmi6taI5L/81Mb8APdYbGfaFJSyy
 9oRC/iUraHsG57XbP/HN2U8f5NCmHs0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-10-EJFb2LaWNvaaCExUw3BLeg-1; Fri,
 19 Sep 2025 06:38:14 -0400
X-MC-Unique: EJFb2LaWNvaaCExUw3BLeg-1
X-Mimecast-MFC-AGG-ID: EJFb2LaWNvaaCExUw3BLeg_1758278293
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ACDD919560B2; Fri, 19 Sep 2025 10:38:13 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.187])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B326E30002C5; Fri, 19 Sep 2025 10:38:11 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH] block: remove 'detached-header' option from opts after use
Date: Fri, 19 Sep 2025 11:38:10 +0100
Message-ID: <20250919103810.1513109-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.005,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The code for creating LUKS devices references a 'detached-header'
option in the QemuOpts  data, but does not consume (remove) the
option.

Thus when the code later tries to convert the remaining unused
QemuOpts into a QCryptoBlockCreateOptions struct, an error is
reported by the QAPI code that 'detached-header' is not a valid
field.

This fixes a regression caused by

  commit e818c01ae6e7c54c7019baaf307be59d99ce80b9
  Author: Daniel P. Berrangé <berrange@redhat.com>
  Date:   Mon Feb 19 15:12:59 2024 +0000

    qapi: drop unused QCryptoBlockCreateOptionsLUKS.detached-header

which identified that the QAPI field was unused, but failed to
realize the QemuOpts -> QCryptoBlockCreateOptions conversion
was seeing the left-over 'detached-header' optino which had not
been removed from QemuOpts.

This problem was identified by the 'luks-detached-header' I/O
test, but unfortunate I/O tests are not run regularly for the
LUKS format.

Fixes: e818c01ae6e7c54c7019baaf307be59d99ce80b9
Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 block/crypto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/crypto.c b/block/crypto.c
index d4226cc68a..17b4749a1e 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -792,7 +792,7 @@ block_crypto_co_create_opts_luks(BlockDriver *drv, const char *filename,
     char *buf = NULL;
     int64_t size;
     bool detached_hdr =
-        qemu_opt_get_bool(opts, "detached-header", false);
+        qemu_opt_get_bool_del(opts, "detached-header", false);
     unsigned int cflags = 0;
     int ret;
     Error *local_err = NULL;
-- 
2.50.1


