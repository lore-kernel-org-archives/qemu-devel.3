Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFA86C36014
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 12:15:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzaVJ-0007bF-0Y; Tue, 01 Apr 2025 08:14:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tzaV5-0007YR-MB
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 08:13:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tzaV1-0007rm-Ga
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 08:13:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743509626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dKaWrx46T3xqbSdOVgY4n2L6yvjmlCUhAgoIRBKISKA=;
 b=PGkcyh18pw4IxixpK82AWHUIL6a/MCnyLlcxSl2h1AtrFle5zTywwaXIclAeM4w8Pums2k
 NqNtPmyJQSl2Cl9kQDfd3ms5yFiRmODXvl+chSZOfgd5cg7kyV2w8typKteQj058izeW21
 1nVdj7pn4ePQwUOM4q9DDmP2QdrUBtI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-240-V8nuX2LYP0GMDGVp-zlp-w-1; Tue,
 01 Apr 2025 08:13:45 -0400
X-MC-Unique: V8nuX2LYP0GMDGVp-zlp-w-1
X-Mimecast-MFC-AGG-ID: V8nuX2LYP0GMDGVp-zlp-w_1743509624
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A66C919560BD; Tue,  1 Apr 2025 12:13:43 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.20])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8F0D6180B488; Tue,  1 Apr 2025 12:13:41 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 1/2] hw/misc/aspeed_scu: Set MemoryRegionOps::impl::access_size
 to 32-bit
Date: Tue,  1 Apr 2025 14:13:35 +0200
Message-ID: <20250401121336.788924-2-clg@redhat.com>
In-Reply-To: <20250401121336.788924-1-clg@redhat.com>
References: <20250401121336.788924-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

All MemoryRegionOps::read/write() handlers switch over a 32-bit
aligned value, because converted using TO_REG(), which is defined
as:

  #define TO_REG(offset) ((offset) >> 2)

So all implementations are 32-bit.
Set min/max access_size accordingly.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>
Link: https://lore.kernel.org/qemu-devel/20250331230444.88295-2-philmd@linaro.org
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/misc/aspeed_scu.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
index 76cfd9167161..6703f3f96914 100644
--- a/hw/misc/aspeed_scu.c
+++ b/hw/misc/aspeed_scu.c
@@ -427,6 +427,10 @@ static const MemoryRegionOps aspeed_ast2400_scu_ops = {
     .read = aspeed_scu_read,
     .write = aspeed_ast2400_scu_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
     .valid = {
         .min_access_size = 1,
         .max_access_size = 4,
@@ -437,6 +441,8 @@ static const MemoryRegionOps aspeed_ast2500_scu_ops = {
     .read = aspeed_scu_read,
     .write = aspeed_ast2500_scu_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl.min_access_size = 4,
+    .impl.max_access_size = 4,
     .valid.min_access_size = 4,
     .valid.max_access_size = 4,
     .valid.unaligned = false,
@@ -779,6 +785,8 @@ static const MemoryRegionOps aspeed_ast2600_scu_ops = {
     .read = aspeed_ast2600_scu_read,
     .write = aspeed_ast2600_scu_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl.min_access_size = 4,
+    .impl.max_access_size = 4,
     .valid.min_access_size = 4,
     .valid.max_access_size = 4,
     .valid.unaligned = false,
@@ -906,6 +914,8 @@ static const MemoryRegionOps aspeed_ast2700_scu_ops = {
     .read = aspeed_ast2700_scu_read,
     .write = aspeed_ast2700_scu_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl.min_access_size = 4,
+    .impl.max_access_size = 4,
     .valid.min_access_size = 1,
     .valid.max_access_size = 8,
     .valid.unaligned = false,
@@ -1028,6 +1038,8 @@ static const MemoryRegionOps aspeed_ast2700_scuio_ops = {
     .read = aspeed_ast2700_scuio_read,
     .write = aspeed_ast2700_scuio_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl.min_access_size = 4,
+    .impl.max_access_size = 4,
     .valid.min_access_size = 1,
     .valid.max_access_size = 8,
     .valid.unaligned = false,
-- 
2.49.0


