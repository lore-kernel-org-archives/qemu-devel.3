Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5F5CC41513
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 00:07:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQyN9-0006LZ-GH; Mon, 08 Jul 2024 20:06:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sQyN7-0006EI-NI
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 20:06:17 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sQyN4-0001uY-MY
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 20:06:17 -0400
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3d9272287easo1448817b6e.2
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 17:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720483573; x=1721088373; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=c2OghkTw1REHAEP7vFDrkBLyXaG/mrWqn8cqdHwsYNY=;
 b=UnmN4803oYxwwYL9hfrs5AsUDKzNg0YldSqDuQFGsAmAZp6+ocxyAFK+DuCrnzyi5Z
 WXPZjlnjcjPO45ZzCD5B1xYSp1SZ5VdwcjaikuRrL6bHq9WZIyWyuQw1aoAPh9/Av2ol
 0XyyLlx33t3/pS3ct/Qb+Blc190+UJCTnAwxcbzbaPF4OThrg35rt617Eu8JoTi140id
 jdGzzEX//9GAFVhH/Mmm4DnovUv1/rCI3G/aPfCsfTMNyyArv2FQZCf/o47IiWhHA4xW
 8M9WBBlqDj7E+IrMnlPocJ9d755x3E5ZXVS/LD2oZrZTLOWM/zKMyC416AYW+s1oQHOa
 PDHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720483573; x=1721088373;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c2OghkTw1REHAEP7vFDrkBLyXaG/mrWqn8cqdHwsYNY=;
 b=styGATJsTfTs6cOJx+0aLTzfiIZfkQoGNX564h6u2E8x9YR4nCbukNQDbHxYk/eUM3
 9Yl9BuRxN7BDDZR+TM/xgSnXY/SZhFAiEPnH6FxV0RadNy3NFRyakT3LIpJCemJ8xjMW
 tcfKbUoFPGjVyOQi43ScBIAdR2VRLfPic/FDFd/vgLMYtJKnM65V/Qd1/Zc+++ZGHvuJ
 VpgBYwLWwEwL4j1KFt3PBkOPnWcsCXD/VfKMAQ3e4ellrUp2cHF84qVWkw17f4l+VH25
 EPqV6oqZLyIjpWyjRZfylTJypKkc+Vg9ImFCAknz32ny3i6kZ4u0Kr9JH4PJLamVkAYs
 9klg==
X-Gm-Message-State: AOJu0YxM2JkK9yx291Gz58GY0szxwoS6zVE43UHgbZ/G8kcTUVRSTLOg
 XzWtcjQa7h4CqCXYLIgp3lMXqZDSjoml+kSWHpXz384do8JlIG4lcgZDJNUrMPmCZblBgcr8W7l
 e9c4=
X-Google-Smtp-Source: AGHT+IEsSZ9ciWBHrsN7RdKi85LgiZ0MnCznNvUBOBX1ZcMJGVvMu/LE0/R0KVVVC95dhD1IogxiMg==
X-Received: by 2002:a05:6808:2005:b0:3d6:2de0:8507 with SMTP id
 5614622812f47-3d93c07acdfmr831396b6e.41.1720483571992; 
 Mon, 08 Jul 2024 17:06:11 -0700 (PDT)
Received: from stoup.. (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-77d682b3fefsm316617a12.76.2024.07.08.17.06.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jul 2024 17:06:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [RESEND PATCH 0/6] target/arm: AdvSIMD decodetree conversion, part 3
Date: Mon,  8 Jul 2024 17:06:04 -0700
Message-ID: <20240709000610.382391-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

[Sorry about the @qemu.prg typo; resend for anyone replying.]

A small set, but better than waiting for a larger set.
It's a good stopping point, finishing the convertion of

  disas_simd_three_reg_diff
  disas_simd_scalar_three_reg_diff
  disas_simd_indexed


r~


Richard Henderson (6):
  target/arm: Convert SMULL, UMULL, SMLAL, UMLAL, SMLSL, UMLSL to
    decodetree
  target/arm: Convert SADDL, SSUBL, SABDL, SABAL, and unsigned to
    decodetree
  target/arm: Convert SQDMULL, SQDMLAL, SQDMLSL to decodetree
  target/arm: Convert SADDW, SSUBW, UADDW, USUBW to decodetree
  target/arm: Convert ADDHN, SUBHN, RADDHN, RSUBHN to decodetree
  target/arm: Convert PMULL to decodetree

 target/arm/tcg/translate-a64.c | 1155 +++++++++++---------------------
 target/arm/tcg/a64.decode      |   77 +++
 2 files changed, 460 insertions(+), 772 deletions(-)

-- 
2.43.0


