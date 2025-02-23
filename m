Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF9FAC021B3
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Feb 2025 14:55:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmDNG-0007pu-0t; Sun, 23 Feb 2025 09:54:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1tmDN6-0007oL-NP
 for qemu-devel@nongnu.org; Sun, 23 Feb 2025 09:54:21 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1tmDN4-0007dk-Og
 for qemu-devel@nongnu.org; Sun, 23 Feb 2025 09:54:20 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5deb1266031so6607479a12.2
 for <qemu-devel@nongnu.org>; Sun, 23 Feb 2025 06:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740322457; x=1740927257; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NRKO4/Lf3S1y2z89MfhWfqnGHofF5YlWQGE0xWq6QzI=;
 b=DuJPee2o7YXf9CYD9OztP//HkKS2Oy2t61bp7SMcBIfNVr/SNtjmoXbzSR9bzLBa5d
 k1R1q9R22opEp4ink9uNqjgLWtK0VUR+YfQhJE9RKQpLtsIqrlyN8j336ouCpVMJ5xLN
 eeWElNiYvhks7PLAmxnMeNCwSDGEa/hsyznxH+Flsof77/57iXWXH2REhQO0U2d3M3Iu
 4KQDyVShBL5/amhmMv5CVjVxVsWmpFHlr/nb2Dir2FbvsZjoPeyXprABD1+/VOJn/dGW
 QBAk16fyeBDo+Fx6cvW3yRfHrxp9qHrJRk/PTvS7ErpDUGSh5lT7+wBxl6bKKR5JTI65
 xDCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740322457; x=1740927257;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NRKO4/Lf3S1y2z89MfhWfqnGHofF5YlWQGE0xWq6QzI=;
 b=jpL+S6eQJb5jWpogiggthXUpcCnKAjK7xwUrCIuXMflzOt9ObyYZQW+C9jkdcq16hc
 70ecoxqNvilD22hi4Z9R+iExvIIGenE3tw7fH3ws6e6U3YcX3RgvVL8MlTfmBdlXk+nL
 kR9emk4yM0PCwp+eJ8n6p/xvTWUO5FGJs8KjgU/je/Yni6vdth25kiyEf8CZZ1K8sHh+
 5H4iBhQC8uzWRcvlVAdjPEAU8sNvbvOnvY6Ew+mSlnbwsMI/GuFi5ybtPPRhFE+ZRBvB
 axYMgjeMOE4bdjZBxnIPRD35jlhQjM3tC3E1nRMh26ZFyQYXx4hv1egF/ZVouL+PuRP5
 cUYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIDlorI1sQp03WnZbmuuznDN20Yt/RjiCWswMhTAxU++WwYBM1GK+juIOR5l/gf0Kl0dEbC/ek5bSU@nongnu.org
X-Gm-Message-State: AOJu0Yx74e+i7xzjI64jvWRfF9bR5hmKkB3eAGahRZo7DAum47CkGA2E
 0PrrDCvXB9wOe0WcsOiAGufqmP0PtpV/nKaRN/QCY8U7iFGPoZUC
X-Gm-Gg: ASbGncuXD3KzmTo40B/gIcIOsvBm6OqyqGmcVMr0mdPoQ5WwU4QD1CgmYFctHaZawsF
 4XNjuj626zS12I057i4SydDo2YtkCtotwNcWM7DGz6KBWECgO10Ce37a7cUG7sTmWPKXPazFd5n
 mm+BhzXLwnMoBXuLqQDCezCJUHh1swRGcrjjOvOMGj8G1oWDPH61FHQVHq+nuIVMubupGhnXIBx
 wLk2nhJepFRLBQ5Dg5f+3e1Xre+JOgqe0q+aLsdlCBRVVIUUITtinitkwR216GljCxVdHQoefIR
 Qglt+DV11dbswrBTy7OSPZSNNQRJCrfWQLE=
X-Google-Smtp-Source: AGHT+IFDp3HbjbeHo960coxX2B1bxb91Moua6uoF462sA9UDbwkYBn9xXTgpTnUkk662WlpQz6+mvg==
X-Received: by 2002:a05:6402:540c:b0:5e0:7d9b:b15d with SMTP id
 4fb4d7f45d1cf-5e0b70e9cc6mr8530759a12.9.1740322457107; 
 Sun, 23 Feb 2025 06:54:17 -0800 (PST)
Received: from think.fritz.box ([2a02:8109:8384:1400:1283:abda:b08f:72e4])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e0a0310f66sm6431580a12.81.2025.02.23.06.54.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Feb 2025 06:54:15 -0800 (PST)
From: Roman Penyaev <r.peniaev@gmail.com>
To: 
Cc: Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH 2/5] ui/console-vc: report to the application instead of
 screen rendering
Date: Sun, 23 Feb 2025 15:53:59 +0100
Message-ID: <20250223145407.259924-3-r.peniaev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250223145407.259924-1-r.peniaev@gmail.com>
References: <20250223145407.259924-1-r.peniaev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=r.peniaev@gmail.com; helo=mail-ed1-x533.google.com
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

Terminal Device Status Report (DSR) [1] should be sent to an
application, not rendered to the screen. This patch fixes rendering of
terminal report, which appears only on the graphical screen of the
terminal (console "vc") and can be reproduced by the following
command:

     echo -en '\e[6n'; IFS='[;' read -sdR _ row col; echo $row:$col

Command requests cursor position and waits for terminal response, but
instead, the response is rendered to the graphical screen and never
sent to an application.

Why bother? Busybox shell (ash) in Alpine distribution requests cursor
position on each shell prompt (once <ENTER> is pressed), which makes a
prompt on a graphical screen corrupted with repeating Cursor Position
Report (CPR) [2]:

   [root@alpine ~]# \033[57;1R]

Which is very annoying and incorrect.

[1] https://vt100.net/docs/vt100-ug/chapter3.html#DSR
[2] https://vt100.net/docs/vt100-ug/chapter3.html#CPR

Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
---
 ui/console-vc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/ui/console-vc.c b/ui/console-vc.c
index 90ff0ffda8c5..d512f57e10a9 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -617,10 +617,9 @@ static void vc_put_one(VCChardev *vc, int ch)
 
 static void vc_respond_str(VCChardev *vc, const char *buf)
 {
-    while (*buf) {
-        vc_put_one(vc, *buf);
-        buf++;
-    }
+    QemuTextConsole *s = vc->console;
+
+    qemu_chr_be_write(s->chr, (const uint8_t *)buf, strlen(buf));
 }
 
 /* set cursor, checking bounds */
-- 
2.43.0


