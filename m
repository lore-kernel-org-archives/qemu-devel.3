Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DC09D591A9
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 17:38:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD5hD-0001lk-5P; Mon, 18 Nov 2024 12:37:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tD5hB-0001bO-MZ
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 12:37:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tD5hA-00050U-6M
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 12:37:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731951471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hkzDv6uUFa/SZx2BOtVeB2b/N2Qd/jtqZGg5bLu+YqA=;
 b=flfzM5MzCUrllU4J/3LGnynt7MDBRIZg4c/u0uPqTTiT9ZRd3/NuMIiuJof8rcsOkeynXY
 rY2q8u0XDa2K448ZgqCYV3EVteyd8xFmGmJPvhBRAMsVjZm8mSH4KXNxFsNPZS48UsUvxN
 jIR4L0SnmS+iR50WETr964o5+c/sHL0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-312-vUE5Lk_lMOe-a1hOjQTg8g-1; Mon,
 18 Nov 2024 12:36:43 -0500
X-MC-Unique: vUE5Lk_lMOe-a1hOjQTg8g-1
X-Mimecast-MFC-AGG-ID: vUE5Lk_lMOe-a1hOjQTg8g
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 120D21955BCF; Mon, 18 Nov 2024 17:36:41 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.53])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7507719560A3; Mon, 18 Nov 2024 17:36:38 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Roque Arcudia Hernandez <roqueh@google.com>,
 Erwin Jansen <jansene@google.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 01/12] hw/usb: Use __attribute__((packed)) vs __packed
Date: Mon, 18 Nov 2024 18:36:23 +0100
Message-ID: <20241118173634.473532-2-thuth@redhat.com>
In-Reply-To: <20241118173634.473532-1-thuth@redhat.com>
References: <20241118173634.473532-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

From: Roque Arcudia Hernandez <roqueh@google.com>

__packed is non standard and is not present in clang-cl.
__attribute__((packed)) has the same semantics.

Signed-off-by: Erwin Jansen <jansene@google.com>
Signed-off-by: Roque Arcudia Hernandez <roqueh@google.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20241101211720.3354111-1-roqueh@google.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/usb/dwc2-regs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/usb/dwc2-regs.h b/include/hw/usb/dwc2-regs.h
index 523b112c5e..b8b4266543 100644
--- a/include/hw/usb/dwc2-regs.h
+++ b/include/hw/usb/dwc2-regs.h
@@ -838,7 +838,7 @@
 struct dwc2_dma_desc {
         uint32_t status;
         uint32_t buf;
-} __packed;
+} QEMU_PACKED;
 
 /* Host Mode DMA descriptor status quadlet */
 
-- 
2.47.0


