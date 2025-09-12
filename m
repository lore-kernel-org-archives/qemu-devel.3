Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64EBBCAC582
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 03:44:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwuhE-00073n-V4; Thu, 11 Sep 2025 23:43:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1uwuh1-00070R-No
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 23:43:24 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1uwugr-0007v2-Sl
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 23:43:23 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-45de287cc11so13615185e9.1
 for <qemu-devel@nongnu.org>; Thu, 11 Sep 2025 20:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757648584; x=1758253384; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rvBTG/+9uS+f4Heq4c0Vn8ltH3qtiDIFK5wU9txYcq8=;
 b=R8vT40dzkTHJcAi6RoSIrahsYJ7JgofqlPRzMJSrQORi6p4a6hg1StdvcUlAkDPAFE
 ON6eYqJmA5WQorUD9UVWxWbVv3isAQv7t0BZ3KDrixuHhW2QX9GOUufmHb9PJBcG2eJr
 OKI9cQ/e09h58oaimS0CiRraJwS5M+xpsYB7/xrHeyQITwxH72eShMGkpU94bmpjrG+v
 b0dOv7tfrrbIXjQ1fL/SdK1nPoCngj/dl6tTx+FuAWaEUf2J2CYf5/0zAUtcCwy3uUS7
 Kij4fgJXRI9ck2KsmGZzYP/HwmnOoH9JwW9z/Big6M6N8yY13bylt63PgEiYVbz9t1Y0
 Lh+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757648584; x=1758253384;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rvBTG/+9uS+f4Heq4c0Vn8ltH3qtiDIFK5wU9txYcq8=;
 b=r/cjfIo1C3/qxPpbJ+1xwQg145opw7yn/QH/DccWO46MIfzvczYSPhSnGSsvITTDrx
 bd4t7vd+026VSwdqUQrBsBcN1qieaUtpQJPo3LXB+7FVZxi3L5o3oIhr9WSgYO5A7uIC
 61VC79UVkmmc7MUeVV20ukqi+UBr7oAr5tH4EWwPaXf2QjWUEqnKeseioSLXuDx199g/
 XXaYptv1jUCnwkcvRP/C6BAGitVZqCFUOD3tDjzv5qtL78m6cHGn9NcIRRSEsyQH2/ts
 Wq//fGzQopnZhqLs5RxdQfc8Yv61pCrZZxaF5NlsOn/8NP9fw84zMcpIt6jE2xsAVgta
 0f5g==
X-Gm-Message-State: AOJu0YxYOjxMAEY7vhpOfJhm7MFqrIYMTC16dtMmX1jmOxbefiZ7Blqh
 gpZclY8ylZAfa3G7HrZk2FLbUPlV3aUUMCDSRrGn3Lun6XEYZzwoZkmV
X-Gm-Gg: ASbGncuXouQAo6hB5swhwzT3VW7fmF5eV2IQejOKhvpWTmRSWThxkNh+NSfsHOO4xvK
 BDb3Qg4QRSpET91b9CXN7DoacUwjGEvjKw1NA7lEY85Cfz20GOsRQRNnP5tTAFe+wa72743jvzC
 r+AFmK+t9XyrPUlDWJBDXCLiYbQ5lb0v9RLv4/ARCf+3Bno5l1pOhr8Ra4T0Ww/bFpgSfOEuM+z
 sble9trXw4wQfq8z7tR8oiknSiY1Pu6YWCp86bMnUzJ7FpwsHCuRkom8g3z3Rp2/MclwH9WA9++
 UIVJI3f7buJQQDSK9etgvptRIdeLH9O3Pd1D40XsEvCDgpRn/ecbyJQ0X4zNTkzF1wq5RbKg5zN
 WR9ynxSXizrLFTfuKTGAAya2irnGbHtlfJ2C40UhKShc3+5tGzlTo
X-Google-Smtp-Source: AGHT+IEfvck7wnRYTk2oXQNe0QlyIoD9k9TagijaTv8UKPinsxSram1eYstKLL1yoJHlsoZCMBW5OA==
X-Received: by 2002:a05:6000:40c9:b0:3b9:14f2:7edf with SMTP id
 ffacd0b85a97d-3e75e0f021emr3838422f8f.1.1757648583904; 
 Thu, 11 Sep 2025 20:43:03 -0700 (PDT)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-3e7607d7b67sm4854169f8f.49.2025.09.11.20.43.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Sep 2025 20:43:03 -0700 (PDT)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Fri, 12 Sep 2025 05:39:48 +0200
Subject: [PATCH v4 03/10] chardev: add qemu_chr_resize()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-console-resize-v4-3-7925e444afc4@gmail.com>
References: <20250912-console-resize-v4-0-7925e444afc4@gmail.com>
In-Reply-To: <20250912-console-resize-v4-0-7925e444afc4@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>, 
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Szymon Lukasz <noh4hss@gmail.com>, Filip Hejsek <filip.hejsek@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757648576; l=1677;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=EbVowVm5LMaQukItgCxeH7pJeB8Mnn5jMPvv+tRJQpY=;
 b=TcTTZbYWPtZHagEsmXmmS5TTyqrgCMZKCzF6c6t1UxFEgDo2Iem5OPaJEUPXthyRh/PiCr+4B
 rBCtxNjU+l3BqDiuapunLEHlv/49DEaC735i695VP4CqMgK2pix4e1h
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wm1-x329.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Szymon Lukasz <noh4hss@gmail.com>

This function should be called whenever we learn about a new size of
the terminal connected to a chardev.

Signed-off-by: Szymon Lukasz <noh4hss@gmail.com>
Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
---
 chardev/char.c         | 11 +++++++++++
 include/chardev/char.h |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/chardev/char.c b/chardev/char.c
index 635d19fea4fd4bd0c7f171f055fe940f9f5ebed5..b45d79cb9b57643827eb7479257fdda2cf6b0434 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -351,6 +351,17 @@ int qemu_chr_wait_connected(Chardev *chr, Error **errp)
     return 0;
 }
 
+void qemu_chr_resize(Chardev *chr, uint16_t cols, uint16_t rows)
+{
+    if (cols != chr->cols || rows != chr->rows) {
+        chr->cols = cols;
+        chr->rows = rows;
+        if (chr->be_open) {
+            qemu_chr_be_event(chr, CHR_EVENT_RESIZE);
+        }
+    }
+}
+
 QemuOpts *qemu_chr_parse_compat(const char *label, const char *filename,
                                 bool permit_mux_mon)
 {
diff --git a/include/chardev/char.h b/include/chardev/char.h
index 45cb6349756ac8072dffab9354108caf90cd3565..1e69b038241074d627ebb7f096e98aee9953ebdf 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -232,6 +232,8 @@ int qemu_chr_write(Chardev *s, const uint8_t *buf, int len, bool write_all);
 #define qemu_chr_write_all(s, buf, len) qemu_chr_write(s, buf, len, true)
 int qemu_chr_wait_connected(Chardev *chr, Error **errp);
 
+void qemu_chr_resize(Chardev *chr, uint16_t cols, uint16_t rows);
+
 #define TYPE_CHARDEV "chardev"
 OBJECT_DECLARE_TYPE(Chardev, ChardevClass, CHARDEV)
 

-- 
2.51.0


