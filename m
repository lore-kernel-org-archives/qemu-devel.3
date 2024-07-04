Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F8E4C3065C
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 10:00:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPJEs-00077u-Fh; Thu, 04 Jul 2024 05:58:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sPJEk-0006up-Dz
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 05:58:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sPJEi-00088i-Oj
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 05:58:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720087123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7MkRViG8QZ36KoPeTrYQRb9R5sxJAqGeAW3NIdlDUcY=;
 b=Urkq4L4IQ2uprxgwuu/HXJLuY0vCp6j/8Ya+pqWPKAn7lErARkj2wVrwUwGnuSP/OTDzzn
 stFvaJtMCeFcu4THV6u6lV9hKtTfw1JNA3ZRUF8obAwOU3a6JZIBlEMwHttoYn6WZ3kD/+
 /X1vhKWc0yH0EImCSbZQ0UILceS1f2w=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-tNuVtscjOc6-240Cr64Ovg-1; Thu, 04 Jul 2024 05:58:41 -0400
X-MC-Unique: tNuVtscjOc6-240Cr64Ovg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-367990a5796so328071f8f.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 02:58:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720087120; x=1720691920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7MkRViG8QZ36KoPeTrYQRb9R5sxJAqGeAW3NIdlDUcY=;
 b=wE9Q+VN4sUvT7XAjP+/kA8prsI8ptUwxdi6LsQhwRqz0nSkqbbp0YmAY7isVSc0Pr9
 uxTARjvDRRQajxKHhnf4PoYHqca3OeXAYTOJsFcaoguwW6OnkzEhzGCemHrq+lCJUFQJ
 HtWBaOK247nlKuBpQZXBG+2SgNr9j63TrwOI3/NKqF92+BfGmioAYHQcSqvDRcbWZI7t
 1X3pMZIt958Y4U0BX4w84knrIKF1oVRN0A37lJgtKbIxPXQTM/xEFYxrasPiLgYOFRWq
 c1lNUrRQQ1CCuGiR93LTEtcZoHr8TEscHseFg8PX/vcGcKvaTfwb1Y7gtkukMBQKV/sT
 rRyQ==
X-Gm-Message-State: AOJu0YzRZ1bJW7ujvM//twM1m2RcuDR9873r/pULzXRfW/NBtgJGPIZ9
 A5RtVLjarUXr046OCCRimzEP7hF0xwNSIDq8PbMrWNhz3ndVqcf6F+r6OoP91tAsYxVy8Ne9XVD
 ucPLK155SAjQT+2VLMg/K7S+YgBYpyGrrOk7ubf1JwQTti5Npy+GCa8bybrXmlvPsKMtmMi69mV
 npoV9l27Gu7oqFsTSclwYbsKlDZ0X4XGW1Xsfq
X-Received: by 2002:a5d:5265:0:b0:367:9ce3:1667 with SMTP id
 ffacd0b85a97d-3679dd3c4eemr791563f8f.15.1720087120022; 
 Thu, 04 Jul 2024 02:58:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeWQQn67J2uNHzR8rJjJIkc2KFIzrg2kotGZayvEsJHFaCKCLm0Ujp2E8Z28vRLJSuY4OYwg==
X-Received: by 2002:a5d:5265:0:b0:367:9ce3:1667 with SMTP id
 ffacd0b85a97d-3679dd3c4eemr791554f8f.15.1720087119695; 
 Thu, 04 Jul 2024 02:58:39 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a103366sm17879438f8f.102.2024.07.04.02.58.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jul 2024 02:58:39 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Maxim Mikityanskiy <maxtram95@gmail.com>
Subject: [PULL 14/16] char-stdio: Restore blocking mode of stdout on exit
Date: Thu,  4 Jul 2024 11:58:04 +0200
Message-ID: <20240704095806.1780273-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704095806.1780273-1-pbonzini@redhat.com>
References: <20240704095806.1780273-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Maxim Mikityanskiy <maxtram95@gmail.com>

qemu_chr_open_fd() sets stdout into non-blocking mode. Restore the old
fd flags on exit to avoid breaking unsuspecting applications that run on
the same terminal after qemu and don't expect to get EAGAIN.

While at at, also ensure term_exit is called once (at the moment it's
called both from char_stdio_finalize() and as the atexit() hook.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2423
Signed-off-by: Maxim Mikityanskiy <maxtram95@gmail.com>
Link: https://lore.kernel.org/r/20240703190812.3459514-1-maxtram95@gmail.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 chardev/char-stdio.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/chardev/char-stdio.c b/chardev/char-stdio.c
index 3c648678ab1..b960ddd4e4c 100644
--- a/chardev/char-stdio.c
+++ b/chardev/char-stdio.c
@@ -41,6 +41,7 @@
 /* init terminal so that we can grab keys */
 static struct termios oldtty;
 static int old_fd0_flags;
+static int old_fd1_flags;
 static bool stdio_in_use;
 static bool stdio_allow_signal;
 static bool stdio_echo_state;
@@ -50,6 +51,8 @@ static void term_exit(void)
     if (stdio_in_use) {
         tcsetattr(0, TCSANOW, &oldtty);
         fcntl(0, F_SETFL, old_fd0_flags);
+        fcntl(1, F_SETFL, old_fd1_flags);
+        stdio_in_use = false;
     }
 }
 
@@ -102,6 +105,7 @@ static void qemu_chr_open_stdio(Chardev *chr,
 
     stdio_in_use = true;
     old_fd0_flags = fcntl(0, F_GETFL);
+    old_fd1_flags = fcntl(1, F_GETFL);
     tcgetattr(0, &oldtty);
     if (!g_unix_set_fd_nonblocking(0, true, NULL)) {
         error_setg_errno(errp, errno, "Failed to set FD nonblocking");
-- 
2.45.2


