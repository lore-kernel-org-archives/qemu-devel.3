Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D60A6EE6442
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 05:32:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1socPZ-0000xk-Px; Thu, 12 Sep 2024 01:30:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1socPU-0000hk-72
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 01:30:28 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1socPS-000300-JZ
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 01:30:27 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-7db1f13b14aso547643a12.1
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 22:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726119025; x=1726723825; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WQnac83Zqcp2GhG5unJHuaV5QZRaiVQQMbeeoAzBig4=;
 b=DBK8EvsGJnADp79LD5dc9lZrc+krUqJFgVx+AtdCjQJztC3VccJ9hqmGKJAkQjELIX
 S42jJV3s9ipyxcvkz3ZtEaxE4LeJ6sh39M6Jec+b3xSKCXwQxM4Kv441488Hulm6s1rM
 ZGUopzwV3jYGAedgG1YveucLz9vAwy3p065zdURbOfTsqdv1Fs8UIweKjI6KaWVXCn+L
 iZXY0n/xAakFesKZCuj56egCot1N73kn7BvYShCw1oauxs7/azlWfSywfe3+iK8mtLyS
 ZvDiowRtVPKIajytVDQUi8iFdzIJomNwnNXu4SBjz+EnTajixlbUUpA03NBTZvkNDKpf
 I3yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726119025; x=1726723825;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WQnac83Zqcp2GhG5unJHuaV5QZRaiVQQMbeeoAzBig4=;
 b=L/nKHWreqFWkRof9E4C1mE5Ml56cOqie+k/ZWqBc5V7R8qv8hYi6HKukbkqyhbTNQb
 x3lSi3Ud7bjHrDd/B1uiOZqFHQiFMCwMTL422w2ZqAPE8ci3weHO7K1U0O1aVwCqs8DR
 /7tgzmSzBL2veTrO7f3tmJ/8NZChmW7xHJ9+qJWYq0x+MFO3Xa8Nak8BEtPvev/DMbrP
 clwzzPVVJaVUYGo4Cnys+8Nz4Q+7/prNkobfQFt5owei9bNLUSN/apaj4OV5VPhoWwmn
 8I7ahPaPnaKcZW9TZWLmAC4gKokyLF13r8z1Cm0Dcf7S+mpCvrT98nUXlumGkIbP72r7
 47Fg==
X-Gm-Message-State: AOJu0Ywh3D/hmu1muHGaCQ+B9X+UBk4A2w5xdt9w1bzw5RvQ5bV4unj6
 sUsImMgxGdpZcqOjJsUKclnD8o/sPMgJ+I/1WulQ22yprRuhBXg8X8bu+w==
X-Google-Smtp-Source: AGHT+IGF4P8QUwHTPeY1tI2ZnWRstojX2l8j2ecq3mx/qDIU07LFjioXOdjTgKVh1dFjKtBVj8boxA==
X-Received: by 2002:a05:6a21:4581:b0:1cf:4458:8b27 with SMTP id
 adf61e73a8af0-1cf764afde6mr2387755637.46.1726119024894; 
 Wed, 11 Sep 2024 22:30:24 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fc8fdesm3833034b3a.1.2024.09.11.22.30.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 22:30:24 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Andrew Jones <ajones@ventanamicro.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 08/47] target/riscv/kvm: Fix the group bit setting of AIA
Date: Thu, 12 Sep 2024 15:29:13 +1000
Message-ID: <20240912052953.2552501-9-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240912052953.2552501-1-alistair.francis@wdc.com>
References: <20240912052953.2552501-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52c.google.com
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
2.46.0


