Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55983CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 09:05:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB8Hc-0001Fn-Ma; Tue, 21 Oct 2025 05:03:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vB8Hb-0001Fb-SY
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 05:03:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vB8HX-0003uw-TJ
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 05:03:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761037430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oRJnHg9mCdPZO18IoDbCGbmaztLw98nZx1iDHyng678=;
 b=Wbh+xdzzMZV/SmokSJBcRYQXnWrVBF/riQchscfeP//7ao0dMqK63Z+yZC6ixC+14p0vIs
 lIZ6jEaBbz81YJRZM/7JBH3KCN9jtxfQk8oVZWGPaiWn2yqR4RqcARLzcu/DOs3bqCNhUs
 NJzuDoJrv8ymvbwHCtf9+6Ea1fo29lg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-JxEKliB3M_qqMYuJlpZM9w-1; Tue,
 21 Oct 2025 05:03:46 -0400
X-MC-Unique: JxEKliB3M_qqMYuJlpZM9w-1
X-Mimecast-MFC-AGG-ID: JxEKliB3M_qqMYuJlpZM9w_1761037425
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A3AEB19560B0; Tue, 21 Oct 2025 09:03:45 +0000 (UTC)
Received: from localhost (unknown [10.44.22.9])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2031F1955F22; Tue, 21 Oct 2025 09:03:43 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 04/43] hw/pcspk: use explicitly the required PIT types
Date: Tue, 21 Oct 2025 13:02:35 +0400
Message-ID: <20251021090317.425409-5-marcandre.lureau@redhat.com>
In-Reply-To: <20251021090317.425409-1-marcandre.lureau@redhat.com>
References: <20251021090317.425409-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/hw/timer/i8254.h | 4 ++--
 hw/audio/pcspk.c         | 2 +-
 hw/timer/i8254_common.c  | 6 ++----
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/include/hw/timer/i8254.h b/include/hw/timer/i8254.h
index 8402caad30..f7148d9286 100644
--- a/include/hw/timer/i8254.h
+++ b/include/hw/timer/i8254.h
@@ -75,7 +75,7 @@ static inline ISADevice *kvm_pit_init(ISABus *bus, int base)
     return d;
 }
 
-void pit_set_gate(ISADevice *dev, int channel, int val);
-void pit_get_channel_info(ISADevice *dev, int channel, PITChannelInfo *info);
+void pit_set_gate(PITCommonState *pit, int channel, int val);
+void pit_get_channel_info(PITCommonState *pit, int channel, PITChannelInfo *info);
 
 #endif /* HW_I8254_H */
diff --git a/hw/audio/pcspk.c b/hw/audio/pcspk.c
index 1b0cc08119..60cedcb375 100644
--- a/hw/audio/pcspk.c
+++ b/hw/audio/pcspk.c
@@ -50,7 +50,7 @@ struct PCSpkState {
     uint8_t sample_buf[PCSPK_BUF_LEN];
     QEMUSoundCard card;
     SWVoiceOut *voice;
-    void *pit;
+    PITCommonState *pit;
     unsigned int pit_count;
     unsigned int samples;
     unsigned int play_pos;
diff --git a/hw/timer/i8254_common.c b/hw/timer/i8254_common.c
index ad091594cd..419d4cd6e5 100644
--- a/hw/timer/i8254_common.c
+++ b/hw/timer/i8254_common.c
@@ -32,9 +32,8 @@
 #include "migration/vmstate.h"
 
 /* val must be 0 or 1 */
-void pit_set_gate(ISADevice *dev, int channel, int val)
+void pit_set_gate(PITCommonState *pit, int channel, int val)
 {
-    PITCommonState *pit = PIT_COMMON(dev);
     PITChannelState *s = &pit->channels[channel];
     PITCommonClass *c = PIT_COMMON_GET_CLASS(pit);
 
@@ -139,9 +138,8 @@ void pit_get_channel_info_common(PITCommonState *s, PITChannelState *sc,
     info->out = pit_get_out(sc, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
 }
 
-void pit_get_channel_info(ISADevice *dev, int channel, PITChannelInfo *info)
+void pit_get_channel_info(PITCommonState *pit, int channel, PITChannelInfo *info)
 {
-    PITCommonState *pit = PIT_COMMON(dev);
     PITChannelState *s = &pit->channels[channel];
     PITCommonClass *c = PIT_COMMON_GET_CLASS(pit);
 
-- 
2.51.0


