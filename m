Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 428CACCD187
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 06:20:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v76Sv-0001Zl-4d; Fri, 10 Oct 2025 02:18:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v76Si-0001T2-Bh
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 02:18:46 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v76Sg-0001Fm-CJ
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 02:18:44 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-42421b1514fso824098f8f.2
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 23:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760077118; x=1760681918; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qgN8PirtL1wAXx2eZzf1aDL1LMCanDOchi4wgYl/Gek=;
 b=PeOsK07uUef9/0ND8jiql1+SqHO3HDXLu2PDjUFOhAND/ix6lkZafNH6NlRKtzRxrV
 klGh+td2Bi115IqukwoPX10tKBAcpeEWxHrOtxoIFM779SrX/CBpLgf0fwO8ZoAhYmzC
 Zycg/WSQxMtFUhN9znaxagEBJRvhAY/kzdWQtaMjLYxCPA8vcuK1H3WLIK+W+jW7Ibej
 cngKlO3f5gY8vKr9IU70fwm2HcN6H9WI7R9040JVVlsJL2UKZu/t1CP+SK9e3+2GBygV
 ymQJJwmRdy2hgsGzfgFRtSRINtSiy1gPx0eKhIf+KUE4NDA3OrW5WPM9LpDip/cHIy3X
 FW1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760077118; x=1760681918;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qgN8PirtL1wAXx2eZzf1aDL1LMCanDOchi4wgYl/Gek=;
 b=oqtbZXvQ47o4y/cmvXXYmMefdx1W/LMELPPas6O5GMctqQt+8AoB4OhadY725L415C
 Nipgp8OjQ5iWl7j+qSddsxz8DP9SYxK7uR5kXBrmnMvT3RZ17quJK2H4VjglouNtLMSl
 P6geAGOLFbDgEFRwBUTh7ZFAq1qKIjedFVSm9eW8SCoxDvd9b9w6u3Oht0DnAkcFXpbH
 bVfDNt683M4nZUw6x1qQ4JGJId0pzSrOsc0GRSOVSjXhY5PaKfYxJH4fkE+9YLKdHqPI
 AHTYaQ3Lz8ozVHhYZgza0kD9wcQil4chaABQsKBfUU5jmq3A7cgkJ+ApBnrbOkM59Jsv
 H27Q==
X-Gm-Message-State: AOJu0YwIh7N1JbzU6ztLL4CHwNi0d7uVY9d8jGs/aYikqVLMKRmv24kv
 EoLi4tLBjMVU3/agHPa9+CTsgjdRn88WfpfHLxwe+QSsW3bNOAQs2XseMqD0DMO4bST+JA/fv6c
 8ZqQN7bLIVQ==
X-Gm-Gg: ASbGncuuAbHaP+okHzNBB/ff+AVEPwIqKf+F59wdNGGKNmYf5hWzNQ/T73O1stmGXNp
 5+AH6FUwIeAFHrLIMS8ZmK1iBdyQo+AfOb6yq7/UxAby5aZ3+kcZY9S4+u3abdp4akgUWfWSvuI
 UiOJtoOibAAaIwYDsPYs5DEk2C1sgPwqSreFwCnZ4nDX7c1r4fhFyzGCYVrbO0PGhWjwVDiV00l
 N7nfElgAWgYKsuoNTSN/BQCBMMAzssIVsQqBfRyiKyIkYNb15n9eBAKo8xpK7RLqMhExDs7//3U
 2VNpNGDoP7h6QlTqVa8qOurPtN/ozPq2T3xkqAAoHIpRdIk8sTQTuJvrTxwL5F2TOglWil00M4Y
 vBLCGlBWoEUpaAzG3lP0gD22T5kWMBbokcYWC+fQyMRNlEM8eU/lU5M2IHGZ5zPvZF3bvLtxtvn
 roPDODV4v8V6OBZ1g+3XYQq41pyTQ663Ogu0M=
X-Google-Smtp-Source: AGHT+IHIxzhCOYo+HF8E11GlVEpn7oM97pQa/Kkuc/IsbL6c5D79xftuvtt0zYdRPWuVrUT63QMFeQ==
X-Received: by 2002:a5d:5c8a:0:b0:425:8125:ac79 with SMTP id
 ffacd0b85a97d-42666ab97f0mr6587425f8f.25.1760077118232; 
 Thu, 09 Oct 2025 23:18:38 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb482b99fsm31628495e9.3.2025.10.09.23.18.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 23:18:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/6] hw/hppa: Clarify machine variables and move them out
 of CPUArchState
Date: Fri, 10 Oct 2025 08:18:30 +0200
Message-ID: <20251010061836.45739-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

Since v1:
- Simplified (rth)

The HPPA machines uses a pair of variables for distinct meanings,
depending on kernel or firmware mode used. Replace by variables
per mode, allowing to use the proper type. This helps reviewing
the code. This cleanup allows removing unjustified target_ulong
uses.

Philippe Mathieu-Daudé (6):
  hw/hppa: Convert type_init() -> DEFINE_TYPES()
  hw/hppa: Factor QOM HPPA_COMMON_MACHINE out
  hw/hppa: Reduce variables scope in common_init()
  hw/hppa: Move CPU::kernel_entry -> Machine::boot_info.gr25
  hw/hppa: Move CPU::cmdline_or_bootorder -> Machine::boot_info.gr24
  hw/hppa: Move CPU::initrd_base/end -> Machine::boot_info.gr22/23

 target/hppa/cpu.h |   4 --
 hw/hppa/machine.c | 152 ++++++++++++++++++++++++----------------------
 2 files changed, 79 insertions(+), 77 deletions(-)

-- 
2.51.0


