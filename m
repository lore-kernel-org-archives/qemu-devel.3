Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 023BFC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 12:20:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjed5-0002yk-FH; Mon, 11 Mar 2024 08:19:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rjecz-0002xk-0w
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 08:19:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rjecx-0007tH-85
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 08:19:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710159574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QzABfLKBNKfh0a7Wav9rN1Gab+80WRzCwqrIX4+gLUw=;
 b=WjFfqqI8KIpFQq3tM65vIxbJ+fiE+dHDrLxaXp3O/N6Xqjta9WLEUBVlMNIYcc/lJBOhpp
 ofs51QPstgrxa+evZTRX1e4Eon5EHqPRN14eRRX2+RlLNPc1BJer+k+znyL6jxzWalVKdp
 j5CIpzpbbGYWAydli/0dJRUNJ8gchiU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-d24tsdCUOkepUnf2RPOsfQ-1; Mon, 11 Mar 2024 08:19:33 -0400
X-MC-Unique: d24tsdCUOkepUnf2RPOsfQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2E7508007AB
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 12:19:33 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.132])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 95439C1576F;
 Mon, 11 Mar 2024 12:19:32 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH 3/4] crypto: use error_abort for unexpected failures
Date: Mon, 11 Mar 2024 12:19:28 +0000
Message-ID: <20240311121929.212472-4-berrange@redhat.com>
In-Reply-To: <20240311121929.212472-1-berrange@redhat.com>
References: <20240311121929.212472-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This improves the error diagnosis from the unit test when a cipher
is unexpected not available from

ERROR:../tests/unit/test-crypto-cipher.c:683:test_cipher: assertion failed: (err == NULL)
Bail out! ERROR:../tests/unit/test-crypto-cipher.c:683:test_cipher: assertion failed: (err == NULL)
Aborted (core dumped)

to

Unexpected error in qcrypto_cipher_ctx_new() at ../crypto/cipher-gcrypt.c.inc:262:
./build//tests/unit/test-crypto-cipher: Cannot initialize cipher: Invalid cipher algorithm
Aborted (core dumped)

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/unit/test-crypto-cipher.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tests/unit/test-crypto-cipher.c b/tests/unit/test-crypto-cipher.c
index 11ab1a54fc..d0ea7b4d8e 100644
--- a/tests/unit/test-crypto-cipher.c
+++ b/tests/unit/test-crypto-cipher.c
@@ -676,9 +676,8 @@ static void test_cipher(const void *opaque)
     cipher = qcrypto_cipher_new(
         data->alg, data->mode,
         key, nkey,
-        &err);
+        data->plaintext ? &error_abort : &err);
     if (data->plaintext) {
-        g_assert(err == NULL);
         g_assert(cipher != NULL);
     } else {
         error_free_or_abort(&err);
-- 
2.43.0


