Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CB1AC5B543
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 12:38:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOyEX-000192-EO; Tue, 10 Jun 2025 08:37:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uOyEQ-000150-VP
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 08:37:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uOyEL-0000LR-S1
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 08:37:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749559048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2pU/WdK9MyKAGOHOGRI5D/jij3/HMuB9YHu/fFuyEtc=;
 b=P50WPoiMNAXXcSBGmpHk+NnreuY3GSKmQfDuui8cJQIFrlBXIwQe02GwvCfOT1oAVBXgVD
 HBzOSpKtJJ96Ols+coOjOvUBnkTS/oA9QmxJaGBWSiPPuQpvJ9/fLUrHSXRLQpR7saFJoB
 84pdB0zcMR4vRwOc6770LYjOGzkUEns=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-575-n90PJIM7PLiroL2NwEMKXQ-1; Tue,
 10 Jun 2025 08:37:25 -0400
X-MC-Unique: n90PJIM7PLiroL2NwEMKXQ-1
X-Mimecast-MFC-AGG-ID: n90PJIM7PLiroL2NwEMKXQ_1749559044
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E1503180028A; Tue, 10 Jun 2025 12:37:23 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.87])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9D26130001B1; Tue, 10 Jun 2025 12:37:21 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 04/31] chardev/char-fd: skip automatic zero-init of large array
Date: Tue, 10 Jun 2025 13:36:42 +0100
Message-ID: <20250610123709.835102-5-berrange@redhat.com>
In-Reply-To: <20250610123709.835102-1-berrange@redhat.com>
References: <20250610123709.835102-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The 'fd_chr_read' method has a 4k byte array used for copying
data between the socket and device. Skip the automatic zero-init
of this array to eliminate the performance overhead in the I/O
hot path.

The 'buf' array will be fully initialized when reading data off
the network socket.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 chardev/char-fd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/chardev/char-fd.c b/chardev/char-fd.c
index 23bfe3c0b1..6f03adf872 100644
--- a/chardev/char-fd.c
+++ b/chardev/char-fd.c
@@ -50,7 +50,7 @@ static gboolean fd_chr_read(QIOChannel *chan, GIOCondition cond, void *opaque)
     Chardev *chr = CHARDEV(opaque);
     FDChardev *s = FD_CHARDEV(opaque);
     int len;
-    uint8_t buf[CHR_READ_BUF_LEN];
+    QEMU_UNINITIALIZED uint8_t buf[CHR_READ_BUF_LEN];
     ssize_t ret;
 
     len = sizeof(buf);
-- 
2.49.0


