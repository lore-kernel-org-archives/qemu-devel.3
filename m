Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1817CD8CA4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 17:17:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJawZ-0000bn-CW; Thu, 13 Nov 2025 12:17:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vJavg-0000SF-SS
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 12:16:20 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vJavd-0006Yr-UH
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 12:16:15 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7aa2170adf9so940799b3a.0
 for <qemu-devel@nongnu.org>; Thu, 13 Nov 2025 09:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1763054170; x=1763658970; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/+VeEoZv4V+FvSeUptBC/KXfvYsV2MVEcENr2lwOWwc=;
 b=mZhI6WYi05KFUdNsihfeeEavp+lBpIry/Jn+nApxUA8s5Gy/DTx99SqBEoc9B3b0Dm
 jTQlcGXvfV0X0wW1KTS0Lm6KVVKU5+tOYFY+LhtPmqNQ3BixT0v6RemwhcBSlPyWeYfz
 BtxBBjOy9gHsxl/004N2KcfM2V/39hLVB1L1/ujSWilWonbgcgtLuzLSbZBsCmq1FfqK
 We8VUdazr+oQRGVWVH5EwB+XpfdPQzY/Vy9cLFA5VJ3Z2PjTQeSyJDakRqp3vt4OV5zL
 bL1lQbJ8Mmrf241rSkG2wjAzTLgv/wFk5fF47FWvOeODNBciyZz2rUK/tmdz7sHZmydf
 jEOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763054170; x=1763658970;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/+VeEoZv4V+FvSeUptBC/KXfvYsV2MVEcENr2lwOWwc=;
 b=KmGyDapaUaP8Q5T5I5vwomZ16WcX1TuRUaLwu2/gmy5GwLjdnP/St0lecWsUYrRXqU
 +58YPij9MeFVMGPQ5DyaIdTelMJNAZpvURGbotMXgn0Q7HhgirgQEQhbnNu8SflYWJWI
 dk53fyDV0f9gmZsRI15yyf5a5ulSV93dgnao2PQTpuvTnr+a6Q+c3mwzijKDl8350Z1L
 Mu36QVX5pg10flKYoyA9mNdOHwbjNCxxu0kwfYiCS/9aJxn4vjKHbVEW0/mRryhTGkhR
 Wy+w6ojvKkGewhCC5JUBx2Y2GLh9zdvPaw8PlKxKqRr4aKFXwrCRqab2JqkLyq5e3q6n
 52LA==
X-Gm-Message-State: AOJu0YyB4M9TmEbBrNim/DMD6Sphpfr97UXBAuqpdRBQBZGF6ZZbssw7
 cbjd0a+e0sQ9hCPWW31IOq9VNSSfVFTEGOBrEtg0/Pj8SqDeQRL5RVE9PihE+L/ub1CgRgUtmHo
 ddxTAd+c7b+nfQWfNwLXGITS9tAzusuh2upOe/zwFl83Ba3wOM1vMZ9o3EG77S9oVtx2vEnCnfm
 SheI3JdLMTQOAwpWu+HfmqzXhffxz5JU10COW77/lCig==
X-Gm-Gg: ASbGncvwwCle4JM7JfRuxfvAhKKX60U0fLhYyQ0nG7foiMgOerP3pYtA+5HdCAjMr8b
 TFYS1XiySYrA9Vz/7efHMHauViKtkWoN3vPg7c+NbnHqAeqoLiPvtq0ia//YseSYbMCQ+SvLB2Y
 SNV5TvbnTeUED/EruhQfUD3MHIvgg9waKGEQydEvDifhyYqF7d8KGPdFlm12Ll3C14gPeOs6HBh
 +SjYaB5CUglZ8itLnpDMWGnOaIFZ3z08PxEQb3SQa1Y3pPXYQ6Vp3Oe3EqCTYXNALWKLv12osWe
 +PV2OX5I7DQBfAayWJOVLx4jWyrkTxBWnIYfyBHV/Siz+9QxriQF8kTzj8IJy5GU68lyr734tqx
 w1ZUON30E1BuTz99nwmKgmcOQrUv/aWS4Cm2GqEdXmkUHg1+pVUKH7x2MlZ1ZTkUwEM8xQeu98r
 j+nR1iTtlv7IBaNJyhpESV3v50LPpyg4cVYRS4EdGTdf0O
X-Google-Smtp-Source: AGHT+IEHBFRC8Ia81Bn5aRJ2lYYjp8s4iP0yWvKhtWNg3wFs/RKokcr091JozWC+cLaNiUzGS+mpcA==
X-Received: by 2002:a05:6a20:3c8f:b0:343:5d53:c0ab with SMTP id
 adf61e73a8af0-35ba0994bf2mr439167637.20.1763054169896; 
 Thu, 13 Nov 2025 09:16:09 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-bc375081023sm2712992a12.21.2025.11.13.09.16.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 09:16:09 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH v3 0/3] Fix some more RVV source overlap issues
Date: Fri, 14 Nov 2025 01:16:01 +0800
Message-ID: <20251113171604.3034161-1-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x432.google.com
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

This patchset is based on the v2 with following update:

* Update the commit message to distinguish the affected rvv instructions.

  Reference:
  * v1: 20250415043207.3512209-1-antonb@tenstorrent.com
  * v2: 20250627132022.439315-1-max.chou@sifive.com

Anton Blanchard (3):
  target/riscv: rvv: Apply vext_check_input_eew to vector int/fp compare
    instructions
  target/riscv: rvv: Apply vext_check_input_eew to vector reduction
    instructions
  target/riscv: vadc and vsbc are vm=0 instructions

 target/riscv/insn32.decode              | 10 +++++-----
 target/riscv/insn_trans/trans_rvv.c.inc | 26 ++++++++++++++-----------
 2 files changed, 20 insertions(+), 16 deletions(-)

-- 
2.43.0


