Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE90EC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 20:41:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWMJc-0003Ga-Ca; Tue, 23 Jul 2024 16:40:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWMJa-0002u3-1r
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 16:40:54 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWMJY-0004Sr-39
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 16:40:53 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3686b285969so2782382f8f.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 13:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721767250; x=1722372050; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EVi4ymf0JUdrFDuvhHPunTPbRwIlHUJLlhZi+FT5T80=;
 b=zdc+VbyXDGJRJwBdwYlWWJKy7XoHXoBDDIprf6Hll5uLnmkG4osvo6naDOpCbSksp5
 +c9iWwFdHdV6x0xD6R/AIlg+zEj9MusQyWtdUGqYAXLLNrOTu4AMGRg1RDSQn6QrXq95
 bBRF46wO9u70W9bl1jbsmVgEF/wqKqMojFTPzAj0Euf60mOeEOw+SKLErMhKIdLxiCv1
 sbtS5hy5Pno6dtUsd3Mzyekv4klk8YP0MBg0NybYZkvi50E7fz8dLdihGflE7zDYdfbb
 6f+UTzJrHFGye2T0RigJc/oqeQlszWxo6RsTwLr+++PffhVhRIPZwVNdyb+PuRZxF9F6
 Zt1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721767250; x=1722372050;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EVi4ymf0JUdrFDuvhHPunTPbRwIlHUJLlhZi+FT5T80=;
 b=uo84XhpgN+5EYKYvhivKmpObOUerQfT54YJ/OPgis+p2zh7iXSsUBHburJ6tqYhbdJ
 cyucPw12R/3U5pxmXc3K2qqKi9qbZfDMj6wBHWTiq6rF7PLycFEkBahR4/fYODrddTAo
 A1TClSAwPTZ8QZrLho4Ptxnnw80T6qb0PXt5maDtC9ftj2OjQRqrFcxiK1S4RmfskQX3
 X8LXQomzsvEJPQ3blJc/6Fg6Df5djXcKkO18pIbsDPqCJv2cFQX0zvZVd5LgGDhNjdko
 qZrlxlabvTV0eRHZnM/BmT7mf7KP2RFMONrHP7km5mxOHBZkLsZsJpZIUAS3G87Z6H/p
 7mwQ==
X-Gm-Message-State: AOJu0YxlSeDpSvjLA8+9zf5XxOqZaBuvvm0gLS1/IS1Bf0yWwm4bUQUS
 wX6dUAFYz0Wypl+sJKHy/5LJPydPSueMSI46X4WwzZyP6xWicCuBHjNJOEa1C8hrycDc4+osIGh
 BKwk=
X-Google-Smtp-Source: AGHT+IEJA35PdPkt4JsORHnb2C8/7l7/PbA++LorrZk8MT/FzrVx6WNAtSsHXFMnUqSEERdoDjx5QA==
X-Received: by 2002:adf:ed8d:0:b0:368:664a:d4f9 with SMTP id
 ffacd0b85a97d-369bae3654fmr8624996f8f.28.1721767250112; 
 Tue, 23 Jul 2024 13:40:50 -0700 (PDT)
Received: from localhost.localdomain
 (vbo91-h01-176-184-50-4.dsl.sta.abo.bbox.fr. [176.184.50.4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-368787ec979sm12392870f8f.94.2024.07.23.13.40.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 23 Jul 2024 13:40:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 20/28] chardev/char-fe: Document returned value on error
Date: Tue, 23 Jul 2024 22:38:47 +0200
Message-ID: <20240723203855.65033-21-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240723203855.65033-1-philmd@linaro.org>
References: <20240723203855.65033-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

qemu_chr_fe_add_watch() and qemu_chr_fe_write[_all]()
return -1 on error. Mention it in the documentation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20240722160745.67904-2-philmd@linaro.org>
---
 include/chardev/char-fe.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/chardev/char-fe.h b/include/chardev/char-fe.h
index ecef1828355..3310449eaf0 100644
--- a/include/chardev/char-fe.h
+++ b/include/chardev/char-fe.h
@@ -228,6 +228,7 @@ guint qemu_chr_fe_add_watch(CharBackend *be, GIOCondition cond,
  * is thread-safe.
  *
  * Returns: the number of bytes consumed (0 if no associated Chardev)
+ *          or -1 on error.
  */
 int qemu_chr_fe_write(CharBackend *be, const uint8_t *buf, int len);
 
@@ -242,6 +243,7 @@ int qemu_chr_fe_write(CharBackend *be, const uint8_t *buf, int len);
  * attempted to be written.  This function is thread-safe.
  *
  * Returns: the number of bytes consumed (0 if no associated Chardev)
+ *          or -1 on error.
  */
 int qemu_chr_fe_write_all(CharBackend *be, const uint8_t *buf, int len);
 
@@ -253,6 +255,7 @@ int qemu_chr_fe_write_all(CharBackend *be, const uint8_t *buf, int len);
  * Read data to a buffer from the back end.
  *
  * Returns: the number of bytes read (0 if no associated Chardev)
+ *          or -1 on error.
  */
 int qemu_chr_fe_read_all(CharBackend *be, uint8_t *buf, int len);
 
-- 
2.41.0


