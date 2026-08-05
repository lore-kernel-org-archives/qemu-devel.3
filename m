Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2B39C55ABA
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 11:55:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wraDV-0003KT-Az; Wed, 05 Aug 2026 07:55:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wraDN-0003Am-Hl
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 07:55:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wraDM-0007Up-3H
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 07:55:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785930915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FVjmh4ZPE1CWjcfJbVY4ylfKXEB4Jlz+y9MOk8aUsqc=;
 b=gMThZG4Gksbk2yitQca030/BTj+4AjWiVBErGEqGpgVtHBIbz4DFk3YdQy6SLTdXWGPEHy
 X+A0bHrmUIsZeZD2vY8gSfy9sZUKwXuzqSzT66Mm9pxhyyGJyjo0w5pHJqlb/0DFp+K9Iy
 aSzi+EhymFFa93TYVpyFY866wTg8jcE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-481-fZ_4vwseMHGNl1i2s-LpOg-1; Wed,
 05 Aug 2026 07:55:09 -0400
X-MC-Unique: fZ_4vwseMHGNl1i2s-LpOg-1
X-Mimecast-MFC-AGG-ID: fZ_4vwseMHGNl1i2s-LpOg_1785930908
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 391301956049; Wed,  5 Aug 2026 11:55:08 +0000 (UTC)
Received: from localhost (unknown [10.44.22.2])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 862761800348; Wed,  5 Aug 2026 11:54:56 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 05 Aug 2026 15:51:12 +0400
Subject: [PATCH 22/27] hw/usb/dev-smartcard-reader: stop advertising PIN
 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260805-smartcard-fixes-v1-22-187ee9122441@redhat.com>
References: <20260805-smartcard-fixes-v1-0-187ee9122441@redhat.com>
In-Reply-To: <20260805-smartcard-fixes-v1-0-187ee9122441@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Zhao Liu <zhao1.liu@intel.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3066;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=srx5Y+nSZKFJAop3xtcxoY4v0msOUn8egihFkdC4xfs=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqcyOv5kGsUlvnW1Y7yJlPu+prhPHZXfCGmNUj+
 zE8PirdLtCJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCanMjrwAKCRDa6OEJdZac
 5SjCD/9vsSW70AWyQnXB+GxPLyTQvb85+6uoFtDU12FgMJkzehx2w7NkJ06b+jHbWQTIjGUYOzJ
 DZ7o1r2yH4y9Tq+l3nHhgM2ExLQFWFMv+5Da2jJGStRuKetvxVvEtHlaSWxvjvcL08bnCrM79XE
 JudcVVx6/CPmS+7dYCimPEtHbJQJyZGjq4n0y9ISzuBMSdvWhfvgQzgoL2VKnDV3BE8Q4kUlLlk
 LS53ffxmc9PeJa9mNMKCNHGizl58V15OVjlmgAX3eF5VMF9kSYq/qB6JKYjUrrGslU9ezUpdazk
 tiTYXQ58ExdJPTxOWqvRRZk42b4XMSj/mMuTQISaLaYq43SRFB831jtrKyDyrVxf3Qk0+iFc5od
 h1ZTPSPFkE9sS9ebMxxqbAMqm6UNDffX3+pUXDb6pZUFBa36zs1wpXQaVGDeFpW4mmfYlm99VLt
 dH1cGzs1/ETxptDXHg1Z35KUD6l8zlvS35gNSZ7A4TGEV9FNXxTlT0f+1TCMIRfCVQvc9+6+JeX
 6VNf2FlUFIRV/jZG9Cj/CXpsDqPL9i0xdkFG1o6g/8WmNpECFGKn1PGXZ7Drem/j3OfOwSmgJJy
 kisj7igy5M5+wuW88cICAfH3fjzyxulNVD+l/oKbCh/BFKakHbIiI75rqOXnCddXcMJdDjpVrFO
 t3A9dW3t49vLYZA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.852,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The CCID descriptor claims bPINSupport=1 (PIN Verification) but the
device does not implement it, returning CMD_NOT_SUPPORTED for Secure
commands. Stop advertising the capability by default, gated behind
an x-pin-support property for backward compatibility.

Fixes: 367071447ec5 ("usb-ccid: add CCID bus")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/core/machine.c             |  1 +
 hw/usb/dev-smartcard-reader.c | 12 +++++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 28842f53ae4f..790d947e28d1 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -52,6 +52,7 @@ GlobalProperty hw_compat_11_0[] = {
     { TYPE_ARM_SMMUV3, "oas", "44" },
     { "migration", "switchover-ack-legacy", "on" },
     { "usb-ccid", "x-accurate-message-length", "off" },
+    { "usb-ccid", "x-pin-support", "on" },
     { "usb-ccid", "x-migrate-pending-answers", "off" },
 };
 const size_t hw_compat_11_0_len = G_N_ELEMENTS(hw_compat_11_0);
diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index 65ceed57541a..a973a0396bb3 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -328,6 +328,7 @@ struct USBCCIDState {
     bool accurate_message_length;
     bool migrate_pending_answers;
     bool pending_answers_loaded;
+    bool pin_support;
 };
 
 static uint32_t ccid_bulk_in_pending_num(USBCCIDState *s)
@@ -436,10 +437,14 @@ static uint8_t qemu_ccid_descriptor[] = {
                      * u16 wLcdLayout; XXYY Number of lines (XX) and chars per
                      * line for LCD display used for PIN entry. 0000 - no LCD
                      */
-        0x01,       /*
+                    /*
                      * u8  bPINSupport; 01h PIN Verification,
                      *                  02h PIN Modification
+                     *
+                     * Corrected to 0 when !x-pin-support
                      */
+#define CCID_DESC_OFFSET_B_PIN_SUPPORT 52
+        0x01,
         0x01,       /* u8  bMaxCCIDBusySlots; */
 };
 
@@ -1498,6 +1503,9 @@ static void ccid_realize(USBDevice *dev, Error **errp)
         stl_le_p(&qemu_ccid_descriptor[CCID_DESC_OFFSET_DW_MAX_MSG_LEN],
                  BULK_IN_BUF_SIZE);
     }
+    if (!s->pin_support) {
+        qemu_ccid_descriptor[CCID_DESC_OFFSET_B_PIN_SUPPORT] = 0;
+    }
     usb_desc_create_serial(dev);
     usb_desc_init(dev);
     qbus_init(&s->bus, sizeof(s->bus), TYPE_CCID_BUS, DEVICE(dev), NULL);
@@ -1692,6 +1700,8 @@ static const Property ccid_properties[] = {
     DEFINE_PROP_UINT8("debug", USBCCIDState, debug, 0),
     DEFINE_PROP_BOOL("x-accurate-message-length", USBCCIDState,
                      accurate_message_length, true),
+    DEFINE_PROP_BOOL("x-pin-support", USBCCIDState,
+                     pin_support, false),
     DEFINE_PROP_BOOL("x-migrate-pending-answers", USBCCIDState,
                      migrate_pending_answers, true),
 };

-- 
2.55.0


