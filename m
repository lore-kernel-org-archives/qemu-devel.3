Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E869CD11DB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 15:51:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmbeO-0001B9-FU; Tue, 19 Mar 2024 11:45:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmbeL-0000zw-VT
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 11:45:14 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmbeF-0005SZ-IM
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 11:45:13 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-41465864644so4586245e9.0
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 08:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710863102; x=1711467902; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EJDlH3IcOyAIPXzpINjBXtBvgS8Gcx3JXjLnmPdWxeM=;
 b=hE8RTnq/ClWfhEVo2r5OHgqY/W+Lzq0pFD1B5JiE+JHTY5eNm+rck4WAceJlLf8/Yd
 D5E1RZ1SJNYM2njYFVnxWrirMCEUWRi8iunskkIYV2x9bXTkiCCtmvShuE4jvxcIRr+B
 Y5NPki0V+jrDim93T1ARAs2um1ZirzW7mUDgK2EcB7PzqeloLvMRqsw5+PuKHq2zMmh2
 ILHuNz27tvpLZ4YmVrvDMQ79FkvbiOCyJ+NRJ04jy9x3W1NEbRznPpEvCkRW3T7jUbMc
 WpWWFyYtwpjhS0Svxa0Yl1ZGps1lMj0nKfdATI1Pi4nwdxUryvtF5MFeHo4TgZE9gJf5
 G31A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710863102; x=1711467902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EJDlH3IcOyAIPXzpINjBXtBvgS8Gcx3JXjLnmPdWxeM=;
 b=FtTdhPfeXE09mah3Gd5Va/2mhOIu92+wle8UnMdxS+20IDbw+zQvRF7Gx9+E6Bhmvm
 o5poOl5ge1w/zhf9/nTef5wZmX1f387LgKxvjUiV+z5BI5ZqTYkrLNlLSX8TSykRNgPo
 vMi7RNOnrGMS9HeuiZmqw8ryFf5XgT/MYs+y5IBFLoxbZsS4PNefwdz2XUqmCjqxCbLJ
 +n+F6dwagAF7CVnRBOjAKdN30oW2fTr0cdEWO6mpyhCMG7w4ljEvaRlyDVHxDcCgHj71
 oQYTWdsOEapTyFWcfYkCKHBsBwA64swd2/5OwdSg/G8clFbwPIzJCUnXvpGUQenXYfT6
 ML8g==
X-Gm-Message-State: AOJu0YxptzBJefkm78lbwB0wgimZi5L0L01MZLtbGHERmRF1T7EIW/G/
 AfzVb9fy8mqbFxflh48+xI1yczAZkd0oERyHZCpCG5hTmIdZowABXRPmTfgNiFHLpiog5yTGHRO
 v
X-Google-Smtp-Source: AGHT+IGwQrOEEKFq39kvMb2rUEIJJbIzrkejECZTx4zU2qkt2Jf2TBS5atBbo3GFJHP+7teutPYluA==
X-Received: by 2002:a05:600c:3503:b0:412:c285:1091 with SMTP id
 h3-20020a05600c350300b00412c2851091mr2952541wmq.7.1710863102010; 
 Tue, 19 Mar 2024 08:45:02 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.166.129])
 by smtp.gmail.com with ESMTPSA id
 fl6-20020a05600c0b8600b00414692977c3sm426238wmb.14.2024.03.19.08.45.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 19 Mar 2024 08:45:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH-for-9.1 21/27] target/s390x: Restrict TCG-specific declarations
Date: Tue, 19 Mar 2024 16:42:50 +0100
Message-ID: <20240319154258.71206-22-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240319154258.71206-1-philmd@linaro.org>
References: <20240319154258.71206-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/s390x-internal.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/s390x/s390x-internal.h b/target/s390x/s390x-internal.h
index 825252d728..559c9f561d 100644
--- a/target/s390x/s390x-internal.h
+++ b/target/s390x/s390x-internal.h
@@ -398,10 +398,12 @@ void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3,
 
 
 /* translate.c */
+#ifdef CONFIG_TCG
 void s390x_translate_init(void);
 void s390x_restore_state_to_opc(CPUState *cs,
                                 const TranslationBlock *tb,
                                 const uint64_t *data);
+#endif /* CONFIG_TCG */
 
 /* sigp.c */
 int handle_sigp(CPUS390XState *env, uint8_t order, uint64_t r1, uint64_t r3);
-- 
2.41.0


