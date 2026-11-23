Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307E3606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 17:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ETtxNnzM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVXQ1-0004yi-2G; Mon, 23 Nov 2026 12:01:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xVXPe-0004gx-Af
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 12:01:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xVXPb-0007X2-JY
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 12:01:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795453262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l191S/6c6HpwdRQ0u+rMK00+yhUqGtbpIcfro2CcLj8=;
 b=ETtxNnzMusdgoYpdXiKVyrU3CDy2zRBpBpVvdZnzUxuf2zFF9niQbLQPWg5ulDeJrswiv3
 E471yRvV7C6iYrZkrz7Y2gnA0SiJCIG41mwgcN9643slBw6ZaAD21+X41PChTIfZKQMuHe
 O1QrDfAql7bITent0XAnJwoCJ3Tyr8c=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-544-v3QOG3IaNd662kC2bsS_Cw-1; Mon,
 23 Nov 2026 17:01:00 +0000
X-MC-Unique: v3QOG3IaNd662kC2bsS_Cw-1
X-Mimecast-MFC-AGG-ID: v3QOG3IaNd662kC2bsS_Cw_1795453259
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 709BA195395C
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 17:00:59 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6184218011D3; Mon, 23 Nov 2026 17:00:58 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 4/6] tests/functional: add Accept header when downloading assets
Date: Mon, 23 Nov 2026 17:00:48 +0000
Message-ID: <20261123170050.4166517-5-berrange@redhat.com>
In-Reply-To: <20261123170050.4166517-1-berrange@redhat.com>
References: <20261123170050.4166517-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

elinux.org is currently triggering an Anubis challenge for requests
to download assets. After comparing the headers that curl sends, it
was narrowed down to the omission of an "Accept" header.

A missing "Accept" header is a rule that Anubis added a year ago
which is known to hit python's urllib:

  https://github.com/TecharoHQ/anubis/issues/1346

the bug indicates the rule was removed by default at that time,
however, rules have evolved further since then and look like they
are hitting our downloads. Adding the header is simple & harmless.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/functional/qemu_test/asset.py | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tests/functional/qemu_test/asset.py b/tests/functional/qemu_test/asset.py
index 0abd89e0a38..ffa01aba2fb 100644
--- a/tests/functional/qemu_test/asset.py
+++ b/tests/functional/qemu_test/asset.py
@@ -137,7 +137,16 @@ def _try_to_fetch(self, tmp_cache_file):
         for _retries in range(3):
             try:
                 with tmp_cache_file.open("xb") as dst:
-                    with urllib.request.urlopen(self.url) as resp:
+                    req = urllib.request.Request(
+                        self.url,
+                        headers={
+                            # Workaround Anubis challenge which some sites
+                            # trigger when Accept is missing:
+                            #  https://github.com/TecharoHQ/anubis/issues/1346
+                            "Accept": "*/*",
+                        }
+                    )
+                    with urllib.request.urlopen(req) as resp:
                         copyfileobj(resp, dst)
                         length_hdr = resp.getheader("Content-Length")
 
-- 
2.56.1


