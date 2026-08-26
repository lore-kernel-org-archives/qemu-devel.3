Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86764C61DBE
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 11:21:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzBfN-0004Wa-Fj; Wed, 26 Aug 2026 07:19:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzBfJ-0004Mu-Ob
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 07:19:33 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzBfF-0005gm-AC
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 07:19:31 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6a3efa2b38aso1488666a12.2
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 04:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787743166; x=1788347966; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SUjBnBdV7pNp3OZVe/2+qT9iBjz7Jwd8aflwWQuaeZk=;
 b=OfG5V8xPrc3Kb44sTwc/azT6ICEkmHRradG2Bs09gHDZPsFXwIK2tcpRBr2stqoWKB
 kl9C7L7FkOgxRzu2JpIoMAWZDy2Dm9vEb+9uUUW0LMxq3j8tsc7rzV/6yA//5QSnN+pe
 v0l7QcB1kptS6r+3jv9lHz4gJWNclc+wU9yi5VIKx4brzZnPkiq6kXDM2hrccrZyHtE8
 lxN5U84kM9Le5cz2FcMFHPqE+pwfyuTJZicAHOV9TI/Q4E1zxSP8l8GMpkSYi874iZLs
 aS1xzfvjrunfXksRLc3XEtEsHVsu7G5Qctev/pFmOMHx8jWn3+OYGMDL1PizuTrPTC/e
 SA4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787743166; x=1788347966;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SUjBnBdV7pNp3OZVe/2+qT9iBjz7Jwd8aflwWQuaeZk=;
 b=IYPDKkIeCAnKEFcrUrF/bwbgLJGo2BX6bMZ8Dxgm/rNWogU9yXmE6Ik5WibVlPISYG
 Rxf7GiSCmzlpvsmBj38wiQNxJJnfK3idNEZG63+a311cZdFLsreUnDEV7Gf4UkmQcawf
 OZSk/zqmaRHF8Sto8BYOY3yR5XNcH6BSfQlocOPcjoS3lLTw62fdhHFwS2Xk+ZmRB9S9
 fzIWjzEYauoLlf7lo8dlGavi9HHXxspkzqqkplMw+En+x/zZpqqpdqPfmr6vGg3n2V4F
 gL+DuO96q19YJt4WfjA1m1M/APKqW2W2SiskH9OvGCVZdYvkqsL5TQiZe4xcLFlB8AKq
 S+fg==
X-Gm-Message-State: AFuF++mcw5tQhTVXwG0aMMcX4WaFk+k/c9jzhLinGqquSiEjWvkI1oQ8
 LJPYkvPaTqGBab6vlRwftcBtjAfgNl9ZOp2K0tHZOazMMjdDxeleL+MlNr4a5jtlmERR0vC4+v6
 AvJM1
X-Gm-Gg: AR+sD11h96lDqjDlHlLmUggIyM4SkRijLLqSI6fo/QwCgFmDrFUVtt2rQkFmhUWGU1l
 KQnPWYwcGMDuDG3qalw2+WE1li0UaYfigtJSfc4g93tvMG75XXJ1/ZLZOtqgy+a+oa6dnww868L
 7nLgOg5HyLGdnIFSyJ3S34M9wCb+ps9rbabFN0cbiWD1t4HRkBwlaCSqkVVgejfHxjEWg7ecoyy
 2BY+GcR1hhU+J5owTzyBgBO71UuG4tvY741PaqWzO9onPY8NkQQh+Oc5VnftKtrAeATQR48hTJ0
 dijnW6lDbB7kwcVNhbS1+JCtMyHy8MtBGeQDa6aSwyZTF6ea27OS5NpKK0P2mUQiw2QnJc/Evsg
 BQKr3yzcbAkaoXJNV9dhDLHURnyJ8BbugAym4oWl2/c5pwYQi+9kgEUFGB1Hw6E1urjid8gqpCL
 t6/LEGBNUWleEawe6K+wm7fhfK/Fgb4RlBr6Zd7ckUZ83Q8P1Z
X-Received: by 2002:a05:6402:5043:b0:6a0:dda3:83db with SMTP id
 4fb4d7f45d1cf-6a5df31b0f7mr8313384a12.0.1787743166373; 
 Wed, 26 Aug 2026 04:19:26 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:8a5:68e8:91b1:8a17])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a5deaa8473sm4838366a12.21.2026.08.26.04.19.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 04:19:25 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 16/28] tests/qtest/ide-test: cover the CHS translation across
 resets
Date: Wed, 26 Aug 2026 13:19:03 +0200
Message-ID: <20260826111915.3387926-7-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826111915.3387926-1-den@openvz.org>
References: <20260826111524.3383479-1-den@openvz.org>
 <20260826111915.3387926-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=den@openvz.org; helo=mail-ed1-x531.google.com
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

A translation the guest selected has to survive a software reset and not a
hardware one, and the two arrive at the same ide_reset(), so a fix for
either direction can break the other. Select a translation, put the drive
through a software reset and then through a machine reset, and name the
sector each translation picks along the way.

The marker read says which translation the device is addressing the disk
with, while IDENTIFY DEVICE words 55 and 56 say which one it reports. The
machine reset leaves the PCI command register cleared, so the device has
to be enabled again before the ports answer.

Cc: John Snow <jsnow@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 tests/qtest/ide-test.c | 46 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/tests/qtest/ide-test.c b/tests/qtest/ide-test.c
index e7a56e0710..f14a0851f0 100644
--- a/tests/qtest/ide-test.c
+++ b/tests/qtest/ide-test.c
@@ -1639,6 +1639,51 @@ static void test_specify_identify_default(void)
     ide_test_quit(qts);
 }
 
+/* A hardware reset reverts the translation (ATA-5 9.1), SRST does not (9.2) */
+static void test_specify_reset(void)
+{
+    QTestState *qts;
+    QPCIDevice *dev;
+    QPCIBar bmdma_bar, ide_bar, ide_bar2;
+    uint16_t buf[256];
+    char marker[9];
+
+    qts = ide_test_start(
+        "-blockdev driver=file,node-name=hda,filename=%s "
+        "-device ide-hd,drive=hda,bus=ide.0,unit=0 ",
+        tmp_path[0]);
+    dev = get_pci_device(qts, &bmdma_bar, &ide_bar);
+    ide_bar2 = qpci_legacy_iomap(dev, IDE_BASE2);
+
+    ide_prepare_markers(qts, dev, ide_bar);
+    ide_set_translation(dev, ide_bar, 8, 32);
+    ide_read_chs_marker(qts, dev, ide_bar, 0, 1, 1, marker);
+    g_assert_cmpstr(marker, ==, CHS_MARKER_CUSTOM);
+
+    qpci_io_writeb(dev, ide_bar2, 0, IDE_CTRL_RESET);
+    qpci_io_writeb(dev, ide_bar2, 0, 0);
+    ide_wait_clear(qts, BSY);
+
+    ide_identify_words(dev, ide_bar, buf);
+    g_assert_cmpint(buf[55], ==, 8);
+    g_assert_cmpint(buf[56], ==, 32);
+    ide_read_chs_marker(qts, dev, ide_bar, 0, 1, 1, marker);
+    g_assert_cmpstr(marker, ==, CHS_MARKER_CUSTOM);
+
+    qtest_qmp_assert_success(qts, "{ 'execute': 'system_reset' }");
+    qtest_qmp_eventwait(qts, "RESET");
+    qpci_device_enable(dev);
+
+    ide_identify_words(dev, ide_bar, buf);
+    g_assert_cmpint(buf[55], ==, 16);
+    g_assert_cmpint(buf[56], ==, 63);
+    ide_read_chs_marker(qts, dev, ide_bar, 0, 1, 1, marker);
+    g_assert_cmpstr(marker, ==, CHS_MARKER_DEFAULT);
+
+    free_pci_device(dev);
+    ide_test_quit(qts);
+}
+
 static void test_cdrom_pio(void)
 {
     cdrom_read_impl(1, CDROM_PIO);
@@ -1714,6 +1759,7 @@ int main(int argc, char **argv)
     qtest_add_func("/ide/specify/identify", test_specify_identify);
     qtest_add_func("/ide/specify/identify_default",
                    test_specify_identify_default);
+    qtest_add_func("/ide/specify/reset", test_specify_reset);
     qtest_add_func("/ide/migration/chs_translation",
                    test_migrate_chs_translation);
     qtest_add_func("/ide/migration/chs_snapshot", test_migrate_chs_snapshot);
-- 
2.53.0


