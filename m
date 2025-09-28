Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83121CAC5B5
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Sep 2025 16:35:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2uJy-00036y-9H; Sun, 28 Sep 2025 12:32:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v2uJv-00036R-7z
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 12:32:19 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v2uJg-0005xv-Ot
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 12:32:18 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-b5241e51764so3325026a12.1
 for <qemu-devel@nongnu.org>; Sun, 28 Sep 2025 09:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759077117; x=1759681917; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Neh7GfVM9qJWWa+J7OFEGXWEDAG0La+CUSrpvduPHh8=;
 b=LKIGq75R118M9XH7FqyGFKiqqihMYfHWw5lr4zar9w5Rz4dZdIlnF3BbFKCj/AVcwU
 ZJ5rS9RW7LHIwlGGgWm73AvHUOLLemHG+z7yX1DpqEeOXhTe5flzFbkgF9iAvy5Fw6f8
 m2iIy6t4YyK2WFsS1Jz9EV6U7qiCbLImjb2Pc14I1rv+xzkwyFvkRnemDrjTJCzg+V2m
 juV7a8NnTMQXMYp+Dc74/urfJo/lJ7B/FNRO2MpKpZ6lhhtlrhSBU+ztzuueXa9zjPZP
 hUaPvMV/t7cCAVn6BQt6Jeg4YcflmqwMgWt8UMh80Sw6+YRBLmhNJTkMfucXhGmFVP2d
 bImw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759077117; x=1759681917;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Neh7GfVM9qJWWa+J7OFEGXWEDAG0La+CUSrpvduPHh8=;
 b=udEaCR8mnr/wSs1mvbVhGRX3yR8YaOfU7dOJ4VUK9/5kQihKjBb04GbBfRG9gAUn0K
 JpiYj5kYCYoM6vtkc0XzJ0xINN0EN6pi1+AU5fSbcxeUsVRP7zamr6zTCkwuU3gz0eCV
 kRA2LKxXXJud+6q+sMmMTjBzTTH/ef0a0YxBjg9POXgEXCiVOKRXyc3olaxdv4dCCIaC
 9DlkWwWlDAhyf9e/1MiFoVulaMlQEsd64EQD+THriu5Fw+arBPK3LiyVK9/VPzcyx0HV
 +QKTYsssVAf2SqAUwUARmF7g8/cxa1VDL2jY/r4CBgp5AGqIL7DKxzJp/g9fCq8MG3yX
 yA+A==
X-Gm-Message-State: AOJu0YyWZsmrYelXrXHGrITajEGEfri50mK23SWtPn8pIMRc06pH93UA
 kqfQkL/5OHCgDUQXDwA7jrv60PFHQNIiksRXL3ovEwzFvFWIR5ds25ZsEngxJ5Wv5C/mydukQZf
 RUARVdQA=
X-Gm-Gg: ASbGnctltd0cFW9j4eCf/FhJRlmaIHjv54HoFIJrWLapNxmePH0c6UMfzL20y8o02Wl
 5LQHvhJBOq+zWqS8xK6J9DrT4Sv/ALzrQebGff7OTM3oYiJxv6XL4lXoNX4X5lwS0thxf0R+Sxl
 er3nWeuNA7Z0m4+5h3i/3ktJoNRPkhIAjEA0wqzWliVM4KWXWMM20+FuSi6N5Q5Pxuwy08UsDnw
 aG0PzsNqxFvCYLpb0WtjGRMh+amIVwe07YfH/+FQu/e9l6qKO14eFx/Fy2KM31MpRCma5XV0096
 nUgreDYvBV9UdglbhPypRLWswuECnIvu1wamqwZEoTT/6KnhtAPfkokFdB4afT7HK/4+qwQEPvR
 F5cyjAjXFVmxNDLDfBW+NfF8WO05DJVu7HpB+jI8=
X-Google-Smtp-Source: AGHT+IHUXtpAWKsK6AQgkPIUD1C/5Mwz9h1QXBs9JEiwsKTMjOhtMHiQfxw8gp5qxgGTuCbXEgpZOw==
X-Received: by 2002:a17:903:4b07:b0:286:d3c5:4d15 with SMTP id
 d9443c01a7336-286d3c5548amr26900965ad.36.1759077116719; 
 Sun, 28 Sep 2025 09:31:56 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-27ed6996963sm107236335ad.104.2025.09.28.09.31.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Sep 2025 09:31:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/5] tcg: Delay lowering unsupported deposit/extract2
Date: Sun, 28 Sep 2025 09:31:50 -0700
Message-ID: <20250928163155.1472914-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Reviving a 2 year old set of patches:

The opcodes that we generate early do not fold away nicely when operands
of deposit or extract2 turn out to be constants, especially zero.  

This isn't particularly rare either, as various target ISAs implement
constant shifts with extract2 and their zero register.   Or the compiler
expands x = y | mask with x = deposit(y, -1, pos, len);

Delay lowering of these unsupported operations until optimize, when
we have performed constant propagation.


r~


Richard Henderson (5):
  tcg: Simplify extract2 usage in tcg_gen_shifti_i64
  tcg/optimize: Lower unsupported deposit during optimize
  tcg/optimize: Lower unsupported extract2 during optimize
  tcg: Expand missing rotri with extract2
  tcg: Expand extract2_i64 with extract2_i32 on 32-bit host

 tcg/optimize.c | 257 +++++++++++++++++++++++++++++++++++-----
 tcg/tcg-op.c   | 311 +++++++++++++++++++------------------------------
 2 files changed, 352 insertions(+), 216 deletions(-)

-- 
2.43.0


