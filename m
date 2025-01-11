Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AA2BE7719C
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jan 2025 18:40:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWgMc-0007EQ-Cm; Sat, 11 Jan 2025 13:37:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tWgMb-0007C7-1g; Sat, 11 Jan 2025 13:37:37 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tWgMZ-0003wP-Hu; Sat, 11 Jan 2025 13:37:36 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-aa679ad4265so770608666b.0; 
 Sat, 11 Jan 2025 10:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736620652; x=1737225452; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Xaj2HO8UwZmDfUICLPjjjrj0phn8PCO9qfBF54euiU=;
 b=Ya38lZu7C6Cl7lQRK7do7+R5S+4B3lk8B0+Nw1tXz+EKDOuCWzPkwvqyGaz89jERQi
 6x66dK1DdqrpjGYFs2kzCgZ/xCngIm2+EhNUXR00JlFhZjddZFWMXNiu56nIahKJEf6N
 XvEiC//MncEqSRbTVXMRi4ZVxop5d+HdWivdRc2/23vn9YbVkU1H6/J4jj1idwG2awR4
 scpuIHfl6pW+odwI19GjOoG6SgEXDe4QMv/MZSTyXsblfF5tDb+FOl7ggJ9/eWDzcxcI
 mXoc9ceKwgfTT9JTQwK/MSdDTFInI/LkpGb/AvbvahnsjWMLH6auRrHkJ1IeHcaqmEP3
 umkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736620652; x=1737225452;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9Xaj2HO8UwZmDfUICLPjjjrj0phn8PCO9qfBF54euiU=;
 b=Pt5ZbNqXYAVhGE6iW3y4fzPvi/PcQ+ZyVP4NEKQ+MwuK61iRaz/bPrIiw5KN9dVNv8
 Mc2912jOgKya5G66EgwF5NWRjaulqbdfbu8BueQ5g9yLyT+RrqlUwRR7A+WU9fjwwvGY
 SQXm1w/i6d9BQSKoJ4E9qgUsCt3LQXahmSwISMbS17MHR7ePgXPExQdmbs4veDdlgWOQ
 FKjxvVLnnP8PfGd2Aogk9kE8xzeTdEaNxPIOYh7X1+jKqcufzP4mUMcMp6K8nlkFAG2R
 8ScaWJ+nvomtbJ+upgcvHR80Nxnx3NuY+QlneDvDjQ28HOhQ5+/Ie1iT/m8xFOl6Q3+a
 REpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvCDNi6NOJIT6PpJ1n+2+hN+GkDOseMN+IjqKkJ9p4yhYfoxQjvwB9o7AJZXqf7b7uEh7FwaBh1tkPEA==@nongnu.org,
 AJvYcCWRBZdDcL+Ov2AdhEBfkxFCS838OwtKXZs58/7p0QHhiowc3/iI6x/snuAuhVWQAFiv64zIfyvKxw==@nongnu.org
X-Gm-Message-State: AOJu0YzEOpYNl+hXbJCaDnc4uo8dGkcGJyc/0wzVtf6dQaYLfQRxY+mP
 lWlagl60MReEnXpycYLmd02zOR7nyKtfgBc6RXvA1B7weOayf4fXNb8rcg==
X-Gm-Gg: ASbGncty43oh/oq+nLCE02Ifyga8tKxaljT8NcZS1LPnCZdXQmA3m8QU/0ITk0UZFNn
 301NuKt5unPXejj1qHAMdiUyZ3PkaQN2m+MVzu/zx3CYgBLEtV/tkBlRZ30TLR+7F100eezIujQ
 TR1dAVRgdakzWRu5++ddNqFFw0R988XIPYoNYBLIclMPnoKsA8GG+4Et85SOH4Mqy1Zxy2y8JQi
 v8yA7Fp9e2cbmL2YbOFvepuomfvLLDC8HtYE5vXQ6LESTMGiGXLCu/pBN96Tf+ShSA9/hyR7mfc
 7psC4p4XG1G1GnOrUfyMX1Ky27G2PbHpurIxf+pMbWM=
X-Google-Smtp-Source: AGHT+IHQDxDv0lrraQ7LH+zxIvmsnPJdn/XpJaIH+j5mAVxZZzSksDI0bJqf+u+8zO+d1rEZDnlbVw==
X-Received: by 2002:a17:907:6d15:b0:a9a:e0b8:5bac with SMTP id
 a640c23a62f3a-ab2c3d4d2bamr845691666b.23.1736620652069; 
 Sat, 11 Jan 2025 10:37:32 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-078-054-101-099.78.54.pool.telefonica.de. [78.54.101.99])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c95af187sm299026666b.142.2025.01.11.10.37.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Jan 2025 10:37:31 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Guenter Roeck <linux@roeck-us.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Laurent Vivier <lvivier@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-block@nongnu.org, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 09/13] hw/timer/imx_gpt: Remove unused define
Date: Sat, 11 Jan 2025 19:37:07 +0100
Message-ID: <20250111183711.2338-10-shentey@gmail.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250111183711.2338-1-shentey@gmail.com>
References: <20250111183711.2338-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/timer/imx_gpt.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/timer/imx_gpt.c b/hw/timer/imx_gpt.c
index 2663a9d9ef..11eca9fa4d 100644
--- a/hw/timer/imx_gpt.c
+++ b/hw/timer/imx_gpt.c
@@ -20,10 +20,6 @@
 #include "qemu/log.h"
 #include "trace.h"
 
-#ifndef DEBUG_IMX_GPT
-#define DEBUG_IMX_GPT 0
-#endif
-
 static const char *imx_gpt_reg_name(uint32_t reg)
 {
     switch (reg) {
-- 
2.48.0


