Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0F21C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 05:35:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u76GJ-00087u-L5; Tue, 22 Apr 2025 01:33:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u76Cp-0002Vj-Ae; Tue, 22 Apr 2025 01:30:06 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u76Cn-0007wm-B6; Tue, 22 Apr 2025 01:30:02 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-227d6b530d8so47578525ad.3; 
 Mon, 21 Apr 2025 22:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745299798; x=1745904598; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=91nDVfsZm/oDTvNCG5UJidsky4wokob61rkejiRrWL8=;
 b=J9np1K/Rz/XCSD373csET7w2ZD31iU8EDrYjf+BHTvhVhQxuhD7Fqgfz11qwyINogA
 +J6c7qIWBepGjNv8gFAPeoypt0gE0XSDrx26XZbc3FBdxG51lO6r1uKLblyE5++1aWul
 Ur6HAHke7Q6w/Cq/Ag0C5Xczr+C4M8nwVpYZjDcRLO9G6WbSEmZADE1vYEM0q1mLPBpa
 nMQneOdhnkLErktq/8TbW4PNhrT/+k4xQ2jYGBSelV1DEvboRmeDC07FXng5fQQkMRAW
 HaB+LjnnBLrjJxZrg1E9+yGMq+/kEx4H3QAxZjl5g/axoG+sG85zF2qDq/bA2teSgfGR
 thkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745299798; x=1745904598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=91nDVfsZm/oDTvNCG5UJidsky4wokob61rkejiRrWL8=;
 b=P4OmYTb54tsHwIFx3dQ/imsgq7X42IHglR35tBTlYykMgyJiwXP+BOGgb5RDx+bxid
 VfWBrf84MHoUbf0YIRm5J5NDvHYCZOzjYfGFfitiseSZTeh4t6y06t2G/cHpHHQcMW2G
 to6FqmF+b7pQuj/4NsF93SvfXZR0x59SEcBmfcBTe7BlUYv+RXXwWgHiVawZjTqCIV/A
 mQOQkQRc91xg72eL87cwLvnnBfPcrN804dpHjcia4VNOovDt64c058vYZCKcL3SWgzFv
 ARGHyVf3ruH/5nzHRNM03/RF5bdrXkTAVU7Gy/htEQN3hU0jETq+IkRpcYD7XWoG15BV
 lOGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAIsKRPKsetnrBP8jLafS0jxWX6GX+2Lhs8hR/Plru7cEHOpCgkPtB9Slc3RupppSXHJiZPtTqOxoOFw==@nongnu.org,
 AJvYcCVq97bfUcFQXdwUwmEtE3vdhJXiCUKn1FXDktf7RywnXYTqqltVFDvLT7jlLpIxJ3QH6HNvJXlo7w==@nongnu.org,
 AJvYcCWxncLJYBPNapLP6x5iLiZa22kJaDbKjhwxgtyVYF6GytkGZ38ra7/8hyT/Ib/VFAHC6Um+CPuz3bU=@nongnu.org,
 AJvYcCXwig18Gi6XWMFbQmPSChSwBCl6Pv5nvefOZ3MyRBPxug9I3TNByJZ/Htr6FSAklBaTJe4rpE3+8Wx7zA==@nongnu.org
X-Gm-Message-State: AOJu0YwH+F8rqDBLyGU1i/vS/FSiSbUsQ3MKnGvAQ8TcOnNymGYb3Nv4
 PU8+lTF/+tZyhRZBj2Nxu1o2YHITZsWJYFsuh3kSKSrhjNVFvE0l9tyV6tMP
X-Gm-Gg: ASbGnctUPnyVulwCfcPHBOhBk0weARXt3Gi/WzFtwMolEk52MjTkk4Z6oVGfoCW7fQ+
 ZHcOzdrbNpMjUHyTnNvKWVS9AFjWhst2frrapjHXgOeAApvWC2EzdFwOE95wrN7h22pMz4OlFyD
 hWP+56qRxRZXa1gwf9tNqEUNPqN/gmJNZ+LjPXCr34QBovhGjNXRqVqpdzKgSc17LaCrx1epUFu
 SJizV7meYW+6tUChBKQ1MvDxZbNzyPSubFWPbrihw8VzgIZk919WXwDTq8qZwUJSFds7LF2sVN5
 8d1HZrzF13HTksMf7kyNcOtpyJhK08SPAJwds1/lxUx9+Aj/gpRpepiNIHo=
X-Google-Smtp-Source: AGHT+IGnrKx9om/fH6E5cqBCPzL1EC7kn1mhDUexl2Lee4iRQjz8WINSi0mIksnLRWfOJyN3waQVew==
X-Received: by 2002:a17:903:2a8e:b0:220:ca39:d453 with SMTP id
 d9443c01a7336-22c53583e56mr235563765ad.17.1745299798322; 
 Mon, 21 Apr 2025 22:29:58 -0700 (PDT)
Received: from localhost.localdomain ([240d:1a:3b6:8b00:e142:4a4f:1ebb:3ca4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50eb4483sm75692085ad.118.2025.04.21.22.29.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Apr 2025 22:29:57 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH v2 15/20] Disable options unsupported on Emscripten
Date: Tue, 22 Apr 2025 14:27:19 +0900
Message-Id: <047b22618137ad1fa0abbfa061726ba08605c4d9.1745295397.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1745295397.git.ktokunaga.mail@gmail.com>
References: <cover.1745295397.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x630.google.com
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

Daemonizing and run-with aren't supported on Emscripten so disable these
flags.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 qemu-options.hx | 4 ++--
 system/vl.c     | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

V2:
- Unified two consecutive #ifndef macros into a single condition in
  qemu-options.hx.

diff --git a/qemu-options.hx b/qemu-options.hx
index dc694a99a3..aab53bcfe8 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4862,7 +4862,7 @@ SRST
     Start right away with a saved state (``loadvm`` in monitor)
 ERST
 
-#ifndef _WIN32
+#if !defined(_WIN32) && !defined(EMSCRIPTEN)
 DEF("daemonize", 0, QEMU_OPTION_daemonize, \
     "-daemonize      daemonize QEMU after initializing\n", QEMU_ARCH_ALL)
 #endif
@@ -5249,7 +5249,7 @@ HXCOMM Internal use
 DEF("qtest", HAS_ARG, QEMU_OPTION_qtest, "", QEMU_ARCH_ALL)
 DEF("qtest-log", HAS_ARG, QEMU_OPTION_qtest_log, "", QEMU_ARCH_ALL)
 
-#ifdef CONFIG_POSIX
+#if defined(CONFIG_POSIX) && !defined(EMSCRIPTEN)
 DEF("run-with", HAS_ARG, QEMU_OPTION_run_with,
     "-run-with [async-teardown=on|off][,chroot=dir][user=username|uid:gid]\n"
     "                Set miscellaneous QEMU process lifecycle options:\n"
diff --git a/system/vl.c b/system/vl.c
index 8d89394b45..255ea3be6b 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -766,7 +766,7 @@ static QemuOptsList qemu_smp_opts = {
     },
 };
 
-#if defined(CONFIG_POSIX)
+#if defined(CONFIG_POSIX) && !defined(EMSCRIPTEN)
 static QemuOptsList qemu_run_with_opts = {
     .name = "run-with",
     .head = QTAILQ_HEAD_INITIALIZER(qemu_run_with_opts.head),
@@ -3677,7 +3677,7 @@ void qemu_init(int argc, char **argv)
             case QEMU_OPTION_nouserconfig:
                 /* Nothing to be parsed here. Especially, do not error out below. */
                 break;
-#if defined(CONFIG_POSIX)
+#if defined(CONFIG_POSIX) && !defined(EMSCRIPTEN)
             case QEMU_OPTION_daemonize:
                 os_set_daemonize(true);
                 break;
-- 
2.25.1


