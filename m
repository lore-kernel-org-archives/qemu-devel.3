Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7CC1CD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 11:02:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXGeM-0005Z0-8r; Wed, 10 Jun 2026 06:59:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXGeJ-0005XZ-SS
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 06:59:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXGeG-00085t-SC
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 06:59:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781089138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1nNc/INcsPpcggiUKdGL+v67fCZIsx+PXcGTnYiRPMc=;
 b=CwIGOR2XxxrgoDdnjjc46i8nXIAw4t2vGk31nO2Xu2xse3c+oeKe3Mr5XrRJHNW3Dch8hw
 rsYOih6gG11DrNr280aAIkvDrZsPecCuuJ/Msl9zrnDjsVO9ZBvzodWknuiBwe3jY3UwbS
 5r76ZFpT2xGZ8U3Nuh3GFjldKGQx6s4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-568-605Qza7aNWim6xvbo3x1SQ-1; Wed,
 10 Jun 2026 06:58:53 -0400
X-MC-Unique: 605Qza7aNWim6xvbo3x1SQ-1
X-Mimecast-MFC-AGG-ID: 605Qza7aNWim6xvbo3x1SQ_1781089132
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DA08A1955F03; Wed, 10 Jun 2026 10:58:51 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9CE3A1954B09; Wed, 10 Jun 2026 10:58:50 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 10 Jun 2026 14:56:58 +0400
Subject: [PATCH v2 16/22] hw/input/ps2: use qemu_input_handler_set_led()
 for LED state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260610-ui-input-v2-16-f68452dd6a22@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=857;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=t0Z9m7c1Hh+44awYmkSHssaygTyzyWH8QlSLYI/LQak=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqKUMBG8zmOISnd7VW9MlSn1iZ8LWN7sOPAM/3y
 dQvUZbFUjuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCailDAQAKCRDa6OEJdZac
 5SMpEACqqodu+0ONuWm685xBWMXATOAOD/IGoAuTq3hXyGog6kRUhBgx2a5mB0E7nN3NFE7o+j0
 3MjfDM9G/9X87BdgQQwUjg69DK++vFGyqKuSKeb0T3slv4V6qs/CEgTLcFaL0IJgmqKyeCbHWR3
 sqpKE+ROfrbcfwxXJX3DqUyQ9IyrDkbDMkOt9W2r4Llm3Z7zidUH591K2XmsGZiLf+CAK8XPHky
 aGnK50oPR5vpfCLHji+22YjuIJ5fPqeH7QWYiuOo98rxYxbQgr3Xo1BjZYgXHN9HInVj5Sgjrzo
 /ONOZbANJVfoYLsi9z6nBjrZ5vWgsNeHlY1vEjugvCxJXac6cqx0tCCa+7QD7dUqcBV98rYj4Vo
 /OCopKpLkCGTIaYVdh1PI/4qiLFLjZom6JdFiz7EF2I1XrpdkgC1vc2Es0hrxDQP6WRmx9DZw8C
 DjTwxbA1L1heicsbUyZuuMT3nWn+5ZnhkL1JPmx+irROt6lSdFMqORSBu5zSMI+bKwIcCWbuhHa
 M550Wa8T5o3YkLgrm5Si6MkDT3REdWYInn1q1UngTRNUwsznHt08RwTnaBzj/MpEKSo+QwBCbhE
 LJOqoBS0tQO47grFDYPrt5QPy6x5/iClQditDojuhQ+OToCRzjMGiQx2l8mRXjaDsZRtCODcu2V
 7f6ux3tOj1kO6Bw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/input/ps2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/input/ps2.c b/hw/input/ps2.c
index 97df7a9a43e..7fbee17fbf0 100644
--- a/hw/input/ps2.c
+++ b/hw/input/ps2.c
@@ -577,7 +577,7 @@ static void ps2_set_ledstate(PS2KbdState *s, int ledstate)
 {
     trace_ps2_set_ledstate(s, ledstate);
     s->ledstate = ledstate;
-    kbd_put_ledstate(ledstate);
+    qemu_input_handler_set_led(PS2_DEVICE(s)->hs, ledstate);
 }
 
 static void ps2_reset_keyboard(PS2KbdState *s)
@@ -1108,7 +1108,7 @@ static int ps2_kbd_ledstate_post_load(void *opaque, int version_id)
 {
     PS2KbdState *s = opaque;
 
-    kbd_put_ledstate(s->ledstate);
+    qemu_input_handler_set_led(PS2_DEVICE(s)->hs, s->ledstate);
     return 0;
 }
 

-- 
2.54.0


