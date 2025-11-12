Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4751ECCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 13:52:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJBFo-0002DP-Nh; Wed, 12 Nov 2025 08:51:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vJB7A-000459-KQ
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 08:42:26 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vJB78-0001LU-OP
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 08:42:23 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-47778b23f64so6115995e9.0
 for <qemu-devel@nongnu.org>; Wed, 12 Nov 2025 05:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762954940; x=1763559740; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0pYieo1+6dfcbenlhIHP+WF6cacxySZysF7HQTfjLpY=;
 b=hecaKoxMEl7efQPk9yWWW1pdI87O9i0+bH0RocQ8y6RNH+MfsCvA7K4U29ScnaiAUU
 nSlliH48yt9LeI0DoSnTHkXpStv541uVbagbQrQmFPLoijj0orH0f5aQQJcTm3e0AiKP
 VXxWSu2vT7Mna/2ei/4lQWntxrtNRL5vNxCcB9rf5R2235xYdX7jXXZkDybh5gRzjylK
 khql888gHyRqfYLm+FZjNkWWz8vw3n2T+3sOgU2a8qo0PyP8kdEAh3OrKJfwiAtDfS6+
 12rr+0K/LszfafPJFi1Hefof152Zg5shJQjqGR1Pt2VXFY05n5+e7KpjrDqr83yeFTbs
 1GmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762954940; x=1763559740;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0pYieo1+6dfcbenlhIHP+WF6cacxySZysF7HQTfjLpY=;
 b=oW/bUD4kIA5Jieg6Qp2drULeRKnKfUFnzTH9pBcL7T4EIvZ7TNY9Dk5iPwqkDVPweB
 31MKsHFlSrQBTplp78LPUcaH+1mVhlCM3S3UZhVOXvt8vg5vz0TN+EjDBJEfBPvmhWUw
 F8Ntv6AJUmgn2QB7PaODbgqTSXu4WXSmJKBMpKuMCmjA57osmB7Be/1tsWLp/AdeizE7
 VD00uVBty9CukRzeUYJAWSGcj5phMjzMwOs/gPy1yZKOWHgBCfSjOyfPxtDQ5tirzCIq
 HkEzs7n4WaZszzz5IPWpRrDBxDoMxMz8vTbyEY1SnLhCmb9ms5vUgZ3g8HUGEDP14TJC
 OHOQ==
X-Gm-Message-State: AOJu0YzNEf0HFyOzCEw8rF/vnwRb6O+xjMvLTO5/N0qodIQFwOttxK8v
 KYOjUQt+Q+AQBpRUVFvw5TQJE3FAfVeHFg/gqEhO9OqyDN6loRVrERMvqcDtV+aq2/w37mN4Z33
 XMKTmhXavuw==
X-Gm-Gg: ASbGnct9P+AerKqWfeEEc5UWKqfiWb4R7fz6oiAjDGPPEJTFOoKMEnFXBLab8Fm2Y2z
 doYZRNrNoxj+WXoDKUPslmSbz8DNv0a0+tqIw8SGYY8BTwvEzR5oo+n9Lh64m6pYvhPkntzi9HI
 qtABPQHZpq1RLnO5WmYzcCkIv9/3INlZxglmBQn3TzR5xaOZfl5CBA52yI8+T2zvDzrKgcFBiWO
 wSlEagQbKR0zUtBlnqEyRwbT2MwXjhUIWlE6m7wCf0N42MqsLdSK25iNp1Unp2APY77q7dCoQHw
 I6T/HviQL71KpAUPXdtQ/9niCUglo4U5j8ORNPOkHR9I4lJ/0zDwwBbjfGP/oT2Kt/ZT8CJf1wZ
 UzIyxCSW6mEL23L/WTbx30CmzFGiM7z7vr3B+xsazwhcQMiftDbn6qe0Go9vXlHQ0DH6hIh7+UF
 Rv6/Not5wp/UrddPvUhR1Tu4nwQNOD/GDJMQiomFEkklAtD1YKUQJkD3I=
X-Google-Smtp-Source: AGHT+IGme6ut1aBA7asl3KLM1DTfWrl690FNOykvafBr91i6tkg4cUEcJk3nEYeyRbiaG16S5eqtlw==
X-Received: by 2002:a7b:ca49:0:b0:477:8a2a:1244 with SMTP id
 5b1f17b1804b1-4778a2a1695mr7485285e9.11.1762954940592; 
 Wed, 12 Nov 2025 05:42:20 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47787e486fbsm34773685e9.5.2025.11.12.05.42.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Nov 2025 05:42:20 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org
Subject: [PATCH v3 05/10] chardev/char-pty: Do not ignore chr_write() failures
Date: Wed, 12 Nov 2025 14:41:38 +0100
Message-ID: <20251112134143.27194-6-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251112134143.27194-1-philmd@linaro.org>
References: <20251112134143.27194-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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
Fixes: 4f7689f0817 ("Avoid losing bytes when on (re-)connect")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
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


