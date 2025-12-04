Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F1F1D29FBE
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 19:49:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRFKD-0006yY-Nq; Thu, 04 Dec 2025 14:49:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vRFKB-0006xF-RZ
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 14:49:11 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vRFKA-0007M3-Aa
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 14:49:11 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-42e2d52c24dso764203f8f.1
 for <qemu-devel@nongnu.org>; Thu, 04 Dec 2025 11:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764877749; x=1765482549; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GgY4wKPjvv9aRCmLjqgJ412b/n2ao+a4W2M6nwlctWM=;
 b=sn6gNQV27Xz3ZljVrHulHM/OHur7y7uxmqwryxsNeO9Z0JwIP4W5mStXc/gjifa4z5
 smo2k4vRHGIeWE2uIuAtxZjpbnoEnWKQQCFAnPHvYqoHMkPF/RqBLmTDfFqzI2TwtpPZ
 xGN7jLLK65ZHBa9ZGgldQ7+RwWYE6ev5wNYwaf7DcbnOoPtBf4iU2HwBd365qx2mfgHR
 cZUlGuvDPyOz5ceSvu5nqzHnxvr0bxqZmxYFC51DGsYXUxx62Gc2vzWXF5cZK3h58PEU
 9IeAr5nHyfep+3K7hdoZhGggEOBtc+69Dzi2DoqS2np17G5hs/yCACyeuBBq8+sRLRnq
 aTsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764877749; x=1765482549;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GgY4wKPjvv9aRCmLjqgJ412b/n2ao+a4W2M6nwlctWM=;
 b=LqsKCvtPBzb8XZ8ucB6/6+X+SBk9zVlk/2Vu5b7163us0jWG8TEdajCa0a5hej2yrx
 ma21A360AjxA0J0UU305MqDvrW31MDxYLqEDbwKLMgJZDkrY1yKBhql1xtgcm9+a7/cA
 YclXM8QY6VIOyP4hTjs6lt5zAJXwyXJltho20Ke+3VQNS543cF+gt7ky5FwmK/J5kL5i
 ZF98o9qC7UEDY1mssJK+e8hpMsmnP630xDT3INzUjl+OIYXGvRoXHHRUgOkwR+2e3Nzc
 FkdCBw3MVSoINGJpk0LeF+8YVCw4xx70f5Bg2XE8ET3JcdQd7jrX5AuvAaO/P8R6x123
 MkpQ==
X-Gm-Message-State: AOJu0Yx9Evb14+Mawlcgcg+p7+FsJ3+Ye0ALW0esbpIQ3dpQ7hX8bByI
 vRu+pAh4qz2HmBAFgknOeEekKVowUZVsDwVo353nBvkohxgKCAHyHQDq8191o9lk05s=
X-Gm-Gg: ASbGncsFEgKjmvmY20MTiixqXGKPwzstd0pwrAynMU1LfgRcG/Yfmf4FzoR/ef9Yv/l
 QqdIyNsLPggWYlkjEhg9k/L1yv49ocv/ZGk6VqNz/UnZzMS2TeOqJBj9YLZ5hCNAk42gxa+cPbo
 NLrmj4VQt0HnHWfZnBSdVUcEa/ro6g6A0zKx8rF+77s4moOXHDAqxU1w0nLMdKjgEfpEUe9jYch
 XEoXtBVmgB2mRe2LiwKiIU07v+VLWtZ6nEowG9B2mQ1DXl+yuEVPqLPJ219GLDeWBWJsmc0tNlc
 ZgRvtVRZxdeT1koh8gWe9uZ7XplO47VQf+TirHKfLnJSxAZJyAmJ9OCin6n5lWHoXHwLlg14Iza
 WMuYCOVcKj/hdPJSzxHD7wRjxKvHxDumc9qZwYeduxopmDQOw2BRwYVB3NYV4izj5nqvpDxyXG0
 /isEHTCL8rRH0=
X-Google-Smtp-Source: AGHT+IH3M/T345AtJAQF4UORHeDwwMUC6jhkpKcMX5M3M8VuZwLcQwyqpxZY9/hoZZ6LICNSN7UD9w==
X-Received: by 2002:a05:6000:2306:b0:42b:3963:d08e with SMTP id
 ffacd0b85a97d-42f731967f8mr7645113f8f.22.1764877748792; 
 Thu, 04 Dec 2025 11:49:08 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7d222478sm4796016f8f.20.2025.12.04.11.49.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 11:49:06 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0A8ED5F874;
 Thu, 04 Dec 2025 19:49:03 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 04/11] tests/lcitool: add bzip2 to the minimal dependency
 list
Date: Thu,  4 Dec 2025 19:48:55 +0000
Message-ID: <20251204194902.1340008-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251204194902.1340008-1-alex.bennee@linaro.org>
References: <20251204194902.1340008-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
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

You cannot build any softmmu targets without it by default unless you
build with --disable-install-blobs.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/lcitool/projects/qemu-minimal.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/lcitool/projects/qemu-minimal.yml b/tests/lcitool/projects/qemu-minimal.yml
index 6bc232a1c3e..2a1ac51d402 100644
--- a/tests/lcitool/projects/qemu-minimal.yml
+++ b/tests/lcitool/projects/qemu-minimal.yml
@@ -4,6 +4,7 @@ packages:
  - bash
  - bc
  - bison
+ - bzip2
  - ccache
  - findutils
  - flex
-- 
2.47.3


