Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38A67C4451C
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 11:53:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkh8C-0003lR-U9; Fri, 17 Jul 2026 07:53:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wkh8B-0003io-EB
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 07:53:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wkh8A-0003PO-0w
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 07:53:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784289205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mFwO8z45faH+SUf4z+vkV70f6AZle9l0fNeXfFpcE+Q=;
 b=LXmvKHqdmTnkgKqU5lTqXrIwzfbCtF/f2Xhm2taZGz/iDIGq6icqfpQbAFQWx9SExghQwQ
 xPyqfgm7MFZBwDu19L8hKmUFafrhUlauQgrzhjJe5YJr25LPcYd2JE9vpgTnPpknkn0+1P
 PGtl3Bn4jUdITlkcIQI8sJiC8CjcvX0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-KB1ME8JgN8yG_BfQbBDWMA-1; Fri,
 17 Jul 2026 07:53:20 -0400
X-MC-Unique: KB1ME8JgN8yG_BfQbBDWMA-1
X-Mimecast-MFC-AGG-ID: KB1ME8JgN8yG_BfQbBDWMA_1784289200
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 11A661955D48
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 11:53:20 +0000 (UTC)
Received: from localhost (unknown [10.44.22.17])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DDA59195604D
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 11:53:18 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 17 Jul 2026 15:52:42 +0400
Subject: [GIT PULL 03/15] ui/vnc: validate color shifts in SetPixelFormat
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260717-fix-v1-3-cb9f7d49dc52@redhat.com>
References: <20260717-fix-v1-0-cb9f7d49dc52@redhat.com>
In-Reply-To: <20260717-fix-v1-0-cb9f7d49dc52@redhat.com>
To: qemu-devel@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1251;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=ORYeDgS/BTC2BlWLULACM9JIIWK8YOohLX9VzNModlc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqWheZVLoi7xFu286r0O+0JfxUJAhH9CoY4pk/s
 yKdJ+wtypCJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaloXmQAKCRDa6OEJdZac
 5efnD/9wnAwQGGppZhLTWJfB190Mx2ehSqlB2bcc0DWH3O96NdN0mUAzZ1qzRMQJx/G8rAKvAwp
 1FCwcRQk/6px7xTIiW9wMkVVPASIdyN3cScTerkj2H9Lyue7blbiF1COFwKtk8S/Lwy4bZAHP/z
 Afa3YS6Dsye8VvIsG94EkuduIBFmYlscihsMemFJXIpjx37w29QgztfEaJGcMF8lSHAzU3M+Ivb
 uYaRL36v0uR23PXSqYWeUW0Ae8ugrPB1vfuYurPWrgo5RuSgwX/9CpdKMKoRE04sWdlDY9VNwPT
 ypDdT2iov18ddRAV9FUTYkurSJKg8wdPFAER6GRM4C6c+6rd5y2FCQgVpALIOKYGUs9EYnyz/vf
 fC19leHBB/jjzFx8mu8VTbUWRkAd/jCJiUo4sHQJ9D/i2seBa6a+nGJ4O9hMVTo3bC3oALIbUtm
 4UKq/7ex+l5pezamT+JFNjI5t261VaHY4Hf3+iziB08dXRQmhYQlvud9ZOdJ81hiUAy07bu9led
 uy2Qh728TQtxPNhNTs3bBDLCjlJp518PjOcTJpiKgxCEvc6rDX6+lZn4zSHF3WKlQZETl6Kcw79
 jN794xH/7Nje3Hvyb0NhLh57hm539e4GR4tyWUZRjrx4RlIDmkFgAOC3glGAQIVLQzyojVnukuY
 Bx7HZH/Y5mL9Zkg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

A malicious VNC client can send a SetPixelFormat message with shift
values >= 32, causing UB mask computation
(e.g. red_max << red_shift where red_shift is 255). Apparently, this is
not covered by -fwrapv.

Reject color shifts >= bits_per_pixel || 32 before computing masks.

Fixes: 9f64916da20 ("pixman/vnc: use pixman images in vnc.")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3948
Reported-by: huntr bubble
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
---
 ui/vnc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/ui/vnc.c b/ui/vnc.c
index 559d3954b87..9219f593d95 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -2276,6 +2276,13 @@ static void set_pixel_format(VncState *vs, int bits_per_pixel,
         return;
     }
 
+    if (red_shift >= bits_per_pixel || red_shift >= 32 ||
+        green_shift >= bits_per_pixel || green_shift >= 32 ||
+        blue_shift >= bits_per_pixel || blue_shift >= 32) {
+        vnc_client_error(vs);
+        return;
+    }
+
     vs->client_pf.rmax = red_max ? red_max : 0xFF;
     vs->client_pf.rbits = ctpopl(red_max);
     vs->client_pf.rshift = red_shift;

-- 
2.55.0


