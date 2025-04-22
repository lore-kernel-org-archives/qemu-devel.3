Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3F01C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 14:38:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7El1-0006b8-S3; Tue, 22 Apr 2025 10:37:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7Ekx-0006ad-Ll
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 10:37:51 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7Ekv-0002t9-Sv
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 10:37:51 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-736c1138ae5so4667664b3a.3
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 07:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745332668; x=1745937468; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5ZLqEuLOyPJkfzxxlGd5ZkTBFMW6eWnAQTYrokcO5Eo=;
 b=C8E4g5gJ4zq11wH42ZJH/ILcKVvJ6uGE3FXsMd+tcVxYO8ttCF1EkvArokriuxzmq8
 DCDOo2uhwouIPWa7F4QgsDT1j6DdeySjm/2Ug5hW1BgHad7OAITIVMfrvqxB+Ayjgeak
 NAhz4g3zsOfB7rvl1L+fte+7icDhRGQUBtMaoR2G6Cy/zpHCEfR6LtqId8xXLMgkjwg5
 wZMWiJ/LsX8Z9GTt0u1gkxry3iyyXiiOI6nt6+taZRVaur4EcFGOX1CGIW+whzEm/wIK
 agjis2bzcWs5PGkmvBuH3YUZ9nJ2ikkyLqLbcXEosf9I+rSqg51dPBlPbIM1ogEt/2c1
 HkDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745332668; x=1745937468;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5ZLqEuLOyPJkfzxxlGd5ZkTBFMW6eWnAQTYrokcO5Eo=;
 b=LSs4fPDNBozi/vCyCzB73jyj5Wohrc9pHZCki5mHaiPBtP8Srcjr5l8T/+4MmX+csM
 kChrjIYfjn9sKAJ60Il5oujs4tYAqHsQvBOSR3nemQJ4Ati9d7sQpzTro9x9Convsb7R
 cQc8jIQ/VtlbiHQoXopjJEjcFcc33fcXxyRcrEaerSIJe487RnDEPi4++cAzfgUYj30B
 RMwvcUw9b7Ong/z1ipWPXcuHsOoJDfrmBvrTEi0GGHcXMmyb9Qh/aYNme0+hD0QlD6lz
 UFlAoSIDUesAJJLP7Ol2RxMP/yT2ZUBWb7k9gmQK1krTplebRQIG40827eqDPHHv8Jtm
 7aqg==
X-Gm-Message-State: AOJu0YzpnDY+xvNDdw4EJI/Jm22ItbbwTHkuTVzUJjscVc3V6/gpjqIx
 tAyRn4REXWtegoyNjzXb3D0tAlM9p8b6MDhbio4NpoiI1RlTfHtgqjkWp8yUHrhBGvPW7yyaVZq
 m
X-Gm-Gg: ASbGnctsGuX1EJx2F9Jl5f8imY6tZ6MGGW5feSoNWojX/l0br52dJEmC2CrpeVYD1oV
 DkpCqXjzZJAb7i6ii+diKeuzWCb7HMA5SgygWrESdcMSCeZpCVk694d5TeFUanGRRduqqnc8IC0
 EfkKulN91g/Qnd4jaZqCOJETkpPQ5dKErdAhtuu4TikQncwXpFGvmbEDAqXX1MAfnXAgLohpWe9
 14bDDMcDcbidDyPWI+X0w8uoM9BL859/8QrRxwUj+qCfZ2FuQsFVPGK6Y47NYbDMxkSDQYxiftt
 DZulqMjIs0DW0Lij4uQvSDADT4+KM7WZ+qqOBTJTdwrw710I5I41ftsc0QgSBnyYffG17ZHqHtt
 V21xrQFFXlA==
X-Google-Smtp-Source: AGHT+IH0uw8gPJfGiCa8WUeh+Y1LVdU5StkGjpIeRE1lVc+xrvfZB/HR0b+N7khBbhNz8UPWNoOAdw==
X-Received: by 2002:a05:6a21:4603:b0:1f5:874c:c987 with SMTP id
 adf61e73a8af0-203cbc4d57fmr22723333637.15.1745332667994; 
 Tue, 22 Apr 2025 07:37:47 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b0db157bb7dsm7375952a12.69.2025.04.22.07.37.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 07:37:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: npiggin@gmail.com
Subject: [PATCH v4.5 0/2] tcg: Fix TCGOP_TYPE in liveness_pass_2
Date: Tue, 22 Apr 2025 07:37:44 -0700
Message-ID: <20250422143746.261776-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

This is a refresh of

  20250415192515.232910-154-richard.henderson@linaro.org
  [PATCH v4 153/163] tcg: Assign TCGOP_TYPE in liveness_pass_2

without re-posting the other 162 patches.  :-)
Adjusted as suggested by Nicholas.


r~


Richard Henderson (2):
  tcg/optimize: Introduce opt_insert_{before,after}
  tcg: Add TCGType to tcg_op_insert_{after,before}

 tcg/tcg-internal.h |  4 ++--
 tcg/optimize.c     | 30 +++++++++++++++++++++---------
 tcg/tcg.c          | 17 ++++++++++-------
 3 files changed, 33 insertions(+), 18 deletions(-)

-- 
2.43.0


