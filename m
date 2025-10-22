Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77732CCF9E1
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 14:50:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBa9r-0003Cc-LL; Wed, 22 Oct 2025 10:49:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBa9q-0003AH-BC
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 10:49:46 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBa9n-0007FC-LX
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 10:49:46 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-47117e75258so35868605e9.2
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 07:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761144582; x=1761749382; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PpX/2+MBiez8U9HpiPaqbx+2JJKLT0Lt776CCM/DT2I=;
 b=iGmpK9MoytVeJR+jH+OPHfwOHojvnxQ8fqG+mPtbZ1RY0Us0//zPahA/RJg8476jgQ
 fHwLYSxgYvlKyHEVNcg18AwKzadNIKv/82LrXqFNeE1W3lBE73PjDYbNIF/um7Rx6NtH
 QZNfXf4oIdbNWJjDial0urc7JhOWlRtP49+KrVJ2OoeesVA22kg1tirsf1e3r1nJv3vW
 LPMpR8lG4GKWNN17D7YxYHfj4cSzhapBoZ78Ff/HnjnYx2C65PoszbAikbESLdpHu9vY
 xzn/5uOdqmjkPUkQTFBeVDN9sk7xhxo0/OJxcGrkstLgZ2i92u1PgnNMgljmKTg6dr/+
 LNgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761144582; x=1761749382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PpX/2+MBiez8U9HpiPaqbx+2JJKLT0Lt776CCM/DT2I=;
 b=Ug/CJzctyLVm1jujZ/zEjvUDJhmAD01MHkGeqq9SwrxhXym4YP4lJ9rR4ZPyApFRnZ
 OEi3km9ltEPPA+hscO/ZrgvegqlQEoVJRrIARtApPgI/iewMd/iXmj1mvTJXdBpO8V38
 5G5tJht/NcHMaZ5Qj38RFGc9w/2sp+gIOHVyx4HVn0k8OmDFVNpMS7HlGHaa45K+E2t3
 6FKgxhZ6RgACThFoMGeP5T1UCg/q+5KcPwbx9Zrjp1rsKdAhWGt9or6YDqwl9maqAAUd
 SVC8vXQh9hYOC/TRxDDdjmQ9LoUzEEadbAaHg1jb7DU1Re+lreXMhHMNGtHhpbA96Lp3
 j/pg==
X-Gm-Message-State: AOJu0Yx7nOZipYrLcOxkm84tE6g9ZcRXe5SMKLLm01YeDQM4yUYMP9ti
 yhV7EAmeIq+ifEJMXfnFXhD4jS7cK3L00rzpnv7hXpk6tAg33GsyXSsbNA0paEOT1AGzOedHtq5
 kfgE7eBQ=
X-Gm-Gg: ASbGncufhzPApwAZuwaAfvxAs60pofP1+8GyfIra7uw5v72GdfqUBdFhJUt94yQLZxw
 MDGZDyknsAtHnZTZI8N823bPrCDNuBtXfp8DDkbNCZ3WrHc0GngBiaXAwKHtPi/ofGwC1/F3+/G
 Y18fW/rZnAy5gMVCynmA7JxUQGzZws4nXwVSyc7W72/JnvYybaD4hWVyH2EB4Vhq0bydeMzEf29
 39DSQmZeq9/kIvcIfeVnZWiW0lxbMmeggBVnlFwiGrz+XVEx2mcseFcT+HQ9g3V9GWG45fwxXn5
 5DOSjrdJU0MpxY3BMFKxRKeL3IWgOsPFf5KV4wS8CEmjbv786g8NRBM9LuvxlKme4bJrDpXi0L+
 Oc0swskU/DscCYpX4vdf6yTi1I2uoMoSHhhW1j0+f2aAwIOjH+VAiN2G+hb08ZFAx6BNkyjWqKC
 vd+6Zc7l0m0PkcWEuIy9d6kIEoKLGLjmeEXfhEGoZiYg4f9GFz56Zwyp4HnA7D
X-Google-Smtp-Source: AGHT+IFeufzexzAg/eoWTpa3bxPhIVQIIaXKb/ZYl3aHjZGenDgDhIYFv5Y37JWJP/z5ld4JbXnNGA==
X-Received: by 2002:a05:600c:4e42:b0:46e:31c3:1442 with SMTP id
 5b1f17b1804b1-471178afc07mr146791105e9.18.1761144581681; 
 Wed, 22 Oct 2025 07:49:41 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427f00ce06bsm25005321f8f.45.2025.10.22.07.49.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Oct 2025 07:49:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org
Subject: [PATCH 3/7] chardev/char-pty: Do not ignore chr_write() failures
Date: Wed, 22 Oct 2025 16:48:58 +0200
Message-ID: <20251022144903.74612-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022144903.74612-1-philmd@linaro.org>
References: <20251022144903.74612-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Cc: qemu-stable@nongnu.org
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
If ignoring this is deliberate, this must be described in a comment
to avoid any confusion.
---
 chardev/char-pty.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/chardev/char-pty.c b/chardev/char-pty.c
index b066f014126..652b0bd9e73 100644
--- a/chardev/char-pty.c
+++ b/chardev/char-pty.c
@@ -125,7 +125,7 @@ static int char_pty_chr_write(Chardev *chr, const uint8_t *buf, int len)
     rc = RETRY_ON_EINTR(g_poll(&pfd, 1, 0));
     g_assert(rc >= 0);
     if (!(pfd.revents & G_IO_HUP) && (pfd.revents & G_IO_OUT)) {
-        io_channel_send(s->ioc, buf, len);
+        return io_channel_send(s->ioc, buf, len);
     }
 
     return len;
-- 
2.51.0


