Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49D2EC54E90
	for <qemu-devel@archiver.kernel.org>; Sun, 25 May 2025 13:29:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJBOA-0007Vt-Rx; Sun, 25 May 2025 09:27:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uJBO9-0007VY-MP
 for qemu-devel@nongnu.org; Sun, 25 May 2025 09:27:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uJBO8-0003Kj-08
 for qemu-devel@nongnu.org; Sun, 25 May 2025 09:27:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748179659;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4zBlc/trBlZVvlSclE+TjFVwrWRwhdoV0H1DLERA2U0=;
 b=cUt1pMZzeHGj6E11OndJUNZFKEl3chFdGTrVfbiC0mLIUbaJH23+IbEptwklk8bhI9q0TG
 u+XZjr4TmmEj9heBfamCnwTC7zAZmXL8CiBUbPvcONlI0tlvjeqVWsiqBJi5c466l+QC8J
 9YMwa6cyapZwjz5HFwMW0aLsZlYiS5A=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-287-0x-jPlCWO8K_cTYlWVGtxQ-1; Sun,
 25 May 2025 09:27:37 -0400
X-MC-Unique: 0x-jPlCWO8K_cTYlWVGtxQ-1
X-Mimecast-MFC-AGG-ID: 0x-jPlCWO8K_cTYlWVGtxQ_1748179656
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 559C61800447; Sun, 25 May 2025 13:27:36 +0000 (UTC)
Received: from localhost (unknown [10.45.242.5])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A7A5D1956095; Sun, 25 May 2025 13:27:35 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Laurent Vivier <laurent@vivier.eu>, Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 5/9] hw/audio/asc: replace g_malloc0() with g_malloc()
Date: Sun, 25 May 2025 15:27:12 +0200
Message-ID: <20250525132717.527392-6-marcandre.lureau@redhat.com>
In-Reply-To: <20250525132717.527392-1-marcandre.lureau@redhat.com>
References: <20250525132717.527392-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -59
X-Spam_score: -6.0
X-Spam_bar: ------
X-Spam_report: (-6.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Volker Rümelin <vr_qemu@t-online.de>

There is no need to allocate initialized memory with g_malloc0()
if it's directly followed by a memset() function call. g_malloc()
is sufficient.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
Message-Id: <20250515054429.7385-5-vr_qemu@t-online.de>
---
 hw/audio/asc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/audio/asc.c b/hw/audio/asc.c
index 6721c0d9fb..edd42d6d91 100644
--- a/hw/audio/asc.c
+++ b/hw/audio/asc.c
@@ -664,7 +664,7 @@ static void asc_realize(DeviceState *dev, Error **errp)
     s->samples = AUD_get_buffer_size_out(s->voice) >> s->shift;
     s->mixbuf = g_malloc0(s->samples << s->shift);
 
-    s->silentbuf = g_malloc0(s->samples << s->shift);
+    s->silentbuf = g_malloc(s->samples << s->shift);
     memset(s->silentbuf, 0x80, s->samples << s->shift);
 
     /* Add easc registers if required */
-- 
2.49.0


