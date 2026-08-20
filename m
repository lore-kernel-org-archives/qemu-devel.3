Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C361C5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 14:44:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx3zW-0000eO-1D; Thu, 20 Aug 2026 10:43:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wx3zN-0000bf-9T
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 10:43:29 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wx3zJ-0005C6-Rc
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 10:43:29 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-499b02fc590so10443475e9.2
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 07:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787237004; x=1787841804; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1VlpdsOBokS3SNvIYS8d4wFOPLdoOB4ncFQBcaVMfCo=;
 b=OdaQ72PdB2eWOIkZH55A/psAcEWljEzxh/L3v6TRD/r2tknYv+JwlFYLsmkFZFDRKa
 SuUE/EyfpE5p27l67leE5TjTUHBKbA3WnIFJN7173k6MeevN7cnPXiZVncNyhkLvtETs
 yeORNjako700TzTvI3dNUFqUlIbDhWeAqzSGygLbFjuDjI2KMNrPltFpqOgsyh6hNtpw
 rWqEQzgvxlmUbnPYKjKMh2/PmL89FHtOZRJvjZUk9Q0+9HvZQkUizibY4fdpYLKQYj44
 YfPlqLn6wjodusjYP9sJaiQT60JNnoR5P4ADHiCG18KojIcmXzbHsbiJg0mdakf2kyls
 jL6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787237004; x=1787841804;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1VlpdsOBokS3SNvIYS8d4wFOPLdoOB4ncFQBcaVMfCo=;
 b=oc1Ov0LF9XLazZk/bcDWKwi9B4QxG3ZVF/MUI2w0fONfVcjmYMx9lUhSxyLifKHtkV
 CF3YKvcQEmlml5vWDDkIUNVjUgkvgRPbpE+dztktQ2MKOyicpYNd6T67XkbnrlwhfJ+C
 6grNPN8R7y5o9NVDfTTU3vAp9euKhMWSdLpFPcakPYgCoe4kF2jiPyH8oi+5lNFhUGJ1
 QPjucPzOFnDL0aXyIsbNoXNMn3EybHGYO2PPAAUAPKcAr3NEAnOvdNJCWp7ZWGZ3xaRj
 Gx19OkYW2Ycmb0vrBJaHsoDydSp1+nSVjMxPkaD/59ZFq30KD23hsXAu7kHchUTKwTeP
 BStw==
X-Gm-Message-State: AOJu0Yw3z5wFKX+arhpe664+uNpwF0OD23qqUfNoiTFvfMWMDlr/T5sF
 1+9lAMX4aZna62CdhP8VuvVy5GSLl1x8wVK+0J3VLhpnhNNLpyZN2zZNjrAli54knDGYCyNglq6
 LiDqL
X-Gm-Gg: AR+sD12w6RBDTUIFw8NB2cvLgqYJvhMy6EWDKvIzEUChpigBUU8b7+qEoZFlyQ/H9LG
 rV3NK0QD1fi38iXAJw4/Tttsw5chTg2FyARFvUKVcCCxbpzMGtRVbVwpSRzsc/56p6m2/i80Nln
 BtO0fs/ctfQgoBKPYhnjSVuT6eAseKnMqOkz+TgFt3dyu8ogKD7Gs554V20etLh9haXIuS2YOLW
 GB8e8JLUoYL6emX14DVMf9x5Attors3dadmRtpLcjNCShwfpr0uFfK5e2UhOFiOUOKSUUkwZqb8
 V+eycBy1d/S0wqf+38F7CQfNbMSnzdYmoKv1crJxwfaY3abdPW1S4G7WWEm9DBCAYSRANBjyhGY
 WfgazfZGPTKCdeEXHILByEyB9ebSevvRCpyWq2I3Q5+XLLEjJHW2tJcsgkQEzvQjDtmftqau58n
 xKdTRC44l2iQswfd1rmDWonIKGtyOVcqwS7h7W2MCMowm3ZuezjqFmuAW0lQ==
X-Received: by 2002:a05:600c:a402:b0:499:b65d:1250 with SMTP id
 5b1f17b1804b1-499b65d127bmr16572435e9.2.1787237003785; 
 Thu, 20 Aug 2026 07:43:23 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:a123:7b43:afd8:8b47])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa0dd620sm136791565e9.13.2026.08.20.07.43.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 07:43:23 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 09/11] tests/qtest/ahci: regression test for a request
 outliving an unplug
Date: Thu, 20 Aug 2026 16:43:07 +0200
Message-ID: <20260820144309.835173-10-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820144309.835173-1-den@openvz.org>
References: <20260820144309.835173-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=den@openvz.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Denis V. Lunev <den@openvz.org>

Add /ahci/io/{ncq,dma,pio}/unplug: arm a read against a null-co backend
whose latency keeps it in flight, then eject the controller through the
ACPI ejection register. Each of the three reaches the freed AHCIDevice
array by a different route, so covering one command class would leave
the other two untested.

That register is what a guest writes to finish a PCI unplug, and unlike
the pciehp attention button it reaches ahci_uninit() with no secondary
bus reset, so nothing cancels the request on the way. It also dictates
the machine: q35 has no ACPI hotplug on pcie.0, so the eject has no
effect there.

The latency is what holds the request; a blkdebug breakpoint cannot
stand in for it, because cancelling a suspended request waits for it and
the unplug would never return.

Unfixed, all three fail reliably under AddressSanitizer. On a plain build
the use-after-free only faults when the freed page has been returned, so
expect the odd pass there.

Cc: John Snow <jsnow@redhat.com>
Cc: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 tests/qtest/ahci-test.c | 75 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/tests/qtest/ahci-test.c b/tests/qtest/ahci-test.c
index 84d4e6b0a5..b143862ce7 100644
--- a/tests/qtest/ahci-test.c
+++ b/tests/qtest/ahci-test.c
@@ -1793,6 +1793,78 @@ static void test_atapi_engine_restart_dma(void)
     test_atapi_engine_restart_in_flight(true);
 }
 
+/*
+ * Regression test: an unplug runs no device reset, so it is the last chance to
+ * detach an outstanding request. Its completion would otherwise walk the
+ * AHCIDevice array that ahci_uninit() has freed, which each of the NCQ, DMA
+ * and PIO completions reaches by a different route.
+ *
+ * The ACPI ejection register is what a guest writes to finish a PCI unplug.
+ * -M pc is what puts it in reach: q35 has no ACPI hotplug on pcie.0, so the
+ * unplug never happens there. Unlike the pciehp attention button this reaches
+ * the unplug with no secondary bus reset, which is the ordering that leaves a
+ * request outstanding.
+ */
+static void test_unplug_in_flight(uint8_t ide_cmd)
+{
+    AHCIQState *ahci;
+    AHCICommand *cmd;
+    uint64_t ptr;
+    uint8_t port;
+    QTestState *qts;
+
+    /*
+     * The latency keeps the backend read in flight across the unplug. A
+     * blkdebug breakpoint cannot stand in for it: cancelling a suspended
+     * request waits for it, so the unplug would never return.
+     */
+    ahci = ahci_boot_and_enable(
+        "-M pc "
+        "-blockdev driver=null-co,node-name=drive0,read-zeroes=on,"
+        "latency-ns=100000000 "
+        "-device ich9-ahci,addr=1f.2,id=ahci0 "
+        "-device ide-hd,drive=drive0,bus=ahci0.0 ");
+    qts = ahci->parent->qts;
+    port = ahci_port_select(ahci);
+    ahci_port_clear(ahci, port);
+
+    ptr = ahci_alloc(ahci, AHCI_SECTOR_SIZE);
+    g_assert(ptr);
+
+    cmd = ahci_command_create(ide_cmd);
+    ahci_command_adjust(cmd, 0, ptr, AHCI_SECTOR_SIZE, 0);
+    ahci_command_commit(ahci, cmd, port);
+    ahci_command_issue_async(ahci, cmd);
+
+    /* Eject slot 0x1f of the root bus, which frees the AHCIDevice array. */
+    qtest_outl(qts, 0xae10, 0);
+    qtest_outl(qts, 0xae08, 1u << 0x1f);
+    qtest_qmp_eventwait(qts, "DEVICE_DELETED");
+
+    /* Four times the backend latency, so the completion has surely run. */
+    g_usleep(400 * 1000);
+    qtest_qmp_assert_success(qts, "{ 'execute': 'query-status' }");
+
+    ahci_command_free(cmd);
+    ahci_free(ahci, ptr);
+    ahci_shutdown(ahci);
+}
+
+static void test_unplug_ncq(void)
+{
+    test_unplug_in_flight(READ_FPDMA_QUEUED);
+}
+
+static void test_unplug_dma(void)
+{
+    test_unplug_in_flight(CMD_READ_DMA);
+}
+
+static void test_unplug_pio(void)
+{
+    test_unplug_in_flight(CMD_READ_PIO);
+}
+
 /*
  * Regression test: a PIO write outlives the command list it was issued from.
  * ide_cancel_dma_sync() does not reach s->pio_aiocb, so the second DRQ phase
@@ -2351,6 +2423,9 @@ int main(int argc, char **argv)
                    test_atapi_engine_restart_pio);
     qtest_add_func("/ahci/cdrom/engine_restart/dma",
                    test_atapi_engine_restart_dma);
+    qtest_add_func("/ahci/io/ncq/unplug", test_unplug_ncq);
+    qtest_add_func("/ahci/io/dma/unplug", test_unplug_dma);
+    qtest_add_func("/ahci/io/pio/unplug", test_unplug_pio);
     qtest_add_func("/ahci/io/pio/engine_stop",
                    test_write_engine_stop_in_flight);
     qtest_add_func("/ahci/cdrom/drain/pio", test_atapi_drain_pio);
-- 
2.53.0


