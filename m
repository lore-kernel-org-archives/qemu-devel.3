Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 325DBC282DE
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 13:11:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqXSh-0002hd-46; Fri, 07 Mar 2025 08:09:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqXSf-0002hN-EW
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 08:09:57 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqXSd-0001FO-Q9
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 08:09:57 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43bbb440520so20620755e9.2
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 05:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741352993; x=1741957793; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2pvYNU7MA+h112B0oi56XMWS7ccwT2Ys8CQNpALrEVc=;
 b=u3Y49qo3TcdgdPeoTI6WKZbybfqJ5A6P/XvyWNmnWAPc8PaRJIojmKfzbxBhJo300P
 M7Elvs65YMFIxs7rOfPngh+jfLVkw0FFgdY1heVqWayxDhLD717GC+mA7h3x0cQ5Sb6i
 sYKvHZE+Unr42aNRbev3PF1Ep2ILyddSCMsshaU2teo/Y/EZ+8MT8eECfsRAVf2eHaY6
 e16Ja0DNRAkfZAYPzgzpLMToGOYgD6ZUtt5BLfp2iDFgAnX6kQ6Knqcf51cykv1rIPEI
 qc9E5UcK37f7lZJc6q6pxVfFDuyC7pL5R2uleGQ8X/2NGB0yi1jbSVWcv/pqOwSOIOdE
 fpsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741352993; x=1741957793;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2pvYNU7MA+h112B0oi56XMWS7ccwT2Ys8CQNpALrEVc=;
 b=bT/dtC7op7aaN6yTkR3pnpXw97Y5BO9lozKxXBNGBR+qLRbjborAtY3JqLPvCOzVUb
 WTxKUJs1UglmTYO5vxHQWlKgylHM7A3EF/ZdJfbl7ROb35FMu9fgHdCOgZGtxbZ1Bkqz
 2kzAVqVJRVP2VknbxjOEXQ4spclVZJcOw7uq2Ofqo1+rQ4sioheq4FGhGYbU6sv3X7Rv
 3ugTaTf3Hb6+9Wk3UtvIEOdHdRI5xPrBSMufMUP4rYpg6vPA9Q6v3WhxdXdHvhEprdbA
 R/Hcy/SzSXvdGHVPSCz3tm86gA+b/1ySO3CPD5TpRMuw+/4wMH66lQrLFzuZGOTWgVTO
 YvPQ==
X-Gm-Message-State: AOJu0YyexyPWtNZKB4nrzbSk17ZgUD2tAG7Ese8Ykvr/pjkRThoDiKWm
 Xo6N4O7sp7JrhfLhoYx+B7nu1RYCVFa2A9hsxL7Genruw7CvZxUtHCiUx0dT9gynbqoDnVGGduO
 y+2Q=
X-Gm-Gg: ASbGncuUIM1EBiVcCvXtBn+c7d++8hYF2F5n9c8oShK8U0vnljnmlPhAyH6dFl4ueKM
 +KZUdFDFXmMm8CHLCrnW0l2ObDzPsKUu4h6wF+IjGdT6Ps1lIEHxcuqJe69tF3Yq2a8jYoG0TrL
 e0U/qN5jfkRU3p1gi7vtzjuhEicgcFefzc+XW0CblIUhvKmRzXFksry+Hkr70qGmCDZkWplZQJ1
 AYwV7RCoUesg70H8pJV6EY6dnXZ/En3KNeB83ARRv8I5VrZzuazfNWECTxRy+1WivC6wfzKnUk3
 WN5ZWTBoFDNqwOjo2WTtqvoKdreHAbHml/gB3rgMZ1+9p3S6aAufNhSSaVHZX6zeczjG6WDdJ53
 oIzWAsBgvg3VKSmMRngY=
X-Google-Smtp-Source: AGHT+IEOodRhnqmmNfFgKNYBWMcKGJaEZZQhoZ8OPv1r3j/0y4ZyOmV3inuW8zv9IHq/YtwoxyoRhg==
X-Received: by 2002:a05:600c:314d:b0:43b:bfb7:e099 with SMTP id
 5b1f17b1804b1-43c602222ecmr30102375e9.29.1741352993017; 
 Fri, 07 Mar 2025 05:09:53 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd435c9c7sm79495765e9.38.2025.03.07.05.09.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 07 Mar 2025 05:09:52 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>,
 Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 0/3] user: Extract common MMAP API to 'user/mmap.h'
Date: Fri,  7 Mar 2025 14:09:48 +0100
Message-ID: <20250307130951.4816-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Since v1:
- Propagate alignment argument to BSD's mmap_find_vma()

Philippe Mathieu-Daudé (3):
  bsd-user: Always use mmap_find_vma_aligned() in target_mmap()
  bsd-user: Propagate alignment argument to mmap_find_vma()
  user: Extract common MMAP API to 'user/mmap.h'

 bsd-user/bsd-mem.h     |  2 +-
 bsd-user/qemu.h        | 12 +-----------
 include/user/mmap.h    | 32 ++++++++++++++++++++++++++++++++
 linux-user/user-mmap.h | 19 ++-----------------
 bsd-user/mmap.c        | 19 +++++++------------
 5 files changed, 43 insertions(+), 41 deletions(-)
 create mode 100644 include/user/mmap.h

-- 
2.47.1


