Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1AC3CF8855
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 12:59:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM4FU-0008IH-C6; Thu, 20 Nov 2025 07:58:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vM4FS-0008I9-JP
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 07:58:55 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vM4FQ-0006JJ-KH
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 07:58:54 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-477a1c28778so10339925e9.3
 for <qemu-devel@nongnu.org>; Thu, 20 Nov 2025 04:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763643530; x=1764248330; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SxGi2uLeDArqC1hUh/YQ7v216i4ry0QDrRVn6jFL5IU=;
 b=YyrxG/hFmkQ9IvlgnGQyG1E5vakXJIDs+l9Fd5dxZ9OjPgnMguo/jw3oPN/7jEZXIx
 hUnrhD/W2E8AXo14BpK57ERu1KX7uSIKdE4owkKTuIuQNpiivadrQMyy2f1ZrbhReuIV
 TUz5x9ZxvbuisVLx7XKdfwbb/YB9cr/cc+zdWJRQ8OymeNlSlT6HULiqD4sdNPYFtG/N
 Vn721QOwpN3RROK0HrZbFtecrTtHvM4zjEMB7Jgdz58u8lSivk1P5uwWvDuVbzMViQnu
 f3nf9R+UXsDymyNo8QNZEdyMFRXgL+n2lSrcvBB7Q+e7P5uv/ny6oGQaaNxzultwIDOK
 ZEtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763643530; x=1764248330;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SxGi2uLeDArqC1hUh/YQ7v216i4ry0QDrRVn6jFL5IU=;
 b=beTbvMCMu2vP0Agj/moSl//NEUEdYoHxOJFrJ3ipBOhFsq8AtRzmiUlLl8dxa1KPq3
 mZLH6DsuZ2qyNva6LXT/BUUxETtqGTKigDOhNrLn6nlRQ4+H9aOypwG9eLSSzP7X8aa+
 6qINx0l8zFdTr2mMYha8dhdI9LxCto8tEY36c0cIjK/zLUUDeVcjpSqmBDGxspk89WYR
 OhkHExmIsT2Gkj/ziI3IdDVjNxPPxBXmFVNGBY5e4Y5Hi8VmNfcPXwJ/4eStY37LKdFd
 JOFLvRaTygU/pJ6XqMPeAiYmD4ABE7YfxvNQx+vWEwtZ1SMnpGkRTEcp6FHi/qtLEIMg
 kW6Q==
X-Gm-Message-State: AOJu0YzokNGQpX7yExg9U2oqvSgCwDBpEdsnI1x7Po9c9rKGA6+G4nNl
 6N9H6s2ipKQ7+1To6W1f52j/WhzaZNEm34yef/+VZjbt5vIlQ3FBXU3eAcT9cIIGFUx0ENPx+x3
 Sh3svoXo=
X-Gm-Gg: ASbGnctnSfboEcrKIbYHn7JnXgvZeMUYMZKZbCl32WDEUMJffcbvc/5qtepe+PX/vku
 KOFP3h/LPCwING2HKZJTPMHPdWktROIoKmoX/25tr0MU/Xb61tH3lbTHplAcLTq8/YG2eVpdJIL
 6821NQ5bdljn3UiN/4SZN+xYqgA3m2RgjXqbdlv0aIAt9nHRuOMSk1bRSv9Ma6ykzRDr/J8mhur
 jQkhNfE9rLs85fFdhfWnUbcwvW8FRhrTZT2ibqYWJI4KlULQAgn7tQBHLZc/4Z+4NdyA/r8ATZG
 Vs8fIgf+WGR1sVQCPDKnsrgG058GnxlsTecwo7aaStX+CX6hCJ0+teUxau0XAQ2evf3fwRSUym5
 Qx2lt6LZsyhd7x9cAIyjzeDqlF4Cx9tyfnCDNaUkkDoeXbrUGVfCz757QfREmBsEFc7gwkGIKUN
 sclOsz5PieuNvK
X-Google-Smtp-Source: AGHT+IFH6y2da/Yz16oQQe/MhduBIkEt0KEj0ZJvZFAGHRZu4xkXvE612789SAdCIaPlaDyzhPDdLQ==
X-Received: by 2002:a05:600c:3115:b0:477:89d5:fdac with SMTP id
 5b1f17b1804b1-477b8a9f9camr32588445e9.31.1763643529884; 
 Thu, 20 Nov 2025 04:58:49 -0800 (PST)
Received: from jimm-x1.. ([2a10:d582:31e:0:1328:3324:f0af:9332])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477b831421fsm46082145e9.10.2025.11.20.04.58.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Nov 2025 04:58:49 -0800 (PST)
From: Jim MacArthur <jim.macarthur@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jim MacArthur <jim.macarthur@linaro.org>
Subject: [PATCH v2 0/3] Basic ASID2 Support
Date: Thu, 20 Nov 2025 12:54:13 +0000
Message-ID: <20251120125833.123813-1-jim.macarthur@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wm1-x32c.google.com
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

In V2, I've addressed two comments from Richard Henderson. Thank you for the review.

Changes in v2:
- patch 2:
  - Added FNG1, FNG0, A2 to mask for tcr2_el2_write
- patch 3:
  - Changed test for ASID from "=0x100" to "!= 0"


Jim MacArthur (3):
  target/arm: Enable ID_AA64MMFR4_EL1 register.
  target/arm: Enable ASID2 for cpu_max, allow writes to FNG1, FNG0, A2
  tests: Add test for ASID2 and write/read of feature bits

 target/arm/cpu-features.h        |  7 +++++
 target/arm/cpu-sysregs.h.inc     |  1 +
 target/arm/helper.c              | 10 ++++--
 target/arm/tcg/cpu64.c           |  4 +++
 tests/tcg/aarch64/system/asid2.c | 53 ++++++++++++++++++++++++++++++++
 5 files changed, 73 insertions(+), 2 deletions(-)
 create mode 100644 tests/tcg/aarch64/system/asid2.c

-- 
2.43.0


