Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C09E6C54ED0
	for <qemu-devel@archiver.kernel.org>; Sun, 25 May 2025 16:03:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJDoC-0001vg-Kr; Sun, 25 May 2025 12:02:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uJDo1-0001kh-70
 for qemu-devel@nongnu.org; Sun, 25 May 2025 12:02:34 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uJDnx-00035g-4I
 for qemu-devel@nongnu.org; Sun, 25 May 2025 12:02:32 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3a375e72473so914799f8f.0
 for <qemu-devel@nongnu.org>; Sun, 25 May 2025 09:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748188945; x=1748793745; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YE2j09W96IIkkn87IgfbfeQRyzbjP4CyaH7xgdwqVFQ=;
 b=OITM3/y7TY6R3Jw0VyPngtIUia20WvONtQrche8TpnOWqMm7ZsE++aQD/J21JmxF59
 Awooc60PcnRz/uDE1lsL+V6OgeCKqsLKdXNs2hJ/8VCv9bV7ztuzhOUVdOMGP/6CvNOq
 ayWpHEOtcT4lyeD8FzhJlYg/MEEs3rPQj6SZ2qDO5QCxqzZq+wqyAeY+NY37QpaDofCm
 Z2ND5kr1Qn/atkWLMnzNmTkl5sIspG2WHThxMChmjf/Rw1nts8Iv8+U9DMBPTbgJhxVy
 F1nR9aQynRkDQWrEy/al8Jn3ufxvrDV1sYWZD/c+Dz2sWE4G+my2ifcHqwaKVF/C4J5a
 pchg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748188945; x=1748793745;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YE2j09W96IIkkn87IgfbfeQRyzbjP4CyaH7xgdwqVFQ=;
 b=APstY+TMMSu5uYcssYFLgHy6GTjyjxmjU5fj8eQJ6NF+Lmcwi1/9qGMUh0u0gcSa8j
 ri1ArL8rniug7x9JdYBIKjLY0ogHWqJTpY+Q2q2e0u00h3pA4InNQ6Mx5khJ8e+hc8O/
 VVR38C0GqZasGol74UzBkhV5fcICkfebOU/6l6S3y+U65Qae9L8tkhZQb84Vyxr+Rx1o
 FCXsLH1h21Q/sBrygVjTnenH+SyqvSv56ICaAKLMzpLE9NN4UhvzVS5tC43vPbOp9zD+
 GkEJ4ORjA5hGCh/tG0AmPCKV8lsjpIi24wZ9YP73O28E6oG9urQcBMtCEja0AwUWaKmh
 EthQ==
X-Gm-Message-State: AOJu0YxEWRZEFAoHk9WDrPLGfxeHQu8k8ko/AhDasdDCybMFB9CyFHRy
 w2Y+nAkz2D5ICPkh9ogSjbVlkmj1Ye0OsxYfcrJHE12qzAtZOZtdSXLxiYNlrFk5/6ns21ocvfx
 kVR+vijw=
X-Gm-Gg: ASbGncs+TK2AYZ6nHBdpZC/F2qVfksNhvbsx3LJirWrk0e9J6w6dUxxTFTTavZvV7I/
 2JcP+RMu8BXWxhf9kkBE5+G+RmkjfcJ0VZy/6k0nTXi7WPLvBuF2AZAAwHP0RydqUit4quNcJgj
 m3xKrzH5BVcfTKtZMhDKf9X1YQLzUZB8lvD9M/OfadudKWdG09BqJ78xXPvCQuIQBPD7oW9GcLH
 HpENWCuqSURj6EE5YohQ+YkADtjSxzxdtW6HRsHijExHSsp69Kbf3eENFc+bKmCrTspdnYYEDNi
 +Bc9AldI9fTx6NA9orj8KbSPwxdTzOB4TU1OC+cacDCAVEC76jczJCKR
X-Google-Smtp-Source: AGHT+IHDeHUZRZqRk6ErtpHkcOBeubM+HGHGJOFAF9FACmomg3FuNUS0TYEThsIbO8m/C5ZIBb5J2g==
X-Received: by 2002:a05:6000:2584:b0:3a4:d0dc:184d with SMTP id
 ffacd0b85a97d-3a4d0dc1c68mr2674013f8f.27.1748188944878; 
 Sun, 25 May 2025 09:02:24 -0700 (PDT)
Received: from stoup.. ([195.53.115.74]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f73d4a3csm215772545e9.22.2025.05.25.09.02.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 May 2025 09:02:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com,
	philmd@linaro.org
Subject: [PATCH v2 00/10] target/microblaze: Always use TARGET_LONG_BITS == 32
Date: Sun, 25 May 2025 17:02:10 +0100
Message-ID: <20250525160220.222154-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42a.google.com
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

v1: https://lore.kernel.org/qemu-devel/20250212220155.1147144-1-richard.henderson@linaro.org/

Use out-of-line helpers to implement extended address memory ops.
With this, we can reduce TARGET_LONG_BITS to the more natural 32
for this 32-bit cpu.

Changes for v2:
  - Handle alignment check inline, where we can pre-test MSR_EE
    and cfg->unaligned_exceptions.
  - Add both big and little-endian helpers, selected at translation.


r~


Richard Henderson (10):
  target/microblaze: Split out mb_unaligned_access_internal
  target/microblaze: Introduce helper_unaligned_access
  target/microblaze: Split out mb_transaction_failed_internal
  target/microblaze: Implement extended address load/store out of line
  target/microblaze: Use uint64_t for CPUMBState.ear
  target/microblaze: Use TCGv_i64 for compute_ldst_addr_ea
  target/microblaze: Fix printf format in mmu_translate
  target/microblaze: Use TARGET_LONG_BITS == 32 for system mode
  target/microblaze: Drop DisasContext.r0
  target/microblaze: Simplify compute_ldst_addr_type{a,b}

 target/microblaze/cpu.h                  |   2 +-
 target/microblaze/helper.h               |  22 ++--
 target/microblaze/helper.c               |  71 ++++++++-----
 target/microblaze/mmu.c                  |   3 +-
 target/microblaze/op_helper.c            | 110 ++++++++++++++-----
 target/microblaze/translate.c            | 128 ++++++++++++-----------
 configs/targets/microblaze-softmmu.mak   |   4 +-
 configs/targets/microblazeel-softmmu.mak |   4 +-
 8 files changed, 214 insertions(+), 130 deletions(-)

-- 
2.43.0


