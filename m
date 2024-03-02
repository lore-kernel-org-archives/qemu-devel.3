Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44EDAC54E41
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Mar 2024 05:21:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgHk3-00031D-4A; Sat, 02 Mar 2024 00:16:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgHk0-00030L-Mv
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 00:16:56 -0500
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgHjz-0007b2-9F
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 00:16:56 -0500
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-5dbd519bde6so2425157a12.1
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 21:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709356614; x=1709961414; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/AMTS8IZGBJLGJhh9QFN8+rJCfUK9CllRktS73q6w48=;
 b=pt44AzfaNElo6zflAE2c5gCb++x9xYsbn8IIDtkNlSibvPK8FMEFrHtSDzW+/+nEQX
 On8KFuZbSUzVVqIBbuG+gmbYklTiF7qHuflnkctpKmE+KoKvGTvPO5hOqOnLB0rOAH1K
 Y1yIjyZ1Ehn30unkMpDyd7tx1K5IBOPY/ebc6TfdCkXbZ7de/VYya5yE30dmMr+8pjkt
 jEI6ExUwDZetK3aoRkO6ZXXWMuBpzFByt2+krWeClerE79N+mjF+OKV9G3JPNfM+Q9wm
 h+fXmHnCILR7vmx2u6kyD2HU3YLnaWNnzBZsBQ5+cmLtFKVw5ODzJzEhqzefFXNxqt7M
 jcWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709356614; x=1709961414;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/AMTS8IZGBJLGJhh9QFN8+rJCfUK9CllRktS73q6w48=;
 b=xUhyx76TufV3lwV4sknw4z5ey6UwTNZQgqQTT94T20LL2+whfKTy+w2YyebuKv9KKW
 Mr133aG2VXCTQntvaM4vyy8r5fJbOyXyKpLgpulpEFwWGda+4PFZ4fGJKJnX2U7u+ph0
 Rb1fLVux8Cs9WaAIHUJzELW/eYvBxWSwuyjynNVsDtySeThTGe1IADrAxfljNCxfQTEW
 LCzMwwWeuO1tvBVnJiQJTfzGTaqZ/+a6aIMmdmDgyv7YI7fcW+zEexlwevyZ3/Fzx9Fm
 UzjZm7UI0Ju8YMlAkxJvdc25JuEo0SBtCom1Xnj7CYWLDlHM6J4P75NvErhfomGORNX8
 GXpw==
X-Gm-Message-State: AOJu0Yyy7UX2YFoWy+ym9H4LljnDU02tD5MgeZOxS92d0LN1WomV71Ft
 2jmBS+NlycPcGGweRW3+hjvYuG0/DB3TFYm16W8usctmSyLVOsqGhWH2oNw36E3HOhlnfs/fKdP
 d
X-Google-Smtp-Source: AGHT+IEff1LTVLXr2OFVHmlg59aNEQ26vo/auSc6lRZibVMXeUuWT/5SMuDGNoLv7nmBofDJ+tQZ5Q==
X-Received: by 2002:a05:6a20:3c8d:b0:19e:9c32:6073 with SMTP id
 b13-20020a056a203c8d00b0019e9c326073mr3958938pzj.12.1709356614105; 
 Fri, 01 Mar 2024 21:16:54 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 v8-20020a17090a458800b0029af67d4fd0sm4034901pjg.44.2024.03.01.21.16.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 21:16:53 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 31/41] target/sparc: Enable VIS3 feature bit
Date: Fri,  1 Mar 2024 19:15:51 -1000
Message-Id: <20240302051601.53649-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240302051601.53649-1-richard.henderson@linaro.org>
References: <20240302051601.53649-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 1 +
 target/sparc/cpu.c   | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 5ebf2bf789..89ce0f3167 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -998,6 +998,7 @@ static uint32_t get_elf_hwcap(void)
     r |= features & CPU_FEATURE_VIS1 ? HWCAP_SPARC_VIS : 0;
     r |= features & CPU_FEATURE_VIS2 ? HWCAP_SPARC_VIS2 : 0;
     r |= features & CPU_FEATURE_FMAF ? HWCAP_SPARC_FMAF : 0;
+    r |= features & CPU_FEATURE_VIS3 ? HWCAP_SPARC_VIS3 : 0;
 #endif
 
     return r;
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 491e627899..07d252a35b 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -552,6 +552,7 @@ static const char * const feature_name[] = {
     [CPU_FEATURE_BIT_VIS1] = "vis1",
     [CPU_FEATURE_BIT_VIS2] = "vis2",
     [CPU_FEATURE_BIT_FMAF] = "fmaf",
+    [CPU_FEATURE_BIT_VIS3] = "vis3",
 #else
     [CPU_FEATURE_BIT_MUL] = "mul",
     [CPU_FEATURE_BIT_DIV] = "div",
@@ -876,6 +877,8 @@ static Property sparc_cpu_properties[] = {
                     CPU_FEATURE_BIT_VIS2, false),
     DEFINE_PROP_BIT("fmaf",     SPARCCPU, env.def.features,
                     CPU_FEATURE_BIT_FMAF, false),
+    DEFINE_PROP_BIT("vis3",     SPARCCPU, env.def.features,
+                    CPU_FEATURE_BIT_VIS3, false),
 #else
     DEFINE_PROP_BIT("mul",      SPARCCPU, env.def.features,
                     CPU_FEATURE_BIT_MUL, false),
-- 
2.34.1


