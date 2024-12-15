Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E889DE7716A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 19:13:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMtw8-0001EI-9f; Sun, 15 Dec 2024 14:05:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtw4-0001CP-Sf
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:05:49 -0500
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtw3-0000xO-Ar
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:05:48 -0500
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-29fcbf3d709so1107356fac.2
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 11:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734289545; x=1734894345; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DoZpJRY8pbU5IfeBuTJpEfz/DDHq0VOQk4NYh61lHhM=;
 b=cFpCw5NuEM8bFoMpGp/VjwdQmB8vI1ykeyzlBbp0D1VQHqJiZXJTKzeEFZgm1u0dZR
 BNHLaH0aq23nE5o+HO3gIIcQidryhW1vxcf4pC5bQp5dzstHiWlmA/A9vsv6Suw+s63S
 RwMBZPptX9cMr5fdzKrXAQpWYHqdV+xOz+lBEeIG+V1wrPvYbICE4aSwilQiTynhDorf
 L0WIOvPbrBBWjYE1Is4Fd/O6cIEb+lVntt7k4H/mBx0VYs5sTAhzs9Nzr8DdKsG1g5Fh
 RND8s9GwF+rX8RCQgdIfPKybRTqxd+3m4EAyNoGRriaRnvyrfKtbrIhhnqksuBeb/9k8
 otjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734289545; x=1734894345;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DoZpJRY8pbU5IfeBuTJpEfz/DDHq0VOQk4NYh61lHhM=;
 b=MRgYuepaRdmexquBij8vJSSijw5/fa6bU7QLXw+YHyZT9+oaD+3/XGcwkz8URBFKQO
 fpHuWTpU61pLsZRc5JimXQPbKmrAI9JPyVH6cXT+h8mgfDMtWr3qv+GSDeqFK1mTAjlg
 5uKQ+H7wBmDQe0cKAnHUxDWokrf0QAa+m/WV3UZeWcx3ZS7z1tBbrJD/ey621gkRhAB0
 jqAFt4oOxN0fffiHNK8Mmd+CWFU0XM8xIyKcv5EUiGC7Lmc2dzwMbpw1TuDbJ1USOG5B
 Iu4V9A30esatnEEbQJs5sRnWPQr6EiKHL5X+ar7cf5pPjaGuQ8cXR1fkgHfZ9jhnb82t
 L/7g==
X-Gm-Message-State: AOJu0YwOyGwmhA/6Ff1dwA7B1PxAD3CDbvB2M7Dgmy8OfK0tMe/ov6xm
 DOQSIEl6LyZ6wW6qpcyuLojM+a2eNUTb8Qo0vGcayawf1hO0HESHOJs2SpDyFsbiHi8VIXrK52u
 PquaVQtxR
X-Gm-Gg: ASbGncsqaTK0qGiP2DIlcUDY0gBcc4qQSnuTKO+0vajablpcGqjv986UrJfe7MS4CmO
 ihYQN52TOkGN7s8EkBB8GmZ+6ro+eh83fhoyeBcmBtwRehHyDTs4lE7kblV4xYwNlDxHw9H8lt2
 YtMb6gP+7mH59TSMyjnXxluCEPP1m/+zHpOcp0QtGbM+/Fsp7tSubw4+fIHR7CPe3ZoTih1BsWN
 xzWD/h7390PodQMzNYawutl0UFqlSpSCdcEprhcFXqyHr22vZ8EeP1DDEIM9nysJO52d2yKtqbW
 KQDlpD5YE5NRGxnG9RbBw1pRPD51N19psN015DUABPA=
X-Google-Smtp-Source: AGHT+IGA/sXC7xonQVHKP+lKV+kk00JxUDMMPIi8mhT3OOsoUJ9ngZC9bCGCNqOKo0aq2tBIHJVQWw==
X-Received: by 2002:a05:6870:2c90:b0:29f:d0bb:618e with SMTP id
 586e51a60fabf-2a3ac6dcd39mr5785024fac.25.1734289545061; 
 Sun, 15 Dec 2024 11:05:45 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2a3d2914ac6sm1423214fac.39.2024.12.15.11.05.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 11:05:44 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PULL 03/67] target/hexagon: Constify all Property
Date: Sun, 15 Dec 2024 13:04:29 -0600
Message-ID: <20241215190533.3222854-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241215190533.3222854-1-richard.henderson@linaro.org>
References: <20241215190533.3222854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::33;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x33.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hexagon/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index c9aa9408ec..a70007245e 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -48,7 +48,7 @@ static ObjectClass *hexagon_cpu_class_by_name(const char *cpu_model)
     return oc;
 }
 
-static Property hexagon_cpu_properties[] = {
+static const Property hexagon_cpu_properties[] = {
     DEFINE_PROP_BOOL("lldb-compat", HexagonCPU, lldb_compat, false),
     DEFINE_PROP_UNSIGNED("lldb-stack-adjust", HexagonCPU, lldb_stack_adjust, 0,
                          qdev_prop_uint32, target_ulong),
-- 
2.43.0


