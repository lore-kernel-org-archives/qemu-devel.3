Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0A09C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 12:38:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbfvE-0002ur-TN; Wed, 07 Aug 2024 08:37:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbfvC-0002u6-Ey
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 08:37:42 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbfv9-0004iM-Vp
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 08:37:42 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4281faefea9so11623015e9.2
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 05:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723034257; x=1723639057; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jKDEOr2MbKzRIueGUKGCdZsTp3Sbw54kpPxGiqJKozo=;
 b=MByFVcc3bzMq18fLV0xxBGPkUjwrwvBChe3Ir+aYjqdeoB+iw3cN/8qfS6GHX7tsGN
 x2eNl/IyhxgLlGZCebtTPoOvuZOyit9Aqw1SJ8Bcw0DRUhkd4HnUuPbuMdJCowbgi+82
 qbEfA8hcepg6EK46H14s06SsXeXirLNGFYhCLUwxFjf/qXevK/jBr9+AelCgESmb90Qh
 Q120kH9OVSKSN7U2VvfTZ4kEKAI89361vgH07gR9ZyQChRjCXOY6D3g4YmnQtOgWzMYf
 swuBrWGlwsI9e5x46tiIYBsQKTnHSMSrfTGibF2DNyjbygWAYeGE45kPUVnxL8HXVMYR
 IzTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723034257; x=1723639057;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jKDEOr2MbKzRIueGUKGCdZsTp3Sbw54kpPxGiqJKozo=;
 b=td+sKoOfjv/aiEbyqJqFOgr0SHix3kHbWmkPh63DhvxkjhNf+okMx+DB8Y2mQafcw9
 yVRY3sJuhvN3VxHE7/iRM08wQh6MQsYQKeKjS5uDGmRo8VJDDHJH3PwJWaPcMXoEf+nN
 limdtLY8uVqTFeayRRis+bnKBGxFNg7TI8RpcgpJ4Hz4mtoZ3nZqCElF3auWSMkTb/4Z
 eSH7ttmXhevGuIX2DAH1vYRXdbdYVcsu2Uu/uNp0QQspqL3TGFwlZz7MQBXaHAEPpllp
 pEKYiLnfs5tGTiohL6EFWGBy5hrG5JVPeHWlobaKXHdzx5GajOiMgJMQaltCLK/Iyj3A
 /kQQ==
X-Gm-Message-State: AOJu0YxL/rl8WanspoE+O4gcYFBVX31WDI0rDSbmUUw4bv5s8s4YDSGO
 jfQMampzqI+64a5ghL0mS9Gl/8fF7KoFYNf/7BpkqfvJe0AjjIfxP9m1mRWMsDAUWvv+dALToia
 D
X-Google-Smtp-Source: AGHT+IEfcJvPYp6IrfJhebId2O6zPn1cIaepzA7auW8ifu40xTJb4qGKrrvtqnScBJ93H3NeUptSdQ==
X-Received: by 2002:adf:a2de:0:b0:368:4b3a:2021 with SMTP id
 ffacd0b85a97d-36bbc0c6c50mr13511230f8f.6.1723034257490; 
 Wed, 07 Aug 2024 05:37:37 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.120])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbcf0c348sm15860514f8f.24.2024.08.07.05.37.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Aug 2024 05:37:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Zach van Rijn <me@zv.io>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/4] linux-user: Trace sendto/recvfrom
Date: Wed,  7 Aug 2024 14:37:30 +0200
Message-ID: <20240807123734.52501-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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
- Add/use print_buf_len (rth)

Strace format added while debugging
https://gitlab.com/qemu-project/qemu/-/issues/2485

Philippe Mathieu-Daudé (4):
  linux-user: Display sockaddr buffer as pointer
  linux-user: Factor print_buf_len() out
  linux-user: Add strace for sendto()
  linux-user: Add strace for recvfrom()

 linux-user/strace.c    | 51 +++++++++++++++++++++++++++++++++++++-----
 linux-user/strace.list |  4 ++--
 2 files changed, 47 insertions(+), 8 deletions(-)

-- 
2.45.2


