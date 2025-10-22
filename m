Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D636ACCD1BB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 14:50:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBaAJ-0004Yr-Nt; Wed, 22 Oct 2025 10:50:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBaAH-0004Qm-Uv
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 10:50:14 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBaAD-0007aj-68
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 10:50:13 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-47103b6058fso7911265e9.1
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 07:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761144605; x=1761749405; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uXhjggSho/stvESB1e5DNT3GroHIpKkaC36CQ6szXx4=;
 b=sZWjASTcmDqrYjsuwqsMrYtNliEujILPzDuQuN/ePMujDcSzMGmWbA2Pp/WCpLgQIk
 lsPNcYwNWQQHjMRARc89l/ZxPm4lHmMQ9JyuSqee9uPrifNSIGVgzlZzhK4+nqZw/VXN
 WvGhJE6ZzQl1vmiWy6TzNWeUql2DbH8gDJeyXqxSqTwl0+PFjig0Kt2pBmlbDjcRJ34g
 d4nyWhqFcPYAkdaoZ+vlFH3nm8ozSSe8ZIOag/R2sXt2BjcYsLwM8wKIxWSTiL/kDCNO
 gIi+RPoOoyeiUOAJCq5wlHMDcdEPgF/pOwgXXE6JeMrK17A18CI3SDUH8vUT/LdI0CQ5
 okzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761144605; x=1761749405;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uXhjggSho/stvESB1e5DNT3GroHIpKkaC36CQ6szXx4=;
 b=jtEPFmzLblkZi4GhcuH9gsF3t6cxXeDCsVtXiOKHaZVDc0bMB/Nzi02GU41110A4NG
 VfOnejvUpYG7PbLiiyC1PsiiXpIxXSBmM7+Pr6phxjkUgPm9Nh2E+SzBcjwzGlU39H3Y
 bsFRLFkS/iPwmXCdc8KBLFnBbtk2llCOLYB1To+mhzrmysbrs/ze16nKVzuDV83BEdIs
 rGVSkf8B06nk5dpdzMRQrRFilVPzmXHZCpIGbiMtkctrGjPCF5/xVZMz7+WVnM3JWaN9
 wocFravARSMoGUTyXmrlsNeWrMm6y0jnDW1mamjPm1TEJBc5IYyQBfwD5UFIbihjOL3K
 Kc5g==
X-Gm-Message-State: AOJu0YxLl9TxJDeTVpTnoRYp9Le9RQl24V4PAhPVXzVGpX3Zmf118mO+
 bKNVnROy+TEHZ2MQIxdxfnhNnfjhI+SFTcZWSyVk+S5HDsN15S1nbx8Yzcxg5MJHzggL7Ia1Kjt
 6wUv7TL8=
X-Gm-Gg: ASbGncuoUicxFtZMo58MKaFNhv2F6CNzTUpLm2VgYbP62O21Y8lF4GdUBrNyJsIiXDC
 VfqeiiL0pVImMJ7JRBkJCohWJACFyfZNgkS0su7Pe0sNk22GtjGSHjPMRyZ39TQnc7v1sT1EOYO
 tPtNBe06spZ52gx3fNhTYxfIfn98SZmna1ocs4CQlmh27Qz27y8YhPwfP4nLYpZS3ya6CvGUwlP
 yMai3cLqdbvicxFdBD3JRBiH0VZqo2uqe8CRXqZSIGGReE1tKrKYGf0eh+fj3iuDB+7JJgAoWkt
 nBwukfE62W7tc3bFpw33/AfMYsSYrTYj2Orkmj3M4EpzQ5iZUolnZsIcafZiCgHj0oOG6IawUMP
 UvAIfO4nwz6+9DxJt0oMkwuQmgOP5ubZME9XKO9yuGQnrdRRXRWl1BiFHuSkbV5M1AhTDuynKdg
 JormZGUKeqsQKlY/Kyy3IaWAytCNP9v9EZEbCinDer90YKJpWDhhZm9sAS1Fyn
X-Google-Smtp-Source: AGHT+IErFlVBAfH0mUFgLYepVZZ40yv1EyZXa/oNzJUpVKoKh1DpCn4Z6s+QoLWuSVDSx6SPzo1qgg==
X-Received: by 2002:a05:600c:6c07:b0:46e:6a3f:6c6 with SMTP id
 5b1f17b1804b1-475c6f1fd1cmr11488535e9.6.1761144605471; 
 Wed, 22 Oct 2025 07:50:05 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427ea5a0f7dsm25091777f8f.4.2025.10.22.07.50.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Oct 2025 07:50:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org
Subject: [PATCH 5/7] chardev/char: Preserve %errno in qemu_chr_write()
Date: Wed, 22 Oct 2025 16:49:00 +0200
Message-ID: <20251022144903.74612-6-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022144903.74612-1-philmd@linaro.org>
References: <20251022144903.74612-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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


