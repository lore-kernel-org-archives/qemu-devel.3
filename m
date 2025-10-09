Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6155CCD183
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 08:23:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6lsA-0005Ce-TE; Thu, 09 Oct 2025 04:19:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6ls9-0005Bc-6r
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 04:19:37 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6ls1-00087F-7Z
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 04:19:36 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-46e326e4e99so8658795e9.1
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 01:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759997964; x=1760602764; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=knvguah2ZAbHfJrAqmZJIL4yzYXBkMBaXmxd3HfsAM4=;
 b=CK3mCXrXLwf/snG0Dk5tEg0lO7FUb3jcPYN7FR9BcH/Oi3NRmWnCI5U5YlGKk5r3d1
 fNd/iyIpgdqsM0YNsaJ72ZhRPfc92RqfRJ12MrV6SoarHMay5bgfXZgY6QxB7igHqDvP
 wRFdLAysFua616uk+chttVEtVCW2b4rBWNtEuJ8CoM16r5VsF/NaumzZjKAikxwFUAHv
 zhtLLYH5Ym+gMdUZ5/2TaAEAmF4/OcDGOhSqywupLKi+erOyTePagUzEXQX6GgQaetqN
 GyHEG1XN12wDtlIlBhMsrbyhcHpHO63dbaZKakkTmPsd4GZ3C+9kQC6PUJjpPuHlUkWo
 pfvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759997964; x=1760602764;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=knvguah2ZAbHfJrAqmZJIL4yzYXBkMBaXmxd3HfsAM4=;
 b=gROxWWRiGpbnzbEpMUDQi5Fosb+WKOhBR9V04vfmyjESJ5ubjB5+miNKkbFhO/1ZJP
 ruB+9ZVGVq+k4cpKhZj2RRzsMu426Jztq3Ec6IvZVpbmeRE5R7TlU9cF8FknSbpOihhO
 r4B7NPxV/nKj6kuUXMLDnIuztCodWMy5d1to6mT4XYixeCBEj+/CLeAlFb8gJyEKm6rE
 ivRxzQ+b++QJdYikdwtboL04o3t53Ke9ghBoPC0jQnWJwkXivKhBhmIFVLw/jzzkapJC
 251avnH+RMWcUxtfJbgh7xjPxSa81r6pp70WzLewUQ0jj1nWl82DiVuXezleMrw8iMEu
 Ymdg==
X-Gm-Message-State: AOJu0YwoWHvZWauMEsOOadVHiYn8Mu7VoIOVSEbEKk5ca0UqCJRo/O2W
 nQJxi/aohLkQ2vqpoX2Q05vmEq9QDvs8/RxMRo0vDgbVnCbTV5uhN63SbAoWNwN5fOwkieRMdLm
 lI3B47P+5lg==
X-Gm-Gg: ASbGncvxTlVnU/7oQD9bF4JeieH1OAnxS12clAwpUr4g1SYpQlgo/jU/0oztNgox8eP
 f+LhEOAJ0BgQw34PqoaoKe8zQo2jihmuyspD/O1pcvV0L1KmgJFLLJ7MH001eOxjMpS3hoSM4I2
 kL5Q4Gt91UdpB9fZnqhWIqtBxcIO7RoedShCt9fQbtX/49LCwMGDXBeMIdLIR/huwzFX79BalU/
 IE1QPRIhfr/QtnaaAqeoBmIw6RykcCAjyZ1OI7DOzUNsPhAwLLZP+jj5DpHlYn7qXXloNv9RJ9F
 sAsD1uWrkhEBD9eWSlbhl8KVioWWIn8x8oVAOvmRLzXQCl2m9mx25home6NVxsV9UM2H1bE2tAX
 +8NH+VUYVrL7k8v8ERpyIYdnUfR4kWMH/bczF46MpsiE8dS1ctdNiq/b4XRcvBuCL1G495h96M6
 AiQZ6qBs8FWT+s7Up30pRmW9vGfO09ETtIKR4=
X-Google-Smtp-Source: AGHT+IH9Pf/z5KO+V2BV7aZlRyvjcOhi/nHqDrXKj+OA6p9Tv3wmv1r3rYf8mhK9XdyHhBBkW7FsgA==
X-Received: by 2002:a5d:5d11:0:b0:3ec:dd27:dfa3 with SMTP id
 ffacd0b85a97d-4266e7cf083mr4495810f8f.25.1759997963785; 
 Thu, 09 Oct 2025 01:19:23 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8a6e1bsm33884776f8f.8.2025.10.09.01.19.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 01:19:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Stafford Horne <shorne@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 04/10] target/openrisc: Do not use target_ulong for @mr in
 MTSPR helper
Date: Thu,  9 Oct 2025 10:18:56 +0200
Message-ID: <20251009081903.13426-5-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009081903.13426-1-philmd@linaro.org>
References: <20251009081903.13426-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

OpenRISCTLBEntry::@mr field is a uint32_t type since its
introduction in commit 726fe045720 ("target-or32: Add MMU support").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
---
 target/openrisc/sys_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
index b091a9c6685..ad59939db3b 100644
--- a/target/openrisc/sys_helper.c
+++ b/target/openrisc/sys_helper.c
@@ -45,7 +45,7 @@ void HELPER(mtspr)(CPUOpenRISCState *env, target_ulong spr, target_ulong rb)
     OpenRISCCPU *cpu = env_archcpu(env);
 #ifndef CONFIG_USER_ONLY
     CPUState *cs = env_cpu(env);
-    target_ulong mr;
+    uint32_t mr;
     int idx;
 #endif
 
-- 
2.51.0


