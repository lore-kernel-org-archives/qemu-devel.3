Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43053C5DF9C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 20:07:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyawP-0000LE-4V; Mon, 24 Aug 2026 16:06:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wyawN-0000KA-2X
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 16:06:43 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wyawL-0004aA-2C
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 16:06:42 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6a36982a875so5964601a12.0
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 13:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787602000; x=1788206800; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ggcp1ncJ6jqxbzs7zCMMoYXXIy7due6cZVPwmVdRZM0=;
 b=e7cdAxS15S05RGMA5gtHTtyPJ+5Dxq/EpMIiMRnoJZfGHhyycNyXGQDAJglmk/NLlx
 F43O4vtwU4SDPrKxUBAxm9oAjCxJedZQoBhnxXadn6fDMGkzzs9RoyFrMu6vxDrfCLn8
 aUKM5B5WpVidXywBdPnHJW/H1ojZhfTaCuOzdj3Bq8gzbDweJIphNWY31fJ/1wk9Pyjn
 LWRUx1J2O7ij760HbHpF1dbhAEPcF0e7pvDbJrVTcVKbrzu2jjNaE0J85oFPZm4KZFMo
 d7JTTNbWNXS0ALMopm6c7VAsvio6iTnOOoDe9oCHStAgi8RUfijkvHa37ITXh4nr2HRW
 DLVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787602000; x=1788206800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ggcp1ncJ6jqxbzs7zCMMoYXXIy7due6cZVPwmVdRZM0=;
 b=etJn8Z5X7rlCBYzDI0GZ9GUiYoY5RCIyeHGhnsGrBOcEwSHBqNfdzxzhGpelzhwJSU
 AjwIc4GFeEAbajb0+wDiRdUeIslfHEe6BttUh12a1VFe7Q4tKT8uAjw7c9Na+7GpcdVz
 N6SVpZ/Ce5h5DnRMqDHbDsHQD6ZWKkVCD4ilieJlRaL6G0g6CnbH6vLYj2WUc0YY0VFz
 zhTG00e0Z+M9QKE9v2zQ3KdbhzV4nQBBf82fNIy7IZi8y5ec6bcN0XqZsjt3e+av4bgB
 IrUJSgyzJyMbbgE5j+DbWW/WnId1xyv3T+Az6u5M/xRTM3Lf1ZSzugRV4sUR/6P1KrT8
 isaA==
X-Gm-Message-State: AFuF++mxAxcZiZhib2MCJcLT7V2v9x0R6JhMOzuadrnZx+GVcd9YVLRN
 SmFjTk3ElV+8ZjIZCBSR3QNdDNjbEz2I87y9WkhS87ZfukY9LZbbsmcV9R4s3iod0H0EIXwfyZd
 6/XCC
X-Gm-Gg: AR+sD11uPuJct0vl6NMxs8NnatpR2nxb+vAFq1abTxtwUrB3G8di2G+TSAcaoZFwl21
 VakgjsBiEh27Sxjq6VtyJ5KoA26KEikvvebb3L1e8QpR2COid4igtWMI+VSIqz98pCcRKS8LfOs
 at80pF7qYTS3VE+ZE6xGXIuwLDzJ2Gf5SG0Iai6CQNwk70GMV5jm7R6J+VhswFaw1Mn6YtZY32o
 g7+6wmmbp1OMnPctsM2DmQYm/aRA9l4FCvRMP2G8ByFIBAaQNIiAvXcZ8kaxqHf+flK4lJpcA0t
 Vn1MmyChXarRyFsIuE9WwBfTnsSZhHQrQZ8rTbsd9bTF0QE4RvcKQm282VXybNY6Dc3QzHhOS8K
 qoBUyssGxrxPXvySs6e4/ES3D5Jlx4QJFBE+GKi60sC/dgRWRY7cBMjcCwusFWMavOu8DoT+bl5
 WE6wOyt9+kBrXBgHfS64uWZq8vwQzkkGLKRNgixUXNSMv8um53IvalvR984w==
X-Received: by 2002:a05:6402:42c4:b0:6a3:e813:8457 with SMTP id
 4fb4d7f45d1cf-6a42f1f9e90mr32730701a12.12.1787601999775; 
 Mon, 24 Aug 2026 13:06:39 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:9048:7bf0:d3e2:2b9e])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a59e0228f1sm6152245a12.10.2026.08.24.13.06.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 13:06:39 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH 5/7] tests/qtest/libqtest: create images with a byte-precise
 size
Date: Mon, 24 Aug 2026 22:06:25 +0200
Message-ID: <20260824200627.2180635-6-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAFn=p-bCR4TvVvHwagXiK-c0wuY5dACwh92249Wv0C3odCtbOg@mail.gmail.com>
References: <CAFn=p-bCR4TvVvHwagXiK-c0wuY5dACwh92249Wv0C3odCtbOg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=den@openvz.org; helo=mail-ed1-x529.google.com
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

mkimg() takes megabytes, which is all its callers have needed so far.
ide-test wants an image whose length is an exact multiple of its CHS
geometry, 130 * 16 * 63 sectors, and that is not a whole number of
megabytes. Add mkimg_bytes() and let mkimg() go through it.

Cc: John Snow <jsnow@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 tests/qtest/libqtest.c |  9 +++++++--
 tests/qtest/libqtest.h | 12 ++++++++++++
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index bec37c71b8..1ae004e6f3 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -2115,6 +2115,11 @@ bool have_qemu_img(void)
 }
 
 bool mkimg(const char *file, const char *fmt, unsigned size_mb)
+{
+    return mkimg_bytes(file, fmt, (uint64_t)size_mb * 1024 * 1024);
+}
+
+bool mkimg_bytes(const char *file, const char *fmt, uint64_t size)
 {
     gchar *cli;
     bool ret;
@@ -2133,8 +2138,8 @@ bool mkimg(const char *file, const char *fmt, unsigned size_mb)
         return false;
     }
 
-    cli = g_strdup_printf("%s create -f %s %s %uM", qemu_img_abs_path,
-                          fmt, file, size_mb);
+    cli = g_strdup_printf("%s create -f %s %s %" PRIu64, qemu_img_abs_path,
+                          fmt, file, size);
     ret = g_spawn_command_line_sync(cli, &out, &out2, &rc, &err);
     if (err || !g_spawn_check_exit_status(rc, &err)) {
         fprintf(stderr, "%s\n", err->message);
diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
index 45217fb8dc..6720ca2de2 100644
--- a/tests/qtest/libqtest.h
+++ b/tests/qtest/libqtest.h
@@ -1186,6 +1186,18 @@ bool have_qemu_img(void);
  */
 bool mkimg(const char *file, const char *fmt, unsigned size_mb);
 
+/**
+ * mkimg_bytes:
+ * @file: File name of the image that should be created
+ * @fmt: Format, e.g. "qcow2" or "raw"
+ * @size: Size of the image in bytes
+ *
+ * As mkimg(), for images whose size is not a whole number of megabytes.
+ *
+ * Returns: true if the image has been created successfully.
+ */
+bool mkimg_bytes(const char *file, const char *fmt, uint64_t size);
+
 /**
  * qtest_verbose:
  * @domain: The logging domain
-- 
2.53.0


