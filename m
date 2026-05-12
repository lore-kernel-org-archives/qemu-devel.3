Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 976D8CD4F35
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 10:43:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMkZ8-00007q-A0; Tue, 12 May 2026 06:42:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wMkZ6-00006r-Ev
 for qemu-devel@nongnu.org; Tue, 12 May 2026 06:42:16 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wMkZ4-0004w7-G3
 for qemu-devel@nongnu.org; Tue, 12 May 2026 06:42:16 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-44ce78ab5feso4651018f8f.0
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 03:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778582533; x=1779187333; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LLH8pQKACICkrBKBFH4x8j50tPMfXmJy8o4keBB8qOk=;
 b=pIHfrB+eI0TTqZxa4WT2m8pLPUgoJdhuuLnL4KmYT7N0rfF3lCF4CK+lWUC2ZKbAsK
 G7LHUtphYcQljbho9aGsi8lN6gMYieY6cUSuEAQzz1eohLJRRPlNW8mc2s2rnncRUgGB
 ZeBgvkoaVSXQAIPTgJelG1Rg3N15DOwC0AM6JsaDwgh/E43j6OBvKiuGZAhru9XqXSm9
 HGSGKjvB9hquU9Sjur7eQBP+MMk9exn8z7WhDV3C0OBDnAsc5Ila32w70fWu3fxLZyRm
 dx+bvEnIwgkY7Gc/IiYFXvhB7J+wqUaD93rXfEDJsmZtsIfQ5uTjtLjhMfKYUR9V5mnK
 Ap1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778582533; x=1779187333;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LLH8pQKACICkrBKBFH4x8j50tPMfXmJy8o4keBB8qOk=;
 b=UOdbaXG3oT91dqMQDUDPIdtrVFfEMQgHwGfc52clbHRTNW5F70wdRsxSxXsOoq4IR3
 g3VEewggZgWXvLtDqOoa6+r1WZxvHjN+/79JPKmfVt80MpdcSix8Ccl3luthJbO1Qb8J
 yy5zPJsaErYsPLMVVfot6oaCqTf8K2SFfgKyc9xB0IhWhnw7srIACxVdu7P2mMf6GHT6
 wf1q8hJJbtM2nRWnL0uJFfLfMd7JY+WPBCOLKEfRjZTj7eJ1s3okj61yfjzBNsswrqaS
 8zhE+gPDr6X6hsHXA1309XrRpmjcrYAGiY+BQGPS/vLR0m1k8iz4fIOpeTkfHTwvpCTB
 iGgA==
X-Gm-Message-State: AOJu0YyhwGCTCk7j004bTl+z3QgCV9hzLAJaK5KcAAEJ7sfj9RG8jH/E
 2irbxANkLZIwuR2/W3N3k8xlYNeDvIHt8WhPlG8kYyOwjwpelas0jzNMBhpFvBNhmVzV/HOco0y
 WKivv
X-Gm-Gg: Acq92OHld18c+IazvxUZi608k7MCM+WsThdx6gEhVOxWCZ8krsmo1u3EmUXZLpO9nvg
 hXRFJIPush6jSIXk3LZIJ8DKMlTzUAyNhyWmSqCJU5YveVC76+S/AC4t6A2cQqNrlyJuWiFt/xg
 7hlEVc2ceele+Esp8boPtKB9/OgA9D9BYzAelD96eBndPipR68PzqKjRvwBLXguIscD6W+IYCMo
 f3v25dfMZM3KiMVrfu9Ldh6HvsvpbrDCSS6EP/f5Dx5bJP8z5rCX7Gcbawz8zXyCK4CPxAaJFdh
 kmVni9S8IPf9v5BuxkaPpy3PrJcoYVqT4PQEgQB09DAV79/wahz7aIDznD/tONJedFMYIv5Qe05
 yLT8MaE1gJhZMJvSF7rbA4K+5nRH0rSI0/YSSmtfRVlJHZF4C6qDda39LQJXa5zIoXJQZl7wl4H
 3sZnKw6p/jc7tCGdJNK+Cb9fIKmICeMKefuVgUE9dQqfudx1cS+cQ1NQ6oAHHwUcYYVe7jUgRzg
 4vDD1O5uqjjSYzTuSQ53OnELtUFqJk=
X-Received: by 2002:a5d:5f54:0:b0:43d:613:33de with SMTP id
 ffacd0b85a97d-45b13790fb8mr3522907f8f.20.1778582532836; 
 Tue, 12 May 2026 03:42:12 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45491f8d4c3sm31481680f8f.34.2026.05.12.03.42.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 03:42:12 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 0/2] ui/vt100: Use uint8_t for byte data
Date: Tue, 12 May 2026 11:42:08 +0100
Message-ID: <20260512104210.3330835-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This patchset is prompted by a Coverity issue CID 1659590,
where it thinks that we use tainted data from the guest to
index an array in bh_utf8_decode() without bounds-checking.
In fact I think this is a false positive because the array
is 256 bytes and the data from the guest is always a byte,
but both Coverity and I get confused because the chain
of functions operating on this data switch between "uint8_t",
"int" and "uint32_t" types to hold it as it passes down.

The patchset standardizes this all to uint8_t.

Peter Maydell (2):
  ui/vt100: Standardize on uint8_t for "ch" byte variables
  ui/vt100: Take byte as uint8_t in bh_utf8_decode()

 ui/vt100.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
2.43.0


