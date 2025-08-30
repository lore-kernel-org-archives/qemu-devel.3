Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BBADCA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:20:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNs1-0003My-6C; Sat, 30 Aug 2025 11:52:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usCRG-00052a-4R
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 23:39:39 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usCRD-00052c-3J
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 23:39:37 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2487104b9c6so25092975ad.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 20:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756525173; x=1757129973; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=JmWEBsWkC6Iy2kPe2svm5u9XW4Lz+QhNZJnUvnzxWu8=;
 b=Yuj6jcvYFHKyWx4PlSFg2qKjIyjPFIxBUrB1D0k1o3YatE4/nxCVs/OP+UWmLIURDX
 SHj2iCSVy8Yj9v7ZxPpYGT/zarJRQELkiD0knaosaHXJ4rr99uDRZhKSjIvOD71CopEi
 HEgZBvhPwTQ9lo7l2mTIJ0AXMzR9HphvyDyEwNLQvNx6FJ8Goi1b1k4qw3wkVzPnJEoe
 wkfX26j6P8mLUusl+HlXK0aekfuC1sW0/AGMbpk1KhuDJ1hZJmWV5O7x4UldCKn1vdYg
 zxnDXnCIED0DaCvp4+Hi0YkqL0xHeo2wAvQ8705sbfzD063FCfhmKcDxQxYieev7YD9l
 EC+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756525173; x=1757129973;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JmWEBsWkC6Iy2kPe2svm5u9XW4Lz+QhNZJnUvnzxWu8=;
 b=Uhmf11fOY0uaVHSNGKZwI49pwccApLaVZeSl9cvsQAYF8dxHG5fWtfgbYddfWSbHRe
 cWm4d88xiySLjGTZuEavDO6c1lkNCVTfB9M6sCbRIi8MVVX7aU87VWkS/TPfWsZJVuHZ
 MN3ftDrDCdmiizoHTIQYUQOkZ7rAZVrOH7uu0lmrTGNV4q0ZlIbnPBsb1tcb3FFCOxUZ
 gesTvigUm9HOBBsviig+7C6Ac0E847zSad1268Pv4oYgb9L1xBbcseySzYfdO418Reed
 DFVnWTqcdYDGhoGhylEbyRepPvC/1pzrk4El6ZMv109d6mO22Im+TZl0zXoOWZWQ3PXU
 PdPA==
X-Gm-Message-State: AOJu0YwwZ4yo7erv6AlVF7VHHcWcuB+ZHesuc9HYQ1Lukf6Lgqem7pzW
 YIcqLjv6lTbw9Fm0bKuZchjja+QqevDorDQNGcvDiDU2P3HrqKwbq9j1HuZBvOjmWJEIzQp6MEr
 kIPwja4A=
X-Gm-Gg: ASbGncu2cD5azOGk/TYIqVQLuNwHsKN1yow5DpgqeE9yl7KOXkLyDBZvdkperPAkixm
 9bx+C8pvzc++j+Azyfv+w+IE4PBSWYfofEy1PdeBYyqGk5F7KjqX6VXt02yKOtbj82suBB6tjae
 2SxEoqgZy1JTQMaLmlZwdG127hlrcsk9wqxyxAFiDi3bjDcv5zpXdJwjuvYRfwCzdhkVcEi+HCI
 uZfAfaFK7r4MQ6nBYDMMjjqvYtbERS0ey7yQP5Kn3jqek7OAWE7ew4FNrNcJbv8aFRBf5zUEwGU
 bJF8/fsTGR+hJIb3QnyqMkJpqqyvqPBo5KsOCFdXh/GW+IOHE0FGnNjjJkYpGfJcH+julHTER60
 p6zCqsxgrdrt7rYAP/uAnP685JvWIs5iCOqHaFdDc8bNNiLNYaYSuG4KFQH/8dlNz8VOAIL15Ig
 ==
X-Google-Smtp-Source: AGHT+IHjGIMcnrt3dLT8rokciY0RpjzYKKVQkteIUbgEO4pIpXLWN3stP49Ug2NXH/Npc7bmk5/eig==
X-Received: by 2002:a17:903:244e:b0:249:3eec:15bc with SMTP id
 d9443c01a7336-24944a44010mr11631645ad.19.1756525172641; 
 Fri, 29 Aug 2025 20:39:32 -0700 (PDT)
Received: from stoup.. (122-150-204-179.dyn.ip.vocus.au. [122.150.204.179])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24905da4784sm39551685ad.90.2025.08.29.20.39.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 20:39:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/5] tcg/i386: Improve vector shifts
Date: Sat, 30 Aug 2025 13:39:21 +1000
Message-ID: <20250830033926.372955-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

x86 doesn't directly support 8-bit vector shifts, so we have
some 2 to 5 insn expansions.  With VGF2P8AFFINEQB, we can do
it in 1 insn, plus a (possibly shared) constant load.

Changes for v2:
  - Use PCMPGT for arithmetic right-shift of bits-1 (paolo).
  - Tidy an instance of non-canonical operand ordering.

r~

Richard Henderson (5):
  cpuinfo/i386: Detect GFNI as an AVX extension
  tcg/i386: Expand sari of bits-1 as pcmpgt
  tcg/i386: Use canonical operand ordering in expand_vec_sari
  tcg/i386: Add INDEX_op_x86_vgf2p8affineqb_vec
  tcg/i386: Use vgf2p8affineqb for MO_8 vector shifts

 host/include/i386/host/cpuinfo.h |  1 +
 include/qemu/cpuid.h             |  3 ++
 util/cpuinfo-i386.c              |  1 +
 tcg/i386/tcg-target-opc.h.inc    |  1 +
 tcg/i386/tcg-target.c.inc        | 91 +++++++++++++++++++++++++++++---
 5 files changed, 91 insertions(+), 6 deletions(-)

-- 
2.43.0


