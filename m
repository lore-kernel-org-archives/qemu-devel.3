Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2DB6CA5FF4
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 10:29:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDJPv-00008N-4X; Sun, 04 Oct 2026 06:26:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJPn-00084l-Kp
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:25:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJPm-0003ME-4P
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:25:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791109549;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v7jEYCR/mC53ka0TTYImY10mCLnH7g9o9Mqn0hV6SjM=;
 b=XCaWqHJx/F9m4PRaA8ljeh48c/AjTTC9uhzf5ZY6uGwRNF4SoyHrFy6Mb1GCgiW2K5MU/3
 ssL4k0DtAURJRtqvFDiL8uRE72U1dr06fbGff9FcWi3Yw9wkzJ+3/EEVE6iSqmGOub1Op3
 bYat9zb1BSNvqNWOFBcXI2qWH2wu2jk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-YkROmC9QNcuoEz4SlCjt8A-1; Sun,
 04 Oct 2026 06:25:43 -0400
X-MC-Unique: YkROmC9QNcuoEz4SlCjt8A-1
X-Mimecast-MFC-AGG-ID: YkROmC9QNcuoEz4SlCjt8A_1791109542
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5C626180066A; Sun,  4 Oct 2026 10:25:42 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 56DE530000E5; Sun,  4 Oct 2026 10:25:40 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 04 Oct 2026 14:23:49 +0400
Subject: [PATCH 35/63] hw/char/serial: clamp zero baud rate to default
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261004-issue-4560-v1-35-ccbef537cbeb@redhat.com>
References: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
In-Reply-To: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Pavee Hui <phui@google.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1091;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=vsQoA3BaJ5Stp6dqcL470I15kWLJbT1SEj2XLBw+imY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqwikjwF5ywqa2+GRirko6CTEQ3+4XAy2ALMxsL
 ZRySg0aQkeJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCasIpIwAKCRDa6OEJdZac
 5dZkD/9iG2+Tmw6E1S2G/Fx32JjEke+tlwaXRUrSZ5RGmodIx/eeEGFnB9UE8LGzoGRx+UTny4p
 Mj69l+K95rZr/55wi46we9iW3rRh9kT5KhncvX4Uq6k63MRjG1ugnr3eFp7IjB+QSdOIHwYdtu+
 nOZtWt/UQuMU7jRMmmtsLBgJrpT2nXCqqmAuLna0Wfih4Il38ZLrHz0cxO05X50UASTncN3jnJl
 V15rd7dXtkq4tUvohx+EO/GQZdggf/Pp2lv1vM8omdGmWrXKE7oObsIB6+14ZaCPiHHOiAJZlB3
 iXQgLXUb6O6K4h/X/QDR+hS5w9HkHFfHU0TQuaEv2heWkEiKq1EZnTwY9Hb+lH5jAHUB+e6Q83Q
 oh9kjdum6F0r0aEObjSpVYNv0y9a6P5QrwUn2/yfcGJh0HNj3N7yOsTF2rAw+/XnAH5ox354eRC
 y8LfJqiM4ugRgIB5PkLrzy7R0C1I646wO2D2UiLnmwYqJQO8m0wy8GzvgfR+gk7UduG2VAPd7Iz
 fucwqrv82tITKWOq3zLE3MURSSPSSZF2Qt6ohgPZfhyTT3zykcX1Wy6sA/4MY9uzgkKU7t+vzWe
 5+M4Hr+GacZ49EysndujHBVdVb9y0YhoDtaUKtY5LGeem+O702btftpLLN0IkkDdZhQ/iH+rPlI
 cjbnyZhNaf+31gQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

When baudbase is zero (e.g. not yet configured), the division baudbase /
divider produces zero. This results in NANOSECONDS_PER_SECOND / speed
yielding infinity, making char_transmit_time infinite and stalling
transmission.

Fall back to the same 3500 baud default used for a zero divisor.

Fixes: 96651db423a0 ("serial: add "baudbase" property")
Reported-by: Pavee Hui <phui@google.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/char/serial.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/char/serial.c b/hw/char/serial.c
index 4339562ab003..44bf9fa0b25b 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -178,6 +178,9 @@ static void serial_update_parameters(SerialState *s)
     frame_size += data_bits + stop_bits;
     /* Zero divisor should give about 3500 baud */
     speed = (s->divider == 0) ? 3500 : (float) s->baudbase / s->divider;
+    if (speed <= 0) {
+        speed = 3500;
+    }
     ssp.speed = speed;
     ssp.parity = parity;
     ssp.data_bits = data_bits;

-- 
2.56.0.rc0.29.g47ce80527c56


