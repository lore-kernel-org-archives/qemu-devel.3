Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7FEBC52D7C
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 02:59:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdLGp-0004Dj-CT; Sun, 11 Aug 2024 22:58:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sdLGn-0004Ce-Kz
 for qemu-devel@nongnu.org; Sun, 11 Aug 2024 22:58:53 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sdLGm-0003ef-5Z
 for qemu-devel@nongnu.org; Sun, 11 Aug 2024 22:58:53 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-70d316f0060so3077242b3a.1
 for <qemu-devel@nongnu.org>; Sun, 11 Aug 2024 19:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723431530; x=1724036330; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=F5IYVpzSZ0U9UxZYhFSQtU8A7Jtfs2iGA3kmqgdiJlU=;
 b=e1qlAzKISqhNKweaZNQ+nx41MVbc5aY+UWF6dbrKKrxRw5qchiDiJ17esFUj5bdltT
 pZbEeUQRmjWS8IlUQ+H69jl8N4Xc0hFOBUaXGaCa6esQ0ut5FK2AlmAM+iVR8wcEdJQh
 Qutw4DOtcZ4ahe5M5adNVgXadUEa2Tc0Uyd+pXRnM7K/q2t5eO7vI2ek6Q9gdc5oSgGm
 tt1MN/9hZRegpjyRIYFfeUdFTzcGgugqX93I1Os5P5Ka7iFUNxyyfRFyd0jrr9ogbCpN
 X/7TLl+fK0QN+WNS8TeCFrPoS/ubQznrUM98ZwqA7mAKQIf4+qlL/PQCA+LOLF3mDcUp
 f/UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723431530; x=1724036330;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F5IYVpzSZ0U9UxZYhFSQtU8A7Jtfs2iGA3kmqgdiJlU=;
 b=IHlQkMrqFRpVjCseMwUHVBpa7m+fW1Gz1i3SW29D5FDYo7h7q+q96HZVKx9x5nzKhJ
 pBmQpOOI1giItA3evFDlE7zw49LTO3dhslofzKxOPUDJrJBPnSWXCAGDHhHSyoMbtJXZ
 FgFvnSz4Iy70pKyQ1ZGe3ytLR1RLXGuP1IQNXku36Vx5K4o68VM5OOi96OWZXTiakLES
 MzHmLYyKf7iYcLNN0qKwP8+9kHJTzEvkuARyC6FXltLIp6TEdPNxgTvsAxPsIKd1I0Yi
 uclcMZZIHElkYcAyAQlpTBFg/xnN2acA0puI3/h9YAC1syXd7KeQ1XJyI7gP9TE1W161
 Oa6g==
X-Gm-Message-State: AOJu0YznIuy1E72Yoj2AYCpJpCfBUYSDlTAD8qLs1TBjzJQgBkS6bRmh
 sypl4uIX074jAyo9pH5APTdjlbb53Ga0pOEw4AaC3ABpC0EX2L3/wcwzfMlTKC1yTJc3EqyaS5O
 sdoA=
X-Google-Smtp-Source: AGHT+IFNnVb2z/a/ECRPt71QG6SpCQbfCKb2QDBzE5PwPRUWsfofGddA5Z01W8GuJQntNGstrjroFQ==
X-Received: by 2002:a05:6a21:3945:b0:1c6:ecee:1851 with SMTP id
 adf61e73a8af0-1c8a1f3facemr13171188637.22.1723431530000; 
 Sun, 11 Aug 2024 19:58:50 -0700 (PDT)
Received: from stoup.. ([203.30.4.111]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-710e5a43b49sm2984841b3a.100.2024.08.11.19.58.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Aug 2024 19:58:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH for-9.1 0/3] target/i386: Do not apply REX to MMX operands
Date: Mon, 12 Aug 2024 12:58:41 +1000
Message-ID: <20240812025844.58956-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Fixes #2495.

r~

Richard Henderson (3):
  target/i386: Do not apply REX to MMX operands
  target/i386: Use unit not type in decode_modrm
  target/i386: Assert MMX and XMM registers in range

 target/i386/tcg/decode-new.c.inc | 13 ++++++++-----
 target/i386/tcg/emit.c.inc       |  9 +++++++--
 2 files changed, 15 insertions(+), 7 deletions(-)

-- 
2.43.0


