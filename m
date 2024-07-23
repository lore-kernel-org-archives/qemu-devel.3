Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 919F1C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 03:36:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW6JB-00031a-4a; Mon, 22 Jul 2024 23:35:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sW6J9-0002uS-Ho
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 23:35:23 -0400
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sW6J7-0001yu-VG
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 23:35:23 -0400
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-260f057aa9bso2815508fac.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 20:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721705720; x=1722310520; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0Aw83kLLuGjCQHx2MdR2LGZJ7cF9lloOkwjusYN+Kq0=;
 b=a2hNxd9okMXPrPsJgNol1bFaRISM+BTqi7Kr8Q37cGkAir4tges/a0aqXcPp4hW2XG
 gPFY6gilsf9DfB5d3KvNt6gbTZwyCpazx8xOXqyXEtvqn/OVA7uQmLPKqljVnZyGfEWg
 IRpRI+sR44zsVn8fe9A5USym8jb1fW/lK7bl5wK6zATUo3+2Cn1QJcUmzNlY9S/DlYJt
 vQBO97i6DjE1DC0rXZsFHOcUgst2M+FgFXKvIMMerFy0b5alc2eATIUPJdJwtiC0pg2E
 cFu0HQIc2ATgQg2VVvXS9mR/ME5JRAQYa4n3gHeoBD0CTr1VbYwBCRYLD/MM14kaJC2g
 U2hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721705720; x=1722310520;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0Aw83kLLuGjCQHx2MdR2LGZJ7cF9lloOkwjusYN+Kq0=;
 b=cbjatLq+tI4ra2G/lH2kPIclMelM5BmQ/hzFXDOryaPfihUN6K/9HQaCoWp5qQiRi6
 PTjir6n/90pyHG5r/zgZdc3G120nNRxVpbiC5gtpIuJWi/D7WhO5k2Z6M21VqHgvfnAW
 2GCOG4rUixXokTkH7NZ4JodTJCuGqZQYNFW1Gmqn+JUYoq5PqRdEE8+6oAyfuIukqCWk
 mlcTcGJH799DNJIZcX/0/iYrejnRY2JGExPPQocGKElGr+JW3npP0lFYWdlLPKy05shN
 KZKs0ZrkJH/Xzu4dxYzfYnryvsGZ9+4VlD/nLSPCRCvqV6QtN/423/HsNf8w9eiR1BjG
 RYfw==
X-Gm-Message-State: AOJu0YzhHd3uwCDgmRphs4ryC4izEk8RDySvx0O97Gqo2HKf1sf51bHf
 N1YUzBEizQPqZ94fyNUD8mlRA2ITJrxOrjzftlhd8mRSaz9/UbTIoeGO4vEvZ3ZsKQ4xmVkXGcl
 +/FRmhg==
X-Google-Smtp-Source: AGHT+IF0V+oohgp57Ifix300JeB1ZCupg0XVrWSm/A3RxXNMWdZKzLnEzZRNKorC2Xq+sV/IOqRbUw==
X-Received: by 2002:a05:6870:d627:b0:260:fbc0:96f2 with SMTP id
 586e51a60fabf-264692d60bdmr1545848fac.34.1721705720471; 
 Mon, 22 Jul 2024 20:35:20 -0700 (PDT)
Received: from stoup.. ([203.56.128.103]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70d2b96bfcasm2171380b3a.87.2024.07.22.20.35.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 20:35:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 09/12] target/s390x: Use user_or_likely in do_access_memset
Date: Tue, 23 Jul 2024 13:34:48 +1000
Message-ID: <20240723033451.546151-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240723033451.546151-1-richard.henderson@linaro.org>
References: <20240723033451.546151-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x35.google.com
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

Eliminate the ifdef by using a predicate that is
always true with CONFIG_USER_ONLY.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/tcg/mem_helper.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.c
index 6cdbc34178..5311a15a09 100644
--- a/target/s390x/tcg/mem_helper.c
+++ b/target/s390x/tcg/mem_helper.c
@@ -225,10 +225,7 @@ static void do_access_memset(CPUS390XState *env, vaddr vaddr, char *haddr,
                              uint8_t byte, uint16_t size, int mmu_idx,
                              uintptr_t ra)
 {
-#ifdef CONFIG_USER_ONLY
-    memset(haddr, byte, size);
-#else
-    if (likely(haddr)) {
+    if (user_or_likely(haddr)) {
         memset(haddr, byte, size);
     } else {
         MemOpIdx oi = make_memop_idx(MO_UB, mmu_idx);
@@ -236,7 +233,6 @@ static void do_access_memset(CPUS390XState *env, vaddr vaddr, char *haddr,
             cpu_stb_mmu(env, vaddr + i, byte, oi, ra);
         }
     }
-#endif
 }
 
 static void access_memset(CPUS390XState *env, S390Access *desta,
-- 
2.43.0


