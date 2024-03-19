Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CB47C54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 06:31:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmSyQ-00056k-5w; Tue, 19 Mar 2024 02:29:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmSyN-000540-Il
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 02:29:19 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmSyM-0005dC-6H
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 02:29:19 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-513e14b2bd9so3256018e87.2
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 23:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710829755; x=1711434555; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zLi8HPYzQKK0ulsJCWUrgKiQfFdRxTHI+3UszDXzaTk=;
 b=oYEfSHzdZLrDQZlnB93SNcjUv1dBWlwx9Bg1DE1rosXuNVy9OT9Y024aZB3KSBTwqZ
 dxSh8lcy7xnJlyzLlcpS6vAM/17lRu/dGoraOalZVQ9dGAnV2F2YGxzirqsV8IDwxco3
 cjh60n/rouRFfk9c3QTgLaeSs00svvfeP7IWKno1ApuW1Hn3S6Kl6v1Mz378MfOJmbQx
 sPvYl/swyCNq7ZHgHq1sj/1KAPxEB8c9/sowOxTCFuErJD1TjrD9Ja6pYsweoyj/n7wo
 1aD7d05CUkAzxLBgWHAvQkdQx07Dt33y0ANtSoRfRbqtAQFAVAv1+ZeDZ4U0g06CaMpV
 YsPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710829755; x=1711434555;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zLi8HPYzQKK0ulsJCWUrgKiQfFdRxTHI+3UszDXzaTk=;
 b=Jb8pRa3Y6Gu7oq4synAy4/U0ba0z0ISx+H+0Ynu9MeYIHEi6anXGw0cLUNCS98YfCc
 mH76Zoe2ypbiCYYqHwcLuBlVlt8VmAXnSHICWi5gefziQHdpyRdnwy5v2DqWCthFr+iQ
 akak3WF5r0/IGVKgUhR0JGhmUS6GWHma8wuc2NL6butvGtXatmxL6EHBwlX8VSrYU7mb
 HzYMGDmNOr7lfCZpKEQI306tH+Zl1wsvwxMug7YxRZJWUMLBBywlHRDUVpv9q7qey99C
 I8Y+t6PwaUiXQSx2T4KluYNaB/FhpDlo1BQbhmkN5YaYVeKwXp3JkAeUWtR/wvC8TH4A
 T7OA==
X-Gm-Message-State: AOJu0YyVHJYNL3Kq+IXwC4qrp8tGhCVv1damZnZEVaIAxubzndCM82L8
 sjeAn/ltBTpP67k0nkCDBKmV63oWeSIPj+ONIbzdmmgtvkSrs0c59+sy9tkA9pkcCru53Wxk2jY
 o
X-Google-Smtp-Source: AGHT+IH990QOXS0xm+rmL/RFHVv4DCA1J7clmAFB+CoDE2gDtWceUhfA0KWECfXWbhnAhWN8ZdSmWw==
X-Received: by 2002:a19:8c4d:0:b0:513:cc24:c464 with SMTP id
 i13-20020a198c4d000000b00513cc24c464mr9866935lfj.15.1710829754972; 
 Mon, 18 Mar 2024 23:29:14 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.166.129])
 by smtp.gmail.com with ESMTPSA id
 k3-20020adff5c3000000b0033e7eba040dsm11624669wrp.97.2024.03.18.23.29.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 18 Mar 2024 23:29:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, Anton Johansson <anjo@rev.ng>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.1 3/8] target/microblaze: Widen vaddr in mmu_translate()
Date: Tue, 19 Mar 2024 07:28:50 +0100
Message-ID: <20240319062855.8025-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240319062855.8025-1-philmd@linaro.org>
References: <20240319062855.8025-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12c.google.com
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

Use 'vaddr' type for virtual addresses.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/microblaze/mmu.h | 2 +-
 target/microblaze/mmu.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/microblaze/mmu.h b/target/microblaze/mmu.h
index 1068bd2d52..2aca39c923 100644
--- a/target/microblaze/mmu.h
+++ b/target/microblaze/mmu.h
@@ -86,7 +86,7 @@ typedef struct {
 } MicroBlazeMMULookup;
 
 unsigned int mmu_translate(MicroBlazeCPU *cpu, MicroBlazeMMULookup *lu,
-                           target_ulong vaddr, MMUAccessType rw, int mmu_idx);
+                           vaddr vaddr, MMUAccessType rw, int mmu_idx);
 uint32_t mmu_read(CPUMBState *env, bool ea, uint32_t rn);
 void mmu_write(CPUMBState *env, bool ea, uint32_t rn, uint32_t v);
 void mmu_init(MicroBlazeMMU *mmu);
diff --git a/target/microblaze/mmu.c b/target/microblaze/mmu.c
index 234006634e..eb7c683020 100644
--- a/target/microblaze/mmu.c
+++ b/target/microblaze/mmu.c
@@ -75,7 +75,7 @@ static void mmu_change_pid(CPUMBState *env, unsigned int newpid)
 
 /* rw - 0 = read, 1 = write, 2 = fetch.  */
 unsigned int mmu_translate(MicroBlazeCPU *cpu, MicroBlazeMMULookup *lu,
-                           target_ulong vaddr, MMUAccessType rw, int mmu_idx)
+                           vaddr vaddr, MMUAccessType rw, int mmu_idx)
 {
     MicroBlazeMMU *mmu = &cpu->env.mmu;
     unsigned int i, hit = 0;
-- 
2.41.0


