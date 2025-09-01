Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACD54CA1005
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 13:27:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut4YP-00024i-C9; Mon, 01 Sep 2025 09:26:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ut4YN-000248-JG
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 09:26:35 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ut4YL-0001Lr-KR
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 09:26:35 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3d4dcf3863dso889936f8f.1
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 06:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756733189; x=1757337989; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vMiNyuN8vCGx4gQ6SgirNIsSrqkqFDJsdJQQNQ3ScD8=;
 b=a1dXWPbvdOoA6s8N3b8aeUynfoy1KQFrQskmgfH+C0I7vh87EMcB22qT8JoKZlMtDQ
 hAIfbPCn1R9u30/jIz0pqp3xTWUSlWkJY6zHA9rE5DCO3udzTBgVXG3xAI6XefG434gl
 nr1QvpIBgsb3V2RXAi7n6qBL/eVK9EwK86+6oepobccpiklJYtFIjo3TKy1lTWU9zUVB
 Xqk6UAH/nyatjRQU4txuXH/PwiLRyNnLjFWIrdAsBUOdc6BGkXPNP6n7p0D/YvFxIVEH
 zGpSAutQOxnezqffi7YrLcY8jFQuPW2YIf3Ayd1/XjuH0yAPC0DHyH6kJ1aURIr37N9i
 18uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756733189; x=1757337989;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vMiNyuN8vCGx4gQ6SgirNIsSrqkqFDJsdJQQNQ3ScD8=;
 b=KIb/l52xgtX712aRp2Q9Kwxd4HKdppHEmq47QLLtFZ/ug5mANu+QQxAAsqgorQvtr1
 bMUvhBNXQQq7/eFmBBdAqaXSe4JK+DBXIO0euJBsacGZTDn2GlgJ0UyOJ7AUxhtrqulC
 W+MoJ+4DGIUB8zGzs90+9cEUCPZOV1J6c7EbBkzVNbNuHBvARRo99FMOCdm35NeeFVZL
 AidPEX+BY9z1aJcfrYFamQw5nZocIE4B06MtbY6KdW6y4+qp9K24i6Bl00b1if43jqs3
 5Nl5sOAYbntSn0Bq37m+hyLUSYrRrp1ni3W/fUy5L16wDZxPxeLF/xFvjQI6s45bdmI0
 YKLg==
X-Gm-Message-State: AOJu0YyCqre8EbMPBAqQBWFLhJ6RLhN5a3AsBZ8Q/XeQvnT4ap1hFwtl
 Ah3t58kVY2kMX4j4kkwi012sjP7q2je/awus6HK2z9ZnnLoRCB4SJKZmM9kEFAKVsrjuyUj/tHG
 GmZ2z
X-Gm-Gg: ASbGncvSi+Q8Xoncb0yAYGI96U8162tYxA5S/MNbG4wN+GhZfDSDw0z8TGAXBkbPUB2
 4kEUMrArMPPzoUkZwzbKE0gQfGVuxnbmYLiTaR0q0gaZ9x7+jz2OM0bHiHtFaGFmhdEuvl36kTC
 vJujV5yJlVOhIFB5hrFbihhik4pM1ALSJOudY1ZvtueQd9Lnq5pCyb05y9mgG4i3nyNNiq7oSDj
 uvArKc7T4/eKSGXzpqA4/KX03MBeOX8gbJwvgpCpnQVaovtuSTybYBHZSJkqhSWGPRgwUAS6pCu
 Un3p6HL8whWgkEDlqr6XFs+UyNEQfAUDa8D1LLG3G2yEIEtcyrMQ8hzXCoUF+6j+crpdpFr7g6/
 KjILoh4/stNvK4bm4qoGdOa7QB4g7LwXdknqkQAq07IqVPSrWlBRyIPf5SjD+rFmgAB+CQRwJ
X-Google-Smtp-Source: AGHT+IGvMZjAB7w3flVb9fpv8Ycj4IjlLC96zH/J1Wz7eo4dvSyKyjK/lO7Gxvgzr6WwfpI7VugvTQ==
X-Received: by 2002:a05:6000:218a:b0:3d2:aadc:296 with SMTP id
 ffacd0b85a97d-3d2aadc060bmr3196475f8f.16.1756733188895; 
 Mon, 01 Sep 2025 06:26:28 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3d0a1f807f9sm14484129f8f.38.2025.09.01.06.26.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 01 Sep 2025 06:26:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>, kvm@vger.kernel.org,
 Glenn Miles <milesg@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/3] system: Forbid alloca()
Date: Mon,  1 Sep 2025 15:26:23 +0200
Message-ID: <20250901132626.28639-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

Eradicate alloca() uses on system code, then enable
-Walloca to prevent new ones to creep back in.

Since v1:
- Convert KVM/PPC (Peter)
- Update doc (Alex)

Philippe Mathieu-Daudé (3):
  target/ppc/kvm: Avoid using alloca()
  buildsys: Prohibit alloca() use on system code
  docs/devel/style: Mention alloca() family API is forbidden

 docs/devel/style.rst | 4 ++--
 meson.build          | 4 ++++
 target/ppc/kvm.c     | 3 +--
 3 files changed, 7 insertions(+), 4 deletions(-)

-- 
2.51.0


