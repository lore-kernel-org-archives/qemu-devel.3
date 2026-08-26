Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69999C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 11:21:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzBfW-00053b-JS; Wed, 26 Aug 2026 07:19:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzBfU-0004wB-JE
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 07:19:44 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzBfR-0005pa-Vw
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 07:19:44 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-c197eaaab00so133615766b.0
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 04:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787743180; x=1788347980; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1VlpdsOBokS3SNvIYS8d4wFOPLdoOB4ncFQBcaVMfCo=;
 b=U9Y2D3Ozem6bqOIvUxwW3WoIwq4nBudUPTqZShTqX+XGXefONlxwb5cB83WVWyo+0b
 m00eNQGQYZtR+ffX6r1gXeyV628SPaz6drzpyuF9USaqste5SxgXOmDkjvE7c42l40Cs
 mn8xKLkTU94r9cOYTBDaz/JY+bTZEO4wuUHogKzxyCRwUeCkLU+95ixLQAJ1NhtFDnrc
 9Fwq0W+YTlVxXz7d/33+NzfU0e1FNjENVxotOm4VWzN+qkkcVayDKDFvhJPpkb7oCILV
 d6zIoRQbipqGGw+g3/Vo9SSoy8nFNQ6y36UK8nSrlmosGCHjLbAnKSDn2IYd//3ql7rR
 RfdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787743180; x=1788347980;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1VlpdsOBokS3SNvIYS8d4wFOPLdoOB4ncFQBcaVMfCo=;
 b=CEOGCoMUQs+boHdsV845AXaZOBJV+KmoVdFzeassaE/EAYELLBjJV77djU2e3uZ/F5
 eTYhWwo5ymJWquj7AbgS17vutMHu1s0wUiKi8/vBTxQ3K7g56LR9HB0hr5UIF1nrSWW7
 LlEu2RjuCxlVEG/qrGsaWHgZsNWOUDjTZjGxE8wvB578djJ9q5vfLrJ/huNlEaywP6bg
 34cjWSqW+YdgUyxMuqIu+qyktgc7Qi1wb9LNe8kh8deOlSw3y6RNnOVqUKIg17TgaLKw
 2fM0Vckm6/dcGSDEyddWZbeJpk+RkmWyqll29svY3ZlJbDnBK2TcPa6W5Vh1qa06OYIS
 M/3w==
X-Gm-Message-State: AFuF++lkov1NSv+bpgXfbNxxBvK/DGDnCDS3EgbyafJ2MnGuPNbZPSfj
 cBfFHkl6WIm2e+D//L8jRJ8S0mNXLUEQ8vGFcBEU3Y2+vMwf0jwLqeak+k5Qn9/1+0aqJFxwsBs
 cADjx
X-Gm-Gg: AR+sD12Z2KK3eK8hLqSQ2NDDPJhJ5aqvWRjJf4cBJnz2glrhT7F/BbF528WRcHn9y+p
 JsFMc8ktqxAxXkUNMlwKZNE24SifAzyNaO4uvnk7qsZJ/5gIvRWFPKLFp+/wkftDSyn1146FGGy
 9qUX5rJazRQFl2Jtie8bAsQFpA03fjXHg8kaVCsSNlPR8VbVHWmFuE6aCIE7/6Cy+W5dbaaE0WF
 M59BPboOLMe0szGbO7fSp39h62Cwoe439hRYLgIHr819OWAi6naW3fEZourCXr00vSDXAXF1qJb
 eC0FmGrAmPMaDSNvVwWpCWrMdWhipIEYFtLXSJiIwVNmuBKljEUKLjhpI8NtlTSoZnD2NxKI3aX
 vm3XQHGzpa0UWR6jEApmrwu1G1ZK7+MzLWwR4V+c3ck0YAfr7LkGG96QUAoPRlrx6+rm6dlFqDS
 89AacKssOssUo8IAmUFezwwGRBs5ayMSAj3dRlVGBhEiibH5HV
X-Received: by 2002:a17:906:9f87:b0:c21:1b58:fa96 with SMTP id
 a640c23a62f3a-c250bbbf179mr852603966b.3.1787743180207; 
 Wed, 26 Aug 2026 04:19:40 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:8a5:68e8:91b1:8a17])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a5deaa8473sm4838366a12.21.2026.08.26.04.19.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 04:19:39 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 26/28] tests/qtest/ahci: regression test for a request
 outliving an unplug
Date: Wed, 26 Aug 2026 13:19:13 +0200
Message-ID: <20260826111915.3387926-17-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826111915.3387926-1-den@openvz.org>
References: <20260826111524.3383479-1-den@openvz.org>
 <20260826111915.3387926-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=den@openvz.org; helo=mail-ej1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


