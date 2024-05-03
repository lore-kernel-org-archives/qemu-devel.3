Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA5C5C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 07:20:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2nDS-0000lb-LL; Fri, 03 May 2024 03:20:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2nDQ-0000lP-Ta
 for qemu-devel@nongnu.org; Fri, 03 May 2024 03:20:20 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2nDP-0001Ed-9u
 for qemu-devel@nongnu.org; Fri, 03 May 2024 03:20:20 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2db7c6b5598so113156911fa.1
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 00:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714720817; x=1715325617; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UVi2/lBwGMlU7cAoTgtyiExKPhec9x+jnIKMxcEwUS0=;
 b=lkngX/r1TiJ4NzZvsShY8s7mh612J/XqYMzEB1KD+AyfyiBxKpi9IuDgyHIY2Dg831
 AqgqgCJMyqP/51X667Cyim+mSuWHoR8L9WU90fm9lCM5SOIPhTBP9s398Mngvk2itbxv
 uhquVt22Tua1fxaxG3aRXF6zmx/OVgwE8AYWy6fmIZ37YBuepyIO4S3xwLkVUgRfhTAI
 6SKi1GXhmAXfEtkCWWYS8hS72Inhys/mLTqQREhV10Xpf5tYaHN15BsrdXsTnHt56m91
 bdgZIi5SJ7mUj0f4wLnEqIMaJCx3CMlOzYMQoXHWEUDKHySnbL39lET/MXUjg82uRcBo
 /XWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714720817; x=1715325617;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UVi2/lBwGMlU7cAoTgtyiExKPhec9x+jnIKMxcEwUS0=;
 b=DceEVd5p6tBTwbkmL06BSlzQMz5pfIiCWVYXPMn19uz5pNVxXA9bDhbTc3LJnTR44J
 9JjijUUVEvyp88KexFYgjXjFyosfvLfdNq3UfLyDfBzbd0hsOMc2WJNe01jlAaT5tCGv
 8IcEUp9rVBU/A2cVrDsQCQdZ4YIyzo61fbHFDMi3UZ8Ap0a32b47PIokmk0FuG1Vne6h
 hb6eQAp1E1kCxbc/RjQ3pOwDLo6XVr7zUlndDT0Mvj1gXYXCFASvNPZkR72XdM/dt1TD
 SQFfpsaADatPLS8G/djNm/Lqd9v49LgV3VZPuDUyc49M6tH+e92fafsZ1c8zpVNh4+sl
 L2xw==
X-Gm-Message-State: AOJu0YwfebveS7zAegfGVI08Y15qLGhA/YC1/gyADNvpGeqWhboLKuHb
 Cqj/WFh7+Koe66nw//xn4DGiuJkz76M9Pn4q7FW1JedhWjMzZhL6PdCTBdTXcXznVSjiz5Rm/ep
 V
X-Google-Smtp-Source: AGHT+IG8pvS7OjdfvSIdVy3KrqHqft9VSymUlhHaYbriZQPFAyq9L4MxmWnEbXVFWU1fM52inQLxXg==
X-Received: by 2002:a2e:80d4:0:b0:2d7:17e0:ff56 with SMTP id
 r20-20020a2e80d4000000b002d717e0ff56mr1238689ljg.18.1714720816778; 
 Fri, 03 May 2024 00:20:16 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.179.187])
 by smtp.gmail.com with ESMTPSA id
 k7-20020a7bc407000000b0041674bf7d4csm8251830wmi.48.2024.05.03.00.20.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 May 2024 00:20:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?unknown-8bit?q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/9] target/alpha: Implement CF_PCREL
Date: Fri,  3 May 2024 09:20:04 +0200
Message-ID: <20240503072014.24751-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x234.google.com
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

Since v1:
- Split complex patch 4 in 5 simpler ones (Phil)

Implement pc-relative tcg code generation.

Philippe Mathieu-Daudé (1):
  target/alpha: Simplify gen_bcond_internal()

Richard Henderson (8):
  target/alpha: Use cpu_env in preference to ALPHA_CPU
  target/alpha: Hoist branch shift to initial decode
  target/alpha: Use DISAS_NEXT definition instead of magic '0' value
  target/alpha: Inline DISAS_PC_UPDATED and return DISAS_NORETURN
  target/alpha: Return DISAS_NORETURN once
  target/alpha: Split out gen_goto_tb
  target/alpha: Split out gen_pc_disp
  target/alpha: Implement CF_PCREL

 target/alpha/cpu.c       |  32 ++++++++---
 target/alpha/helper.c    |   8 +--
 target/alpha/translate.c | 117 +++++++++++++++++++++------------------
 3 files changed, 91 insertions(+), 66 deletions(-)

-- 
2.41.0


