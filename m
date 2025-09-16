Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 469D4CAC59B
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 14:31:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyWcz-0000yv-Fu; Tue, 16 Sep 2025 10:25:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyWaf-00062p-1n
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 10:23:29 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyWaU-0008JI-ED
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 10:23:28 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-25669596955so57003035ad.0
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 07:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758032567; x=1758637367; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZH0mjB8So3ur3KXNJMzLcfZFHoI3w+OVbUHK09CkjfQ=;
 b=ri8/oyhVzcYjI6fJtE1HND5l+cMhBbLAJ2SwUZFP2rPA/Juia/8zVIgmxlWd1y03dJ
 cDB64/JoJa2pkpOgki1BTEWaj6DI0xYYq2lWDrlRUYzSfA88MJfiRZ+RItj6ttiAY4Ir
 H1TnT9Z9m0xNS36I8AHeYxD+5GaxGAmaUUH1utXH8trdYzDO9214rXhaAvQPvDcHCE4+
 v1kF5iB2Nc/5UyOmKS06VvRtFcd7qmCAlRjoI3e83s07KmmKBKLl2z7Zyv8WxiDu08HG
 AuRpNfbGb4axRq2vW0J7GK+v92vOw13w3onDAloMMHz0pd3bLmrBiqbiEXTEoqisIJfA
 L5Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758032567; x=1758637367;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZH0mjB8So3ur3KXNJMzLcfZFHoI3w+OVbUHK09CkjfQ=;
 b=olbFJTDkUByuefPTOl33XFv9+8w66XaEwmur5x3NCNg9PJNDDFdaSy5EeqEF3ToHub
 LNQT9FYMFg5pb9ifTOqopGuZ3ML0CkOAnNXt4JF4jnXvgiKAxLH4QfCo4uEOKnM1K9A5
 RxYSDUVq3c2KrJU014zc7e6ZWTMdv8o4SpgKhv6EesIpfCRsVzcImr1MChGw1YNnI5D5
 PZT/UpsDN+b2wDU07LpNONoqTNrAsWgrSYjfpE+bkillkXSqN+8IsRKfm7v+aI6HE9GT
 ye8La0UHFygdi2koKa1Krizd2W4gNR6nZoE21zwH4fzIVNY3fISm3dC5tEBasF4rlJ9X
 Bffw==
X-Gm-Message-State: AOJu0YxWuMHm2wCnliALB0Q5y34Oz4MBlBaFU9DqHRjLZNdgr63OBq9T
 j6nqKNQFkaAdthY6qUqUAKPp4roTDYzHvyoJSR7HB8iBNeLzdr0YdfeImN+vf8ILfzFkvgWDmnk
 VcR/3
X-Gm-Gg: ASbGncuTKSypBBy68YVaQwCLdMrNkLQMzJ4LKd8ugNGRVlNpg063wwJQWAm9RFRA+DM
 sThzC90ARoebHD5glgi9S0ghHuYGfTKVUr6PBFLSCoan6pRuHGi6/ql1COA/mQ+HRlnU38cczuR
 nEIS17689wNuh7WpBxlKvUeozZvJSv0OVXnL1Bg0vGdkj5CEtMhS9DEHOTZbaot38U8IkBAaCRi
 tmzfhvqp58yiRdZU0UVMbkrcfY5sFvS1zWCf58SKuir/wLnmzNUIoKNQ95ta5bzXDoQTXAlOtMb
 4ZNcSK8nDTsJ0yvBsG0egQPM6hNvw7WB2cDKRg57VOL3AfGFG5dkU5W9q1TUhyMyp30tEmmRFVg
 KQV0y1o/9kOUtu5f3S62jx+8iais9AVEb1P31zQY=
X-Google-Smtp-Source: AGHT+IG+v3H3/O7Wr4EKQVM8edjAxAdCdo/aABxMlATr82uHWyL3hoOKbDN+lOcn/r4nSc30WgXFuQ==
X-Received: by 2002:a17:903:478d:b0:264:8a8d:92dd with SMTP id
 d9443c01a7336-2648a8da428mr133255525ad.20.1758032567416; 
 Tue, 16 Sep 2025 07:22:47 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2651d2df15esm73459905ad.45.2025.09.16.07.22.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 07:22:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v2 09/36] target/arm/hvf: Use raw_read, raw_write to access
Date: Tue, 16 Sep 2025 07:22:10 -0700
Message-ID: <20250916142238.664316-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916142238.664316-1-richard.henderson@linaro.org>
References: <20250916142238.664316-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

Reduce the places that know about field types by 2.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/hvf/hvf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 99d8672b9b..694584cc13 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1153,7 +1153,7 @@ static bool hvf_sysreg_read_cp(CPUState *cpu, uint32_t reg, uint64_t *val)
         } else if (ri->readfn) {
             *val = ri->readfn(env, ri);
         } else {
-            *val = CPREG_FIELD64(env, ri);
+            *val = raw_read(env, ri);
         }
         trace_hvf_vgic_read(ri->name, *val);
         return true;
@@ -1435,7 +1435,7 @@ static bool hvf_sysreg_write_cp(CPUState *cpu, uint32_t reg, uint64_t val)
         if (ri->writefn) {
             ri->writefn(env, ri, val);
         } else {
-            CPREG_FIELD64(env, ri) = val;
+            raw_write(env, ri, val);
         }
 
         trace_hvf_vgic_write(ri->name, val);
-- 
2.43.0


