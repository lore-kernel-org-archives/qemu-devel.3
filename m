Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00316C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 09:42:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1NWl-00047m-48; Mon, 29 Apr 2024 05:42:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1s1NWi-00046y-Bx
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 05:42:24 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1s1NWf-0007ry-A1
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 05:42:24 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:6401:0:640:7e6f:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 73E2260B30;
 Mon, 29 Apr 2024 12:42:16 +0300 (MSK)
Received: from d-tatianin-lin.yandex-team.ru (unknown
 [2a02:6b8:b081:b491::1:d])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id AgM7KD1IdiE0-Ws9SnWcZ; Mon, 29 Apr 2024 12:42:15 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1714383735;
 bh=yj85sCC4Q1J1GLe/VGxKLQrbjBBvbNkknZNZxH02XWc=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=i7ck5LSfUQdrBoSe5BesovqEz3AQi0Wx5YAoG9L0EF1hSdmwKjSScNYbFCg0Jw1bf
 qCbVXkbtVo59Fx8cgXcjOQl8LxPzng1RDu4PwF0QMBbqg3cG8J79HaHqQE0Uijc2at
 2ohhKEe0wx7kEkZeHguZPUG7nUkSmOhuZ4FmHCqU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Daniil Tatianin <d-tatianin@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH v2] mc146818rtc: add a way to generate RTC interrupts via QMP
Date: Mon, 29 Apr 2024 12:41:59 +0300
Message-Id: <20240429094159.514096-1-d-tatianin@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=d-tatianin@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This can be used to force-synchronize the time in guest after a long
stop-cont pause, which can be useful for serverless-type workload.

Also add a comment to highlight the fact that this (and one other QMP
command) only works for the MC146818 RTC controller.

Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
---

Changes since v0:
- Rename to rtc-inject-irq to match other similar API
- Add a comment to highlight that this only works for the I386 RTC

Changes since v1:
- Added a description below the QMP command to explain how it can be
  used and what it does.

---
 hw/rtc/mc146818rtc.c         | 20 ++++++++++++++++++++
 include/hw/rtc/mc146818rtc.h |  1 +
 qapi/misc-target.json        | 18 ++++++++++++++++++
 3 files changed, 39 insertions(+)

diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
index f4c1869232..8501b55cbd 100644
--- a/hw/rtc/mc146818rtc.c
+++ b/hw/rtc/mc146818rtc.c
@@ -107,6 +107,11 @@ static void rtc_coalesced_timer_update(MC146818RtcState *s)
 static QLIST_HEAD(, MC146818RtcState) rtc_devices =
     QLIST_HEAD_INITIALIZER(rtc_devices);
 
+/*
+ * NOTE:
+ * The two QMP functions below are _only_ implemented for the MC146818.
+ * All other RTC devices ignore this.
+ */
 void qmp_rtc_reset_reinjection(Error **errp)
 {
     MC146818RtcState *s;
@@ -116,6 +121,21 @@ void qmp_rtc_reset_reinjection(Error **errp)
     }
 }
 
+void qmp_rtc_inject_irq(Error **errp)
+{
+    MC146818RtcState *s;
+
+    /*
+     * See:
+     * https://www.kernel.org/doc/Documentation/virtual/kvm/timekeeping.txt
+     */
+    QLIST_FOREACH(s, &rtc_devices, link) {
+        s->cmos_data[RTC_REG_B] |= REG_B_UIE;
+        s->cmos_data[RTC_REG_C] |= REG_C_IRQF | REG_C_UF;
+        qemu_irq_raise(s->irq);
+    }
+}
+
 static bool rtc_policy_slew_deliver_irq(MC146818RtcState *s)
 {
     kvm_reset_irq_delivered();
diff --git a/include/hw/rtc/mc146818rtc.h b/include/hw/rtc/mc146818rtc.h
index 97cec0b3e8..6cd9761d80 100644
--- a/include/hw/rtc/mc146818rtc.h
+++ b/include/hw/rtc/mc146818rtc.h
@@ -56,5 +56,6 @@ MC146818RtcState *mc146818_rtc_init(ISABus *bus, int base_year,
 void mc146818rtc_set_cmos_data(MC146818RtcState *s, int addr, int val);
 int mc146818rtc_get_cmos_data(MC146818RtcState *s, int addr);
 void qmp_rtc_reset_reinjection(Error **errp);
+void qmp_rtc_inject_irq(Error **errp);
 
 #endif /* HW_RTC_MC146818RTC_H */
diff --git a/qapi/misc-target.json b/qapi/misc-target.json
index 4e0a6492a9..0f2479f8f4 100644
--- a/qapi/misc-target.json
+++ b/qapi/misc-target.json
@@ -19,6 +19,24 @@
 { 'command': 'rtc-reset-reinjection',
   'if': 'TARGET_I386' }
 
+##
+# @rtc-inject-irq:
+#
+# Inject an RTC interrupt. This command forces the guest to synchornize
+# the time with RTC. This is useful after a long stop-cont pause, which
+# is common for serverless-type workload.
+#
+# Since: 9.1
+#
+# Example:
+#
+#     -> { "execute": "rtc-inject-irq" }
+#     <- { "return": {} }
+#
+##
+{ 'command': 'rtc-inject-irq',
+  'if': 'TARGET_I386' }
+
 ##
 # @SevState:
 #
-- 
2.34.1


