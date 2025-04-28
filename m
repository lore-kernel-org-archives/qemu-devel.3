Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9C13C369D3
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 06:47:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9ID1-0006On-1F; Mon, 28 Apr 2025 02:43:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u9IBU-0003q1-Fz; Mon, 28 Apr 2025 02:41:45 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u9IBS-0007C7-NL; Mon, 28 Apr 2025 02:41:44 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2295d78b45cso63368955ad.0; 
 Sun, 27 Apr 2025 23:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745822499; x=1746427299; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R6jPsS98l2HtImWR7826BuhFjQUnhmK1pGYGyF3oAgs=;
 b=dhEm+DlBfzv0sKXbIR4PJtCv5kk+rBrI3Eo4GalMvxhr83cz5eg2+SN+UsjvmuAmQv
 B3w5gJsbbzuFfUwfQlJvbD9zX26HxkODvhQhFxSjk4W4jVARAvhj3HHwL8xd+pRIWkJ+
 EB9avaYrtOqWUCRtAFJYuyw5V7HvNci1sbHyP8e59XyJK9W+EXtqAwME1hTGrdEg0IWK
 gpTN0phEDPHzn+c1V2/YOWkHgQIhwKIj8V6GGral5PYh1TyO9t3i1qQDs1vc6sFvQaPV
 ycBaX9HDcciZFawAz6POy5HQ8Ll/8Aw/hw+uPTmG/Mz/oDv6DW2szcIjQnb44JR3Wcsl
 W1kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745822499; x=1746427299;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R6jPsS98l2HtImWR7826BuhFjQUnhmK1pGYGyF3oAgs=;
 b=jWQyM6FlQ311WUn/FtqWyeQNj2ssRDXkB9sN4EWdmpEOlNzrDrzFdQJPhQrcOvekEM
 GAcqWCLH25eMzTlp+tQoPEUUVq/An90Y+Uhg6FmkSdmxvC2k65KvoaYs0e0fOnyqQnul
 PDWyXjn9YAzJgJHR9t2+MZx3M5XBRwq74MAzujoocKu64BAXjr1Lr6CktpUccxw2f+jk
 UYOJXtOW/eYfkm2ToVFof4PL35JYXwwMUnBjDB6qJcdQrrnAvT4AhliTkuamLVKIYd/6
 s7njnYqhzFHooJGl+0AztEUt2PyY35DnrZ1FrpBXvTcG71b4t3o2JOS+Ir/pWUBGg9KF
 SdWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0NlzvaPUbGBBZuzXs4lcRGC0fJbPrhOCBuioohC8nUatYZiHUSTZb/nIVxasaQsKif0exGwqDeQ==@nongnu.org,
 AJvYcCUOuG2VgQhwuCK3IMMD8pLt7BBHeeMKHPPr9DXkc/TEbvJgaLs3q5ti/+LzKP5CHT2uQflxhzz5FJfecw==@nongnu.org,
 AJvYcCVYvr/n80OlhJuWeEcH8RdlvWM5vZUejrV8qXp2D9jsUFpFQydiAlBbCfHrTxDChuux8rZjtMc6U8gnAw==@nongnu.org,
 AJvYcCWGEfNj9VxrlKA7GSHiqgTNvFBe4JJXJwZmmMS8SrfS41J04NXlDKuGrOKmkF+D9sjd9ssV92TiE64=@nongnu.org
X-Gm-Message-State: AOJu0YyhUsSSbuLursDFjNhlye6TS7ZeSdViNnOrpHqzB7ruOVFErSj3
 JCjr8Z48b/u8Y5KVVRL3BdAOuce476NFaHfgjAR7hFjeZBT0o+AQF7Ff2v3H
X-Gm-Gg: ASbGnctl3Ct/zYAqMF2tSXg3iYNIR6zY4moCVyPH0Q34NSh2mcsBPtMchYdhX5la2yL
 j5hjSpshlnnQW/DoqzGDmmHtU9jL/bDz7FL4vsouLx5vavHVp8nTfp8pT7xk0eN20/I1QuB/Lk7
 IxNxvyYOOXPCZD4x2pERbb4MDJL7wS2Y9yFA2ME1p2mKnmPUApzkv0jIrapmdIBX0DP78DJ1w0c
 I59UjbVgNJYCrA4IPK9LdWsIitTrTBAXj64mpp8rO/wucZfIxVk5MppfgRjJI1dmvi1Mes3Vc04
 874N/ZWEp55JaK+9YV8xkfEZupaoqwuodcSFxBC01gryvzyq
X-Google-Smtp-Source: AGHT+IFym8WIhNXoi7lOBk7iZe8tENzgr80vvYR/vFUOQ5RBVCxatIPLGd35xL14OlH/qqt4/RwAIQ==
X-Received: by 2002:a17:902:ec89:b0:224:1ef:1e00 with SMTP id
 d9443c01a7336-22dc6a0495cmr126482915ad.19.1745822498370; 
 Sun, 27 Apr 2025 23:41:38 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:bcb:2cf3:f1b5:b7f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4dbe328sm74721215ad.88.2025.04.27.23.41.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Apr 2025 23:41:37 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>, Jason Wang <jasowang@redhat.com>,
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
Subject: [PATCH v3 15/20] Disable options unsupported on Emscripten
Date: Mon, 28 Apr 2025 15:39:04 +0900
Message-ID: <79c5e591b634762703f3eef6427a192d145799e4.1745820062.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1745820062.git.ktokunaga.mail@gmail.com>
References: <cover.1745820062.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x633.google.com
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 qemu-options.hx | 4 ++--
 system/vl.c     | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

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
index 4ab2001df7..30c6385b7a 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -767,7 +767,7 @@ static QemuOptsList qemu_smp_opts = {
     },
 };
 
-#if defined(CONFIG_POSIX)
+#if defined(CONFIG_POSIX) && !defined(EMSCRIPTEN)
 static QemuOptsList qemu_run_with_opts = {
     .name = "run-with",
     .head = QTAILQ_HEAD_INITIALIZER(qemu_run_with_opts.head),
@@ -3678,7 +3678,7 @@ void qemu_init(int argc, char **argv)
             case QEMU_OPTION_nouserconfig:
                 /* Nothing to be parsed here. Especially, do not error out below. */
                 break;
-#if defined(CONFIG_POSIX)
+#if defined(CONFIG_POSIX) && !defined(EMSCRIPTEN)
             case QEMU_OPTION_daemonize:
                 os_set_daemonize(true);
                 break;
-- 
2.43.0


