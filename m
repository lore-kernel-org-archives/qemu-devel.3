Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A274F417F3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 15:56:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzcxx-0002A0-GM; Mon, 09 Mar 2026 11:56:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcx5-0000QF-FM
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:55:29 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcx3-0000fh-NW
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:55:27 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4853e1ce427so10345355e9.3
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 08:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773071724; x=1773676524; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=I9pkSl+RPDpscWwr+MPBejtK4wJPWeiMCO/OxsmQACQ=;
 b=Xknk/5cbaUM7nkMUs3RuT64Eg3nicr3X6pCwFAdkdFZtFSWPa4rjQySmqBJUo5E5Es
 V4LtTOdSsGmLzL8GFHquIggZ2lJZq7+kxytT7CjZ06EuE4J8dUs7snoLYChCdSB8ZJuD
 p5HBIjGeScoPioxsYvTcLrsxoV/eB6osYbYCT9Ei2bJJPzwuoLscM+8s5XFn5wq0v2Xv
 4F7aQYeY2zBZWDAB92YqwRmq0nnDt0J5NItaQ9Lm+kAZrY3G6jxmEVIJESeVsHkRfi0v
 /UNnpjFu4JBMUttlVf1PDbykm1s91b20AYDfUcWc34sxlviziMsZGLEuBuYewcPN4inr
 QjaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773071724; x=1773676524;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=I9pkSl+RPDpscWwr+MPBejtK4wJPWeiMCO/OxsmQACQ=;
 b=faztHXO7u/Lsc7iwKigheuWu23whlK2I9nKiO1Pyo1dkVMiAxIngYAb6tlTbrCkBi3
 rISN0jikVHFMzezMw9WfVeEJNO9NKm46defwQ/LJA3NYjNLgmTuGtwU4gJAm+VrGSn5J
 h1HqSvN39R+Xiu3VmX/BtTLn0xk1B5IYxxyzFjb+QZPWWy8S42G8uFwTebYzlGTS0UiE
 SXpXyQIsCwktUX6zc+5J2DpXJfIsGnLUAwrVMWhfc8r7RVLQi/p/SidK3EDXv0JdHCd6
 jiroKON/gDSi5dEFSPwKu3in9x6mSMX5rR2AT4r5Rj3fEO7F6BL0RWtLoQH6pySNZSTK
 MEow==
X-Gm-Message-State: AOJu0YyhY0Sn8niZUaT5oVBVsGsw4IOm8ZoOpWly8xg4awK37Odp1b8m
 e2RDuuDz2RMY3D7tf65HcuDNlBwvq0ALbv6hYY53ndpvaLcigFPGbbjwIY5kPfUdoP/rW797Rgo
 /ExCCrQ4=
X-Gm-Gg: ATEYQzxOI7EFie4AcO9GPy2v6oTy2w9WAKTAxPOvWykQXzTgOrDa5fY1X/4gwa8I7rS
 wl9Fh9dQSCj8EF1QvY5eq9nP3Tlnv1n0JJCavxOAbS9QGA5SYG6WyjwBe25cVuna8Qf7jK5GInq
 8hVm082RuKO2fS1WqLr6PkG1ROc3ZnBBYlQHEqulOCxSs1fiEPTy0VeS7cuIx5U9/Jf/Rss9OD2
 KcIn7XXfunJBTzByM3UDjM87d+ayy1doCpooUyqTy/N5B++L5+F1bwF/qylG2KX1jUGmPnVJQgv
 rrOljI7ve8gIclCW4kqaH6nxHv7jesENU8LPi+tGj7zpP0AmsEQml9883jRnG/x5WYILBraQN/D
 XayRsHZtXb4QjadX1J73saU+4KFsNZlZzlo12ss6o08iGRPWGcOZFvWPcaYIMnino/+IqtavdOw
 5fMDXe9Ef13pdFEksTGas4oQAa/JH3Pgcx2STUCGpMgryLvkf43QDElPEVbC3Su+W74jxhhDJtO
 PkDuA//6f0=
X-Received: by 2002:a05:600c:4446:b0:485:34b3:8589 with SMTP id
 5b1f17b1804b1-48534b3882emr105247085e9.31.1773071723721; 
 Mon, 09 Mar 2026 08:55:23 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541a7f1f5sm1813545e9.4.2026.03.09.08.55.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Mar 2026 08:55:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/49] meson: Add -Wformat-overflow=2
Date: Mon,  9 Mar 2026 16:51:57 +0100
Message-ID: <20260309155219.62400-28-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309155219.62400-1-philmd@linaro.org>
References: <20260309155219.62400-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

https://gcc.gnu.org/onlinedocs/gcc-15.2.0/gcc/Warning-Options.html
> Level 2 warns also about calls that might overflow the destination
> buffer given an argument of sufficient length or magnitude. At level
> 2, unknown numeric arguments are assumed to have the minimum
> representable value for signed types with a precision greater than 1,
> and the maximum representable value otherwise. Unknown string
> arguments whose length cannot be assumed to be bounded either by the
> directive’s precision, or by a finite set of string literals they may
> evaluate to, or the character array they may point to, are assumed to
> be 1 character long.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20260305-nvme-v4-4-b65b9de1839f@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/meson.build b/meson.build
index 102f0cbb13e..f45885f05a1 100644
--- a/meson.build
+++ b/meson.build
@@ -694,6 +694,7 @@ warn_flags = [
   '-Wempty-body',
   '-Wendif-labels',
   '-Wexpansion-to-defined',
+  '-Wformat-overflow=2',
   '-Wformat-security',
   '-Wformat-y2k',
   '-Wignored-qualifiers',
-- 
2.53.0


