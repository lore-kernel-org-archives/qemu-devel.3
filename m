Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73BEDCF9C7A
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 18:00:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM8wD-0006nO-S1; Thu, 20 Nov 2025 12:59:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vM8wC-0006mf-3w
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 12:59:20 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vM8wA-0006y6-Lp
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 12:59:19 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-47795f6f5c0so8386075e9.1
 for <qemu-devel@nongnu.org>; Thu, 20 Nov 2025 09:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763661556; x=1764266356; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NFVXYREM9dvVkLV+NnBqVgSYy0Rdt0c6oRW9YMfiSKw=;
 b=hMVNQ2lZLuKXuL3e95oVBCH+a+WT/NvfnWCOitej5A7v/7SntZ3uULId+XsF6ZJLS5
 YX6Lib9IWQMm+64W3ADvji2iN1iwa1dtH3DIeZRStgR6zo0+3bvuEiiJP7jh0Jm0OZeB
 r8pXHniWZqpyRGWFLEqkaggxPKK9s7DJpzEFotem3QKvZATdMw3fZbMaI/blYov5BOBP
 1Xd0Hj48xKDnryCJHO+R1rSq9VPgkpo3KvURFvLqcfKHt1Mvpp2f48abFI+wwgYzaTnP
 HGzP/2FKmJ7hXzOSpIvAvX88M4ajpgQmWUyl+LPqw6QD/XSUS5iK0WHjaVf6zNCdS2Rw
 qdjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763661556; x=1764266356;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NFVXYREM9dvVkLV+NnBqVgSYy0Rdt0c6oRW9YMfiSKw=;
 b=qupydUE72fQOslypJD5fvCf6X50E3pSQxhY0zhhGeATzewDltU5FM7giEsPe4SfMEW
 HOKhvKRSlaWMlfsGP+QXxWdGXXJnrHhiqYYDIUUjvW7+ymwW9t8Y561PaM8IGQm9VKxz
 Dv0iEHAehvZ6VOFbiAmp5YQdjWmdvPLiKw776m/LkRrN6zOzpEsQiO43hjJwOYzun6Hx
 9EP0GFUuR4uNWOWHGJbdju+pvcXHLmyJ787ks21P1oiwYU8eKNteUSSB3NnxgVxjxPhV
 4suXYG6EAQry8GfIvYNapqWCyLNI0fOgsXXbL1OSujFLglJSFjWNRZ9VAIb6VQZucSve
 C4rg==
X-Gm-Message-State: AOJu0Yyy6jvidwrOYtqRDg38qcMROj3J5X/PVITnx4hpYpyC3d7Ggj5L
 7ais08ZplKOaceiXoYKrU3+CCB5nQC/Lt6MtvXpZknJ7Ov7GOQQJHFvfVZDZHdP3RWbIHrRi7k6
 OusA1aVTRAQ==
X-Gm-Gg: ASbGncsFaHNltWwJXZ73r8VSBxNlHrss5rla0Hi+hMbkfHJrV7U7nHqkbOMPBof6Ped
 e4xkfzHqdQjHWNfMDDnaPWMO3PQQiuCweV1xtTANDc26dK4v+46lA+w5AIChGRQ2oYTl3T2t8br
 7un4R79UVoAZb+25/TiR9ewJdq/rCvEEPxNc7wgMiHo+nqMQSgRCqbEzG3JcvroMHOO1FIT9B+Z
 0T5DdhwIbgqc2vJilxQ16EuTkAE5hB+xcPaL8o2vAGhgGvJG5YoKpsJM7LKYk6PqRf/PfwkUd0x
 3AiHzQbot+jnYn0tK3ymsQaHNOYMixajml3iGn346vV7TZOaqIQBRMV5xLdGqXsqPL1aio21UIX
 oL++X+//iooBy26FsywPyQ0NNzFUyxW/l4DzXysMyyHWW2PYqb4W/iB3rC2I/DkJD2oIjKLyxhq
 Q708IWFZ8wpLBRViRbpdpXSvrsQyRYmZQvenplPeuj3NVEi6qzn5pvr277lktA
X-Google-Smtp-Source: AGHT+IFMqs+7PEOoR95q7zfPzq0EtHiRgWmLAJUnX9I3jwRH5X89PESy0b+0YXToBOEHNDFq/eiNQQ==
X-Received: by 2002:a05:600c:314c:b0:456:1a69:94fa with SMTP id
 5b1f17b1804b1-477babcfeb2mr28258045e9.13.1763661556483; 
 Thu, 20 Nov 2025 09:59:16 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477bf1e86b3sm2718705e9.6.2025.11.20.09.59.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 20 Nov 2025 09:59:16 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [RFC-PATCH-for-11.0 0/5] accel/tcg: Remove some MO_TE uses in
 cpu_ld{uw, l, q}_code()
Date: Thu, 20 Nov 2025 18:59:09 +0100
Message-ID: <20251120175914.6515-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Hi Richard,

Quick attempt to remove MO_TE uses for fixed-endianness targets.

For the other targets I started to propagate MemOp in the call
chain, but since IIUC it is constant, I wonder if it isn't simpler
to have a CPUClass::code_endian_mo field, set once with a
target_big_endian() call. I can post another RFC to show, WDYT?

Regards,

Phil.

Philippe Mathieu-Daudé (5):
  accel/tcg: Add endianness variants of cpu_ld{uw,l,q}_code()
  target/alpha: Use little-endian variant of cpu_ldl_code()
  target/loongarch: Use little-endian variant of cpu_ldl_code()
  target/sparc: Use big-endian variant of cpu_ldl_code()
  target/s390x: Use big-endian variant of cpu_ld{uw,l}_code()

 include/accel/tcg/cpu-ldst.h   | 43 +++++++++++++++++++++++++++++-----
 target/alpha/mem_helper.c      |  2 +-
 target/loongarch/tcg/tcg_cpu.c |  2 +-
 target/s390x/tcg/mem_helper.c  |  6 ++---
 target/sparc/int32_helper.c    |  2 +-
 5 files changed, 43 insertions(+), 12 deletions(-)

-- 
2.51.0


