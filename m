Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29013C3ABC5
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 13:41:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD1Uf-0006w1-3O; Thu, 08 May 2025 09:40:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uD1UN-0006OI-Pd
 for qemu-devel@nongnu.org; Thu, 08 May 2025 09:40:42 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uD1UH-0004Uq-U0
 for qemu-devel@nongnu.org; Thu, 08 May 2025 09:40:39 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-22e033a3a07so11499545ad.0
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 06:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746711631; x=1747316431; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=asjuzn+eAAncdD20eXT1wyN528c12dvw5wk014+4k7o=;
 b=n4+hUlyJXXiVURMDEaXhmuAIeke3CbU/WhW2sNX2vqjWn5djXq1b+c7tuhFuX7a3Jp
 qQpf0PQ390AtQVr/vpAuDeyE/gwAkYWH63Nn6yUXvRFbuZtai6WTgWDsXWkIqWWFmSfv
 7rqVuKKaS3881y6bkfa/hUrntcEe34Bawu/SSuxqbUO7LUeUPcMtQCMWs9tAb8G53/lx
 cCayG3dri6IS+icrP12Af0XK3Exjkk+DAjL7z/hZXBF9/vYGHD2InnZDzxu7DBC5ucwk
 9UmfkdVtS9F2+fHvY0Exbjo/iVumaOwZ2gVuNj1NIw+IHmT0uFpX0g0rBHIPMWU2lJ1z
 TY5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746711631; x=1747316431;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=asjuzn+eAAncdD20eXT1wyN528c12dvw5wk014+4k7o=;
 b=OkXB8+F8oAnX2bbDM/uACR+ORo50C8eiTo0gYPCuciHaCtMOqyJN0haMQYo1Wm1rFM
 yvMhNiBni5AuUUmnx+90mBpFMiDN2aRnLf0Sxw771WrwjfQoFfVGH3fXV61rsKT8Ylf1
 T6B1jbZWNE1CZM5k86bZ1YDcJdgC+E2y0/B1wXGeI90joQSwepaF5A4UA2VSMY1zdKkw
 pYudsz95yyfP8pJC/p5pnMnWPOxU0Xo+1T81OUWb7IJ4Jg4IxFL2C3ja/+cz1FHf2ijC
 JOZDOdYVIcneOSCFVWz1DriQNPqxZAWSLhJzbqPQhpFoX36oj5b+4tV5R1LQNRz9RwJW
 f7Mw==
X-Gm-Message-State: AOJu0YyRhKIjAtJhIas71P9bqxeRFHc/VKQE5SfHsesxUUrlkNtoWrkB
 USSM43UKy7DX0gTbBZwfhgquS2/fdJK5hShnuZQc+xilsNJl7cCEgtG+k/h/ZIB1b17fb2vQ3ZH
 vyIM41A==
X-Gm-Gg: ASbGncvKGSsdO1E7PJM/s9i0/Kd+uSkQcsrH6gTen38qH1JyAK1d/RU+yQq3n5YRVzf
 ueCcaf5mzoWb6Yzg8Ml5zNSIkeF9gEDAK2MZCqM5dg5B5CcgveX+jJgXgCRt/96o5SlifzeomWj
 5nbFwzA8k3jWuO5gdaoIZHoI9bCWqaUlVeo/IOnUManQWtUK8qOtWlK3RCyyrfJkgYHEMTLv9h7
 ODriRmaJHHqLXSl/AJsr6c5c8TQ9tdnWv1NS6/Zg4K02ZO1rwgbx2IYRE7CIrZEKZMNjHJcTfnE
 zuQ5ymhl7qrwLZbGb3NgeV/N+d92scnntiMurQv7aHyvxuxO2WQJ4LOgfLj+ADiaU1++uVyG2GL
 crP2+elDDTkAlXV4=
X-Google-Smtp-Source: AGHT+IFMVBzAtV2goIk7zmm4G8sdtx//nL3Zm5hupcOT55Ln+9PVf+fcRnFH7jUrGz21grhEs6MpwA==
X-Received: by 2002:a17:903:3bc6:b0:223:4d7e:e52c with SMTP id
 d9443c01a7336-22e5ea1d4b2mr110687105ad.5.1746711631350; 
 Thu, 08 May 2025 06:40:31 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fbd4474c1sm3299195ad.112.2025.05.08.06.40.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 08 May 2025 06:40:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org,
 Sergio Lopez <slp@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yi Liu <yi.l.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-riscv@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, Amit Shah <amit@kernel.org>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 Helge Deller <deller@gmx.de>, Palmer Dabbelt <palmer@dabbelt.com>,
 Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Jason Wang <jasowang@redhat.com>
Subject: [PATCH v4 12/27] target/i386/cpu: Remove
 CPUX86State::enable_cpuid_0xb field
Date: Thu,  8 May 2025 15:35:35 +0200
Message-ID: <20250508133550.81391-13-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250508133550.81391-1-philmd@linaro.org>
References: <20250508133550.81391-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x62d.google.com
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

The CPUX86State::enable_cpuid_0xb boolean was only disabled
for the pc-q35-2.6 and pc-i440fx-2.6 machines, which got
removed. Being now always %true, we can remove it and simplify
cpu_x86_cpuid().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/cpu.h | 3 ---
 target/i386/cpu.c | 6 ------
 2 files changed, 9 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 0db70a70439..06817a31cf9 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2241,9 +2241,6 @@ struct ArchCPU {
      */
     bool legacy_multi_node;
 
-    /* Compatibility bits for old machine types: */
-    bool enable_cpuid_0xb;
-
     /* Enable auto level-increase for all CPUID leaves */
     bool full_cpuid_auto_level;
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 49179f35812..6fe37f71b1e 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6982,11 +6982,6 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         break;
     case 0xB:
         /* Extended Topology Enumeration Leaf */
-        if (!cpu->enable_cpuid_0xb) {
-                *eax = *ebx = *ecx = *edx = 0;
-                break;
-        }
-
         *ecx = count & 0xff;
         *edx = cpu->apic_id;
 
@@ -8828,7 +8823,6 @@ static const Property x86_cpu_properties[] = {
     DEFINE_PROP_UINT64("ucode-rev", X86CPU, ucode_rev, 0),
     DEFINE_PROP_BOOL("full-cpuid-auto-level", X86CPU, full_cpuid_auto_level, true),
     DEFINE_PROP_STRING("hv-vendor-id", X86CPU, hyperv_vendor),
-    DEFINE_PROP_BOOL("cpuid-0xb", X86CPU, enable_cpuid_0xb, true),
     DEFINE_PROP_BOOL("x-vendor-cpuid-only", X86CPU, vendor_cpuid_only, true),
     DEFINE_PROP_BOOL("x-amd-topoext-features-only", X86CPU, amd_topoext_features_only, true),
     DEFINE_PROP_BOOL("lmce", X86CPU, enable_lmce, false),
-- 
2.47.1


