Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 926ABC5478A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 21:19:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rctyW-00049c-H5; Wed, 21 Feb 2024 16:17:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rctyL-0003Ut-Ji
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:17:46 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rctyG-0000y4-Of
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:17:45 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-33aeb088324so3908689f8f.2
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 13:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708550259; x=1709155059; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BjLOWnOowHsDr6B+HTK3K7dnAqdoyTXUuN5gUgDOyxc=;
 b=i6GbSvhLMscjmR20xCNa2UCblE+gWX7go3qvdspTDC8hYccvzP7MmajJxlxHDc6s3k
 e53wPWUdk3tDP+2J+ooalVBfYqj30RPEtWUl3AQq7eByiCVheJZHIpG/gxB0nKmobrkq
 SR1BMmrbWqTgWztpYOdQvSkULA8pv0GHvaVRC2UDnyD8KUEX/9RmV9yrG1idCa5mp3kx
 qyenmg6uj6pdQoua/PQ08s1LS1yQmO2Qhd3pMHBFr0zxTpqcO93djw/Dzq/fPtTNZlL9
 1e+4XWPsTGZuM3O47sEliT83Gb6KMT6sUUF2UtHP9osm0tNp6Iyp6+gLD9OKmvGjcyiR
 /AdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708550259; x=1709155059;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BjLOWnOowHsDr6B+HTK3K7dnAqdoyTXUuN5gUgDOyxc=;
 b=bTOMKGQpiWmb9V2zTzDviZTU54F92BSrgSaz6oDZeukUd/SQoa75GzA5SlhaEuytJ8
 Nr5aCj1wzOzQXm/JtJws8zpu5ICRskRpqsXAfXAkMRDbXvgxhJBCLEkn0ovbBjiI1LjB
 fxdPU9EuwcVAjM+XZul2riY5qnNsOWaG/Sii03oclMaptFYfyuTnm9iE2v13xQftwiZ1
 NFKVPWbMAD3TvQjlcdBn+KFY4NoBImd5XdpnMbC9VL0v14iiUWof+GH4kkl1p6VbHF3q
 Xs2irPBsD+cFDx+qHM3ZfLRDU3328fACOojx99yTCogBRnTFA5LJxCu7rmkNIGJq+qvc
 BQjQ==
X-Gm-Message-State: AOJu0Yz+vIseQdUAjYSqhQqfHEvVkx/Bge2Sg7MRDr1Fd4DGNH+0XV6t
 zzHq2Uz9/4T4Hf/b/U8ABHXicVlVM2XQ5YuWuCinT4DZvapE7vT0D9/p9BSDCboaFTHP0OkZBXB
 ury0=
X-Google-Smtp-Source: AGHT+IENLPABupxNks9MlSVajhcdQIKNGGK2eWFNHJ+le8zEE2ru50YvEYuzvpt2J2lO5SJ6peg4kw==
X-Received: by 2002:a5d:6dae:0:b0:33d:3cf6:a2ca with SMTP id
 u14-20020a5d6dae000000b0033d3cf6a2camr8716854wrs.30.1708550258936; 
 Wed, 21 Feb 2024 13:17:38 -0800 (PST)
Received: from m1x-phil.lan ([176.187.211.34])
 by smtp.gmail.com with ESMTPSA id
 14-20020a056000154e00b0033d10bd6612sm18477037wry.81.2024.02.21.13.17.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 21 Feb 2024 13:17:38 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org,
 Joe Komlodi <komlodi@google.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Corey Minyard <cminyard@mvista.com>
Subject: [PULL 07/25] hw/i2c/smbus_slave: Add object path on error prints
Date: Wed, 21 Feb 2024 22:16:07 +0100
Message-ID: <20240221211626.48190-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240221211626.48190-1-philmd@linaro.org>
References: <20240221211626.48190-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

From: Joe Komlodi <komlodi@google.com>

The current logging doesn't tell us which specific smbus device is an
error state.

Signed-off-by: Joe Komlodi <komlodi@google.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240202204847.2062798-3-komlodi@google.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i2c/smbus_slave.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/i2c/smbus_slave.c b/hw/i2c/smbus_slave.c
index 1300c9ec72..9f9afc25a4 100644
--- a/hw/i2c/smbus_slave.c
+++ b/hw/i2c/smbus_slave.c
@@ -25,11 +25,15 @@
 #define DPRINTF(fmt, ...) \
 do { printf("smbus(%02x): " fmt , dev->i2c.address, ## __VA_ARGS__); } while (0)
 #define BADF(fmt, ...) \
-do { fprintf(stderr, "smbus: error: " fmt , ## __VA_ARGS__); exit(1);} while (0)
+do { g_autofree char *qom_path = object_get_canonical_path(OBJECT(dev));  \
+    fprintf(stderr, "%s: smbus: error: " fmt , qom_path, ## __VA_ARGS__); \
+            exit(1); } while (0)
 #else
 #define DPRINTF(fmt, ...) do {} while(0)
 #define BADF(fmt, ...) \
-do { fprintf(stderr, "smbus: error: " fmt , ## __VA_ARGS__);} while (0)
+do { g_autofree char *qom_path = object_get_canonical_path(OBJECT(dev));  \
+    fprintf(stderr, "%s: smbus: error: " fmt , qom_path, ## __VA_ARGS__); \
+             } while (0)
 #endif
 
 enum {
-- 
2.41.0


