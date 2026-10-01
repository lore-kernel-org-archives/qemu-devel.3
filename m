Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE99FCA5FD9
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 13:31:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCGsn-0000cu-7k; Thu, 01 Oct 2026 09:31:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCGrg-0007eF-9Q
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 09:30:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCGrc-0006JJ-Lf
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 09:30:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790861420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lWIBM2ZXglrUd23kFWRLvq7k6UftDx6q5rDXK/b5cnA=;
 b=jSEHuB923yf53WVu6txkoeZKIFXYC5O4l03NGL4fZjInZ/G3G+KfOKKIRtvlTgO2CjBg8W
 POb1eeXkgMRHSW3HjhGryI2FChe16VPYW1Tb/xF7Sgp2fVphEHY7GHY0ePGqqoicDoGX3d
 Ncz3GkOaFanyk5+R4fkq/Ec/8MlIrr8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661-kRzXFf1VOXqoQGORLR45kw-1; Thu,
 01 Oct 2026 09:30:17 -0400
X-MC-Unique: kRzXFf1VOXqoQGORLR45kw-1
X-Mimecast-MFC-AGG-ID: kRzXFf1VOXqoQGORLR45kw_1790861416
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7FC3019056A4; Thu,  1 Oct 2026 13:30:16 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B669C1956089; Thu,  1 Oct 2026 13:30:15 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 01 Oct 2026 17:29:47 +0400
Subject: [GIT PULL 08/27] hw/usb/dev-smartcard-reader: drop needless state
 fields
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261001-smartcard-fixes-v1-8-ebb5a40dd497@redhat.com>
References: <20261001-smartcard-fixes-v1-0-ebb5a40dd497@redhat.com>
In-Reply-To: <20261001-smartcard-fixes-v1-0-ebb5a40dd497@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1845;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=r7pycVW+de2Q6cGfmcDBWH+eQJ2goLJcJrX/ILjk4wQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqvmBH3i8UFV6rhTCSD4NKaxWeFLkCq6h5pFRxp
 3XNGmbhy5GJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCar5gRwAKCRDa6OEJdZac
 5W71D/4wZrmN2MryOChXeloL6t0fKhQtnTvpo6VMPVwiY4lnnmZsfhKvzAbow9G7oXcsXsuTqf9
 8jMHENnZKgruJmky88Z1s0evIqB5fEdz5SWEPKjEHN8GjmL4ojSfganCPJZ2BxdI3ZYWfmbII5s
 NgbgR/O+xhy0R2B/w0/jEqm3geQuF5Lviu1gMaBxnPD8p4VYraVEmdg9R6dKWEOn89d1tTGY7NU
 Bq+6L30jE7z5ufp0bsgWOZ7XAhNsVaABUHwq0rnVSrx0UPgjEj/zxFW2beZtufObP0jHkATcfTy
 +uAtNYJLCaf/xF0qTshIhcSfsPCNyaUa3i0ivoLJdb38K9PoSmZtnutoZIhwfPMQZIeiySvtitU
 Yix40QPt/c1I2W+0Ib4Os1zhyvxjvBixKjHtVYedxNVaqUjpc/uTpnz2RasitkhWyMftso6fUfH
 m1ed6zpVVAyC8va3B0FaRVS61ESVu00xs6Q5vlRVwMku9GlrZnU+ZClWyfPsVdr2+rdjshECCcr
 47Dhqvaxb549lj8a/JKSbAA9seU23DJFCQVk0mMMCaNh7zp4SwVxMCaRWadjiJQVuPs47OQWw1C
 JpcsQwX/0JznbcsLvmv3z87OSXGW9DYPE//ejD5+mcOgzhCRjIv6rQKc6v0SCe96fge/sDe6EDv
 hNZtKNlLA8In9Ug==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.331,
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

The field is never used, it could potentially do break on malicious
migration stream.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Acked-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/usb/dev-smartcard-reader.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index 786d5217a95a..0201b994f9c2 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -308,7 +308,6 @@ struct USBCCIDState {
     uint8_t  bmCommandStatus;
     uint8_t  bProtocolNum;
     CCID_ProtocolDataStructure abProtocolDataStructure;
-    uint32_t ulProtocolDataStructureSize;
     uint32_t state_vmstate;
     uint8_t  bmSlotICCState;
     uint8_t  powered;
@@ -766,9 +765,8 @@ static void ccid_write_slot_status(USBCCIDState *s, CCID_Header *recv)
 static void ccid_write_parameters(USBCCIDState *s, CCID_Header *recv)
 {
     CCID_Parameter *h;
-    uint32_t len = s->ulProtocolDataStructureSize;
 
-    h = ccid_reserve_recv_buf(s, sizeof(CCID_Parameter) + len);
+    h = ccid_reserve_recv_buf(s, sizeof(CCID_Parameter));
     if (h == NULL) {
         return;
     }
@@ -1451,7 +1449,7 @@ static const VMStateDescription ccid_vmstate = {
         VMSTATE_UINT8(bmCommandStatus, USBCCIDState),
         VMSTATE_UINT8(bProtocolNum, USBCCIDState),
         VMSTATE_BUFFER(abProtocolDataStructure.data, USBCCIDState),
-        VMSTATE_UINT32(ulProtocolDataStructureSize, USBCCIDState),
+        VMSTATE_UNUSED(4), /* was ulProtocolDataStructureSize */
         VMSTATE_STRUCT_ARRAY(bulk_in_pending, USBCCIDState,
                        BULK_IN_PENDING_NUM, 1, bulk_in_vmstate, BulkIn),
         VMSTATE_UINT32(bulk_in_pending_start, USBCCIDState),

-- 
2.56.0.rc0.29.g47ce80527c56


