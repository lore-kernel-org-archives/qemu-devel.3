Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0686F8E4A6
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 03:58:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDaKt-00007m-Le; Thu, 16 Apr 2026 23:57:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDaKs-00007X-4w
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 23:57:42 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDaKq-000180-CT
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 23:57:41 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-488b0046078so1812135e9.1
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 20:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776398257; x=1777003057; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SwcGW9aAMVBij0U1ZXwv381sKfboZtdPKjDsOvF/Hk8=;
 b=h6JT4s71SR80X8ZU373C4wCVLAbwsIHfSiR63p7fkDdeIjzxcArdk1KGhl+ku22+17
 TyjnfUivPq09+WC8re2DSJ02ZtrpBRqqtE2IfqY1Z9kZ7aEhYywE36cako62bv9nPiHa
 FfyY0d1V4zvnQPUimxVq4yW7bV+e8FRlvZNJoAYDEKeFumHh8QsPhPTe8hEVS/0T5M6e
 kHfYtuHapAmeCITjfx31fgXogPAdYUlxbik9PquFK03olLJ775RzdEobZdguhXReBAIy
 xN4BssGkzq12HwAmNDdTzLMgHJi30UBvNbzR/KHyDvX/TmTcFNdkyYOOFIIAmkgf0Yye
 o7nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776398257; x=1777003057;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SwcGW9aAMVBij0U1ZXwv381sKfboZtdPKjDsOvF/Hk8=;
 b=SRccsJVDjTBLSwXNiDbhSzuPBM1jJzrthb7i/WgDIjWPx2cnGN1TgYASEQIYpbyjGS
 vUgs2GfEFijx92jwfurHnPTr9/wcpjz7aQi86dYEVu91BHOM/SQRbl98nGkN7I3kuhIQ
 yFGer1Fxp1k676lV3sncnv9yEwPAyDJexQVdeYx/aYLHZstPbwBkX0f8CLfgK37zeSoH
 qhn4o+ccs3exbI8YOOwuFEYA52qKTD7E70Spj/KMrsmgkJPs7AvJvxsgNZBBRFRxjGoi
 vkOQ+qyVihaSI5+E60MU93qIxbtB8FA3MVs3MbDt4uaQHhy8T0edhj5hn53iH6KojerQ
 YNAw==
X-Gm-Message-State: AOJu0Yx2S3Yo1WpEA1kzj0GWI9rfNzYdvt1Ur0BJ3Y3aRe+kPjKtBjdt
 VUb4zWoSvpkI1eRpmSaHErEMhjSZf20DWvTXHzm8NDVFo6o/mYqV6HOQSAu3oB6aigO7VsXtWl4
 AxUWbZH4=
X-Gm-Gg: AeBDiesrl+x5u1QleJHYCsNI2eEHrxT6uoDabNI056FBzUJTBbiMbQOx74B5t/onKvw
 mrCntrYhjAfLfABQOPkJknCwwdcZsmVaooKJHxWGmTKaaOorNsD2eU/4TMduTJKWz768qYcSNqF
 imjcJ6TasgcREtfWo3mYk+PxEjSvhTMkwRdX/0LHCNXBReUu2mHkJCyiDGXHUrrNXaz8yMxa0gW
 GNlO/7TCam7z678weUG5azKRhsDBLyk6QTYgX+fsU39TbKjlaJrhVVmdp1+xyguiljaRmRK0YeF
 wSHV7mINdaQv2ZjU8b155NwW5UiIU4+ExyzvOtItRNmjMSv03Pmoc2ny9nevCYMgHq2VU6o2GZu
 ivYTbcZg0Dazk7N3A+Hp25w1Lcy6XxPUKxDfWQ6c/2fyYZXqX6aWWe6WYfMKbX3MWM/X5ffmaQj
 PHlJv1oVaxSahvenoyMt7SzrBEaKtNNyKwt6u1YjP7V4TC1YWn6DULFwWZQ4Kvc5bEpKxGQU2qN
 KchhlmVEO4=
X-Received: by 2002:a05:6000:1ac7:b0:43c:ff58:35c2 with SMTP id
 ffacd0b85a97d-43fe3dc5eaemr1587366f8f.20.1776398256899; 
 Thu, 16 Apr 2026 20:57:36 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e44f69sm1022374f8f.25.2026.04.16.20.57.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Apr 2026 20:57:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v5 0/4] target/mips: Replace cpu_ld/st_mmuidx_ra() calls in
 LD/ST Multiple
Date: Fri, 17 Apr 2026 05:57:30 +0200
Message-ID: <20260417035734.32334-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Missing review: 2, 4

Since v4:
- s/size_t/unsigned/ (rth)
- Use DisasContext::default_tcg_memop_mask

Address Richard review comments on v3 single patch [*]
as its own series.

Do not convert the helper to translation to KISS, since
my goal is simply to kill the cpu_ld/st_mmuidx_ra() API
and these are the last uses \o/

[*] https://lore.kernel.org/qemu-devel/bb8c987a-d46b-48ff-96fa-df558e63b878@linaro.org/

Philippe Mathieu-Daudé (4):
  target/mips: Pass MemOpIdx argument to Load/Store Multiple helpers
  target/mips: Remove unnecessary target_ulong uses in LD/ST Multiple
  target/mips: Inline cpu_ld/st_mmuidx_ra() calls in LD/ST Multiple
  target/mips: Check alignment for microMIPS pre-R6 LD/ST multiple

 target/mips/tcg/ldst_helper.c             | 74 +++++++++++------------
 target/mips/tcg/micromips_translate.c.inc | 18 ++++--
 2 files changed, 48 insertions(+), 44 deletions(-)

-- 
2.53.0


