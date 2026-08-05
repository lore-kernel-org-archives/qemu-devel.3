Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB3FEC55ABA
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 11:55:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wraDi-00045y-Mu; Wed, 05 Aug 2026 07:55:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wraDg-0003pw-NX
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 07:55:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wraDe-0007Wx-Oa
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 07:55:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785930933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JJYSed4bMpJL/q0dbriaVvyhdgepiiOHGbaEnAQQr7g=;
 b=eoe01yEcK/L7kv3Odc1PNBMWJdk9oGEC54OVtUbxiBpAGZUSRxVhInEfQBiwcj9bnhmElq
 pGRzHMwtSp10bdzSR8N+D34ZHS6RiRYrJ7cFdhnNMyjNYwm6RwMZDJ+pgarqmdi1JK+Q29
 FdlngbpF/E0cHodMw0RLMaDixpHyNyk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-602-ITYTV0q3OYqNF9I9hWgtrQ-1; Wed,
 05 Aug 2026 07:55:32 -0400
X-MC-Unique: ITYTV0q3OYqNF9I9hWgtrQ-1
X-Mimecast-MFC-AGG-ID: ITYTV0q3OYqNF9I9hWgtrQ_1785930931
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 59AD818004A9; Wed,  5 Aug 2026 11:55:31 +0000 (UTC)
Received: from localhost (unknown [10.44.22.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D5301180034C; Wed,  5 Aug 2026 11:55:28 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 05 Aug 2026 15:51:15 +0400
Subject: [PATCH 25/27] hw/usb/dev-smartcard-reader: advertise T=1 protocol
 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260805-smartcard-fixes-v1-25-187ee9122441@redhat.com>
References: <20260805-smartcard-fixes-v1-0-187ee9122441@redhat.com>
In-Reply-To: <20260805-smartcard-fixes-v1-0-187ee9122441@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Zhao Liu <zhao1.liu@intel.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3619;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=BsrL+0MBSMaMusNeetvdAGYiszIG6+E8WKFChzY874I=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqcyOvcb23HUT6JZsyVXSbwEIoyGPdOpSIYQFZo
 nwQ96ouETOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCanMjrwAKCRDa6OEJdZac
 5VIcD/wIGK5zaslJXmWVyQ6Gdv5yc99MW/27aOw5Nv7y4NKcXehckgJAdpovIfskORQeforNl8E
 wuLM41ce7o+kqQN3fLcthZydiq5pzcvOCjBRJJCBckEHYYx3FKkdzhJf++pE8TRMRRdXt83EmRv
 w4CMA4Ztr/CwNfDFo33pnj1aLa3RMScjT5ExZNPHe65uLgTAr1GiMGmsVBloZwoqAxzPU/jzzxZ
 ikXkjtC2PcXOgO2JqUdP/SxkX6eMJh2JMWfgwDi1RZTMtfpSABZZV9YRFCjOD8lxhtIfG4h5otn
 tasIuwnpSvP9TefoKaz9semk45S3fISh+5BTGhTrFFiPzNU2M6kAAR9mVQC6/Qws56UiWCtkJqf
 wr+JSIm1IIapjjs6r8aIFfpVKnlnRcygv/s0hWgugmBm1bOi75GzBMOVgh3L6Da43h+AadzrQod
 QrL1mLadjbZbsye6XIuYGE+P1L1MnncdOYAiVdS659necfOH9T5CASBzP2Wa/KERt3Q0GF/81kq
 CcuQIPfoQo2ccxpGWO8kA96oqmGSBeeeU0qKc93r2lFpudJTBq2/E1k92Agt6LcAgie7pVenbKi
 RIyxGIYGbuuk48MW3CAEWitrof2L/VSmCh9e0yOIMM4xjUriyqTeFe+yOg1Tk1x0JRa67obiyCH
 eabQIq6uQv5N25g==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.852,
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

The CCID descriptor only advertised T=0, but it actually handles t=1
since it shuttles framed blocks to the backend. libcacard advertized T=0
in the ATR, so it works fine. This allows passthrough cards to work
at t=1 if they need to.

Add a configurable property to also advertise T=1 in the dwProtocols
field, enabled by default.

Use the correct error code (7, ICC protocol not supported) instead
of CMD_NOT_SUPPORTED when SetParameters receives an invalid protocol.

Note: I only tested with libcacard emulation.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/core/machine.c             |  1 +
 hw/usb/dev-smartcard-reader.c | 10 +++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 790d947e28d1..e9fecdec18df 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -53,6 +53,7 @@ GlobalProperty hw_compat_11_0[] = {
     { "migration", "switchover-ack-legacy", "on" },
     { "usb-ccid", "x-accurate-message-length", "off" },
     { "usb-ccid", "x-pin-support", "on" },
+    { "usb-ccid", "x-t1-support", "off" },
     { "usb-ccid", "x-migrate-pending-answers", "off" },
 };
 const size_t hw_compat_11_0_len = G_N_ELEMENTS(hw_compat_11_0);
diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index 8520a2dab216..99086befe0b8 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -169,6 +169,7 @@ enum {
     ERROR_CMD_SLOT_BUSY     = -32,
     ERROR_BAD_DWLENGTH      = 1,
     ERROR_SLOT_NOT_EXIST    = 5,
+    ERROR_PROTOCOL_INVALID  = 7,
 };
 
 /* 6.2.6 RDR_to_PC_SlotStatus definitions */
@@ -330,6 +331,7 @@ struct USBCCIDState {
     bool migrate_pending_answers;
     bool pending_answers_loaded;
     bool pin_support;
+    bool t1_support;
 };
 
 static uint32_t ccid_bulk_in_pending_num(USBCCIDState *s)
@@ -368,6 +370,7 @@ static uint8_t qemu_ccid_descriptor[] = {
                      */
         0x07,       /* u8  bVoltageSupport; 01h - 5.0v, 02h - 3.0, 03 - 1.8 */
 
+#define CCID_DESC_OFFSET_DW_PROTOCOLS 0x06
         0x01, 0x00, /* u32 dwProtocols; RRRR PPPP. RRRR = 0000h.*/
         0x00, 0x00, /* PPPP: 0001h = Protocol T=0, 0002h = Protocol T=1 */
                     /* u32 dwDefaultClock; in kHZ (0x0fa0 is 4 MHz) */
@@ -968,7 +971,7 @@ static void ccid_set_parameters(USBCCIDState *s, CCID_Header *recv)
     uint32_t protocol_num = ph->bProtocolNum & 3;
 
     if (protocol_num != 0 && protocol_num != 1) {
-        ccid_report_error_failed(s, ERROR_CMD_NOT_SUPPORTED);
+        ccid_report_error_failed(s, ERROR_PROTOCOL_INVALID);
         return;
     }
     s->bProtocolNum = protocol_num;
@@ -1546,6 +1549,9 @@ static void ccid_realize(USBDevice *dev, Error **errp)
     if (!s->pin_support) {
         qemu_ccid_descriptor[CCID_DESC_OFFSET_B_PIN_SUPPORT] = 0;
     }
+    if (s->t1_support) {
+        qemu_ccid_descriptor[CCID_DESC_OFFSET_DW_PROTOCOLS] |= 0x2;
+    }
     usb_desc_create_serial(dev);
     usb_desc_init(dev);
     qbus_init(&s->bus, sizeof(s->bus), TYPE_CCID_BUS, DEVICE(dev), NULL);
@@ -1742,6 +1748,8 @@ static const Property ccid_properties[] = {
                      accurate_message_length, true),
     DEFINE_PROP_BOOL("x-pin-support", USBCCIDState,
                      pin_support, false),
+    DEFINE_PROP_BOOL("x-t1-support", USBCCIDState,
+                     t1_support, true),
     DEFINE_PROP_BOOL("x-migrate-pending-answers", USBCCIDState,
                      migrate_pending_answers, true),
 };

-- 
2.55.0


