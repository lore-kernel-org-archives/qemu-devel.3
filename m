Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E8C6CA5FD9
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 13:34:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCGtl-0002Na-1F; Thu, 01 Oct 2026 09:32:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCGsf-0000G8-3J
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 09:31:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCGsd-0006SC-KS
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 09:31:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790861483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ofML6BJ95Ba4YzYEQVrCMCG9cao+U7lAMJ/mDJt7Cqs=;
 b=dHpVsVVTHR5KbYNSWmBiFNAE8z06xvZR3xbWOKSfmaqFGuBdi6FMp/6fLeM87+CHchAgdk
 XepNT5XhQefoSmfWMvwndNEOYRON9fXt2DjR0WJ7DFSLCh4+QHkbeCtdt1uYo6sNDXPStT
 5BCZtCRuo/bX+cCN7Z+cpvJBJRmrlHs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-550-cd20zX97NYKC1o47Zq3cSw-1; Thu,
 01 Oct 2026 09:31:18 -0400
X-MC-Unique: cd20zX97NYKC1o47Zq3cSw-1
X-Mimecast-MFC-AGG-ID: cd20zX97NYKC1o47Zq3cSw_1790861476
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 716A3195394D; Thu,  1 Oct 2026 13:31:16 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A5F7D1956095; Thu,  1 Oct 2026 13:31:15 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 01 Oct 2026 17:30:05 +0400
Subject: [GIT PULL 26/27] hw/usb/dev-smartcard-reader: correct CCID_IccPowerOff
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261001-smartcard-fixes-v1-26-ebb5a40dd497@redhat.com>
References: <20261001-smartcard-fixes-v1-0-ebb5a40dd497@redhat.com>
In-Reply-To: <20261001-smartcard-fixes-v1-0-ebb5a40dd497@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=805;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=7RhYZdLE06FM7tYKFfMTkTMhWgTFc0CmbaCJDELrgqU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqvmBJVArRG2BtnZ2iJ/WKAQol+1HjcrgqNBx7t
 zz6oJMUVueJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCar5gSQAKCRDa6OEJdZac
 5XpyEACYk1efv87x438mCRlzd9jh7baLzvL9eYqziBNEeS58SZMQF5b+Ey8lItUoUMuB47qGDxZ
 sNVfDosq9Ld5fQaYmxsBzPi/nJVXJWccBvg5LBKTGR24zjrEBpwTwiOaiwxyW25njWC8uuU7Wb1
 m3DWTNqiiKnfZNQZzq9z9sGJspzMYE9fLgooQKjd4KgxiaRgvtwgWw8lSQ5AVaN5o7qV/UiCfWI
 AJH7mV18Oni51GuHKnAXweI1UCdiqd0fhSn3LCG7+mmiIvj9bvD5PzXwux39+DPJ2Hx4J8IL8M+
 zvpemF/EykCVo+YUddFyId45yTZS9yWygDpdcjtf/CAMDx/RnGuF42TSeYyv5TWQ2PO6wym6Y8n
 PpKVoUlD1cxeBKn/QE2JXI+NLZ/KyYoRFVJWwqWJUqmCGspRp5ounUog+QAXphPBrYMmST54lh/
 rgMg2cxDxkmGXib15oKQxI1o4F40u3pKpJnL8qbWx02AxfsPkE04ER3w0ULR/wZwDqKiZ6gVLht
 3XqpGCmGNYLriyLEvC/G4rxhw/AGXDhp/kKblrncAGBXiyrxGmguq0VQ/U5UeYPrReknVNCVNfT
 gVSnqkkIvmVfzzVibYbR07+ErGIqbc3ofmla/fMOIBI969Iq3Tvnbd2kbabrslorGXvBGcHgYU6
 GR1O7hBjD75lu8A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.331,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The struct has 3 bytes reserved according to spec. Fortunately, it's not
used yet.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/usb/dev-smartcard-reader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index 99086befe0b8..752571043ee6 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -264,7 +264,7 @@ typedef struct QEMU_PACKED CCID_IccPowerOn {
 
 typedef struct QEMU_PACKED CCID_IccPowerOff {
     CCID_Header hdr;
-    uint16_t    abRFU;
+    uint8_t     abRFU[3];
 } CCID_IccPowerOff;
 
 typedef struct QEMU_PACKED CCID_SetParameters {

-- 
2.56.0.rc0.29.g47ce80527c56


