Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0310AC2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 10:36:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFVou-0008AO-Ph; Thu, 15 May 2025 06:28:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVne-0005QS-Or
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:51 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVnX-0008GC-TT
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:47 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3a1b8e8b2b2so447851f8f.2
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 03:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747304802; x=1747909602; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=j2FeuUXXVncNRr45/ixdgoWwzsnoHydOQLE8nm4vHw8=;
 b=tHKDd36nSf3RAT7wiFhFgiNx0FGyLhNqCYlDjQ+x/K43xzv085Oq+ETke8r+aCgWsU
 tNv4Be0a8IdUZ6xanewWZJFXIavBtlzkPAZHAsCqg3F6cxXuYRa2HmYHW/DjCYkVKGum
 KNlQYjdmxlOzUVyUz0Nx1sCRfGNOGJsXqDd4Q98M0vSf8Wj+y+XdHHZnvyBf5Qo5OCX5
 h9Nb7E1XBDSAN5g1pSAt73j1wu7LJ78UA1Y+kt/qwvPNZfQjboZ6ieZlSGlNLsV+rSiP
 8HHyPzt8quymg8oJ4W/PaKk0dBODIcnlNJA8pvsnC8fMMkgMVsI9uh4LCFumh00e6Tfj
 2CQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747304802; x=1747909602;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j2FeuUXXVncNRr45/ixdgoWwzsnoHydOQLE8nm4vHw8=;
 b=fLfafE/V/GmZX70YjykRDHHTxwXeJBq1TQ/y+VFIp4iKQBy5Izfj876DC8iQL2taSk
 I9d4nfrVyPyYkSRe1hj+t2sTaxj0lx3nP3pPByq0eUnKzL3Qt6pUMLqCNN9C459LjqQF
 ZLZrNcYR+khwoPTnnVk7DdhYAKonTDaHiEKb9ZvmGkhJpoyq5itfk77O2J+yzCCForvZ
 SUT7Trc7R485Q6OHnRv95vMY7JcWbdsStb+iVjcif/DvxGc0CXCNBjXtD6CvJioLBVXG
 DOF9B3Ap7ceL7fSQEn3wru26FBSOGu+x6w1wuwSVEYk3Dr3uNJ4JkkIvUZR9F7IIXk55
 qusw==
X-Gm-Message-State: AOJu0YwlaomlXMFDCu39awGChxIh5R2kFy5fRTWo9IqdUYRillEEggND
 18mxfK35R/LzgD6H+L1gHcVHI1j07aHrJTBmEHLCQW+Hd+oIHf6xBO7VVfEYpoUbc2zMeHCp1by
 O3NI=
X-Gm-Gg: ASbGncsZQw6mZV+vdvbhWq8zGAd/AnPWsSVstsG6yEYm3w9EggisN7oBGK9vMSF16o9
 MOOTfpQmbEKIA1J3ZmXMJz2qMsCFyiI3XqNanJpm7++/N42Ujib5DbjbsmhHiKTMbZDrVY7f+G9
 wLaC6fQqYU0kD34HzGc+2Y44XF9cpmSVFTXw+KD1EV3IUNRFgaL2LvhaRV7ANwdY+K1BLLzrjyY
 +aGnGwhG/NhYDUXfm9EIK+OYoG4BKkkeqCREiGTWnuuNxy8Z7ZRSVWccAGQOdUBvirmEj3eynj5
 7D4xJRPmfb/i4q/gkSrvX8ee1MX70AeWZR53VLQqJoH/dERVDoz5Yc2tbA==
X-Google-Smtp-Source: AGHT+IF/HUtCXLriwgFGjSCcvDjGyIqTO60OHVy6wnjqZKW/wKUIg/uW8cgl9N20/CQrSL1bzP4IIw==
X-Received: by 2002:a05:6000:1f10:b0:3a3:55ea:c6f8 with SMTP id
 ffacd0b85a97d-3a355eac818mr903350f8f.49.1747304801613; 
 Thu, 15 May 2025 03:26:41 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f396c3a4sm65657855e9.26.2025.05.15.03.26.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 03:26:40 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 42/58] target/arm/meson: accelerator files are not needed in
 user mode
Date: Thu, 15 May 2025 11:25:30 +0100
Message-ID: <20250515102546.2149601-43-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515102546.2149601-1-peter.maydell@linaro.org>
References: <20250515102546.2149601-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250512180502.2395029-33-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/meson.build | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index 151184da71c..29a36fb3c5e 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -5,9 +5,6 @@ arm_ss.add(files(
 ))
 arm_ss.add(zlib)
 
-arm_ss.add(when: 'CONFIG_KVM', if_true: files('hyp_gdbstub.c', 'kvm.c'), if_false: files('kvm-stub.c'))
-arm_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
-
 arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
   'cpu64.c',
   'gdbstub64.c'))
@@ -18,6 +15,8 @@ arm_system_ss.add(files(
   'arm-qmp-cmds.c',
   'machine.c',
 ))
+arm_system_ss.add(when: 'CONFIG_KVM', if_true: files('hyp_gdbstub.c', 'kvm.c'), if_false: files('kvm-stub.c'))
+arm_system_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
 
 arm_user_ss = ss.source_set()
 arm_user_ss.add(files('cpu.c'))
-- 
2.43.0


