Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31857D6E2CE
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2024 07:47:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDfQO-0002UB-1J; Wed, 20 Nov 2024 02:46:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1tDfQM-0002TZ-U3
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 02:46:54 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1tDfQL-0006Rz-Bl
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 02:46:54 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-20c7ee8fe6bso17380365ad.2
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 23:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1732088812; x=1732693612; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qR1sFxsLrriO/BPDZ7OAiWQXKRll1xzEwd9fI6XIvNU=;
 b=YkD+sP1bLXwlm4WQYEcTfmw67LJt0C4yflyejjk11T7wZ7YmLdxCjoTriMpW6YZyOm
 LWeCKcaJqSbEJ89X3yoRZJKmElfJrUhSIlpWfn5rSZbTXIkqYCkh/3jZ47Mm07p86Qh0
 jYRD/39wcyaf1Is46fUEZ9BVbpH56EJeH5owLFMi4akRMchdNVOopYabCqY1nutncJ2l
 9cMkW7BYJg69cXYu8xUningQRAXMruQ7k2kqrAURUCVSR8vvcwcnBJ/KJuSyWrqQpI3v
 ovo92WZ2VBcZaRn9rhiuUHNNXIehpJVbTV+xvmzJ9vqdQskvBXEG+YApbh5UZvWJBBSY
 EGYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732088812; x=1732693612;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qR1sFxsLrriO/BPDZ7OAiWQXKRll1xzEwd9fI6XIvNU=;
 b=l3dvVjuaqjjVK6iZflPDRw/UfDdqBJ5JOYgLmdnXBpQYDtHXfCYQscfOj95InC3jbr
 BC27t99hray1HvcQltFOAMJoR3aEG9onOdi4oTJrO8ct6upnhY4qOji2N0i4usLF+1M1
 qDvU6gYkg8LsoIOs+kThi3bepC1NEutLxeMNkJ7ElyazsJE06Ear/e+HBugd1D5YKKvn
 DbSKhUI6/Xgp6PphjBULvwwrvdeypROWtAa0P1P/LtWM+7g8GI48GvD5QIM+0xLWDvF8
 dHaxHkwS7WRuElEt1skX0eSaDSRZ7Oqxvzx6zxQ7fEG7NLN/fCtzpc7CkYd49ZGb/jAW
 YS8w==
X-Gm-Message-State: AOJu0YztTzut4m4AMOnK7r73/P1SJ6ymQ0XL1D/H6C8C05efizEPppoU
 BGtLzgz9xL58V/P3QsRTeGe3XnJ6Heli/eoqyvB452pPYdO/Z5yQPRsGyq8yPNTztdEe7LMeH+V
 LR4ot/fGDIEUbQpLfnL+bQsK1cAkGPwt17DnwxZEL9H+ne5g74PZV5B95JQ061YdKnQfa0Lzqqa
 BlsI1HIyOkAhV163dF2OBwjWeVay+2tIA1Xio=
X-Gm-Gg: ASbGncs3GDxMZgom824TDKoy/v6dU6dgt8iyp3kepB96jg4Sr6+dK5pFbJnRuqdHHm1
 3ivg7L5zYd220fygTqz33gXFm+61MDJdGoCHz79myy+v/qaM3EXKIt7ViCOav/LeMZj2klsFtxF
 zKP4nMiNw73F1piNzulX6BmzC9Q35/uEB+JWzqoyaR91Uxso32o2QIWOb/laiHlPcuR1i2uOtG6
 BpbujMKOGXgk9js1dNqqwxpka+ykacjPVZGpxyEMReb3Wy9E13JC75onGh+8Q4uIDqgrqATqUpN
 hzeCN7gvVobAXp0dkqFpUOfDn/BavLt8sNdgE2GwmA==
X-Google-Smtp-Source: AGHT+IGcjC2zsB7038QVaycnOA00MoJQXwuwdXeTXVJA8GTE3hBHQdu5cZRc7+Qi8pQ4M4Est+tYKQ==
X-Received: by 2002:a17:902:e74c:b0:212:1f:e66b with SMTP id
 d9443c01a7336-2126a474ee5mr16915655ad.51.1732088811665; 
 Tue, 19 Nov 2024 23:46:51 -0800 (PST)
Received: from hsinchu36-syssw02.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211d0f51fe0sm86206255ad.233.2024.11.19.23.46.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 23:46:51 -0800 (PST)
From: "Fea.Wang" <fea.wang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, "Fea.Wang" <fea.wang@sifive.com>
Subject: [PATCH v4 6/6] target/riscv: Check svukte is not enabled in RV32
Date: Wed, 20 Nov 2024 15:48:54 +0800
Message-Id: <20241120074854.1767780-7-fea.wang@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241120074854.1767780-1-fea.wang@sifive.com>
References: <20241120074854.1767780-1-fea.wang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=fea.wang@sifive.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Based on the spec, svukte depends on SV39, so it should not be enabled
in RV32.

Signed-off-by: Fea.Wang <fea.wang@sifive.com>
---
 target/riscv/tcg/tcg-cpu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index c62c221696..4273f1f472 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -652,6 +652,11 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         return;
     }
 
+    if (mcc->misa_mxl_max == MXL_RV32 && cpu->cfg.ext_svukte) {
+        error_setg(errp, "svukte is not supported by to RV32");
+        return;
+    }
+
     /*
      * Disable isa extensions based on priv spec after we
      * validated and set everything we need.
-- 
2.34.1


