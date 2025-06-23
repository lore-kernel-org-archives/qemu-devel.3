Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68FB2C77B7C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 16:54:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTkQx-0000st-3h; Mon, 23 Jun 2025 12:54:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkrcmar@ventanamicro.com>)
 id 1uTkQu-0000rk-OB
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 12:54:12 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkrcmar@ventanamicro.com>)
 id 1uTkQt-0008C8-66
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 12:54:12 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4536c6b2506so362915e9.0
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 09:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1750697649; x=1751302449; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tNCesYs3FFj+/RQZWBoxRB23WBzDxbnoA2srKEuQzv4=;
 b=baPpPDgo0+BhElh1eMaz/CcSmMJ9fJQYASZ+wN4x6hQe51YtonU21fB1pDf0Ibyirz
 yM85eofOd15UepiNmAq+9UZfY5YOx4ZZVa3k7bD2LxkoqyN8c3F+AledfLik49pKWMye
 cXnVfRMJ9XNt9YTMaLxM3ufszGwh3uuLL8mt5hEP3Kca/0fObfzjrRJ17N7KvB0lRw5u
 6ajW/tvNXue/QLOIyB0iZk0GLoZVNw+EcqrWp0ublRMUXTBKAa3XzMkFbQEjitx9d/4n
 Hr03VaPGkSAi9ig2oOwDbmMf42am2C3rxrxg+FUfOVLjPt8qPrHz3ZRBXWv4R4BDb0NW
 a9Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750697649; x=1751302449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tNCesYs3FFj+/RQZWBoxRB23WBzDxbnoA2srKEuQzv4=;
 b=VgozgQAgBfwSxHgILre9dMKInuA28dbSHQsn6FwYiRe8prusj16xiFNEmQXUqozyky
 iqZYbNehf4XNcecNy2ugO9M0d16wWAtHtU2S3Zr6lE/Ds5UyDrHScOA5rJoK2+u8ebWe
 3hb27s7wE+ZRm8IGNWoa0VVnmKKy9cVjEoIIpq2zKmsb188N0CHcmjTYHaIUUkbUMw9P
 6Q/I6mMKRlrLMFbWYXAOijgdW4tbHHQEAD+2NV64yLyLrCLXT3iJt2rUS36dfIAylCoK
 6BxLZ9xjDgJlGGx999TLq5Kqej2nd1E+Ic8k0R7UwtgxnJvSVtqLzcJ0+PiBoVWeITrO
 Sjmg==
X-Gm-Message-State: AOJu0YwJ0P7VJwY+TNg829w+LxdwXtMrWV5VANWwErffdNySjz0wuwYw
 SVY5D7RJVXKkG3Z/i1Y5R3RumE4BcQYMD+ehG3e6Mxvq3cvo9896SsjvoKivcScZ7DM=
X-Gm-Gg: ASbGncvK5UCvAxEtHCItWwhUiOEoF6O83Vupw0VgoCdW+5Rd32EgE4b6HuvzALTs6Av
 dXNvFlE2Ppe40BL54khMCWEWTu0L+6Nk+HCzAhnkKD+yAK+j3LSK1qCkUFyqYnvVw4nLGMCPUYj
 nEUF2o4rM+oX/1+6taVYdJCpsSaeAjrBIyicqPiMXGleVMSe1684gK4N4Ef2DmGmzwsnxM3MDo+
 RvohcNYUrax+LE4+Uf651oclGdDBy1o0xKWGE4MimEeGlCnxpllvcoRWHNdSdFTH21ni+fJ4cD4
 LypzotU5kGOg+LuNzg0XwSlXNB8sdfPDU63GShvFqO1vZdIWwr9A1G1rZRJeG/g8W08=
X-Google-Smtp-Source: AGHT+IEto515WugI+tQ8tzq/Ckbh2Pz50Ab9kcI7e97q/wl6trF+5OZZh4CYul12bGQb/+lxjnlVDg==
X-Received: by 2002:a05:600c:1c28:b0:453:4376:8f48 with SMTP id
 5b1f17b1804b1-453659d879bmr49082635e9.6.1750697649327; 
 Mon, 23 Jun 2025 09:54:09 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200:8947:973b:de:93b7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453647082a2sm116607745e9.37.2025.06.23.09.54.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 09:54:08 -0700 (PDT)
From: =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
To: qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Atish Patra <atishp@rivosinc.com>
Subject: [PATCH 2/2] target/riscv: disarm timer when writing past value
Date: Mon, 23 Jun 2025 18:53:29 +0200
Message-ID: <20250623165329.2759651-3-rkrcmar@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623165329.2759651-1-rkrcmar@ventanamicro.com>
References: <20250623165329.2759651-1-rkrcmar@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=rkrcmar@ventanamicro.com; helo=mail-wm1-x330.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

There is no need to keep the timer running when writing a past value to
the *stimecmp.  The behavior was correct before, but I think it makes a
bit more sense like this.

Signed-off-by: Radim Krčmář <rkrcmar@ventanamicro.com>
---
 target/riscv/time_helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/riscv/time_helper.c b/target/riscv/time_helper.c
index 8198a2d8d92d..81a6a6394502 100644
--- a/target/riscv/time_helper.c
+++ b/target/riscv/time_helper.c
@@ -64,6 +64,8 @@ void riscv_timer_write_timecmp(CPURISCVState *env, QEMUTimer *timer,
          * If we're setting an stimecmp value in the "past",
          * immediately raise the timer interrupt
          */
+        timer_del(timer);
+
         if (timer_irq == MIP_VSTIP) {
             env->vstime_irq = 1;
             riscv_cpu_update_mip(env, 0, BOOL_TO_MASK(1));
-- 
2.49.0


