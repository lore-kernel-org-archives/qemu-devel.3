Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34CF4E77184
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 02:00:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOSF5-0006Wm-4v; Thu, 19 Dec 2024 20:55:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tOSF1-0006MK-Bj
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 20:55:47 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tOSEz-0004Vc-NU
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 20:55:46 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-725ea1e19f0so1278708b3a.3
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 17:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734659744; x=1735264544; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q96eOcWLcysQ07uIP/ggdqasxYbE2mH1LAUugO2htPo=;
 b=QQdHEOaL8hLNhn7WhS3o23eBSQyJDmdvHxvC1T+lA8p3f1LgG3XSad+UehOPiKxtoZ
 aAK8wahTdXrYuDXTpoMqDYYRqKFVbdA2609Fy/3TEuqMJ+ycTlpd63FPvoqVyHm4Hm9X
 lRKrVrz5gA7IVXn52Yt2QKSONp548GLNM9fPWJ+mGbb0cGlawMwF3ANVg67D8cQLIIYG
 tWkDGQpUGjx0wUCwv/7uT2VOZdB/Gn7IHoQksPoel6OQWiTM++HwFj/bOacRNtaoNh/5
 D1j7Y0p6ecapc5z9vsUva6WkA+8KaehKvYXfNt8MHJS+PZrF221bGhtv9mAZgM9A+6lM
 1Oqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734659744; x=1735264544;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q96eOcWLcysQ07uIP/ggdqasxYbE2mH1LAUugO2htPo=;
 b=G2q18acLJAc81ZydwYHvuCWUwMMS9EfxCKM+Qh1MX2z0Q6PeN7GRP7wZMfxa2QH2nI
 BB7XIzfsOeuJSghJg+7j4kTSVuyuJZukMaunKgcV0IwgoBzhuEQ6UxA74bojLyBVBevl
 vRS7JPf4cGy5X43KlxHZpbXl41qSv6bJQ3QMk4y8eYiE/KBZGxwS8KiuglYAu+0dLO86
 YbOCQHJqMVILbUZx/owx5IuG5oeh+VkZdOg91axSRGC/BBfmyqy0hfs9yCOHT33r5zQP
 2w/NRlpts6boI1K8bWLOUAceVunlcnb4Hmd2kQRYSyJVVXnzlVj+NFPp2i6mr6NdmGN/
 ekZA==
X-Gm-Message-State: AOJu0Yx1BT0sDOo3qau5gH5GjU8OhDvomJ3BLyrcYIfu87vDMs9HdB1l
 gDgIpZYsuFltOTiaqloeO2hUimNgXJzAOUvSUFzn9wUKOLmYMkl+CcdYF1Mt
X-Gm-Gg: ASbGncuuxwLac4FnL8bbdM7L8spvqFl+Ftw222J0IbnqeAuUNaGI0JxUrsZ9CbKojfK
 WEhv6yszNcpwmAJPd6anJAJHF9rAGN/3jHc0UQK90+25lvRQPTCyfOiRQPQXowMsT8yrAVghnP3
 j5dO1t5sJLNicM0S7wmm67QLNj+dqOgBO2Koh2as99J4g3CbOifcJE/rG2y1Woeu0+GLq98G71S
 fk/DeDXYpvWo/IP6wXCwZGNWCA8ABmtoLwlvEDSn2RHkn27tuL1C8EQ2+zjJybiy+207z9g7LqM
 e/nKLxRlbRZIGnH/IVEwt22fEWz0eCONBR1DSbHbMhOEn5XEWmxQ1VLWjDeJcNA=
X-Google-Smtp-Source: AGHT+IHaTSFzObOyQUJfpS6mBy03Q1HZ4Kps/fwsdvfCpts7BB8jArnmjnLM6vy3na5WcMBP3JpkiA==
X-Received: by 2002:a05:6a21:99aa:b0:1e1:cba5:8e1b with SMTP id
 adf61e73a8af0-1e5e048a318mr1921792637.18.1734659743814; 
 Thu, 19 Dec 2024 17:55:43 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8164d3sm2002539b3a.15.2024.12.19.17.55.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 17:55:43 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 17/39] target/riscv/kvm: remove irqchip_split() restriction
Date: Fri, 20 Dec 2024 11:54:17 +1000
Message-ID: <20241220015441.317236-18-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220015441.317236-1-alistair.francis@wdc.com>
References: <20241220015441.317236-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Remove the 'irqchip_split()' restriction in kvm_arch_init() now that
we have support for "-accel kvm,kernel-irqchip=split".

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20241119191706.718860-8-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/kvm/kvm-cpu.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index a9680f2447..aaff4a0f42 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1408,11 +1408,6 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
 
 int kvm_arch_irqchip_create(KVMState *s)
 {
-    if (kvm_kernel_irqchip_split()) {
-        error_report("-machine kernel_irqchip=split is not supported on RISC-V.");
-        exit(1);
-    }
-
     /*
      * We can create the VAIA using the newer device control API.
      */
-- 
2.47.1


