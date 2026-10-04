Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FD74CA5FCE
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 10:26:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDJPb-0007PC-Ql; Sun, 04 Oct 2026 06:25:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJP6-0006PU-19
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:25:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJP3-00035H-Sz
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:25:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791109509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xzQiA0dW2QxeeEcOrx9kwaoLzqrOh3Dfb2HEZ36axnc=;
 b=TWmvexCK0yq0HvkaJZm6WA+y/T0LUabTCmVDWa+nikjqmf9FNQdnwH5igUtm9zAg+4tJJe
 YbXYxVauriTrExlxnTH/2AxZjQBaaMN3kU2qhvSastzzqkXBhVTQpLsM9Dxn2YA2LR6evL
 GwOIkibTVthsvYvQ8qgrtZlb+M9CBcI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-558-iOfHQO89Pay3esGrrcNlMw-1; Sun,
 04 Oct 2026 06:25:08 -0400
X-MC-Unique: iOfHQO89Pay3esGrrcNlMw-1
X-Mimecast-MFC-AGG-ID: iOfHQO89Pay3esGrrcNlMw_1791109507
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 028881955DC6; Sun,  4 Oct 2026 10:25:07 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0C9D01956089; Sun,  4 Oct 2026 10:25:05 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 04 Oct 2026 14:23:39 +0400
Subject: [PATCH 25/63] hw/audio/gusemu_mixer: use unsigned literal for IRQ
 bit shifts
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261004-issue-4560-v1-25-ccbef537cbeb@redhat.com>
References: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
In-Reply-To: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Pavee Hui <phui@google.com>, Gerd Hoffmann <kraxel@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2092;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=wyPkYoI8Y8wuubTFwBmJQC0sADZM5Miw3DLnVRFgmYQ=;
 b=owEBbAKT/ZANAwAKAdro4Ql1lpzlAcsmYgBqwikjc3Io8VpPW0sPKlzDnHzZPhU2Cx5zCiSC3
 fUE0vbU7g+JAjIEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCasIpIwAKCRDa6OEJdZac
 5bUuD/j8w8iYFEqkI49YimOS5RsLvlWLfHyBvMTclFkXD7jHpVlA2ijkjQwIOJCvvZ06rNY4lZE
 OfPUyG2gwLiUl7kfww1tNjeROmgGdvmPvJYevUpCsQrRPHqUIK9wFcsPHvsBCM51c3Mzshq8CUF
 m8dJc8rGxLTmK3DLiNMYxO/PkRBSFn+Xx4SRGRBbw7r0GvK/GT34oMYTWteqcc6ztukHuZZJOci
 J390t9+zBc7QgXRlJphCNGnfjKNE1t+NInE56+iLt2ol2TcP5VENEHbL6invHbyzFvdJk0Rm3zv
 5IW4r4JQRKrFG/tq+JnpmsdgMwwvIqO6RWsc+GDUCKWa3JWBQxhGq1XCnKmjout7NgYBtI5WpJQ
 x2IcXhFnFTn27ics+R5Va48+bKZtO3wu8lYy90qAnWXpY8TiGVwT0KRfgtvGxNfSULe4JVOLnFG
 SxaZp4uNKvHixl8NfxFp7oAnI0nXSCscFdSC6c/dw/l/l31BbBZJfzKriBJeA+Nndrkf7LzSyFx
 dFJxf5KlQwQ3KEWj5jWwlO7u46zunr5ntX9U3xT9DTmnSKGVpazzHmkjnQ47v58akK0AdwTaqob
 MYOnr1fWjs832CyDUYGtkaNk/XXv9Ml8eIMnQkRA53NI7SWv+oe2PEJITvKfVV6kodh9Us4q94a
 kM72TJtgcXiOd
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Voice ranges up to 31 (NumVoices & 31), so 1 << 31 is undefined
behavior in C as it shifts into the sign bit of a signed int.
Use 1U to make the shift well-defined.

Reported-by: Pavee Hui <phui@google.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/audio/gusemu_mixer.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/audio/gusemu_mixer.c b/hw/audio/gusemu_mixer.c
index 341995cfd19e..8dc4a68386b4 100644
--- a/hw/audio/gusemu_mixer.c
+++ b/hw/audio/gusemu_mixer.c
@@ -133,11 +133,11 @@ void gus_mixvoices(GUSEmuState * state, unsigned int playback_freq, unsigned int
                 }
                 if ((GUSvoice(wVSRVolRampControl) & 0xa000) == 0xa000)  /* volramp IRQ set and enabled? */
                 {
-                    GUSregd(voicevolrampirq) |= 1 << Voice;             /* set irq slot */
+                    GUSregd(voicevolrampirq) |= 1U << Voice;            /* set irq slot */
                 }
                 else
                 {
-                    GUSregd(voicevolrampirq) &= (~(1 << Voice));        /* clear irq slot */
+                    GUSregd(voicevolrampirq) &= ~(1U << Voice); /* clear irq slot */
                     GUSvoice(wVSRVolRampControl) &= 0x7f00;
                 }
 
@@ -164,11 +164,11 @@ void gus_mixvoices(GUSEmuState * state, unsigned int playback_freq, unsigned int
                 }
                 if ((GUSvoice(wVSRControl) & 0xa000) == 0xa000)    /* wavetable IRQ set and enabled? */
                 {
-                    GUSregd(voicewavetableirq) |= 1 << Voice;      /* set irq slot */
+                    GUSregd(voicewavetableirq) |= 1U << Voice;      /* set irq slot */
                 }
                 else
                 {
-                    GUSregd(voicewavetableirq) &= (~(1 << Voice)); /* clear irq slot */
+                    GUSregd(voicewavetableirq) &= ~(1U << Voice); /* clear irq slot */
                     GUSvoice(wVSRControl) &= 0x7f00;
                 }
 

-- 
2.56.0.rc0.29.g47ce80527c56


