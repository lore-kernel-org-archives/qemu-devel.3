Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F3BDD6E2AE
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 22:15:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWMHW-0001Y2-Ko; Thu, 18 Dec 2025 17:15:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWMHT-0001Xf-18
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 17:15:31 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWMHQ-0006tw-HO
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 17:15:30 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-47755de027eso7031185e9.0
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 14:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766096126; x=1766700926; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FC2VnuRoT3Be3yx27aWW594etoCauJGuy9gbMRT7b30=;
 b=QMijpWo2iBa39rV7fkXZeCG71Pr0/27kHHaBKQJH6f+K+W4hh2YR/n09VEbO8RANb0
 zPCjN2hrbVH+ucecYRe7W8O9vh6hWFixeAtT6BRydAZ6aUURL1iHi0noUomuz/Cd1Lq6
 CKXd2Kvj9tVMI0MpNoX4OSGiKW9faJyQnPoI05FvifM40YQ90HGdaiafNnTu2mG9zYtN
 wg0i5z4TVps4Oh6Uu93bWGn3H91H8PD08Tq4HrLSLdf33gkrby7JJAuv/JktaakO1iat
 DYtRrbaq7NqQ40NQnBqiRIIXUD/y5NZOnjf9EFfkNL88rXbWlCJuXwCFTzN38Up3iRIL
 fbvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766096126; x=1766700926;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FC2VnuRoT3Be3yx27aWW594etoCauJGuy9gbMRT7b30=;
 b=lLPSn1tP1XDSlViEGs/Hsd4xpiSWIvtXDZdMXuskiYxVEEy3BUAF+bNyf2jl0u1Mtk
 3RyJWFCVm7fG7UsEIkU6uJnsqRy7fv46jo14fPXfmi1WtqytrOhBN+d0vzvDxfFl64IS
 c9qrBAdM4i7wfzVsMAbMBxAq4naHfJECotdE3vafSxru+WmaKu/LEYLnxR3nxYh2OoZ9
 n0D8SWsKHwX3rbmWALRvbYCgO325/49jOjFpFTbWLvJE4JZFtcJyhO2ZQ8gdgI/WomHQ
 5pjDTgKAkx1/np7PKMe8iqLeuvl6b0GqBzE8GBJgZmBqZGP5l36j/dOLLSZPV2ARGEIp
 IUfw==
X-Gm-Message-State: AOJu0Yw0Htbyf+W19d/55vbIx5RoTfU59pX1RYqFaNgGXAkZM+6aQCtT
 +dOdOHsXQZGwjLnsSueRtUdFlJI/dsklwXC4g/CbxtsG0BT8yMTGcqhook+GWWqPjWHbXTv40wB
 khozQM2U=
X-Gm-Gg: AY/fxX4b/dra5epSxJBiA7XNk//M+2hQlNcGP3FzQfCUdFctnFM1Muyg0pENfMwHyYF
 wS2Erv8CLcOeePAFj6B5dBa6TuqNxVYgv6dVwAd4AXglKxPG3SFjM+6v+dOErI6zTyRZybfKkk9
 pcA3AvpTFl4SsxQDT61mNn4jcbmNGArVSV9QjcAsnHI5z2uIlz/GqcjEbtyhyXxcmh3UvVjK2Gv
 AvP4erAklRMQ9oJUOXm6HXhCfOz/Io/6VogwMdYTOOOaSGdefvSJNlalJLRrvU63Ear8+KXNG7/
 wskAV/EZh5LH7aXQNuQZ+tLlboAd7BrtswZCYB5fbFsnYEQjMxb46cxuqxDw7BoYK9R1dme00Kf
 CEyBwcrbptsgq0jc1tZT3c0oUVpAIh4gukUW1dlO5eoqTc5a360Y9P8QAS9loUMW9h7mPSv/9ld
 Xd8GcF1m61cm8OoxP3c9hgFIC/kwIARUxF9iVAwK3OpKb1caZN4P2IIVoQrgyt
X-Google-Smtp-Source: AGHT+IFeYgb4/uRYNtR2R7RTRiH0HSu1AVsPLPRXFhwq0wrQ4R3G2VuikuF6pUb3BTNqqv6XDRJbNA==
X-Received: by 2002:a05:600c:3495:b0:45b:7d77:b592 with SMTP id
 5b1f17b1804b1-47d1954a15amr5359715e9.12.1766096126229; 
 Thu, 18 Dec 2025 14:15:26 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be27b28a7sm64278165e9.12.2025.12.18.14.15.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Dec 2025 14:15:24 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/6] target/sparc: Inline translator_ldl()
Date: Thu, 18 Dec 2025 23:14:54 +0100
Message-ID: <20251218221457.73341-4-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251218221457.73341-1-philmd@linaro.org>
References: <20251218221457.73341-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

translator_ldl() is defined in "exec/translator.h" as:

  198 static inline uint32_t
  199 translator_ldl(CPUArchState *env, DisasContextBase *db, vaddr pc)
  200 {
  201     return translator_ldl_end(env, db, pc, MO_TE);
  202 }

Directly use the inlined form, expanding MO_TE -> MO_BE
since we only build the SPARC targets as big-endian.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sparc/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index d6b599b71fe..1a7e5cc3d73 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -5743,7 +5743,7 @@ static void sparc_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
     DisasContext *dc = container_of(dcbase, DisasContext, base);
     unsigned int insn;
 
-    insn = translator_ldl(cpu_env(cs), &dc->base, dc->pc);
+    insn = translator_ldl_end(cpu_env(cs), &dc->base, dc->pc, MO_BE);
     dc->base.pc_next += 4;
 
     if (!decode(dc, insn)) {
-- 
2.52.0


