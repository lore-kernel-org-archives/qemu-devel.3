Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AD11C4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 21:50:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1CPk-000362-BY; Sun, 28 Apr 2024 17:50:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1CPh-00035I-DT
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 17:50:25 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1CPb-0001Je-Kp
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 17:50:24 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-41c1b75ca31so4419245e9.2
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 14:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714341016; x=1714945816; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PiKDLwE364Pw013trdbS6B+l3BI8G2aZyNTUUJSMStE=;
 b=UcCEgzjqTqWs+LW/8Pp7vqHI9MTjATyg+9KEeyI5SxIwzPXt7jEVHm5sZwrIBEApzF
 OJJNvhxyu3ysg0P8TlLxY3LX4Po/Vl2yQdAM9GAv1S2FZd1Zm5TvJ/QJoRl7+vtqxmR7
 WeKDBclMzLnXvFTcNAqKub+zCERiaWKsWbtT40zkX1aT0YzzNNXqRG+obM+cOoS/f0XH
 BfoIswGjYi/pHOJTxp237aLqAAYDnub5Zz1IMFg2YZSSGYhVGthfeC+a+IRBhHK2l/Dq
 R7QXQ7LBow/mCVNz5Dl47cP+klZMLkkFAtF2umGMac+bY5rHBE17ITxvu9dgosSN9mOU
 9kpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714341016; x=1714945816;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PiKDLwE364Pw013trdbS6B+l3BI8G2aZyNTUUJSMStE=;
 b=g8xs8s5pc2KOImPDnTXWKVS27l9PNS+pTzq2npsTxcP7nj92ol3IqrvXMOoFKwBaCf
 kpv+moBtY8Anxha8OQ991d4i2rIyLeuyI2QU2z4jygoGxYwsms2QONOOtzBDwPY1aRTS
 803Dm+U+yFGzVAEaIEdTxkqWRgJ/XvLMuYRWqn57plQ2FolI50IaFNyDJQGM674kDK2H
 1zmyHQMfLzCxJYxzs6jPZy+OoE/9pf+lBZYXayUNcepn7IF8uYWwuxm+Ry4Se5sYIoXR
 m7+H2xh/eAyQhKNI9/hLDEP0O5Hl21DVH3l2VI+MgU8GUWCLDyyZptYe3MtrPWSWNSDB
 Ec2Q==
X-Gm-Message-State: AOJu0YyzR6CDTJU3hdQlO+ELyj/Wq5vHTkbgumkLC2c1T3g3yqabVOLp
 FrqaO2K3680MqsPicCk6//Svl1tOgyA8rS/nhN+GDCp8BcNhJU6sSfZ+4ltO57Zo/8etNf6baC7
 z
X-Google-Smtp-Source: AGHT+IGUT5jQwd/Cn4XZf4R8UekYyzYZt42HD65j994dZ/HGdoeuNy1QlyLDwBkw4ORkmAYYakZBxg==
X-Received: by 2002:a05:600c:501f:b0:41b:b07a:c54c with SMTP id
 n31-20020a05600c501f00b0041bb07ac54cmr5546361wmr.9.1714341016281; 
 Sun, 28 Apr 2024 14:50:16 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.142.130])
 by smtp.gmail.com with ESMTPSA id
 k29-20020a05600c1c9d00b00418948a5eb0sm43150505wms.32.2024.04.28.14.50.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 28 Apr 2024 14:50:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 10/12] accel/tcg: Remove pointless initialization of
 cflags_next_tb
Date: Sun, 28 Apr 2024 23:49:13 +0200
Message-ID: <20240428214915.10339-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240428214915.10339-1-philmd@linaro.org>
References: <20240428214915.10339-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

cflags_next_tb is always re-initialized in the CPU Reset()
handler in cpu_common_reset_hold(), no need to initialize
it in cpu_common_initfn().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240427155714.53669-13-philmd@linaro.org>
---
 hw/core/cpu-common.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index a72d48d9e1..c4175cc4b9 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -255,7 +255,6 @@ static void cpu_common_initfn(Object *obj)
     /* the default value is changed by qemu_init_vcpu() for system-mode */
     cpu->nr_cores = 1;
     cpu->nr_threads = 1;
-    cpu->cflags_next_tb = -1;
 
     qemu_mutex_init(&cpu->work_mutex);
     qemu_lockcnt_init(&cpu->in_ioctl_lock);
-- 
2.41.0


