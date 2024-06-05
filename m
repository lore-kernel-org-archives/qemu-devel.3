Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ED80C27C5E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 23:39:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF0Br-0003Xm-Gg; Wed, 05 Jun 2024 19:37:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sF0Bp-0003Kt-Uq
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 19:37:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sF0Bo-0005yZ-3h
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 19:37:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717630627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qGhmwqguo7pIYQaZC7WOHDuKcF1Cau7swIzTfVk8co4=;
 b=T1ULlpmkosCkUwFHjOnZr03KX7TJfe4C3TcQJX6FFkYJRqmsjPEHYnOC1Jz9dSMHcBaClP
 EE0+xUZy1ld6CCrX6UhB2NzojZRbbvDyyBpu4WUmzIUiMVay2RgCaOFEtAnGOYjYW+UV9y
 2ZeI3XffOmJsdeOUcbsflzqsZLUd5aM=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-QeIByTx8O5uzjUBZ5tAPVA-1; Wed, 05 Jun 2024 19:37:06 -0400
X-MC-Unique: QeIByTx8O5uzjUBZ5tAPVA-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-52b83657cc3so267617e87.0
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 16:37:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717630624; x=1718235424;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qGhmwqguo7pIYQaZC7WOHDuKcF1Cau7swIzTfVk8co4=;
 b=WZlBL9TO3AG+Xx8GAqnQiEFDg/MTNTkLeNx6RKOEs8y3N9oljfa+32csdtoxq2cQtZ
 UCnewYHXgyuophdGopBRXUnE5jXX22KGYzf9qn42DEf18leeaeXnDpO3dI0mq5PrxXtT
 cHsZoVN5I/wiibTTAGTAr3Rpl1K9j9OI5VMn9bLJav4JNJys0uEdhh4668FFZ21ABrJK
 UjCCmN/t/UN5cBcRSWsVe8MNjI6S0dzYC/pacNbPWIqSfUW6axC0eZfl8hNtVv6+q1n0
 0KzrBUyqVnYfrhAr6POPLZ+hqsOBn95ruI5mj2jFVFUcw3mgxTgjuW0nnzmAy3SAM0Le
 UwmA==
X-Gm-Message-State: AOJu0YzgaeSPPCC6a+t2iATOL6rKyPtiqL1Ne6Fi+H6GEmRmmWx0ABVW
 o3GBVfGzmr5PZlwa/Ni6S+pWaaUv/tv/Sr98jHqhW2fBIGedWrtnup0hA5my62zvarXBMpdOf1W
 PDf1J38BDrHmNWZ4iTspTpGk0p3vfv6lme4WhKaapf017T6AnJ0aJvUC1aFj3T9qe8n4NSLcANz
 bKWLLk3A0WmAYaSPJMMflhj9ljRBtDew==
X-Received: by 2002:a05:6512:3e01:b0:529:593f:3f39 with SMTP id
 2adb3069b0e04-52bab4d7fc5mr3004949e87.35.1717630624081; 
 Wed, 05 Jun 2024 16:37:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAVyNbLm+6cCNbrSnWunv7Ff1ZhYxquVYrLQxOSM2SpU55aqcaOIHcd7pAfyJIyKnBlZNeQg==
X-Received: by 2002:a05:6512:3e01:b0:529:593f:3f39 with SMTP id
 2adb3069b0e04-52bab4d7fc5mr3004934e87.35.1717630623550; 
 Wed, 05 Jun 2024 16:37:03 -0700 (PDT)
Received: from redhat.com ([2.55.56.67]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6c8070e80dsm6603866b.175.2024.06.05.16.37.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 16:37:02 -0700 (PDT)
Date: Wed, 5 Jun 2024 19:37:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL v3 38/41] tests/qtest/pvpanic: add tests for pvshutdown event
Message-ID: <a9aed05f6b7ded621c851cdab47b39fd34d5f704.1717630437.git.mst@redhat.com>
References: <cover.1717630437.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1717630437.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Thomas Weißschuh <thomas@t-8ch.de>

Validate that a shutdown via the pvpanic device emits the correct
QMP events.

Signed-off-by: Thomas Weißschuh <thomas@t-8ch.de>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240527-pvpanic-shutdown-v8-7-5a28ec02558b@t-8ch.de>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/pvpanic-pci-test.c | 39 ++++++++++++++++++++++++++++++++++
 tests/qtest/pvpanic-test.c     | 29 +++++++++++++++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/tests/qtest/pvpanic-pci-test.c b/tests/qtest/pvpanic-pci-test.c
index b372caf41d..dc021c2fdf 100644
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
index ccc603472f..d49d2ba931 100644
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
MST


