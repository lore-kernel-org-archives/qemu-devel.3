Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF26CCCA470
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 07:06:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6kib-0001Ut-G6; Thu, 09 Oct 2025 03:05:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6kiZ-0001SD-IK
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 03:05:39 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6kiV-00079u-DV
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 03:05:39 -0400
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-46e4ad36541so6520845e9.0
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 00:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759993528; x=1760598328; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vWVfgnQDdlivF5r+F/17HcoTWT231mXlExjzQEQ/pRM=;
 b=MP9s6HZwrNU+QrpwtFqEI6GVy4HEe2rIN7LNjrBxL8GhmLuJGhIMafEqKyUIoyDJJH
 WboZpdN8xJPwfp1/tn5BCnM+E7zQEs/JHW5ESHLYq0fNfTQhOAuIx9tGcXMgoG0rma2Q
 R+kE1ILrdfi/FSysN+gV1XEt74d0wPzgTZ1yCIK2pUtTZFOfRYqEAHh24b3PRo6A50sH
 +O3ElNvzpUvqROGwG3fdkjNVoVj9+0bqNg7zwLa74RPWhULeOheskx5M3cOcyWt8OUOv
 Jl1buiIft3/NKi8678Ke2b5CNA8H64Db9Dhrl9+jmo3d7KojzAGEx6WPedgwtcEUnbwA
 c6Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759993528; x=1760598328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vWVfgnQDdlivF5r+F/17HcoTWT231mXlExjzQEQ/pRM=;
 b=oUAQf9/s+eA389ITVTOJGaJaEgCU4cKzfvSUezS5xlryVdTxffzdLXHBmJefbEsmBh
 ///qHxr05WrTd3h8NU/SOJsO9zJz/l8EIt3JFdXapqaab9PL3zDvu3SCNofGkQRAXkHq
 3oZjZB/a8YBybrXw1RXGK6emfPoDtUqctMjl84PMPIHveZGNakiAc5NNZj7PQlbQ9Wu8
 atCvDtsXWz/E4n1nTCn5y2V+gZxDIwgR6DWL3ILWVodZ+5ojaTKKKMpqTkqgU7kvoI2S
 ogGW1ZDxWIPbHkrpA/NcrLorN6CFjXHf0c3awjiZ7sogE4zHrd9vLMD7KDgHy3Crwifa
 HY9Q==
X-Gm-Message-State: AOJu0YxQX38PexSYPASDeEhipMRyBTpJgEk+pRwIVSZQPvQk+WyoE/Ja
 rweHoQ3Mc19rZt5QtkSj5fQb2hmpZZFzXJUFrQS0AutfZI0WKJHhOOQ+ndMTbLdbQWAoayKD83l
 /8pvRcmh5hIEM
X-Gm-Gg: ASbGncuJhGL+JOO+qsE8O00V6JZfxAKffk8hm/u8rLxlruxF+ZNBUxLFJc6cWkIYGun
 b6Ckb2DlrJYkNwrI4Gdjw3pObzpGYGaF9I+ZEQbhrtJD7A9HES5ezr6dR0+76y08AUbcnEGuG1h
 kqz6wj3u9VtWa+hgpbsm87N2FkUSwiW+/3IgoLBKsZVj8MNis7Es9qOgU+xt0zaAhTdd0hQG9vv
 gCCf9+3tGPOIYwn205CXx1J522rPqCY5Ux4aB300AhJAYzfaahep6A+QP30I9PR3ClcRtsg+2pQ
 KYmq92jbLiZUOVdgNNzCccFrCzBcPL1cA6LY3f2hgumwI5MHkr7LKXPmj5+7vj27Wd4yCj6MyDt
 bIZgL6E2PaRKysIqF8NrzOHwtsXXKKk5wjRUrdZmG9QGgSJCZebTZcwUyF/vAIfm7pODJceRPGu
 4rqe9tInMAfK6ITMhdM7XxMGd1
X-Google-Smtp-Source: AGHT+IGMrHHDi4iheHoLRn+3cmvR7rsbUzpijbYUynTTgca9xeGgH0DNRQwHBICl+1ZmINr6gpb+5w==
X-Received: by 2002:a05:6000:2087:b0:3cd:ef83:a9a1 with SMTP id
 ffacd0b85a97d-42666ac716dmr3992535f8f.20.1759993528401; 
 Thu, 09 Oct 2025 00:05:28 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46faf111a15sm31964245e9.7.2025.10.09.00.05.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 00:05:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 3/3] mailmap: Unify Richard Henderson addresses
Date: Thu,  9 Oct 2025 09:05:12 +0200
Message-ID: <20251009070512.8736-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009070512.8736-1-philmd@linaro.org>
References: <20251009070512.8736-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x341.google.com
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

Richard toggled his email address in commit 336f744e148
("MAINTAINERS: Replace my twiddle.net address").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Cc: Richard Henderson <richard.henderson@linaro.org>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index a510b5d681f..43bfa46bcf5 100644
--- a/.mailmap
+++ b/.mailmap
@@ -105,6 +105,7 @@ Paul Burton <paulburton@kernel.org> <pburton@wavecomp.com>
 Philippe Mathieu-Daudé <philmd@linaro.org> <f4bug@amsat.org>
 Philippe Mathieu-Daudé <philmd@linaro.org> <philmd@redhat.com>
 Philippe Mathieu-Daudé <philmd@linaro.org> <philmd@fungible.com>
+Richard Henderson <richard.henderson@linaro.org> <rth@twiddle.net>
 Roman Bolshakov <rbolshakov@ddn.com> <r.bolshakov@yadro.com>
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com> <sriram.yagnaraman@est.tech>
 Stefan Brankovic <stefan.brankovic@syrmia.com> <stefan.brankovic@rt-rk.com.com>
-- 
2.51.0


