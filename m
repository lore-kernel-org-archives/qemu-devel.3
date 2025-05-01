Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F85CC3ABA9
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 06:27:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uANLa-0005S9-8M; Thu, 01 May 2025 02:24:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uANL3-0005BQ-Ar
 for qemu-devel@nongnu.org; Thu, 01 May 2025 02:24:08 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uANL1-00076k-GI
 for qemu-devel@nongnu.org; Thu, 01 May 2025 02:24:05 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7376dd56f8fso874709b3a.2
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 23:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746080641; x=1746685441; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k54PyA3qe+UbX4AzHMockqDzIGWdHV1GUXIbKPo2M9I=;
 b=TVMhRki/H9prJv4KxBY71Cp1a5Ku+xOacaWhB258ahHREPhicNrOqOFWlkXEWBjbbX
 ursIi0Bv3aGIJpKYkbuNU8vKkY1izZ9+rE+FaZ1oDBRS7sQvHeqXnc+0HmQDLzJ8EZbw
 mEnNdF0CnljySFNQ7UZ6As0cd3xeKYdm7f1NBc1iccZIXAfv6ICOGbpu3Eg3sytdnDEp
 WEzHhF2pu+rB3GFuHnt+44uwVig0FW5L5oWBYRH0kzOAnJQgf+X3YOzc55iTw5FTvhbd
 fJYtFBHvzsr7KSdMbRjwjpwIk/CGfaWC1AAJQBib5NE5StS4/dr+xWU9f06JwtwiyH39
 7nXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746080641; x=1746685441;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k54PyA3qe+UbX4AzHMockqDzIGWdHV1GUXIbKPo2M9I=;
 b=C7hxiOk4M50Kq1zHFQkA+LNLwl1TYlnU1aD0txgGSVYvn6UJZhYsGQDTfcqKR1/CVI
 7eLoGzalHjdgDZK3BDLwRqpZZovEQu5utjxQuta/T/IjSYuZzrQo3xKS6/1TNuIk2ySC
 qsgGsNg4bpGxdsbXGHLxjWyFsbsOO/pdJ2amh/FdJSQliCh0AVVHvGBmJ8llX3mqADhE
 +UvXqWRMQkwNwEKLQxDobXCkXMHtewQi46S3NjZP3FFIlyYgHbG0oK74EGT2YWEpyvZe
 pUJcWP6tdhuDMffE8rR1XNAKsTdy5dRg7zF5PHcES3CkrfH1db+SNVmC9x/QCHVzr6Cj
 n+ng==
X-Gm-Message-State: AOJu0YzDcQc19ML4LtJk/MuYSyuqZwXopowqCtxDf2q7X+qs6ILM8hRh
 b75Dw2rEbHQA5fbitMj5hGAf8WWbfusDiNjhxWjL5FbZ7Te/8jCkCTmn2R7r9iozJLiToypNJ/7
 j
X-Gm-Gg: ASbGnctdcIH5xX/Eez+rog5G1WeJ7Y6mUG8EN3gutSjR8iLpXJ+d5IqSkB3vOGD1ofU
 ROGG1gtwoGAU/dlODIKK9a+hxEHiXrRYud2OI9o9BlzOzveFEAp4Dvpbuxu+19mSBjtRfblkrMC
 sZO2Dr+Z3jkaTFQIdOfxk4VezYzWS8KjUL/ZNkzQMvBsFoXlGoFRX6MNFx5/bjsYKJP65AiIREK
 GNU40QMXD016hd+SegaUGJRR2Cd4h0x1sq7JOb1NNPOVOLRoDWr91kRkuBjKLkT9F/Up2IZUtop
 AXVnFXP9mhI9TFe5qUT0ihiL9DlWVkwbK3PPymEU/T2sky+j3ls=
X-Google-Smtp-Source: AGHT+IGGqIMGeAE500q1l86u/9Td5IJIvn3/wPWzMJrXJrwn66g+j5DSrcvsYCEO1nuQYpFIbL1HYQ==
X-Received: by 2002:a05:6a00:6113:b0:73e:30dc:bb9b with SMTP id
 d2e1a72fcca58-7404775ccaemr2024449b3a.2.1746080641210; 
 Wed, 30 Apr 2025 23:24:01 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7404f9fed21sm108134b3a.93.2025.04.30.23.24.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 23:24:00 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 11/33] target/arm/cpu: compile file twice (user,
 system) only
Date: Wed, 30 Apr 2025 23:23:22 -0700
Message-ID: <20250501062344.2526061-12-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
References: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42d.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/meson.build | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index c39ddc4427b..89e305eb56a 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -1,6 +1,6 @@
 arm_ss = ss.source_set()
+arm_common_ss = ss.source_set()
 arm_ss.add(files(
-  'cpu.c',
   'debug_helper.c',
   'gdbstub.c',
   'helper.c',
@@ -20,6 +20,7 @@ arm_ss.add(when: 'TARGET_AARCH64',
 )
 
 arm_system_ss = ss.source_set()
+arm_common_system_ss = ss.source_set()
 arm_system_ss.add(files(
   'arch_dump.c',
   'arm-powerctl.c',
@@ -30,6 +31,9 @@ arm_system_ss.add(files(
 ))
 
 arm_user_ss = ss.source_set()
+arm_user_ss.add(files('cpu.c'))
+
+arm_common_system_ss.add(files('cpu.c'), capstone)
 
 subdir('hvf')
 
@@ -42,3 +46,5 @@ endif
 target_arch += {'arm': arm_ss}
 target_system_arch += {'arm': arm_system_ss}
 target_user_arch += {'arm': arm_user_ss}
+target_common_arch += {'arm': arm_common_ss}
+target_common_system_arch += {'arm': arm_common_system_ss}
-- 
2.47.2


