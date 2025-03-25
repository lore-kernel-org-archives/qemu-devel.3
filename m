Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56EBCC36005
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 22:49:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txD0g-00039X-7j; Tue, 25 Mar 2025 18:44:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1txD0L-0001ni-62
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 18:44:17 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1txD0D-000738-Mp
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 18:44:16 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2243803b776so3634615ad.0
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 15:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742942648; x=1743547448; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zAHr9PqknqCL0FB0Tc4WFmI5gr2YFriYH/85HJUA/+I=;
 b=yElOuqsxtNDs4icc8eGNf8lKgLxcoPC6U0QPf8iAqCYPQdbOuEpHbJjWVOIv+DLB/4
 4tjycuuic9UUB7XE4zLrLt4XYKekz75Y4AjhWzO943k8EPAXD4VczQd7vPR7KYlyG2Yp
 KMBA9oEaXvzXpgFcVIMzCR5zXU3M215vSq3PSSzc12czCWllkG2HXSD3VLl62E/jAqos
 VcUxtziIQ0p5KdR8g/81C9t4LL5M2HfjV9I3om/0x5w7+6s1Yps8P0MXmnqTBtsoem7d
 PEZCFjJDUi0Vz5wpLgfuugm3EnXxhMcOxBV018O5Z77bO3lrSGgOrl/xq/Dga78XHAcx
 wSog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742942648; x=1743547448;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zAHr9PqknqCL0FB0Tc4WFmI5gr2YFriYH/85HJUA/+I=;
 b=wJLs/iGFrfE7qPy38LoRsAT1cWVYtPCX3pr9Jx7CJTiTHq9/V9u/LLLBEICriBzSo2
 on+C4dOOF7QnXgU0Ho/o9cbwTanxOK4y2CrJn0+/EJJ8ArLxMEK/HpDqJC/E58VB3m8R
 ScvhYXovfMgNasj9DLrQiOy1j6Zcrrr0vFRjqr1BjKL1LasS8pRdS8yOQdmKGQQO+zeg
 +xtFgou9hlK+mEmu2gufyPQ03bhzPxK1SfPhSqDntX4tZVhPiw/+42ndxD+HOnBahwGL
 kg7HDEOr9fbKh48pZVQFcb6og0jTDBl9lCNtmoL0rBX3EdLPunYaKr1rPHmdrGYNuZrK
 L/fg==
X-Gm-Message-State: AOJu0Yx9AopjfOtO1OL6p7KqvYhfjGFYKuVly6cW8v4dVqz6/k/FyqC8
 dRk3ZFF0i+YNF9QprjYfDYI9kD1a2tCPEtpe3n3Q+4eYQeCyUNHS022Wqs9YfMkTjatJPq6dik6
 y
X-Gm-Gg: ASbGncs0zwNkUnGMfJpI5xVQBXWJrqMDAgaGpe88Bgc8HKdxtUjVzwUdgUYNAIiuosJ
 z/wL2ayHbVkIxB8PNFrz0ECeXitB9bugHs2GY7hEQgzMsmAm4ettgt7bemNQ+aI5R7CZ1pEmVF5
 W5PDddv2dJerngqltMEpZVuxeCjMwMBf6ktOc3YOWPEekz089BiB4gkQBuKZT5D/JCqGmpE8PyC
 WjgZTJ7zA+3sfuWk0tOeoowmq1D7mMns45xkD/xVisxyl9wORpuuf0rg5sE6ube013eRT+i6Vfc
 MHm2Pxt5q4utmkmgoEWjxWvE3NUiXLL+djT3Zq3vS+cW0i9gTI9ay1RgpwE1yiPR94GQXQL6WmA
 P
X-Google-Smtp-Source: AGHT+IHCrxOkY97HrB7dfsQDoDQ9n2u/WHWkpBliNeJ9jdoQUJjcaXPRS8dIm+3H/bFXd3tUtyCYag==
X-Received: by 2002:a05:6a20:43ac:b0:1f5:730b:e09a with SMTP id
 adf61e73a8af0-1fe42f99190mr32244080637.20.1742942648450; 
 Tue, 25 Mar 2025 15:44:08 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7390611d3d6sm11111321b3a.94.2025.03.25.15.44.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Mar 2025 15:44:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mrolnik@gmail.com,
	philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH v2 05/11] target/avr: Remove NUMBER_OF_IO_REGISTERS
Date: Tue, 25 Mar 2025 15:43:57 -0700
Message-ID: <20250325224403.4011975-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250325224403.4011975-1-richard.henderson@linaro.org>
References: <20250325224403.4011975-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

This define isn't used.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/avr/cpu.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/avr/cpu.h b/target/avr/cpu.h
index 84a8f5cc8c..b49e7a7056 100644
--- a/target/avr/cpu.h
+++ b/target/avr/cpu.h
@@ -44,8 +44,6 @@
 
 /* Number of CPU registers */
 #define NUMBER_OF_CPU_REGISTERS 32
-/* Number of IO registers accessible by ld/st/in/out */
-#define NUMBER_OF_IO_REGISTERS 64
 
 /*
  * Offsets of AVR memory regions in host memory space.
-- 
2.43.0


