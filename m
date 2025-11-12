Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A684ECCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 13:51:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJBEF-0007FB-Mi; Wed, 12 Nov 2025 08:49:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vJB7O-0004Cy-9F
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 08:42:41 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vJB7M-0001NJ-Ec
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 08:42:38 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4775ae77516so8961695e9.1
 for <qemu-devel@nongnu.org>; Wed, 12 Nov 2025 05:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762954954; x=1763559754; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QfROIVJKqfl7QKnSQpWNFzHIRml7qxEw0ys6YQW3ulo=;
 b=xXfo6V9ltwRGH22ODMXuLEq6FI5CeWdLN77Vy5/UNZvtfTdUv/mX71CcvrK9y66dkA
 x5MG/aOHoq2kuD6jV3XtMwW4P9mPMTqQHPFRNqRl1UTFAKToqswGPkXqhSa8flC8LyDs
 kEeDBiQLqGPLbeajjXu1fsL/Ta3ZKDzVMpS6VVO6On8YA0BodgvU/Xj8r7k+FaxaGGQt
 nFs1MIVKaBkompZLBGaR31v9sDaGUh/mWn3+oXJjzaIGoixWpfTo41Pbjoai1i5IoOrj
 a12TRQDKJPU11m5t7+6MmUxJr4bRKTKsI+tg1Evgdu8T/349sXde4Rjm961/Mpvy0BkP
 DPEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762954954; x=1763559754;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QfROIVJKqfl7QKnSQpWNFzHIRml7qxEw0ys6YQW3ulo=;
 b=wJlBE3CMteITKS0DXyN8E4IcqJJ+HDRREoSf/xuUgo7fI7Td4Z0JkazriHffbshkHp
 TgaMdvKK8i+N/Qn+jib/fYMaLr+YnKYaOjA3YYgM6V/SMumWaFYf3TUGBILxWHz1LOub
 Az+6nOtsuSBe1srjUb4535o8b9rDZEt5q26pQMYJH2B2jVpVese5g/8+GNQY59cZHFzP
 WSR8o5NyMZPFkHw+AfPXrtAwba0w9wtHBsBmEK1v971ZAgsjzpIuGqU+9Q3HnUblUOhK
 ieZ+0d52/hc9bXGmX3E8QZlEImmRknlf8gvFa2Yldo+q+umzx1l+qZf7ci4q6X6kMpAA
 K63w==
X-Gm-Message-State: AOJu0YyHYdT1XHAWBbzdPP0/at9genbYUy0rYQzV1wq/ointYGfKQD9Y
 Pqvkd6eBPU4JABHEP7NoFi46dFuRn60Z6uw7dhwJgKJuIqUXew7JQZGYFsfAJHBoD70WYa/cAqj
 DE5Q2IBdb7A==
X-Gm-Gg: ASbGncuUI5iapTMtPe6sNF86O4FTbJPevfM9RSl17IDlEnUsaleVdwL0dOAu8IN3qso
 IUyzw+VfjrhO+JZQeUn56N5yX8eT0ZZst/6D+TL2QUikL3gR7MzEFnTRneZqhf4xmmOk7WJeyYh
 Q9wgusxMlYFfMWs5+EcjEJgj0X0f7vedjxoUshFT9SiDEC2sCfx3knTFWX1BJBgWdeMV2kJg3UU
 kZKV/uIc/ViWa77kLvHwVDddctHbgAgqQ47hLyu2q7knDcGjF2S2jjYdO7i4FqUmP6AIcSH0uoT
 TcDkEu7fIrYtpr3MZ+jfd9HwSR1uJ9NM/HXyZnEl3ONzWuNuJKfekfpFbsScxhE6xmBHHFpjbZX
 TZly+lSWAsLdT+L4e81FxWOZw7MPR5DLo1eB4atUWURfA9tp0dZZJpOR4T5M00bd58fl99YEBmz
 CGIz8fi+hwxHctNnU6G2n/r+Lkwbohy6FY/t/IGsm1HeYgieISYEzd80A=
X-Google-Smtp-Source: AGHT+IFHHTPtzjtpxezcgC/tlkCl+4sqWp6QwK3mmQBikIms2T7kNlVM3+Z0g8E/zIvlPyBv58bN2w==
X-Received: by 2002:a05:6000:2003:b0:42b:40df:2339 with SMTP id
 ffacd0b85a97d-42b4bdb9f74mr2764618f8f.57.1762954954573; 
 Wed, 12 Nov 2025 05:42:34 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b2c6d3f67sm27951608f8f.37.2025.11.12.05.42.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Nov 2025 05:42:34 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org
Subject: [PATCH v3 07/10] chardev/char: Preserve %errno in qemu_chr_write()
Date: Wed, 12 Nov 2025 14:41:40 +0100
Message-ID: <20251112134143.27194-8-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251112134143.27194-1-philmd@linaro.org>
References: <20251112134143.27194-1-philmd@linaro.org>
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
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 chardev/char.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/chardev/char.c b/chardev/char.c
index 7931f4e0832..46a2dbfb5a3 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -114,6 +114,7 @@ static int qemu_chr_write_buffer(Chardev *s,
                                  int *offset, bool write_all)
 {
     ChardevClass *cc = CHARDEV_GET_CLASS(s);
+    int saved_errno;
     int res = 0;
     *offset = 0;
 
@@ -139,6 +140,7 @@ static int qemu_chr_write_buffer(Chardev *s,
             break;
         }
     }
+    saved_errno = errno;
     if (*offset > 0) {
         /*
          * If some data was written by backend, we should
@@ -156,6 +158,7 @@ static int qemu_chr_write_buffer(Chardev *s,
         qemu_chr_write_log(s, buf, len);
     }
     qemu_mutex_unlock(&s->chr_write_lock);
+    errno = saved_errno;
 
     return res;
 }
@@ -192,7 +195,9 @@ int qemu_chr_write(Chardev *s, const uint8_t *buf, int len, bool write_all)
     }
 
     if (qemu_chr_replay(s) && replay_mode == REPLAY_MODE_RECORD) {
+        int saved_errno = errno;
         replay_char_write_event_save(res, offset);
+        errno = saved_errno;
     }
 
     if (res < 0) {
-- 
2.51.0


