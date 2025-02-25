Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1C37C021BB
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 16:03:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmxOq-00011h-Sw; Tue, 25 Feb 2025 11:03:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <loic@rivosinc.com>) id 1tmxN1-0007Gi-75
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 11:01:19 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <loic@rivosinc.com>) id 1tmxMt-0001xE-UY
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 11:01:18 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4394a0c65fcso58745215e9.1
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 08:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1740499260; x=1741104060;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gFwyJsZ9aRSgNbolC4VPZjvH7EqpCkFhCwlagWn/q9A=;
 b=d1lq1bT3TWyNTG2U2qOjnIl/N8TdFcn6qBSioVbhZSYtwlh1TS1Ir9JffHo/5hglUM
 5QXfpz+vgAgRdY7jS6AjN1YIo95NtNGOnnZdRA4HX1qZpaGPrv71/sGAYGM/zjHfV8M+
 YS7AFkvQhjc03qfRVMkhQ+yggEQ3QRNOO+lRB73WjlwqDjRiwOrK2oXvkj/xvWaG2IJf
 4Hspx7w+s3mBAE0A3UgUh/7YRWfUfBLDSEvh8vWeMIerdNDMP99wJmdtzjHpDHyOHx22
 xAfi0Fc6n6IcPf56gapU/NfEzQgj0Jh84EC/K075VzgZ9yMcM1ogMuNbLuitaniRqM69
 NBmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740499260; x=1741104060;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gFwyJsZ9aRSgNbolC4VPZjvH7EqpCkFhCwlagWn/q9A=;
 b=N05cEdzZwyxYJ5qIOYJfyydCf73+t5EhMkT64XhGAgZ5ofsBxQG3VQ+kzh2Tixy0xi
 BQbisjo4I5ifXYPfBdJcZ/mAVhHRSVSMlGdagMERfHd7UkWqVhfB8rD48ZERr/uGRjRZ
 rGPqXDj9I1nVmcLkUG//tU83Z4K7FocM9t0C1/PnMOJy75LoUU73ioU6gz3F5yD7CGth
 0RjazRkJkpokKUzdthCMyHcBkH+n9oTfbKBkwZtF0666ZbHrxf6h9ooxIhRLB2DlZZyw
 gcc78noE4D/tznOS/oWwf5bk2eUVJsIuFDAJ9ndSsbVCJxcbYA9u9MQp1oaMLue2Td6b
 e4mw==
X-Gm-Message-State: AOJu0Yy2ndFZzjMeBsE1DLpf3TVUXn9VLRJAhwDZWvn5OMUmmhsV3rSA
 aUoOC/NXrSfJCTgYQSYLKFZ572SG2YgNY0HgjEpi1+dGXnmxepqqZkEYWrygQiG6JelVUQZGn/B
 vdkddK+cs
X-Gm-Gg: ASbGncsN2hjBNWdiL7776/abNvVNCm36+wN1m0Wg1dSL/dRZECuyufkND1e7wG+SJ4j
 7Eu2di//kaUsA90KsZ86n7MpU6nk/blFt32LWeeGMB0A6UsxAoFoPnmsvhfqI65B26GML6NYZ1x
 yb+A7y3BWZfkSvZfI6LIkgMVzZR7QSFDg/agpKVI2016nSsmaBROSeUJZiMk/uc8TaXxDdXYn+o
 wXaTkpYJJEmWTB83AjX7LCZwak2fvf5iaoCDA+CykTKRppQX9un134cyv7sf4GaMJY5iTtJbOxT
 dqvgpaK9k/FNwf4k149TC3Xuwrac2ZTPA444WUWtIrNZm9MXYoRhQCmpwD5ud2hU7P2XQK6m6w=
 =
X-Google-Smtp-Source: AGHT+IF9zC9j0LMpWwQJ9hPqqKtvjzOhmUmKjZiUsWMVEOysBPz5Aa6LQedkEf8EJOFeKLdogLqPKA==
X-Received: by 2002:a05:600c:1d8c:b0:439:98ca:e39b with SMTP id
 5b1f17b1804b1-43ab44b58c3mr27814935e9.29.1740499260185; 
 Tue, 25 Feb 2025 08:01:00 -0800 (PST)
Received: from llx1.cad.pilog.net (lfbn-mar-1-50-94.w86-229.abo.wanadoo.fr.
 [86.229.28.94]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ab1546df4sm30530755e9.17.2025.02.25.08.00.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 08:00:59 -0800 (PST)
From: =?UTF-8?q?Lo=C3=AFc=20Lefort?= <loic@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 qemu-riscv@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Lo=C3=AFc=20Lefort?= <loic@rivosinc.com>
Subject: [PATCH 5/5] target/riscv: pmp: remove redundant check in pmp_is_locked
Date: Tue, 25 Feb 2025 17:00:52 +0100
Message-ID: <20250225160052.39564-6-loic@rivosinc.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250225160052.39564-1-loic@rivosinc.com>
References: <20250225160052.39564-1-loic@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=loic@rivosinc.com; helo=mail-wm1-x329.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Remove useless check in pmp_is_locked, the function will return 0 in either
case.

Signed-off-by: Loïc Lefort <loic@rivosinc.com>
---
 target/riscv/pmp.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index e4fee10d93..81c8bd71ce 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -58,11 +58,6 @@ static inline int pmp_is_locked(CPURISCVState *env, uint32_t pmp_index)
         return 1;
     }
 
-    /* Top PMP has no 'next' to check */
-    if ((pmp_index + 1u) >= MAX_RISCV_PMPS) {
-        return 0;
-    }
-
     return 0;
 }
 
-- 
2.47.2


