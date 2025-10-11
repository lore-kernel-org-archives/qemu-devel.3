Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FEABCCD184
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Oct 2025 08:15:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7Uk3-0006xZ-4o; Sat, 11 Oct 2025 04:14:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daan.j.demeyer@gmail.com>)
 id 1v7Uk0-0006xI-LM
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 04:14:12 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <daan.j.demeyer@gmail.com>)
 id 1v7Ujt-0005Yj-HB
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 04:14:12 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-46e491a5b96so14684155e9.2
 for <qemu-devel@nongnu.org>; Sat, 11 Oct 2025 01:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760170442; x=1760775242; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YfHqHYCHafO6rnOLQUpDhedy3JSR82AQLNE0adlA1EA=;
 b=D5Xr4mmgV5nxdoeKrK/qsKFbW5QUSK3yXhgk52FhHAQo3yFwxB1diVoEl1UHdlWZPB
 XzbsEgViPpdWs5UHL7JDqOIQ+Or67asnmlkAWzCQkwFG8oP2ALpE4TBU5rWSQnCARECC
 291/tYITxEj5jjVPW7f4Z2VGrxwkFyZmVjEdUzNOSILXJ2/8u1eo+NdUMFZN670ekS5b
 pxgB9Zq+ab3ZPTZisPxUaD57I/m4Qw8k40eV5oR8N20j7WLF5L2LBY+T1d25hXGjyf8e
 8+WOjzAJM4/QE4jkgzFM9GfIUO/bn71Cu8n9S20dXcuMOGVQJgpy6KpzRyPKU7vEjNfy
 49vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760170442; x=1760775242;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YfHqHYCHafO6rnOLQUpDhedy3JSR82AQLNE0adlA1EA=;
 b=kaG0DAwT6kYl5kuMZDFRw9ZMB6rruOXwNps2iRUDPuhCWE89klsccqtZ2K5WrzLfWt
 kB7vt5sQWQzffJ+/1gemPYOpdaBCb7dXtPbyKe8WuDLITg8W+0T/oxrkMFM2XDBqq18R
 7tKwBRG7DQd8ikyPDnLKL9Dk5P1zq/T+f3JkVqY0XCoO9zsQAa+gn7DBfYB4xfc8hKRC
 tcCsGEcSKQyhVgcQxObqDCxKuKbwOhg5Jz8i6oDByoAC6SdJy3k5tsuP0Mlwp+jhdVWn
 EmZrRBxZ9qwR5nqM4rrmG3AsJ0JN6zW0Xsr0XRZ5avGxI0AP7wPPefNzoBZWojkNFANh
 +quw==
X-Gm-Message-State: AOJu0YwdX0e48gqefEXxNeeUju6u714ZLBBeqETRu65NUonRyhAqG11L
 IO6geiYdI23MR1Ckgr2l2q9ce7W5q5q8Zqh/DViQ/DmYcmYzJBxcw4bLp4ruAedV
X-Gm-Gg: ASbGnct8YNhBhwHb/dcsREryWlyf8xOo+jA4TJ78GXwxiDYet44gJ1kcYcJRX6p4ssN
 2/SO30tsZwMPW5Va0OaTlRr7onumFC26IiDrHopwiCl1udthSpBMlgVqfQ8Mx9bUl09+DzWiwp0
 4lM6VYtH93OSePAmkvisEEbJ637FSkPwOxGeuO/zT0S89Ik4EnMyR+LjDCfXEtgv9QbjnskIfNK
 gsJdUuu/fQu/YSd5XVSxDyMvMM2fALmXFHRdF07zSWzXyh7sCtpNm6sxW3p7VvRHuPFFDPZk61F
 W/0qxR4FRX0aqBXJ7psIV9ZIJg/WRmyixuJpyicRwxqZcXb5k2fqan6P5f6AkkfjfWJjER3C46h
 AUQlSPyMMOMRqOfx14lxtPFMQQm+wwYZtMlb6Lgi95UX9D/tr0Hd4T4eM5KcrmnBXDhPS+hCL9D
 zqgUU62gJCXS1OCqdXDcEuY+o6NjNa09M=
X-Google-Smtp-Source: AGHT+IHx76q4DbGV7kEiEW9a8PJelGWWp4Wwjk3/RVmqZggKjH//xYhqqf15+pKLgUZpYjzijYFwKA==
X-Received: by 2002:a05:600c:6383:b0:46e:32dd:1b1a with SMTP id
 5b1f17b1804b1-46fa9a8f146mr101590455e9.7.1760170442561; 
 Sat, 11 Oct 2025 01:14:02 -0700 (PDT)
Received: from daandemeyer-fedora-PC1EV17T (d54C349CA.access.telenet.be.
 [84.195.73.202]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-46fb497aec2sm83873195e9.1.2025.10.11.01.14.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Oct 2025 01:14:02 -0700 (PDT)
From: Daan De Meyer <daan.j.demeyer@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Daan De Meyer <daan.j.demeyer@gmail.com>
Subject: [PATCH v2 2/3] Use g_autofree in unpack_efi_zboot_image()
Date: Sat, 11 Oct 2025 10:13:46 +0200
Message-ID: <20251011081347.4063198-3-daan.j.demeyer@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251011081347.4063198-1-daan.j.demeyer@gmail.com>
References: <20251011081347.4063198-1-daan.j.demeyer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=daan.j.demeyer@gmail.com; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
---
 hw/core/loader.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index 42edcf2d98..e8be700afb 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -864,7 +864,7 @@ struct linux_efi_zboot_header {
 ssize_t unpack_efi_zboot_image(uint8_t **buffer, ssize_t *size)
 {
     const struct linux_efi_zboot_header *header;
-    uint8_t *data = NULL;
+    g_autofree uint8_t *data = NULL;
     ssize_t ploff, plsize;
     ssize_t bytes;
 
@@ -907,7 +907,7 @@ ssize_t unpack_efi_zboot_image(uint8_t **buffer, ssize_t *size)
     }
 
     g_free(*buffer);
-    *buffer = g_realloc(data, bytes);
+    *buffer = g_realloc(g_steal_pointer(&data), bytes);
     *size = bytes;
     return bytes;
 }
-- 
2.51.0


