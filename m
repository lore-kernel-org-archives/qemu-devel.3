Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91548C369B1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 08:21:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4y11-00070v-97; Wed, 16 Apr 2025 04:21:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u4xx7-0002Js-EZ; Wed, 16 Apr 2025 04:17:02 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u4xx1-0005wK-S6; Wed, 16 Apr 2025 04:17:01 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7399838db7fso484460b3a.0; 
 Wed, 16 Apr 2025 01:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744791411; x=1745396211; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c4klZ5LCWvRR7sigiHEe5f8QPHEXneqpNeiJtQ0wxIk=;
 b=Vt1MsfsSiqn7OeeZeGcghlg5iFcfNExSuooTExmpfL4G6tghpW42VryrIVRQPydTbi
 CbaggBvuyrY8+OtH3II1IewBfukvKrRqGJLwDwIUqdfBFa632pL4QIdHd3OLi1O1HulD
 Behirpad3911/WC5f4yF8LrGLeCPB7PnHvOEtgvqJRZH43MbI1/b4ppI1gdVM9U41Sg7
 US44jg+nLE0whze9gj1H5EKX82uKwnIMl3P+prpDVvoIiZYcv8UaXDqvvr0sglT2sguU
 /pr6GwTL6n3qQVBfE8BEXX9h6lwovbMaf09UDliqEJOgMsNyi6hu+T2ae/kMZ2DESUJU
 miMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744791411; x=1745396211;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c4klZ5LCWvRR7sigiHEe5f8QPHEXneqpNeiJtQ0wxIk=;
 b=UcScMRt6jM3pEQ3gsrEVsV3fY2t5ruKETzcean2hmBRSaYwN6ggxkopyZe1AXZeWsI
 bCQeJg7R9fh5n2HQtUX67owOx6YhjWtI+V9vNAHo7pMjNBgCG7tHCsWEr9C4wnrCpMNW
 W0nZkV93CU6/DX+PHU1vbER6s9G8OwUdwC36uE7ubuo1SXpH2YFiAE8YTduUVjHu1sTm
 PMGsuXM/60IQ289VyupkRxKGXaMO+VaIBPCtRUyjOXEwvDm5ZBzhbSknBUWAiWMEQd26
 /22q8qgg/ErYoqsqpT+V0fNSiMUrCmN9VJeAgr5zU2GAFREncejOyg3jA5XjtTUwUsVB
 7VzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4qSsAn15G8UlrR+JoonAg4HXHRCOGdlYwJHs5W+hKed+lbf3+SZs4Wf3zvC8UJ+B1/G5RUYU7dFqFow==@nongnu.org,
 AJvYcCUNedkIWrxd+dwM/RdEYxBtQ8i3DGBGNffYOv7uJSmA2xHq2soGRqrwdHUVFxMmwWPRyFgeQojXF+E=@nongnu.org,
 AJvYcCVK1yCHLqG5Vsu7cURfrJXZMt6NAa4oVCBqZEjaVXgCIo7qGDDimR3LmJ3UHoIjJs6hn+bssF8wPA==@nongnu.org,
 AJvYcCX8IJcFsBWG2HboP9pRrsIuCGm+6rVQpog9P1jwMy/UzrMJNui3KhjqCeWJe05jJ2/jSJgXaGdJAZryjA==@nongnu.org
X-Gm-Message-State: AOJu0Yzew0J+5YdYokH63u5Q4n+9r7ARqfGoZL9yD+wzI+IeuJrVT8gk
 GEC/7cQv1RPmRShvPH5M/PbMRYf1wNPfeoDStdniimn+8ux+URTvV3eNI1EL
X-Gm-Gg: ASbGncskroP4MTsU3Wu4oF4C7r1QhR1XBdzOKsq0o4FZzX4IB30W47v5MZa/LbM0uXS
 DfFCnPdVoaFoDWmqZScFRKMs+izT8Vl0isy+pSU5kG+324G/dNtHS0VN6gO8ofVTn+uX2+b4CVD
 J8OoUCsj6nKQpw76m3LO0kAadDivlN52Y/svwEzYbm8XFdNJGSjxijZXXKewcwV2eF1zyyqAccc
 IQ4GpVHxqhIB+PulfBCBSaDq/Ic8QFlQmup4SlDH2fXTfdtQvhmp5FtDfe8iZl2n8Yw52GoMcLQ
 e+KeFhiUp0rDAfGcNb3p7nqitb6ARdcniTElY5bwlxg6FmkYvNsu6OnYng==
X-Google-Smtp-Source: AGHT+IFhoIl7I56S7fT7c23WuBVz8x479Hd++Aam1yHes86eL19L43Zv+85HiEDav9c321yeBTTcSA==
X-Received: by 2002:a05:6a00:2985:b0:736:4c3d:2cba with SMTP id
 d2e1a72fcca58-73c26dffd2cmr1421139b3a.9.1744791411149; 
 Wed, 16 Apr 2025 01:16:51 -0700 (PDT)
Received: from localhost.localdomain ([240d:1a:3b6:8b00:ee5a:e672:7d4c:d43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd21c3263sm9839445b3a.38.2025.04.16.01.16.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Apr 2025 01:16:50 -0700 (PDT)
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
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH 14/19] Disable options unsupported on Emscripten
Date: Wed, 16 Apr 2025 17:14:19 +0900
Message-Id: <c2e3a58825c39678fcde361b685d1bd69d2fb1dd.1744787186.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1744787186.git.ktokunaga.mail@gmail.com>
References: <cover.1744787186.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pf1-x435.google.com
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
 qemu-options.hx | 4 +++-
 system/vl.c     | 4 ++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index dc694a99a3..20ed22afe2 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4863,9 +4863,11 @@ SRST
 ERST
 
 #ifndef _WIN32
+#ifndef EMSCRIPTEN
 DEF("daemonize", 0, QEMU_OPTION_daemonize, \
     "-daemonize      daemonize QEMU after initializing\n", QEMU_ARCH_ALL)
 #endif
+#endif
 SRST
 ``-daemonize``
     Daemonize the QEMU process after initialization. QEMU will not
@@ -5249,7 +5251,7 @@ HXCOMM Internal use
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


