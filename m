Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6559DC5DF9B
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 15:26:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyWY9-0005vX-A6; Mon, 24 Aug 2026 11:25:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wyWY4-0005mx-FI
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 11:25:21 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wyWXw-0007Ei-LR
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 11:25:20 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6a156627e22so8414562a12.1
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 08:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787585111; x=1788189911; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aUlRGxcy2rZEj1QS7x2oqaNrmrRAbDWz5zlA+zLfboE=;
 b=GUArX8v68kFiTj2HAh4hyygzD5zi6p7UbOhYUl2DipOZODKFs32UGEdbqiPXrAG1OU
 SxxD37P5vDdGRdOsrwKAdwcyHokVgkcxDeQtI0rJov4kr5D4qG7ZhztAsbAMrRFRredQ
 oAp1pdqLbg2GAVT8yK8znHIgcYqgi7jJywgMHRlrtMZpFUucXOuIUmHWeodW5Vpd9zkg
 tbK/NqQRlsPRRkW7OyrLEhLsYz+8Gsw3DjsjMFOR7CwNPeSzk6E753qxE093KA/MkvJF
 2S51RsdvW6VqS2d+yYZKfwlJEkbMixHsSjdmXXrfHYndjIpfch2Wd1MurnzafMKewa9H
 Ruxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787585111; x=1788189911;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aUlRGxcy2rZEj1QS7x2oqaNrmrRAbDWz5zlA+zLfboE=;
 b=ZgHPDxO12vogs+kbhJTcuIE3O7sRsm8h8jHmK3cDtTtJUDPFGciijNF0DY7R5uX9WW
 fLgT94un9cR8xRY1Xx3cLsP9izp47cb4JwAawFhLRkCHsTB43Z1uVeq5FwYvKuun2/rR
 9v0CGvn2kxylGijmWomN5xoNLwqEM8gDTJCSY2qKZhJxX22rs2mWxFJXlDvQAk8oXaib
 wxbk7cmyJuweyJ1Gp0Bw1+XWskJkWPfbedo/TYHNuj/toc+Mmt0pwxNC0yWbrap0jMyO
 OmYvp7fzSBJiygcTQi5dXalpQRnJOEoeSWL2jFKMjyU7dtPpWBvtggnYhaxiWiy0s4Eh
 DxsQ==
X-Gm-Message-State: AFuF++l8rhDFUl5Je0EO18nU83SB/Ahq4Do1ohbT948ZhFyWY9Nr3BQg
 4ovRfWcn0QfIz4ePTJ9hHBIO5TtVF7o1URwo+/bzIC5jAVpxYM5OAx8z6QoJ0sVxMMU=
X-Gm-Gg: AR+sD11bCUL+Pd2ijSpyY0P8X12QRZqxQFUkzI0rQiRESxTpZsCQvjzGgyiHAvu5EwV
 i0XicCDDMnax07QuqEfqg5I1PiqYmn36R4QHmK8eqKhEUlqlVa1n7VvQe/uR0j4PF8DS76XZ4VT
 tRtHP/PvToYp4po+HBlMVdQpfkb2BA5Dq2n84arcG90Rcp3JcsnWwnp9S5oX4khq+G58b8gVZKC
 w+fti6CkSOLAXIfncWZkuL0ssc3422cAgxj3/TCaqvftwtXkci/bFAyQsQ1Mla6ch0HmdEdUIEr
 e+sGYkcauFesDPIj3iWZq+l1kKXgXOKAuJ0mIJqwJ/2NKg4YzSxYdTHIgsd6WdEfWGy0AfAvjC+
 pu2ah8UQ0BYCjE3PXHvrOeLn24k2ti3kukt3EXcwks1huJfS+fA8bxYc873pZiBPn5OhqQ5D4X7
 15C8YInNE2u97S2rTvIfo+Ue9o3nhIhK3FpLWAhWraOQxK9j1AEP2sbOKXrtORKqypU+WwryM=
X-Received: by 2002:a17:907:8dc9:b0:c16:6dac:a008 with SMTP id
 a640c23a62f3a-c246dc97d69mr2504648266b.8.1787585110895; 
 Mon, 24 Aug 2026 08:25:10 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c249689fa97sm1158371166b.57.2026.08.24.08.25.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:25:07 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6A8EE5FBDB;
 Mon, 24 Aug 2026 16:25:02 +0100 (BST)
From: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 24 Aug 2026 16:24:53 +0100
Subject: [PATCH v2 6/8] tests/qtest: add test case for fdc sector overflow
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260824-fixes-for-11-2-v2-6-352c6b890402@linaro.org>
References: <20260824-fixes-for-11-2-v2-0-352c6b890402@linaro.org>
In-Reply-To: <20260824-fixes-for-11-2-v2-0-352c6b890402@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, 
 zhenwei pi <zhenwei.pi@linux.dev>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 qemu-block@nongnu.org, devel@lists.libvirt.org, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Fabiano Rosas <farosas@suse.de>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10652;
 i=alex.bennee@linaro.org; h=from:subject:message-id;
 bh=TVs3th5ucYmnjcYnTts8iJZexWW8EZ/0P70j7X/7Wy8=;
 b=owEBbQGS/pANAwAKAfvQ2wlanipEAcsmYgBqjGJOwK5vH2h3meJq0WXNFYqlbOHUwPhp08X6A
 /maULgMqruJATMEAAEKAB0WIQRmha6Z51FnvK/I3zX70NsJWp4qRAUCaoxiTgAKCRD70NsJWp4q
 RH5OCACLczSMuPnc+l8KPp0/4nbAFmz7n9LqJ2qj3E7ihpqPRS+3nOTkt5wNsBlqntkixoXuU+5
 nimRUWV8zVydIFXBg6E9RXfzh26Uq6fouO6aP7+NXL5wFY1pBwj5V9Uvah6Vq4eC1Ikp+U7cYZy
 07OTB1nkgK2uIxvesea5DwJeXulFr4J1X+IUaXgManT3SJPdQ+/MjaimOIVna6fuvGPswBClxkn
 LrSaxWjyVDZRf4Mn6imnLG+z6Aligljp1n+UNiwcqeOya1ETDFKUPPlVGfSQgK+s3JS+ssHupWB
 gdRmn4MlRNym0IUc/qSJ+u1+cJEnz7f7U2gvL7h+k9BJeeeA
X-Developer-Key: i=alex.bennee@linaro.org; a=openpgp;
 fpr=6685AE99E75167BCAFC8DF35FBD0DB095A9E2A44
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x532.google.com
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

Add a test case for #3800 where we check that the last sector is
properly bounded by the physical media that is inserted.

Link: https://gitlab.com/qemu-project/qemu/-/issues/3800
AI-used-for: initial draft of test
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/qtest/fdc-test.c | 246 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 241 insertions(+), 5 deletions(-)

diff --git a/tests/qtest/fdc-test.c b/tests/qtest/fdc-test.c
index 1e1dd8659d0..3f2642fe671 100644
--- a/tests/qtest/fdc-test.c
+++ b/tests/qtest/fdc-test.c
@@ -31,7 +31,8 @@
 #define DRIVE_FLOPPY_BLANK \
     "-drive if=floppy,file=null-co://,file.read-zeroes=on,format=raw,size=1440k"
 
-#define TEST_IMAGE_SIZE 1440 * 1024
+#define TEST_IMAGE_1440KB (1440 * 1024)
+#define TEST_IMAGE_720KB (720 * 1024)
 
 #define FLOPPY_BASE 0x3f0
 #define FLOPPY_IRQ 6
@@ -49,8 +50,11 @@ enum {
 enum {
     CMD_SENSE_INT           = 0x08,
     CMD_READ_ID             = 0x0a,
+    CMD_FORMAT_TRACK        = 0x4d,
     CMD_SEEK                = 0x0f,
     CMD_VERIFY              = 0x16,
+    CMD_SAVE                = 0x2e,
+    CMD_RESTORE             = 0x4e,
     CMD_READ                = 0xe6,
     CMD_RELATIVE_SEEK_OUT   = 0x8f,
     CMD_RELATIVE_SEEK_IN    = 0xcf,
@@ -69,9 +73,11 @@ enum {
     ST0_IC_ABNTERM = 0x40,  /* abnormal termination */
 
     ST1_MA       = 0x01,    /* missing address mark */
+    ST1_EC       = 0x80,    /* end of cylinder / sector past last_sect */
 };
 
 static char *test_image;
+static char *test_image_720k;
 
 #define assert_bit_set(data, mask) g_assert_cmphex((data) & (mask), ==, (mask))
 #define assert_bit_clear(data, mask) g_assert_cmphex((data) & (mask), ==, 0)
@@ -276,12 +282,17 @@ static void test_cmos(void)
     g_assert(cmos == 0x40 || cmos == 0x50);
 }
 
-static void media_insert(void)
+static void media_insert_path(const char *path)
 {
     qtest_qmp_assert_success(global_qtest,
                              "{'execute':'blockdev-change-medium', 'arguments':{"
                              " 'id':'floppy0', 'filename': %s, 'format': 'raw' }}",
-                             test_image);
+                             path);
+}
+
+static void media_insert(void)
+{
+    media_insert_path(test_image);
 }
 
 static void media_eject(void)
@@ -586,6 +597,222 @@ static void test_verify(void)
     g_assert(ret == 0);
 }
 
+/*
+ * Query cur_drv->last_sect using the SAVE command (CMD_SAVE, 0x2e).
+ * Byte 8 of the 15 result bytes returned by CMD_SAVE holds last_sect.
+ */
+static uint8_t get_lastsect(void)
+{
+    uint8_t res[15];
+    int i;
+
+    floppy_send(CMD_SAVE);
+    for (i = 0; i < 15; i++) {
+        res[i] = floppy_recv();
+    }
+    return res[8];
+}
+
+/*
+ * Attempt to set cur_drv->last_sect directly using the RESTORE command
+ * (CMD_RESTORE, 0x4e).
+ * While the 82078 datasheet describes RESTORE for restoring a previously
+ * saved state, a guest can issue raw RESTORE commands with arbitrary
+ * parameters without having issued SAVE. Parameter byte 9 is used by the
+ * controller to restore cur_drv->last_sect.
+ */
+static void fake_lastsect(uint8_t last_sect)
+{
+    floppy_send(CMD_RESTORE);
+    floppy_send(0); /* fifo[1] */
+    floppy_send(0); /* fifo[2] */
+    floppy_send(0); /* fifo[3]: drv0 track */
+    floppy_send(0); /* fifo[4]: drv1 track */
+    floppy_send(0); /* fifo[5]: drv2 track */
+    floppy_send(0); /* fifo[6]: drv3 track */
+    floppy_send(0); /* fifo[7]: timer0 */
+    floppy_send(0); /* fifo[8]: timer1 */
+    floppy_send(last_sect); /* fifo[9]: last_sect */
+    floppy_send(0); /* fifo[10]: lock/perpendicular */
+    floppy_send(0); /* fifo[11]: config */
+    floppy_send(0); /* fifo[12]: precomp_trk */
+    floppy_send(0); /* fifo[13]: pwrd */
+    floppy_send(0); /* fifo[14] */
+    floppy_send(0); /* fifo[15] */
+    floppy_send(0); /* fifo[16] */
+    floppy_send(0); /* fifo[17] */
+}
+
+static void send_format_track(uint8_t drive, uint8_t head, uint8_t last_sect,
+                              uint8_t *st0_out, uint8_t *st1_out)
+{
+    uint8_t st0, st1;
+
+    floppy_send(CMD_FORMAT_TRACK);
+    floppy_send((head << 2) | drive);
+    floppy_send(2);          /* 512 bytes per sector */
+    floppy_send(last_sect);  /* sectors per track */
+    floppy_send(0x1b);       /* GAP length */
+    floppy_send(0x00);       /* filler byte */
+
+    g_assert(get_irq(FLOPPY_IRQ));
+    st0 = floppy_recv();
+    st1 = floppy_recv();
+    floppy_recv(); /* st2 */
+    floppy_recv(); /* track */
+    floppy_recv(); /* head */
+    floppy_recv(); /* sect */
+    g_assert(get_irq(FLOPPY_IRQ));
+    floppy_recv(); /* sz */
+    g_assert(!get_irq(FLOPPY_IRQ));
+
+    if (st0_out) {
+        *st0_out = st0;
+    }
+    if (st1_out) {
+        *st1_out = st1;
+    }
+}
+
+/*
+ * Test that guest cannot set last_sect beyond the probed media size
+ * via RESTORE or FORMAT TRACK commands (gitlab issue #3800).
+ */
+static void test_last_sect_bounds(void)
+{
+    uint8_t st0, st1;
+
+    /* Start with 1.44 MB media inserted (last_sect = 18) */
+    media_insert();
+    send_seek(1);
+    send_seek(0);
+
+    /* Valid last_sect values (<= 18) should succeed */
+    fake_lastsect(18);
+    g_assert(!get_irq(FLOPPY_IRQ));
+    g_assert_cmpint(get_lastsect(), ==, 18);
+
+    fake_lastsect(9);
+    g_assert(!get_irq(FLOPPY_IRQ));
+    g_assert_cmpint(get_lastsect(), ==, 9);
+
+    /* Restoring to the default 18 */
+    fake_lastsect(18);
+    g_assert(!get_irq(FLOPPY_IRQ));
+    g_assert_cmpint(get_lastsect(), ==, 18);
+
+    /* Invalid last_sect value (> 18) must fail */
+    fake_lastsect(19);
+    g_assert(get_irq(FLOPPY_IRQ));
+    st0 = floppy_recv();
+    st1 = floppy_recv();
+    floppy_recv(); /* st2 */
+    floppy_recv(); /* track */
+    floppy_recv(); /* head */
+    floppy_recv(); /* sect */
+    g_assert(get_irq(FLOPPY_IRQ));
+    floppy_recv(); /* sz */
+    g_assert(!get_irq(FLOPPY_IRQ));
+    g_assert_cmpint(st0 & ST0_IC_MASK, ==, ST0_IC_ABNTERM);
+    g_assert_cmpint(st1 & ST1_EC, ==, ST1_EC);
+
+    /* Verify last_sect was not changed to 19 */
+    g_assert_cmpint(get_lastsect(), ==, 18);
+
+    /* FORMAT TRACK with valid last_sect (18) should succeed */
+    send_format_track(0, 0, 18, &st0, &st1);
+    g_assert_cmpint(st0 & ST0_IC_MASK, ==, 0);
+    g_assert_cmpint(st1, ==, 0);
+
+    /* FORMAT TRACK with invalid last_sect (19) must fail */
+    send_format_track(0, 0, 19, &st0, &st1);
+    g_assert_cmpint(st0 & ST0_IC_MASK, ==, ST0_IC_ABNTERM);
+    g_assert_cmpint(st1 & ST1_EC, ==, ST1_EC);
+
+    /* Change media to 720 kB floppy (last_sect = 9) */
+    media_eject();
+    media_insert_path(test_image_720k);
+    send_seek(1);
+    send_seek(0);
+
+    /* Probed geometry now has last_sect = 9 */
+    fake_lastsect(9);
+    g_assert(!get_irq(FLOPPY_IRQ));
+    g_assert_cmpint(get_lastsect(), ==, 9);
+
+    /* Values exceeding 9 (e.g. 10 or 18) must now fail */
+    fake_lastsect(10);
+    g_assert(get_irq(FLOPPY_IRQ));
+    st0 = floppy_recv();
+    st1 = floppy_recv();
+    floppy_recv();
+    floppy_recv();
+    floppy_recv();
+    floppy_recv();
+    g_assert(get_irq(FLOPPY_IRQ));
+    floppy_recv();
+    g_assert(!get_irq(FLOPPY_IRQ));
+    g_assert_cmpint(st0 & ST0_IC_MASK, ==, ST0_IC_ABNTERM);
+    g_assert_cmpint(st1 & ST1_EC, ==, ST1_EC);
+
+    fake_lastsect(18);
+    g_assert(get_irq(FLOPPY_IRQ));
+    st0 = floppy_recv();
+    st1 = floppy_recv();
+    floppy_recv();
+    floppy_recv();
+    floppy_recv();
+    floppy_recv();
+    g_assert(get_irq(FLOPPY_IRQ));
+    floppy_recv();
+    g_assert(!get_irq(FLOPPY_IRQ));
+    g_assert_cmpint(st0 & ST0_IC_MASK, ==, ST0_IC_ABNTERM);
+    g_assert_cmpint(st1 & ST1_EC, ==, ST1_EC);
+
+    /* FORMAT TRACK on 720 kB floppy */
+    send_format_track(0, 0, 9, &st0, &st1);
+    g_assert_cmpint(st0 & ST0_IC_MASK, ==, 0);
+    g_assert_cmpint(st1, ==, 0);
+
+    send_format_track(0, 0, 10, &st0, &st1);
+    g_assert_cmpint(st0 & ST0_IC_MASK, ==, ST0_IC_ABNTERM);
+    g_assert_cmpint(st1 & ST1_EC, ==, ST1_EC);
+
+    send_format_track(0, 0, 18, &st0, &st1);
+    g_assert_cmpint(st0 & ST0_IC_MASK, ==, ST0_IC_ABNTERM);
+    g_assert_cmpint(st1 & ST1_EC, ==, ST1_EC);
+
+    /*
+     * Change back to 1.44 MB floppy and verify last_sect = 18 is allowed
+     * again.
+     */
+    media_eject();
+    media_insert();
+    send_seek(1);
+    send_seek(0);
+
+    fake_lastsect(18);
+    g_assert(!get_irq(FLOPPY_IRQ));
+    g_assert_cmpint(get_lastsect(), ==, 18);
+
+    fake_lastsect(19);
+    g_assert(get_irq(FLOPPY_IRQ));
+    st0 = floppy_recv();
+    st1 = floppy_recv();
+    floppy_recv();
+    floppy_recv();
+    floppy_recv();
+    floppy_recv();
+    g_assert(get_irq(FLOPPY_IRQ));
+    floppy_recv();
+    g_assert(!get_irq(FLOPPY_IRQ));
+    g_assert_cmpint(st0 & ST0_IC_MASK, ==, ST0_IC_ABNTERM);
+    g_assert_cmpint(st1 & ST1_EC, ==, ST1_EC);
+
+    /* Leave drive empty */
+    media_eject();
+}
+
 /* success if no crash or abort */
 static void fuzz_registers(void)
 {
@@ -661,10 +888,16 @@ int main(int argc, char **argv)
     int fd;
     int ret;
 
-    /* Create a temporary raw image */
+    /* Create temporary raw images */
     fd = g_file_open_tmp("qtest.XXXXXX", &test_image, NULL);
     g_assert(fd >= 0);
-    ret = ftruncate(fd, TEST_IMAGE_SIZE);
+    ret = ftruncate(fd, TEST_IMAGE_1440KB);
+    g_assert(ret == 0);
+    close(fd);
+
+    fd = g_file_open_tmp("qtest720.XXXXXX", &test_image_720k, NULL);
+    g_assert(fd >= 0);
+    ret = ftruncate(fd, TEST_IMAGE_720KB);
     g_assert(ret == 0);
     close(fd);
 
@@ -686,6 +919,7 @@ int main(int argc, char **argv)
     qtest_add_func("/fdc/read_no_dma_1", test_read_no_dma_1);
     qtest_add_func("/fdc/read_no_dma_18", test_read_no_dma_18);
     qtest_add_func("/fdc/read_no_dma_19", test_read_no_dma_19);
+    qtest_add_func("/fdc/last_sect_bounds", test_last_sect_bounds);
     qtest_add_func("/fdc/fuzz-registers", fuzz_registers);
     qtest_add_func("/fdc/fuzz/cve_2021_20196", test_cve_2021_20196);
     qtest_add_func("/fdc/fuzz/cve_2021_3507", test_cve_2021_3507);
@@ -696,6 +930,8 @@ int main(int argc, char **argv)
     qtest_end();
     unlink(test_image);
     g_free(test_image);
+    unlink(test_image_720k);
+    g_free(test_image_720k);
 
     return ret;
 }

-- 
2.47.3


