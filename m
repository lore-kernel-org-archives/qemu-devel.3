Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E91BCCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 18:34:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEtwc-0004S6-Nc; Fri, 31 Oct 2025 14:33:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vEtwU-0004ON-Gz
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 14:33:42 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vEtwF-0006Bn-12
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 14:33:41 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-426f1574a14so1697465f8f.3
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 11:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761935600; x=1762540400; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BhBtli8BAcXvy3RsLsAt6zM5vhvDriswJPSjYGCYQo4=;
 b=IZn9wgEcFkWfsKjmGWjSuGspk0KhLBCrajiuNXmyNWnPSoNloAA8PC1Gdy/mjQSK2Z
 t/G2MQ/cHRWfrjhS2I+XPkJ5T6srh+nF/0bT/N39xiuKHyaAIGAxk+tN0SvSBfJ9eJ4V
 AGMc+BxuEvU+fdu8Gk8mBiAIGmPB4sF1145EIaA+V39zV3GDzovT537qWZYRy21eYThD
 FVlMpi7Zq4iSZ7QyI4ObRlBS6j78YmOE1HfWo76BWJ1QJuPTrRRQ+udEDBo70pEcrkG1
 ItT+J4sHI1o24b9uf3QeS6TJAS8SiUa/YAS1oEh+lJ6xG8Y0aMIJ0UeVW9P5xu1ys0lD
 YcXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761935600; x=1762540400;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BhBtli8BAcXvy3RsLsAt6zM5vhvDriswJPSjYGCYQo4=;
 b=BQlghxUqwcrNspSuCvULokUe4kTqklDa6CNnoirzzz4BdMK54Hh9x8MYzIxUE9s6Ro
 YJqj93ns4cI7tcchpeXmLnObPTKKajA5GfO7k7s6vvTelaE7Xnm6H+EoxMU3mcWQDbmF
 mkdbSsjydmvMrzUZO6Yiaik4zagR0q0X8TVYREL9z6YyHv+eF8Y1fLWufVTzlOyR6jRs
 5vqD2iG4cy9XJhd9nQAYa1F/p/N8apE82MP+fi0jFJTfUgXOEEKCJwkj99//V/7jyrBi
 wb2DPY+MXjCDFm8b0O7S3lFuhax04+SlIjdX64KphxDa3ZTx8De5ouGYpQNb8a64yK+U
 yDCA==
X-Gm-Message-State: AOJu0YxByVkhX3Re5EBcNLdeHuScTvFb5vE4mE1ZRlEvGgc0FLeWTUCb
 v30JaK79AaOceE3OY0PbiRCQ9JJ3zumswbqcFK82K8LB5Ha0MPozVuX8fmzInMZ1IrEsAeEHvm/
 wXs/G
X-Gm-Gg: ASbGncuNDlxCYByqoOFQx3M5T6Gj1aVOCKXkhVsIl1C8hqsvX7LUHqbazDzxltxxO8c
 +03NA3gZCHuH6EPAQLz1/wV3Qw5JkTpQv8X73cVOcgrwFCbM0VW5XgaQCrBl7IBezU1uahpn8yu
 uUh4g6KduEdgfP4ZdgmC602EHaA9G2XuFYHnnIXaCTFYvaAKe4gpc7vTS5qg3F2TX/MwPOIlOGH
 ovFVGw/WwPxA66eSpYIIEjF2zLqRHX27D4pxxSTH1rY7GxAGsZRL9PU2PKYw3vFYyTDdAus7gto
 1Kz9q2DsP0QcbZ+30hW3Lm592B399RgjLcitZIUTNadajmMPUUaq74JJzOm5FPSXuBctfzmV4wP
 QJTKI16CT4KiaQSW9NGpPQJJ1FXlNdZtTcZhwoBwQzuL3Ia6e+QydotibqqO+TH9WZNQaQqtdk0
 esQEiJhg==
X-Google-Smtp-Source: AGHT+IHKoAx8WKkVDZcxQ4+IzxbPQUOP/4m30Ih+FuBSVtl1KW0B5R9tt8KrQTp1K3BVpuKHnzTthw==
X-Received: by 2002:a05:6000:200c:b0:429:ba95:3a6e with SMTP id
 ffacd0b85a97d-429bd6a6194mr4120964f8f.46.1761935600451; 
 Fri, 31 Oct 2025 11:33:20 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c114c944sm4859142f8f.20.2025.10.31.11.33.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 11:33:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/38] hw/arm/virt: Remove VirtMachineClass::kvm_no_adjvtime
 field
Date: Fri, 31 Oct 2025 18:32:40 +0000
Message-ID: <20251031183310.3778349-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031183310.3778349-1-peter.maydell@linaro.org>
References: <20251031183310.3778349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The VirtMachineClass::kvm_no_adjvtime field was only used by the
virt-4.2 machine, which got removed. Remove it as now unused, but
keep the ARMCPU homonym property.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20251020094022.68768-5-philmd@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/virt.h | 1 -
 hw/arm/virt.c         | 5 -----
 2 files changed, 6 deletions(-)

diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 993872bb680..c77a33f6df2 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -123,7 +123,6 @@ struct VirtMachineClass {
     MachineClass parent;
     bool no_tcg_its;
     bool no_highmem_compact;
-    bool kvm_no_adjvtime;
     bool no_kvm_steal_time;
     bool acpi_expose_flash;
     bool no_secure_gpio;
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 751e22e6f42..25fb2bab568 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2365,11 +2365,6 @@ static void machvirt_init(MachineState *machine)
             object_property_set_bool(cpuobj, "has_el2", false, NULL);
         }
 
-        if (vmc->kvm_no_adjvtime &&
-            object_property_find(cpuobj, "kvm-no-adjvtime")) {
-            object_property_set_bool(cpuobj, "kvm-no-adjvtime", true, NULL);
-        }
-
         if (vmc->no_kvm_steal_time &&
             object_property_find(cpuobj, "kvm-steal-time")) {
             object_property_set_bool(cpuobj, "kvm-steal-time", false, NULL);
-- 
2.43.0


