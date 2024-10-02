Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC042CF3196
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 05:53:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svsHB-00065F-TF; Wed, 02 Oct 2024 01:51:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1svsGu-0005bD-26
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 01:51:39 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1svsGk-0004qj-EU
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 01:51:29 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-20bc2970df5so7580005ad.3
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 22:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727848283; x=1728453083; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fkJZSA7C1YMYbj18IbYt88D9rov3Y7Hm1wOOVyfn81Q=;
 b=mA3a8iQiuNMHhDOKt/SaBJcuKRQxbB2RhvOrTLvHF8TEitrx4i/YLMnxBmedYTMRbK
 L4nmzjRGe1eQIVJVTgufw/6a9FkNjGZFpsB6efBN1UsN8s5GheirlxSANNCDJaPna6aw
 mldNiA24GvFhpIEcGBh8nRmnZl3mwkRqkmri2F2fHzzTvklUb3Ez4Xk7u/PrAd+wFaBe
 wNGhJwtACFQcDIZE7ms5ot0fnKMtNuRj9hwPYoRg82afyn2jFqEmzU6K8HIuyQfhzsF6
 pGclQfIcaOjAXcJ5t6WDor3K02ZNDWDjj3XO562Jd4RlBWQ09fStw8BBIU/UD/MpeDEc
 EfwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727848283; x=1728453083;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fkJZSA7C1YMYbj18IbYt88D9rov3Y7Hm1wOOVyfn81Q=;
 b=ekqChcDunEZjhIkWlgug+3RuJpVArPV6g8WlVG6VuhuNxfY60kp9mljyM4IBKUlj9V
 M4fyqoOA+KiQxHVESa/eaWCZDVrRnDaNm3gjvg3Cs8vJSPL2s+/wur96+r9NZgxfi1is
 Bwzg3HXzZj9De2KJnt9uuZTmpgMg2igG/vy3XE7Up5YaJOgCSeIn6DMwrRKPbFYo6FKF
 7kR0RGt8ZEYWrKzkz/xSXwibNwARh16rLrGMDc50qVJNI8Ypk25JenhfaqRflheim+mF
 fb9jqQRXldUKMfkLpnn6Jwn6htPdjw4PfLonYpECIU41ORlF44WU0D6dUYuJuhmg7q0J
 JXXQ==
X-Gm-Message-State: AOJu0YzRl8P5MYGir0Kp4zOSn7Q7dfXo46OO9f0yoCD/wH+Fh5d3qROS
 wE+MHwMdnf3gWV/6BPQ7ih775kxoejfzdps/F+wYbQqr1mmU9vwez6lo/iBg
X-Google-Smtp-Source: AGHT+IFcNznaMI87nAaj3v2HAq0zK9HseUf4Rt4Ar8Y3tZZ6sbr/q4vcANu5Tt+SvwVbHNTPLwsVzA==
X-Received: by 2002:a17:902:e802:b0:205:8bad:171c with SMTP id
 d9443c01a7336-20bc59994b5mr28731105ad.12.1727848283049; 
 Tue, 01 Oct 2024 22:51:23 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20b37e60c76sm78324235ad.269.2024.10.01.22.51.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 22:51:22 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Andrew Jones <ajones@ventanamicro.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v3 08/35] target/riscv/kvm: Fix the group bit setting of AIA
Date: Wed,  2 Oct 2024 15:50:21 +1000
Message-ID: <20241002055048.556083-9-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002055048.556083-1-alistair.francis@wdc.com>
References: <20241002055048.556083-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x629.google.com
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

From: Andrew Jones <ajones@ventanamicro.com>

Just as the hart bit setting of the AIA should be calculated as
ceil(log2(max_hart_id + 1)) the group bit setting should be
calculated as ceil(log2(max_group_id + 1)). The hart bits are
implemented by passing max_hart_id to find_last_bit() and adding
one to the result. Do the same for the group bit setting.

Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20240821075040.498945-2-ajones@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/kvm/kvm-cpu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index f6e3156b8d..341af901c5 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1695,6 +1695,7 @@ void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
     uint64_t max_hart_per_socket = 0;
     uint64_t socket, base_hart, hart_count, socket_imsic_base, imsic_addr;
     uint64_t socket_bits, hart_bits, guest_bits;
+    uint64_t max_group_id;
 
     aia_fd = kvm_create_device(kvm_state, KVM_DEV_TYPE_RISCV_AIA, false);
 
@@ -1742,7 +1743,8 @@ void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
 
 
     if (socket_count > 1) {
-        socket_bits = find_last_bit(&socket_count, BITS_PER_LONG) + 1;
+        max_group_id = socket_count - 1;
+        socket_bits = find_last_bit(&max_group_id, BITS_PER_LONG) + 1;
         ret = kvm_device_access(aia_fd, KVM_DEV_RISCV_AIA_GRP_CONFIG,
                                 KVM_DEV_RISCV_AIA_CONFIG_GROUP_BITS,
                                 &socket_bits, true, NULL);
-- 
2.46.2


