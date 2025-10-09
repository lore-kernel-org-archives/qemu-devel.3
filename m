Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D0F0CCD183
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 15:18:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6sNU-00012S-7F; Thu, 09 Oct 2025 11:16:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6sNR-00012C-S2
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 11:16:22 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6sNO-000127-BA
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 11:16:21 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-46faa5b0372so7408115e9.1
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 08:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760022970; x=1760627770; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0oYHRVompW79UZ14f7k3659AY04Q+/HDwOgL3pRMdx8=;
 b=eAF338CO4yJJWhyPXsMgvGVFGHQjEtN1k3WzduLQzbGoPUnIHOUiLj7uyps6lcaBNq
 atDFIGCkJIJQSHhhxbqR9ONLLqy4596x+Hx8/Gzbg+dbzi0YUFZcGeRH0YsXeWsB9Aud
 B/f5u5nj47VXiGrbD87ngXw2gZKIobRxrv++0YyVRqKY2z6u6vzpYrb0fENXKbY4DscU
 uqZ+QWo0R3LoROKOxBFLxQTb5eqE/JhlrY764n+g9fmVAqLlelqAduXITGJrRU58HKcc
 6RwAGTp7gmoywRbKXPJi391iHhpjC0g9aWwk93lmWcQbtJRQLmJh8u/LvHa6pHr4dHmy
 ktNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760022970; x=1760627770;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0oYHRVompW79UZ14f7k3659AY04Q+/HDwOgL3pRMdx8=;
 b=eYV/WBI1pDijI13oEvCBZXVamk+s3qI5k3uixV2YgHMprItoVd8QoyAcEfa+GkM9RF
 xi9SMg1D9hcuRS4aJDUkbBUl9Qlbi8X8l6J/Dwcbrsy4WxOR4CtfKQjqxWE4pue8F1mH
 9TCz1L7Ai/enThceaVT5Za8+HE/YRPimM4BWvlOvsgGGiOXGc9nqGKncxccSvVwk3iqs
 GRNS8NlyB+Du6p9CRr/w9tKzdvt+OcA2UmvWYwPAQNRSgBWX/cp37pAAakaqqzo9WMnv
 biTUZ6BF6G/0gt9xwE2MC9697ceh7W2dWY6EnWkkcE8E63q8e4ZOo7QVH6/kKLgjjS91
 V8uQ==
X-Gm-Message-State: AOJu0YytUSxxpmGfX0pfdWgQ36H3XQj4t4Ul2NtKTOKjYOZHIqpJVxGw
 9VQkZm5DvcuWfFb+rSkHPVSyr5hJlXMsDvipC2bUCR1XnKmfRZLo1p9G1ercamnEBwhQLqnbsVD
 VEN2nTEz2SQ==
X-Gm-Gg: ASbGncuyci7QcLxwFD1xaiB1fmbRRpEY42eY8LPUqzhMo2ppdR3uy4N0ZGkCONIES7F
 4coCNM3/PvoQt07+kIQPUjVSTLouhntDBHyfEx/i4vrkBS1uzQeP5uhxm7dembLde4mdxnescQq
 WzsUWsTM1D69L1q3fnumLlf8xNJzOHIFXCeDn4U8vv+rLU8TpTQaZ4k1Zp9EjaazYpQbkrnBpiH
 bixDrm37G5xPjfqg7JD0pWIPHZ9ebcQ5Rf6ddKhJAdKsel3zGxv2SafYPpkW9zukNBR+n/uiQz6
 7sVbAiIu2SH/bx7wHdL2lOatzj0P+6SbGNPOrvFNiUI0tiEUxA9awtFoPHQVu9yP5jzzmB5J2Sr
 NTluG0FknJ6ouMQkg12lSZLub7U46L/Q8+3kpRkNQ8ilwlsj0Y7O8TjHQ0zATDTIRAvRlVZwSG6
 aLOS7wkcs93h0dQuJprROdg6lu
X-Google-Smtp-Source: AGHT+IGuY8v/C9K6V3mIH/xAyxP4dhcEp7aXH8FEM0UhOOVyX4TFGacOcF7jdVKLy2gDHCC1/qRUuA==
X-Received: by 2002:a05:6000:18a3:b0:3e7:471c:1de3 with SMTP id
 ffacd0b85a97d-42666aca1dcmr4979707f8f.14.1760022969697; 
 Thu, 09 Oct 2025 08:16:09 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8f01a0sm34970154f8f.48.2025.10.09.08.16.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 08:16:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/8] target/rx: Remove target_ulong and MO_TE uses
Date: Thu,  9 Oct 2025 17:15:59 +0200
Message-ID: <20251009151607.26278-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

The RX target is 32-bit / little endian only.
Remove an invalid target_ulong use, then replace MO_TE -> MO_LE.

Philippe Mathieu-Daudé (8):
  target/rx: Replace target_ulong -> vaddr for translator API uses
  target/rx: Use MemOp type in gen_ld[u]() and gen_st()
  target/rx: Propagate DisasContext to generated helpers
  target/rx: Propagate DisasContext to push() / pop()
  target/rx: Propagate DisasContext to gen_ld[u]() and gen_st()
  target/rx: Factor mo_endian() helper out
  target/rx: Replace MO_TE -> MO_LE
  target/rx: Expand TCG register definitions for 32-bit target

 target/rx/translate.c | 427 +++++++++++++++++++++---------------------
 1 file changed, 216 insertions(+), 211 deletions(-)

-- 
2.51.0


