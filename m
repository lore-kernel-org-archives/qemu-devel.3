Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14FCCCCD1A5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 09:07:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB8Hs-0001Is-4l; Tue, 21 Oct 2025 05:04:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vB8Hn-0001I2-WC
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 05:04:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vB8Hk-0003vu-2H
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 05:04:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761037443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DuHgBn6v7c8UQAR8rBWZJ/UAAtSM19kE3jiv1Od/ysc=;
 b=EA0FiXc56iTwKKOJbnMP3FbtofsIr6BNRImLmaybeBQuWEPGfPEC3Y/ApGjIdiaWarsmXE
 E/GK4hqrLn4t1A/F2JR9m+g4mjaH1O6x0+vXA/JGt5c+soBcB3dIu9raDodYbB+VggK9Q4
 S0R67eB+XS5I0LdJdxCSIWHa/0T8blY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-296-l5oIt6scPMmxfuT148O56w-1; Tue,
 21 Oct 2025 05:03:57 -0400
X-MC-Unique: l5oIt6scPMmxfuT148O56w-1
X-Mimecast-MFC-AGG-ID: l5oIt6scPMmxfuT148O56w_1761037436
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 565C518002EC; Tue, 21 Oct 2025 09:03:56 +0000 (UTC)
Received: from localhost (unknown [10.44.22.9])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 02FAB180057C; Tue, 21 Oct 2025 09:03:54 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 06/43] hw/pcspk: check the "pit" is set
Date: Tue, 21 Oct 2025 13:02:37 +0400
Message-ID: <20251021090317.425409-7-marcandre.lureau@redhat.com>
In-Reply-To: <20251021090317.425409-1-marcandre.lureau@redhat.com>
References: <20251021090317.425409-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

We don't let the user create a "isa-pcspk" via -device yet (in theory,
we could, and fallback on a lookup PIT), but we can add some safety
checks that the property was correctly set nonetheless.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/audio/pcspk.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/audio/pcspk.c b/hw/audio/pcspk.c
index 40572241cb..8ea3a161a4 100644
--- a/hw/audio/pcspk.c
+++ b/hw/audio/pcspk.c
@@ -181,6 +181,11 @@ static void pcspk_realizefn(DeviceState *dev, Error **errp)
     ISADevice *isadev = ISA_DEVICE(dev);
     PCSpkState *s = PC_SPEAKER(dev);
 
+    if (!s->pit) {
+        error_setg(errp, "pcspk: No \"pit\" set or available");
+        return;
+    }
+
     isa_register_ioport(isadev, &s->ioport, s->iobase);
 
     if (s->card.state && AUD_register_card(s_spk, &s->card, errp)) {
-- 
2.51.0


