Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C46A9CAC5B5
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 00:14:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1w4D-0002Je-1Z; Thu, 25 Sep 2025 20:12:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1w4B-0002Hy-1o
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 20:12:03 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1w3u-0005Dv-Oe
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 20:12:01 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-b55197907d1so1207472a12.0
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 17:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758845496; x=1759450296; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Qu2WawuNif6cwXABrQIIkgvEB/+OsY6QuECYBRRDHsI=;
 b=t3pL7xhvVMiFEkSNxCx10f4W2SwYxcLqwAaR6UUFR2nZwsy8KI7lnDN+ZqBM8Lyucn
 PzX+nK814NVEekTZ5XkrAz5fqL0GI5gL0hQcA5gglR3NKWbzKsLxBZjf1dK3Op67CV4Z
 jJ6katwEnbYCtW/wbY5FmtdcFlfMWGsoxTImMqqv23aVGDO6a+0lJMEvZT71WjMytOwd
 9oG2Jy1Vs9646kWxfccLNHJM/5ZF+eeim751Caw9Te9BGlFl345xROBTIW9ZF2k74cDO
 xd8k42wAJ7tkZEyfMFcSk0/ghOVatbeW2yesVi6oY0iK8aJ+/hQ4NxgHS69WhX2ATuYg
 SsFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758845496; x=1759450296;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Qu2WawuNif6cwXABrQIIkgvEB/+OsY6QuECYBRRDHsI=;
 b=GF2ja0NfHHAi1m6V1CXo0Qm8DSzVvm9l6tunyoMBqcnmwzdbmEFfcIY3J6n7om1RO4
 qVQYsfmAMYr2SSNRdawEtDTdlZBzGo1jMqWVSZeyjEjTvGSSj56dF/EcDDP165HJMEUl
 jtBnLV651G977nZbvsU6Fkn3MaoJ0+Wlt1F0r+B9zGOg+E9g8Ss0qjMn3YUjCV8ULaR/
 JSoSRJ5HRj14oN7eXgiwXpTgUZc3R7VJRUFaNeQfCFoZChMldc5AMPJECO77BOjzxUSR
 cP+FZ7zaxY7X/9bNyfbKWl8t1jVwWSI+7U5EefKUsC3dX0SfrXXWGyFT6Ag0BTSqMA8t
 c7uA==
X-Gm-Message-State: AOJu0Yx7sP2WgwkDTQuwRQ6l9uGNWRldW2Hm7EMpSg2sbyMA2kYP4/RU
 FVdgFNcRWLZ6wGMYfizwtVx0QfrSJT+cZLw7iVkLGcyNXRsE9lTswXcfrePNOpUI4UYBvOnDKWa
 GwM0n
X-Gm-Gg: ASbGncvp0YzUzAWIi9Zy6Q+PB6XakyITId3sD1CtUyuprLtbp1E/Az8spVpjmhUFpY3
 Jh4C9v4Rgj92oupLLfmFKrXQZp2C/UsFiylddXogS7asqp1iMj9EuPFS/Om0Dw740cLYUEQo95U
 yn/hUd9isCnzpsefUH9tNOHtAEIfAXjq/OJuD925Ecc8rBTBxIZtdni+cENGJAVmorLvKkwyzmN
 u6HpFH8EszdMhY6j15GvQPR7RKO4KOWyQqFLzjJ2kGfuGamXrOmOuezvj3SdaUqZCCDpLJufgde
 8yD9qVyrjguYngtrkEXy0Q8djLDL4zRiE+d9TAC+cgC+ehtEyAT+h18ltKDI/nG4ZrLiV/Dp+jD
 4kVTXZVeu3sTNlBNDxSgweeAWj/30
X-Google-Smtp-Source: AGHT+IFj9ZJbFTtBMtZ7xTa+VEKyNEYLEK8bztJqTsWfxwlkmY3+yCkQRa4ivUlYNJN7ikvx34rmOw==
X-Received: by 2002:a17:903:3c26:b0:24c:e9b8:c07 with SMTP id
 d9443c01a7336-27ed4ac323bmr65721225ad.43.1758845495881; 
 Thu, 25 Sep 2025 17:11:35 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-27ed6ac37efsm35829425ad.137.2025.09.25.17.11.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Sep 2025 17:11:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 00/10] target/arm: Implement FEAT_RME_GPC2
Date: Thu, 25 Sep 2025 17:11:24 -0700
Message-ID: <20250926001134.295547-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Note that patch 4 will conflict with patch 5 of the FEAT_GCS patch
set, and I'm inclined to think this cleanup might go first.

This is otherwise a reasonably simple extension.


r~


Richard Henderson (10):
  target/arm: Add isar feature test for FEAT_RME_GPC2
  target/arm: Add GPCCR fields from ARM revision L.b
  target/arm: Enable FEAT_RME_GPC2 bits in gpccr_write
  target/arm: Add cur_space to S1Translate
  target/arm: GPT_Secure is reserved without FEAT_SEL2
  target/arm: Implement GPT_NonSecureOnly
  target/arm: Implement SPAD, NSPAD, RLPAD
  target/arm: Fix GPT fault type for address outside PPS
  target/arm: Implement APPSAA
  target/arm: Enable FEAT_RME_GPC2 for -cpu max with x-rme

 target/arm/cpu-features.h     |  5 ++
 target/arm/cpu.h              |  6 +++
 target/arm/helper.c           |  5 ++
 target/arm/ptw.c              | 95 +++++++++++++++++++++++------------
 target/arm/tcg/cpu64.c        |  3 +-
 docs/system/arm/emulation.rst |  1 +
 6 files changed, 83 insertions(+), 32 deletions(-)

-- 
2.43.0


