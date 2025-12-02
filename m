Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79D2DD12663
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 18:47:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQVOt-00033s-UG; Tue, 02 Dec 2025 13:46:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vQVOs-00033h-Ob
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 13:46:58 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vQVOr-0002Fh-BH
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 13:46:58 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-477b1cc8fb4so36153765e9.1
 for <qemu-devel@nongnu.org>; Tue, 02 Dec 2025 10:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764701215; x=1765306015; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HKk5GtRZ9dC0idT+rWCzPItLFgkjImKuUnByVLupPVs=;
 b=Dh6N1t6eqRbN8RMFXurfDpZBg6VvpTVeK6IC5wqwmrg7AT4ZfeI5Nb5jq2o4GXXgR8
 q3zrYBqWzi5ALyLcIGpdUdQZgC0OU5EbhWgPGTEw5blENQ6Qrw0a6zg3H2eq2NMozqhh
 GmWa3N9X+qnp0M5N2ZgXiQ2WXXfiGzuoilqpeBFE4N1wslDJogVAW8BwsGqBw2BPYnFK
 76DGA0hKkyMw1rluCk172JuIZUGFhe9XJrwTgz/16mrKVI8V0ee1i4MNj9phCZgHWEZW
 Doiazu7qh0/HdM1W8zUiHfhW7TjJLNtwDEu8Vy6s3AY/bAI+wI58QvIfNxPydnu6Fj2v
 0hjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764701215; x=1765306015;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HKk5GtRZ9dC0idT+rWCzPItLFgkjImKuUnByVLupPVs=;
 b=s/+/xdpyCGp6oAEKm+OAESPn2hzx4bMHN0ewuoA49ADwua1PYP436wFWZsttuo9Pw2
 fHqNoSBTdPGJyfwF2X7+CxYKbhrHKRrBe94w/o7KX0JgOWvUQx4eWQ/qcmM7gLBpmrCq
 R8IGeuV7aZa9fsD7g1k3bXYuQJkOiiKttUvofRbkecAt14kyiAhWWQwyZ7AM+oQ4z5fi
 eReXAWwVIfLbgco3HN3+n7ejYoaX+/BxjsQFHCxmPfDUObATp8MCw33aZHs8ZkS8mw6D
 xTMjpf2XwAPQJ5REudoxWb5Kz/LEsF70HYw/LTScOVTeBUVeCqoJ2dpyD8+KntO45Arr
 GtYg==
X-Gm-Message-State: AOJu0Yy9EhWeVLPJjM6Sp6stoCZePqjHQMTAMreLitI7vRD9pzHjoeV2
 rPl+rdUYIbyeHlgN/9Gxke685lounl+Qowd9B01zunHt2v6EM5mvO/L+tt+wA7c+lFEVCWum3Fl
 SitfLzcQ=
X-Gm-Gg: ASbGncv9mJ8pno71W7VwUZHaOGzUPcDCyREMi5g7/YOIODoIN+0Oog3vhXTUV8vqS0T
 kiH6kQinlGTlYu+ibfr56YmnETOVIKItpQH9WKnJcrtw9uxhC0rP4xv86BDYV2Sme37oeWHAxcV
 /PUjeuujg6AWnR2tTsyiZnVtLv997OWHSiL4Ukmg9aQRUg7de/w/u97LLQEHIwwGheOKVIR3tiM
 nWyVPzN2qh88FGFp0J4SosgD60pADNGS5SLJ2N7KV0sIQ6WPlJIMpC8bVOTtcDxQ0368qjaC6Uc
 Dy0qL1Xk/Tzs1UYpNd7xsvmq5QUBs8PXjjLY18Jhpfh/57bLP18mTJ41LiQVkZQm1WHQBISInfB
 xtDxrEKF/t0aoTv1xde6M+cHK16EzMRC9reHb32a41mkN0r1zqmPU43W+TPvTNxMioo2jaPAK+Y
 wVKcBzU4jKODNn5BjKjCQqarTDf1IzoFFmfiE0fvgZXybSGKe2XNWsod4Sp7A8
X-Google-Smtp-Source: AGHT+IH8jDodP90OavswYYsNmTtNALPfAH8n/XftXLv6g60rF1vMicoMcVDMJXBX7+/yjG77C9aXYg==
X-Received: by 2002:a05:600c:4fce:b0:477:73e9:dc17 with SMTP id
 5b1f17b1804b1-47904b2bff2mr289012275e9.35.1764701215172; 
 Tue, 02 Dec 2025 10:46:55 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4792a65ff2asm2624745e9.8.2025.12.02.10.46.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Dec 2025 10:46:54 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.2 0/2] tcg: Fix TCI build on macOS
Date: Tue,  2 Dec 2025 19:46:51 +0100
Message-ID: <20251202184653.33998-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
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

We don't test TCG+TCI on macOS host and it is broken.
Luckyly the fix is easy.

Philippe Mathieu-Daudé (2):
  tcg/tci: Disable -Wundef FFI_GO_CLOSURES warning
  tcg/tci: Disable Int128 support

 meson.build               | 2 +-
 include/tcg/helper-info.h | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

-- 
2.51.0


