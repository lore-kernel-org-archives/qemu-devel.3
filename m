Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6925AC369C9
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 13:11:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5P0a-0005Pq-37; Thu, 17 Apr 2025 09:10:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5P0M-0005Nn-Ts
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 09:10:11 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5P0K-0007qz-Rn
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 09:10:10 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43cfa7e7f54so5177585e9.1
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 06:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744895406; x=1745500206; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=x9S7o8V5sZETIKpIqgQZESlJBUueWfCdjnDkU1tQzlI=;
 b=JyDuxAKtMkqOlEeePmIrtajSQcQOOzexRLM/MQ2u23fEF9JueZqI5D5BqqDr9pQUCL
 ZlikuEcJvqKsgj1AOeyfzSlwvSZ/SRIQlXFsWqeBGoYuKsTvLQmy2koRakbSIXLcntYd
 8qFIh5hjUcKOKiXYVyemxS9eB0tZ4fLLVUCwvbOUDvS92/IuWgD3pMIluHbYWJVpB3BI
 wDu5AinmHDcikdv5HJHcDB0U3Zpb5rYVlPtDdmC5984y0oEF3h4lyFCaezaHCBlu8Yme
 SvFMVuSokNEIf8ag4z/+imuwUOr301ps5TGZ8lcWxSzlZdNeRLrfKMiIV3GPfnFL1Y0X
 8Jcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744895406; x=1745500206;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x9S7o8V5sZETIKpIqgQZESlJBUueWfCdjnDkU1tQzlI=;
 b=Zm0D6SJi/PLKrxcfOKv8x1J+jPvyPbA6by8f/ioqdckXVMZQMYXuRf1NJfDLIDRA14
 pmpqGdfxx+P5yzNOA9L3zMmoeOZPh49kpZYHk+OwFxU4fl7QyGhgaM3P3v6xRckWyrP6
 7LW79nddOCmvXj4XeczEh6kYUevA9AlPGThk/mQQ7Qyk4GT9F2NC8Q+NPn97WHj5nER+
 XFjJ55Id8yJf0QgYDU8LiuR5LtwCymldUAYGrUwB9GL+QOXwPx6A+yl/HxfvyGqf5izr
 Jj84tRxB6TUJT/YBPu9QdsSN5A2I5ImsnHAxs0qz3/r+kQSQum3AXx13IMa1kUkQspJr
 4tAw==
X-Gm-Message-State: AOJu0Yy3s8d+uJc+S/onWgs7U62svezZodA5iCM4C4qZhFsRg68CKByQ
 wwsiwXtE6CvBKS3Mz/KAaWdgLSndwUg+yy2G6XgCcXn7ki3ao/0JUazYYZSQcu894x81jEvDjek
 +
X-Gm-Gg: ASbGncvBxERFSqbQotttwc4nsNP9F24iq/1CM9t7FMfWJoPjnc8Cc+qX+rJFVUWR5wb
 u+500n8JS8k2p8GhMzx077qYzv5e9otDpqc/85BUnQgA76XfIFQcT4l1I2sRtMYJeexJEkkNkwT
 FJddcNXXiEy8S1+yl1wnAsnnKLp3QJgQwGPau/C63gtrDNNXXm6XI/dTK27bl4+ruIP9TnxnYXY
 UDN7DjTCRQjrpO/3SmWAtBmXzIGuk8J2m9HzS4Eo6YOMcq6V2HlwNDwyqUof635LKlhjTVz0H1w
 7Jvs0elEDlq4vyj9VoGP6wmpdxbrwYPGTSjOkzyvBbE59IwzpalFIEAw62YThNjtTClbOkvIS2H
 OheYpUWHfHjZHntg=
X-Google-Smtp-Source: AGHT+IGGfHPnkRSFoWIVdlgi6EdvlqVpWua76p92Jz0D2/zcB6PThO/SqMD0OKNhG8IyXFlw7KGe2Q==
X-Received: by 2002:a05:600c:1e8a:b0:43d:16a0:d98d with SMTP id
 5b1f17b1804b1-440636a4ec1mr27822165e9.15.1744895406169; 
 Thu, 17 Apr 2025 06:10:06 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4405b4c8028sm53878415e9.8.2025.04.17.06.10.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 17 Apr 2025 06:10:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/8] misc: Prefer evaluating TARGET_BIG_ENDIAN in C
Date: Thu, 17 Apr 2025 15:09:56 +0200
Message-ID: <20250417131004.47205-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Few single-binary cleanups before switching to the
TargetInfo API. Sending as a preliminary cleanup
because can be reviewed out of context.

Philippe Mathieu-Daudé (8):
  linux-user/elfload: Use target_needs_bswap()
  accel/kvm: Use target_needs_bswap()
  target/mips: Check CPU endianness at runtime using env_is_bigendian()
  target/ppc: Evaluate TARGET_BIG_ENDIAN at compile time
  target/xtensa: Evaluate TARGET_BIG_ENDIAN at compile time
  hw/mips: Evaluate TARGET_BIG_ENDIAN at compile time
  hw/microblaze: Evaluate TARGET_BIG_ENDIAN at compile time
  gdbstub/helpers: Evaluate TARGET_BIG_ENDIAN at compile time

 include/gdbstub/helpers.h           | 11 +----
 accel/kvm/kvm-all.c                 | 29 ++++++-------
 hw/microblaze/petalogix_ml605_mmu.c | 12 +++---
 hw/microblaze/xlnx-zynqmp-pmu.c     | 12 +++---
 hw/mips/jazz.c                      | 10 ++---
 hw/mips/malta.c                     | 21 +++-------
 hw/mips/mipssim.c                   | 10 ++---
 linux-user/elfload.c                | 63 ++++++++++++++++++-----------
 target/mips/tcg/msa_helper.c        | 34 ++++++++--------
 target/ppc/cpu_init.c               | 12 +++---
 target/ppc/mem_helper.c             |  6 +--
 target/ppc/translate.c              |  6 +--
 target/xtensa/translate.c           | 10 ++---
 13 files changed, 109 insertions(+), 127 deletions(-)

-- 
2.47.1


