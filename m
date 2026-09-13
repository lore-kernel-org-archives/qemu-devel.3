Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BB08C88E56
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 06:44:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5dwe-00049v-Vy; Sun, 13 Sep 2026 02:44:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x5dwd-00049a-CA; Sun, 13 Sep 2026 02:44:07 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x5dwb-0004Qf-JX; Sun, 13 Sep 2026 02:44:07 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 68D6hwDf079608
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sun, 13 Sep 2026 15:44:01 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=G57FdFOD5ffPthcDh73cYYvrkao8RvczkTWi+PNJ6n8=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1789281841; v=1;
 b=qiHDkU8hLWDq1M3Nge6b39lgUKdLo+TDCtmUwyuMHKD0jEw2SgSPGLcPGGtxBJCE
 bxYi76cJGeFB5UPbYyH/03P4+xFIv3MTyyFm6E3LuCssVvL07CqpRi3RfPE7b5b3
 AdvnQnQcknOlmBhVeWi2ZdJGZ5p1ZKps4dFsP3xJk68xAW3TXlEC6Urx2YUkyuah
 BzAOhv/Rorht7YPO26J4PVXndKfHApNuHdl3SmwJHfYWoXTQqMhDzwQfywVq/d+o
 u4mR92YPm9//vneIB59hZGH71bdsRggdW276Iq8+3d7JYe4fv2sB7dDPY+k8UFtz
 u13KuLJeCEXpoZtcEk03dw==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Sun, 13 Sep 2026 15:43:49 +0900
Subject: [PATCH] hw/misc/bcm2835_powermgt: Free the watchdog timer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260913-bcm2835-v1-1-b3719ca0df13@rsg.ci.i.u-tokyo.ac.jp>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDS0Nj3aTkXCMLY1NdSxPzpKRUAyPzZIMkJaDqgqLUtMwKsEnRsRB+cWl
 SVmpyCUi7Um0tADSyqDtrAAAA
X-Change-ID: 20260913-bcm2835-947bbe027c0b
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-arm@nongnu.org, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1354;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=QoE3J3w2bR9tcJaNMdEnXrIDPU2n6km1qP1giIU44lM=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ9YyN02xPyrW0pFXFeUXiYU3qu35mJb6rS3sLM9ZjtcL8
 l6eMZXsKGVhEONikBVTZEkp2s2tEV37qTAhvgVmDisTyBAGLk4BuMn2jAztXo+nS2dfW+K2wIl9
 2ubPDv8XXGHOy3XbOT3q3woJi25HRoYDZ9ZM+CRw5OebkMcbd8UlpTyRlqyfe3PKJUebJZsieN/
 zAQA=
X-Developer-Key: i=odaki@rsg.ci.i.u-tokyo.ac.jp; a=openpgp;
 fpr=AEDC03C9AF734F2EC26A7BFFA4BAEAA73536753C
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

It leaks with introspection.

Fixes: 21fcfb604608 ("hw/misc/bcm2835_powermgt: implement a real watchdog timer")
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 hw/misc/bcm2835_powermgt.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/misc/bcm2835_powermgt.c b/hw/misc/bcm2835_powermgt.c
index 7b01be48bb7f..1de5a55a4f5b 100644
--- a/hw/misc/bcm2835_powermgt.c
+++ b/hw/misc/bcm2835_powermgt.c
@@ -152,6 +152,13 @@ static void bcm2835_powermgt_init(Object *obj)
                                  bcm2835_powermgt_expire, s);
 }
 
+static void bcm2835_powermgt_finalize(Object *obj)
+{
+    BCM2835PowerMgtState *s = BCM2835_POWERMGT(obj);
+
+    timer_free(s->wdog_timer);
+}
+
 static void bcm2835_powermgt_reset(DeviceState *dev)
 {
     BCM2835PowerMgtState *s = BCM2835_POWERMGT(dev);
@@ -177,6 +184,7 @@ static const TypeInfo bcm2835_powermgt_info = {
     .instance_size = sizeof(BCM2835PowerMgtState),
     .class_init    = bcm2835_powermgt_class_init,
     .instance_init = bcm2835_powermgt_init,
+    .instance_finalize = bcm2835_powermgt_finalize,
 };
 
 static void bcm2835_powermgt_register_types(void)

---
base-commit: 209b2afaface001c7d4d981e38f186afe7b24a50
change-id: 20260913-bcm2835-947bbe027c0b

Best regards,
--  
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>


