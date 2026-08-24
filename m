Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB657C5DF9C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 20:07:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyawN-0000K9-0d; Mon, 24 Aug 2026 16:06:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wyawL-0000Jl-Ou
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 16:06:41 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wyawK-0004Zn-7E
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 16:06:41 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-69f7fa1c548so7168535a12.2
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 13:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787601999; x=1788206799; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zefcis5EP0IMyzuxM7R1Khej6wymuVyXd6Sozi1W8vk=;
 b=n8JDtwebWB7vby70XOgjNO28hph/k9m/LJJwYmBfO/C4UlSgkwWPdSGQAY/7MO8t35
 uBMKXbQZn7BFQkIoaPU6qzGtOivXvt+zlCo72ZpDRyvrldUVHKpAzHd96am3GXAremM1
 vxON9bW475sIanAt/qZkHCOG3CK7gRK5dzHwTycYn3FkSmr6eX8sQ39PvJQIfn1EDWak
 OICCUXmZaYZPCF966INaEwZRareO0dxGNf+CIGIu8D78dEhIQ3TGKCbIkcXeoK9px9q3
 nCDrinEe08stayGSTuyOV5lcdCMQu9BCRQisyMGhrydPOpJPzMB4nA8dAGJ105cGBEBY
 BQnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787601999; x=1788206799;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zefcis5EP0IMyzuxM7R1Khej6wymuVyXd6Sozi1W8vk=;
 b=B/C8Xtr675JJynoXuEKtL62+KPJaCKP14yE/Uh/Ib+1h2JVqZI0HACbFsnVtlgsSxz
 9M3R2b2JKoevphlg+G7A68eLUcnJLmCmQvQDovWJi6BUFlc0S6rWer5cq/3+G7BLDs7p
 2XSbUP4vezBna7aF8chQliYB4I3iVgp6Covv1E8oktPG1H1BsguKJp9VPIczw5WwTgge
 4JaNYRsRU3KMhbWwTg9n4XNyY8CJPINZAQxxJpUN0lhxHwpjDd+SVB25QYYgx9HpuOvp
 gHXVGRrhoYm97IuFNqoy5PHTemlroMofyr6Bo20SLQXSY6+7DMtt4pDMk762Q37rm1Qq
 kkQA==
X-Gm-Message-State: AFuF++mU2W5Mo06YyL8NYUz/fpJVYz6q3qr4xB6hBsRwf3mSMUGmYeyb
 bpNx8EwFJv8Jflwladn7DdlCoUq+Dlj+RSi9WBZkIjsnKc4M952dF7jFOujxI5sSu4QCihTDVzb
 KIgpF
X-Gm-Gg: AR+sD13XOgmgiNBwnmGfci4qJnfbH/MYdJ1XsQ5VBWmSUdH4OZ8S+8zYZyQeBYJJgJX
 S+BZtR/bHR6Fju0AtuF7bt6cteWmWHU5pWz2lhXUDhl5vEbaVidYhIzbpMtRdK5DNhSkCQ2agyy
 VJex5B5tynmJpa4J9WyJkwJEVQ3u3xBTQBkklA2w3Fh/7+mrCFNPg3+n9x64wv/ZaopPpVbBGAB
 CVRZDjd/hcQNkU/iLhB80YWi3ZkyU1vSb96YQROe27XgqCJf+VNUBtEtMNbN31YdREEARqDeBh/
 XFkvFtoWKvh5KGr64lO0Fd5yxbq3gwLZ8EaYrOkv05FAanqKJUnfuPNIw69XvqxdhmZueHyT9Ss
 NvICTg6745V4W84+rIU7gTTrTcrVSnNv2d4iypKufQISArF/p+9086+XWf3Y3mRSbgJV30uaW3O
 byxiE7J1yHrRXJK1jeiZ25JwLhGVGJsO3U3Vra1xChZn43y2h2G0C1gqkMXw==
X-Received: by 2002:a05:6402:4342:b0:6a3:f8ab:19f7 with SMTP id
 4fb4d7f45d1cf-6a582b7d8b0mr24049303a12.11.1787601998843; 
 Mon, 24 Aug 2026 13:06:38 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:9048:7bf0:d3e2:2b9e])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a59e0228f1sm6152245a12.10.2026.08.24.13.06.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 13:06:37 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH 4/7] tests/qtest/hd-geo-test: skip when the scratch file
 cannot be created
Date: Mon, 24 Aug 2026 22:06:24 +0200
Message-ID: <20260824200627.2180635-5-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAFn=p-bCR4TvVvHwagXiK-c0wuY5dACwh92249Wv0C3odCtbOg@mail.gmail.com>
References: <CAFn=p-bCR4TvVvHwagXiK-c0wuY5dACwh92249Wv0C3odCtbOg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=den@openvz.org; helo=mail-ed1-x531.google.com
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

Commit a0d6d7454a ("tests/hd-geo-test: Skip test when images can not
be created") skips when the 4 GiB image cannot be sized, but the
temporary file itself is still asserted on, and a file system with no
room left fails g_file_open_tmp() as surely as the ftruncate().

Skip there too and say why in both cases, from inside
create_test_img() where the GError is. Unlink the image that could not
be sized while here.

Cc: John Snow <jsnow@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 tests/qtest/hd-geo-test.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/tests/qtest/hd-geo-test.c b/tests/qtest/hd-geo-test.c
index 41481a5e09..e3b4a4db31 100644
--- a/tests/qtest/hd-geo-test.c
+++ b/tests/qtest/hd-geo-test.c
@@ -27,15 +27,24 @@
 
 static char *create_test_img(int secs)
 {
+    g_autoptr(GError) error = NULL;
     char *template;
-    int fd, ret;
+    int fd, ret, err;
+
+    fd = g_file_open_tmp("qtest.XXXXXX", &template, &error);
+    if (fd < 0) {
+        g_test_message("Could not create a temporary file: %s",
+                       error->message);
+        return NULL;
+    }
 
-    fd = g_file_open_tmp("qtest.XXXXXX", &template, NULL);
-    g_assert(fd >= 0);
     ret = ftruncate(fd, (off_t)secs * 512);
+    err = errno;
     close(fd);
 
     if (ret) {
+        g_test_message("Could not size %s: %s", template, strerror(err));
+        unlink(template);
         g_free(template);
         template = NULL;
     }
@@ -1059,7 +1068,6 @@ int main(int argc, char **argv)
         if (img_secs[i] >= 0) {
             img_file_name[i] = create_test_img(img_secs[i]);
             if (!img_file_name[i]) {
-                g_test_message("Could not create test images.");
                 goto test_add_done;
             }
         } else {
-- 
2.53.0


