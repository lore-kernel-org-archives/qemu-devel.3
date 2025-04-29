Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02AE2C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 14:09:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9ldm-0000iv-S4; Tue, 29 Apr 2025 10:08:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9ldj-0000f1-QY
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 10:08:51 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9ldh-0006HM-Ox
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 10:08:51 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43cf58eea0fso26814245e9.0
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 07:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745935727; x=1746540527; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2TdK0KknkLOYwI+XSWuaAcvX7rG//eSaXjO5J4+I7ro=;
 b=lPpH27jmnDxa6xJSXYh8p1T8Wr9xu+jVXwmjrU0fVqibE7XM6Zcu1/niDd48a0nDDz
 u9dBbR/CB+4ehkPFEhAMTolZsmWZumTrNr/UTc+KDVszL/U12R24TAgrVO0vthhtHqto
 A5Xp3TFbAmSXxrTjJ4Sfrf/+gVVxXUxQMBIZucA8NaqFCgWT2eXpk9ezWli5D1XcWcow
 lzW3KwZLcFJAJ9W0ZwpD15Y5WQIF4sCFE+9c9Loj4F53sRRW90ktpOZa1lQfLqIstVka
 KXQqbGLCjbea5jw0YHimEYQQqZfFOrelA/wCbZBoLCFjw2pm0DBBoUFOCJ1ejuHGM/Me
 aUxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745935727; x=1746540527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2TdK0KknkLOYwI+XSWuaAcvX7rG//eSaXjO5J4+I7ro=;
 b=tyAK5mDiAszKjcC9djNtfVi7lk4SJ2FAMA5ezaATl7VGlsiZm16Ez+NBvsspfR5Z35
 gHZDIaVNpORQp34qR4X5oeDBUiH6/AzlTGLjAveWOd1UqOuBYJJhcZduYp7P0zwIr8Py
 rbteR/LyeUZq689Gf6gpB+PytYW4447+AD6LRXcQxYHBOwVOabICwe5oOqyJY9fXxpjo
 Zw0GHua2uIVWVq62TzAHm6y8uOnXV/1HCJlxTajP9Pvei2BzroSSSB/k8BY5inkJcVHZ
 bM4TmH/3gtfbL7qiAlGZfCRPYPvQOj684+yfzRDuKPumyu8oP6t1HAMljaQxfkSPcaON
 4JKw==
X-Gm-Message-State: AOJu0YxLSEEOi2XVE6nFl6K+2/a4S0jJxk+mwpfOSUP9r+Vow1zHmYlf
 pA3CTq5TFOjARDfRl7DHOSnzeYICF7s82KWQ9mBQWn4ppEuZeN3gqF/CdVWnjtxe73vcz0pP8s9
 Q
X-Gm-Gg: ASbGncutY3KK8VC8XBnBRQwU6qXPUw07orG0N9FOfTx9LqMTxZy+Z6wh4ryn6CF1XL8
 vitRL9NVODhrijkfGBxHkaekGsKxzCf7rl1OyWebSALf9gAfC/XcBuzcJdAUgKnlq9NLeKj78xC
 fl7n/EndzBjJsh54yIZ9Svvmdywm9/y9Raayd6UYaKQaFKhQc5PZvhUsFyYyCPSP7pYXnrieaon
 b3lIFuVd9wdAgPP+mTJmF3WZn5aA49+/H7ES62GL6XFyv2mdmkiRSrxsFOixCiNvXf8An1V8jFE
 soRmnPmYPshVKON91QJG7Js/BTMaX/G/ggAB9gPggWAMS7PRZ4r+eWfbL/sANJPmFqVRri4gra3
 OlIgeujFbXfst5Cm7o6hq
X-Google-Smtp-Source: AGHT+IFWlOuXDLcKoC6qJIRh5j/hcn7Yfp6eX8KlCf+i9kGpCj9E0hPGD/4Ol8IQcBfdMdTOYuCWpg==
X-Received: by 2002:a05:600c:5491:b0:43c:fe15:41e1 with SMTP id
 5b1f17b1804b1-441ac8ce2f9mr24719525e9.4.1745935727158; 
 Tue, 29 Apr 2025 07:08:47 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-440a5311403sm157348955e9.23.2025.04.29.07.08.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 29 Apr 2025 07:08:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 04/19] target/i386/cpu: Remove X86CPU::check_cpuid field
Date: Tue, 29 Apr 2025 16:08:10 +0200
Message-ID: <20250429140825.25964-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250429140825.25964-1-philmd@linaro.org>
References: <20250429140825.25964-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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


