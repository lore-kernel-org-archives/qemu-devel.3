Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A87FC4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 23:46:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzmIO-0000zL-1v; Wed, 24 Apr 2024 19:45:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmIL-0000xW-2P
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:44:57 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmIJ-00028Q-IY
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:44:56 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1e4f341330fso3913405ad.0
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 16:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714002290; x=1714607090; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=2yyd735UfzyLOYoJn2aQVItYH0NxUIsZOxgYBbVgHYY=;
 b=bUPLlPxA2D0uVs2KkqsQOyR9Txj+njEBEA9xSnSGZJ+fDXhkjw1EjenCWEiPt+7/9H
 zHyeAghBCb64ZQ6OFP4y03QW25vSMFMTmnEkpYZg4R3Wazr3IXyfqXRXn9L7PXXOOvHK
 t/7qkjb8a8jpCNYcLv4goFZAXccmcjkeXZblh9zEQYnc5SmNFccBdIEwgSkgZ+lmx1ed
 Q3hSik+z8STNvDp0swbgjt5DWqhyUkA0CDk985Cstqnhh95veF6WSeh+675tvHLy7DP5
 6cnhc5AEUvN5Z1fF6mIJiMb8qlqgeDJJMBGEvQ3wQFLYIQznNqkK6ru0M6EwqKH/f7wt
 FB8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714002290; x=1714607090;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2yyd735UfzyLOYoJn2aQVItYH0NxUIsZOxgYBbVgHYY=;
 b=N9ryJ0wgG41WkDTXKLH8p7VMkaI7EerDZ4Pj0XO6RZvqXkhj/UnPVy15TLilpeQbNh
 J1rM2TSsI0v61twUanN+oJL6DKKCzY1S/H8MPvspJ7n74sw+IzvcgmJ2wKj+m55975K4
 7J+DY702FlzkEPNrhUx56nlIj9ujsl7TNh0FACiLUyvlx/P65X4tj51C97MjqgwH6dkb
 RoUjo7HIixBoNKy40mCDivD1UxIm1PmEnsJaTEaLsuRfQXxiw8xs5qiY3OBkwBSXa4Ch
 6JQOiGgHA7ogj0aeTSDXoHwNzjBdRIuR8wUx7iiKEUm4Sf2zYQ8VtT0GJC/N63qflABu
 yzSA==
X-Gm-Message-State: AOJu0YwkHpqf1+aPKbNQtVcb91ISS7FJ3DZbCvLS0sQ+rKdu1EzOtXF/
 t38XwyRZqRFgtY4sziplQian/i9cuBU2lkSfR62qbH4j3JYXOEmY9IIl8OzNeOPuxw4TGjGRBwy
 R
X-Google-Smtp-Source: AGHT+IF4tNm0PQHZjWW+ElHumU6duqqffrlimun/awsuj0LR4OPKjCGS98JMaBB9rGAo8n7zSVE6zg==
X-Received: by 2002:a17:902:cf0e:b0:1e7:b775:64bd with SMTP id
 i14-20020a170902cf0e00b001e7b77564bdmr5059276plg.53.1714002290141; 
 Wed, 24 Apr 2024 16:44:50 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 h17-20020a170902f55100b001e49428f327sm12531642plf.176.2024.04.24.16.44.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 16:44:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/5] target/alpha: Implement CF_PCREL
Date: Wed, 24 Apr 2024 16:44:31 -0700
Message-Id: <20240424234436.995410-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

Implement pc-relative tcg code generation.

r~

Richard Henderson (5):
  target/alpha: Use cpu_env in preference to ALPHA_CPU
  target/alpha: Hoist branch shift to initial decode
  target/alpha: Split out gen_goto_tb
  target/alpha: Split out gen_pc_disp
  target/alpha: Implement CF_PCREL

 target/alpha/cpu.c       |  32 ++++++++---
 target/alpha/helper.c    |   8 +--
 target/alpha/translate.c | 117 +++++++++++++++++++++------------------
 3 files changed, 91 insertions(+), 66 deletions(-)

-- 
2.34.1


