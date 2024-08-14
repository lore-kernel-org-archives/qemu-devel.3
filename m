Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10974C52D7B
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 13:40:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seEE4-0006Pl-69; Wed, 14 Aug 2024 09:39:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1seEE0-0006JJ-1k
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 09:39:40 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1seEDx-0004Ks-2f
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 09:39:38 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-428e0d18666so49021285e9.3
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2024 06:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723642775; x=1724247575; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gTkWpmoTYWWZMSGTkTM4NmFUtiHO/e0O6nDNIsU/+uk=;
 b=dndskHQDHeNC9jJIYrNqq34OdzwpS24n6pz87L92F6dZtKVH9IcCG0S8tiRZDxBXK6
 gjZ5MYndH580b1s07f0/cOsu0LsgBA3/DRCKfXiBexMeYiZ0FdKdqwa4TF7rFfMDsZ92
 j0gy7PI6adIdOds6PLG6oI7F0zq8E/uPhbbkRS2vJOkyzN1tGOtGyZEo0ZZgMlSYG7y0
 AQacw7Otpb8nzaME7xJFX9K69bAhQivKjwwvAZCQoBhl1kmpP8wBwyPNLDVsHLGo+FUx
 aa8FwHZzDUSh4f2B+443+ganYR6tmmYc2Q/zPfCiury1bAe0lhpFTtJJ7f35DAmX3dr4
 +aOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723642775; x=1724247575;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gTkWpmoTYWWZMSGTkTM4NmFUtiHO/e0O6nDNIsU/+uk=;
 b=k55enkyR+1QWcPtGAe6pOC8UX4Y6tlEA9ut9rN5bJTYud7WP+stFyfz7aSs0uwzaxF
 gPdSqt4hNW8r/3dlNEDecB6NWIF8RQp/FyUz0NMTPGmXxCOfnOvFgn9QE1gdo2vfUR0l
 Xxex6pYrIpIh27Wq6eq89SuvTuT0C6YZar7m6/SRhQxjZnUMFbIYtskt140V/Jk+yYsG
 QY2kN5z6iPoLdT2M00MU6UQHNv3J9YQqHtwiRvDX0TeRKlWqgTh2n2ptZofOGiilRnhg
 q40h1HjVMpPp2tP8DUlGYUaPwAj5++4yrjoUdALdBemBL4guImI80z9M/1MCRVSaI1wQ
 zhDA==
X-Gm-Message-State: AOJu0YyLi+hjxuEVRKCPPz72BN96Ay9kGF9qlrzzyassqj60YsTgAdy0
 PKJWHg6UGZDJXPejC5Y86RWeOJT+biOTVOYtmqSEbq7rZSLhzyLmghoeCTF7Bh6tSGdlFfGbXzf
 PMmo=
X-Google-Smtp-Source: AGHT+IFbGkXb4xGvyA5EPstlaMjaUl1QltvJNADlud8h7l91Xx+j7S/MPXAeQJRKKht+6DGNzZEnqg==
X-Received: by 2002:a05:600c:1f83:b0:428:f41:d467 with SMTP id
 5b1f17b1804b1-429dd2364d4mr20711195e9.10.1723642774754; 
 Wed, 14 Aug 2024 06:39:34 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.208.57])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429ded29fcfsm20404245e9.20.2024.08.14.06.39.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 14 Aug 2024 06:39:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 YunQiang Su <syq@debian.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.1 0/4] linux-user/mips: Select correct CPUs
Date: Wed, 14 Aug 2024 15:39:24 +0200
Message-ID: <20240814133928.6746-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Improve CPU type selection:
- Remove R5900
- Cover Octeon / R2 / Loongson*

Philippe Mathieu-Daudé (4):
  linux-user/mips: Do not try to use removed R5900 CPU
  linux-user/mips: Select Octeon68XX CPU for Octeon binaries
  linux-user/mips: Select MIPS64R2-generic for Rel2 binaries
  linux-user/mips: Select Loongson CPU for Loongson binaries

 linux-user/mips/target_elf.h   |  3 ---
 linux-user/mips64/target_elf.h | 24 ++++++++++++++++++++----
 2 files changed, 20 insertions(+), 7 deletions(-)

-- 
2.45.2


