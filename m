Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0C7DC678DA
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 12:45:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOyFg-0001oa-5b; Tue, 10 Jun 2025 08:38:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uOyEd-0001CS-3f
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 08:37:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uOyEb-0000ON-7x
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 08:37:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749559064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C7RTKr9TMIEcecNoe3lz3XO90qrGqNncV53XXMM1M2g=;
 b=DrxTAYMb41dV+HtVKZPFgCBgEqkUpODW5/IoiEbN9Hvijpmkcgb9JPTdUG9pmpS54Mzgix
 YPtRaa03YhRq8IC3vTdVFnXmpCT75SMVxRXhcaUukwddwn27Y28EvCRZpIlZXXetgSwRZV
 JtvLfih103hi1r8I6l55uP9HRh1eJoE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-260-SOqxDLp0P7ay3V75-atGZg-1; Tue,
 10 Jun 2025 08:37:40 -0400
X-MC-Unique: SOqxDLp0P7ay3V75-atGZg-1
X-Mimecast-MFC-AGG-ID: SOqxDLp0P7ay3V75-atGZg_1749559059
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7C0D9180135B; Tue, 10 Jun 2025 12:37:39 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.87])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4C14A30001B1; Tue, 10 Jun 2025 12:37:37 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 10/31] hw/audio/gus: skip automatic zero-init of large array
Date: Tue, 10 Jun 2025 13:36:48 +0100
Message-ID: <20250610123709.835102-11-berrange@redhat.com>
In-Reply-To: <20250610123709.835102-1-berrange@redhat.com>
References: <20250610123709.835102-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The 'GUS_read_DMA' method has a 4k byte array used for copying
data between the audio backend and device. Skip the automatic
zero-init of this array to eliminate the performance overhead in
the I/O hot path.

The 'tmpbuf' array will be fully initialized when reading data
from device memory.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/audio/gus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/audio/gus.c b/hw/audio/gus.c
index 87e8634893..c36df0240f 100644
--- a/hw/audio/gus.c
+++ b/hw/audio/gus.c
@@ -183,7 +183,7 @@ static int GUS_read_DMA (void *opaque, int nchan, int dma_pos, int dma_len)
 {
     GUSState *s = opaque;
     IsaDmaClass *k = ISADMA_GET_CLASS(s->isa_dma);
-    char tmpbuf[4096];
+    QEMU_UNINITIALIZED char tmpbuf[4096];
     int pos = dma_pos, mode, left = dma_len - dma_pos;
 
     ldebug ("read DMA %#x %d\n", dma_pos, dma_len);
-- 
2.49.0


