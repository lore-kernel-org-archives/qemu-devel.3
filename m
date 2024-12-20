Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B386FE77184
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 01:57:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOSFy-00016h-WB; Thu, 19 Dec 2024 20:56:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tOSFt-0000nJ-Uz
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 20:56:41 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tOSFs-0004du-Bz
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 20:56:41 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-725c86bbae7so1287661b3a.3
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 17:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734659799; x=1735264599; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TduC2J/yNmTTE2R5ICRn5/t9vkcz5PWA+UR8MkeO9Bs=;
 b=GYw0aKsUjHxL+d2cOshj4/39QuYKKvfaLlVDowRzM7ZS3u6ct/TEE7GqLp+uJtRX3D
 omH90dqLoStMCgR/eVwSAVdh5L+HalPY9SHacInImjzrCsAL2V7sHjdK21FYDTW0ghjy
 NcQvex/2Rsm5u0RUebb+JRVsopiNZ1T+bvDGwyU4u7ib8zLcE1uHxM4OdmFpbu4e7iRK
 XM+RLhYgfk71Elyc7XLtrz5/Lqv0xLw08poR9efMErgj8FHYbtYYmSqvkeNrsRBSkehF
 HMm+kriNFwQg+fiQJa98aee/kHGkgeARg6sTr4wU4JJIrsamL2GaS458Ow8I4NInhjJq
 ZVAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734659799; x=1735264599;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TduC2J/yNmTTE2R5ICRn5/t9vkcz5PWA+UR8MkeO9Bs=;
 b=xNL+R5hYVmJiX4kpcyx2TiRTXvVvsRxA9f/YPYQwIy7DqBOVbK5eEWxk0p6HXFJ2xc
 3e0jzwPrDP/G0HI4clPNUBGro/1c9TT+YpwJC/DzRFOfpeLgvX/d7FDr9Uo/2kLaiNC0
 k9/hs8AMyOu+945+0t4r5mcz4lvi2r3ZvYICni1CvdpyAxKg0lWYuI2pZwUpRVKR2sPv
 cqaZErnAKgiNUIyY7RnKqyt84Bvje9z/jLhXSDk1n66VT8BRamapaKD1M1gAIPfXesMp
 gpcFmW6xduw1LQ1RH214DL8+GRjR8AcE1O6BHyjSHTkgVVXOSHLDB04MBNJIQnExDDIR
 SwwQ==
X-Gm-Message-State: AOJu0YwClaJlSDwjqP2qef2MOLYNbloAryzzg8azqpsZZ3guQ8Itw8TG
 AnveJ6WIXH3rIi6zKXUD74qO9jOstSDvsCKWkXto1YZ5Z/vXLMhA95r1AYKS
X-Gm-Gg: ASbGncsw0s+cYRmgFuS3SSTf9dber6cDg1bw+MgSpZ2HKr33zu5bQ/WtxPUk8ITfHWb
 DRkEDA8jdMyuOEi78WUvI3HZhTLZkq0ZBCZCF9mW1wItMPHQPvYbk0UTrJCDXsqFV0wjrSx/aa6
 Xb/EuBL8hllLwaWCC1B07EaIwq3kvmWQ8JW3HTOIQwipiQf3GBjFY2LwKh5+DjnFw+gRkkgq4zE
 cLXtMVldlqnh7h8ZkUy/a5fmRqEuj9lTpUMsLrAx5Kf31r2eRfvEUM4+kJpJ9qQ9h8jokIOtbuE
 ViUMi03pQbcQHKHAiHBsNs2KRIifqFsyzXpEe8J+Mlt7wB082OQPOY5WQ3rFYWw=
X-Google-Smtp-Source: AGHT+IEYwgriLNeRWG1b3q15zTPw+p33sAFUVZbfrC8zsQjAhxXPw3EwYQS3+kOnsF0LVNEOcF/WdQ==
X-Received: by 2002:a05:6a00:44cb:b0:725:1d37:ebff with SMTP id
 d2e1a72fcca58-72abe0960c6mr1322463b3a.22.1734659797604; 
 Thu, 19 Dec 2024 17:56:37 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8164d3sm2002539b3a.15.2024.12.19.17.56.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 17:56:37 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, "Fea.Wang" <fea.wang@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 34/39] target/riscv: Check svukte is not enabled in RV32
Date: Fri, 20 Dec 2024 11:54:34 +1000
Message-ID: <20241220015441.317236-35-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220015441.317236-1-alistair.francis@wdc.com>
References: <20241220015441.317236-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: "Fea.Wang" <fea.wang@sifive.com>

The spec explicitly says svukte doesn't support RV32. So check that it
is not enabled in RV32.

Signed-off-by: Fea.Wang <fea.wang@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20241203034932.25185-7-fea.wang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/tcg-cpu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index c62c221696..3b99c8c9e3 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -652,6 +652,11 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         return;
     }
 
+    if (mcc->misa_mxl_max == MXL_RV32 && cpu->cfg.ext_svukte) {
+        error_setg(errp, "svukte is not supported for RV32");
+        return;
+    }
+
     /*
      * Disable isa extensions based on priv spec after we
      * validated and set everything we need.
-- 
2.47.1


