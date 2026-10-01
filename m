Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFDBBCA5FD2
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 13:34:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCGv2-00034M-88; Thu, 01 Oct 2026 09:33:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCGsS-0008QQ-TP
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 09:31:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCGsP-0006Qk-Oj
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 09:31:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790861469;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bKw6fkq7NI7n/7XJwVwBUUecKUqBRGB1AOlajcKyMQ8=;
 b=JjyFXnvgQVJJBMapORqJi5Rquo846XxBaI9RMtd3GXhpbH9qEP8CYa+Jqxs9i7s1fd50R3
 48o7Xq9XAdfKOoQGgQexwUgRsrtsFaYTjKyW30/wnLsSS92i7l4I12/1Gf7wftWmqa4X+Q
 DHMDhwy8DJPtHBZzg3TKeaFslRdCngg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-FGGwCB7_OpWTnBx-G9i5WA-1; Thu,
 01 Oct 2026 09:31:04 -0400
X-MC-Unique: FGGwCB7_OpWTnBx-G9i5WA-1
X-Mimecast-MFC-AGG-ID: FGGwCB7_OpWTnBx-G9i5WA_1790861463
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 67C9E185588D; Thu,  1 Oct 2026 13:31:03 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9BD0C30000E6; Thu,  1 Oct 2026 13:31:02 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 01 Oct 2026 17:30:01 +0400
Subject: [GIT PULL 22/27] hw/usb/dev-smartcard-reader: stop advertising PIN
 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261001-smartcard-fixes-v1-22-ebb5a40dd497@redhat.com>
References: <20261001-smartcard-fixes-v1-0-ebb5a40dd497@redhat.com>
In-Reply-To: <20261001-smartcard-fixes-v1-0-ebb5a40dd497@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Zhao Liu <zhao1.liu@intel.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3148;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=wjdQd/MOl1N5vuQvFluSxxpU2EXe4n1TUXXXwQA5c9Q=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqvmBIzTHur2g/HmCzGFYPvcfwFNL/0em2s6WSE
 WNBIxfeTBuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCar5gSAAKCRDa6OEJdZac
 5S0RD/sGJZMqqHL3WHNVFDtwmy8XRobHt/FBtkysYaWsRjWMHt5VPvIeMpEciSABsM5++/8mbmg
 a4OfemJ/LSqU681xFjRVqWIGPYkUiIWIQd+c6O+CBkzeNhPOi+0hiBDmcNngF+oKVvDtsLFrHC1
 PoaPBt/fiaIl9Zmrzx1rIFGlLSs0UCQ6FUmSnsMlS2NinfqPnYWlsYKaACpipZjoYUcX5KMlO23
 0+fbGRgtmF6ElCaoyLN6GdAtHgkcW8WKacoVBjQ4kX6U7BjlIqRfBlTdpQ/5URo14IUDNwuQ5L8
 Zq4Fsxu9USRL8QOs4JM/7Q0awRl1RP9bAKFtXNijXAXJpEvYlDey+6GC+ZZ6ZoOd2QjU4HlXuGM
 VGlwg6uRCKz2tEjyWOJ3dSLwRxvY2nhaTy6idB0Z7WQ9EJuh8HgoGI0s7qhYNSs68cmRwiasn8q
 0pKB5ocaB7v9Mfq1LV3S+iWguuW9Zwpdu3C+pwGpe0za0El7qyoUj0LeUPhng/UBIM1YKfzQ5NS
 zt7bR4iS/ohO6eXCMOz6fmNStm3XlxiQ15JepEPMOwEIAWpBFOQzZuIElICbcxKUt2RGYDQH9/1
 F+RrKKt1ETgHIxlMdtaShSA0TT/adIl4wFu4oR7+tT5LIpVMB9Ilwb8mv6ZLNySyp+rYu55ueO+
 bYG8EeRP6pQUOlQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.331,
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

The CCID descriptor claims bPINSupport=1 (PIN Verification) but the
device does not implement it, returning CMD_NOT_SUPPORTED for Secure
commands. Stop advertising the capability by default, gated behind
an x-pin-support property for backward compatibility.

Fixes: 367071447ec5 ("usb-ccid: add CCID bus")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Acked-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/core/machine.c             |  1 +
 hw/usb/dev-smartcard-reader.c | 12 +++++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 4aa5df13f386..a5a168d72521 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -58,6 +58,7 @@ GlobalProperty hw_compat_11_0[] = {
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
2.56.0.rc0.29.g47ce80527c56


