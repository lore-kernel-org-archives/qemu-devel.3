Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 978DDC88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 20:36:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Zs1-0001KU-25; Tue, 15 Sep 2026 16:35:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x6Zry-0001JJ-Fn
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 16:35:10 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x6Zrw-0005bo-N2
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 16:35:10 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912d3931so1617965e9.3
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 13:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1789504507; x=1790109307; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mfggAYcfW+ee4C8Ti5nGRWscQD6bm2tdaOwAHPoXh0c=;
 b=Un8RtduvA8y0gTfc2Nk3fo1m/tECufJiIsxG/KVnOboKN2NoC/7log+JBPmasTSlKr
 1voMWfS4lkEru7IgGZ9tlcWMp1kJ4arHXf3BJvTLkcLlGk/cxv8ze4Nj3rUMGL+S8ROy
 0qyBxxW/OPMpFvVhuY7RbzTmXcPLbb+7J3VRmwF6i/2isXMfhJZurB29TQLw9HdlcwWK
 x96MG472GzJgqNUY/kmnt45wTPu7m7UktxT5oW4h1FVLyfMGFh/aGTBNxLxikjrCiNzi
 WE8AMfCI1V6LkKnYpzcQHZy6fFtceEy7lb4y5SZXXeLD90xjTcIegXwJcToRv8FvpPP2
 f+jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789504507; x=1790109307;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mfggAYcfW+ee4C8Ti5nGRWscQD6bm2tdaOwAHPoXh0c=;
 b=FYKL7xIjutc3Bns9FAK8r7IHvp0+hF9c1H67fWNLIaqXMM1b6GA/r+qPRt10oZjTtf
 MGp00VY2Yi8jTf7xp8iSQ3HmwZ9s4/n5QhYNtTzn+nzkxTn7kvMLsuUsIbVZSK5wELxx
 mhijPGxGYrs+OZ9bISXm7GLQtka+ym3c8M89i7edmN3etsMYCvyfJEwawjwysMiXlHNI
 mlpCRAUbR91dC+8tWlV+RgotnVPRq5nemNxsk8DIZ1kqTKBmVxdNLac3OHOuC4z9e1HD
 ep2SWKtioIvyLEqMz2+nbKOuQK9Qp/HaVwH8e4eTxFzRSQ2sBzqoaMIFLyrZCj8y+k1B
 sN1A==
X-Gm-Message-State: AFuF++m2KpjA8GdWhS64eJh/DVpKXw3z4kTemspeVi5bhDdvtBYZWWOf
 RGoOIxaltNGyFKzTj0iyMLTZ0T73JP5Q6raB0PG/+p0DWGfn/bOGArVozQIJ8K3KR5d0S63EUZ2
 4PnUM
X-Gm-Gg: AYBFou3NKvfyLZalbkXrsqiWAQsrezdxCJpafAg2zVJix+PexWZLDecUob0M3wOyrel
 pL8Ka/eW4lYd4+EbCFEfUUtah1hL0yAQqpuq+XI5qfTReSeJZA/0cGcB+2o6CkCrJ6oZHxbR2dP
 ABOFaAnZGAa+Z+eQN9G76i6hIbykZh+ixqIH+o0xBdaC3pZIYk093/RZeYE/kp8LRia18hOvN6B
 Qa61hbIxwLUYnJ2IdALcCYDYX+W8Gf1w3Bh6GtRuCjixZxJ1ZtzXphEwvKf3+siXcill47Ti9gh
 kquEd2wVxsx7u/DxbY2naf7oO7g7oaidO4/VYYxrcUF20Gsyrn2aJddqkHOlnBHZGnlz8VClTKa
 7uJgwkmtsCFvQ3IhQe+gIRG8NmTmi2y95iDSz+UK2YAdxdLxO/UVCUa75bAJZDAmxaqr7qq+Fll
 cgOLCkVa9h1qeXYvDPpfN5msKz1mLAvbMWUMYMGPGefawcofnHb5SNsuYIKysOiG5RW8zum7WW+
 zyVwI8=
X-Received: by 2002:a05:600c:35c2:b0:49c:eb16:9fd with SMTP id
 5b1f17b1804b1-49e821ffef1mr43234155e9.3.1789504507309; 
 Tue, 15 Sep 2026 13:35:07 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:f0fe:c7ed:403d:e487])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf37e69sm1504073f8f.29.2026.09.15.13.35.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 13:35:06 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 05/10] util/qemu-thread: reserve a signal for thread
 introspection
Date: Tue, 15 Sep 2026 22:34:49 +0200
Message-ID: <20260915203455.580999-6-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915203455.580999-1-den@openvz.org>
References: <20260915203455.580999-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=den@openvz.org; helo=mail-wm2-x10.google.com
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

qemu_thread_create() blocks every signal in the threads it starts so
that process directed signals reach the main loop and nowhere else.
That reasoning covers delivery the kernel is free to route: kill(2)
picks any thread not blocking the signal, so leaving SIGTERM or SIGCHLD
unblocked in a worker would let signalfd miss them.

A thread directed signal is not routed. tgkill(2) delivers to the named
thread whatever every other mask says, so a signal only ever sent that
way was never the main loop's to receive, and unblocking it takes
nothing from it.

Reserve SIGRTMIN for asking a thread what it is doing, and leave that
one unblocked. Nothing sends it yet, and until something installs a
handler the change is invisible: a real time signal terminates by
default, which is already what a stray one does through the main
thread, where it was never blocked either.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Cc: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 include/qemu/osdep.h     | 9 +++++++++
 util/qemu-thread-posix.c | 4 ++++
 2 files changed, 13 insertions(+)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index c15ffd7880..0bd08e0f7f 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -667,6 +667,15 @@ int qemu_get_thread_id(void);
  */
 bool qemu_debugger_attached(void);
 
+/*
+ * Signal reserved for asking a thread what it is doing. It is only ever
+ * sent thread directed, so it does not compete for the process directed
+ * signals that qemu routes to the main loop.
+ */
+#if defined(SIGRTMIN) && !defined(_WIN32)
+#define QEMU_SIG_INTROSPECT SIGRTMIN
+#endif
+
 /**
  * qemu_thread_states:
  *
diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
index 580cdf8079..66bde85608 100644
--- a/util/qemu-thread-posix.c
+++ b/util/qemu-thread-posix.c
@@ -444,6 +444,10 @@ void qemu_thread_create(QemuThread *thread, const char *name,
     sigdelset(&set, SIGFPE);
     sigdelset(&set, SIGILL);
     /* TODO avoid SIGBUS loss on macOS */
+#ifdef QEMU_SIG_INTROSPECT
+    /* Thread directed, so it was never the iothread's to receive */
+    sigdelset(&set, QEMU_SIG_INTROSPECT);
+#endif
     pthread_sigmask(SIG_SETMASK, &set, &oldset);
 
     qemu_thread_args = g_new0(QemuThreadArgs, 1);
-- 
2.53.0


