Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7711EC27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 18:15:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKMJ6-0002rE-Nf; Thu, 20 Jun 2024 14:14:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sKMJ4-0002qh-GH
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 14:14:46 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sKMJ2-0000AM-LC
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 14:14:46 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1f862f7c7edso10455105ad.3
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 11:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718907282; x=1719512082; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YAijQOVnS5jU0EMoUj3MvNmIscSmYw6vA5W8YVXxlec=;
 b=QNRVdGyBWANx8TK8cIYYdxFSYXOmnJjTSkqWp41wP20EnGtPa1a/o0mMgt1/7ptZKF
 5LrMMrlxjkChSHU2JHds+MDlIwYmJcLmYgDLT+xNUFYd6lV6kCVjUkzhW+yCePagP7KZ
 ZwLrswefF0WSX/nl3JAPv5zIP1sxW24+MxLbH3SDobNFjMsmFhqbRKKrVpPhi5YVSwMW
 F3go9d8hv7XMI1Bh7ABSUMx24dWfrOwQhjcVLtdt/+sc5p3iBJIOXobGYhGFBhflrxyo
 pSupWdLDeBPcuQez0lD9/3sAWlFPHYwTi+3+0tu6CuiKHQaG3CuT+HtTNrApybTWgV61
 rmCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718907282; x=1719512082;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YAijQOVnS5jU0EMoUj3MvNmIscSmYw6vA5W8YVXxlec=;
 b=PZhy8SbpncxmDcuoITDSa1tqEhrcuIIsIf+wzx/sq+F0+gLvN02cmBD2xySQcTkE1m
 rNuhKi3Mt8B7W4V0pRUJWkD75+uiBrDfGmxfHiw2PEAEv1AtS7onRXjifDC+yCJ81PsY
 OjBWPxtCrnCxyBeH6CmrBU4ckq6rQ1vi/JZiYfZoz/J7xBMFKD7wqRjw0brAmzsmNTmw
 o/1xNl8MmAwv6YEIa5LE5J+YnxuvJ609gDIaX/m4Agry2urLg54bIvkguM3ARWE/x51s
 QU+cbbqtftKHX+vpbtUjyBnh4L6MIa2sMOacDEH+LBWC6gi4jUnAIjCnDQl0q0/gdUZk
 kVew==
X-Gm-Message-State: AOJu0YwWgDq+XhaIUVmy9xfEGgSwceiFmv/wiPtLk1a+SNeNQpVv4/Ce
 fFMfr8GDfUdG2uYdyt2s5MkIjda30FaBKifZ1Lh85eNBogVMR6FvUM5h6MX+CgFN/yeDQwJBZcj
 g
X-Google-Smtp-Source: AGHT+IEE2WK8NNXBmkRc5oL5lfTxHqjSqLvzfxL44xk4rCfOqhn+rtADIcS4Gd4jLlsKe0acQSPw9w==
X-Received: by 2002:a17:903:2445:b0:1f9:cf2f:507c with SMTP id
 d9443c01a7336-1f9cf2f5301mr21377515ad.41.1718907282488; 
 Thu, 20 Jun 2024 11:14:42 -0700 (PDT)
Received: from amd.. ([2804:7f0:b400:8dcb:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f9d6b7f403sm13628255ad.200.2024.06.20.11.14.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 11:14:42 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, alex.bennee@linaro.org, richard.henderson@linaro.org
Cc: philmd@linaro.org,
	peter.maydell@linaro.org,
	gustavo.romero@linaro.org
Subject: [PATCH 0/2] target/arm: Enable FEAT_Debugv8p8 for -cpu max
Date: Thu, 20 Jun 2024 18:13:50 +0000
Message-Id: <20240620181352.3590086-1-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x632.google.com
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

Enable FEAT_Debugv8p8 on Arm 32 and 64-bit max CPUs.

Gustavo Romero (2):
  target/arm: Move initialization of debug ID registers
  target/arm: Enable FEAT_Debugv8p8 for -cpu max

 target/arm/cpu.h       |  2 ++
 target/arm/tcg/cpu32.c | 34 +++++++++++++++++++++++++++++-----
 target/arm/tcg/cpu64.c |  9 ++++++---
 3 files changed, 37 insertions(+), 8 deletions(-)

-- 
2.34.1


