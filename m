Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38836C47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 15:22:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT1YK-0004Ou-FK; Thu, 25 Jan 2024 10:22:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rT1YJ-0004Of-MS
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 10:22:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rT1YI-0007FO-0r
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 10:22:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706196120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=S0cVTuBTyXzld7x1iW7DlhQfLLP+UdE6Aa1+QGSRg7k=;
 b=Ad0cAF7GJBEIxWFrj++BctS6eXx74I/lEQ0vD5QyjV3LLoF18SCl3SAPfuts8Ai4O20e6z
 iLR8qS0WlgbmrM2YlYy3zZ/8VeCKDMubxU/YBcGMfoSqNCjzVJ3q14PJuGdItemdixuOKe
 pIFQOSQSJ+oaHwoKKMaU2XZ/+fJAfos=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-341-g89eusZAN06uvVn80NS5pw-1; Thu,
 25 Jan 2024 10:21:56 -0500
X-MC-Unique: g89eusZAN06uvVn80NS5pw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4341D3C1494B;
 Thu, 25 Jan 2024 15:21:56 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.194.139])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6C7F7492BC6;
 Thu, 25 Jan 2024 15:21:55 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, peter.maydell@linaro.org,
 qemu-devel@nongnu.org
Subject: [PATCH] iotests/iothreads-stream: Use the right TimeoutError
Date: Thu, 25 Jan 2024 16:21:50 +0100
Message-ID: <20240125152150.42389-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
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

Since Python 3.11 asyncio.TimeoutError is an alias for TimeoutError, but
in older versions it's not. We really have to catch asyncio.TimeoutError
here, otherwise a slow test run will fail (as has happened multiple
times on CI recently).

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/tests/iothreads-stream | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/tests/iothreads-stream b/tests/qemu-iotests/tests/iothreads-stream
index 503f221f16..231195b5e8 100755
--- a/tests/qemu-iotests/tests/iothreads-stream
+++ b/tests/qemu-iotests/tests/iothreads-stream
@@ -18,6 +18,7 @@
 #
 # Creator/Owner: Kevin Wolf <kwolf@redhat.com>
 
+import asyncio
 import iotests
 
 iotests.script_initialize(supported_fmts=['qcow2'],
@@ -69,6 +70,6 @@ with iotests.FilePath('disk1.img') as base1_path, \
                 # The test is done once both jobs are gone
                 if finished == 2:
                     break
-        except TimeoutError:
+        except asyncio.TimeoutError:
             pass
         vm.cmd('query-jobs')
-- 
2.43.0


