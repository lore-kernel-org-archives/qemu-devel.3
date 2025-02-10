Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5E04C0219B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 16:23:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thWS9-0006gZ-Cb; Mon, 10 Feb 2025 11:16:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1thWR9-0004Kg-6h
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:15:09 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1thWR5-0001WB-Eb
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:15:06 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-ab7d451f7c4so58244866b.0
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 08:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739204100; x=1739808900; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=drUSqKJyol0KqcrQAykb+B2rcXTaSjubQI7HNVc4K6M=;
 b=EQ3NXv5LhYDpbgICW+p5kJoUpzNKnG4NOhmp7gN7dduhwfTPo9HztwYOMjeN9h0Mst
 orrgJw9BCxq0/peQ20/QX1kOpOLFajpmd+cUHF5hlboTWAS54uOebJu4fOZAO3URiQlG
 8GRsyjQ2/4yRysLBdWqwGX1OIEkXNe97SKlF3IZk/u59nzJVF+OXt/NQK6lQMuq68toV
 woTQ4CBqrWttAc4ebeGE6SvVKL+CMsrLvWYH1tI7IC7kMhqT4Lk38gDEfFRcbO1IVhcw
 XMZwOodhMpeeDGBRahd9eh8KPbMuUPG6MA00JOTRNGV4WpzwzNjGUyh8LIGn3pLPfQsF
 YRwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739204100; x=1739808900;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=drUSqKJyol0KqcrQAykb+B2rcXTaSjubQI7HNVc4K6M=;
 b=Qn8hd5j+mVxOcO3/xWPOZBhuZ8xaKjQnanTPQ9njE9LuC8EcToSIys/yM0SmaFC8fK
 qIgNJHcl3zyqe02c6VoqO1JAPy4S/e5R4HIftF1tjHerNeuZATlATKXGpAwGg+2wE9rk
 HpAyHlziMGUDMVLLz4E7JS1hcJo2E/zpj8fa6Q9V2g8noqDZm1i2hiaACGWSt+XcV3G4
 Z8S5S2ueycNIIxSd+OK37lzuh3pQZjcs9fhlOdJL+C3+skO4NSG8b6Ze8O9ffWOEd0pv
 XJ9iHbPUM38CP50HnCVAsGV9AQ6+65yNYuYFxxzVDcdRxMIiHduKBOQ8vFSo6vXBVkt0
 tmuA==
X-Gm-Message-State: AOJu0Yzyr9MoTQabHqHew2Wszdg+XrvZW99QYDXmsGqpomeWx96RNgOz
 fMk/eiPdzmXrJKQ36FBujTuyfdWInFVt/J+DIn2k5WA51cxZacTAwKrrtbhNZT8=
X-Gm-Gg: ASbGnctGFQN5aqYxKe5xZO+WkpN/SogxLt6NqAUMJzxHeB0v86cBPWgIludHs1ba81p
 YoeGniIVVfGEgnG7l/g4SZa3b4VqFRAdedsqWb6KL2UE+XCuHqrV7J4kzP18EluG4HR8s5P4AnS
 PHaly7R8sOYNmDiOAlJERolAtp15rHuQgH0kSMkQxRqowouZ7gpQnDItQCvk7i8YVBMb1EcEI+Y
 0C7Ehi2Nczjs3+jjppFwoZy10tM8jVzjD67Z5AsgWXkXggsMog0P7VtwRbPOFyQMc6OFn3Ra5Dx
 8wvq3zxUxOwmiM5F6w==
X-Google-Smtp-Source: AGHT+IHb5RndRI06xl37JMWMbMARZvkmIYowTjDXqIdy4SANlVpPE0LB6SOC8VryYlW8/4iTdNv2TQ==
X-Received: by 2002:a17:906:7955:b0:ab7:cedc:4b13 with SMTP id
 a640c23a62f3a-ab7cedc4c5bmr271617666b.34.1739204100593; 
 Mon, 10 Feb 2025 08:15:00 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab7d243bb58sm81258066b.141.2025.02.10.08.14.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 08:14:57 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B0E9B60353;
 Mon, 10 Feb 2025 16:14:52 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 10/17] gdbstub: Allow the %d placeholder in the socket path
Date: Mon, 10 Feb 2025 16:14:44 +0000
Message-Id: <20250210161451.3273284-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250210161451.3273284-1-alex.bennee@linaro.org>
References: <20250210161451.3273284-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x629.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

Just like for QEMU_LOG_FILENAME, replace %d with PID in the GDB socket
path. This allows running multi-process applications with, e.g.,
export QEMU_GDB=/tmp/qemu-%d.sock. Currently this is not possible,
since the first process will cause the subsequent ones to fail due to
not being able to bind() the GDB socket.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Warner Losh <imp@bsdimp.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20250117001542.8290-2-iii@linux.ibm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250207153112.3939799-11-alex.bennee@linaro.org>

diff --git a/gdbstub/user.c b/gdbstub/user.c
index c2bdfc3d49..fd29d595f4 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -317,9 +317,19 @@ static bool gdb_accept_socket(int gdb_fd)
 
 static int gdbserver_open_socket(const char *path)
 {
+    g_autoptr(GString) buf = g_string_new("");
     struct sockaddr_un sockaddr = {};
+    char *pid_placeholder;
     int fd, ret;
 
+    pid_placeholder = strstr(path, "%d");
+    if (pid_placeholder != NULL) {
+        g_string_append_len(buf, path, pid_placeholder - path);
+        g_string_append_printf(buf, "%d", qemu_get_thread_id());
+        g_string_append(buf, pid_placeholder + 2);
+        path = buf->str;
+    }
+
     fd = socket(AF_UNIX, SOCK_STREAM, 0);
     if (fd < 0) {
         perror("create socket");
-- 
2.39.5


