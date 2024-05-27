Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE110C25B78
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 00:54:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBOZb-0007SC-06; Sun, 26 May 2024 20:50:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBOZJ-0007Cp-8C
 for qemu-devel@nongnu.org; Sun, 26 May 2024 20:50:29 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBOZ7-0003f1-TA
 for qemu-devel@nongnu.org; Sun, 26 May 2024 20:50:25 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6f8e9870e72so2388820b3a.1
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 17:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716771015; x=1717375815; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cH8p7zFQoa8qKM/2WS7ZfbaGhkQJFlfpHgdlJuwcM/w=;
 b=LwdQg8ib+n6BafR6TW9s36jZHujxpgIkqjWOHt1X3PEnRlVGsISjGmcg/JV9bDrT7p
 jRGBZjfpxAyOpYyMIOD8CSU9vO/+M2r8IP56Ea50VlWW/VnkrLWtQttukiD/NemPEKSc
 Q4v2kAUUhvGAH6Bc7SKoBBoebIeSaJtCD6L/inH2UD0QcMDX0LEW58eJNbangTpi00rx
 8GLlcjhhnOHvsBISpN6dtp9rZl+yU5m0kUMCj+5lUfz+qqSl186/EuIJH9ALX/jSHLjU
 +YHQPJ5ku8K73j6mE1siIBouRc3ioPSiybg4Ryi3NZcYQpeUrBmd30TO8ppHQnhlVW4W
 DcNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716771015; x=1717375815;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cH8p7zFQoa8qKM/2WS7ZfbaGhkQJFlfpHgdlJuwcM/w=;
 b=LiQxO7q4plhYvMfP2UBFsNAbXNj5ghKUTS6afWE14JJLSV/SBXmSWw5GYxStrHMjmm
 2tjbXADfR1phgu8RnPg7+j883oUviWjMfJbsUVyEPutlrd2D4KVxjIT46pwiz+oEegM7
 oZtSNMxjl6qd6fBnZALfPtQDuJHSBLzzOlRcaNp0irEgqaZ/o3D8Tg2od9mSS3VaFk1s
 3hTPgV7kDSvwMdCnGcQ+AhVnW4AHpclfYELUPeN5rLTTAmJfW+DIdF+Tw7tQaL1alrHd
 cso7y2JTt9MSuCk39VDVXKab9t6K0N+9j5+D8FCShI3G0yDd1paBKYV1zHMAjezFInEi
 vXdg==
X-Gm-Message-State: AOJu0Yxt826r7y8qoI/DvoTHfvkTZAF6q0kDFfDbVl5wAbukai0lZAOZ
 MLcmkBuWQyJWg3RcXXNjEH5NkSwVlGk5HzIdzdSgbf+yRUJhMgUgOPesPIthYGmMcBb9QyDHx0n
 W
X-Google-Smtp-Source: AGHT+IHPn3d4k39EEaLTJfcpFpdY4Zbr0JG2RGUUp2RFuHF/+s++Gnkx9iHh6ecy+jHCqdaNjILpJQ==
X-Received: by 2002:a05:6a00:368a:b0:6f6:a417:fa44 with SMTP id
 d2e1a72fcca58-6f8f45d8ff2mr8400917b3a.29.1716771015417; 
 Sun, 26 May 2024 17:50:15 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fd6d7598sm3942958b3a.220.2024.05.26.17.50.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 17:50:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 16/28] linux-user/i386: Remove xfeatures from
 target_fpstate_fxsave
Date: Sun, 26 May 2024 17:49:49 -0700
Message-Id: <20240527005001.642825-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527005001.642825-1-richard.henderson@linaro.org>
References: <20240527005001.642825-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This is easily computed by advancing past the structure.
At the same time, replace the magic number "64".

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/i386/signal.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/linux-user/i386/signal.c b/linux-user/i386/signal.c
index 89048ed069..f8064691c4 100644
--- a/linux-user/i386/signal.c
+++ b/linux-user/i386/signal.c
@@ -67,7 +67,6 @@ struct target_fpstate_fxsave {
     uint32_t xmm_space[64];
     uint32_t hw_reserved[12];
     struct target_fpx_sw_bytes sw_reserved;
-    uint8_t xfeatures[];
 };
 #define TARGET_FXSAVE_SIZE   sizeof(struct target_fpstate_fxsave)
 QEMU_BUILD_BUG_ON(TARGET_FXSAVE_SIZE != 512);
@@ -266,7 +265,7 @@ static void xsave_sigcontext(CPUX86State *env, struct target_fpstate_fxsave *fxs
         assert(!(fxsave_addr & 0x3f));
 
         /* Zero the header, XSAVE *adds* features to an existing save state.  */
-        memset(fxsave->xfeatures, 0, 64);
+        memset(fxsave + 1, 0, sizeof(X86XSaveHeader));
         cpu_x86_xsave(env, fxsave_addr, -1);
         __put_user(TARGET_FP_XSTATE_MAGIC1, &fxsave->sw_reserved.magic1);
         __put_user(extended_size, &fxsave->sw_reserved.extended_size);
-- 
2.34.1


