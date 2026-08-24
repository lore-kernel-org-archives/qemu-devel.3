Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89B37C5DF9C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 20:08:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyawR-0000Me-4L; Mon, 24 Aug 2026 16:06:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wyawP-0000Lz-FU
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 16:06:45 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wyawN-0004ae-Hd
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 16:06:45 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-69f7fa1c548so7168619a12.2
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 13:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787602002; x=1788206802; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ycG6Ljrdkey67bf40u4rbUgKuhnsQ+73913h+Dln1C8=;
 b=Rb2FY92R8YXD/HwzkP7sW2Sl9Rz0n9Yos1AOc5S48pT0H+/0YR5IX6+ltF7Ik5imqw
 CPnw9PhAKEKHNwNQc+gARJvEqtmDvuk3YkZYsX8yM8JWUxTw+kpt+6knNCg1HPzLwegr
 LPD7VMWNPNMQr1i7Lenn9kcv56pJ/xLu/HW/7OXLQbH9VyrcKgpmxFDJfU0MjVD3kWxq
 cDinMTdAaBHAJnUBVDq9f2gKld4xEf0g/LDwrnTZZYIyzjp3AmFHLyeCWf5f39ZyR4hN
 ZBWKpOyoNFZ1YsXbD8wafBilmO6VAaddQUVgsdN4C5e4GfLZ0mcyxaGJuAAgYhTZhTiY
 qFhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787602002; x=1788206802;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ycG6Ljrdkey67bf40u4rbUgKuhnsQ+73913h+Dln1C8=;
 b=OHto6ORu5fSEQrVOLypwgiOsDfPmmcBCsZ57dsOhmSfHTGe2F7ZTsG9m9xz7bmEVK6
 k2w3GchnfLR2vrfTKMS0vAmDZCk0T03lOxV+tvjfto4XCuke4jDL61RuI746O0tlaPPs
 yrLLckC7xm61KkhLbaduzxpfH7XCapYSCg08XtsIIhGiAZISDFWOoYGsjqKlTD98pCam
 6qyeioOPkQYFMLdNCk+0kd/pdSSyXJlVIefGZ5qRGe+KUuVZ3Dj8i5egddisoM2ESJgf
 IsyFZXMaTJdWfxBYWgCJgKIAR0Nd38nOC2oB0+oipfhapczL57ujF9/N2Kd1KDGDu53Q
 T5zA==
X-Gm-Message-State: AFuF++n5dPMwDyaMzF/lmrCHtj0wr2WvZd4UIzEDif/7jF+97kWiXgs2
 GUSit//fbWguNaV+chzOyTEDKwEN3K8LPOpIt8/LMXL2Z000IV9Am0dz49e4xfCbJ0Qs0Nh0ktz
 lyTAU
X-Gm-Gg: AR+sD12RIeh/ZS5LVDxhbVoUkvg6z37UepoqxSlhl54YR/GEumtcViw/wO0oy7KxAUg
 vbr4GNantr2PI4QS7it1cTFhF3AtdIS+eIGPfRMuCtzgUUIFjtiSZVuZcwy/G96KL5UYjIf+1ue
 QcG0PROnYYF7KgLY5Cb0mLCbyBhoQ20XnGskpR5iatbcibTMVFQs+MNKoxTItHWD4Wtl84u2/xT
 zMGQ0PE/i4AB4bLDVWYSPM5+Nwoi976BUHGNLXKIPqIkx479LI8Fmt8plyv2lJMCBrfoYP6tDjZ
 VBHggPmzXgxDcApRwTzfiga56JZnT/7UjZ0V/1zuQ9gTpCnm5uW+eUy8Nrse7z+cWiBCpR9xIfQ
 Zr+pkrnhX/HM2jfUCF81lHLlOlZdoeVWavyqcFJvzvJBNMEOPWLIdYclya7a9dlPZUugTE1bATo
 ZZVz/aIwJUGsOLXojK2M41xAeGY9TPQa4ngIU5BHTbnnGX9M+2jcOaA+tTJA==
X-Received: by 2002:a05:6402:3202:b0:6a1:b515:d2b9 with SMTP id
 4fb4d7f45d1cf-6a582ba2f09mr24698882a12.14.1787602002117; 
 Mon, 24 Aug 2026 13:06:42 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:9048:7bf0:d3e2:2b9e])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a59e0228f1sm6152245a12.10.2026.08.24.13.06.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 13:06:41 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH 7/7] tests/qtest/hd-geo-test: build the test images with
 qemu-img
Date: Mon, 24 Aug 2026 22:06:27 +0200
Message-ID: <20260824200627.2180635-8-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAFn=p-bCR4TvVvHwagXiK-c0wuY5dACwh92249Wv0C3odCtbOg@mail.gmail.com>
References: <CAFn=p-bCR4TvVvHwagXiK-c0wuY5dACwh92249Wv0C3odCtbOg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=den@openvz.org; helo=mail-ed1-x536.google.com
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

The two backing images are raw and are grown with ftruncate(), one to
30 MiB and one to 4 GiB, so on a host where sparse files are not free
the test skips and the BIOS geometry goes untested.

The override tests already build their images with qemu-img, so use
the same route here. The convert and resize pair moves into
mkqcow2_with_mbr(), which both users call and which reports a failed
qemu-img rather than asserting. setup_mbr() stamps the MBR by
rebuilding the image, that being the only way to reach sector 0 of a
qcow2 from outside QEMU. Only the setup running before any test can
skip, so the rest keep asserting. Without qemu-img the images stay
raw.

Peak scratch space drops from 4126 MiB to 1.5 MiB.

Cc: John Snow <jsnow@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 tests/qtest/hd-geo-test.c | 129 +++++++++++++++++++++++++-------------
 1 file changed, 86 insertions(+), 43 deletions(-)

diff --git a/tests/qtest/hd-geo-test.c b/tests/qtest/hd-geo-test.c
index e3b4a4db31..160bdc7216 100644
--- a/tests/qtest/hd-geo-test.c
+++ b/tests/qtest/hd-geo-test.c
@@ -25,9 +25,69 @@
 
 #define ARGV_SIZE 256
 
+#define MBR_SIZE 512
+
+static const char *imgfmt = "raw";
+
+static bool mkqcow2_with_mbr(const char *path, const uint8_t *mbr,
+                             uint64_t size)
+{
+    g_autoptr(GError) error = NULL;
+    g_autofree char *raw_path = NULL;
+    char cmd[100 + 2 * PATH_MAX];
+    char *qemu_img_path;
+    char *qemu_img_abs_path = NULL;
+    bool ok = false;
+    int fd, ret;
+
+    fd = g_file_open_tmp("qtest.XXXXXX", &raw_path, &error);
+    if (fd < 0) {
+        g_test_message("Could not create a temporary file: %s",
+                       error->message);
+        return false;
+    }
+    ret = write(fd, mbr, MBR_SIZE);
+    g_assert(ret == MBR_SIZE);
+    close(fd);
+
+    qemu_img_path = getenv("QTEST_QEMU_IMG");
+    g_assert(qemu_img_path);
+    qemu_img_abs_path = realpath(qemu_img_path, NULL);
+    g_assert(qemu_img_abs_path);
+
+    ret = snprintf(cmd, sizeof(cmd),
+                   "%s convert -f raw -O qcow2 %s %s > /dev/null",
+                   qemu_img_abs_path,
+                   raw_path, path);
+    g_assert((0 < ret) && (ret <= sizeof(cmd)));
+    if (system(cmd) != 0) {
+        g_test_message("Could not create %s with qemu-img", path);
+        goto out;
+    }
+
+    ret = snprintf(cmd, sizeof(cmd),
+                   "%s resize %s %" PRIu64 " > /dev/null",
+                   qemu_img_abs_path,
+                   path, size);
+    g_assert((0 < ret) && (ret <= sizeof(cmd)));
+    if (system(cmd) != 0) {
+        g_test_message("Could not size %s with qemu-img", path);
+        goto out;
+    }
+
+    ok = true;
+
+out:
+    free(qemu_img_abs_path);
+    unlink(raw_path);
+
+    return ok;
+}
+
 static char *create_test_img(int secs)
 {
     g_autoptr(GError) error = NULL;
+    uint8_t blank_mbr[MBR_SIZE] = {};
     char *template;
     int fd, ret, err;
 
@@ -38,6 +98,16 @@ static char *create_test_img(int secs)
         return NULL;
     }
 
+    if (!strcmp(imgfmt, "qcow2")) {
+        close(fd);
+        if (!mkqcow2_with_mbr(template, blank_mbr, (uint64_t)secs * 512)) {
+            unlink(template);
+            g_free(template);
+            return NULL;
+        }
+        return template;
+    }
+
     ret = ftruncate(fd, (off_t)secs * 512);
     err = errno;
     close(fd);
@@ -207,7 +277,7 @@ static void setup_mbr(int img_idx, MBRcontents mbr)
         /* chs 0,1,1 (lba 63) to chs 7,15,63 (8001 sectors) */
         0x80, 1, 1, 0, 6,  15, 63, 7, 63, 0, 0, 0, 0x41, 0x1F, 0, 0,
     };
-    uint8_t buf[512];
+    uint8_t buf[MBR_SIZE];
     int fd, ret;
 
     memset(buf, 0, sizeof(buf));
@@ -218,6 +288,12 @@ static void setup_mbr(int img_idx, MBRcontents mbr)
         memcpy(buf + 0x1BE, mbr == mbr_lba ? part_lba : part_chs, 16);
     }
 
+    if (!strcmp(imgfmt, "qcow2")) {
+        g_assert_true(mkqcow2_with_mbr(img_file_name[img_idx], buf,
+                                       (uint64_t)img_secs[img_idx] * 512));
+        return;
+    }
+
     fd = open(img_file_name[img_idx], O_WRONLY);
     g_assert(fd >= 0);
     ret = write(fd, buf, sizeof(buf));
@@ -237,7 +313,8 @@ static int setup_ide(int argc, char *argv[], int argv_sz,
 
     if (img_secs[img_idx] >= 0) {
         setup_mbr(img_idx, mbr);
-        s3 = g_strdup_printf(",format=raw,file=%s", img_file_name[img_idx]);
+        s3 = g_strdup_printf(",format=%s,file=%s", imgfmt,
+                             img_file_name[img_idx]);
     } else {
         s3 = g_strdup(",media=cdrom");
     }
@@ -431,15 +508,10 @@ static MBRpartitions empty_mbr = { {false, 0, 0, 0, 0, 0, 0, 0, 0},
 
 static char *create_qcow2_with_mbr(MBRpartitions mbr, uint64_t sectors)
 {
-    g_autofree char *raw_path = NULL;
     char *qcow2_path;
-    char cmd[100 + 2 * PATH_MAX];
-    uint8_t buf[512] = {};
-    int i, ret, fd, offset;
-    uint64_t qcow2_size = sectors * 512;
+    uint8_t buf[MBR_SIZE] = {};
+    int i, fd, offset;
     uint8_t status, parttype, head, sector, cyl;
-    char *qemu_img_path;
-    char *qemu_img_abs_path;
 
     offset = 0xbe;
 
@@ -476,44 +548,11 @@ static char *create_qcow2_with_mbr(MBRpartitions mbr, uint64_t sectors)
         offset += 0x10;
     }
 
-    fd = g_file_open_tmp("qtest.XXXXXX", &raw_path, NULL);
-    g_assert(fd >= 0);
-    close(fd);
-
-    fd = open(raw_path, O_WRONLY);
-    g_assert(fd >= 0);
-    ret = write(fd, buf, sizeof(buf));
-    g_assert(ret == sizeof(buf));
-    close(fd);
-
     fd = g_file_open_tmp("qtest.XXXXXX", &qcow2_path, NULL);
     g_assert(fd >= 0);
     close(fd);
 
-    qemu_img_path = getenv("QTEST_QEMU_IMG");
-    g_assert(qemu_img_path);
-    qemu_img_abs_path = realpath(qemu_img_path, NULL);
-    g_assert(qemu_img_abs_path);
-
-    ret = snprintf(cmd, sizeof(cmd),
-                   "%s convert -f raw -O qcow2 %s %s > /dev/null",
-                   qemu_img_abs_path,
-                   raw_path, qcow2_path);
-    g_assert((0 < ret) && (ret <= sizeof(cmd)));
-    ret = system(cmd);
-    g_assert(ret == 0);
-
-    ret = snprintf(cmd, sizeof(cmd),
-                   "%s resize %s %" PRIu64 " > /dev/null",
-                   qemu_img_abs_path,
-                   qcow2_path, qcow2_size);
-    g_assert((0 < ret) && (ret <= sizeof(cmd)));
-    ret = system(cmd);
-    g_assert(ret == 0);
-
-    free(qemu_img_abs_path);
-
-    unlink(raw_path);
+    g_assert_true(mkqcow2_with_mbr(qcow2_path, buf, sectors * 512));
 
     return qcow2_path;
 }
@@ -1064,6 +1103,10 @@ int main(int argc, char **argv)
 
     g_test_init(&argc, &argv, NULL);
 
+    if (have_qemu_img()) {
+        imgfmt = "qcow2";
+    }
+
     for (i = 0; i < backend_last; i++) {
         if (img_secs[i] >= 0) {
             img_file_name[i] = create_test_img(img_secs[i]);
-- 
2.53.0


