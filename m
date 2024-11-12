Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F25E7D597A4
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 20:39:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAxee-0001Io-2d; Tue, 12 Nov 2024 15:38:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tAxeV-0001HM-8j
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 15:38:23 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tAxeK-0008Sn-6d
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 15:38:12 -0500
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-7f43259d220so3259951a12.3
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 12:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731443881; x=1732048681; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=szuHMevCrKC+EdwnnmTePxCBnHN0QrWML9ZRboDaHSc=;
 b=U0eLAzAB+SmHkAw/MsrXahxRoH4xFcxctLqK4jOi8k9sZWNqEj8/EPBLAvfhOImyg0
 iTASiJxWpyMsktAtblj87398URBdmSuRY+2Lbdz0A2cnmTBLkwLJv2et/6ZU/WoVfrRZ
 kPiHA1QOISrPcsIN5+a8CmQYYoPNaRW/woD7wJi38k/N2x/khjRr/Ih46+wPlTuDJCUc
 n7tRG26nYYfNO8npo5YgZAHXz7fG2zszPH+rLG6BwgFQRobu1mL9mPuVbI+ay4WFxOuE
 RepKAdI61YTpQ43fsB0nwqyERUJBeY0rq9qynM4rjVe4AbimLrm3MQ2dZUgCP05F7XTz
 5nVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731443881; x=1732048681;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=szuHMevCrKC+EdwnnmTePxCBnHN0QrWML9ZRboDaHSc=;
 b=Nrjyic5kipwzGv8dQXf6YoEYSVjyB8T0QODOxyVulTaks5bQaZcHjzl5GH4vF9TLV5
 2wBT8PgphhHBD3atMeFv4a9NlDVD91KpdEpX4UYQOmoNLD5NECCnrgPPIb8pyJGT6beN
 FSjDgpRETUL0KcCku5+3a6RKxHmeE9ijARVbzaOCjHEGbRRJprVpSC3NmaSo/+w8W5Ss
 SBNT6v22DNBtl+4/PTgbYGFVclnJ5aSXI5M+G/tUIuqVcAuZ/sa2oyNRuorlVV0EKxkX
 Xo2luBj889rSvXUoTjD7xflgN07c6gZLMsUQWdaLTQIGz6xCYpLa/mU9kFJSfLBV0GH1
 ZVJw==
X-Gm-Message-State: AOJu0YzDqqle0/+hoFqqBsri06iiPaRGPpDVkhASw8IULiILA7dIskT4
 TD3F22WXJ01ASMjG3kV4yGFCG3C5tklJiz2dx/3tVbAbvA1PwI/kWyqmykE3qJZa8VfhLjP9Doa
 6
X-Google-Smtp-Source: AGHT+IHJMPfPsIFIc8c6dKAefZea2i0RCOpSsOe8kl9VuU0QARM+pjdyylKWv8W3blUhknIjPdBftg==
X-Received: by 2002:a17:90b:33c8:b0:2e2:bfb0:c06 with SMTP id
 98e67ed59e1d1-2e9b17058camr23137447a91.12.1731443881252; 
 Tue, 12 Nov 2024 12:38:01 -0800 (PST)
Received: from stoup.. (wsip-24-120-228-34.lv.lv.cox.net. [24.120.228.34])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e9f3894192sm9860a91.21.2024.11.12.12.38.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 12:38:00 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for-9.2 0/6] linux-user: Fix elf load and vdso alignment
Date: Tue, 12 Nov 2024 12:37:51 -0800
Message-ID: <20241112203757.804320-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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

GDB picked up that we weren't properly honoring alignment.
After fixing that, reduce vdso alignment to minimum page size.


r~


Richard Henderson (6):
  linux-user: Honor elf alignment when placing images
  linux-user: Drop image_info.alignment
  linux-user/aarch64: Reduce vdso alignment to 4k
  linux-user/arm: Reduce vdso alignment to 4k
  linux-user/loongarch64: Reduce vdso alignment to 4k
  linux-user/ppc: Reduce vdso alignment to 4k

 linux-user/qemu.h                    |   1 -
 linux-user/elfload.c                 |  38 ++++++++++++++++++++-------
 linux-user/aarch64/Makefile.vdso     |   5 ++--
 linux-user/aarch64/vdso-be.so        | Bin 3224 -> 3224 bytes
 linux-user/aarch64/vdso-le.so        | Bin 3224 -> 3224 bytes
 linux-user/arm/Makefile.vdso         |   2 +-
 linux-user/arm/vdso-be.so            | Bin 2648 -> 2648 bytes
 linux-user/arm/vdso-le.so            | Bin 2648 -> 2648 bytes
 linux-user/loongarch64/Makefile.vdso |   3 ++-
 linux-user/loongarch64/vdso.so       | Bin 3560 -> 3560 bytes
 linux-user/ppc/Makefile.vdso         |   6 +++--
 linux-user/ppc/vdso-32.so            | Bin 3020 -> 3020 bytes
 linux-user/ppc/vdso-64.so            | Bin 3896 -> 3896 bytes
 linux-user/ppc/vdso-64le.so          | Bin 3896 -> 3896 bytes
 14 files changed, 39 insertions(+), 16 deletions(-)

-- 
2.43.0


