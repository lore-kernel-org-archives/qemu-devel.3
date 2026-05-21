Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE44ECD4F5E
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 11:57:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ224-0004gS-Qz; Thu, 21 May 2026 07:57:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wQ220-0004a8-K9
 for qemu-devel@nongnu.org; Thu, 21 May 2026 07:57:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wQ21y-00043U-NV
 for qemu-devel@nongnu.org; Thu, 21 May 2026 07:57:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779364657;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RZe8CPnHyR2ivcxoMe01YPDfyJrlhdcOYxW+oU3Kn2Y=;
 b=Y7Rr/JgdiAhMRGrX7HO8JilN5chtkmZGYVkMC5DroYcsN643L5KqMXPfI5xxLm+cz7Q4c6
 l6pf1HKWsYgL4yZkHWmPM78ExGgW+EjLQVeykxxhKzw/pNqAqAHHqGQ1I+XOhGNlpB6QJQ
 jHvYl/Lkwq3AOERN1CfJLa9a9PV05Eo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-107-ZO20lljpMVqHnRLbz8uFlg-1; Thu,
 21 May 2026 07:57:35 -0400
X-MC-Unique: ZO20lljpMVqHnRLbz8uFlg-1
X-Mimecast-MFC-AGG-ID: ZO20lljpMVqHnRLbz8uFlg_1779364654
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A59A8195609D; Thu, 21 May 2026 11:57:34 +0000 (UTC)
Received: from localhost (unknown [10.44.24.26])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2F2201681; Thu, 21 May 2026 11:57:32 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 02/38] ui/vt100: Take byte as uint8_t in bh_utf8_decode()
Date: Thu, 21 May 2026 15:56:39 +0400
Message-ID: <20260521115717.1701482-3-marcandre.lureau@redhat.com>
In-Reply-To: <20260521115717.1701482-1-marcandre.lureau@redhat.com>
References: <20260521115717.1701482-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Peter Maydell <peter.maydell@linaro.org>

The bh_utf8_decode() UTF8 decoder takes its next byte as a "uint32_t
byte" parameter, but it assumes it to be in bounds as it immediately
indexes into its array with it.

Use "uint8_t" as the argument type instead. This moves us away from
the upstream implementation slightly, but it is the same type as
we use in the one callsite, and it makes it clear that we can't
be indexing off the end of the array with this guest-derived data.

This probably helps make Coverity a bit happier (CID 1659590).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260512104210.3330835-3-peter.maydell@linaro.org>
---
 ui/vt100.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/vt100.c b/ui/vt100.c
index 7e373766bc1..f8140cfa85c 100644
--- a/ui/vt100.c
+++ b/ui/vt100.c
@@ -438,7 +438,7 @@ static void vt100_clear_xy(QemuVT100 *vt, int x, int y)
 #define BH_UTF8_ACCEPT 0
 #define BH_UTF8_REJECT 12
 
-static uint32_t bh_utf8_decode(uint32_t *state, uint32_t *codep, uint32_t byte)
+static uint32_t bh_utf8_decode(uint32_t *state, uint32_t *codep, uint8_t byte)
 {
     static const uint8_t utf8d[] = {
         /* character class lookup */
-- 
2.54.0


