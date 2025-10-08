Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B54ECCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 06:02:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6NF8-0000po-9y; Wed, 08 Oct 2025 02:01:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6NF2-0000mZ-8k
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 02:01:37 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6NF0-0000ZM-Fc
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 02:01:36 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3ee15505cdeso440954f8f.0
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 23:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759903291; x=1760508091; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=j/HPQrNaUmj/ytzSkCmd5CDPSDtiswdIlwbkmYNxbUo=;
 b=UdXxJkzX2LzOpCwIHzwJg4m75c7/0aXmgm1MKf6zYLnSaqXpKUzZncPhQBZNCecwR4
 KJ95h2upV9bbgjyNwGPXMpHiLdrDUGtWmQMdLZbKOsZnbD44gHKOwpVi0rH9vh53W/Mc
 PGYWf/416pdvEko0ZMje7t/b3M1iFu1QfKfovEVhQoKP53sP/8vLRJUWXlgthVPWTg3E
 2z8spwF1uKkx+C+yyGaUT/1IwVfJszAlJafkfPArJB3QQl5BURvPTmZPu7d8l8jqrE4x
 v899e/3Ob7Ga8c4J70JQ/vGcZWvF6xDW8AnxjDL9H5hPKMJNSvuT8+57RSgWbW+EcXuQ
 rCKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759903291; x=1760508091;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=j/HPQrNaUmj/ytzSkCmd5CDPSDtiswdIlwbkmYNxbUo=;
 b=tPDgBe0qwKIk8/B5h9dWToqNMTMhwSrgfzq5Vq7kRbri1WrzggFNwnEIK8sCn0tmmX
 xs3MOif7w9mefkDUWqy4HAP6Mrk/XjcOB9/6VHB74mT5xIKBu0F/0bRghySmkCg/XNZD
 JtN7baoK3MREThubW6npxbqt10pK2jHzNa/BibhpLOcSn8dYu0EyFRgOxN0+lje9/FmO
 vqglVc9l/lYcWXa9jUL3ITsHNsS4UgLrS6BlvBeod9gauv2P24MnPd69MhBcwIfkysLh
 P6dclxKKI3tyvC1VcduFUxWSjsWZ9X1Vzuf8Abk9F3ZJHYJ3tEOeyXtG/CqRdtr88Q4K
 HiDw==
X-Gm-Message-State: AOJu0Yy0E1ChqWhCUPkb9lLOoaXWBWt65YM8vo0PMReEw4KWjb+fZ63j
 V19JKmEfVL3YCanubFffue2Veo81YZqN/nJJebI17vAyWNAMFpEJcy1nFCbe9KDcPhVBOmrhc/h
 BF0rfuRwzVw==
X-Gm-Gg: ASbGncsxjm/BJxm6YLe177R3FTfehb2DgeSXcMlw/+HgTpNPz3Vjc4/8CRkeMwyHeAk
 gHUUWTqsvxWpj5aYOAvbfVZQOWTXbreFFPXYx9VRg6ScdlYvFZ3bd02KvjLIgbo3KHkfXyZlzyP
 FEkDCaIVZAi2Umc2N4ORVX9OezLH2prTZncI9zQXDnYX0tXYwF6Rj5cL0RnQdIjGSoVc+plwNzn
 ZoPFmlvdLz+h4Uxo18vmYBz+kretOWol+iMHpt10YclRpaf506wWjhOlEOHTJkhYFLNKUEHfFxq
 K2xfND7LbzFNnhLb241weF1EgE7sNnzEaLpKBvhHjocgA/7jpN7cfJZFHXzQ0VK8NWNrPYuJ+gQ
 7MjitxgohMpUvgJGcYrvNvoV+j4ZyU/d3g9vKLL9TzwWJyzuMqNzLUgFltoClIeztDR1fjaQfbe
 Cm5Bmo1/UM+TAXfkp9d6khuCez
X-Google-Smtp-Source: AGHT+IFjSxwXIUj1w4JYZfYRGyXXs4bm6PDK1wJZ4dxRXX3cghy/lw5dT7MqjoS+ecH45ZiTlJzgHg==
X-Received: by 2002:a05:6000:24c4:b0:3f4:ad3f:7c35 with SMTP id
 ffacd0b85a97d-42582a0534bmr3602231f8f.27.1759903291134; 
 Tue, 07 Oct 2025 23:01:31 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8f4ab0sm28402952f8f.52.2025.10.07.23.01.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Oct 2025 23:01:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/5] target/microblaze: Remove all uses of target_ulong type
Date: Wed,  8 Oct 2025 08:01:24 +0200
Message-ID: <20251008060129.87579-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

Remove the left over target_ulong uses in MicroBlaze frontend.

Philippe Mathieu-Daudé (5):
  target/microblaze: Remove target_ulong use in cpu_handle_mmu_fault()
  target/microblaze: Remove target_ulong uses in
    get_phys_page_attrs_debug
  target/microblaze: Remove target_ulong use in gen_goto_tb()
  target/microblaze: Remove target_ulong use in helper_stackprot()
  target/microblaze: Convert CPUMBState::res_addr field to uint32_t type

 target/microblaze/cpu.h       |  2 +-
 target/microblaze/helper.h    |  2 +-
 target/microblaze/mmu.h       |  2 +-
 target/microblaze/helper.c    |  3 ++-
 target/microblaze/machine.c   |  6 +++---
 target/microblaze/mmu.c       |  4 ++--
 target/microblaze/op_helper.c |  4 ++--
 target/microblaze/translate.c | 19 ++++++++++---------
 8 files changed, 22 insertions(+), 20 deletions(-)

-- 
2.51.0


