Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC90FE77188
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2024 15:26:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSHeP-0002gU-Iq; Mon, 30 Dec 2024 10:25:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSHeO-0002gE-Ac
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 10:25:48 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSHeM-0001mJ-Pj
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 10:25:48 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-385de9f789cso7008127f8f.2
 for <qemu-devel@nongnu.org>; Mon, 30 Dec 2024 07:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735572345; x=1736177145; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+fA5or/bmCnhWrsP/slJI6ViiWLeMfeymomX0gA+oig=;
 b=dbEnYA88SwY4gIOEfiYaPos89A7Ai5fYE8RRpIoxOlWrKXRUCC9BXKeFb6N9Ym3EkM
 /39NrVWHqDYmb1xsmN16wX2OEl3RH30A/lw2xrIlb3K+fmwydY7NAD7Lm4pj/L7tWpPc
 aNmDgxHUpTZkDMbmuz6pItXJ4a10xNdWuLYyGKO41hSGCYZEmM4/+DqRRwfLj9h6rSbX
 oMxEmZ6C3+MkT39vpn98Wq0wYpKXm2QeGXQe8+QZL2JDolVbJnKn127YQv41JOfSWVC8
 4aoVdJxEz7wrYQBBlMjz/ScbKP8J//TmgeR8dIYMXRB0EAryTALQ6kykxBu0m2XlSvRr
 sFnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735572345; x=1736177145;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+fA5or/bmCnhWrsP/slJI6ViiWLeMfeymomX0gA+oig=;
 b=KUUQ6ktTIW0eHCoQAjuikHdmCCEhW+x5ydkdD0xnJatZXhESy0awnHrtJvIxXuorA4
 c4kCHHRwrMvdAXcocktFpqQnwAc3WUDIHkEdrtLeUlJQ/gXEymrXd6k7U+/F5jG6gT5i
 U0NqV2oTDoPE7ZBTaMj1w209EpU8QOY1IZz10p+S27MI+rYxy2x9uVIyr3DnoxMNzmK/
 5NpXcHU6JNI3EgrEfEHw7sXWy6WuhgQCO2Z+Ce2c048qZRjMy6lPzPyLAsQdwQKhfI8k
 hULQQBjLs8CHOKrUZuRKarsEPiViUWNQd/ioVcaCU8v81P5xdK4ht001NZTUxUYiM6qy
 hLCA==
X-Gm-Message-State: AOJu0YxbXlqYLKsroSnGmCThx2CO9cyJumzwmf6AS+iVbQIKwHhazEad
 uBoudpniSW8bFVw5lnkZRE1FCpNFANsDTmZJr9hx/NhrHfYTDzX/Uo1dBydKoZllo+MpxioRkUV
 l
X-Gm-Gg: ASbGnctm/2yzV9EeZAfvYnq+z4jL+kzoySYGO+t2jV+HP9qeZQmHBW0JIwReGBAmCiQ
 KfOGwfO75QoIkEofF0wcRN+DOuIi0oqGL5WR90ScWt1s1qK12maVLenfe+PpnJFAfr3S/5YPC1g
 QdmQfnrHSL2c+qsUHjTXsRGmxR4jESK0xaZVyc8KJLoiEla6lg5d5SXvboYF/h1D8kKKFw+WUuW
 RH7+e0jLe9JMbtX+1iempYFkDrrILH9mIzsqzLf0MTbKZy5WffzCCzPEVjeK2+ambavsCL5dEZB
 W9jvCerYmRG7o1J4OV49iyGVmHn/DAY=
X-Google-Smtp-Source: AGHT+IEWPX06gFkgWicr2nFcPuD1dTE3BoJPCJ7tWyVuRYfY2RU/YEx8p/mM5kRbZLG8jbfgqOaqYQ==
X-Received: by 2002:a5d:47af:0:b0:385:f10a:335 with SMTP id
 ffacd0b85a97d-38a221face5mr28963025f8f.21.1735572344829; 
 Mon, 30 Dec 2024 07:25:44 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b119b6sm395923675e9.22.2024.12.30.07.25.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 30 Dec 2024 07:25:44 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 5/5] target/hppa: Speed up hppa_is_pa20()
Date: Mon, 30 Dec 2024 16:25:19 +0100
Message-ID: <20241230152519.86291-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241230152519.86291-1-philmd@linaro.org>
References: <20241230152519.86291-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

From: Helge Deller <deller@gmx.de>

Although the hppa_is_pa20() helper is costly due to string comparisons
in object_dynamic_cast(), it is called quite often during memory lookups
and at each start of a block of instruction translations.
Speed hppa_is_pa20() up by calling object_dynamic_cast() only once at
CPU creation and store the result in the is_pa20 of struct CPUArchState.

Signed-off-by: Helge Deller <deller@gmx.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
[PMD: Have hppa_is_pa20() take a const argument]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/hppa/cpu.h | 6 ++++--
 target/hppa/cpu.c | 2 ++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index c1d69c1a835..083d4f5a56a 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -266,6 +266,8 @@ typedef struct CPUArchState {
 
     /* Fields up to this point are cleared by a CPU reset */
     struct {} end_reset_fields;
+
+    bool is_pa20;
 } CPUHPPAState;
 
 /**
@@ -297,9 +299,9 @@ struct HPPACPUClass {
 
 #include "exec/cpu-all.h"
 
-static inline bool hppa_is_pa20(CPUHPPAState *env)
+static inline bool hppa_is_pa20(const CPUHPPAState *env)
 {
-    return object_dynamic_cast(OBJECT(env_cpu(env)), TYPE_HPPA64_CPU) != NULL;
+    return env->is_pa20;
 }
 
 static inline int HPPA_BTLB_ENTRIES(CPUHPPAState *env)
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 7278b7ca6b5..6e5434a8e99 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -209,6 +209,8 @@ static void hppa_cpu_reset_hold(Object *obj, ResetType type)
 
     memset(env, 0, offsetof(CPUHPPAState, end_reset_fields));
 
+    env->is_pa20 = !!object_dynamic_cast(obj, TYPE_HPPA64_CPU);
+
     cpu_hppa_loaded_fr0(env);
     cpu_hppa_put_psw(env, PSW_M);
 }
-- 
2.47.1


