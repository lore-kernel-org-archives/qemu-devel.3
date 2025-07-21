Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 702EFC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 15:13:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udsBi-0007F0-Gx; Mon, 21 Jul 2025 11:12:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1udsAi-0006EI-UG
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 11:11:21 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1udsAg-00042y-KN
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 11:11:20 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-23dc5bcf49eso54977565ad.2
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 08:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753110675; x=1753715475; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=jXhZxO5Pw8UV70WpgLujmKeMRmQ8N24zT5/byREqzSc=;
 b=qTzBWUngAT2mpJcc/7u8tnZlEfN/rJe/e7k+LEXWIGiAYPJtZaE/nCElgeyz9Rnz0N
 /Fd/9ccCfjKuFZc1n1dURl/NFaF4GD6jxAX4vxLxP5fyydJJD2y5eZcgpZRPYhMYrbbJ
 26RTleJLhLTJYKkWuFiFCqIN5Abqe4bxZ5g5MKJJlqLVHn5NjANRRXqNUuCBQZZf7rYd
 HpZYyWBi3yI/mbYxaZUPjk4qUHQblUazatM8YdrmMwgTAsdMElN2/9Ab894D0rIP7rWq
 yXCt4DkpMJ3/s/jO5hwdN6JqYSLNaxVXcJmNxKD3UFc30ar7n5YR5rtrkUA3keUXj7D3
 +Mjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753110675; x=1753715475;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jXhZxO5Pw8UV70WpgLujmKeMRmQ8N24zT5/byREqzSc=;
 b=FOt/mC0uptQu/MhxKrTqmSywTfKICkGod8a+JsUYfYmpGqFvU0pi2l5F5VGJ20dO9c
 Pupfqc1AuaERGSpPYAxsVfht5YbVK3HVHuSsOiAtbsUsspDUiWtsINan98qRDwQxnQdl
 nOou0zVfOUQc7ocoPg6dZeCBmSfAH5N5kCaDlWdrEJRoVU4UDcd9OCEdb4ES3769P75q
 2ro5dwgxGneGyX3geU8eimRdNxmGhNDYUKv4JB3HKsEjc54TiAGMTyDD3DWL9siRqk5i
 ms+Kzr9aTbDicGQRMJjh0dXwQxSGDSoqeqNcS9b3Y93C9GibsxsDVSFs60K2+/Q9I0uL
 Yceg==
X-Gm-Message-State: AOJu0YyFWbcXHeM17bePWajF6RJfKcUeOh1P3awwkhcRMJerW0G2szhd
 ddmdacs1ArfcQ9PH0xKr3RTW6IcJC7Z2qrcmwzzNsUeNXGLRrdkwhEb+50fiKxEVLuqocLe5dkf
 yo8+A
X-Gm-Gg: ASbGncusB3R7fwFEVq4m7slonqivmtIARs6oGxt2Lg5FdWz2+9J/BLenRaq4XyhpJdp
 FymXgKyv5l2qtOGLpE6yGxdPASQ0qLe4PxsKpST/E+6PcmIw31kdtKS895RpU8pTavOlE5k41Ey
 YkwNAzwUTPq4KUuYYn+np3d7D3R0UYYh/JbzQpk8OrkouEZpZUZCJQBt3234bwXrrpvWbCuJPt3
 c3RJV+q2KckRu1pPx9DG62TEeH3yJ6sxJtmJ8QZG69vSdxOLGBPAThcknFvitTJipswvsuM+aiY
 lEAx+7KZqiXJS5ghV5p+9uuiCQqzmZ5pmftHZ7Mx+MOeI2Fz6joffUCzTCcpOJSNZ1+D2Gn4RB+
 FoRHwOS94R2IlU9Kdp78vpTwOHyCw
X-Google-Smtp-Source: AGHT+IGHRvIVoxqL0p4iEnpHJ5ZslInjXyxYdNwoI1Oka5sOlPlL4arJ57klXWEXejhcwdlixO+QOQ==
X-Received: by 2002:a17:903:3c2c:b0:234:c8f6:1b17 with SMTP id
 d9443c01a7336-23e3035f29bmr301665455ad.38.1753110674858; 
 Mon, 21 Jul 2025 08:11:14 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23e3b5e2e30sm59953485ad.2.2025.07.21.08.11.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 08:11:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/1] tcg patch queue
Date: Mon, 21 Jul 2025 08:11:12 -0700
Message-ID: <20250721151113.56372-1-richard.henderson@linaro.org>
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

The following changes since commit 56a3033abcfcf72a2f4f1376a605a0b1ad526b67:

  Merge tag 'pull-request-2025-07-21' of https://gitlab.com/thuth/qemu into staging (2025-07-21 06:34:56 -0400)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20250721

for you to fetch changes up to 2c047bdb77e8f636936edd9ac5000521c9580477:

  tcg/optimize: Don't fold INDEX_op_and_vec to extract (2025-07-21 08:09:04 -0700)

----------------------------------------------------------------
tcg/optimize: Don't fold INDEX_op_and_vec to extract

----------------------------------------------------------------
Richard Henderson (1):
      tcg/optimize: Don't fold INDEX_op_and_vec to extract

 tcg/optimize.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

