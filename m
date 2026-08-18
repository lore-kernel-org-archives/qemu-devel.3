Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC840C5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:05:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwNCW-0007Pi-M4; Tue, 18 Aug 2026 13:02:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwNCU-0007Oe-8E
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:02:10 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwNCS-0004gC-QJ
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:02:09 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-84e84a6c4bfso1388054b3a.1
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 10:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787072527; x=1787677327; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=z0O2HTR3sNOKW6M0XOX2OWkfkppjEUkdIUvOoj0R6vo=;
 b=eRo1KnhF5CpYxJff81M/GzvmZE5Zbhpx9Ctf0FxeU5RwzoDvbOEJnhZK28hEpUw379
 ejMJwMKSoNnq45dnJJn4uaj+D271BZ/Dmzu3mjErP3if59b4sGLmSPND1u7kWx9vYEKn
 ZlNSV2IFJ+gp99CUrr+67zNMt6++RafokEw0pNcJse1I8LHJLbgJwQFTbR8YqBDzHCpR
 yxZbzozPRkMSo8Fe/w+rGE2NWd2NSY919i4iZf5BPk8NRwdUhP8qJmSbkUIyPfhicQf3
 Pv8jindlDlyDn+ttIhpzLUUAL1D8Z+pRmRS4KAOStOvHK5Lim1M+9GVpWrcU1tG4UC5h
 uMDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787072527; x=1787677327;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=z0O2HTR3sNOKW6M0XOX2OWkfkppjEUkdIUvOoj0R6vo=;
 b=rFjmuxze9rlV5AyeY6VUITF3ID3/aZP2OmwCrq7umKo2lGsFGWcd6p9GcI9AiuP40j
 ug6iK7nBdPYIq56djSzMlHfTL+yGRpL8M6qRohI1GQZGu8OaCB8JWCndu4D6+uto8nWF
 H1t7EwAX/aQSpMHbZfFSAQBUuwj+BsZjV0C0sc0KKv9QqjXnc4uOdz01ofZYVVoiTTg3
 L6BxFiSrzKSNcZNhX7rsDPq61xDQo1k7dYpuorwqflB6Eh1vjAJ2ZGZt4wupoVloFWWj
 O1d9IZtr6QWWuaoC8one1tNN2NLsebpm2FnaPcAy4uavTsDk2bfnzcFw9l9J/n7HKYyr
 U/7w==
X-Gm-Message-State: AOJu0YwscM+59gbTmp9ols/F0ZVURN5WnutayaetwcwxVa6qkDnCib1S
 6REPl11U4U+woL5k44Drd1HLtPBoKPAbRWsDMgYE7gG7A2chyoqm9IgI2R/ZM/MzYe1eWAems9w
 HLJnVYRE=
X-Gm-Gg: AR+sD10PIm4MUwyxOAEJP3KrF5V2s4D2pD/vdvHUZyWd/gBYpUVDfAUS+MePuG7Dr3O
 ZpRElT0WK9xV6rUjOvcPKn4dcB7R6Vh5Is0FqN3WqrsSi99QEDiNS6U0Jgu0ZxMwY6TJOEl7FsU
 +rG+JuvbSOPvlOyFUxzeFkx6M7c6iGk1jtZ3CS5FjVQTQ6Z5rfGg81my4NpIIGW99o/MWC49/HS
 Te6IV5CE/a+wkQiZwt+/YfoGuu4NugHs20c61esn7/Lcj5HbQbnlJ8JfW18SWPm0EZzyTWyFUo2
 EKLXCnbjUgbPnEbH9Lofz5LmOovLhfDKpNWxNdROnIdIkjxBhb/Ot2Fd7i1MpZF8aeUU+bWu7PF
 X/dHNanvVb3IDoFmZpaIwPN8UIGX7J/EHS5IXwm6JPjYUxd58I06zZ1T2EAKwGZIcXuYVfF0Vdc
 DSdtZlxDScNRMSM8fr3HGyNIvrFZ5MQGhEJoSb6VFHYx7cWtl31YpqoYxxZbb9GR/9XThua+jlk
 KJD3jlCVQzNiJEbs8Ox5tB62lbca6MZf5Q=
X-Received: by 2002:a05:6a00:2314:b0:84f:df11:b78e with SMTP id
 d2e1a72fcca58-851bc2351d9mr7237295b3a.2.1787072526962; 
 Tue, 18 Aug 2026 10:02:06 -0700 (PDT)
Received: from stoup.. (c-73-181-156-132.hsd1.wa.comcast.net. [73.181.156.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851b401e10bsm2108314b3a.12.2026.08.18.10.02.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 10:02:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 07/38] tcg: Fix opcode dump for bswap
Date: Tue, 18 Aug 2026 10:01:24 -0700
Message-ID: <20260818170155.1907006-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818170155.1907006-1-richard.henderson@linaro.org>
References: <20260818170155.1907006-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

We use an array of char for bswap_flag_name, so some
entries in the array are non-null but empty.  Check that.

Fixes: 587195bd590 ("tcg: Add flags argument to bswap opcodes")
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index db43589fa2..937d0c8fd7 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2957,7 +2957,7 @@ void tcg_dump_ops(TCGContext *s, FILE *f, bool have_prefs)
                     if (flags < ARRAY_SIZE(bswap_flag_name)) {
                         name = bswap_flag_name[flags];
                     }
-                    if (name) {
+                    if (name && name[0]) {
                         col += ne_fprintf(f, ",%s", name);
                     } else {
                         col += ne_fprintf(f, ",$0x%" TCG_PRIlx, flags);
-- 
2.43.0


