Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E617CFA443
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 20:19:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMB7n-0004WB-C1; Thu, 20 Nov 2025 15:19:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vMB7l-0004Vy-KT
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 15:19:25 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vMB7k-0001OF-50
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 15:19:25 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-47775fb6cb4so9538155e9.0
 for <qemu-devel@nongnu.org>; Thu, 20 Nov 2025 12:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763669962; x=1764274762; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=g+EIEbi5r6Qel7NOeQ2UTN7EOLGZGupf08AsjbeZmIs=;
 b=fp0RgplGGm/fcLYeZsONy6EX7t46TlyGL7gIYg6mWQtc2UvdPFH1xjAi4kpAAYh7p7
 my1lcFwB5UWJVex9aNqvzjSwzEtYteJ1ke8Kcd6SB7mAjLG+ovWrC80WLbAeXqQUlpZv
 S1MlKM2ncaJFJTCxSwWCLz90TlJEDWosGhJ5umb0dUccN2uxxBe+4UhwithZD55gEQA2
 0gEmOr5jpqTP5bt9ikSs87GJnKkh7zHlA5BldEDTjYvR651A2RKiKAmT3MUHBXecdJwq
 ASIhn1OAuFP1WZ0DB6JZEq0x++mFBQlqC2q45Ndq61mKXE1O5FAmAnDMjF8Mwp1ErH2A
 YEgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763669962; x=1764274762;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g+EIEbi5r6Qel7NOeQ2UTN7EOLGZGupf08AsjbeZmIs=;
 b=rV8Yo/WFUTqYyt0BSS8EwI/JeI/1teTsMg8aP29rrQOfL4YOEV7qfN/YuOSs23UQgv
 LrhmmqLeEiImYdw33zqwrPnoy/OEtFQg8PgJLkf4JWI5ycGi7M2y2tjgMNtizqbLW+5k
 ZZfaOK7nHbyXLm+iPeqdxSvTaoNsk+dtqwaAs4tXHd4jlLgyvq+cM9LiWK4DYFG4uQrs
 ohPFSMvb5T8iSP+5GZxP0reQwM1tFIycxnCWUfawo7qnM9PB6fMl/Cj+uaAVSG/VhFzG
 ZMJZbSKr87XIGFlMXjHLOGmsatIkxBPRxPLIWm+ADng8TwUSoT7HLTXQxkc8LmoJGo3N
 OVzw==
X-Gm-Message-State: AOJu0YzdOnK1bxluQhFJkL3za+pni6AwZnuXrbmyO3brBv2qEhhSdOHW
 zTX/2B7+PVD41bOatMOtUZVjIb0Wzfxe/c7N5ZhTRT4d5bAS+badswiXld5nF9Ws/9qu0J4HiWX
 h0aEG2cn9RQ==
X-Gm-Gg: ASbGncuLD7i5uUDLX94GwbMtPPUK4db3yeoSagV2/Zzh4IUwTXXvGoqrLq/tLH2U1U8
 9veJKMdtX/seqruxOUqVf5eHdqSrCzJWl3vOdJz/2LSHiW6nZCitqpZXrbF5lOp96FlvbKqtY0Y
 ray1NcJbolFzAJ2x/8wyNww6y2xmehqRBW6Zs7fFt5uUPRI5MpBn48zYaMqHXCrEirKxAOJdMek
 BBzbeAbuxZUMSf30bFYtvJm28pseiC6w5Um+FmklcHtoJBFmhPAJeglpjkANb0gXYb9JT3sIKQ4
 wkOGfmc86RNZAH5Iiiszp3DmF90LQRd/937NUJWC0bFpAKy7yOAIAPRyGcL06YwaNH+Ji+NUppl
 w0kkdE0JONxX2bDxCB3ixtrYhF8kaWq/CZTSsVwee6dtNxOEKIMurDrvif/SJ5nocqKUW0XgzAW
 xSM6ObR1oXn59lICbUHK/Uip6MoE9NtG0F9IZigyyUs12PO5byZzrvGpWvFLbW
X-Google-Smtp-Source: AGHT+IEztTmJMXQFuqh1gCdvP7ozIq1EpAHYCToTvR/qumWkII/d2+iNZ9o9J5kFJ7kR5SLjfWebkg==
X-Received: by 2002:a05:600c:3b0a:b0:475:daba:d03c with SMTP id
 5b1f17b1804b1-477c0168fcfmr119415e9.13.1763669961711; 
 Thu, 20 Nov 2025 12:19:21 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477bf3b4fafsm6324805e9.14.2025.11.20.12.19.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 20 Nov 2025 12:19:21 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [RFC-PATCH-for-11.0 v2 0/8] accel/tcg: Remove some MO_TE uses in
 cpu_ld{uw, l, q}_code()
Date: Thu, 20 Nov 2025 21:19:11 +0100
Message-ID: <20251120201919.8460-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Quick attempt to remove MO_TE uses for fixed-endianness targets.

v2: convert all but mips targets and remove unexplicit API.

Philippe Mathieu-Daudé (8):
  accel/tcg: Add endianness variants of cpu_ld{uw,l,q}_code()
  target/alpha: Use little-endian variant of cpu_ldl_code()
  target/loongarch: Use little-endian variant of cpu_ldl_code()
  target/sparc: Use big-endian variant of cpu_ldl_code()
  target/s390x: Use big-endian variant of cpu_ld{uw,l}_code()
  target/riscv: Use little-endian variant of cpu_ld{l,q}_code()
  target/ppc: Replace cpu_ldl_code() by explicit endianness variants
  accel/tcg: Remove non-explicit endian cpu_ld*_code() helpers

 include/accel/tcg/cpu-ldst.h   | 33 +++++++++++++++++++++++++++------
 target/alpha/mem_helper.c      |  2 +-
 target/loongarch/tcg/tcg_cpu.c |  2 +-
 target/ppc/tcg-excp_helper.c   | 17 +++--------------
 target/riscv/translate.c       |  2 +-
 target/riscv/zce_helper.c      |  4 ++--
 target/s390x/tcg/mem_helper.c  |  6 +++---
 target/sparc/int32_helper.c    |  2 +-
 8 files changed, 39 insertions(+), 29 deletions(-)

-- 
2.51.0


