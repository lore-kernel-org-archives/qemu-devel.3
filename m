Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ECC6C3DA5E
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 10:59:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU2MS-0005EG-OT; Wed, 17 Jul 2024 06:58:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sU2MP-0004zx-PS
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 06:58:13 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sU2MN-0005j1-Oc
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 06:58:13 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-36794da7c96so2199893f8f.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 03:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721213889; x=1721818689; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S4LCP0TPUvNWs+1AuzrihN13r1C08nRA9emJSD2ibmQ=;
 b=p84PL4uNts4JPPeEVfLo//iSombWu28Fim54m050gPSOVkiB+gWKmNE13NhlPM4fQV
 6ModDQnr2mkPnCcNV6mUMfvSMwhYAsAI7yFj37rfk5tBNeLuoCMYRiP1aQ2ADArXa9Me
 Qvc256ZNDYlClgkMTxvhQJo6drI3bfG2VwR6fjZvHSDi5suvjYcGN1tpgGW0GhGpD94v
 v5yx6G4QBZTqh2nvhsssFMO4MVE4r32Kd1X9Rb2QZEBqbpcHsw8m7cilZkHjADiDOhvo
 UvkFu7FHqGbEsqAGVKppg0q0BG0v9LusfA+LIF2rJ5fUBVaNE0TVQNXonMe5U0MsMlig
 ATyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721213889; x=1721818689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S4LCP0TPUvNWs+1AuzrihN13r1C08nRA9emJSD2ibmQ=;
 b=dw8A/+AlaSNmerdQZQmkWXoVEISU9UMbOu0EEl1Gc3gxRTcs4gpfKnZrt1/zBbyF/l
 MQ21X4DwI/ZKE0TYHMGZXbRpnzNUI2s3XzWuivV14Feo9j5lY0QGtYayLBZN8bVtw/Zs
 hZTP1zx2oSCZCaAu3IJpIt+uML9JIsZdQYXxlUjnjsTndtll7Gi/sH+2QfU6cOL2zCV0
 vFq6rpEigRquQ1Dq475Lqe75lM+S2/OrDfQp/5ek+hjXsLZwf1A4XtnpgBX0P49lyxfT
 QmXZP3d1csmfz4LMMYxYdXGMmLzoJndKnYjJCnNXPnw2YFMOBPAk59+naVnhYcvcdRf4
 f0cA==
X-Gm-Message-State: AOJu0YwRu2cQ2/SrYzF36HDG9NVzLbSyHgzxfw70m5t91WsG/RiTT8PQ
 IWgWfOaqISCezqoyDHraCUN1bHSrwtyY8avvh7LZxDLa0JMafK9ZQHEby/O5sLfmRK+qJ/gW9HG
 rZKMyDQ==
X-Google-Smtp-Source: AGHT+IFb0DArV+yDso2NvZpQvFOXENEFNEJSvTsMvEgTk9tab0oY6ZhD+GB6Uqf0m8OMtmkDJzXzKw==
X-Received: by 2002:a05:6000:1372:b0:367:8a24:1fde with SMTP id
 ffacd0b85a97d-3683165e7fbmr1132850f8f.17.1721213889111; 
 Wed, 17 Jul 2024 03:58:09 -0700 (PDT)
Received: from localhost.localdomain ([176.187.208.21])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-368337e1d12sm987534f8f.31.2024.07.17.03.58.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Jul 2024 03:58:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 8/8] semihosting: Restrict to TCG
Date: Wed, 17 Jul 2024 12:57:23 +0200
Message-ID: <20240717105723.58965-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240717105723.58965-1-philmd@linaro.org>
References: <20240717105723.58965-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

Semihosting currently uses the TCG probe_access API.
It is pointless to have it in the binary when TCG isn't.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 semihosting/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/semihosting/Kconfig b/semihosting/Kconfig
index eaf3a20ef5..fbe6ac87f9 100644
--- a/semihosting/Kconfig
+++ b/semihosting/Kconfig
@@ -1,6 +1,7 @@
 
 config SEMIHOSTING
        bool
+       depends on TCG
 
 config ARM_COMPATIBLE_SEMIHOSTING
        bool
-- 
2.41.0


