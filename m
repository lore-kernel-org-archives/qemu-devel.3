Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B1E3C48260
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 01:26:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ra41v-00077Z-TT; Tue, 13 Feb 2024 20:25:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ra41t-000769-I3
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 20:25:41 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ra41r-00014R-Te
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 20:25:41 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6e08dd0c7eeso1103288b3a.1
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 17:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707873937; x=1708478737; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=SNiGNE3HiEzRvfGUrQ5BOeoRweXB1F60nk9LGsLbXg4=;
 b=nIlUYGqG645Byl26NdJC6Ss6JEsK7YhCagERA+VZTLsZW8/Z2drSQd3Ldwfz5L8PTE
 M8NFsncXkq+djp++xwdKN2ipllRs4nQoy43ITnzvtJNjaGBZZvcVZwZ6OXNdpXLlwZbM
 P6p/JDw7W7vNCPfVFu3/WTqmqlel00eHs6RzYdwsCzsKtb5kmoyrXkwV0cgji7P7FeWK
 e97OHUSTnrLo5y4+t6oV9geqlHweRCqwLEboqDMQoosgUxbFSRw5W8RRS/I6fG02I6Ji
 jkyzSFBmb7p2k7I2bv7B5EApYhF8G1zk6mhzBSjt1mGRqFhb0S1m8mwKdSX+6FhHb7wA
 QYOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707873937; x=1708478737;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SNiGNE3HiEzRvfGUrQ5BOeoRweXB1F60nk9LGsLbXg4=;
 b=GJ5ZByPgmAhIZm5G53UVzMR5NxRH3h8Tw7wtAC6Ed1A7VXE9f9lwVsndgN7oE1QuqQ
 yCjbbNW366w0DMvAnZs6wYSXHQ79b57rDtAwYM/0SrNlqiSzQMNF2RzsDSRKFM5BEJNQ
 JL/TbZksZmOxrLChux4auXt8Gz9cbU0EEaLVPf6UbHxIusKyz5f+ijWPnbqnx842kHOf
 XMsU62/qVM+I2lB+cgJICVgqPSaq70G0vrWogt3P3UAYLrs8Ha9MreOTkMgrWFs6RN6U
 UB6kpnzeixoqbkoqvEzjwAnsZrJuMsxBSohBGz4994migifh0wxqBZ7iDa7v3omhWmQP
 TLEg==
X-Gm-Message-State: AOJu0Yzl8esSniWsTjnubbC5yQFSZZC2d66xT/C/J0ASkOB/smVCNGeQ
 W96VVcdnRX6JKv/pHSfotHFsAMamYwBDEbvMYDXrjCQLZ4KBy5YSg7uDJ43Sz6O+TmXqJcBxfMw
 t
X-Google-Smtp-Source: AGHT+IEzsIr0n2lvwCZOl4Os+41ZQIinrQVQsKl9Tr7kPPMG3x3Z25+JTC9D1Sbqcv5gB7lMR4V8DQ==
X-Received: by 2002:a05:6a20:e68d:b0:19e:a85b:854b with SMTP id
 mz13-20020a056a20e68d00b0019ea85b854bmr682320pzb.48.1707873936620; 
 Tue, 13 Feb 2024 17:25:36 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 d11-20020a170902cecb00b001d961f28b0asm2660333plg.270.2024.02.13.17.25.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 17:25:36 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] tcg patch queue
Date: Tue, 13 Feb 2024 15:25:31 -1000
Message-Id: <20240214012533.453511-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

The following changes since commit bc2e8b18fba33f30f25b7c2d74328493c0a2231d:

  Merge tag 'hppa64-pull-request' of https://github.com/hdeller/qemu-hppa into staging (2024-02-13 13:56:46 +0000)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20240213

for you to fetch changes up to e41f1825b43796c3508ef309ed0b150ef89acc44:

  tcg/arm: Fix goto_tb for large translation blocks (2024-02-13 07:42:45 -1000)

----------------------------------------------------------------
tcg: Increase width of temp_subindex
tcg/arm: Fix goto_tb for large translation blocks

----------------------------------------------------------------
Richard Henderson (2):
      tcg: Increase width of temp_subindex
      tcg/arm: Fix goto_tb for large translation blocks

 include/tcg/tcg.h        | 2 +-
 tcg/arm/tcg-target.c.inc | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

