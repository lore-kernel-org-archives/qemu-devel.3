Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79012CCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 15:09:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBaS7-0000IM-99; Wed, 22 Oct 2025 11:08:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBaS5-0000Hm-2S
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 11:08:37 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBaS3-0001BC-Gs
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 11:08:36 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4710683a644so10003635e9.0
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 08:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761145713; x=1761750513; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8QDJMFH+dcM6qM074DoLCqmO47D4LxU/fxPKd9vCjyg=;
 b=F83i0niClYYxAtjOv755BaOusBak+qk6Be7fz+Pb6VRJGnKNCow1JmUboPxJce6rK6
 Vxz9seY9RBGn8l7MT8tryhXUpR87ZD70nwwbura+9Q/oDSG4pzkEffId4Ne9OCwn1an2
 Cl/ODep6HdMSAYHNLQH6a4lEg5l0P+e53v31L+8qm4e8+esR4BfQB0RK+S+8zMzzCp9Z
 AAyvR0j8RXjhtpBmMCZ11r5PxvNG41qbSSc5RWArwUzJ/IAXTxn1nFBlbe/BdcKdS/fF
 zrwByl6mFMyHTy2lS8KCZSO6jyELlOwaNnVeAf+krOsIQHo+oBFZpWWW7g9p4JKcTtDe
 0CGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761145713; x=1761750513;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8QDJMFH+dcM6qM074DoLCqmO47D4LxU/fxPKd9vCjyg=;
 b=m30Cng/a/pZyAYvHo3YJ08ongm75EXvw9w4YYWgK+YM68sb+19jWNAMT3EXMxu099U
 9DECBs1ZbUKNBqcVDB9xpX4Q4o+DbTIgU8rxPeT8rXqt33ybUGYUc3DXZLbHmpxUjGL9
 jXVS4KcFoSlPwhfS+uI+7fhfIJBiHCSi/wN8xsU3OQfHaVmV6P6+yyYvfP6ZkwTGWI+2
 zVidUHNPyizO1ATBOlFeV7+gXPmsmv2p2a7cfEnSCAT+QCf7RkWScpEocxvzUybWfIOk
 uZ18BcC/9jBHdUuWb2+FddrJf+t+PxjqOL/o7wbePZTNVzSgtFlwgF3tjDYOW/zNC1BP
 TlXg==
X-Gm-Message-State: AOJu0YxMIVXl0ifhDitIPxKRGgnyMwpWUP7rwKqscsC/1k3nHbKhjl+n
 3ix/QM7w4Av/bz7+7K4OPs6UXiLZtT22ctjf9NK41UhIWc0CCaTZlQpj70fJbISkJvdih22LBTZ
 tIqIoKK4=
X-Gm-Gg: ASbGncvCGtwlrKYl5G27+SEpF9A0kP4RBdLnxQ8b+0/UVCDqgJybAbh/y/KlhpYdxMJ
 /dotoqgPILx28IHlg+qO1z5G5p4qUuno041sQug4K1jmRc0ZSLnoK/MZILYUQd6RKLKQzpThzim
 3pzh8+Gt+DiGWiLjDAj7gunS9gNoZSWZH5TbqCcexpWqBRPhbTH4VcFa+cSCKA2jilo8GQe8jrX
 9p8dmSmUk1arCYKXkC6i1dYho7kFculfHpWElC7cuhgCI9XgScO5sMvRi4cifdtyy2kYgyegI75
 ++cYs+e6w9cunQduaZn6ZuS8oS2wDHDfHvY/TD7W7PgiJOpbRGdJyE9AzMYj3b5Ms5ubsKiTRnT
 y7TjQETB4z67AwMFh+M4WZL/3iQgCgj/lh1F0eV/E3a5BGxHsNnvAkpGV/uk0Q2/43TSEwPUjYJ
 Y9nC7P7+0OXN46c5/hygMHseQtvSSNFhSsIekGTl8jE8dKSmy9JBVr4kTQm+iC
X-Google-Smtp-Source: AGHT+IEjvrOXrhPSM2M+ZyQBMv1S7SxinGaNet6YuV9WPBOkUs26/pChvIGc9B4IA10NohCvPq354g==
X-Received: by 2002:a05:600c:63d7:b0:46e:74bb:6bd with SMTP id
 5b1f17b1804b1-475c6f18706mr12789235e9.4.1761145712734; 
 Wed, 22 Oct 2025 08:08:32 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c427ed3fsm57895415e9.1.2025.10.22.08.08.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Oct 2025 08:08:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 4/9] chardev/char: Document qemu_chr_write[_all]()
Date: Wed, 22 Oct 2025 17:07:38 +0200
Message-ID: <20251022150743.78183-5-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022150743.78183-1-philmd@linaro.org>
References: <20251022150743.78183-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/chardev/char.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/chardev/char.h b/include/chardev/char.h
index d809bb316e9..8b1d5153dfd 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -223,7 +223,31 @@ void qemu_chr_set_feature(Chardev *chr,
                           ChardevFeature feature);
 QemuOpts *qemu_chr_parse_compat(const char *label, const char *filename,
                                 bool permit_mux_mon);
+/**
+ * qemu_chr_write: Write data to a character backend
+ * @s: the character backend to write to
+ * @buf: the data
+ * @len: the number of bytes to write
+ * @write_all: whether to block until all chars are written
+ *
+ * Attempt to write all the data to the backend. If not all
+ * data can be consumed and @write_all is %true, keep retrying
+ * while the backend return EAGAIN, effectively blocking the caller.
+ *
+ * Returns: the number of bytes consumed or -1 on error.
+ */
 int qemu_chr_write(Chardev *s, const uint8_t *buf, int len, bool write_all);
+/**
+ * qemu_chr_write_all: Write data to a character backend
+ * @s: the character backend to write to
+ * @buf: the data
+ * @len: the number of bytes to write
+ *
+ * Unlike @qemu_chr_write, this call will block if the backend
+ * cannot consume all of the data attempted to be written.
+ *
+ * Returns: the number of bytes consumed or -1 on error.
+ */
 #define qemu_chr_write_all(s, buf, len) qemu_chr_write(s, buf, len, true)
 int qemu_chr_wait_connected(Chardev *chr, Error **errp);
 
-- 
2.51.0


