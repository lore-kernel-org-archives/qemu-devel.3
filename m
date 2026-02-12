Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F785EE3692
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 14:44:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqXvF-0005id-HG; Thu, 12 Feb 2026 09:44:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqXum-0005Kq-Bx
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:43:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqXuB-0005jk-PW
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:43:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770907375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y1qB8f5S1a8OY4JKauR7kdT3uCW8tDUiJfDSKAlMRVI=;
 b=fdPZYgQuCAqxigHl27RjTFZo1zj3yF44MPqlQhVI6W9vltKW9nQpq/WtTbUbCYi8XjZoaz
 SnNBDf63hVggKtxOSkrqKs9YlPUVbNsXinNliC4oUwxXFO5un+Yb4A0HqY4724qmvLskZs
 uPf80rMwSz+iu2bBcHc+GIRDqZHyhmA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-Rgk8NUe_PduiaBuFc5Ymqg-1; Thu, 12 Feb 2026 09:42:51 -0500
X-MC-Unique: Rgk8NUe_PduiaBuFc5Ymqg-1
X-Mimecast-MFC-AGG-ID: Rgk8NUe_PduiaBuFc5Ymqg_1770907370
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-480711d09f1so43103875e9.0
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 06:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770907370; x=1771512170; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y1qB8f5S1a8OY4JKauR7kdT3uCW8tDUiJfDSKAlMRVI=;
 b=uNcgOeRlCSzne7ga2b7JVLiUnTZtLew3PcYYHsyzOL8HIBZBVOLR52Wo7ivnp0tvv6
 ogYkgSVvZQV4W4mqOWFkGV44087NW7zUM0D0ae+UBNshB861U6oof9BqmZGf8hRrxxiq
 FR+oJ8O3rGf7GYCaMYScfPhLC3KQYWzWrChWX5a4aEp9/+1a3n1cyRXj/9y/x3m0SzV5
 BSPD8GGQEIKvB/VEHtPhnXSH1gHmjHiUSRPGA2NeC30ILpUlSLEgeUNe4mcNou4EGa6E
 cnb8OpmQB4Pj9U9xXARkOp8y0wfBHzYcz/d0v4lB9zDhxIgQ7MZxm3aKOnNBQcdQpd3n
 eQ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770907370; x=1771512170;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Y1qB8f5S1a8OY4JKauR7kdT3uCW8tDUiJfDSKAlMRVI=;
 b=ShMMD3b3O8q9/mqpZACUIJqE9w4SPnp48nMX5sKQgDlLOteP2LaaKLnlRfZ9XB/Jzd
 38b9La0sfNbONuOpignvh5xngOg/6F/u8RB1tA9xtH7O16I35ApoP0a6lpGHL6Kd0v8o
 C8/R0XFNcpq3hjAZSW4G9gUc4349Q3ccNDsVXLg8LWRLPSUzehntH/aqBc7TMVtUoN1h
 UMef8sJyBs2NvZzSfyifWAPCtrk/HZwujGxVDO97YZnLyzEwUvO1fxH8o8jSGYVinSAo
 wpngrN+3X1jkFIkutRYsxjV6QA31mGeSYciioTTmZjO3e+ZJnLiuRwVdvgEbmijYU4+4
 y7qA==
X-Gm-Message-State: AOJu0Yy6khFGA+p17m5WTAKG2/ZI73c9qTBQzlnX3mrb5S0xzOekgJMO
 dfjFAVl+xM7u6ZkkDEpYVmW92t35bvOApOap/zHhUqoCOroVuPlgr2ca+Mw0eaYQhjqcQEgKOUl
 WgvMgyXlRasAI6rn8cbspYskM7/THjVxvmkOnfFU/S33wrZjHKnTg/BOmZ2vxZRCbsCOWt8O6q0
 lIUsv8yyvlC76ivkk9Vfd+Q5HjP/BBrXWC4QkkxITQ
X-Gm-Gg: AZuq6aJY4wDN8gs/Ymle8/13lphi833FzWNukmC6tXilLj8e/TR+StwxS/JQ/QLrVHb
 RfEY8GF/1dCXGxnQ0kMP9wVFaADIPHcn+Px2C/ix2oqvcNP4O4jBWpv3bRTSOPMsjuzO4+FiIdI
 V4Ni/T07gdW72JuHGBGQSmn4zqoBi+1B9thcJVJK8Ac8MmH2E17HRL9jNx4yI2vh+cK98HaJT1G
 4nNLBwITwxG4Wh4PreF0DFcnJC3DmtKQSx8witn0z4Rx5FeVOsySNvK0OeH6gGhz1G/o86eBGbU
 2uAxMDxlkMVOaz34QFLWKL2DEX+oNu1defZnMRqU6VwZ2Wtn6DLe8U8DwoH7LRJklT7NeAA4HtK
 uBR5u4efBRFmV6saDl4oDezxOWhvgdsDp2Iptu3zpLUxTqkGm/rkF5jmybIDvBRCaDaRuy9Pj9Z
 H1WN9wjOcE7V+AwtryXPFvveUmV3SvOAXwwUa5DnGiV8mSxt4CUh0=
X-Received: by 2002:a05:600c:3b12:b0:477:9814:6882 with SMTP id
 5b1f17b1804b1-483670fac0fmr37888715e9.5.1770907369714; 
 Thu, 12 Feb 2026 06:42:49 -0800 (PST)
X-Received: by 2002:a05:600c:3b12:b0:477:9814:6882 with SMTP id
 5b1f17b1804b1-483670fac0fmr37888045e9.5.1770907369195; 
 Thu, 12 Feb 2026 06:42:49 -0800 (PST)
Received: from [10.60.241.123] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d82a4c4sm353804045e9.10.2026.02.12.06.42.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 06:42:47 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Thomas Huth <thuth@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Igor Mammedov <imammedo@redhat.com>
Subject: [PULL 02/41] hw/i386/pc: Remove deprecated pc-q35-2.6 and
 pc-i440fx-2.6 machines
Date: Thu, 12 Feb 2026 15:42:04 +0100
Message-ID: <20260212144244.22579-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260212144244.22579-1-pbonzini@redhat.com>
References: <20260212144244.22579-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

These machines has been supported for a period of more than 6 years.
According to our versioned machine support policy (see commit
ce80c4fa6ff "docs: document special exception for machine type
deprecation & removal") they can now be removed.

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20260108033051.777361-2-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/pc_piix.c | 14 --------------
 hw/i386/pc_q35.c  | 14 --------------
 2 files changed, 28 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 878db5721b7..9efb42ad055 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -732,20 +732,6 @@ static void pc_i440fx_machine_2_7_options(MachineClass *m)
 
 DEFINE_I440FX_MACHINE(2, 7);
 
-static void pc_i440fx_machine_2_6_options(MachineClass *m)
-{
-    X86MachineClass *x86mc = X86_MACHINE_CLASS(m);
-    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
-
-    pc_i440fx_machine_2_7_options(m);
-    pcmc->legacy_cpu_hotplug = true;
-    x86mc->fwcfg_dma_enabled = false;
-    compat_props_add(m->compat_props, hw_compat_2_6, hw_compat_2_6_len);
-    compat_props_add(m->compat_props, pc_compat_2_6, pc_compat_2_6_len);
-}
-
-DEFINE_I440FX_MACHINE(2, 6);
-
 #ifdef CONFIG_XEN
 static void xenfv_machine_4_2_options(MachineClass *m)
 {
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 6e5a23d718f..6dd1120c004 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -680,17 +680,3 @@ static void pc_q35_machine_2_7_options(MachineClass *m)
 }
 
 DEFINE_Q35_MACHINE(2, 7);
-
-static void pc_q35_machine_2_6_options(MachineClass *m)
-{
-    X86MachineClass *x86mc = X86_MACHINE_CLASS(m);
-    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
-
-    pc_q35_machine_2_7_options(m);
-    pcmc->legacy_cpu_hotplug = true;
-    x86mc->fwcfg_dma_enabled = false;
-    compat_props_add(m->compat_props, hw_compat_2_6, hw_compat_2_6_len);
-    compat_props_add(m->compat_props, pc_compat_2_6, pc_compat_2_6_len);
-}
-
-DEFINE_Q35_MACHINE(2, 6);
-- 
2.52.0


