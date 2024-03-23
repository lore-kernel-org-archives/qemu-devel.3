Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84015C54E58
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Mar 2024 09:40:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnxqX-0001pt-J6; Sat, 23 Mar 2024 05:39:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thomas@t-8ch.de>) id 1rnxqT-0001oe-P7
 for qemu-devel@nongnu.org; Sat, 23 Mar 2024 05:39:21 -0400
Received: from todd.t-8ch.de ([2a01:4f8:c010:41de::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thomas@t-8ch.de>) id 1rnxqR-0006wx-EZ
 for qemu-devel@nongnu.org; Sat, 23 Mar 2024 05:39:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
 t=1711186752; bh=/KvE0ibIDZCzGsU2xL4WmYohrL85WVD01hFgWCYQCBY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=VeRhsNVD7HpSPKWc7iW6mgkdyxtgbGtM2dcsy7VGdUZ/ipi78FlH1ypj+sxhcRZ0z
 wmqIur8kqujCZmxUsGUqriYkc7QKuqnnPfrp4aPP9yaZg+cAWavBJSwfo9qSCGwXbg
 GLf3uAmv7Q38jS2k00t6xgCVy7jClufal92fm0bc=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Date: Sat, 23 Mar 2024 10:39:11 +0100
Subject: [PATCH v7 6/7] tests/qtest/pvpanic: add tests for pvshutdown event
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240323-pvpanic-shutdown-v7-6-4ac1fd546d6f@t-8ch.de>
References: <20240323-pvpanic-shutdown-v7-0-4ac1fd546d6f@t-8ch.de>
In-Reply-To: <20240323-pvpanic-shutdown-v7-0-4ac1fd546d6f@t-8ch.de>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, 
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711186751; l=3527;
 i=thomas@t-8ch.de; s=20221212; h=from:subject:message-id;
 bh=/KvE0ibIDZCzGsU2xL4WmYohrL85WVD01hFgWCYQCBY=;
 b=+7AH+MDS+anmZlwSe57HRj0fTK9rBppdx2XEBUEsMTc3QisbKFHbLSsLa/Q2Giw9Q4cwvRFmV
 fGwYQtpwi7WDti/DOsE27dqfSBocAZy4VWhrxD5rPtygdRnTJY30idQ
X-Developer-Key: i=thomas@t-8ch.de; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
Received-SPF: pass client-ip=2a01:4f8:c010:41de::1;
 envelope-from=thomas@t-8ch.de; helo=todd.t-8ch.de
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

Validate that a shutdown via the pvpanic device emits the correct
QMP events.

Signed-off-by: Thomas Weißschuh <thomas@t-8ch.de>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/pvpanic-pci-test.c | 39 +++++++++++++++++++++++++++++++++++++++
 tests/qtest/pvpanic-test.c     | 29 +++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/tests/qtest/pvpanic-pci-test.c b/tests/qtest/pvpanic-pci-test.c
index b372caf41dc0..dc021c2fdf77 100644
--- a/tests/qtest/pvpanic-pci-test.c
+++ b/tests/qtest/pvpanic-pci-test.c
@@ -85,11 +85,50 @@ static void test_panic(void)
     qtest_quit(qts);
 }
 
+static void test_pvshutdown(void)
+{
+    uint8_t val;
+    QDict *response, *data;
+    QTestState *qts;
+    QPCIBus *pcibus;
+    QPCIDevice *dev;
+    QPCIBar bar;
+
+    qts = qtest_init("-device pvpanic-pci,addr=04.0");
+    pcibus = qpci_new_pc(qts, NULL);
+    dev = qpci_device_find(pcibus, QPCI_DEVFN(0x4, 0x0));
+    qpci_device_enable(dev);
+    bar = qpci_iomap(dev, 0, NULL);
+
+    qpci_memread(dev, bar, 0, &val, sizeof(val));
+    g_assert_cmpuint(val, ==, PVPANIC_EVENTS);
+
+    val = PVPANIC_SHUTDOWN;
+    qpci_memwrite(dev, bar, 0, &val, sizeof(val));
+
+    response = qtest_qmp_eventwait_ref(qts, "GUEST_PVSHUTDOWN");
+    qobject_unref(response);
+
+    response = qtest_qmp_eventwait_ref(qts, "SHUTDOWN");
+    g_assert(qdict_haskey(response, "data"));
+    data = qdict_get_qdict(response, "data");
+    g_assert(qdict_haskey(data, "guest"));
+    g_assert(qdict_get_bool(data, "guest"));
+    g_assert(qdict_haskey(data, "reason"));
+    g_assert_cmpstr(qdict_get_str(data, "reason"), ==, "guest-shutdown");
+    qobject_unref(response);
+
+    g_free(dev);
+    qpci_free_pc(pcibus);
+    qtest_quit(qts);
+}
+
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
     qtest_add_func("/pvpanic-pci/panic", test_panic);
     qtest_add_func("/pvpanic-pci/panic-nopause", test_panic_nopause);
+    qtest_add_func("/pvpanic-pci/pvshutdown", test_pvshutdown);
 
     return g_test_run();
 }
diff --git a/tests/qtest/pvpanic-test.c b/tests/qtest/pvpanic-test.c
index ccc603472f5d..d49d2ba9313e 100644
--- a/tests/qtest/pvpanic-test.c
+++ b/tests/qtest/pvpanic-test.c
@@ -58,11 +58,40 @@ static void test_panic(void)
     qtest_quit(qts);
 }
 
+static void test_pvshutdown(void)
+{
+    uint8_t val;
+    QDict *response, *data;
+    QTestState *qts;
+
+    qts = qtest_init("-device pvpanic");
+
+    val = qtest_inb(qts, 0x505);
+    g_assert_cmpuint(val, ==, PVPANIC_EVENTS);
+
+    qtest_outb(qts, 0x505, PVPANIC_SHUTDOWN);
+
+    response = qtest_qmp_eventwait_ref(qts, "GUEST_PVSHUTDOWN");
+    qobject_unref(response);
+
+    response = qtest_qmp_eventwait_ref(qts, "SHUTDOWN");
+    g_assert(qdict_haskey(response, "data"));
+    data = qdict_get_qdict(response, "data");
+    g_assert(qdict_haskey(data, "guest"));
+    g_assert(qdict_get_bool(data, "guest"));
+    g_assert(qdict_haskey(data, "reason"));
+    g_assert_cmpstr(qdict_get_str(data, "reason"), ==, "guest-shutdown");
+    qobject_unref(response);
+
+    qtest_quit(qts);
+}
+
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
     qtest_add_func("/pvpanic/panic", test_panic);
     qtest_add_func("/pvpanic/panic-nopause", test_panic_nopause);
+    qtest_add_func("/pvpanic/pvshutdown", test_pvshutdown);
 
     return g_test_run();
 }

-- 
2.44.0


