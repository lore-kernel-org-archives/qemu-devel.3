Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC1CCCD4851
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 06:55:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN3UU-0002QW-Tr; Wed, 13 May 2026 02:54:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wN3UT-0002QH-5w
 for qemu-devel@nongnu.org; Wed, 13 May 2026 02:54:45 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wN3UR-00038E-Gg
 for qemu-devel@nongnu.org; Wed, 13 May 2026 02:54:44 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-48d102471a4so62810685e9.2
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 23:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778655281; x=1779260081; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NOIo/Ed2g1WOcLhZFztn/cBadKii30LozWdC3zqI4xA=;
 b=HmBkuyMZerIfygrx1GI3YKrqSwr97LF6i4QQQDLHtQw8Y0/Xqh9IyxB7HAb2OQLgZA
 x/RkVWEWHIs7uDt7yc6/UI7JrD86wJUuTWJsmUq4zaDfeFn2+nLyPIaiBmwO6ov8kA37
 HjmBgG1Y/RHxftncBgNeqXaZ8ry6kthQT0OrQNiqMPDFjEaET5AtSRXvfj3wBeis/BGh
 1lllxUYEOpJmYHLbtDL90RQ9LP8ZXO/Y8cjpHhSCJGCKBczzNsAUrVZJBtA3hXfmu1ZM
 pVcHaCAm5gFMzRrJyByj9vUSJNQQk/UFIcvZaweGg5jc3o9ed+uaESHTavWWt1gjVhBm
 mSQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778655281; x=1779260081;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NOIo/Ed2g1WOcLhZFztn/cBadKii30LozWdC3zqI4xA=;
 b=e3rHr2vCyUjxICcRef8vcmoAbwLB8PqOxBknAHVJC1ZUwzGXBPqKggtWGh+iqRIkZ/
 m/JfqSZ+afUYh7AR/2Vp0bU7kh7yQE5rtyayrd6obQSdFg2vCnKWmWLHURLlbJf1nhsR
 35CECsYgD0Aq1EHOp2EOrvv4MrFk+T0oinZEmjYLi7/PabwSkg90PqiLTuOd0aWuY6V0
 mxzKPjEXm+FNOUWQIE9ivvh6zjih8OnvLpfcYgijU2RUfieFuVhvhABwokpuRXKfDjwA
 AyJ+7Ceg8clUOyXSoLCCce8Tz++YCa4RPQVNnDsHPjQ+bzH30EXye9EiKczeq/MgQqsC
 dCIQ==
X-Gm-Message-State: AOJu0YwWMvdf8uPLPNP0tSUb7kjJxDkL97rvjzNYQsMUM4hNhAAw6WSn
 soiaC4D3PeV+ETRjiVtteAEBEzVenDDdVbPT47OXxpCw4mvyXeWag5XZQPyYSKG6e8gvBSk9EUg
 GvOorA7s=
X-Gm-Gg: Acq92OF9RMF+f8Q1G45b5FyTYpg9CB5eIQMki5G7ei9QkAsTpXr36jhGaZUcqbT4EfE
 OhJXVr4G5S8EE2Ve6jy6wyEdjMy4BFX/VLAsN4XbgYz1wr4eehuekNwmieMyYGUeJo7yDCmLl52
 k6wEEkRhNyy1AxRVUXqqKljxEJTzVfjPevU2mMmz+qBh013sC8MMD4lvFvPrz+UztbrZzdacahM
 TRcqvkJTGnFErhLQLbvyVlWfwQ3uNm9weZ0D8faO6/sc1vG0IY9JM0WLUC3z8f+JoXTb94Sz91g
 D/ZoluezDnSiiEPUQRfFX3nwbUU9L3jzDPje6XvvkFz2vihxzmnRzbhZTQ68qxwJMjt3OUIHRTA
 iskIPM0XZwb6ie/L7sxHhtSZph9Z4I3j+4N9JcCbZDfeBaiI/PizIxhTNuL7GrtNU9Juyig0Yfb
 agMy8iC6e99b/vw8f/F9PgLum7AlKpzu0rs2e3X7VLyOtROjB9WgZuzPc6mzXIms8/yPOQnrCs
X-Received: by 2002:a05:600c:1d9a:b0:48e:6275:27ec with SMTP id
 5b1f17b1804b1-48fc9a47efamr26128605e9.24.1778655281059; 
 Tue, 12 May 2026 23:54:41 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e8f4470d8sm33864675e9.31.2026.05.12.23.54.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 May 2026 23:54:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/3] target/sh4: Re-allow unaligned access on system emulation
Date: Wed, 13 May 2026 08:54:34 +0200
Message-ID: <20260513065438.8680-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Restore unaligned behavior on system mode,
hold alignment in DisasContext.

Philippe Mathieu-Daudé (3):
  target/sh4: Re-allow unaligned access on system emulation
  target/sh4: Hold alignment as DisasContext::mo_align
  target/sh4: Inline UNALIGN() macro

 target/sh4/translate.c | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

-- 
2.53.0


