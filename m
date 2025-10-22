Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19186CCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 06:59:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBSmW-00086i-30; Wed, 22 Oct 2025 02:57:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vBSmT-00086S-Vp
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 02:57:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vBSmS-00081n-Cx
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 02:57:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761116227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vG50Cp8jXs+Vv6N4renrVb1ftJ7mwjUTNPnbXKcw4pg=;
 b=C3Mln2BN4PNh03Enj2FNkKAmtoNtcZLG3gCAsy1Yto/sfFaltfy+QvOTmn0DjnpIazzvuk
 PeLNoHdH5Q+TW6AOn5i184T1Qd581e+eEn/NmOa63RJygHPFN+mQ9Y+Rfdh5GESAUH3MxD
 xzKSLbnsjKAlpzm7WIUpUrNIg2HUQz8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-685-kc6obWqjOoOAQGmuKWAwuA-1; Wed,
 22 Oct 2025 02:57:03 -0400
X-MC-Unique: kc6obWqjOoOAQGmuKWAwuA-1
X-Mimecast-MFC-AGG-ID: kc6obWqjOoOAQGmuKWAwuA_1761116222
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 83EB819560AD; Wed, 22 Oct 2025 06:57:02 +0000 (UTC)
Received: from localhost (unknown [10.44.22.9])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 14C68180035A; Wed, 22 Oct 2025 06:57:00 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2 03/42] hw/audio: remove global pcspk
Date: Wed, 22 Oct 2025 10:55:58 +0400
Message-ID: <20251022065640.1172785-4-marcandre.lureau@redhat.com>
In-Reply-To: <20251022065640.1172785-1-marcandre.lureau@redhat.com>
References: <20251022065640.1172785-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

It is no longer used since commit 6033b9ecd4 ("pc: remove -soundhw pcspk")

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/audio/pcspk.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/audio/pcspk.c b/hw/audio/pcspk.c
index a419161b5b..1b0cc08119 100644
--- a/hw/audio/pcspk.c
+++ b/hw/audio/pcspk.c
@@ -60,7 +60,6 @@ struct PCSpkState {
 };
 
 static const char *s_spk = "pcspk";
-static PCSpkState *pcspk_state;
 
 static inline void generate_samples(PCSpkState *s)
 {
@@ -192,8 +191,6 @@ static void pcspk_realizefn(DeviceState *dev, Error **errp)
     if (s->card.state && AUD_register_card(s_spk, &s->card, errp)) {
         pcspk_audio_init(s);
     }
-
-    pcspk_state = s;
 }
 
 static bool migrate_needed(void *opaque)
@@ -229,7 +226,6 @@ static void pcspk_class_initfn(ObjectClass *klass, const void *data)
     set_bit(DEVICE_CATEGORY_SOUND, dc->categories);
     dc->vmsd = &vmstate_spk;
     device_class_set_props(dc, pcspk_properties);
-    /* Reason: realize sets global pcspk_state */
     /* Reason: pit object link */
     dc->user_creatable = false;
 }
-- 
2.51.0


