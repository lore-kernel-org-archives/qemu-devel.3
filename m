Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D4A1C41513
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 06:11:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTxrj-00079w-Vn; Wed, 17 Jul 2024 02:10:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sTxrJ-0005M0-TI
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 02:09:49 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sTxrD-00034t-PW
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 02:09:46 -0400
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3d96365dc34so4851417b6e.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 23:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721196578; x=1721801378; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R2XV0a88eGLbu1U/vWq9ttzcAxIlbjkNY5QMrMqYulc=;
 b=i3yKvF8A5GRiSialPOKJEdvsbkG8FxW8uPQrzhQA5eFVX6+L8V8lpNwSEfWImBUcWF
 nOT6koPsSTZfyEPu+R/2R3quDI5OK3+cUdLEK32i5WrYD4Og2jK/4isNjrXZbbgQBtOq
 JoTiJ3dGOeoxl/Tt1HEUPsF4pSLiXqQRWf2F99plhqLMIMbmnHDbC+Y34S4jZh46YPH3
 pK4VbFsYvMJZrWCTjbzJ63dtWRYQPZiUQ/vYYexswyIONv7gakvi0+1bdbiXrBMONA18
 SRUoS2fylTHKFD/jTZh7hQVB+oUk6N0XCxHDMk1KJaV1JP1AWrKJeWUt0hDJd48XfRub
 qxPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721196578; x=1721801378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R2XV0a88eGLbu1U/vWq9ttzcAxIlbjkNY5QMrMqYulc=;
 b=qChNBMmYfEd6pTn3SaUbEE3paQejZVLK9XPmOIf38g/mA3sk3jBDsthG69oKn9gcYt
 plEcVlkVCtSlGpRdhoPDe/G3h8KMBFVenCvSKy0o3zKjSF58MERIRvdTjW/jlTBOFJpg
 yzxrzvOhh9t2dQeeRP9gRyx/OBmM33beh/Nu58vlvj8kxsABIstPgVbESK2uNQzoTc1Z
 AA6OpUPnOIeM/cuage985BGtPpJBAMq6ZK/r4f4qAWHmxym2j9IWkm6sarP5PcWc0seM
 kwTxqlOok3mVpxnFp3oECxdJo2vbUewILcL6A+C02hFXmZLFzqvekxrVRGrVxikCB6AL
 DF+w==
X-Gm-Message-State: AOJu0YyH7KBbkPaFfRMbjH6FPjU44+YP2JPKyclSS7zpf8DigcKP2uTk
 PtOk5elhUKgxDborQNpeJ7x9eiXbZYs1UlixbK8muu7fbiaRDTH6VAyxm4Lru/Z7eVlP74Va/DS
 ucdY=
X-Google-Smtp-Source: AGHT+IE/1+DMmI7kX5lfczf/8DxkkTZR0ZID09vzhY7UEkXGWXpvKLjjP4UGovF6H0SBpgRuC2tifw==
X-Received: by 2002:a05:6808:1483:b0:3da:b3b3:191 with SMTP id
 5614622812f47-3dad1f7c512mr988315b6e.48.1721196578203; 
 Tue, 16 Jul 2024 23:09:38 -0700 (PDT)
Received: from stoup.. ([203.56.128.103]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b7ecd603bsm7330404b3a.219.2024.07.16.23.09.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 23:09:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 11/17] target/arm: Fix whitespace near gen_srshr64_i64
Date: Wed, 17 Jul 2024 16:08:57 +1000
Message-ID: <20240717060903.205098-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240717060903.205098-1-richard.henderson@linaro.org>
References: <20240717060903.205098-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x233.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/gengvec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/gengvec.c b/target/arm/tcg/gengvec.c
index 47ac2634ce..b6c0d86bad 100644
--- a/target/arm/tcg/gengvec.c
+++ b/target/arm/tcg/gengvec.c
@@ -304,7 +304,7 @@ void gen_srshr32_i32(TCGv_i32 d, TCGv_i32 a, int32_t sh)
     tcg_gen_add_i32(d, d, t);
 }
 
- void gen_srshr64_i64(TCGv_i64 d, TCGv_i64 a, int64_t sh)
+void gen_srshr64_i64(TCGv_i64 d, TCGv_i64 a, int64_t sh)
 {
     TCGv_i64 t = tcg_temp_new_i64();
 
-- 
2.43.0


