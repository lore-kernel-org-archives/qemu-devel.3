Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74097CCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 05:26:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v75aK-0006jI-BL; Fri, 10 Oct 2025 01:22:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v75aI-0006is-CA
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 01:22:30 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v75aD-0000x6-TG
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 01:22:30 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3f0134ccc0cso1170917f8f.1
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 22:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760073742; x=1760678542; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cLnb0+UZNnHyfQFRiD2LKaf+Nk8xNSma03ZJfohueQ4=;
 b=ZqXiVSzH4kuESkKarWbNosbsIGP5VUYixJXnLhtsRI127FCMEfvurtOKCYbHflvdgj
 2q4rtV+769MNXZys199/WDm4PnWmUpBcJnksb6t+I/Z5/++4DcPAhSsB7LzB2twFNLdC
 EHreR4GLUm66SeketxC84GZt+NxswTtGg7gFwYZV2yo0nJuO/CvYHfKQnfq18zLNL0Qa
 iBdB1h9LbgiriwQ9FXJZgYnvIA5rCgFnggIybSZt8Pqtuh5vN/wCYfvwzsEc8cICqtnT
 Mw6we0kKsjZzeqwlN/5Sv8T2OHhWG2BdjiUr06COrAXAb0p7jMxh5ndFQ8Y+KSMwIn8Q
 faIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760073742; x=1760678542;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cLnb0+UZNnHyfQFRiD2LKaf+Nk8xNSma03ZJfohueQ4=;
 b=PqKIyMmPMG+AIvw0tU2/VnlC4P02f1x0SWd3pNtRNmdCa0WYCr6czi5HCedK56dEZ7
 /4v+0jp86opWMNmVoLXfDSb3W1ebgn8WJGpEG+4maZXskqUaO5YIApNU8fmQBsg7vRGr
 vcv+UhsTEW2QEna0LWq/ACyztNXUpugBPNkcZqU0+wsqPlkDAzMy76eZ7i9rmNYBntLm
 TJpDGYtnl452Sc0gLWv5gUwkkQEr9I+DmGieSmvS50PoWwalE4SBmjv4ZJlwN2tUjY3n
 Vtl4NE8rAZb2EA7bXctJ98/bs9lLpiIe6OjwbdCt2ixJyvdTWOx4w+vb7YhR/LNJK2aV
 9vWA==
X-Gm-Message-State: AOJu0YwfR5IrbVdlXDDowZGmtsDboamQhndzJ1ohrl60J6jMz4f1Jz/f
 8WaN51CB9LrxIS1zvP+LLiw92SWIHHo4hRfE8hX2zCCckEPvd6tIZKMkxk+Tj3cA+cp1E8swfcZ
 vsn8xJRdfqA==
X-Gm-Gg: ASbGncu/a9uSGYf0hJIrXyVY1I4tzO9vkkpXZqUWjVhfHeMeKj+zSPYSnbNOi8U9vYO
 G8aiZ2i/DSsEFEBfnaAqHfk/5a1oCxHgSC7JZ8jZ8ifNBt9JCk4HAUP9TPF3QEqFjmxhFvcs/NC
 tQlThW+jpilfBV4+cm51byP4ebPfnm5xSjrvYfiBXQI59t2U2bJ7XMAXCkWH3stTYINw/x0HmNY
 ilvbzkPnP4SwdHvkGkVDgo9vF9Ur2y3l6dNKAYj0lqKAXaLnaKRgm+X2qAGttXuFsZ0+zyp5l3Y
 I08WR+eCmKsXczB/jdhzXGFgH2WFZaDiv12UxZP2SV5Jg5K2BMm5nnKuNQ6gDH/9A6AfEfkFGgu
 brCRSGanBrdPhNHweeFMB8fSfRx8mX9L7Ip45AN0PKr7tyu3tooJCPQL4qQnwFXak1ZEDwoNJJY
 guPPqznz3iW3unrPgkgvyvQOaD
X-Google-Smtp-Source: AGHT+IE4SLkEKD6XzDuWGbSPA+3xrABRnQHI5e2SxVyiQuFlrfwcagnjA/eoTgHlVZYwd6kjwrBJyg==
X-Received: by 2002:a05:6000:2c0c:b0:3ff:d5c5:6b0d with SMTP id
 ffacd0b85a97d-42666abb559mr5982518f8f.4.1760073741941; 
 Thu, 09 Oct 2025 22:22:21 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5d0006sm2281109f8f.34.2025.10.09.22.22.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 22:22:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 08/12] target/tricore: Inline tcg_gen_ld32u_tl()
Date: Fri, 10 Oct 2025 07:21:36 +0200
Message-ID: <20251010052141.42460-9-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010052141.42460-1-philmd@linaro.org>
References: <20251010052141.42460-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

The TriCore target is only built as 32-bit, so tcg_gen_ld32u_tl()
expands to tcg_gen_ld_i32(). Use the latter to simplify the next
commit mechanical change.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/tricore/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 194c4db8d0f..da08f7bd60a 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -7959,7 +7959,7 @@ static void decode_sys_interrupts(DisasContext *ctx)
             tmp = tcg_temp_new();
             l1 = gen_new_label();
 
-            tcg_gen_ld32u_tl(tmp, tcg_env, offsetof(CPUTriCoreState, DBGSR));
+            tcg_gen_ld_i32(tmp, tcg_env, offsetof(CPUTriCoreState, DBGSR));
             tcg_gen_andi_tl(tmp, tmp, MASK_DBGSR_DE);
             tcg_gen_brcondi_tl(TCG_COND_NE, tmp, 1, l1);
             gen_helper_rfm(tcg_env);
-- 
2.51.0


