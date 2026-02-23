Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEBAAE98E06
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 08:23:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuRCj-0001tz-6Q; Mon, 23 Feb 2026 03:22:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vuRCh-0001tR-EC
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 03:22:07 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vuRCf-0007iS-Sf
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 03:22:07 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2a79ded11a2so26704605ad.3
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 00:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771834923; x=1772439723; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KVp+zSrn/lBbxAF43bM9uO0yOZE+myVOzQIUAc/Fz7A=;
 b=MiWOrUal2lc9k+/pGDWzrGonl/tJWUI12jQ4cidVruECRnn5FKEW3mQ1tCMVJMRIw/
 W3Q11V0bTrDqe6V3/TDsBMdTpe71EY5jhHEagwCDehlATMRlkP3bGHSqvs2w3XTaLPYo
 m0B/+EU8GxYyUjiDCoVzsegYHPGyFczRCZwAPN5b+gr8tEBklXZAWzdWFr9L7mtCiqGw
 u8nzNjWjIp09/Dpx1wUlagLl66Lj0PFpIs1fy3dowDVUe7M6ZX6DdktVS59Trbhd1YhH
 z7OIWmuzl5Baf8kKGhlT+IjdbO5SitIN2UY1igcTfUk+jHekKnIVcruFlPjjE/jXLgF1
 0Y2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771834923; x=1772439723;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KVp+zSrn/lBbxAF43bM9uO0yOZE+myVOzQIUAc/Fz7A=;
 b=tDCab0KFp67N/a8+Tr/uXew8+Y5A0Pcz0/w6Vf7ur9F+wlMabSMLApUYJhg3mif1eu
 PL2ah/kI+W0Ixgk+mgPmp63ThyK6ot8H/3EY/BM+cxrLwyiNzRAO0xY342/71ROm0Ibx
 3iMgmitn3VglAYxGcyWec06RwX9kYZmyb3cC4IuSD8g5+3rDt3gXRfigtkDcywD1KRfl
 EskuPmA5Z+nydoYES8sHljQlpFtnhY/SfkJM1BlcW2upT13EQNxPXtOcfkR/bcsOO39s
 N8Ul7NwnR0Tb7yCcbPFSwKyC0JvkCR62pDlPJbmAkil/2hDFACeJaoo3zs8E6hf0fGMN
 mIDw==
X-Gm-Message-State: AOJu0YyUWlafiCV+vfSLqTgQyHDvdBa+M8PNdDYxjA9b5GlJd2uu7dNI
 ghG9ZhpJ+0QUNSBb567L3GnYcRL0CskK3FaMKWFIICA76iiknZH52Cm9nXg+CRkYKRf46KYVOTo
 4+vrc7bI=
X-Gm-Gg: ATEYQzwtj24hIBZj+VRTLfusa3zu4PyTo9cU2oP0Ah+06aHs+qwIPRd8Yz9dnmMiLvp
 kIbtH3ARJiK9BFp4HcoaCTr6g4Ovw27yUKCgBa3J+WcHmnSZsgtnEYiFVOy45YpUCVXjjvQvTtw
 CuPGvrGSKifkIns03L+WeZvUw9fegHWWvGmWPHitozd2UTOgBl4nVZvlVA/rJbuZt3ZHkAzWCIs
 naj/EIvri0RT8ybHaCjEwtvqBae7sHucxN0GtYa+LOIfieaVX+v9jhIyQna2Qd0qaPcT32ZjlNK
 12t8te/RgoCTocJj7lNePqcaaBDbez6hB4VSbPP2/ebktw3ytl9qwOYuqtoxp9j66GpDLLE5Cqb
 kAMLVe0xXuZD3lqN/qlN9MYQIy91I1p6mNLEEbRU2Q2TFGQegZVrrKJA/0UnlzYlFYqOSI/JIfb
 0cpQ6J1LRYjjA7PV0jFW/Wk4nf6V/h/mmZZczCbu8jEaw16oKCRBbcxej3EZT/wYvxOannegMLY
 suG
X-Received: by 2002:a17:902:d488:b0:2a9:30d4:2b0b with SMTP id
 d9443c01a7336-2ad7455ed1dmr67512615ad.52.1771834923474; 
 Mon, 23 Feb 2026 00:22:03 -0800 (PST)
Received: from stoup.. (123-243-199-74.static.tpgi.com.au. [123.243.199.74])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad74f5dd7asm86543625ad.28.2026.02.23.00.22.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 00:22:03 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: max.chou@sifive.com,
	chao.liu.zevorn@gmail.com
Subject: [PATCH v5 0/9] fpu: Add conversion routines for OCP FP{4,8}
Date: Mon, 23 Feb 2026 19:21:45 +1100
Message-ID: <20260223082154.5623-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

Changes for v5:
  - Rebase on master, resolving s390 conflict.
  - Introduce parts_float_to_e5m2 for saturation of Inf.


r~


Max Chou (8):
  fpu/softfloat: Refactor IEEE format NaN classification to share code
  fpu/softfloat: Refactor floatx80 format NaN classification to share
    code
  target/i386: Fix pseudo-NaN handling in FPATAN/FYL2XP1/FYL2X helpers
  fpu: Add overflow_raises_invalid to FloatFmt
  fpu: Add saturate parameter to parts_uncanon
  fpu: Add conversion routines for OCP FP8 E5M2
  fpu: Add conversion routines for OCP FP8 E4M3
  fpu: Add conversion routines for OCP FP4 E2M1

Richard Henderson (1):
  fpu: Introduce FloatFmtExpMaxKind

 include/fpu/softfloat-types.h  |   7 +
 include/fpu/softfloat.h        |  18 ++-
 fpu/softfloat.c                | 242 ++++++++++++++++++++++++++++----
 target/i386/tcg/fpu_helper.c   |  30 ++--
 fpu/softfloat-parts.c.inc      | 152 ++++++++++++++------
 fpu/softfloat-specialize.c.inc | 245 +++++++++++++--------------------
 6 files changed, 459 insertions(+), 235 deletions(-)

-- 
2.43.0


