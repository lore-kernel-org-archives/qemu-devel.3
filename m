Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF3DAC83F17
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 14:47:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZsYZ-0006h2-Fb; Thu, 10 Jul 2025 10:47:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZsX0-0005lH-37
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 10:45:58 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZsWx-00085n-4t
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 10:45:49 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3a51481a598so652071f8f.3
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 07:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752158745; x=1752763545; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ctTT9Gcd/K8ncPr6pwIo+D9Zug1wgzZc+9rfVlCsxrQ=;
 b=jZ/2AwOvs3/DHOw9fC6VjGXSc2fLhEMtAKS40cMHolPfZpEuGXwQURtv6MTBT6C7Uz
 Re4/HvbnF/LeLd212WNoFe7Dpv6jTrWSdqhWlxXkAxAwKwwypjFl+b/UWzCs4WIEc/qH
 eaYjlIVN/MXqAZ4sNtCOAoh2MfL7gKac2IDx8ImwsX5EvuG31tIP0iHNuO8uOF/AEg2O
 mF7KLyk1+DO5UElA2/WTb2mMlhsnJXOBJzVWIxkd5q1C2XCAO+MyIPc4Tsu//R3hgfj3
 TYSh1UX4cxDfYXknEyGdVT1qx5/Hq0QPqe6FXV0Qo4f6jT1rUafo2V//iujiw3iMjWCz
 c0Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752158745; x=1752763545;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ctTT9Gcd/K8ncPr6pwIo+D9Zug1wgzZc+9rfVlCsxrQ=;
 b=h7252uCVPp3rYjcEUpld6s885VnW8yM61XX/ainUH1oEKZOlBrqfTVRar4cY1niln/
 Isv+BI/Wdbf9ERwvB95VK+uwZ1dffVlYbOgvtMGrJIBAXCdUJz+1drzMzxyriHRPLHl9
 2oxXO2l2O/qAcvSwGoWMVwu9esRKJuFSoQ7jJ6PSG+dcmBCjVs6adPR9R0p/8H78Olr/
 zULR+CJHgenT/PGy876BzsG0LfxxNIU21pYCJVVkW/xD49q3NYGrJUEVFeoIHewUpeid
 2N/xLZIRK2AcMV+ox8oYk8ebF3fyj6P+6upyfdUyXDzUeHzbnKrZKZIvKaYHesUIYV4e
 mzpQ==
X-Gm-Message-State: AOJu0YwKsRfkGSZp5zqToSSQZHy4QC8emmu0dbbm+IHSxF+ZO1vRV8c5
 Mx2sx+5aZHY/pjgUk0n4bFm9YfgV6IfjoT2zJ2guJpNfV1+J8vbqwgGUKQhf4a4pxQUk/NoerZm
 SWhv4
X-Gm-Gg: ASbGncvAA2JH+BmgBxcskG76PTzLTq8gkod5wFRQgutmejyop0Bqi5XmOO1BacB9nhD
 K9iMawhsbWFDc8I7Ulh5fTbJX7hQV/YCAZTxxkrC/lziQLxwxe93mxnGjb5NJ2HrlS5lZYn3o9B
 5614z/tFjUvj/iGRxR+ibEIpUjYv/OKOq9Yso5+3anoAp/TtfkZTPHZcg5e2iyTXOxgOZzz6BbT
 0/7Kg+4Be+YSa1YvBVAwy+DoXrK4E2570Q90yHyHpphhbHoCSIPjk0q674GPmOOqtZemzoZjXD5
 arKp1a0DGxFf9HWhk77DN3H+EXd/26rTROFqhCEShR30f7Hbi0Gsszc1yqGfFe39Fs5O
X-Google-Smtp-Source: AGHT+IEPq717QcYp7Gn8ovn86CMBV/vmZMQGbQsyPFu9cHxN3zGyly8FWxN7prxwFbhN/rGVlo8D4Q==
X-Received: by 2002:a05:6000:387:b0:3a5:2c18:b181 with SMTP id
 ffacd0b85a97d-3b5e86e3447mr3412550f8f.53.1752158745165; 
 Thu, 10 Jul 2025 07:45:45 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e26f7bsm2081856f8f.95.2025.07.10.07.45.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 07:45:44 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH] contrib/plugins/execlog: Explicitly check for
 qemu_plugin_read_register() failure
Date: Thu, 10 Jul 2025 15:45:43 +0100
Message-ID: <20250710144543.1187715-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

In insn_check_regs() we don't explicitly check whether
qemu_plugin_read_register() failed, which confuses Coverity into
thinking that sz can be -1 in the memcmp().  In fact the assertion
that sz == reg->last->len means this can't happen, but it's clearer
to both humans and Coverity if we explicitly assert that sz > 0, as
we already do in init_vcpu_register().

Coverity: CID 1611901, 1611902
Fixes: af6e4e0a22c1 ("contrib/plugins: extend execlog to track register changes")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 contrib/plugins/execlog.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/plugins/execlog.c b/contrib/plugins/execlog.c
index d67d0107613..8b07dd773e5 100644
--- a/contrib/plugins/execlog.c
+++ b/contrib/plugins/execlog.c
@@ -95,6 +95,7 @@ static void insn_check_regs(CPU *cpu)
 
         g_byte_array_set_size(reg->new, 0);
         sz = qemu_plugin_read_register(reg->handle, reg->new);
+        g_assert(sz > 0);
         g_assert(sz == reg->last->len);
 
         if (memcmp(reg->last->data, reg->new->data, sz)) {
-- 
2.43.0


