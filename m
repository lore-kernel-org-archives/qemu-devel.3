Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A549EFF8860
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 12:47:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHLMt-0007fV-LK; Mon, 27 Apr 2026 08:47:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <314abh@gmail.com>) id 1wHEJo-0006NF-St
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 01:15:45 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <314abh@gmail.com>) id 1wHEJh-0003YR-UD
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 01:15:40 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-82fbf5d4dc2so5989822b3a.1
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2026 22:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777266930; x=1777871730; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Dj5974dVflUeqeR/9kqN6lrYauLJt57H/ZKahF2mZM8=;
 b=OFr4I4y4996U0l2jU+dniwLvaTweknUU/C3YjcZxOTUUkrgPFB3TBNcWvo6Oz4y1US
 BN3OYCHRjQfkHlFUYRNqYbAo/OsU1pek0pAcP5WnbPhlQJoTC1qvETlWN7engEWpEJxN
 dWZfl8GOGaqmaMSNOOuNIZadfdBQ3NvR103+d77yzaOfkbckqYE276CqK5Kh5671UCGK
 s5aFFuKxbJeCz130gZFh6RpydM+wCH8nOXLwcmWLY8YiJQcDBCFCmm4nhG+o49eZQDOz
 8m97urQ0RTHDzrKADvK/OXaViJXtn0+m3E8tpSq3RoHDZbm1X/4hVz8T2PVa5Xu+tIJX
 SpbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777266930; x=1777871730;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dj5974dVflUeqeR/9kqN6lrYauLJt57H/ZKahF2mZM8=;
 b=MxIDvSSzF7o5S5ygrMMUsTnPkT6sjMkI5SG52+NYiDDA0AYyRtrm8qJtie6ImSp3n+
 oRekjreDJ9L7Z6UQp0YHe8mbPicgjOa8rcVMFD48cGpRj7hORJrZlztN5hh9IPiyZBOE
 yCr6rxDMbRdjq1jilYqcWoCDTbHU2cRlMys8nL3rVy5HKFJAFpU/pKFR3icMnJZNeeyH
 +j6nzXbZwuthlmyNok2PcEJhK7woWR7ea6yVKr7Iys9YWVn79HjGrUxYQWDjUgf3O1gG
 hTi/2DHVdi2uKmKECMCMt+HuyOaPH228OTIi/xw64EwHODQSIfXna2evJvd330PCiDRZ
 gOdQ==
X-Gm-Message-State: AOJu0YwkUBO7oD6+lN0rFrA6wIZTsuNNIRZEIUFzrRFjXOVzpdTnsJOO
 5IjjJrMp49HvftEoH2BI6fFHWdSaYRmStxK2VgR4gzaSuOtnbaqMqy0dRJFN7Spt7uw=
X-Gm-Gg: AeBDieuBMfZO0ToP6nHisB9q+i/Zg3HH7yD1Cd2rzzJrwMbgwArKrcEkSEMSyzup6P5
 bYprz/hOZVKDAuRI/3j+Jh8jKt5V9c1D6RSrr8/1+GCdW8G7FXQGd56Wvls/p9uMqhTHP9z+rRl
 m/OEWVkUqciR08VhoqczNqz7bUY2x83/S3V3YYB9EQjyUrQt9K54YQmhJiEZ3a75delVYQrDafs
 ugYbwOAkLkBp67F2AGkYtADlDFtMBN4KTfj/qvh/NngCVfKzqiYfyaY24KsoOqgD3b8jyerViKO
 WV6ntwZAtXfXSWB7HlYEjWvC1iNI8Wz+8bzO18ognZbX1YZMomzghih8R7rBWQeyd8X4bTh/WEY
 A+ow1akSsvZTwuXCYKX+5Enkbt8FrYfrRv4HVv/ruzwKNQKRA28LKJqCZDJdZV6PvM3uJeYK4G+
 L3ErYIUA1xvBbKOpACRBO1
X-Received: by 2002:a05:6a00:8715:b0:82f:a89e:e16f with SMTP id
 d2e1a72fcca58-82fa89ee99fmr23788077b3a.14.1777266929705; 
 Sun, 26 Apr 2026 22:15:29 -0700 (PDT)
Received: from arch ([112.133.246.16]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8e9fbb85sm35349019b3a.22.2026.04.26.22.15.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 22:15:29 -0700 (PDT)
From: Abhigyan Kumar <314abh@gmail.com>
To: qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, qemu-riscv@nongnu.org,
 Abhigyan Kumar <314abh@gmail.com>
Subject: [PATCH 0/1] target/riscv: Fix medeleg[11] read-only zero bit for
 M-mode ECALL
Date: Mon, 27 Apr 2026 10:45:06 +0530
Message-ID: <20260427051507.727280-1-314abh@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=314abh@gmail.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_STARTS_WITH_NUMS=0.738, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 27 Apr 2026 08:47:18 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This patch ensures that the read-only zero bit (i.e. the 11th bit) of
medeleg remains zero, adhering the RISC-V specification.

I'm a first time contributor. I was a bit confused when it came to
writing tests for this. However, I did debug it via gdb myself and
confirmed the patch works. I would like to seek guidance on how can I
add a test for CSR issues like this -- or if it's even required in this
specific case.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3438

Abhigyan Kumar (1):
  target/riscv: Fix medeleg[11] read-only zero bit for M-mode ECALL

 target/riscv/csr.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

-- 
2.54.0


