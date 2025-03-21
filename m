Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD179C36000
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 18:42:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvhJn-0001BO-Jb; Fri, 21 Mar 2025 14:42:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvhJl-00013c-V8
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:42:06 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvhJk-0000WD-Bi
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:42:05 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3913d129c1aso1699490f8f.0
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 11:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742582522; x=1743187322; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NpxUpa1g1vPr5GFFi4fmbaGYlaCL3v/ZCqoMDwHYU6I=;
 b=lp8SUZBqc2ht9s/f2ibZnlRkz2+UgGSWBE4MImfAZEYwhzbviBghCEpBe4so1llZ4L
 hK5S0FAdkst1bqnggRyiZDQ1MEZc8rNVlM6a9MPhFeBXwvu4Kl8MsCAeQxPh1X5Lvbmj
 i4K8CvSI1kxAF0N7gawdu5Ws8TgQ+JX00oe6CCESaoOrWbtOj5+3WWsiLgVys0xEAJk6
 xCOgYkvECxG1+NzkEWVwKPqTIjN6ZyT5IG4KksgBSFyc3IDO3ausIqkAW5NBPxwjGV7O
 uy9+paYchHYwZ4tt7EpJyMPqqB83Xs96j54jmMNVtMbacw0GhstRGUfGvDh21a8vqqEs
 7SGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742582522; x=1743187322;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NpxUpa1g1vPr5GFFi4fmbaGYlaCL3v/ZCqoMDwHYU6I=;
 b=htWShGv9u1Dqv+lbsESJpy5wLVazF/nMzehTdYynN9J1DqJhtfcH6vvBB709VtBgaD
 zIzDuEo0N0dQwUKQuqHYRDsmbezP5WGripDUuxWBgQnqXAP2aJ33hu6f0WyDZ3BEU98b
 TJ+vaLsfIrUgUWMdEDchmGBVZbmhFDjgl5HKcVNaY6ADkm25xODs6YYUxyvsUkHilsue
 zZRQLgs0IQ3Qg1gliPdRxoV0l06d6DYu/dGwLGlinzlBrauK6qW3yeJeR/o4r2ewEPqI
 0tLb/5Lhej7mcl4NEMagf0EoBaRZbM2AbVDUNkz9ualcIa+h6NpSRYk3UL57241igLMG
 bRMw==
X-Gm-Message-State: AOJu0YyPju5bwJesgdXVcSL2140A4sTYEk6nKS/HMitpMa+QxzrvTnwr
 9Y9fkuKwJfRt16HEDCwhpZSodm0qxl827DQhg226lLJJWpgTJItE9kJhHxTCnBeFyffbb0lKd8l
 5
X-Gm-Gg: ASbGncuYrkr+qlre4pxpjeLfu2JeZVJU7c5YNl90nPhEa327u2twGeLXnYYbVMssPva
 r3Otx+bVYP1bFSvcRtgxZwOZPrOCAUg0QvEgF098X0wR9G4W9sT1zAPxcByBuMYDv/bMZeHtcQt
 sy8FPn4cZ/PR8gs/haHpOLcAFbzRmQUcVy4YgGKGnc4SVKTMSsUpcqY2DadlF8TfQpKUO+fE2+d
 42aA+KdU4YuevQJA/dE9+PP5dzd16+w5/sGgz1tBk6Lxg3ueRVm/8hMIKsp4iam8HGfwl0jkxW6
 JHZTBoCz0Yzz/tpoEyW3rvunIUwcmaEAkmENcyWxw3PARuRMGV/LQnwLGD7c4bgTeJs5CFGtHlF
 jlTMUGW/A/XxvgZZ5Vhk=
X-Google-Smtp-Source: AGHT+IGHPRyPuBPuchYR+v5v6zW0LXBvNqgCh6VCUyjtMd+MIv7/CbGqa8PgwlGU1eyetM1K8E9otQ==
X-Received: by 2002:a5d:6c66:0:b0:390:ec6e:43ea with SMTP id
 ffacd0b85a97d-39979579dc8mr8191879f8f.15.1742582522328; 
 Fri, 21 Mar 2025 11:42:02 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d4fd277c9sm35187835e9.22.2025.03.21.11.42.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 21 Mar 2025 11:42:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] target/hppa: Remove duplicated CPU_RESOLVING_TYPE definition
Date: Fri, 21 Mar 2025 19:42:00 +0100
Message-ID: <20250321184200.4329-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

The CPU_RESOLVING_TYPE definition was added in commit
0dacec874fa ("cpu: add CPU_RESOLVING_TYPE macro"), but
then added again in commit d3ae32d4d20. Remove the
duplication.

Fixes: d3ae32d4d20 ("target/hppa: Implement cpu_list")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/hppa/cpu.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 7be4a1d3800..8b36642b591 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -391,6 +391,4 @@ void hppa_cpu_alarm_timer(void *);
 #endif
 G_NORETURN void hppa_dynamic_excp(CPUHPPAState *env, int excp, uintptr_t ra);
 
-#define CPU_RESOLVING_TYPE TYPE_HPPA_CPU
-
 #endif /* HPPA_CPU_H */
-- 
2.47.1


