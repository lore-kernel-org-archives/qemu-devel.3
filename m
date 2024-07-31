Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 766ADC3DA64
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 15:18:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZB4v-000676-7q; Wed, 31 Jul 2024 11:17:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philipp.reisner@linbit.com>)
 id 1sZB4t-00065k-6R
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 11:17:23 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philipp.reisner@linbit.com>)
 id 1sZB4q-0005tq-Sc
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 11:17:22 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a7aa212c1c9so783472766b.2
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 08:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1722439038; x=1723043838;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Sh6zZA6XZUgT7LwMjMI+bUvSxGAEJP1sV+aVcQWSRY=;
 b=z2IIn6s3JHR759qMO5BtPJAFwDOyiGsxtZlz6nqKxpQf95OJgbYQafW6wk3xiA85ht
 y/XsedPLMOUIKncR3+wIZ14V2F0KULp5wbUHT8BeBldNhI3ttlQZ5x93D1PZUsi08kOy
 NgbhLSvOYxcPgohnOuv/tcNnHyuLa9MdM6tROF39JKNjUiDRTgKl2oFiEaukF4QeSe9I
 azQdy/RakUCzBSKKif4aAfPf7ilJ0nIxuUBZ9SF/ooWie31hhqJwsrJMgvQtAyDHzFE+
 oWpFQ/suVsNYMbQaWuL+PY4El3jXdp3PuaIxcbW+POYZ8XhI+DuDm7StDTb2EZxsGKPc
 bsfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722439038; x=1723043838;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/Sh6zZA6XZUgT7LwMjMI+bUvSxGAEJP1sV+aVcQWSRY=;
 b=bzIXxPxS0v+6BTcWA7CrS6/si8FrcW/QAvKTdb/GJqBjPabBTp/tgBdbmjLSxDPtfW
 TjdmfYSYrrH2cHC0f6Onhfko5hfucc9UEAUz8hoy7uqMFPtzvOdU0OFySnghn4Gpb7U3
 0AuQXUI1ZwkbiXJDl+fgCeSgNB+0f5UBfMBkHGt38SBX2VhKAoRCvzQMzQBPrfGH2JZM
 oJcHYadhP1JC3UhnNAhDLM1CFsQgRfWWT6F7ShDZibPXj2BaJUcLnYVMc8So2m9Pz74M
 i1U6TLiOqfyqKtRRw0p04mnFsZZcnJnvfdIFw15stS/oVgz218Upk2yrKS5NifJ8MiJS
 P5xQ==
X-Gm-Message-State: AOJu0Yz8A53pL13kzSw5sj2m7ZR4MMs7Mi2BSYcP6iNgbwpxOmZKex2/
 MxNdfiRq58AiUjqcQt9E3cm5IHWnd6mnkNoW+7dXzxMXId5sR5AHKDOQNThj7jbpqUkvQ7SPg6w
 m
X-Google-Smtp-Source: AGHT+IGy74RlGanl1HZmBA7JKAIh1i9hNKo72fih0yYBD6+3BSBsbWDuIsK8xtE4wd+P/HVUTJEVcw==
X-Received: by 2002:a17:906:c10f:b0:a7a:9f0f:ab17 with SMTP id
 a640c23a62f3a-a7d400afc1dmr1034715966b.32.1722439037839; 
 Wed, 31 Jul 2024 08:17:17 -0700 (PDT)
Received: from ryzen9.home (193-80-247-151.adsl.highway.telekom.at.
 [193.80.247.151]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acad41dd2sm777683666b.107.2024.07.31.08.17.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 08:17:17 -0700 (PDT)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Philipp Reisner <philipp.reisner@linbit.com>
Subject: [PATCH] util: use RETRY_ON_EINTR() on open() more consistently
Date: Wed, 31 Jul 2024 17:17:14 +0200
Message-ID: <20240731151714.326879-1-philipp.reisner@linbit.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <CAFEAcA9J37Z1JJb34zyRDo=ow0h1QgOq9bm10dCc0u5bMyQKpg@mail.gmail.com>
References: <CAFEAcA9J37Z1JJb34zyRDo=ow0h1QgOq9bm10dCc0u5bMyQKpg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philipp.reisner@linbit.com; helo=mail-ej1-x635.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

As with many syscalls, open() might be interrupted by a signal.

The call trace
img_open_file()
  blk_new_open()
    raw_open()
      raw_open_common()
        qemu_open()
          qemu_open_internal()
            qemu_open_cloexec()

Ended up in calling open() without a retry loop around it.

The experienced logfile entry is:
qemu-system-x86_64: -device virtio-blk-pci,bus=pci.0,addr=0x7,drive=libvirt-2-format,id=virtio-disk0,bootindex=2,write-cache=on,serial=1b990c4d13b74a4e90ea: Could not open '/dev/drbd1003': Interrupted system call

Add the RETRY_ON_EINTR() in qemu_open_cloexec() and remove it on
call-sites using qemu_open_old().

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
---
 chardev/char-fd.c   | 2 +-
 chardev/char-pipe.c | 4 ++--
 os-posix.c          | 2 +-
 util/osdep.c        | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/chardev/char-fd.c b/chardev/char-fd.c
index d2c4923359..00a225bc48 100644
--- a/chardev/char-fd.c
+++ b/chardev/char-fd.c
@@ -198,7 +198,7 @@ int qmp_chardev_open_file_source(char *src, int flags, Error **errp)
 {
     int fd = -1;
 
-    fd = RETRY_ON_EINTR(qemu_open_old(src, flags, 0666));
+    fd = qemu_open_old(src, flags, 0666);
     if (fd == -1) {
         error_setg_file_open(errp, errno, src);
     }
diff --git a/chardev/char-pipe.c b/chardev/char-pipe.c
index 5ad30bcc59..c9dc793434 100644
--- a/chardev/char-pipe.c
+++ b/chardev/char-pipe.c
@@ -131,8 +131,8 @@ static void qemu_chr_open_pipe(Chardev *chr,
 
     filename_in = g_strdup_printf("%s.in", filename);
     filename_out = g_strdup_printf("%s.out", filename);
-    fd_in = RETRY_ON_EINTR(qemu_open_old(filename_in, O_RDWR | O_BINARY));
-    fd_out = RETRY_ON_EINTR(qemu_open_old(filename_out, O_RDWR | O_BINARY));
+    fd_in = qemu_open_old(filename_in, O_RDWR | O_BINARY);
+    fd_out = qemu_open_old(filename_out, O_RDWR | O_BINARY);
     g_free(filename_in);
     g_free(filename_out);
     if (fd_in < 0 || fd_out < 0) {
diff --git a/os-posix.c b/os-posix.c
index 43f9a43f3f..7401e7da6b 100644
--- a/os-posix.c
+++ b/os-posix.c
@@ -291,7 +291,7 @@ void os_setup_post(void)
             error_report("not able to chdir to /: %s", strerror(errno));
             exit(1);
         }
-        fd = RETRY_ON_EINTR(qemu_open_old("/dev/null", O_RDWR));
+        fd = qemu_open_old("/dev/null", O_RDWR);
         if (fd == -1) {
             exit(1);
         }
diff --git a/util/osdep.c b/util/osdep.c
index 770369831b..13a09d0dd5 100644
--- a/util/osdep.c
+++ b/util/osdep.c
@@ -295,9 +295,9 @@ static int qemu_open_cloexec(const char *name, int flags, mode_t mode)
 {
     int ret;
 #ifdef O_CLOEXEC
-    ret = open(name, flags | O_CLOEXEC, mode);
+    ret = RETRY_ON_EINTR(open(name, flags | O_CLOEXEC, mode));
 #else
-    ret = open(name, flags, mode);
+    ret = RETRY_ON_EINTR(open(name, flags, mode));
     if (ret >= 0) {
         qemu_set_cloexec(ret);
     }
-- 
2.45.2


