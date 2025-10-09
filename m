Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13D27CCA470
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 08:19:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6lrm-0004UC-K4; Thu, 09 Oct 2025 04:19:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6lrk-0004Ss-Gb
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 04:19:12 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6lrh-00085U-Fz
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 04:19:11 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-46e61ebddd6so6956695e9.0
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 01:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759997945; x=1760602745; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Qvkbzp3zkfmnMdWNdkG0QcZthVBpTwn6djxCZAbJMe8=;
 b=dueRg9nD7782/gPHN/JLYci1nk0O0QPsEINYmeUSXxCBkniwsttdtY/nXJaNy4LFzz
 T8an3HEJo8dWG27gDFtMoE3PhIBHitObH2kW14grfN+z3147RgpzOiOw2lAG/Zrn+lGH
 qUx+QNMN/OFUAClj3cYPEhxUgnc5tbThlz3SN1nbUJIpPJot6u1XPZR1mbgIwmt/KiEz
 TxBytso/MA2Fn9y6VIdkH3n94dP8x0NlxVPB+TFmGXa40oWzGtqRllibyJcU6SMQDvMJ
 zvnQIz/BUgKqfdVJ548z6/VxNGpyeFXsUVx8Rdt1XJa/sBsl6dwNlp3bVrQllcoWmAh6
 tUBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759997945; x=1760602745;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Qvkbzp3zkfmnMdWNdkG0QcZthVBpTwn6djxCZAbJMe8=;
 b=rYHgO6sQfq3zy9sRMUDFVgjuqSIGeeJ8LzIiEXOj73XuYGXSrEObEQ53yBlFJoBiuu
 HycBiVaABOdmBdwKCSRbme8+o88eiN1TLOO86D2P1wE78Nfdkfhll4fJKxhOFWsovI9S
 mRnrRVVHOMR259pYtJCAqgcCJpAonBcNgD5NwE1Gk5AoFkVysVwrrIVcDWbE1DEc1Lb0
 /BHKOOq3qgWVcFojBlLgf4mhFSgQYxUE68SNseAeT5nzlySCIzGAN3kConJQpXoOZRC0
 7gyNMPlFppRsHsjZz7tKyxQ5hva/FDLFIogTdC+I0cSaFwN4XKWBhwyRYqQ8O/X0mmEv
 A5kA==
X-Gm-Message-State: AOJu0YzB2a4SNaqagdM7eG3aR4dkUcQQ8ua/yADIa23GWU7CvswM+iKp
 pyMg/7Rlv+q6u3b1nNa4wBt0rbdVpb8ERxMGYad2N89iU8dnz/7eiDZwlP8EGObt+GLzzPzZWOv
 eOoSoFm3rmA==
X-Gm-Gg: ASbGncsAb3o2d4uTw5FeXMj1mZa6t0ocyAXPk/edgiWT3WKQ8nDpdn7fY0DYIA+hXYW
 9tAkKZq0dfu4ecDkDHPxm+/mFGYPpx2TtCLaKYOCIZPMI5vNiGvJW50ZNbuw54/Fs6Xhn4d/I1z
 IkN+BjqxLXE9J1262hXzJwPIp4tHJjPdD0Pvo48RoO9zUewykA18923yJy83RMzSne1tK+SaREP
 4ppP6fwUOlaXMEIxKXPCafwHfHswERjY1+fgANuX8baePM+N63osOB7gp0hG0zsmXmWyHqt6GF1
 K3m8vEe1Sy6y5/Bt0OrhDO2akQbQUH10MGtY9nAfpy0gZ88X52k8CTolBRIsK/nooX9UwGFXLk3
 yFcI4nAxvKD1wymeoiGy68/1psjRMSiKJIcYdOjOpJghz9+cIjl9HrWTCywuVJnMz40lwodCRUi
 PGOdzW1cX/tEH66BUBN1tvMigDPs+P+arupu4=
X-Google-Smtp-Source: AGHT+IGOkVyIroh7yJD9twvrWstQ3wQpqBzC8qbNaiu5WgWXiLnNI3RhUEZgCgDCylMRSDDcUwfKnQ==
X-Received: by 2002:a05:600c:4510:b0:45d:f83b:96aa with SMTP id
 5b1f17b1804b1-46fa9a8f2e1mr38392735e9.7.1759997945101; 
 Thu, 09 Oct 2025 01:19:05 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fab3d2c1asm31483105e9.1.2025.10.09.01.19.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 01:19:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Stafford Horne <shorne@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 00/10] target/openrisc: Remove all uses of target_[u]long
 types
Date: Thu,  9 Oct 2025 10:18:52 +0200
Message-ID: <20251009081903.13426-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

v2:
- Remove 'TARGET_LONG_BITS != 32' dead code
- Addressed Anton's review comments (MO_TE -> MO_BE)

Remove all the target_[u]long uses in OpenRISC frontend.

Philippe Mathieu-Daudé (10):
  target/openrisc: Replace VMSTATE_UINTTL() -> VMSTATE_UINT32()
  target/openrisc: Explode MO_TExx -> MO_TE | MO_xx
  target/openrisc: Replace MO_TE -> MO_BE
  target/openrisc: Do not use target_ulong for @mr in MTSPR helper
  target/openrisc: Remove unused cpu_openrisc_map_address_*() handlers
  target/openrisc: Remove target_ulong use in raise_mmu_exception()
  target/openrisc: Use vaddr type for $pc jumps
  target/openrisc: Remove 'TARGET_LONG_BITS != 32' dead code
  target/openrisc: Inline tcg_gen_trunc_i64_tl()
  target/openrisc: Replace target_ulong -> uint32_t

 target/openrisc/cpu.h        |  31 +--
 target/openrisc/helper.h     |   8 +-
 target/openrisc/fpu_helper.c |   8 +-
 target/openrisc/machine.c    |  20 +-
 target/openrisc/mmu.c        |   7 +-
 target/openrisc/sys_helper.c |   7 +-
 target/openrisc/translate.c  | 443 +++++++++++++++++------------------
 7 files changed, 244 insertions(+), 280 deletions(-)

-- 
2.51.0


