Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A0F3C43602
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 12:54:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgiqK-0005x3-BU; Mon, 06 Jul 2026 08:54:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wgiqE-0005uZ-En
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 08:54:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wgiqC-00086r-Uh
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 08:54:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783342467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fjemWcUQ0wpFl2+FNiO5wmSYq4+Q2OjQyjJjPZdkMWg=;
 b=MZcHtrr27ZBArG2m9VsPwPEBvMyN87l7r31O3yobmXlLyC7ipkSKyLDomzR42YcezEJ7Dg
 oFJ9VIEIIWJUDuNGvU7Bbi7cvThk8uuMBRwkRgjLy1n7SuX6CWh9+yCzhPn7YVKhbUrIYC
 WQAXFA0uUT7YU2I0njgkKV/TYsB7kuE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-106-zkzl4vEzP9uchR0_0-0UWg-1; Mon,
 06 Jul 2026 08:54:23 -0400
X-MC-Unique: zkzl4vEzP9uchR0_0-0UWg-1
X-Mimecast-MFC-AGG-ID: zkzl4vEzP9uchR0_0-0UWg_1783342461
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4BA0D18052C5; Mon,  6 Jul 2026 12:54:21 +0000 (UTC)
Received: from localhost (unknown [10.44.22.3])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1B41E18005A4; Mon,  6 Jul 2026 12:54:19 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 06 Jul 2026 16:53:50 +0400
Subject: [PATCH 3/5] ui/vnc: validate color shifts in SetPixelFormat
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-fix-v1-3-4b83a70e9f3b@redhat.com>
References: <20260706-fix-v1-0-4b83a70e9f3b@redhat.com>
In-Reply-To: <20260706-fix-v1-0-4b83a70e9f3b@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2093;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=/764FwEy+oMuo7XRT7vkFLChejFIabvQLxH4PU5NCcw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqS6Vn1pJsbMg3g1eXZo+l/L8WFjY5KQc0mY9DU
 x7SYRDucf+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCakulZwAKCRDa6OEJdZac
 5XU7D/wP1pv3zX9sft85OhZ3zGBmE7dWsseE5uyBlreG9+RXoPzYcBGRYOk6ZUEKG13KhuYfgM2
 4rXQ72FNi6AhinHVKgKV4DzaZyq6gOQ2Ey4VOm01NXlkZH+xfcYR0cvsySv2lvyeATPQ/1h3DDa
 nR70QceDIGokm5dcYNNmWhylR8ndbwTyQoqQLpSKQ0dvWVfn43XkV9FsKsZPCYXjfmYmWO1vNW7
 uv4BnG2ngavZA5+jIoKcF8rydInTIC+YkIETyij/xPpnJ72+vl23PK2q+2ozyM5Uy+clktyw+xV
 v6weXFQ7pA2v6s+C11Jg/kmeJzDTKm3AfNkgr3x3AyNNJj/zLgsEWfOlcsg43TqjXdbhr1Js1/2
 YvZtF3qauo1yn2birZbJrcT8FvsI1CyMTseq54OeEuVf+iiop0Hda9MkTSwkgmh+UhLEIBhkKrU
 jMrvv1TSM4qTlMl08Mdu0cC3efALLTdxz3OUEwi2BPc9eS0scxPU9dqxWxV3Ccrw3R/CVQuJe/z
 h+pEqYyO/VZeGLr5oPPvCF7PeQbHkakceh/Oc/XJVSnsXAXbEr8EHlCEZEUu6jNyrDClIctEIZ+
 GFiQbu35XyKlkBOnAV1wdSwqj9lttwKDCASwexJ16BHHWXwUPKabMFikTQw8vUZsH5uW0lLcdnX
 UU9CHkOmYWCpmyA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reject color shifts >= bits_per_pixel before computing masks, and cast
the max values to uint32_t to avoid signed integer overflow when a
valid shift (e.g. 24) would set bit 31 of a signed int.

Fixes: 9f64916da20 ("pixman/vnc: use pixman images in vnc.")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3948
Reported-by: huntr bubble
Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
---
 ui/vnc.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index 559d3954b87..94a38242c56 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -2276,18 +2276,25 @@ static void set_pixel_format(VncState *vs, int bits_per_pixel,
         return;
     }
 
+    if (red_shift >= bits_per_pixel ||
+        green_shift >= bits_per_pixel ||
+        blue_shift >= bits_per_pixel) {
+        vnc_client_error(vs);
+        return;
+    }
+
     vs->client_pf.rmax = red_max ? red_max : 0xFF;
     vs->client_pf.rbits = ctpopl(red_max);
     vs->client_pf.rshift = red_shift;
-    vs->client_pf.rmask = red_max << red_shift;
+    vs->client_pf.rmask = (uint32_t)red_max << red_shift;
     vs->client_pf.gmax = green_max ? green_max : 0xFF;
     vs->client_pf.gbits = ctpopl(green_max);
     vs->client_pf.gshift = green_shift;
-    vs->client_pf.gmask = green_max << green_shift;
+    vs->client_pf.gmask = (uint32_t)green_max << green_shift;
     vs->client_pf.bmax = blue_max ? blue_max : 0xFF;
     vs->client_pf.bbits = ctpopl(blue_max);
     vs->client_pf.bshift = blue_shift;
-    vs->client_pf.bmask = blue_max << blue_shift;
+    vs->client_pf.bmask = (uint32_t)blue_max << blue_shift;
     vs->client_pf.bits_per_pixel = bits_per_pixel;
     vs->client_pf.bytes_per_pixel = bits_per_pixel / 8;
     vs->client_pf.depth = bits_per_pixel == 32 ? 24 : bits_per_pixel;

-- 
2.55.0


