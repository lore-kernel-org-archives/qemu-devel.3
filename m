Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7989C5B543
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 12:46:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOyEe-0001Cl-Ah; Tue, 10 Jun 2025 08:37:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uOyEa-0001Bc-I6
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 08:37:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uOyEV-0000NX-Dn
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 08:37:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749559058;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SqELLEQfR8/5Vvj/4xWZnG7IMm5yMn3lnT+oxdWHCkQ=;
 b=dthAb+YGsjmEAbLP1EsIrmQGzymKMWY3GgGo3u/9Fnw55CLdAaRjKEZ3/hf0KWts5Fyz/V
 BGWZgkfyxhYzWRIp9l9NX3/lrLIZ6CdxhLKw5UAmZ+It7YP//w4Z7DC6a2Zpl5yxr+Rhyt
 vXmd8k/cORA2sfOTT4nSOBm+3U8tYmc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-488-mBh_R01mOIKVwAayOMjyMQ-1; Tue,
 10 Jun 2025 08:37:35 -0400
X-MC-Unique: mBh_R01mOIKVwAayOMjyMQ-1
X-Mimecast-MFC-AGG-ID: mBh_R01mOIKVwAayOMjyMQ_1749559054
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3F5B0195606A; Tue, 10 Jun 2025 12:37:34 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.87])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2EA2C30002C6; Tue, 10 Jun 2025 12:37:31 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 08/31] hw/audio/cs4231a: skip automatic zero-init of large
 arrays
Date: Tue, 10 Jun 2025 13:36:46 +0100
Message-ID: <20250610123709.835102-9-berrange@redhat.com>
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
 SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

The 'cs_write_audio' method has a pair of byte arrays, one 4k in size
and one 8k, which are used in converting audio samples. Skip the
automatic zero-init of these arrays to eliminate the performance
overhead in the I/O hot path.

The 'tmpbuf' array will be fully initialized when reading a block of
data from the guest. The 'linbuf' array will be fully initialized
when converting the audio samples.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/audio/cs4231a.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/audio/cs4231a.c b/hw/audio/cs4231a.c
index eb9a45805b..6dfff202ff 100644
--- a/hw/audio/cs4231a.c
+++ b/hw/audio/cs4231a.c
@@ -528,7 +528,7 @@ static int cs_write_audio (CSState *s, int nchan, int dma_pos,
                            int dma_len, int len)
 {
     int temp, net;
-    uint8_t tmpbuf[4096];
+    QEMU_UNINITIALIZED uint8_t tmpbuf[4096];
     IsaDmaClass *k = ISADMA_GET_CLASS(s->isa_dma);
 
     temp = len;
@@ -547,7 +547,7 @@ static int cs_write_audio (CSState *s, int nchan, int dma_pos,
         copied = k->read_memory(s->isa_dma, nchan, tmpbuf, dma_pos, to_copy);
         if (s->tab) {
             int i;
-            int16_t linbuf[4096];
+            QEMU_UNINITIALIZED int16_t linbuf[4096];
 
             for (i = 0; i < copied; ++i)
                 linbuf[i] = s->tab[tmpbuf[i]];
-- 
2.49.0


