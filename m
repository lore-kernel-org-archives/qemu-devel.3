Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8CE4C54E71
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 08:55:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnafR-0004tO-Kv; Fri, 22 Mar 2024 04:54:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rnafP-0004hu-Bb
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 04:54:23 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rnafN-00012j-RM
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 04:54:23 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1e04ac200a6so13924285ad.1
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 01:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711097660; x=1711702460; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ljw0MvRJZooGVgJY7PB96wXwwjw3QI+ulH/dM68Nsmw=;
 b=AxEjTgd2DLrq2uW00bdkmDXrMegA1fn3eSm7X+BBF/3m26ZqYyY01vTacP4locq7/H
 ABddoiJwhgQ2rdc/jeyce/epS+0ScYZMGDZ/MuWWIGTshFIGrESHmaW/6XJqtSvMHTjb
 gUm5SVlznctlbCo8ZztookH0hjgIswHn+puCO3zC9BousTMG4M1qz4Dx48ty1xDen9Cf
 gIn6yZMIzsKnHsAOXCcVO6it1VVBpK8prlTlKJKr0+w0Mac5WVQRavJTcobXYAcHe63W
 p6SjFUV9aOvm7PkYOjqIYit4Yd41fNlaYOQub4VU2jY6MqCMsduhU9vFYv64CD66CXPj
 5q5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711097660; x=1711702460;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ljw0MvRJZooGVgJY7PB96wXwwjw3QI+ulH/dM68Nsmw=;
 b=jTUtEzVgIfbBsfgc5uz/AE3Xfe62ljfHHsVAdTRpvEyLr9ZgT1SZJYI7WES4u/8l01
 1E8lCN4jchitmBFjmclMY9gC3hBHimpudnm8gPQQ2ayR2mEENtjmoamFw3xYeyJSJv9m
 HV5mEKu/elYWgncNgrLOvHTShh3QbDxbHL4yKl6zQaHJaSszsxUgmJpkpyQQg/xmVtBY
 B8rqFnhCUqu/RugewxAP6JZQ7DqOGrzbVCExZUtd1ThMNYMPdAUp6qKAmlplbNqJFzi1
 BnfZNhBabLSKhIClNvyxF24CqdYzYG/yw+8Jw8ZgGMLb1bJk85HI0EGJi+o5cow7sIeE
 LgaQ==
X-Gm-Message-State: AOJu0Yx+Yd/wLnvNe/SG996ZMhCqS9fcmBKmreLHmXC9ij3EPnPqv7TT
 lCynbl+TXMrvm1dbIQAHz1ZL0x4Ejo6wF8kA+86A46tqZ4c7nmD6bSkb5Gi3TC0LPA==
X-Google-Smtp-Source: AGHT+IHKYCEZLbiYG243f/RtVaRve+3mp80pY5awYn/fFu1TYObDXv4119eyxLh50rGuZoLXWJVbUg==
X-Received: by 2002:a17:902:6808:b0:1e0:8b17:58b5 with SMTP id
 h8-20020a170902680800b001e08b1758b5mr1726224plk.13.1711097660268; 
 Fri, 22 Mar 2024 01:54:20 -0700 (PDT)
Received: from toolbox.wdc.com ([129.253.180.114])
 by smtp.gmail.com with ESMTPSA id
 h5-20020a170902680500b001ddde07af12sm1369048plk.143.2024.03.22.01.54.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Mar 2024 01:54:19 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Yong-Xuan Wang <yongxuan.wang@sifive.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 15/15] target/riscv/kvm: fix timebase-frequency when using KVM
 acceleration
Date: Fri, 22 Mar 2024 18:53:19 +1000
Message-ID: <20240322085319.1758843-16-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240322085319.1758843-1-alistair.francis@wdc.com>
References: <20240322085319.1758843-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Yong-Xuan Wang <yongxuan.wang@sifive.com>

The timebase-frequency of guest OS should be the same with host
machine. The timebase-frequency value in DTS should be got from
hypervisor when using KVM acceleration.

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Message-ID: <20240314061510.9800-1-yongxuan.wang@sifive.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/kvm/kvm_riscv.h | 1 +
 hw/riscv/virt.c              | 2 ++
 target/riscv/kvm/kvm-cpu.c   | 9 +++++++++
 3 files changed, 12 insertions(+)

diff --git a/target/riscv/kvm/kvm_riscv.h b/target/riscv/kvm/kvm_riscv.h
index 4bd98fddc7..5851898868 100644
--- a/target/riscv/kvm/kvm_riscv.h
+++ b/target/riscv/kvm/kvm_riscv.h
@@ -28,5 +28,6 @@ void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
 void riscv_kvm_aplic_request(void *opaque, int irq, int level);
 int kvm_riscv_sync_mpstate_to_kvm(RISCVCPU *cpu, int state);
 void riscv_kvm_cpu_finalize_features(RISCVCPU *cpu, Error **errp);
+uint64_t kvm_riscv_get_timebase_frequency(CPUState *cs);
 
 #endif
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 72a55b8af1..d171e74f7b 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -711,6 +711,8 @@ static void create_fdt_sockets(RISCVVirtState *s, const MemMapEntry *memmap,
 
     qemu_fdt_add_subnode(ms->fdt, "/cpus");
     qemu_fdt_setprop_cell(ms->fdt, "/cpus", "timebase-frequency",
+                          kvm_enabled() ?
+                          kvm_riscv_get_timebase_frequency(first_cpu) :
                           RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ);
     qemu_fdt_setprop_cell(ms->fdt, "/cpus", "#size-cells", 0x0);
     qemu_fdt_setprop_cell(ms->fdt, "/cpus", "#address-cells", 0x1);
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index cda7d78a77..6a6c6cae80 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -739,6 +739,15 @@ static void kvm_riscv_put_regs_timer(CPUState *cs)
     env->kvm_timer_dirty = false;
 }
 
+uint64_t kvm_riscv_get_timebase_frequency(CPUState *cs)
+{
+    uint64_t reg;
+
+    KVM_RISCV_GET_TIMER(cs, frequency, reg);
+
+    return reg;
+}
+
 static int kvm_riscv_get_regs_vector(CPUState *cs)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
-- 
2.44.0


