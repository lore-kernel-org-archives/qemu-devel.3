Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02B05C3ABBC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 15:34:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCKFv-0005G3-M9; Tue, 06 May 2025 11:30:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCKFa-0004RR-5l
 for qemu-devel@nongnu.org; Tue, 06 May 2025 11:30:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCKFX-0002Ee-5R
 for qemu-devel@nongnu.org; Tue, 06 May 2025 11:30:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746545425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IDPa5HjQl6ahGOhV9sWMIssCb4FuwxI06hVzoLW1Cb4=;
 b=PCHfF4awN7a90z8IPWgt21SBeiwEU8Wqdjw/Pk/o+vnX9pSt5n/n3rLTTIhu3l6OG+kXuC
 jS1h5Ybhn3yspDdh+3FzcrEas/YDYOhc6VdJIKpfZyyuoagZV5g4XiB675Cp03HrpxY0ww
 Ia2KmgFKp34rjtbFqgSwv+KOg/2wvXw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-DWIdATQROUix7fa-gA9V_g-1; Tue, 06 May 2025 11:30:24 -0400
X-MC-Unique: DWIdATQROUix7fa-gA9V_g-1
X-Mimecast-MFC-AGG-ID: DWIdATQROUix7fa-gA9V_g_1746545423
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43d0a037f97so31505315e9.2
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 08:30:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746545421; x=1747150221;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IDPa5HjQl6ahGOhV9sWMIssCb4FuwxI06hVzoLW1Cb4=;
 b=DP9gZJZHOJ4rACPckBi5493WdVNFBCZrRIUkciehsDXTR1TXdQmLL+BhJuA9h/lkYZ
 ZED/jiVODL+PtulY/t2Pk7tw2vhngpX8TnoyluWNUtplRKg2xJsWbmb2wn8pCPS8CGg5
 9Nrc9Ce9pE54RFxDQkdjUBYx2SfxJw0AWin17gGld74aUIhOOy9Jtf05Qlh5sFt3HXiA
 JapWCkmSCrX+r+s9OrtfXln4h/GYVlznaMqjBqP8ApEOWDfc8n/Zk3DYc0kzBu+0Nmjk
 T6pfl8sdSNWZcB0rud1mK/JW1oYYH8c9Um8P7k/9GoA9/l0hCoABvCWvCsswJjWrIMrM
 p59g==
X-Gm-Message-State: AOJu0YyzW4c2A78ugScOSAffbENGbgAMbhe1yR0YYvRkAYNOCwG2IJKc
 U7tyJw5cJcF07R2idU3YpsMdEPnpMIAEB4jC10pYsfTziPJid8+I4ktDYqroSMKqf0X8AQcy3IY
 1kT01rgOCfzYowoT6FuER7UPxQyzFCXtCfnRg743+yU9w5TBtP+KArZ16fcFFE36V6hsWcPz3s3
 w6cJA9JLOwTiM2MbmNsD9OXdb5z5anP/H4mIKv
X-Gm-Gg: ASbGncudUCQx6GuSHfYf2FPtHA7SA1zGr/0qzmCtd2NKZJ/ejdG6uCnyuO6zHSIyzc8
 xN727lfZtZct4oPl6rMQPjwZy0a/Vky3qUfPwe5YvIs21yeRxE5QBlp12mE6J8O5CPxA/hKmWY2
 WkmOX+8jaGSFTE+PI01mGXdAiVO11V6H8mr4vc8JMGZSsKRXWGGU0A/7Q4LsSyTMNVj0h0F1fcR
 cH/eBKMs1GEtxwFQjylkApnkGx0DYFvGA0w4c3G6bg2eZdP/rovTIsL4dqXdD/VW80hREQ0aaxl
 bKZNwdPx8Ibybe8=
X-Received: by 2002:a05:600c:4e93:b0:43c:f513:9591 with SMTP id
 5b1f17b1804b1-441d04ffd97mr36286775e9.14.1746545421213; 
 Tue, 06 May 2025 08:30:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeRU4GKoYpu2AmrI1p0uem7ftoxnAze8RrsLKihUW84wzh6ZjB4AKETBZaS2qKrV0EV3XnyQ==
X-Received: by 2002:a05:600c:4e93:b0:43c:f513:9591 with SMTP id
 5b1f17b1804b1-441d04ffd97mr36286455e9.14.1746545420817; 
 Tue, 06 May 2025 08:30:20 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b2aecb54sm216901115e9.10.2025.05.06.08.30.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 08:30:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 25/30] Disable options unsupported on Emscripten
Date: Tue,  6 May 2025 17:29:20 +0200
Message-ID: <20250506152927.222671-26-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250506152927.222671-1-pbonzini@redhat.com>
References: <20250506152927.222671-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Kohei Tokunaga <ktokunaga.mail@gmail.com>

Daemonizing and run-with aren't supported on Emscripten so disable these
flags.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/r/79c5e591b634762703f3eef6427a192d145799e4.1745820062.git.ktokunaga.mail@gmail.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 system/vl.c     | 4 ++--
 qemu-options.hx | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/system/vl.c b/system/vl.c
index 520956f4a19..b69d5bb81e1 100644
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
diff --git a/qemu-options.hx b/qemu-options.hx
index dc694a99a30..aab53bcfe8f 100644
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
-- 
2.49.0


