Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3C38C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 20:16:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk8Wv-0001mH-AP; Tue, 12 Mar 2024 16:15:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rk8Wp-0001lo-IW
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 16:15:15 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rk8Wl-0001JH-OD
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 16:15:12 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-33e9623c3a8so205916f8f.0
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 13:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710274503; x=1710879303; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mHESGhfLSlYehDJfOaQNs3o0t0nyr1FSmJX5b5N9tss=;
 b=e1Yc6XCqhUc1m32uJpkjIOer3Wa3w1VjJRrY9fV50NhhNGNyxBnBwhkX/KJQM1aGOz
 XzkEFYgj1tjC1gbZ7vukQmQ46uEhyJn3JV9xBz1IpZacAxfa2hxkIIszrbHl6vF6FRPG
 VsBHge1f1XHLKDsNCdLeQ6EsyAeLcsI4DlIM6xI9JSu+IvsaU6viV8MpTD0668TmYZ06
 JpdMDIQfe+b1cdOS5Izvxi050vmcHc/pa98ojTNu2YeeaEMVv701PgvrcPxrr7tFXPtE
 7Rkv/e36x+gzElk4iorHK/sBQtb4SPq/dzXWc4FBodKibu8ZmES/jUV2t30rL9JKzNzA
 6uyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710274503; x=1710879303;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mHESGhfLSlYehDJfOaQNs3o0t0nyr1FSmJX5b5N9tss=;
 b=jsT+2S2dH2H9NrA6FyD+z5cASeUu36LoxpOtF9Wih76ah0CPiVUkjR9ftemSvSJT9e
 7e5xAmBIw5hlMEVPQTwfuqociq5ArZk8+Nyt1S4D9asDMYezY2v07C7la6iHuNYDpwh6
 lyR4rY/QINcmU609WdCZksB2PGJyfoIpk6TUF53MgzuSi/PNU/XAL8IbMZHJcpNPgcjL
 c9C1RBTJq17lCZKXj8cR+JAEiLvnFgwpFJOsi9vablXLfxQzceWtd4NtuUGRhnmsBy7v
 YYS5puEWqzLUvO3CFu7mlM2M/lTwNWY/Iz8X6Ww+E1uSL1ftoToRnhTEIjjcf4u9N+8x
 1ksA==
X-Gm-Message-State: AOJu0YyZx+l4Lo3NEwTI9WO9R85iBnRVpIEHyW9blK/wuLMar6vhLOTY
 bgiTk+AN5XrJkGr0Pzvj6POvHugv3yk2FnQ5tDsFm5mT3ePKSr80xORTafp6XmvHB5N3upfpOBL
 Nw0Q=
X-Google-Smtp-Source: AGHT+IFFNhr6FsPwRbnZ6h1VGysDGqZQVUwW5jOqwmTz4qurqqcQPorVmx7i/FlrBR1aqhDZnQDyqg==
X-Received: by 2002:a5d:65c4:0:b0:33d:ca56:a616 with SMTP id
 e4-20020a5d65c4000000b0033dca56a616mr335770wrw.36.1710274502887; 
 Tue, 12 Mar 2024 13:15:02 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.206.139])
 by smtp.gmail.com with ESMTPSA id
 v9-20020a5d59c9000000b0033e22a7b3f8sm9744832wry.75.2024.03.12.13.15.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Mar 2024 13:15:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.0 v2 0/3] system/physmem: Fix migration dirty bitmap
 coherency with TCG memory access
Date: Tue, 12 Mar 2024 21:14:55 +0100
Message-ID: <20240312201458.79532-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Respin of Nicholas patch, without introducing
tcg_cpu_physical_memory_dirty_bits_cleared(),
and split in more digestible parts.

Nicholas Piggin (2):
  physmem: Factor cpu_physical_memory_dirty_bits_cleared() out
  physmem: Fix migration dirty bitmap coherency with TCG memory access

Philippe Mathieu-Daudé (1):
  physmem: Expose tlb_reset_dirty_range_all()

 include/exec/exec-all.h |  1 +
 include/exec/ram_addr.h | 12 ++++++++++++
 system/physmem.c        | 10 ++++------
 3 files changed, 17 insertions(+), 6 deletions(-)

-- 
2.41.0


