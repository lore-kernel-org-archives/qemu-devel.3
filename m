Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24A45C3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 14:49:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJXE-0002EX-9j; Tue, 06 May 2025 10:44:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCJVK-0001sc-BJ
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:42:43 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCJVI-00029E-54
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:42:42 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43ce71582e9so38495585e9.1
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 07:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746542558; x=1747147358; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aiQ7ZcnC+QYDI7GaGe0RXvbyxeI4m0Rk5zu7vlP04q8=;
 b=BzgCblwwFdTKb8zasqRrcM65zPAqX++X8ILW8O57r8VfLP5rNJGKds0dU6yb8kFqN/
 Ncge00MPJak6q3lHw7NDHei1kTe0oNz2OYKoNOq/y4SeJCx73XSibz+22MPMo7GvIOy8
 QDZF+a62MQAveLqk7sGo01cfcKAT1JvSCnudEQVBsnSLOopmxIwqwtyqKYRmFUmBvA8m
 Xg/kgq5oYdRUjfNOe+MnJyE+39I/qzQhfDdBLzhFFdEQ1pKacOmTQMGP397adeJtwF2J
 TXXmnvlpXUj2LaVx3uXdpdc0myUeHFjKvQZRyAzpdwm5H1t8Z1mhFQWxUbt1pv8kk3FC
 7lWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746542558; x=1747147358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aiQ7ZcnC+QYDI7GaGe0RXvbyxeI4m0Rk5zu7vlP04q8=;
 b=O4Nsz9k1rp02Z4FoPwrrOo7BHEneQ7Zo1RMapiLzs74kxz5kEiy84ehXP2YGxg8aq6
 Qw1K57Wfc3j2Cf9DdBM6YuUmciN9KN3jtKfIAIRKC7I2z77U0xzDpdphN7qyUvg14l1T
 0oFKBsVM2EGQCDHCguwxRdiqJ13HU3pr8WkTis+M5sf9JPwmNn/t2EetJfZ4+rbZ3ZAV
 MPlSbxYAbVLl7W0UzyiHz+4jdrk07bWDto1a+d3uRxjoDlSYxL5vCIh8kjXMFyRG9A01
 nwIq7HpiNc9qF26YnSsJoAp44LdHszXBLARE7yHyvzTkvsTPuE2QoIw+S/+B2hfdbTkF
 EG2g==
X-Gm-Message-State: AOJu0YwvzL7baH9vRmusXn19Xpu/1ryphfVbt7X1Cn1RdADgWJjs/yve
 hiJlFGkwpD4DK9WTrTsIHqpISzKDrEncOABGGPrgkYIGuq/fHun5GA1EC4Zo7FCUpPOaKBrckKC
 g
X-Gm-Gg: ASbGncuCdh1cnXupBsAIP/yThshH5T8s/xmJgU2bcw9xUaKmvDp4wiWlRSdr9ieZUoc
 MENgKgcdVJis9GGQtoekI5mfRtBvPE96Gqk/zu//dKL/CBSSmL8a5o0Q742q8Yx6k48cV4PNaeg
 DpPU8Cfe8MXM2VXxt34Qx9WVVJBgME5Ybs2751LhidxsHNU7rF5lAna5qIqCK9sonr3K8NDq9Cw
 km0oJOX/8XK3YIAl/KKnoXRdvEeYh4IOfVkJMWlGiy38vZTVowNzw+XPDCqccQFhdkQrKUMijnV
 lsihiPmwx6h/BYpAye5Mb+MY2kAql5eFbqSK/5Ko0NbW6Pc=
X-Google-Smtp-Source: AGHT+IFpCsc1zSewbcoLsXZJk+qdsf6yD2y960KwmCu4deGlg/YakmDXLUSJ+h1LNc1ggIA6o7MhAQ==
X-Received: by 2002:a05:600c:1d07:b0:43c:fc04:6d48 with SMTP id
 5b1f17b1804b1-441c47d393bmr99677685e9.0.1746542558414; 
 Tue, 06 May 2025 07:42:38 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b89edfc2sm169603435e9.20.2025.05.06.07.42.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 07:42:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/32] hw/arm/virt: Remove VirtMachineClass::no_highmem_ecam
 field
Date: Tue,  6 May 2025 15:42:02 +0100
Message-ID: <20250506144214.1221450-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250506144214.1221450-1-peter.maydell@linaro.org>
References: <20250506144214.1221450-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

The VirtMachineClass::no_highmem_ecam field was only
used by virt-2.12 machine, which got removed. Remove it
and simplify virt_instance_init().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/virt.h | 1 -
 hw/arm/virt.c         | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index b2cc012a402..9a1b0f53d21 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -119,7 +119,6 @@ struct VirtMachineClass {
     MachineClass parent;
     bool no_tcg_its;
     bool no_highmem_compact;
-    bool no_highmem_ecam;
     bool no_ged;   /* Machines < 4.2 have no support for ACPI GED device */
     bool kvm_no_adjvtime;
     bool no_kvm_steal_time;
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index d047983c80e..bd1a68673a7 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3336,7 +3336,7 @@ static void virt_instance_init(Object *obj)
     vms->highmem_compact = !vmc->no_highmem_compact;
     vms->gic_version = VIRT_GIC_VERSION_NOSEL;
 
-    vms->highmem_ecam = !vmc->no_highmem_ecam;
+    vms->highmem_ecam = true;
     vms->highmem_mmio = true;
     vms->highmem_redists = true;
 
-- 
2.43.0


