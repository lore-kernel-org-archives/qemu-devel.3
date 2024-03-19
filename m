Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C431C54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 06:29:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmSy7-00052K-4k; Tue, 19 Mar 2024 02:29:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmSy6-000521-23
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 02:29:02 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmSy4-0005bl-FU
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 02:29:01 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-33ec7e1d542so2816837f8f.1
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 23:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710829738; x=1711434538; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Yzwu8Bi0D3UNtFLlf6Zo9X6jTLsaWPc1Ocv5RRkNU2Q=;
 b=NBhywOqqhRWlFzOnf0EEvso+dvnE3gD1XBukmAZw9yxUsbHoecOPKU2LMeTGrvXOyc
 PINTRjRXhYUIM7IK+q5k8Q0fT3HsNQOaIbKvJQF0WwhbsS1ErCcO4FRc6WlaJpTA6AJb
 R5JI5XDnpai1ijhnfYqMBERrwr8+yKFMe4LUWhUrTFN0dF4qneSYzVq8PBrHGXH4QZFF
 bxEANQg9NCoZIpypg4wC6NHWvyTALi7rwyS9RWUdC82vxyY3eiNIqAzYznhf+16ASge5
 jsd1BiXcnttGOzTF7MwcbuBxNdn1UuSu8xExnQ6T3Ctp2X6n3THDQy4OsLHdfuzFwePi
 GT6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710829738; x=1711434538;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Yzwu8Bi0D3UNtFLlf6Zo9X6jTLsaWPc1Ocv5RRkNU2Q=;
 b=Ld1L32JVmGjzTJFLjnLYVtRkmxV+CeUce9LZG2+w07yg+ho/oTTe/jRdCXKIsKdXec
 nxHg8RYOmHUY5+IPk2vxnL5zvzYFUffXYI9oPCMz+ExdsrDlk4mB8YERnGWbMhm72qy3
 6nVfb6T8IJQ7bx1W7PM/N3t/LvMJHxCAZYRCnyTBPOraNHotVj7/dvWhCAnqqh9YiGtJ
 /J3h2YzySv71+VGgPRvkNvxWLmpRVav0LTZhyxy81T4mUA8ZyGEpGNI9r3hXpCp9lJwL
 v+ROC+v1E0WJbf3SgipDDoYOrxH6Ia7P2OhXY/eG9jcsG9/zmLLfXmbfQ4nGz5DdB+hU
 RZSg==
X-Gm-Message-State: AOJu0YwgK/2Cj7X8wyjuy8Dera3ad6P0V4PiojzkP48q/IGYNkzoHtdH
 aW6RRCCltIMsHMg7NMdFhmV4/1G1sr33WD2+pR4ketxHoSHi5WrMvGlB5dKIerbvoxgAUtgtm0W
 b
X-Google-Smtp-Source: AGHT+IFAfIy/TdgXZEjpbOhC5Gpv0opa7LsJDzTKpQ1n1r6rwZXweN4Rd1+o07yaxZYy5k0MW+f08w==
X-Received: by 2002:adf:f58b:0:b0:33e:7065:78f2 with SMTP id
 f11-20020adff58b000000b0033e706578f2mr1020884wro.40.1710829738346; 
 Mon, 18 Mar 2024 23:28:58 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.166.129])
 by smtp.gmail.com with ESMTPSA id
 l15-20020a5d410f000000b0033cf4e47496sm11456672wrp.51.2024.03.18.23.28.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 18 Mar 2024 23:28:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, Anton Johansson <anjo@rev.ng>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.1 0/8] target/microblaze: Sprint housekeeping
Date: Tue, 19 Mar 2024 07:28:47 +0100
Message-ID: <20240319062855.8025-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

Cleanups while trying to remove non-essential target_ulong uses.

Last use is in helper_stackprot(), but I couldn't figure what
to do there yet.

Philippe Mathieu-Daudé (8):
  target/microblaze: Use correct string format in do_unaligned_access()
  target/microblaze: Use hwaddr/vaddr in cpu_get_phys_page_attrs_debug()
  target/microblaze: Widen vaddr in mmu_translate()
  target/microblaze: Use 32-bit destination in gen_goto_tb()
  target/microblaze: Restrict 64-bit 'res_addr' to system emulation
  target/microblaze: Rename helper.c -> sys_helper.c
  target/microblaze: Move MMU helpers to sys_helper.c
  target/microblaze: Widen $ear to 64-bit

 target/microblaze/cpu.h                      | 12 ++--
 target/microblaze/mmu.h                      |  2 +-
 linux-user/elfload.c                         |  2 +-
 target/microblaze/cpu.c                      |  2 +
 target/microblaze/gdbstub.c                  |  2 +-
 target/microblaze/machine.c                  |  2 +-
 target/microblaze/mmu.c                      |  2 +-
 target/microblaze/op_helper.c                | 48 ----------------
 target/microblaze/{helper.c => sys_helper.c} | 59 +++++++++++++++++---
 target/microblaze/translate.c                | 13 +++--
 target/microblaze/meson.build                |  2 +-
 11 files changed, 75 insertions(+), 71 deletions(-)
 rename target/microblaze/{helper.c => sys_helper.c} (84%)

-- 
2.41.0


