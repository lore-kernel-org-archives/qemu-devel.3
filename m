Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE5F9C5B542
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 18:06:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJcDK-00036u-PG; Mon, 26 May 2025 14:06:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJcD9-00035O-DX
 for qemu-devel@nongnu.org; Mon, 26 May 2025 14:06:07 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJcD5-0004oe-31
 for qemu-devel@nongnu.org; Mon, 26 May 2025 14:06:07 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43d0618746bso20040175e9.2
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 11:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748282760; x=1748887560; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hE4u9DqrVkOFxf3CMUX+T2PBWRw3eyPSmguG7jTFS18=;
 b=gfAGPvO2YcUop9hBX2lsoon4wxsEv21IFbuoVWV+5tZvBupfRjQBZsTnudB7IvJdM6
 4FgqI8kkBsr8CS7XZEt70nyf8yJyNO/cD/c7JOfmV5ouP9BhEcNfpMwxW2YhwX1cCBbc
 1SB6pln1udhZEXh7dUxb3xQB7cfx/y8FRNEIlimfPpJlOcPSwKKxAiU/X2buNeY/J4Ez
 90o98vORgHnMaCIsYSTDbBUrQ1P1WvO4LKR5wrmwLD1fKbfyuM5qZfKDJ9+3dV9BX0ln
 9C3lrY5GmsEio9fX8YgPcStCwwchRYgKtQG390XdK3PZtpddyUpl4Cpjf+pqTe12zSW0
 +DtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748282760; x=1748887560;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hE4u9DqrVkOFxf3CMUX+T2PBWRw3eyPSmguG7jTFS18=;
 b=bwOToHgKouM5mdSwiYFAIxVJiTx29xs7F1wfalSOtc+aKSTMIJ+wtrYa3GLjcSQJWq
 AbOWxlYcy0z1efXQQhyw26flHFa5yH/A6PW81zyjG7RQXUg/zBB0/XNtBq25KVR6adsV
 Rq0iTRFZLuDJ7AYWyNK7Ddpi8iAXVKKkwvxVcOwXoFIgJBzLkOzDzbaIp0j0jKiZMrV0
 aKlj8V7/KkaRL9rmwFH2MZITK/NplrwvMbj2BEENOss0zdgIiKZ4FAJbgVI6A3dtiSQx
 zOe+xVE7HGVgjJfAvxh5WEIIe5bif+xOa7tJkm9C40zqeRhDL0iAufq/v2yFAlUQbwO3
 6WPg==
X-Gm-Message-State: AOJu0Yxk0zZ/3wP2sxpE9FnSvTSYppq6neeoEc9sBGLfpwZYC3PHga75
 lpuhR4LG1eUwLwjF6L8shXicTnrWUQeiAZaRSMPccvRHWBrHZmh88ggttHA3+lKgSebmAd+BgVJ
 LrVCH7gY=
X-Gm-Gg: ASbGncs/qV+I/VQ0qLPgzyJHZJE9kJXKUH9sNCO445PlJldIX82MwVBFQyTfkWUriU+
 QhcSqM19kgHoqycHEC4mrhVjB5YlrSRvOdjlZg6oyfgcTqpLAmv346yyU/plvPOuSimNWeWiaj/
 g09aFyaS9r7VQdqYjZOmjY8VGuGtUDZivzkdv6/tK3HQKiJi64OSt6YZLwWXhNMGSzrVJ+gUSu/
 axJ9WzEQmhmYJ7X8XfR7LKtmeVEqBbpyL29qhKSuJLJKNCbGAYJ1essICwsQGH6EYROgOPNyC61
 +720yjOtTX74wRs60z/OL9yQ3I1kT3+0QmKj44tSi9L3sbLh10BI/XEciiGp94RBmosVleewYU8
 qn6s9tF8tXRNjz/xWfGSvPBfO+b90Zvc=
X-Google-Smtp-Source: AGHT+IFmZjlg6hHfzYy3Ryf+U4j3zkXN5lh5z+BoS/BxGiFEf1EdXwS9/tVB7rR6c0S7f44Spet/xQ==
X-Received: by 2002:a05:600c:64ca:b0:43d:46de:b0eb with SMTP id
 5b1f17b1804b1-44c935dcaecmr84888305e9.12.1748282760107; 
 Mon, 26 May 2025 11:06:00 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f38142b8sm240601545e9.30.2025.05.26.11.05.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 May 2025 11:05:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Laurent Vivier <lvivier@redhat.com>,
 qemu-block@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 0/2] hw/ide/ahci: Delay a bit before completing reset
Date: Mon, 26 May 2025 20:05:56 +0200
Message-ID: <20250526180558.65613-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
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

Intented to help SeaBIOS development; untested there
(except with QEMU test suite).

Jiaxun, is it helpful to you?

Philippe Mathieu-Daudé (2):
  hw/ide/ahci: Introduce ahci_reset_delayed() and ahci_reset_complete()
  hw/ide/ahci: Delay a bit before completing reset

 include/hw/ide/ahci.h   |  1 +
 hw/ide/ahci.c           | 70 ++++++++++++++++++++++++++++++++++++++---
 tests/qtest/ahci-test.c |  4 +++
 hw/ide/trace-events     |  1 +
 4 files changed, 71 insertions(+), 5 deletions(-)

-- 
2.47.1


