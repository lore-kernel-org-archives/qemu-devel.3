Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66099C28B2E
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 08:03:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsdW8-0004Cp-CU; Thu, 13 Mar 2025 04:02:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tsdW1-00048k-HO
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 04:02:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tsdVz-0007ir-N2
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 04:02:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741852922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GK09BF3/euIWU9pkP2gpzT9/ok5OVwK5KYCEivXHKjk=;
 b=b6NwcNORU1cRz9hPN/Fk+09ixeGLPeWUI+ef25GDD6lmOuixIQCxO1Qc9581FMNW5X1JIt
 W3XDFz4konKG6cN7fi4z160VdiLmZfWAUNqNL08USQWl/PwUSSQXyNMH2DATKWhT55pIcv
 Cii0Gv2vkZDiV4MfKtx2xnCFNNy8Dzo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-G5W9hqCJM6SkQwvxZTzr7A-1; Thu,
 13 Mar 2025 04:01:56 -0400
X-MC-Unique: G5W9hqCJM6SkQwvxZTzr7A-1
X-Mimecast-MFC-AGG-ID: G5W9hqCJM6SkQwvxZTzr7A_1741852916
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DD35B19560B8; Thu, 13 Mar 2025 08:01:55 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.26])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F2DB61955F2D; Thu, 13 Mar 2025 08:01:53 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 6/8] tests/functional/asset: Verify downloaded size
Date: Thu, 13 Mar 2025 09:01:30 +0100
Message-ID: <20250313080132.1467625-7-thuth@redhat.com>
In-Reply-To: <20250313080132.1467625-1-thuth@redhat.com>
References: <20250313080132.1467625-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Nicholas Piggin <npiggin@gmail.com>

If the server provides a Content-Length header, use that to verify the
size of the downloaded file. This catches cases where the connection
terminates early, and gives the opportunity to retry. Without this, the
checksum will likely mismatch and fail without retry.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Message-ID: <20250312130002.945508-3-npiggin@gmail.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/qemu_test/asset.py | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tests/functional/qemu_test/asset.py b/tests/functional/qemu_test/asset.py
index 27dd839e705..6bbfb9e1cad 100644
--- a/tests/functional/qemu_test/asset.py
+++ b/tests/functional/qemu_test/asset.py
@@ -121,6 +121,20 @@ def fetch(self):
                 with tmp_cache_file.open("xb") as dst:
                     with urllib.request.urlopen(self.url) as resp:
                         copyfileobj(resp, dst)
+                        length_hdr = resp.getheader("Content-Length")
+
+                # Verify downloaded file size against length metadata, if
+                # available.
+                if length_hdr is not None:
+                    length = int(length_hdr)
+                    fsize = tmp_cache_file.stat().st_size
+                    if fsize != length:
+                        self.log.error("Unable to download %s: "
+                                       "connection closed before "
+                                       "transfer complete (%d/%d)",
+                                       self.url, fsize, length)
+                        tmp_cache_file.unlink()
+                        continue
                 break
             except FileExistsError:
                 self.log.debug("%s already exists, "
-- 
2.48.1


