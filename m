Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D2F4CCA476
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 08:17:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v62rx-0006ne-L6; Tue, 07 Oct 2025 04:16:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v62rw-0006nG-QE
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 04:16:24 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v62rt-0001zn-6R
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 04:16:24 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-46e5980471eso29554615e9.2
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 01:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759824979; x=1760429779; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XK3NTl2B3zTpPA8Q4QoS/MR0UKSoTctc+BHX4wlh/xE=;
 b=tVaoyCKAXb64eVCX7LeB/iADcnj7ohXbqEdPWo6sRaN35LIQjsXdVqojP8CHd8inDH
 v6dEJYPcb8zdxRJxEbVXoOszbLxCDkrLRhQVu27ckSSuyOpmR3/9isjEnJzzJ3w9KT34
 EUFMyJceW/11V8Zgj6KowB3CK2kp/VYndoiPikz3zf31bZXseL4ldrXBqRKiYa5c+Omb
 HmcmgPNLlD42Upx+sw391QXqzjEplmdAHSkxBt0kH39UrIsoA1xM44/dYbyTdoh/knJe
 fpVLvo0txUN0nIKDdXCVbVyHge0cvQkZFyaqvRqDvhMf1GadV2s9czefaBZ+ar6+cr+b
 LxPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759824979; x=1760429779;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XK3NTl2B3zTpPA8Q4QoS/MR0UKSoTctc+BHX4wlh/xE=;
 b=nkKn+IKw0ZBeLtZbzRoPe4r9dZgWCUSn82w1FSgnw/n6GGNaqnGDcDpMrcdkjx9hLa
 MyqENcZKj1ghcPMRpPPnUTalbdYBI12RbBd1j5C2fZl+deXFAzES8Duqbs1oMr5JFclZ
 xunkXxj3VsP5jCEXl1p1XQepSHtcWg72EM0LGASRUNqf08O8nZPy1ci65ewIAla4ni+X
 1RbCQrCbPGOV7vy56LGWAWaPGXFBtQo58yjIwZJvD1DNz6h1hRP9e+xZs0TfNdkYQ46M
 QGEQBIyrdsnsvPnHkHDdULjy91lC+UZit+bNevmrzX03kL5YP125ekV5/ktlfqPwmDtF
 NnWg==
X-Gm-Message-State: AOJu0YzbYe2TerMuZaVH26FYLKbzO8y9SivOF4FR3HrJ7fTSizxPyzWZ
 ouQWS78VR62l6dfkH/OmgQjXoA2j4qlCYpF6Flnl5IPDc9uQXxGEUxPzOvqPztqFwXNwNdnczNB
 DnPEu86NRhA==
X-Gm-Gg: ASbGncvyF/jAwwk2yd8zoQZkMqagDi/R/uc/zDR8x2ykM292EuyLET9PC5BeLB3gaXW
 2QXE+izSjjkPJpDnPeqvtY72JH1gxfXfS/rBfnX69YpVb9Bq1GSYjWtkJpQN78PvJuvB2LAGxes
 0jL6XCoMQoEVqniXPQXFDm8/rFmtt8mMeXnyla7MeD6C3UVWu9nskP0ZMUpUmYY+Nv5uNolCbhh
 IhrHNwQCX1LYd0YI/mINNAHL/pNRsao7UmnNa5nX6xCmGqJvAly0B0xNi6LtSNnjhk1H8r2d7Yj
 p6VXXGZB3laixAEIIyCV+cSxDsDjxSbO1/TYSgJsI5/OqTeLWFPEApfhekLHpTkUUwErYjl8d7r
 fmPECHC2h7gyPrW44yQb5Nhwhb6yNbwR+tlrALh8h8hghzq4atah6l5yHbcfMpwlS0uXc0AASVw
 yhQYsIF+ohH+yjETFQ4gklWdHF
X-Google-Smtp-Source: AGHT+IERVc3C2yNd3DcAeDNZ7zbSciuCigfwYIc8ze9WnpdAZv9l9FsjkHi9L+VcMIyxbope5cQePA==
X-Received: by 2002:a05:600c:34ce:b0:45c:4470:271c with SMTP id
 5b1f17b1804b1-46e711408b5mr109040775e9.18.1759824978832; 
 Tue, 07 Oct 2025 01:16:18 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e61a029a0sm289392805e9.13.2025.10.07.01.16.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Oct 2025 01:16:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Weiwei Li <liwei1518@gmail.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-s390x@nongnu.org,
 Song Gao <gaosong@loongson.cn>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, kvm@vger.kernel.org,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Huacai Chen <chenhuacai@kernel.org>,
 qemu-riscv@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 0/3] accel/kvm: Cleanups around kvm_arch_put_registers()
Date: Tue,  7 Oct 2025 10:16:13 +0200
Message-ID: <20251007081616.68442-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Extracted from a bigger series aiming to make accelerator
synchronization of vcpu state slightly clearer. Here KVM
patches around kvm_arch_put_registers():
- Move KVM_PUT_[RESET|RUNTIME|FULL]_STATE to an enum
- Factor common code out of kvm_cpu_synchronize_post_*()

Philippe Mathieu-Daudé (3):
  accel/kvm: Do not expect more then KVM_PUT_FULL_STATE
  accel/kvm: Introduce KvmPutState enum
  accel/kvm: Factor kvm_cpu_synchronize_put() out

 include/system/kvm.h       | 16 +++++++------
 accel/kvm/kvm-all.c        | 47 +++++++++++++++-----------------------
 target/i386/kvm/kvm.c      |  6 ++---
 target/loongarch/kvm/kvm.c |  8 +++----
 target/mips/kvm.c          |  6 ++---
 target/ppc/kvm.c           |  2 +-
 target/riscv/kvm/kvm-cpu.c |  2 +-
 target/s390x/kvm/kvm.c     |  2 +-
 8 files changed, 41 insertions(+), 48 deletions(-)

-- 
2.51.0


