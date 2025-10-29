Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D503CCF9EE
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 12:08:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE4xV-0003F0-SN; Wed, 29 Oct 2025 08:07:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vE4xG-00036P-Fw
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 08:07:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vE4wz-0004vz-31
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 08:06:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761739605;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KKITr5gA2FHzlfnuTzxnhBOq+A020dUORWKLOiqpqQ4=;
 b=Oib+zh7+Qwaf7p06BWcfxJT2VVjYiG2l44S24k8PvIIat+y9RsmKuIqJrnkNs236OgUoM0
 K7YDFLKSL7Bb34/kEor4iHfUvDoyN9SZE9ZsVXfLJ9e/+CPIFYbx6SQRDdXA6smXbq/GqX
 Cf7bbO1mUMJ6lHeFJIawjYA6JL0FD8c=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-318--NO20msOMXSaIUnbIICCeg-1; Wed,
 29 Oct 2025 08:06:43 -0400
X-MC-Unique: -NO20msOMXSaIUnbIICCeg-1
X-Mimecast-MFC-AGG-ID: -NO20msOMXSaIUnbIICCeg_1761739602
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A480D19540DF; Wed, 29 Oct 2025 12:06:42 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.33.204])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 37F2A180044F; Wed, 29 Oct 2025 12:06:40 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 02/18] block: remove 'detached-header' option from opts after
 use
Date: Wed, 29 Oct 2025 13:06:18 +0100
Message-ID: <20251029120634.288467-3-kwolf@redhat.com>
In-Reply-To: <20251029120634.288467-1-kwolf@redhat.com>
References: <20251029120634.288467-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Daniel P. Berrangé <berrange@redhat.com>

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
was seeing the left-over 'detached-header' option which had not
been removed from QemuOpts.

This problem was identified by the 'luks-detached-header' I/O
test, but unfortunately I/O tests are not run regularly for the
LUKS format.

Fixes: e818c01ae6e7c54c7019baaf307be59d99ce80b9
Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20250919103810.1513109-1-berrange@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
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
2.51.0


