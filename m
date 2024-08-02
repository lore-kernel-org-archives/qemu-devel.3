Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F6B4C3DA64
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 03:20:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZipf-0003LW-PH; Thu, 01 Aug 2024 23:19:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sZipe-0003EX-0P
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 23:19:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sZipa-0008Pm-2c
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 23:19:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722568787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gej3BZW1jRRnjEGiS9Y5Dm5DmUSoq/CdSCr11ScQosI=;
 b=CnvLqYZSkBF1Dzp64ZFnHPtM6/9tYB5vvY5JWdAt4nF54Q0ScFAM//hwzOyrRXY5ZmgirJ
 JEOyfcCsp/HgJQgHzJ89xntOwEbj8RUXusvJMxlxuPvOREJYduvGh7MqXUBXFWs2ykpudQ
 l/6bh3+Id5pDsY9tQusD0gb+czRrIZ0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-272-zXoQgsJiP6Kws90ETsBcKQ-1; Thu,
 01 Aug 2024 23:19:42 -0400
X-MC-Unique: zXoQgsJiP6Kws90ETsBcKQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 30B121955D4B; Fri,  2 Aug 2024 03:19:39 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.229])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 02E9C300019E; Fri,  2 Aug 2024 03:19:35 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hans <sungdgdhtryrt@gmail.com>,
	Jason Wang <jasowang@redhat.com>
Subject: [PULL 1/8] rtl8139: Fix behaviour for old kernels.
Date: Fri,  2 Aug 2024 11:19:22 +0800
Message-ID: <20240802031929.44060-2-jasowang@redhat.com>
In-Reply-To: <20240802031929.44060-1-jasowang@redhat.com>
References: <20240802031929.44060-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Hans <sungdgdhtryrt@gmail.com>

Old linux kernel rtl8139 drivers (ex. debian 2.1) uses outb to set the rx
mode for RxConfig. Unfortunatelly qemu does not support outb for RxConfig.

Signed-off-by: Hans <sungdgdhtryrt@gmail.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/rtl8139.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
index 897c86ec41..03a204ef8a 100644
--- a/hw/net/rtl8139.c
+++ b/hw/net/rtl8139.c
@@ -2738,7 +2738,11 @@ static void rtl8139_io_writeb(void *opaque, uint8_t addr, uint32_t val)
             }
 
             break;
-
+        case RxConfig:
+            DPRINTF("RxConfig write(b) val=0x%02x\n", val);
+            rtl8139_RxConfig_write(s,
+                (rtl8139_RxConfig_read(s) & 0xFFFFFF00) | val);
+            break;
         default:
             DPRINTF("not implemented write(b) addr=0x%x val=0x%02x\n", addr,
                 val);
-- 
2.42.0


