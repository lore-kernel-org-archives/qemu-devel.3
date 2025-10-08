Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05A24CCD184
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 04:07:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6LSf-0007Ff-BO; Wed, 08 Oct 2025 00:07:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6LSZ-0007Dk-HX
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 00:07:28 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6LSW-0005qp-RX
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 00:07:27 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-46b303f7469so44805015e9.1
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 21:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759896443; x=1760501243; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FxAtWtmejX8FeMeLelhLJTDbTvi6ib8BE8g2ZB3OGV0=;
 b=viUDSEY0wtTcE7JQg/pmTRdcC7OWhtapT4MBQgDYEp1Ry8XlcF/X3lEFfcbDRMdOei
 1Os+G8+6/1W5e1zqe12mtKOkJfcp5cCHM5SCrcI5Bnd+rpZhMMHKwYlF96snNeRpJ0eq
 mAkvUbC3vT0n5ljON9l7CM1uUIcXDFuCObgvhAehSeGMbW0XdtkLijPMHYb8skFZHfck
 xl4OHnmNjBu4TsrkWqIaoOmktR2daj3+oWc0R9yXdvvc5S4b57X/GaEbawRDcru1g71g
 g+GszYR2dqrlW8vi/yD2nYTvmzSeRqWIpNcDcO4hpkb6zrf8/wtxZ8JuTo6NSpqTsbK0
 p/og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759896443; x=1760501243;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FxAtWtmejX8FeMeLelhLJTDbTvi6ib8BE8g2ZB3OGV0=;
 b=AOIG8d4Q0FxtNVaQ6S9qhbXXdmfoT14eHZ/951t6iXPW4/Y2V73ercTiblq85nYSOH
 LJntnn1FAETPGlgTzduoo1Hr+4YCsvLEjTpeoJ94BLxrpSKSHeAXxq/nCwbcVNOcpyPI
 +zvLAuk0Ab8G1CZ4ZxHiWbiFAT98fZxNpSjEPnPwyShnBZUTernllP08QgCgdXVFtG8t
 11zprWqCZMfr16fGb1SjJyV6pWk7U6R5rMdt7xjxKoHba0wdTbc2AojktpmOPVrU12yW
 BauZgvyaUN7G+lxSW43WiGJO3lyYubIOSeZgEF/DEonBbzd5nOX7FoGRzXciRmR/zfVE
 cwcA==
X-Gm-Message-State: AOJu0YzUDGKofEiXEc+GQhSTWo9MX1XKh81dNCxhTMDLs0R+6HG3g+al
 rWDkUKIgQpw7bR9l0pa8HMYdx14dMoBmZ6l5zLiyLJkDai2926gy3wyn4oeNciUWgXiyBOEbPqU
 0Q0006KJ5PQ==
X-Gm-Gg: ASbGncvFUMQYGUWPWffmO9K1KfxW+tvPctgTJKCIXMrZGzprghxAityu0+pzTtKU1qL
 HYPMBQQM3W4OBMYKaeVneNIGcNQSDiZ+VH3P9CDClwYZ1HVIJLsD8DTFUQ2x8DqYLzlxcuDDWk3
 11udjEFIK0lkCelgNGu5iDd8aIR1Ib5+h9uYp/ZqBkH4xC73LUdm4Pv88REvWrPZSjEWKNNi9bj
 RL7HRsCj+bLAv4jRRHAsheWCeVgoK/9kTVia6pY4akIGULZo00U9deKrSPOJtlyU/OEbU1gHj5P
 nGLKhjIoXriWUX/iRUJh/syjRNnMHyX0pHyXuGlGKKN84dhdM9xPy4Iy9OJjPHmxGgK5i/vLl6u
 UZLlBON/s9OY7wIFKFgW0futrN7WfnE8EGxxv0xKspY5gr8FwoAouqt7qbPP6TbRrm/l2fyKmDr
 q1YH+qGRuLX7eB46Mys+RJKTqZ
X-Google-Smtp-Source: AGHT+IExiobNOfGSPWTb7L2l3odsWU/Eo27joKAv0sBZvTrPNsL9nZk7Rb2MQW0Mia20pwxgoKA8RQ==
X-Received: by 2002:a05:600c:3b1f:b0:46e:42cb:d93f with SMTP id
 5b1f17b1804b1-46fa9a98ef7mr11946895e9.15.1759896442997; 
 Tue, 07 Oct 2025 21:07:22 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fa9d7f91esm18486965e9.20.2025.10.07.21.07.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Oct 2025 21:07:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, kvm@vger.kernel.org,
 Aleksandar Rikalo <arikalo@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-s390x@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Song Gao <gaosong@loongson.cn>, Weiwei Li <liwei1518@gmail.com>,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>, Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v2 1/3] accel/kvm: Do not expect more then KVM_PUT_FULL_STATE
Date: Wed,  8 Oct 2025 06:07:12 +0200
Message-ID: <20251008040715.81513-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008040715.81513-1-philmd@linaro.org>
References: <20251008040715.81513-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

KVM_PUT_FULL_STATE is the highest level defined so far in
"system/kvm.h"; do not check for more.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 target/loongarch/kvm/kvm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index e5ea2dba9da..45292edcb1c 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -397,7 +397,7 @@ static int kvm_loongarch_put_csr(CPUState *cs, int level)
                            &env->CSR_RVACFG);
 
     /* CPUID is constant after poweron, it should be set only once */
-    if (level >= KVM_PUT_FULL_STATE) {
+    if (level == KVM_PUT_FULL_STATE) {
         ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_CPUID),
                            &env->CSR_CPUID);
     }
@@ -801,7 +801,7 @@ int kvm_arch_put_registers(CPUState *cs, int level, Error **errp)
         once = 1;
     }
 
-    if (level >= KVM_PUT_FULL_STATE) {
+    if (level == KVM_PUT_FULL_STATE) {
         /*
          * only KVM_PUT_FULL_STATE is required, kvm kernel will clear
          * guest_addr for KVM_PUT_RESET_STATE
-- 
2.51.0


