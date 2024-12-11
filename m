Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A43CC3DA4A
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 23:38:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLWGs-0000kl-7y; Wed, 11 Dec 2024 18:37:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLWGq-0000jb-Kz
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 18:37:32 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLWGp-0007Ox-8U
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 18:37:32 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4361f664af5so48575e9.1
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 15:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733960249; x=1734565049; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1oFMdKOr85bNvMIWJORghdmpH9Adk2WysMLQRAIunfw=;
 b=i2d94C6J4DuycI9ZB2jggwgWh1jtFi3WsMn6MqpBuD3I2qqJNnT4mG02mUd9otWZ1b
 +Dm/x86xUn2jNLabQDwPYryaWADiheY1yv4FEfVtq05dKlw9RVi3WUjwriS9DGuw033A
 rgnONejUc8OA/Av2OCdzjKIhIl+mHw1ljqVr4HksYNc+5pyN780PYxnx0PRhjABnyf1X
 7Kgwi/u4gtdHWXt19ZA1rTi7paSDRJXC50ql9ntww84OTNTI8MjvT7RBHZaOW3wNKUaT
 HckZelxZ3x3+QazIbKAnpXLmOzMVY+l8FygxLN6ljHtLY4L9XIwsdy+34NTLat5LAghm
 mYRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733960249; x=1734565049;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1oFMdKOr85bNvMIWJORghdmpH9Adk2WysMLQRAIunfw=;
 b=HGBS8hgAlExk9iKHDCLfKKVqizHVg+bAofbPzHzpGK7L0qdO9XeRvvkVimnM72QRn9
 WuUIxw9JaBEpgZUC7o9LgMwDgewbB6M6XEHwTTfRUCvKeKQJSBkKDIw0OLy7FwPznkTw
 RzGNLnWfZHCh2m4o9pIX//2DqmyM1DzGbG+vDkJunotlzM8VmEX+j3SiBCtURFwCdzJI
 T+DW3IZrBzSyUDxRw6k7/2B7YmMmuI8fxfsITQUIThmK+kCwT1T+ZQMuLrHoWvD13UFk
 wxoLiOaQBS7ykYi1nZ3hkp6q4tPlhYjcvYxCW+DLZo4A6OXe8WJxNxXnt5vWxvIsqG+p
 DdUw==
X-Gm-Message-State: AOJu0YwHiCyrQ7cIJCobcYrNHiGchNDTbNDUWzE4hPIGqXk2zx+/aEpz
 9xJfAH83tbUvDwLomTAX0NwLihaU5Vd07akFdtyF5+ONtTKJADp/cpoGbBwFVEjsplu8cCubBJ9
 S
X-Gm-Gg: ASbGncs39kf+oQonWl4j4yIGeAXc+erZnqxXTBWW31/82JNe2xzylparWQg/WQqO0sR
 +kNXhfC1n4dqdCUqE+M5H1fz40+rR0914JmrKQd0fes3QxrCSwkDXmr/r+GIJOOviDn2yXkW5vZ
 zuT1uni6028aoVVg4a7j6ZGV1uDUaxLqUoJiRRJOn+smhufs7bgExptgEZPLLVeAx8b7j46gQvg
 xvB9FQc546a8YalSfbnuyj+lj++jwce6fUdjx1ZcqWcBAiI5tQwM/O6Oa7p5MKjD//H/dPgtVXd
 8gZz/xw1Z25UX2dtOiJX/RHV/6VsodYF/w==
X-Google-Smtp-Source: AGHT+IGiGWlXh26yXytaZOTs34sbYU0SROPDXBjpAqGXFavKB1NnaAP9OBk6s7Mg3sbDtQDkCsqnqQ==
X-Received: by 2002:a05:600c:22ce:b0:434:e9ee:c3d with SMTP id
 5b1f17b1804b1-4362286c27emr10371635e9.20.1733960248859; 
 Wed, 11 Dec 2024 15:37:28 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f55733d2sm128445975e9.40.2024.12.11.15.37.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Dec 2024 15:37:28 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bandan Das <bsd@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/2] qtest: Remove uses of 'first_cpu'
Date: Thu, 12 Dec 2024 00:37:25 +0100
Message-ID: <20241211233727.98923-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
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

Replace first_cpu->as by address_space_memory.

Philippe Mathieu-Daudé (2):
  system/qtest: Remove uses of 'first_cpu'
  qtest/fuzz: Remove uses of 'first_cpu'

 system/qtest.c                    | 53 ++++++++++++++++---------------
 tests/qtest/fuzz/generic_fuzz.c   |  3 +-
 tests/qtest/fuzz/qtest_wrappers.c | 53 ++++++++++++++++---------------
 3 files changed, 56 insertions(+), 53 deletions(-)

-- 
2.45.2


