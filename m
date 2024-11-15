Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFBF1D68BC6
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 15:21:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBy8H-0001nx-KC; Fri, 15 Nov 2024 10:21:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBy8F-0001nm-Lv
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 10:21:11 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBy8D-00044J-Hi
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 10:21:11 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4314f38d274so20707455e9.1
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 07:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731684066; x=1732288866; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GRasMU/kl6pU0nKOnvS8/V9PVLoGYuKbLYq4L4yKpFo=;
 b=imh5T0mcRvm6fKylrnHKff4C7xlbk7SdFcLkuqqGjSfrUrtGrhuJhMgErU58bJV8TT
 2Y/+L3cfVDIw9jbmZqkljnpcBYFCQKI2F/bvHMurwSeV3lQOY8xw54AmuTrMaatrHy2U
 kZh+PcjYEy1F2112aoSzaAupRGKYP0ASi0ddgpYKaus/ia0He/sZqaHcLDQNiHadfKHH
 n6ygmaVSg9V7oAahQXfk5szx/SrPPTwEJhRluL4uYuDGa8da90VVmD76aZWYV5SZ/Ve2
 TBXT6kCA23HPDATIeMhSCeq4xilD8zjeFAev+Bg2SqGHRyfJj9F820yy0xtfc+3m3Emq
 uh0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731684066; x=1732288866;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GRasMU/kl6pU0nKOnvS8/V9PVLoGYuKbLYq4L4yKpFo=;
 b=duNP7PDreVE/CQDhYUtQGUMDxPDndOdELV6xiuAa39+sdRg9pByvPfin19TubYqX1g
 u1eI3xTnEfqtbvX5aikV0iWQnARSKsLCKT3885EEHlPQ2qZLQy3jH4gQi81oDXOP9qpw
 0p062lvOqX0bNxcuUICNLP+3rnyYJPdGSE51vCoiF83LcKsgNx9KLM1oCWqdpTHefRiB
 sjP+NupBLNfHnzTlituGJJsVk8p6zxpTrK3BIOaa4teryHifS2z8J6aN9zHQWKWSP8qI
 RyJ6MhR5u8UVfI/1s1YxEx5YhrGyMMp2EMttwsAc8CObfoB89rPva7M93bqFfvC2LCKL
 V3sw==
X-Gm-Message-State: AOJu0YyU5IqbEQ7QP7Lzuc8o51oTo8ELVwQNVD+9NUflmmT9uvVyrtPU
 Lkgf6x6ihMe1pBTLuaUwqNBcEdOYIo4eCn8PLWQU3wcTLFX1fJAFfW1W1Zr063XnfA4kaEoN3Sg
 o
X-Google-Smtp-Source: AGHT+IHW0KR5WTaGL0p1XuyzuwgZiuu6fe6xjPHY63DvbhB+M1bhjA8sloCdYDCDRG4tHaIYISzglg==
X-Received: by 2002:a05:600c:4e8d:b0:432:bb4d:cd77 with SMTP id
 5b1f17b1804b1-432df74fda2mr30187755e9.19.1731684065835; 
 Fri, 15 Nov 2024 07:21:05 -0800 (PST)
Received: from localhost.localdomain ([176.187.214.209])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3821ae2f651sm4785315f8f.87.2024.11.15.07.21.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 15 Nov 2024 07:21:05 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 02/10] target/loongarch: Declare loongarch_cpu_dump_state()
 locally
Date: Fri, 15 Nov 2024 16:20:45 +0100
Message-ID: <20241115152053.66442-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241115152053.66442-1-philmd@linaro.org>
References: <20241115152053.66442-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

loongarch_cpu_dump_state() is not used outside of cpu.c,
no need to expose its prototype.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/loongarch/internals.h | 2 --
 target/loongarch/cpu.c       | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/loongarch/internals.h b/target/loongarch/internals.h
index 1a02427627..0655ac948b 100644
--- a/target/loongarch/internals.h
+++ b/target/loongarch/internals.h
@@ -18,8 +18,6 @@
 
 void loongarch_translate_init(void);
 
-void loongarch_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
-
 void G_NORETURN do_raise_exception(CPULoongArchState *env,
                                    uint32_t exception,
                                    uintptr_t pc);
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 57cc4f314b..e599beb30a 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -742,7 +742,7 @@ static ObjectClass *loongarch_cpu_class_by_name(const char *cpu_model)
     return oc;
 }
 
-void loongarch_cpu_dump_state(CPUState *cs, FILE *f, int flags)
+static void loongarch_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
     CPULoongArchState *env = cpu_env(cs);
     int i;
-- 
2.45.2


