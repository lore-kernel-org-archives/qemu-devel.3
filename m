Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8838C369D3
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:23:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kug-00005b-7c; Wed, 23 Apr 2025 20:58:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7ktN-0005ft-F9
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:56:42 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7ktL-00054Q-GA
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:56:41 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-736aa9d0f2aso524380b3a.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745456198; x=1746060998; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LfrM+ZFsKrY5Zrl+zb7ZsXPhOM4tj+2Yc0NhZX/EHbY=;
 b=Kw/NiHkGYBpsX4ErSi+a05xQO8gUB5TajRYIAJLHXGdlCAEbK5VGcw9CjXIZI8LA9+
 ENSR8MMIS9OeOdHeMWTu5wc+Y0Y/U6q8dbwXzC4oQT9MixLrPfqa8n3Cuy0stBVGKyZ4
 3PnA6j8du7vSevZ5QqLUERWfPJMEw2LBMFh2yt9JwRojKfIaRHr3fTf7JSfezSA/A5/r
 uCcV4sCGrm3KGloWunEJojkdoiX/xiPNBH0LhZeMMCea04mD5zU/qEasfJu1LFh3z7yu
 jXWyHFU6CXRLIHuNC7LJwZ/bkD6Psy9wNLEJTDocXar6E+3O7z7Ia+Ok0G5pxDypHFXB
 0SVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745456198; x=1746060998;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LfrM+ZFsKrY5Zrl+zb7ZsXPhOM4tj+2Yc0NhZX/EHbY=;
 b=IvP8wrtEgjHNj62o5UXN9ekQ367frusBGtNGKWeqtwMJZI2JJUEZ9AMNSZxq45L8dC
 FqcLl8bEPCekgkA1KLFTADAlxMC1PB9vIN0lKay68Sgtv3+hrlyASgFx+bmMHo+/06Vi
 Z9Tdo6CC0ee4KpL2AFfXx/zbLCsZtqjSykR5zwowI5iKRhemzYufwQHNwjKIioWBADGM
 QSuNnm86XnbWTXwN+lLYNIrKb06aO44ZkzS5PzQuOqOqcnjKyJz4u0/zNWf0w1AFwof8
 ZnwaJjYkCd1hDeerA7YpX7KkZpvyeM9kkgp8kOUUTjd9ldLQeMxXD+UcEsmvMDdaKuPv
 08LA==
X-Gm-Message-State: AOJu0YyrXF3ZLCZY7cFThVRmLUrCFCCKh+aXWZP2mnsOT7y+Q5MHVA3H
 eoF8qLOrfQHV6Zjt2ly4nqmphjOrdeEg+BSxYkIAmBmr2abx4BUJlF2gRe1ua1L9gD134feRlld
 2
X-Gm-Gg: ASbGncuHKgwMx05fx35kVIXmkEpjmQlbF4t68C2Ii5S8ToPvclk3tFUIWei1XDY612A
 aZz/+Q0B/W+lEvYpgy+mIvnoqL9/DJtaQzy0oiFIUixM4Kwng08UIHb099nD7+LmNPU7BWZzbqZ
 YplxK00yabzSUtD2xj0a09CvMXUlk4UZ7CD+mn6uLdPjas5gKf+5Z8uOJAd+PVxPpoYfk6zFZzd
 F698c2wOjnd0C8yZyYWsv3gxxkxZ3E3OIOo1pCLc+fMlAZW85Wa7E0JgpqsDtITH/7G4+t1B6OZ
 LLAsNUnhVQtudgrQlbDcU8hK8Mut2UaQilpr6jSx5O9lQSxPajJsCabWkX8DJZVBAi22OWDcyNs
 =
X-Google-Smtp-Source: AGHT+IGv5wD8UQvJT1QKgRrRu/oD4QRoRzCak+TwD7Ju3f8DW6xhpnoKpKSf6zJMYuOHriceEV4TqQ==
X-Received: by 2002:a05:6a20:6f88:b0:1f5:59e5:8ada with SMTP id
 adf61e73a8af0-20444e71afamr897908637.4.1745456197805; 
 Wed, 23 Apr 2025 17:56:37 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15fa907fcdsm119775a12.54.2025.04.23.17.56.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:56:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 085/148] target/openrisc: Restrict SoftMMU mmu_index() to TCG
Date: Wed, 23 Apr 2025 17:48:30 -0700
Message-ID: <20250424004934.598783-86-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250401080938.32278-15-philmd@linaro.org>
---
 target/openrisc/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index e8abf1f8b5..dc55594a7d 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -247,6 +247,7 @@ static const TCGCPUOps openrisc_tcg_ops = {
     .translate_code = openrisc_translate_code,
     .synchronize_from_tb = openrisc_cpu_synchronize_from_tb,
     .restore_state_to_opc = openrisc_restore_state_to_opc,
+    .mmu_index = openrisc_cpu_mmu_index,
 
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = openrisc_cpu_tlb_fill,
@@ -269,7 +270,6 @@ static void openrisc_cpu_class_init(ObjectClass *oc, void *data)
                                        &occ->parent_phases);
 
     cc->class_by_name = openrisc_cpu_class_by_name;
-    cc->mmu_index = openrisc_cpu_mmu_index;
     cc->dump_state = openrisc_cpu_dump_state;
     cc->set_pc = openrisc_cpu_set_pc;
     cc->get_pc = openrisc_cpu_get_pc;
-- 
2.43.0


