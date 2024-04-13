Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60948C04FF6
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2024 05:25:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvVrZ-0001sE-76; Sat, 13 Apr 2024 01:23:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvVrX-0001rx-D7
 for qemu-devel@nongnu.org; Sat, 13 Apr 2024 01:23:39 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvVrV-0001cd-Va
 for qemu-devel@nongnu.org; Sat, 13 Apr 2024 01:23:39 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-53fbf2c42bfso1160676a12.3
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 22:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712985816; x=1713590616; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9gZgFEisTuojaEU6BFwPKIxl+WemPaSElaJvjDQjwig=;
 b=pt92eSZ0O8g6iLFsuoDFwc/6W9ermKjnzX42Jq6KeItrIkjPXotikOOVJjJ8qc6IMw
 L56L+FAnYvfImHd9cW/dJI442ofDFo95Lpx32erHPaxJZi301/oSWPkmwrXVeiQS5Bko
 XK8ZNqQBQAs3TBiOXFzzMONaCoL4DQtIeG8QCoFYibbjbXcKkq2ix6AgZrPPc+jJSygY
 ZF93LQPjidFrp6WlqWY3xGyITwGoD6fc3FfTkYWNEdDI7H8cf2JENtWHcu1AQmf7p5Kl
 FFO1eL025y8dfugnHahj1D6dFpYJQeI0kga0XA94vzkhheunBYLF2WlUEzVDSqRonsuw
 GIhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712985816; x=1713590616;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9gZgFEisTuojaEU6BFwPKIxl+WemPaSElaJvjDQjwig=;
 b=ZJT1RDonDQHY0PNumsY+On/H0j9s5DMrKVsnrb7z8JnV75yU/Wr0qkSS0hWg1I3TrV
 z5WzQnzeVtbjLjj+Ioh1f4RpeiV8EGsMaLYsEerP9t5LJqvGgNAvGgC96o07G/bGfUk2
 TVam5Ezorz2A7Bi80tPL2vy3br6vZ1ijnCoGJ4ohRRdr8zInKnGCVFelkPWG/HigSxsw
 cHxkkXHAmnZEyZ/f6Phgw97xZepyT9e21tZL4xonBDcgkRz/PXavCYWXrC+Jq2m3xbVv
 +gIiUKp1loZVn6jKZOQ/zsXediKVElJRmNkO3u58/9g6aMGrc+OPmNa03CS2aGUSS6m9
 9PJg==
X-Gm-Message-State: AOJu0YyjU6HYBu5eGuzkRLIeF4RAg2XvhAyifYjuM3MPTmrFfaOnY89J
 qoNpNaznUq/FS338e4+CAQjpotZJ+nnsmA5hphJemZcTQt0buUhWw7FefA1pA8+3X50FqttsOK4
 l
X-Google-Smtp-Source: AGHT+IH5GISJF3O+/9+kqifJmrFqz5adfhtKFAB9wkCMD7c2H9LgdHjq71PNfDV43lvsX26sMPZQwA==
X-Received: by 2002:a05:6a21:7899:b0:1a8:4276:670c with SMTP id
 bf25-20020a056a21789900b001a84276670cmr5864215pzc.17.1712985815878; 
 Fri, 12 Apr 2024 22:23:35 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 v19-20020a17090abb9300b002a0544b81d6sm3564074pjr.35.2024.04.12.22.23.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 22:23:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com,
	philmd@linaro.org
Subject: [PATCH 0/6] disas/cris: Use GString instead of sprintf
Date: Fri, 12 Apr 2024 22:23:27 -0700
Message-Id: <20240413052333.688151-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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

More sprintf cleanup encouraged by the Apple deprecation.
Probably there's a more minimal patch.  On the other hand,
there's certainly a larger cleanup possible.


r~


Richard Henderson (6):
  disas/cris: Untabify
  disas/cris: Remove TRACE_CASE and related code
  disas/cris: Drop with_reg_prefix
  disas/cris: Use GString in print_with_operands and subroutines
  disas/cris: Remove struct cris_disasm_data
  disas/cris: Improve output of register names

 disas/cris.c | 2498 +++++++++++++++++++++-----------------------------
 1 file changed, 1070 insertions(+), 1428 deletions(-)

-- 
2.34.1


