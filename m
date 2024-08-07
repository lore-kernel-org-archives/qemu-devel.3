Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BDD1C52D6F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 12:43:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbg0e-0007z4-Un; Wed, 07 Aug 2024 08:43:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbg0a-0007yL-4J
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 08:43:16 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbg0X-0005Mu-B5
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 08:43:15 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-428101fa30aso11933785e9.3
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 05:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723034590; x=1723639390; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TL5081hbBIr3tCvE3Zar9ZNbWMAEgMPLCiEUuGEST9U=;
 b=amPAUqAbJ5EwaF7SHnSLznkQyhv17T+WxnX9A5bCT0nHxZniduaVJmvu7q1xeGU4Ay
 uZENDLGew/ooQw5vZcMR419RRoNxcVeH1MtqdM7NpBIf3F4B91xem7tN1m+Gn48vP1Gs
 hMe/VJb4zqdChfAJOsPxvn40Dx6Lgt/0X64PbI2KHcQfZuw+1swglgaAh3xqoH3aOGqV
 mq4Fn3vIOPm9vuzjgjggKJxYt6htqR2uJ7CyeFADJGGOsj+d2dq+ucIFaXsWPOrgZGGo
 KKShlfo5BOSTtSO+lSsgfqIe4d3iUoRSMmGGgdL37M62km4t995zie+ulbwJth5B4Cpg
 w6uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723034590; x=1723639390;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TL5081hbBIr3tCvE3Zar9ZNbWMAEgMPLCiEUuGEST9U=;
 b=ot06UgGxHK38uVlARX1kxGiP5lQGUX6pghq/8U4MH0pYREV4Q8rNy9FcAccgbeubcD
 beY0NlIZ1Jxs79NqjNhETyhKgQoPdnYWqGLSsGiF2kmcmj0IUM5nDWnh5OP0gaTxraIj
 tnJpHR8ViE7CiLLdaSaB0SNlCjlxpYXeGyL6U29Jv4vcWy55R6zyCj02L0HbfVNoWrBw
 cgxYFgY2gxEWiMYRFgmUfAhABXGJ6lCku7m/91ogV4jiEEgF2KW2j9byHptdT/NRAidc
 B29VQKFe6RVktkYh41zyfyNWBdECxCemOZPRjYfrhHlVbba0gFa2aF5SJBgJrNlXmhyD
 XfjA==
X-Gm-Message-State: AOJu0Yw/+bQVZ5rkX4BJnUpjfvwL9BkzEnbje4MQpRNx49Vcs6cy5UGe
 AHdKKW/eHFoHjkSeDyTvP49ujtPYus6RuuxTAxWZCJYrnzmIUDPkgcpFIlh4AHf4otxrA3cjqiK
 U
X-Google-Smtp-Source: AGHT+IEc7G7QYv7gW73O8M6OTsRLj0UO4JUnxt/5jhy9axJArFbPwXsVyqHFpo5ZyNMPWZgXJQ1/QQ==
X-Received: by 2002:a05:600c:1c17:b0:426:5ee5:3129 with SMTP id
 5b1f17b1804b1-428e6aea7bdmr134195695e9.2.1723034589480; 
 Wed, 07 Aug 2024 05:43:09 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.120])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4290598f18asm27492195e9.27.2024.08.07.05.43.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Aug 2024 05:43:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zach van Rijn <me@zv.io>, Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 0/5] linux-user: Trace sendto/recvfrom
Date: Wed,  7 Aug 2024 14:43:01 +0200
Message-ID: <20240807124306.52903-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
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

Since v2:
- Do not squash 2 first patches...

Since v1:
- Add/use print_buf_len (rth)

Strace format added while debugging
https://gitlab.com/qemu-project/qemu/-/issues/2485

Philippe Mathieu-Daudé (5):
  linux-user: Correct print_sockaddr() format
  linux-user: Display sockaddr buffer as pointer
  linux-user: Factor print_buf_len() out
  linux-user: Add strace for sendto()
  linux-user: Add strace for recvfrom()

 linux-user/strace.c    | 51 +++++++++++++++++++++++++++++++++++++-----
 linux-user/strace.list |  4 ++--
 2 files changed, 47 insertions(+), 8 deletions(-)

-- 
2.45.2


