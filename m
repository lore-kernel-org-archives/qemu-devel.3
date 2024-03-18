Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E84D9C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 13:04:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmCf0-0007RB-7x; Mon, 18 Mar 2024 09:04:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rmCch-0002WI-DM
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 09:01:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rmCce-0007ja-CL
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 09:01:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710766902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UGKKjvaXxYmFKHQMdtSjAoUHjNEkrd8PSJrjEXtTN2M=;
 b=SgrrrCr7BgrQ8mddKSk4U1o2SkXKoqFyFUu2wkHO3AeSmxJmYdAh8xfVIF6lQhfGv2l/oX
 QOj+Go0j33wEoQRJcZ/YY8XG7W8vRVuUIyRFIOx8LL9gnQKMG0cmLigV4yfFyI9X0d4tMw
 1q7HOVTXiHcQpVOvs/6qaCIiB24F5Ic=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-10-FsilWBCDP3afuQUFoVe2ow-1; Mon,
 18 Mar 2024 09:01:39 -0400
X-MC-Unique: FsilWBCDP3afuQUFoVe2ow-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 001843C0D7CD;
 Mon, 18 Mar 2024 13:01:39 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 677842166B5D;
 Mon, 18 Mar 2024 13:01:37 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 15/15] iotests: adapt to output change for recently introduced
 'detached header' field
Date: Mon, 18 Mar 2024 14:01:18 +0100
Message-ID: <20240318130118.358920-16-kwolf@redhat.com>
In-Reply-To: <20240318130118.358920-1-kwolf@redhat.com>
References: <20240318130118.358920-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Fiona Ebner <f.ebner@proxmox.com>

Failure was noticed when running the tests for the qcow2 image format.

Fixes: 0bd779e27e ("crypto: Introduce 'detached-header' field in QCryptoBlockInfoLUKS")
Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Message-ID: <20240216101415.293769-1-f.ebner@proxmox.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/198.out | 2 ++
 tests/qemu-iotests/206.out | 1 +
 2 files changed, 3 insertions(+)

diff --git a/tests/qemu-iotests/198.out b/tests/qemu-iotests/198.out
index 805494916f..62fb73fa3e 100644
--- a/tests/qemu-iotests/198.out
+++ b/tests/qemu-iotests/198.out
@@ -39,6 +39,7 @@ Format specific information:
     compression type: COMPRESSION_TYPE
     encrypt:
         ivgen alg: plain64
+        detached header: false
         hash alg: sha256
         cipher alg: aes-256
         uuid: 00000000-0000-0000-0000-000000000000
@@ -84,6 +85,7 @@ Format specific information:
     compression type: COMPRESSION_TYPE
     encrypt:
         ivgen alg: plain64
+        detached header: false
         hash alg: sha256
         cipher alg: aes-256
         uuid: 00000000-0000-0000-0000-000000000000
diff --git a/tests/qemu-iotests/206.out b/tests/qemu-iotests/206.out
index 7e95694777..979f00f9bf 100644
--- a/tests/qemu-iotests/206.out
+++ b/tests/qemu-iotests/206.out
@@ -114,6 +114,7 @@ Format specific information:
     refcount bits: 16
     encrypt:
         ivgen alg: plain64
+        detached header: false
         hash alg: sha1
         cipher alg: aes-128
         uuid: XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX
-- 
2.44.0


