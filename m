Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0CEDC02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 14:46:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1texdt-00047z-Vb; Mon, 03 Feb 2025 09:41:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1texdN-0003ft-8p
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 09:41:11 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1texdC-0002P0-30
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 09:41:08 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a9e44654ae3so719431666b.1
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 06:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738593656; x=1739198456; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/577CdB1eWedE91Z4d0PM1VMtk8hOH9rwbGlAE6K9w8=;
 b=sHOqC0vR6eHlwNI6PcgEdE/FX4h0ziH7bPelCgmBDCUI6MYsY+PRNJCVbkcPUL8+ap
 Xobyw+Y3pFTIdgZ7eR3AwmObQyHqJu+hnOr2y78M1u2qeWR238+F7b005yvyaBlmgSC0
 k9odv5xB40MDNbiZjst+sdttbL6cQedSX4uPR7bkVhlpfcWWf0xFHphkI4dICtsLmpXe
 MZcfEQuk0NQYWR9t7SsARjE0CeAIi/BPJngcmv7PptKf0Z1gfd6iqbTc2p31z5NbHkzk
 3c3BhXa9vEqydTRB5Rn+hc1omNEnCXIX6W3GU9v9s55iW281OM9ZeJVGNTQYy6qRYujM
 kH8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738593656; x=1739198456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/577CdB1eWedE91Z4d0PM1VMtk8hOH9rwbGlAE6K9w8=;
 b=qPD4dtFe98G5N7PhkU84DfV36f2gKA3tyPb8qzLDoavQ3OR4tZdsAawiqxnO6oDDQJ
 7eGQqnC3Wf6yRBHx/pNJ1bBTTpbJwRUf2qHqYxqv9fPsEt2Ip8RkDe9z5q8S95yur5EZ
 eZq84NijBxWv2zbdwVgdtdFr4fKog0As1aERWYtvXUUXCIxcCI3AE7YAaJpte5SPcrpS
 iy7aEdGBf8hURwoLLvv+vYwUklKCHHHg1fFTSSRsY5jKlm37lzid0a03FeQGF3dR+xI6
 ZW+rrI760ntcgZ05UA912036nt8EHmcLPzIlgxrRdwaPfcrsOO66c4FsTYtzt45obpnP
 QInA==
X-Gm-Message-State: AOJu0YyzX2K6s0FCgtw/lqAeS3ZEZQRZN4ODOl26fr8QnSVz5xU2nQKU
 rT+cVLOVFUBI47FkM8kuOlAc651c8lup0Lk4cpps1uQPH8aBvU7u2LEq1Eqw4uo=
X-Gm-Gg: ASbGnctNe+eRFUt9cjNt/5ijHx/PURjfPQMYPPyCoAbMDtD5mryFpXAmtUILwa4kL23
 kKcRfbzwEKkNEYFXuDVR2Tls0Xox1DWvszGbHm3D2gVoUfyvvUCExufcoATrau2W4ZRtLKK+8Ea
 IxC+jclDyUBw6uuRC/iCrjKOHMi7umicpgaGR9RV6cyhdoKa9l52Ddhz7vZPuxHSEyLIKnkvZS+
 ejSDiHZTKRQkvRsXAVK1RUSv3LWlFz7HJA9VilBeLR/+gpUSXu9cj3VmKmYyTPNZzS8Fla+3C4V
 6mM2W7YCJZiXlhSHYw==
X-Google-Smtp-Source: AGHT+IHKcF2++g0wusgoUDeHmIZClv5NVUKi6L+52mtdageLBLkne32ON9bDgwCYMZ/GfaeVIOSc5A==
X-Received: by 2002:a17:907:97c5:b0:aa6:5d30:d971 with SMTP id
 a640c23a62f3a-ab6cfcb6979mr2706860166b.11.1738593655675; 
 Mon, 03 Feb 2025 06:40:55 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab6e47d070bsm757877366b.48.2025.02.03.06.40.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 06:40:53 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9F6B260870;
 Mon,  3 Feb 2025 14:40:49 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Thomas Huth <thuth@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Hao Wu <wuhaotsh@google.com>, Peter Xu <peterx@redhat.com>,
 Warner Losh <imp@bsdimp.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Kyle Evans <kevans@freebsd.org>,
 Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-rust@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Weiwei Li <liwei1518@gmail.com>,
 qemu-riscv@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Tyrone Ting <kfting@nuvoton.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 10/18] gdbstub: Allow the %d placeholder in the socket path
Date: Mon,  3 Feb 2025 14:40:40 +0000
Message-Id: <20250203144048.2131117-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250203144048.2131117-1-alex.bennee@linaro.org>
References: <20250203144048.2131117-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
---
 gdbstub/user.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

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


