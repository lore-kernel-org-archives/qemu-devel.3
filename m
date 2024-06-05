Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A150C27C52
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 21:59:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEydd-0001gg-Fk; Wed, 05 Jun 2024 17:57:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEydc-0001gQ-I8
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 17:57:44 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEydb-0003pL-0U
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 17:57:44 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-702508bf0a9so240075b3a.0
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 14:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717624661; x=1718229461; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=blzvfwXxem+jxeMaTZuyFUbnqoY52verEbkq7kNgMiU=;
 b=qGBvdUgCtSZl/2PEHbMYA5FmSMjoYb1re0BEov0RhJxDIVqZgyR5k9qTszaEnjnE8F
 vUp8YzqP2ShW0nbNm21EzTBg47TQ9vGQqyKmfU1SUILulSqAXMtKagvgT0ghI7MCjvsd
 Ob0Hlitj+iOuE+ZRZHCfUWxvYh5hJ3YS7fcnG+VTKVMqGGe27+NaU5TjcR1f9ekzk0rD
 G0w22StSioSSsmFoNxt/zKasIsaQmZV6oZqgl8TsP2xVCjoh3f6I8MQORAocIftlA7S9
 TYoleJLy+kc3ElrtH6BCNnqou1K7pkd/nJvg+mVaUQqlxjlqq1OdxabjFxGs+phSsIcO
 dEzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717624661; x=1718229461;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=blzvfwXxem+jxeMaTZuyFUbnqoY52verEbkq7kNgMiU=;
 b=j4AIunz6UEZbO3FMu5uk2HF1IY1iE6X/wjpydg8XZMxeZx9lSH4e1Hs7vNwFW8UWSh
 S4ZSXqLLP9kXzyKj+/kuJNa9crQNyhZBvu4RBYOJapNJ5Rrz03IF11AyP8mgrJYdbhdg
 TOhw7XrxyF5sk8xd2KUm6Ut/JFoE8uA8gCpj2MfVaP0Z/pGDaW2Xp8rP0unQ/+lh1Xtm
 TR5GzQi0C8/9O7YeuN3vzDPnLv8xf9MwBHc+ML1H4i8Ylmh00IBuPcLZSrTJmG7i1oy2
 bsr9bSuhx5iVYe/ZGqz89doY5b28CWOV0S7rH3XKIFhiTqj1Dpuv9cJBEV3oBTj2qYPt
 xUMg==
X-Gm-Message-State: AOJu0YxKSy4hepGFm7P76q/Zi4HAy4Mex3zd/gVEAGNMN4SoOrKW5nS6
 qmGIruaEDTwaQ5F8JuA2fVLG20JTSsyG2fXwOv7d+evY2rELtjADjq9zrGO/BfhzMzsQmD7kgv8
 a
X-Google-Smtp-Source: AGHT+IGzmBkS2ZPj6Bb+fK9/JNDZC8ZkbrdNvlNRT2cVXQcCb6tCOcnlu8DeHPsHwZxjxkPVAeu3lA==
X-Received: by 2002:a05:6a00:b4b:b0:702:8b18:9fc3 with SMTP id
 d2e1a72fcca58-703e599dbf1mr4259929b3a.15.1717624660741; 
 Wed, 05 Jun 2024 14:57:40 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70242b2ff9dsm9091509b3a.212.2024.06.05.14.57.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 14:57:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org
Subject: [PATCH v2 00/10] target/s390x: pc-relative translation
Date: Wed,  5 Jun 2024 14:57:29 -0700
Message-Id: <20240605215739.4758-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

v1: 20220906101747.344559-1-richard.henderson@linaro.org

A lot has changed in the 20 months since, including generic
cleanups and splitting out the PER fixes.


r~


Richard Henderson (10):
  target/s390x: Change help_goto_direct to work on displacements
  target/s390x: Introduce gen_psw_addr_disp
  target/s390x: Remove pc argument to pc_to_link_into
  target/s390x: Use gen_psw_addr_disp in pc_to_link_info
  target/s390x: Use gen_psw_addr_disp in save_link_info
  target/s390x: Use deposit in save_link_info
  target/s390x: Use gen_psw_addr_disp in op_sam
  target/s390x: Use ilen instead in branches
  target/s390x: Assert masking of psw.addr in cpu_get_tb_cpu_state
  target/s390x: Enable CF_PCREL

 target/s390x/cpu.c           |  23 +++++
 target/s390x/tcg/translate.c | 190 +++++++++++++++++++++--------------
 2 files changed, 138 insertions(+), 75 deletions(-)

-- 
2.34.1


