Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3381C46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 11:31:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUmKx-0006IV-RJ; Tue, 30 Jan 2024 06:31:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUmKh-0006D1-RW
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 06:31:16 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUmKY-0005Mg-Ls
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 06:31:12 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40e775695c6so34190545e9.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 03:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706614265; x=1707219065; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uriMJ13edI6G4XpJBTuYK8QPI1ou+khs8JB42NZhqwI=;
 b=tfHCOuBl4VRcn2Ylb8CsqLqff64WElX2e9BWTM7eLr1C0bK/P1m8s7tyTQpKpQHtJc
 MJS7tehF7Vm5V4sN7BpZmqyTkrVQP6ZwbPgTUZuep/ESsSbr3J/ecHeGz9cbdxmFOJzG
 K09t8GPK/ABGkbiawjTGqU5GZ2RollAuo0uXLh7+VsEyPJ/S+p+6Zxv5G1nel7dzKAZo
 cogs9HreqZcED/uyF62R1/gt+w58HUUMV6NEIWwC3A1gg+vQcSO7/YM3TPg5g+mR2/HA
 sDY2z97/6l9QtMBP9gMsGzWTX5x4A0iuIftUzOBrPF7VcCDFmyLJe6F536PRaMy/yPJD
 2VXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706614265; x=1707219065;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uriMJ13edI6G4XpJBTuYK8QPI1ou+khs8JB42NZhqwI=;
 b=Sh2MDCQ32CPYCUp6o3NFdj3ZGd5cvk8vkgRRauHUjlniN3gdTMRIBENuEq2KIfkPwm
 Va6TGjIU/bPu9nwAH3LnOa+lmX0Wpb7IoBxjnB/pIy+Tb4KN0CVWdRte6OuQulkDDPZw
 jnV3jaxEToiqQLLLDZ7lueiWUIMLU4BSPFERDWNLvIGPYluFCZG2dq3Igio4hunsJCNf
 JLS7RGox7S+zYpsW64jC7uxWGRFRuEron/iHgbtaD1ht4SiSQQ11KjP3pauYxwpE7qnU
 DmyJ4EqtwSbUFqDZ9iNAlU9Ehzhe5vh5m+NY63YmCn3BKcd1pc4CvLgBv5LDe/xoqaBL
 la1Q==
X-Gm-Message-State: AOJu0YwQh48apMvU2mPwwjdsRBQ+rTQD1gi7rh2nDXjYoKUlUcBF6ZmV
 iuS77zCtqk6bS20og6i++c7MUJCIFsJz095UL9knLo8Fj9G2yNp/jiOv8LH9AV22z+3HMi+o3Rq
 S
X-Google-Smtp-Source: AGHT+IGcQMfVZ5giNtbbd1ZVB3eFxRx69II9jxTV1A5uZsVuhvuzSBkwSkB9O/wXJThxgAXxR8ypvw==
X-Received: by 2002:a05:600c:35c9:b0:40e:f438:2f89 with SMTP id
 r9-20020a05600c35c900b0040ef4382f89mr4985571wmq.18.1706614264863; 
 Tue, 30 Jan 2024 03:31:04 -0800 (PST)
Received: from m1x-phil.lan ([176.187.218.134])
 by smtp.gmail.com with ESMTPSA id
 u17-20020adff891000000b0033ae55db108sm7925438wrp.20.2024.01.30.03.31.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Jan 2024 03:31:04 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>,
 Fabien Chouteau <chouteau@adacore.com>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/2] hw/sparc/leon3: Minor cleanups
Date: Tue, 30 Jan 2024 12:31:00 +0100
Message-ID: <20240130113102.6732-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Minor cleanups noticed while reviewing Clément series:
https://lore.kernel.org/qemu-devel/20240116130213.172358-1-chigot@adacore.com/

Philippe Mathieu-Daudé (2):
  target/sparc: Provide hint about CPUSPARCState::irq_manager member
  hw/sparc/leon3: Remove duplicated code

 target/sparc/cpu.h | 5 ++---
 hw/sparc/leon3.c   | 2 --
 2 files changed, 2 insertions(+), 5 deletions(-)

-- 
2.41.0


