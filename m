Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFF56F417EF
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 14:53:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzbwd-0003qt-Nx; Mon, 09 Mar 2026 10:50:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzbwC-0003MP-8T
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:50:28 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzbw9-0005eA-Gp
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:50:27 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-48538c5956bso13409485e9.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 07:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773067822; x=1773672622; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NngTNdq24X5y9HO0NgvOvHi/Olf87roj8zALJBcI8aU=;
 b=ykfitZHbEjbRScGaxyk9t84VJR4hPepcFCOXkfN2dsr4995i5J4LF/DKowy7uzGbTf
 9s3Zhll/xlRTb/uTj+yclt1W9SkEGlSQr5to9cst6+lXWyXR8SqrDb9L7qYpjV70xz6p
 gXOJUAtfcjc6msdzrBhicPpgRiFAt9NRSgLihTi88CQKsOF18KolqCd5BZ4eoBDaVC2m
 of+foCsral1TKCdkEkcswBPkfyiGUtVAvjxMMlQdA9P5nLqIt3LOfcWp5QnqYIyN3QMU
 kOYi8+W4fM5TDNj7MmYIvFja33iZEdzt3hvXOj+1H16et9dR7znTTsdvguh+fjaAe0g3
 eNhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773067822; x=1773672622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NngTNdq24X5y9HO0NgvOvHi/Olf87roj8zALJBcI8aU=;
 b=UmCWVxrzjxpktud99RTwEbzYC8M0BMs4XGMtDVB8x+RmEXFkP5gVHEID5jZDF8Fq0G
 e8/vpfNYOytgNsbn5ajYH8+FCrpmmI9k+BGY6bRrl46VQnXjSuGCForpBnQRxD76EiW5
 Hwqicj/9IjZS9LrJp8VKYt4p3h9Ckeh5OC0RwIM0o0CGaZbJpDRtyqj+D4Y9QNZQGgoE
 APJIrDAEJ7FTKbk0KL5ACZ1MSlRx7PGEAYEMX74k1Z+1JnSwOYG8Wm+r5j1Lr3wJ+NAU
 5zEJxjgQa944ujq9Rt9+tCKZrntepkqkamHpQ3VQACeZcsipwlDtFwmn4wVA/xPjuc6U
 MaBQ==
X-Gm-Message-State: AOJu0YxbqkW+guGEDAcYuQSms+0N73S5TRZzmKrcr6jHe1chICMNOvj3
 8/J+aektIytyNg+wlO+pcNzHjqswdy37wc/kWHt5BOoQtP4Y0G5fCd4b7PTCTUnJts5KENJuvvj
 Jfly/pSk=
X-Gm-Gg: ATEYQzxlOlX97xg/KwqDJ2kDnZqst3TJfR3UBBv6b1umY3kDq34qUIXkrLaYNeg3j47
 1bnVIJNEG9PIVbYP77NVQAD30X3g3I7AQgGXReGOVUEkxosX3yoP25bQP34L1dP3flSCrdeQhRI
 ew0xQoESDqsfsVdzM+7cCZe/DwZ0vjKAzvg3nVYFM4ogRWHfbpd+dcAjZNprpUW5LL1lC+oFmGW
 ieYO7023N4LgDccasWx8A0l43DN455O3zE+XuApE5GrhJwYxb14WWmM2M1WgHCnmji5qF93kgtC
 QivJB3Pf/zlN1QUGV7KIkOjhIOhvIq/DifYd79R6hEJep1OxN/iaS0SUruAVvy86wlahAJpzEK3
 CMtRFRx7ybI3jum2RXkPXRoojzSq6E6X7y293OKSb7err8p+Az21OZKJVDj7VttxIzca6BOWACH
 rd+Psy2rmAF7zuhd1Gdbt+Z0RsRzHtRtCuUWsyBevfJnf1CuBsED5UNOYSMo8mGxcaC/diX6AJx
 TtHkQ==
X-Received: by 2002:a05:600c:3b9a:b0:485:3c11:de84 with SMTP id
 5b1f17b1804b1-4853c11e970mr48719215e9.14.1773067822191; 
 Mon, 09 Mar 2026 07:50:22 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48540ae5484sm19806785e9.2.2026.03.09.07.50.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Mar 2026 07:50:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Yi Liu <yi.l.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v2 01/10] hw/i386/pc: Remove deprecated pc-q35/pc-i440fx/xenfv
 3.1 machines
Date: Mon,  9 Mar 2026 15:50:03 +0100
Message-ID: <20260309145013.44327-2-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309145013.44327-1-philmd@linaro.org>
References: <20260309145013.44327-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

These machines has been supported for a period of more than 6 years.
According to our versioned machine support policy (see commit
ce80c4fa6ff "docs: document special exception for machine type
deprecation & removal") they can now be removed.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20260307152635.83893-2-philmd@linaro.org>
---
 hw/i386/pc_piix.c | 25 -------------------------
 hw/i386/pc_q35.c  | 14 --------------
 2 files changed, 39 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 29c8e997131..2b94c472446 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -655,19 +655,6 @@ static void pc_i440fx_machine_4_0_options(MachineClass *m)
 
 DEFINE_I440FX_MACHINE(4, 0);
 
-static void pc_i440fx_machine_3_1_options(MachineClass *m)
-{
-    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
-
-    pc_i440fx_machine_4_0_options(m);
-    m->smbus_no_migration_support = true;
-    pcmc->pvh_enabled = false;
-    compat_props_add(m->compat_props, hw_compat_3_1, hw_compat_3_1_len);
-    compat_props_add(m->compat_props, pc_compat_3_1, pc_compat_3_1_len);
-}
-
-DEFINE_I440FX_MACHINE(3, 1);
-
 #ifdef CONFIG_XEN
 static void xenfv_machine_4_2_options(MachineClass *m)
 {
@@ -679,16 +666,4 @@ static void xenfv_machine_4_2_options(MachineClass *m)
 
 DEFINE_PC_MACHINE(xenfv_4_2, "xenfv-4.2", pc_xen_hvm_init,
                   xenfv_machine_4_2_options);
-
-static void xenfv_machine_3_1_options(MachineClass *m)
-{
-    pc_i440fx_machine_3_1_options(m);
-    m->desc = "Xen Fully-virtualized PC";
-    m->alias = "xenfv";
-    m->max_cpus = HVM_MAX_VCPUS;
-    m->default_machine_opts = "accel=xen,suppress-vmdesc=on";
-}
-
-DEFINE_PC_MACHINE(xenfv, "xenfv-3.1", pc_xen_hvm_init,
-                  xenfv_machine_3_1_options);
 #endif
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index f102da8e4a1..52b8064b4d2 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -600,17 +600,3 @@ static void pc_q35_machine_4_0_options(MachineClass *m)
 }
 
 DEFINE_Q35_MACHINE(4, 0);
-
-static void pc_q35_machine_3_1_options(MachineClass *m)
-{
-    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
-
-    pc_q35_machine_4_0_options(m);
-    m->default_kernel_irqchip_split = false;
-    m->smbus_no_migration_support = true;
-    pcmc->pvh_enabled = false;
-    compat_props_add(m->compat_props, hw_compat_3_1, hw_compat_3_1_len);
-    compat_props_add(m->compat_props, pc_compat_3_1, pc_compat_3_1_len);
-}
-
-DEFINE_Q35_MACHINE(3, 1);
-- 
2.53.0


