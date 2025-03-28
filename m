Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B09A4C36013
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Mar 2025 17:56:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyDva-0007Is-Fh; Fri, 28 Mar 2025 13:55:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tyDvY-0007I9-P9
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 13:55:32 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tyDvW-0003KA-VJ
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 13:55:32 -0400
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3fa58dc37c5so1918933b6e.1
 for <qemu-devel@nongnu.org>; Fri, 28 Mar 2025 10:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743184529; x=1743789329; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=M+S7a9QC5YKsggE51++wQSF28OMoPxK47/MhF/n7eFE=;
 b=EVGXECG9XMhbv9G5aFiVoDsz5gS/eDZxU09aTJy0j4sWUZSl1fXnNM7Z4v6PF1omax
 k9e1iX6RqCTRQ7FfrP/s0NOd5T68CK4LInG2o6haY7nsSvLUzIU0Oc5wsXX4N33/laMT
 DDH8vVrK9EOxh+D60Zl3Z61tYxgIo7V5qkhP+PucYbu6fCAzefYcC1VC0VsOCL9M/neB
 ZPYJRQdF01pYnDiFlbKRzEiUeWN2gWVBCVLH3eISR2a/Sbqp7lhgAOCJxBJq7IModoOy
 wIb4ahKaspoQ9HLs9rSBzxxX5hgJ8/5dB7Gozx0e3X2iiQvv0QvAewaxoQODsJDWZpgX
 +cMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743184529; x=1743789329;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M+S7a9QC5YKsggE51++wQSF28OMoPxK47/MhF/n7eFE=;
 b=jU9utUgJNDNiP7MiILpjoKwnu7YAtSuWJknB009/asfGZVYghL8W/nbsCiv721qMkO
 FWSnfk1txPD5IVy0XgqiMHbrg9JLNyAcq8ohRg2uuVMVDCmvvGHVC38gxU0GiLYMOafy
 xp0HThTmOMzIN/78t4LTp0crRmGO53SQJbeovT24Cv85u5Xn91cm8eaJV44BIqlrvM3g
 CZg4jgm/KPipfK7K+utbsUSLi7JbMcPxTx41BRE15WFXDFJbOPox/u5KrCkXEQUmybKH
 oWdaL8xH/UtQqVt1AmIjox6Z6r8tyPLLRsMRIVSKaxCqwnV6rAI5QLfJDxikWICSATdC
 /Xxw==
X-Gm-Message-State: AOJu0YzQPu5S1OVsoaeW8L9ttyKigryOvaDcU7ckb8e0jxM1PqyCGU4w
 wS8FK3i+fmg0/H52DRI27pmJ1pQYiHT/AsUf/TuhUBqynT2htYgiJIzXWNIdF5sTBqWufWUPuy3
 W
X-Gm-Gg: ASbGncvlD2rqznVs1dK6vruCSekbAMBsRbIaBnquh9u3mODYHwvy+Mco8pcjHlb1U/u
 1wRIjmxRcvHrJbSXmviqIDibObk/rW8WmJAFliEJRVMrxuv+tcOcQ3wLqmIYBVhxnbCL5kIsyNI
 vMxYWb3SNyYgvSh7hljyw+jDNMZRtMuw27ZEJUPQSZvlrutQ8e4Qq3/tXk3rqUaLXI57oUrJV0/
 4wVJeeal6PN4FBJFjrElxj149gmIX+d7u/t4D0oGT1trjnLUvGTecZChAJ8Hi7SX51B5/1911XU
 xiTrcTTPEccfY2/pYHKLOsz1bM45pCLqi0lwj/7pa+WwCvy2nm+J+/kOFR8vgW1kg2satH9S9JA
 60Xp8FjLvrBs=
X-Google-Smtp-Source: AGHT+IGa8soSS3fUfjV/HA50iD7jnBGglfeFpemP+xrzphQAkMDe43uvBlQTqvWCs3AcFOhL46oHpw==
X-Received: by 2002:a05:6808:2184:b0:3f9:aeb6:6e92 with SMTP id
 5614622812f47-3ff05cab70fmr2069844b6e.9.1743184529129; 
 Fri, 28 Mar 2025 10:55:29 -0700 (PDT)
Received: from stoup.. (syn-071-042-197-003.biz.spectrum.com. [71.42.197.3])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ff0529511esm410338b6e.46.2025.03.28.10.55.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 10:55:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, chenhuacai@kernel.org, jiaxun.yang@flygoat.com,
 arikalo@gmail.com
Subject: [PATCH 0/3] target/mips: Revert TARGET_PAGE_BITS_VARY and bug fixes
Date: Fri, 28 Mar 2025 12:55:23 -0500
Message-ID: <20250328175526.368121-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x233.google.com
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

The logic behind changing the system page size because of what the
Loongson kernel "prefers" is flawed.

In the Loongson-2E manual, section 5.5, it is clear that the cpu
supports a 4k page size (along with many others).  Therefore we
must continue to support a 4k page size.

While in the area, I noticed two other bugs related to update_pagemask.


r~


Richard Henderson (3):
  target/mips: Revert TARGET_PAGE_BITS_VARY
  target/mips: Require even maskbits in update_pagemask
  target/mips: Simplify and fix update_pagemask

 target/mips/cpu-param.h             |  5 -----
 target/mips/tcg/tcg-internal.h      |  2 +-
 hw/mips/fuloong2e.c                 |  1 -
 hw/mips/loongson3_virt.c            |  1 -
 target/mips/tcg/system/cp0_helper.c | 32 +++++++++--------------------
 target/mips/tcg/system/tlb_helper.c |  4 ++--
 6 files changed, 13 insertions(+), 32 deletions(-)

-- 
2.43.0


