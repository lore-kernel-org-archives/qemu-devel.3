Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87370D15DAB
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 16:15:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQpVU-00049U-4T; Wed, 03 Dec 2025 11:15:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vQpVS-000498-64
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 11:15:06 -0500
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vQpVQ-0006Mr-En
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 11:15:05 -0500
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-3ec4d494383so4723228fac.3
 for <qemu-devel@nongnu.org>; Wed, 03 Dec 2025 08:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764778502; x=1765383302; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LvUTqpShIK85FdjJOAtQkkZveszbqWEXF6b8rHH6eb4=;
 b=M8k9Fpr+p5hs2Yccpx11XpsISume35FLy7fbydGanrhiKZgzjx8Nb4N/i+p4fCDhlq
 K9HSElGYgecQkXRi5m2Ja5vamSRn6+av8xqXyfYrGTIPWoSdrpctHfZDORwwj01IYn7X
 BfAyEPnQS8Jm627dkB+V2RsI2FqIaouHL/fMbq7X96kiOLfoaID88AivHvRieg3bptVq
 JJoTv7uf3yyMe12bNrwzZI4gkPN/TbCkR5f3BLZH/QJvWqqaK1h7gAMsz8IN6/NFShnO
 iIDcyjSKHVuQf/em0yFkbq9xohwuXd04PSjgHAHa1vWIM9J6n5DqXvc5hUX1LJA2+OQ8
 N30g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764778502; x=1765383302;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LvUTqpShIK85FdjJOAtQkkZveszbqWEXF6b8rHH6eb4=;
 b=likOxIFb46hJuOC+FOzvtq/ev8MZut7J/QM6lnnXP99GNPa+lA9EDXQhhxZQebK5AF
 epnnQ2BRdeF9LRqBkJY8i0qEhLC5aSbKxBVqVfxd6q4yd3iJnDZbtWopQl66TrH8qrrr
 0jJ/pbRDoDtjYlTv0c2w1glmJLaWRuO440vtTLakUBfJ65AbPnJ4rAnM+slMyTtb+QLG
 Xpc6HUG8XZEfUlbgH8P50MUgV8mAt/vyBfYM3TXA3iEQbz+Oji4D76YbbbANi1ZOxusa
 ObYnNRnzANoTnQbvbof6NxmE7leCc3tKBMwzU0kqX1OJkKLO1zPfdwnryui2mqFjUXyG
 dQyA==
X-Gm-Message-State: AOJu0YzSk3Tz0qtw2/ieOe5nkZiG/IOVELs1+gSm3ZUjY+pqcKrtOzg8
 LkLXfavFRaH8NAjgokonZD0zZvC+vuEwamFWv59UKz6RMdiarO4J+1s+XZxnw9ETiME0Ne3H49R
 fJ5LdvP8=
X-Gm-Gg: ASbGnct1nxp8fKujis0NMSyfX/O3Fu8WwXvmEz+Jbp7ocFEa6tV6/NyYhYeHOWVEL3w
 Q9SEuZmXEEh+Pn/wY4CKiCv01gwvdBMWj5qvk2fvy687J3J1lVRvXs+akjJFsrFUmArf/C+BxWL
 zhDsR+qrQLGEFc74bn0TfMuAnV5JBznlzr/IgOaZ1IA4E+yqOujQCzhnvxFi1KLN2/IauhzUjgc
 g55m1FYcH2f9tjYftIor/4TXj4JXg9oyXwMND+3gFYMzbvAIFkctDxUp3CZUl71PV8VrC5mCuG6
 fTe1mFKyhM8MUX/D6VFJJvjmhAMQ/9sshq+0Rb++xh8jz3Hz7GTQuti+o3v6mrmq16d7gUhbw7h
 0pxKJsxOl0DTwROpgGi7qxIa1bxuJmMJ8PN5lXpH2mG/bdt6rib1zrj7FobPZZkLG7M3zz5lkH9
 U3eDdtFEpRCfydUbNAaw==
X-Google-Smtp-Source: AGHT+IECDka/5D+z//2EGLCvqq9QvwCJlI7pdSfBRPgzaVmIepaq5ZwMnK3Tln+7i68CBz9WmNho1w==
X-Received: by 2002:a05:6870:d6a7:b0:3e7:e20a:39fb with SMTP id
 586e51a60fabf-3f16913f752mr1789919fac.11.1764778501709; 
 Wed, 03 Dec 2025 08:15:01 -0800 (PST)
Received: from stoup.. ([187.210.107.189]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f0dca40d4dsm10141625fac.9.2025.12.03.08.15.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Dec 2025 08:15:01 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH v3 0/6] tci and macosx fixes
Date: Wed,  3 Dec 2025 08:14:53 -0800
Message-ID: <20251203161500.501084-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x35.google.com
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

Changes for v3:
  - Skip v2, re-posted by phil,
  - Drop any changes related to maybe_extend_addr64,
    since the atomics are using helpers already.
  - Drop some changes related to plugins.  This does
    duplicate some code, but simplifies temp management.
  - Don't extend for 32-bit tci hosts.
  - New fixes for other failures affecting macosx.


r~


Richard Henderson (6):
  tcg: Zero extend 32-bit addresses for TCI
  tcg/tci: Introduce INDEX_op_tci_qemu_{ld,st}_rrr
  tcg: Remove duplicate test from plugin_gen_mem_callbacks
  tcg/tci: Disable -Wundef FFI_GO_CLOSURES warning
  include/generic/host: Fix atomic128-cas.h.inc for Int128 structure
  include/aarch64/host: Fix atomic16_fetch_{and,or}

 include/tcg/helper-info.h                     | 12 +++
 tcg/tcg-op-ldst.c                             | 96 ++++++++++++++-----
 tcg/tci.c                                     | 19 ++++
 host/include/aarch64/host/atomic128-cas.h.inc | 12 +--
 host/include/generic/host/atomic128-cas.h.inc | 24 +++--
 tcg/tci/tcg-target-opc.h.inc                  |  2 +
 tcg/tci/tcg-target.c.inc                      | 14 ++-
 7 files changed, 138 insertions(+), 41 deletions(-)

-- 
2.43.0


