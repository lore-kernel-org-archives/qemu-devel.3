Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E5F0C8303C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 15:43:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYnzD-0005b6-29; Mon, 07 Jul 2025 11:42:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uYnZR-00056P-RF
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 11:15:54 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uYnZP-00024g-Va
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 11:15:53 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-72c27166ab3so2069479a34.1
 for <qemu-devel@nongnu.org>; Mon, 07 Jul 2025 08:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751901350; x=1752506150; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=exK5udp98SfjYm/ZGWW758+vLIc1xsfmMlQkHBhSgwY=;
 b=hHr8ck4PXxD5GPT8DQjDTThiPL+vwvbruUFyLIOC/axizKvIuXDEBDIK/3y6Nmku5R
 Ml+nZyBYMBAT2+m96z/eDIdxySeUAVfMli1P/cnLKTWkOy/EU4oyzbf98clb1w2pzqQs
 b00v7bqv4hIb0TaVVrOiig0oZItIHd8nOY8fFnTRELvuwqQTjeftYDm/sPZmyTaUw5G3
 iTLjpFFN/Ex1EgP39ZTzidLh2QqbvnU9EUkRE8zycJxYUUEEzK2gy84ILXIKyVoL+9Y8
 mZiTGw83lvn2WXabR0tO5eN6zUibVVnhks+dNvrWnTk1TyF4BSiH0oVExfOQ3MD2CNev
 sKUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751901350; x=1752506150;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=exK5udp98SfjYm/ZGWW758+vLIc1xsfmMlQkHBhSgwY=;
 b=VqWhGwFulgf8tU738TPiKP4LxLQsBCPcp29nh3d/lZIej7uxRCe2ubxVYhZgi2bpY6
 9cL+Ne0m4lormIPgFFRjb0fmIxXQaaco4DKnPRNmHd/oY4pNU/o3xlbIeQ2mtYMmQoE/
 F2D1V9MNNy1Ot5uJVSft8+mNXuO7Mo/vJ/eaPDD7FPHJWh+KDqAu/6emANbO9bnIfSr/
 /s5ymezT49vNdEQii/yHXk0iHlgCEbdqck+pS5pVIWyc9YIcbsL6kzV9su26kvOHfVNV
 bBgrX1PU5rpVX+2ukIhUvaQ5q2HLFKubaS9jq5h+Id1mKMwDNqDisHWieSoESts6Vqgv
 MvWw==
X-Gm-Message-State: AOJu0YywxvRwzjGpfXW4xWT3EOBX8X4gCHgyx48Iikc0Uvaqrt3d9rz+
 hQi3WRxNW22YzDRon31rVPhByMlyrVga8k62r+RRXt4uLZ2aLHEwF2DrB07qWqVD6jRS9xPBL6J
 fDE6mq7g=
X-Gm-Gg: ASbGncstxW3dpOuXvWHHPT7bRNQ65VNSvObMYr5nqqBwwgczIEcjOP69WPAdID6FBG9
 nxt4sCBnw7VfCfOTLDrvZbCPhdqqd9TrgVrC0rT5eiHXjq64SF3JMa/QcUK4AuLAbxADsBjWop5
 2gG4qaJvBnex3D9lW9HuhP9RqXrH3Xir/gOypYuCtM8FVc14iGHv4Bv8gXGs9cDPxNsxWthQGLr
 oWKvsU8Id8VbO2K7x5c8l0uWqOz8KWwyTvHDa0H1gsx7mbZaaFrODZmp+KzmktC5FWBwLmorhO+
 94Qe4bSQt0gOUkL3nrh8AMPhyYnraaUEHVtF8xku0N6ybiIpQr0c0O/l3zN+bDpnSztxL8W5736
 ADQhvqcoc2tHc41HmiNIzR8qXFjFpK3wUSDKuVESXkFHf5cLp1RIHMs16YKM=
X-Google-Smtp-Source: AGHT+IGkHY/tinfvhRC2Ic9o5v/E2Y0i2AEJY4rfV0sILm597w611NuudBbFjgFSBXIKfmlPvgmwnw==
X-Received: by 2002:a05:6830:b90:b0:739:fe21:42ba with SMTP id
 46e09a7af769-73ca1311522mr10304825a34.22.1751901349658; 
 Mon, 07 Jul 2025 08:15:49 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2f7902d65f6sm2236393fac.46.2025.07.07.08.15.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Jul 2025 08:15:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/3] target/arm: Split out AT and PMU cpregs
Date: Mon,  7 Jul 2025 09:15:44 -0600
Message-ID: <20250707151547.196393-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x334.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Rather than the wholesale movement of cpregs out of helper.c, split
out two subsets: address translation and performance monitoring.


r~


Richard Henderson (3):
  target/arm: Drop stub for define_tlb_insn_regs
  target/arm: Split out AT insns to tcg/cpregs-at.c
  target/arm: Split out performance monitor regs to cpregs-pmu.c

 target/arm/cpregs.h        |    3 +
 target/arm/internals.h     |    5 +
 target/arm/cpregs-pmu.c    | 1309 ++++++++++++++++++++++++++
 target/arm/helper.c        | 1805 +-----------------------------------
 target/arm/tcg-stubs.c     |    5 -
 target/arm/tcg/cpregs-at.c |  519 +++++++++++
 target/arm/meson.build     |    2 +
 target/arm/tcg/meson.build |    1 +
 8 files changed, 1847 insertions(+), 1802 deletions(-)
 create mode 100644 target/arm/cpregs-pmu.c
 create mode 100644 target/arm/tcg/cpregs-at.c

-- 
2.43.0


