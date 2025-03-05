Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A31DC19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 06:42:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpiSV-0001oQ-W2; Wed, 05 Mar 2025 01:42:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1tpiSS-0001kj-5d
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 01:42:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1tpiSQ-0001jD-L4
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 01:42:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741156937;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J00pWuUnTDd4NWy1BuTvnygaDXlsFJHg+/zKXZfp87g=;
 b=irIQ/APy29AfnUfv09iChPAmqy214MYkeJvuxbHG23Ma4P6pszvRXmC91CW3FzmnUf8uGk
 pzqJuNDyXhXgotWfsdZnrt1ks91F7HxINFRkAA14H9DnslN1gsKucsMq2GxjtrOzWs0Nz2
 ML5BORCTF0fqhi3Z15SmmOCaY5pABS8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-61-Tw9pfuRAMcGVKM9LDnQlmQ-1; Wed,
 05 Mar 2025 01:42:06 -0500
X-MC-Unique: Tw9pfuRAMcGVKM9LDnQlmQ-1
X-Mimecast-MFC-AGG-ID: Tw9pfuRAMcGVKM9LDnQlmQ_1741156925
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C73FC19560B2; Wed,  5 Mar 2025 06:42:05 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E1A031954B32; Wed,  5 Mar 2025 06:42:03 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 3/6] ui/console-vc: report cursor position in the screen not in
 the scroll buffer
Date: Wed,  5 Mar 2025 10:41:29 +0400
Message-ID: <20250305064132.87441-4-marcandre.lureau@redhat.com>
In-Reply-To: <20250305064132.87441-1-marcandre.lureau@redhat.com>
References: <20250305064132.87441-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
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

From: Roman Penyaev <r.peniaev@gmail.com>

The format of the CSI cursor position report is `ESC[row;columnR`,
where `row` is a row of a cursor in the screen, not in the scrollback
buffer. What's the difference? Let's say the terminal screen has 24
lines, no matter how long the scrollback buffer may be, the last line
is the 24th.

For example the following command can be executed in xterm on the last
screen line:

   $ echo -en '\e[6n'; IFS='[;' read -sdR _ row col; echo $row:$col
   24:1

It shows the cursor position on the current screen and not relative
to the backscroll buffer.

Before this change the row number was always increasing for the QEMU
VC and represents the cursor position relative to the backscroll
buffer.

Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20250226075913.353676-4-r.peniaev@gmail.com>
---
 ui/console-vc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/ui/console-vc.c b/ui/console-vc.c
index d512f57e10..87f57f1c52 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -827,8 +827,7 @@ static void vc_putchar(VCChardev *vc, int ch)
                 case 6:
                     /* report cursor position */
                     response = g_strdup_printf("\033[%d;%dR",
-                           (s->y_base + s->y) % s->total_height + 1,
-                            s->x + 1);
+                                               s->y + 1, s->x + 1);
                     vc_respond_str(vc, response);
                     break;
                 }
-- 
2.47.0


