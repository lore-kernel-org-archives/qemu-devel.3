Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62761CCD1BC
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 15:10:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBaTH-0002HT-IW; Wed, 22 Oct 2025 11:09:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBaSg-0001NK-4x
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 11:09:15 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBaSd-0001Cr-QK
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 11:09:13 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4710a1f9e4cso51705825e9.0
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 08:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761145749; x=1761750549; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uXhjggSho/stvESB1e5DNT3GroHIpKkaC36CQ6szXx4=;
 b=LMCyG7TTt9opyvKCmnC1S9b4A5K4LI622Ma57WXfKF3yxTQ93R8IZwnq6kajOa6N6s
 bxVWfDSVbVsMJviblCEMIFIxXbGNWpC98ZdhywtNNeilKMout/AIcmynui0mQ36HSVPS
 LGnjc2FC9rR12H1lKK6DOsPEvYSl2FpNmcnGXm+kwvayNtuppPqRlRjSju8UPx1FlxbL
 B6xLraJOmoGp8xLYQhb5Sm+QDjdHa6dyiP0YaP/VdD7Au+YEWi6rNoYg8eRPOJDHBiVA
 208TTITDmdaWw08KSIQAvo+OkIG968PkMVe4spq/Wy0Zba6gZjEbTfTXOrEcO/L/kbYs
 yTfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761145749; x=1761750549;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uXhjggSho/stvESB1e5DNT3GroHIpKkaC36CQ6szXx4=;
 b=AGXCrwxloxIV5p8gkDk/hgDXuzhJe6p2CxTzoonDcUvAaNh+bgIT8e+Z2yCiYT2846
 uXJ0PNhTgmDcPiYPBnB9mYj8+X3mizRuuZVJf4FmiVdPx0eViys4JXaPOTaBQ4xHQjW/
 ccb/cweeHYg5qKMz+5WhT3TDAnDXOA1fw7hxZLnt77I4IgvK4VKchAUpv4eoWsjysqUs
 BQGwDZRqIPAXlWnFLEb4420ZNDVZ2NVhISHpvjV95vDEsz6OHKDeJHg8e9vXwQhEN/WE
 a2eHfh56p5yV8M2e9WLo5tZS+Yb1YtpKd0DUsXTE1WStW/bYHC5MmssNIuhvnxg1QC+6
 okXw==
X-Gm-Message-State: AOJu0Yy7XiFZ4JweHjqAdQhkBuoF0dh0kniTTqQAF32x67ghfwylw3+r
 lhspzyjTsqTUOa1SLL0CJ6yeQ/iCkkH1/0n9RL4/E8WIQ4fMUvdEiiPOpXr6PAk9J7Vx+ubacpK
 e8moo3uU=
X-Gm-Gg: ASbGncvkbAOLFxASlga24a8GHZe6jfXDOnmSzrbnKlZnqYH7q1XmbJdYgkpBVDjxl4K
 0LeXM2THODx2YeOY9o8eq58Hd6HSf31J7Ywa+MKDjoReeQ8ULiR1LlwotenY+gSvz5yPa4btdkX
 JNkoddJiX8k0HLlyaZNBKU85V30vFvq+Y1/0A3+WRmAAgmLYY59CTj/8nIfSDuFeE4v0YRsI3It
 GaSRwQCFgYTC9gfRiyWl2cLNvQcoKO5duG/kdGS/yO0Xu0paRyoyqESya4alN99vDZoaAnTvxkl
 GJ8yzHvFGgJ9ecQ01hdWvWiikVeE4IMxDZ0+wFnExLnSds7kx5R+BzYR4cNGVV1+exbQ24QY5we
 7/zdpruljr00aOQaOsYNVP/LnT7k4v/Es0PgP568g1L/WBp6akGuJuTRSbsDqeo3xR9Sdq8E/Gb
 QB2ghzr0p/seXoM3GzqVuFWyYtIsHF4yZrv0vkKn88UfhOGwkKh9XBaxxL6lK5
X-Google-Smtp-Source: AGHT+IHRb7j9cc7iuYG+wxsx2kJeU6+zjX3+rl19PmtzvZIUntE7l4ECz+iLaW9F8aD+LcUgLdxEDw==
X-Received: by 2002:a05:6000:420e:b0:3ec:db8b:cbf1 with SMTP id
 ffacd0b85a97d-42704d900a9mr14509133f8f.24.1761145748698; 
 Wed, 22 Oct 2025 08:09:08 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427ea5b3ae9sm25321242f8f.13.2025.10.22.08.09.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Oct 2025 08:09:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org
Subject: [PATCH v2 7/9] chardev/char: Preserve %errno in qemu_chr_write()
Date: Wed, 22 Oct 2025 17:07:41 +0200
Message-ID: <20251022150743.78183-8-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022150743.78183-1-philmd@linaro.org>
References: <20251022150743.78183-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

qemu_chr_write() dispatches to ChardevClass::chr_write(),
and is expected to propagate the backend error, not some
unrelated one produce by "best effort" logfile or replay.
Preserve and return the relevant %errno.

Cc: qemu-stable@nongnu.org
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 chardev/char.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/chardev/char.c b/chardev/char.c
index 5c8130b2435..2af402d9855 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -113,6 +113,7 @@ static int qemu_chr_write_buffer(Chardev *s,
                                  int *offset, bool write_all)
 {
     ChardevClass *cc = CHARDEV_GET_CLASS(s);
+    int saved_errno;
     int res = 0;
     *offset = 0;
 
@@ -138,6 +139,7 @@ static int qemu_chr_write_buffer(Chardev *s,
             break;
         }
     }
+    saved_errno = errno;
     if (*offset > 0) {
         /*
          * If some data was written by backend, we should
@@ -154,6 +156,7 @@ static int qemu_chr_write_buffer(Chardev *s,
          */
         qemu_chr_write_log(s, buf, len);
     }
+    errno = saved_errno;
     qemu_mutex_unlock(&s->chr_write_lock);
 
     return res;
@@ -186,7 +189,9 @@ int qemu_chr_write(Chardev *s, const uint8_t *buf, int len, bool write_all)
     res = qemu_chr_write_buffer(s, buf, len, &offset, write_all);
 
     if (qemu_chr_replay(s) && replay_mode == REPLAY_MODE_RECORD) {
+        int saved_errno = errno;
         replay_char_write_event_save(res, offset);
+        errno = saved_errno;
     }
 
     if (res < 0 && offset == 0) {
-- 
2.51.0


