Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4939BEE01E9
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 21:24:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so8L7-0002S9-KK; Tue, 10 Sep 2024 17:23:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1so8L5-0002Ke-Na
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 17:23:55 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1so8L4-0001vU-7h
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 17:23:55 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-718e482930bso2284111b3a.2
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 14:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726003433; x=1726608233; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=T80UPj+qhu7ZvuwY7K7ZmyNGsP2DUjUnk8vZcnVrlpM=;
 b=leJvHV/k9LgajSoW7wWeYIT+lwxq6GII836i8aGIxjVQws7TF7gYVSfzmeL3uacDR1
 xxm9r3xmrDYLzB3xLCeOveRvp3Em2FJg6bZfCnw8wbBcfN0SIOa06T4IBWzDCBq3Fxvd
 X5jENwkV7XbK83l4j+Bo+mDajO2eD0SbFJ9HWXbtk2LIPityF4qN6NvUV10agCwSpBg4
 YqCxJAS0k7irW3e1dtxZH0MSGPWcqcu0klNzPDUvZ+x+9CPVr8XkcfbdLHo9+aCXzMb5
 ZrHIQWHk5Z3O/pJtYJcBK5UtYTvARvWBVQuIlHBBsfuwPk2sJZIzAKV0GgnqtGEvz/rX
 Vl8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726003433; x=1726608233;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T80UPj+qhu7ZvuwY7K7ZmyNGsP2DUjUnk8vZcnVrlpM=;
 b=I8zP1jycRp8aIN8aIvtYC+u37wAMZtmKqPQq/yZosfBhHGVYrMKgaS6b4/GEey3wie
 w0zKJ7nXiTyRftdnoMq35iP5656+gtG6kRXm8guWBQqY7NRTDmQ+lZ9Qs/3AHesh+xSd
 zIqHzqM+SFaQnkEznVNxh6uSZw2657JLhR1ghwK/nE4zY0DAggzle4TK1doEXUDPomSQ
 FPxADCEg+kLP8IB0i0qdJHkx98vJOipOUoMVUxgtTdjaNIDw3JE4zMhu+PKM+f6/124p
 DwCGeB56ZwEsY3ae+6SlMoxM4Rxa5P3sQ+ItFWRN7yvbf41JpgN+YaUEz32S1JE9vLbI
 Z74A==
X-Gm-Message-State: AOJu0YzWWZ4VdmTyD1vkspzW59khLCfAzD5PTVgDVQVOOdrq2D6U//Tf
 WjLBVHY785813RchyHwLtUftqYz8T14fvd7egh6Sbe7FlSKUSJYlQNXVJdw5pnJz3z06A0cWZAg
 i
X-Google-Smtp-Source: AGHT+IFZT5bJEvpeK66reUQfLUuR7qGQ7HF8dhXAZScpTvrOGiIo59qe48vKjo9Z9zmyNYG0VMctYg==
X-Received: by 2002:a05:6a21:392:b0:1cf:5b31:313a with SMTP id
 adf61e73a8af0-1cf5e0307abmr2884246637.1.1726003432532; 
 Tue, 10 Sep 2024 14:23:52 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7d825ba616bsm6089661a12.93.2024.09.10.14.23.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 14:23:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH 0/2] tcg: Fix branch/label link during plugin expansion
Date: Tue, 10 Sep 2024 14:23:49 -0700
Message-ID: <20240910212351.977753-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

With tcg_last_op(), we always get the last op of the stream.
With TCGContext.emit_before_op, the most recently emitted op
is no longer the last op.

Instead, pass the op being emitted back from the allocator so
that we can link it to the label without needing to look it up.


r~


Richard Henderson (2):
  tcg: Return TCGOp from tcg_gen_op[1-6]
  tcg: Propagate new TCGOp to add_as_label_use

 tcg/tcg-internal.h | 12 +++----
 tcg/tcg-op.c       | 86 +++++++++++++++++++++++++---------------------
 2 files changed, 53 insertions(+), 45 deletions(-)

-- 
2.43.0


