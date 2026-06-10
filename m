Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19315CD8CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 11:02:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXGdK-0002WV-G0; Wed, 10 Jun 2026 06:58:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXGdI-0002NH-CP
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 06:58:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXGdG-0006Tb-VQ
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 06:58:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781089082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bCFdaleLAqFZOybhIPB+08n2Tsh51f2ld96XW2TReag=;
 b=df2GW0QbMQCbsE0+Q6crBv+jY3+at8JphIkRdV9vGnoHZymDpJXSDRCuRAMwq3aZGzHWRE
 F/eQWv3dxBZZdKo3Osy4MtQ4BH2T6KHBUb5MKKZA8V/5bRsuUsywHB6g8sTAGSsccwabJv
 +6XU71JNb4zLd2l/M5jIIMbHgaFYCRM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-A9NWhNYlORuWDpXXgDyvxQ-1; Wed,
 10 Jun 2026 06:57:59 -0400
X-MC-Unique: A9NWhNYlORuWDpXXgDyvxQ-1
X-Mimecast-MFC-AGG-ID: A9NWhNYlORuWDpXXgDyvxQ_1781089077
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A6BAA19560A7; Wed, 10 Jun 2026 10:57:57 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5F5483000223; Wed, 10 Jun 2026 10:57:55 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 10 Jun 2026 14:56:49 +0400
Subject: [PATCH v2 07/22] ui/input: remove double-notification on
 qemu_mouse_set()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260610-ui-input-v2-7-f68452dd6a22@redhat.com>
References: <20260610-ui-input-v2-0-f68452dd6a22@redhat.com>
In-Reply-To: <20260610-ui-input-v2-0-f68452dd6a22@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Jan Kiszka <jan.kiszka@web.de>, Peter Maydell <peter.maydell@linaro.org>, 
 qemu-arm@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 qemu-ppc@nongnu.org, Thomas Huth <th.huth+qemu@posteo.eu>
X-Developer-Signature: v=1; a=openpgp-sha256; l=500;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=QKTfJXkiYTlclQdjxc806Ee/VaUL+ZAjxSUBDEqQqXU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqKUL/cORcNFDBPjM3siOoGK2aYZZLT6gQVlMKx
 XtnBLM2x7GJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCailC/wAKCRDa6OEJdZac
 5SN9D/oCQ7y1dObfroT6Nr69qN6gIvgru24qcVxlLrlxqO3INM5ZBHOExEcT5Ws/Ra/FAgWv+Kd
 mJTSAy+ZsfbvG0qvNZyVpSDNSJR8MCqr4Y4o3AORdXxD6AgJZ9W6gTLdCvA+gFSCkepeQjveQgf
 3bXKM2aQqOaHZl6tObBew2sUCIQxVJdrzJQuuZ5Cy7x8hdDFFnRufADz43/kro1FuLFPoZ7YGaP
 7wXg0QdDcBm2Z6YNG4GFMYFjVciKVcyY66JGWDfm9OjNYc0i2GuBc2nk4FpRFtJONIesbOOf28X
 +VmrHERU8JyP5lC+R8d0nnkjc+oBdhULCl232qruiCXxXw31eJQxZ9s57/vxwY3r5WbouW8+s7n
 bhVj6u3AmAd8Kqxa+kCUgTR04xo0pY23F8jKYGuWgkxoQoe8k72GbXDy5b+vtWd7vdqKNqXZsla
 EDs7foLSKSdzX3uy/W8J0c0JsHcattwQup/GoW1jolqj+Uu3V3OS113gkJ53GLDalCCwlqZ/HyQ
 L4ieGPrXNjn9VxblPvoF/JPCk5gBHsn6V/aiMx1BPck7LeuPKXesXGfqeU0q9/gQHo7jZ2gcCNS
 U8IVtrxjZNYiDM6SK82OqWne5ZGggKrf7wTT63mX5OE1dvTrqRboMoYgvgVjx5gQxngS53BxyI7
 tIKRASXmommTIVQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

qemu_input_handler_activate() already notifies.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/input.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/ui/input.c b/ui/input.c
index 55769c66fcc..15affeabf44 100644
--- a/ui/input.c
+++ b/ui/input.c
@@ -580,7 +580,6 @@ bool qemu_mouse_set(int index, Error **errp)
     }
 
     qemu_input_handler_activate(s);
-    notifier_list_notify(&mouse_mode_notifiers, NULL);
     return true;
 }
 

-- 
2.54.0


