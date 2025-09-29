Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F09ECAC5B0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 16:58:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3H8q-0004QQ-1i; Mon, 29 Sep 2025 12:54:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v3H7d-0002uY-Tu
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 12:53:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v3H7X-0002nY-TW
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 12:53:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759164782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aqVOYhGw94Jf/OiJAawsJ2cAh/HpqFgHZnqY+6tx1CA=;
 b=Mrbni4vZgRAmd4V7+fsm2geSF3qdHrTQGCLH5ATfi6x85y0RqCW3G0oC0tdB9Y/+Gy8sSA
 kXvWlPC/L2/5t86wLGuN7vSqrAoke5bCtb1FXmIx2JrW2OSqtWOS1SHph2ZMDvsXfeLpSe
 KgP/E+aDVKbZCm3KgZQKBubfJ4r0yAE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-Uud92gsJNb6nHzOenO94-w-1; Mon,
 29 Sep 2025 12:52:58 -0400
X-MC-Unique: Uud92gsJNb6nHzOenO94-w-1
X-Mimecast-MFC-AGG-ID: Uud92gsJNb6nHzOenO94-w_1759164777
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9484C1800577; Mon, 29 Sep 2025 16:52:57 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.27])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F08611800452; Mon, 29 Sep 2025 16:52:55 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Kane-Chen-AS <kane_chen@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 09/32] docs/system/arm/aspeed: Document OTP memory options
Date: Mon, 29 Sep 2025 18:52:07 +0200
Message-ID: <20250929165230.797471-10-clg@redhat.com>
In-Reply-To: <20250929165230.797471-1-clg@redhat.com>
References: <20250929165230.797471-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Kane-Chen-AS <kane_chen@aspeedtech.com>

Add documentation for the OTP memory module used by AST2600 and AST1030
SoCs, and describe options for using a pre-generated image or an
internal buffer. Include example commands for configuration and image
generation.

Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250812094011.2617526-11-kane_chen@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 docs/system/arm/aspeed.rst | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/docs/system/arm/aspeed.rst b/docs/system/arm/aspeed.rst
index bf18c5634700..6317c0e910a2 100644
--- a/docs/system/arm/aspeed.rst
+++ b/docs/system/arm/aspeed.rst
@@ -243,6 +243,37 @@ under Linux), use :
 
   -M ast2500-evb,bmc-console=uart3
 
+OTP Option
+^^^^^^^^^^
+
+Both the AST2600 and AST1030 chips use the same One Time Programmable
+(OTP) memory module, which is utilized for configuration, key storage,
+and storing user-programmable data. This OTP memory module is managed
+by the Secure Boot Controller (SBC). The following options can be
+specified or omitted based on your needs.
+
+  * When the options are specified, the pre-generated configuration
+    file will be used as the OTP memory storage.
+
+  * When the options are omitted, an internal memory buffer will be
+    used to store the OTP memory data.
+
+.. code-block:: bash
+
+  -blockdev driver=file,filename=otpmem.img,node-name=otp \
+  -global aspeed-otp.drive=otp \
+
+The following bash command can be used to generate a default
+configuration file for OTP memory:
+
+.. code-block:: bash
+
+  if [ ! -f otpmem.img ]; then
+    for i in $(seq 1 2048); do
+      printf '\x00\x00\x00\x00\xff\xff\xff\xff'
+    done > otpmem.img
+  fi
+
 Aspeed 2700 family boards (``ast2700-evb``)
 ==================================================================
 
-- 
2.51.0


