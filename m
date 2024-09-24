Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B933ECF9C69
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 22:18:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stDrZ-00045a-I7; Tue, 24 Sep 2024 18:18:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1stDrY-000413-B4
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 18:18:28 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1stDrW-0001dA-R7
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 18:18:28 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-71b0722f221so577449b3a.3
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2024 15:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727216305; x=1727821105; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FcflzJeXCzeW0THHScuUblBqGSayWPSVoBUuI18HYPA=;
 b=ISyc6PwHqr8fD8+WrJAitCWtrIWYOzPbvglIkv9tofss1AB6Nmg7wW0UVG/7zcSPbS
 tQhRIxk53TP5gzdpWpBNFC2ZrhxWUUlUvdjC0gFQKuGRenIlz6R4sGk/WC+kqZTDc5bD
 2JUXAsl61/OMv+/2Q9MdDKTRVQrY83VgnbV3i/2UU0cTkA8feqeNMfNSTIOmW+BPYrWG
 sUUFWQPIWKMteW2j/NJJmMrONjwSq8wFE3akyEvDn+aHRyDWuR3TBOR9fjJKbAvlJDId
 vdtVXnsCwr0khwHNV11OR0NPFpdZcR40UJLJ0kWW8RyNnI5qX7GFKGP1RvAIFNhLBqAv
 6zUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727216305; x=1727821105;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FcflzJeXCzeW0THHScuUblBqGSayWPSVoBUuI18HYPA=;
 b=jVDf5ThjCO1eK6Kp/M+Y8p2Jb93aVa4OkDwWeUaqmUNvfVDYFia8z+hoo03vQRtInv
 F0gYUbMWnG94FkVghjOfYF/pOWRiX4rhtMwLkaVS9BTs1X8LCnYwyozKA+6ANz5GSymy
 3ua45bpcaU/acxAJE7xuej12NYH2Sup/a6myrXl7W9IyPXW223vm5iybA6o2nl7AUNln
 gdugu7oojVtmxS1V/HgWLdjapCPHr704iKpiXRsN0j0eu3A/7Yp0bOTzQmX6LnHvenCW
 f0IiBy/XtzmkJ9gFYCa7btwpjvFIA5MWfpapjy5VA/VoUr9i6GPYAoR8WQqEivXf9BOx
 nEmg==
X-Gm-Message-State: AOJu0Yw7Vp3GyG+BlsrQ8AKlSpo9MXd9HwhDx+d0bSVjGDeMRgOFf3bc
 c8hH9JLyGpSQLjoti01+GzVmIkxutWrTGFryNlksqOxykVIIWeGc2yJZOw==
X-Google-Smtp-Source: AGHT+IFpZo+5g4pXjdIkc5B+brBHgrAYkGbr8h2WafH0NRfhe/IuokyeQHLS/cXfnsHaP/ASpyeISw==
X-Received: by 2002:a05:6a00:4b05:b0:706:61d5:2792 with SMTP id
 d2e1a72fcca58-71b0aaade4bmr1083258b3a.8.1727216305180; 
 Tue, 24 Sep 2024 15:18:25 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71afc8342easm1665310b3a.11.2024.09.24.15.18.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2024 15:18:24 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Andrew Jones <ajones@ventanamicro.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 08/47] target/riscv/kvm: Fix the group bit setting of AIA
Date: Wed, 25 Sep 2024 08:17:09 +1000
Message-ID: <20240924221751.2688389-9-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240924221751.2688389-1-alistair.francis@wdc.com>
References: <20240924221751.2688389-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42f.google.com
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
2.46.1


