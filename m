Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C79A6E7718B
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 10:59:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTIuR-0005DK-MO; Thu, 02 Jan 2025 05:58:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTIuO-0005Cf-Vf
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 05:58:32 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTIuN-0000MG-Be
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 05:58:32 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43622267b2eso118886515e9.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 02:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735815506; x=1736420306; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=L/j8G5JVfC/edLaXM5aXpQItqqKBeIwBiIxQO8tVbYE=;
 b=HZFWrWqywyTLvb8Qv1ioBLt4M087H+psCHryadeSYe0WuuHQ9Y49OJ9PQaHtNzavWN
 nj+Mnsq9OBwsB8D07Jk+GO5h+eOqsI7u8zhoIJNz4vE4oPgvjZjHQmXmKgBmgCRadQI5
 H9lC2/5U4EViNhx901keX6Oy3gG9l28MPCDLNmTHDVk7EiePlIaNt+SsYz7aw+6P2U2y
 sQdrbQXnwUnxkAySkC6WS7qWNVKLwzB1J5JKp968CekYNTmvsYQixETyZhieTpd2VV5l
 +JsE/w9V7NWbi/nKKnaV1Gl78AkxLt2cbBB9tSyLyrXzCukY7IGTOgfYVf5gzAfSIvAt
 oABg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735815506; x=1736420306;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L/j8G5JVfC/edLaXM5aXpQItqqKBeIwBiIxQO8tVbYE=;
 b=B6n2cGESKCeP+RDPl1GSu9E9h41q2ftlQ3JQHMv5C3jsIrihz0kgCUts9pkzjv7dRj
 2eDrK5iHTYPC1Ki5bqCtW/rRvhAykLUIQ4jSduQT7rMwKGko+NFPtoPTNiORBG17rnjl
 vEFvSkn8POZm0JffygH3KLiKnk/N+HHfVBFgPNImDn9UY7WXotH8+rjpt5jMONKH6+Ws
 oStWR1W6DG/PCb0xcZA9Jhhz42KbZWCQuo/atp4YWH1AKepga1ZgQ1KRxEXGFHkk3/fP
 ujXH01FJlnqHm5u1W67gBHSTYny59Rt23+1IB4En8ruQqcsFn2b+FEEJ3JC4mxIgf0wi
 Pbqw==
X-Gm-Message-State: AOJu0Yw7nfiG/lzLJZg7qgkEkKourZBPOKMSy9M0nKRO/VEC34yH1mI+
 HsR3bc1vj51Fl1QIBiduEnChdCetrzVeeGs59AQFWOyqhSEO67KQohFKVRwB8HPGQNzhdFdhvnc
 PrvS9ww==
X-Gm-Gg: ASbGncue9nsjFYvHhp87uMAUlLHeEcf/HrR2dT6NDZV4rFne261koBfXGjg1SIDJPu0
 iSQ6tEWq55pZoYgIFog7jeAnRZZlUfEHWl6lVydzYyeth9HNkVUOxXd5TpfTZPU3r7v8Ku10q2O
 RcvCOWaMhY7YZcDGSlwE8ie2m17hXROHl/JYvqjNjpQFc1oenGoRXQFk0LXeTSD48feU4rjtjVK
 0nktJIIgG46W7/4n6u5R5Q8oCRCYj7Yk1xinZfIx3NxHQcL0mPU18WLuAzaniKCeK5ZXZjxd4E5
 NaGyIMthwmA6MJDQzKapJE6l7Vlqa7+Ddfy/HQhNKPZFZQ==
X-Google-Smtp-Source: AGHT+IGkPhm9Fit7zgxsHHqVLXU0K+bDv6jss/V1DIIE2ndr2jYlM1HJ33ssoTVHdOXAP1gaPtsqMQ==
X-Received: by 2002:a5d:47ab:0:b0:385:e16d:51c0 with SMTP id
 ffacd0b85a97d-38a221eaca5mr38013414f8f.18.1735815506135; 
 Thu, 02 Jan 2025 02:58:26 -0800 (PST)
Received: from localhost.localdomain
 (161.red-88-29-191.dynamicip.rima-tde.net. [88.29.191.161])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656af6aeesm485138145e9.6.2025.01.02.02.58.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 Jan 2025 02:58:25 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 0/4] tests/qtest: Update tests using PL011 UART
Date: Thu,  2 Jan 2025 11:58:18 +0100
Message-ID: <20250102105822.43532-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

This series split a patch [*] which was previously posted
too compact in multiple trivial steps. The last patch
initializes the PL011 Control register, enabling the
UART and its transmit channel, before using it to send
the 'T' character in the boot-serial-test.

[*] https://lore.kernel.org/qemu-devel/20240719181041.49545-10-philmd@linaro.org/

Supersedes: <20240719181041.49545-10-philmd@linaro.org>

Philippe Mathieu-Daudé (4):
  tests/qtest/boot-serial-test: Improve ASM comments of PL011 tests
  tests/qtest/boot-serial-test: Reduce for() loop in PL011 tests
  tests/qtest/boot-serial-test: Reorder pair of instructions in PL011
    test
  tests/qtest/boot-serial-test: Initialize PL011 Control register

 tests/qtest/boot-serial-test.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

-- 
2.47.1


