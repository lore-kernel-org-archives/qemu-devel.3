Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4EF6C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 23:24:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYCjQ-0000QU-8v; Wed, 15 Jan 2025 18:23:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYCjI-0000Ja-Gf
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 18:23:21 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYCjG-0003qM-VL
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 18:23:20 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-38789e5b6a7so203820f8f.1
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 15:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736983397; x=1737588197; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HiK7kWV2YxErB75r1QBmNlphCk6c+f8aCYytVgiOb3Y=;
 b=aP4cuog0Baamh/hg4i/i8jm1SUiLSDpal1AmNASjt8X/A87qx3wyoXGk0T0pjJBb8w
 l/2ATZB9sF/lxbJ4tjE6++RLhoNt3my6fkX98SNvsf9z/nkCSRQhLKLyvyAWKtvNXLhI
 FFozDGAspABnSiIJbiZ30yHVFyfMpQ6TEUpoAaaiW3twJ1xLzvdR//3yxxGqsVDkxcQq
 ZgecDEVkBHMEV2SsndSQBGs3o/E5fKUW5SIOwhu1O4H5aCShgWxuMBCCCGmvF9swYNqn
 2dw7s3Zjh6zrR9Nu1/vr9k3Gz2CPNwqQsHeqBn14jI4hguKeaWONf9VSGmWb7AiOz/aq
 21Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736983397; x=1737588197;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HiK7kWV2YxErB75r1QBmNlphCk6c+f8aCYytVgiOb3Y=;
 b=Lge6mMpyUnr/LsYx90jmCjWa/zVYW8Gbo7yMI9rCo06ynA7Fc5yLjz2rX6VDH9WOwG
 eEoUA/0HCh2ENXqbs6SFp2HX1ybo0ZdCMV9mReM3DZ8OWjBuKR0ibGStUWGYjB0nCn33
 SkwxmhwK/3uD/okzzgx8CRLB2KiaNEJO5Qtfu3ZltdNaH/85CUaEfoudWOFJvT2R/iT0
 SDfR5KUd8Cs0JCZg4p+gQyJcMM9TyZK59/XUmD0YGt3Or8UB6LgsqEwcTGMVrErBmnAk
 nc3MsRF7R/0dtUA2wcukdcP8Ctw74iPBVMfydaWuePz46/mxIa0avY/qPIC8PBCHWVVx
 Hn3Q==
X-Gm-Message-State: AOJu0YwoWspAUZY9Wywq8qZvuwlSHBAPQ6pWCOdMMrMALW19TxV27uvv
 kEWvVGqtQMit9pC3TMZjcAVUNZSO2rBFmZApWt8bLQZHv6V/EH+rQS81pZjyMLGSnl9QdhhmauR
 Q1Gk=
X-Gm-Gg: ASbGnctu+SOOPza96ZNf27x2kte3rm98VogS1sA6eDPG2XcjoGifHE0q4INJ+Vd/YZZ
 EuPmHCQBGEyYkqAt8n9XxlvByKQBnpNwYjcWz768pBGTGF0CyZsvFtDpx4eqTR4E2Uk+1o5niAO
 0wOLxwWay7CgzZqgL92yclVU6e/etYCYep7eBU2KrJx+hp2x1S7+uPqal+DsD5Bf/7bil5dGhOK
 nFRTVuWx0DSmfVV9f6Pe8va8vsQCoNlvAhK2OfETCussMaAs624x+YNGIEAgzPfTfaQFhMAL2u9
 mzNJX8XGsgKzJ22qVragu2pbeB1fdWk=
X-Google-Smtp-Source: AGHT+IF4aPTTANd00MhfnjjKHU9Z7l1eY0wyhqkRLgoKYUUb7vQyLWliC9eqwzg19q6RydsD/c5r0w==
X-Received: by 2002:a5d:5c0c:0:b0:385:fc00:f5d4 with SMTP id
 ffacd0b85a97d-38a8730acf1mr25197093f8f.29.1736983396953; 
 Wed, 15 Jan 2025 15:23:16 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4c1b44sm19019124f8f.90.2025.01.15.15.23.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Jan 2025 15:23:16 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 05/21] target/i386/cpu: Remove X86CPU::check_cpuid field
Date: Thu, 16 Jan 2025 00:22:31 +0100
Message-ID: <20250115232247.30364-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250115232247.30364-1-philmd@linaro.org>
References: <20250115232247.30364-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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
---
 target/i386/cpu.h | 1 -
 target/i386/cpu.c | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index dbd8f1ffc79..87917b7f895 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2091,7 +2091,6 @@ struct ArchCPU {
     uint8_t hyperv_ver_id_sb;
     uint32_t hyperv_ver_id_sn;
 
-    bool check_cpuid;
     bool enforce_cpuid;
     /*
      * Force features to be enabled even if the host doesn't support them.
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 0b639848cd6..42227643126 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7822,7 +7822,7 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
         }
     }
 
-    if (x86_cpu_filter_features(cpu, cpu->check_cpuid || cpu->enforce_cpuid)) {
+    if (x86_cpu_filter_features(cpu, cpu->enforce_cpuid)) {
         if (cpu->enforce_cpuid) {
             error_setg(&local_err,
                        accel_uses_host_cpuid() ?
@@ -8491,7 +8491,6 @@ static const Property x86_cpu_properties[] = {
     DEFINE_PROP_UINT8("hv-version-id-sbranch", X86CPU, hyperv_ver_id_sb, 0),
     DEFINE_PROP_UINT32("hv-version-id-snumber", X86CPU, hyperv_ver_id_sn, 0),
 
-    DEFINE_PROP_BOOL("check", X86CPU, check_cpuid, true),
     DEFINE_PROP_BOOL("enforce", X86CPU, enforce_cpuid, false),
     DEFINE_PROP_BOOL("x-force-features", X86CPU, force_features, false),
     DEFINE_PROP_BOOL("kvm", X86CPU, expose_kvm, true),
-- 
2.47.1


