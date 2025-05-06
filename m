Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1B0AC3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 14:42:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJVC-0001RQ-51; Tue, 06 May 2025 10:42:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJSI-0006rB-C7
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:39:34 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJSE-0001PJ-GC
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:39:33 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-441d1ed82dbso5982555e9.0
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 07:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746542367; x=1747147167; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2TdK0KknkLOYwI+XSWuaAcvX7rG//eSaXjO5J4+I7ro=;
 b=SxFyPsX5XyDtGBCPQaSr3SAMSF2n7DdAy6t/hSwzJCbQtBMmxgkzYpvOMKhhppKvbv
 sjyCiNrF4IxrjopiGxpzHujPt8MwF2C1X/hZJe4vFBPxKmwIyu8U/mzxGJEiPvp8yeo4
 e4xhcQI0bDqDdz+JadAZvNWmecNkSb0/o1f6vKhBQBmXSRzy5mlLPhB6MBrNsar0FErh
 vdeF52FP4yzLU/6WiQLZ6EYt0gVlK1FUtjzWRLQkczC9L1J/glBQwRBtXH2fcbLRBzWd
 HXgEHHUPGwkyhUU5FwHxDiiA0DpeCm3UDHlev6z0hQkebPptw3c2BdP3fPhaMTuUZmFJ
 scZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746542367; x=1747147167;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2TdK0KknkLOYwI+XSWuaAcvX7rG//eSaXjO5J4+I7ro=;
 b=sITGnr1C57KPYg9+wex3MobXNQcBoIEwlV6A+3TUkJrmcs5IRLrGfS4Kyi1GAkKLAn
 AgZArUHXo2OO1hj3PxpFv+rnQg0s/rd5wLpEQh0YjaeQtfOVObT/9MnKlZ7q0PAfNXL1
 rm3lBAvI2/TZI2bHJBqedNr5hC9Q2OaDXZKx4T1TweSNTaEiAowCZNKJwnfGGOZUzCxF
 9qZTgGosfa02szStpSq1LkVFfDmxll3fz6GDDuNrtBjXxnrWNgzw0ypWcTOkjFsi3/I7
 tcWdHrgJzLVwfJrLgGaaGWSHt32ncrPOjE5MK3t/oJ0Qa8mMerUPYKUQ4JJXPQNFxc2R
 yXeg==
X-Gm-Message-State: AOJu0YywYrLTgoWDhT3DHNv3DMIpNG0scMLOHDkcnBLAWm7FO/Wmxrxk
 k5I4QbmsKJtSh13Mj6dMWn/C3ev6L+fdZzk6c15cMNFFq0mg5pcmu+MR7Vu5N6rTJ6YQJVLUgGf
 d
X-Gm-Gg: ASbGnctExzoPnKdSDOUFmFfvDDMFlKNHRBwtp4DcQPDm+34qbEdXz7D5ZLH8Yj0OQ5a
 Dqbt2wMfvwZhzdYooYn2/nH+9pjMLjpS7an9F6lxSuBJwBtFk6ag461/YLrwCqkxppyVZb9yEsX
 emO36lVPI5rM8TlP8yqPF34/UZxor9IicVLaMtIwlofBAu++We+i1Sr9hB2lj3Oc18vZpSXwwWk
 bvoAbvz7vQENuLIT1bQT6cHpsXMr0wPD4AALr9qAiMiTIjqZTo6mzZsHFvAK8iiG9Mf2ILZxPx3
 Q9bKSlJ35tjZ5KYbjlQXNZc/Zi6OjCJfXDZD6rsTlLfMZjTrKbthGyQOVTnYWxHKj5iV4Hj+dug
 HHzSLtnxYpFq66HtFDI6g
X-Google-Smtp-Source: AGHT+IGK4tl6FNfKwSbMfTf4FkQ+0hMvuyfj8DUZkE2MqEgr0lYypj5K7EW7BkJnQ0gq7IJlWnzbGA==
X-Received: by 2002:a05:600c:5297:b0:43d:49eb:9675 with SMTP id
 5b1f17b1804b1-441d100a85cmr27233975e9.22.1746542366860; 
 Tue, 06 May 2025 07:39:26 -0700 (PDT)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b2af2a0csm216546445e9.18.2025.05.06.07.39.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 May 2025 07:39:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Fam Zheng <fam@euphon.net>,
 Hanna Reitz <hreitz@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-block@nongnu.org, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, John Snow <jsnow@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 04/19] target/i386/cpu: Remove X86CPU::check_cpuid field
Date: Tue,  6 May 2025 16:38:50 +0200
Message-ID: <20250506143905.4961-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250506143905.4961-1-philmd@linaro.org>
References: <20250506143905.4961-1-philmd@linaro.org>
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

The X86CPU::check_cpuid boolean was only set in the
pc_compat_2_4[] array, via the 'check=off' property.
We removed all machines using that array, lets remove
that CPU property and simplify x86_cpu_realizefn().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 target/i386/cpu.h | 1 -
 target/i386/cpu.c | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 54bf9639f19..3a5e17e0741 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2168,7 +2168,6 @@ struct ArchCPU {
     uint8_t hyperv_ver_id_sb;
     uint32_t hyperv_ver_id_sn;
 
-    bool check_cpuid;
     bool enforce_cpuid;
     /*
      * Force features to be enabled even if the host doesn't support them.
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 6f21d5ed222..49179f35812 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8169,7 +8169,7 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
         }
     }
 
-    if (x86_cpu_filter_features(cpu, cpu->check_cpuid || cpu->enforce_cpuid)) {
+    if (x86_cpu_filter_features(cpu, cpu->enforce_cpuid)) {
         if (cpu->enforce_cpuid) {
             error_setg(&local_err,
                        accel_uses_host_cpuid() ?
@@ -8808,7 +8808,6 @@ static const Property x86_cpu_properties[] = {
     DEFINE_PROP_UINT8("hv-version-id-sbranch", X86CPU, hyperv_ver_id_sb, 0),
     DEFINE_PROP_UINT32("hv-version-id-snumber", X86CPU, hyperv_ver_id_sn, 0),
 
-    DEFINE_PROP_BOOL("check", X86CPU, check_cpuid, true),
     DEFINE_PROP_BOOL("enforce", X86CPU, enforce_cpuid, false),
     DEFINE_PROP_BOOL("x-force-features", X86CPU, force_features, false),
     DEFINE_PROP_BOOL("kvm", X86CPU, expose_kvm, true),
-- 
2.47.1


