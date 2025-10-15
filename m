Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E57DECCD194
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 18:03:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v95p9-0003rD-OB; Wed, 15 Oct 2025 14:02:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v95oc-0003n8-IX
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 14:01:44 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v95oV-0006Dk-VK
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 14:01:34 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-46e34052bb7so78873815e9.2
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 11:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760551277; x=1761156077; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zFhq0jSUzPui062WT9pMVnpcMzTRdbgoXIZAb5xoQ3A=;
 b=bcccLAxJ7HA1Z9qPcoFiBiQngz0t6vtpaTV2FAZq6AdsoM4dpI3vBJirESP/m0MUI5
 pQOcMMJjLaF066u+F+2sCFNS8JyOgp2AogDe1dhYMTSHVZTkB3E0XwBk1UM0d9mKCI0L
 XQ7F6qKpxcUODb+J3xs+7CHrAljYacs2YjoFCCX9kR9LLD+6XsQNsOOH6s+Dj6v+XnCV
 RXi9cc2U9MKp6Rlu1oKi0snDYxbRMUskbvwoGFN2C928lqukhAwj+twF+D89A/s44PcP
 qRZZte/wuZYleD+sMJe+PGa7HeNzmQl0yRWF1nROw+qDVIiRJKxMqp7rZcg2eIWDp9kO
 iHDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760551277; x=1761156077;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zFhq0jSUzPui062WT9pMVnpcMzTRdbgoXIZAb5xoQ3A=;
 b=dUGNjBHN29S9wc+2WWnXkMFujnCMEuRyEmhuMNkdNIrbm0/DojNWnc4N6zfO2qgQ0y
 Xr9u0pqZbagYd2QTBWcjzI44TWpR91zvOxH1dkp4iIxhSVPa/WE4gEshsneV0LjVQPMP
 0xBaTnmVfeEBhjwayyjQnXPJZyHLhKAAXk99YTt6+hkC6uEaSFslN+JdFxohCnQpTFOB
 tZm3pP1tVpq3hrGSjC4SdE4E7dyJ9AruL4Hl2gezIvEtp4zbQ3Ga/tlee7ojImSc+pQd
 Y+gSWFVsowFmQYXC5DCLeZAERY54HLw83SV6+57u2K1plahmS/Jdhc3Bbv9ESdrjp7cF
 i1rQ==
X-Gm-Message-State: AOJu0YyVIZJjxfj9kCu1ZWK5abTw6BtjcfhK8TQ5CvCzLvvGsBcRWjGX
 7CPX5yPlKik4zb7+gw/J80kujckn3GWFzfWwZ7kigdmtcPZQDLoMxxMlM+M2Z2GdFfCGmg5dSxh
 RHrnt1vk15Q==
X-Gm-Gg: ASbGncuNiCTvaezZDsPeKqsi/gLnQflPa7Iagq6ixBNjM5RNTj+56BokSkOsbtD3qEw
 GKhiV/kEH/e/mfz8z31uYfAm3M1L7KZv4zihaYqvl396PahSxzJuP+XrelKVvFNgRS7sHIs7uXW
 cTaJeSvni4o1MB2lX+Ld/l/FZhx0f0uly3+U0I1VZDGkUTHaP4KMN/wLfnrBFSWD+u33Zt47RXf
 fP+V+JxFVjHMh/YixchyuhH8wfxdxtTGTuv1uNiJ1/l8yeyWLXCV8oYgmTmW0Xg335dTs8Z0/C0
 MLE7Pyn8nPvfZDOhD5ZhfqOXoUkEIH4LdBDAyN2k3goYpmRLGJca3Olq1Bw0IiynYouaP5gcUAb
 ZMVlKeJf5WAEuf8sCh62d5Az3EtIf9Gk58EJm52H8+yRjGvxsGnkLBZtgdvIP1Bko5XDHw3rCOx
 6vQl9cw277jxwg8w2mfw0=
X-Google-Smtp-Source: AGHT+IE3pcArPiRgoGfIMZYJFuBh7VCth8p91gdDkjd71oZ9TNfu2OP/XZQf+CetVfMH7c/oLYn1CA==
X-Received: by 2002:a05:6000:420a:b0:3ee:1521:95fc with SMTP id
 ffacd0b85a97d-42666ac6a8emr19167016f8f.14.1760551277439; 
 Wed, 15 Oct 2025 11:01:17 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce57d49bsm31761371f8f.10.2025.10.15.11.01.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Oct 2025 11:01:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 0/7] target/microblaze: Remove all uses of target_ulong type
Date: Wed, 15 Oct 2025 20:01:08 +0200
Message-ID: <20251015180115.97493-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
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

Missing review: 5 and 6

Since v2:
- s/TCG_i32/TCGv_i32/ 🤦
Since v1:
- More uses of TCG_i32 (Anton)

Remove the left over target_ulong uses in MicroBlaze frontend.

Philippe Mathieu-Daudé (7):
  target/microblaze: Remove target_ulong use in cpu_handle_mmu_fault()
  target/microblaze: Remove target_ulong uses in
    get_phys_page_attrs_debug
  target/microblaze: Remove target_ulong use in gen_goto_tb()
  target/microblaze: Remove target_ulong use in helper_stackprot()
  target/microblaze: Have compute_ldst_addr_type[ab] return TCG_i32
  target/microblaze: Have do_load/store() take a TCG_i32 address
    argument
  target/microblaze: Convert CPUMBState::res_addr field to uint32_t type

 target/microblaze/cpu.h       |  2 +-
 target/microblaze/helper.h    |  2 +-
 target/microblaze/mmu.h       |  2 +-
 target/microblaze/helper.c    |  3 +-
 target/microblaze/machine.c   |  6 +--
 target/microblaze/mmu.c       |  4 +-
 target/microblaze/op_helper.c |  4 +-
 target/microblaze/translate.c | 80 +++++++++++++++++------------------
 8 files changed, 52 insertions(+), 51 deletions(-)

-- 
2.51.0


