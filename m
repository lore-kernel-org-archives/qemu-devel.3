Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07810CCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 11:36:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAoB4-0002ZR-1q; Mon, 20 Oct 2025 07:35:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAoB0-0002Yh-DD
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 07:35:46 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAoAy-00019N-Eh
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 07:35:46 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-47117e75258so14895545e9.2
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 04:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760960142; x=1761564942; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=71R8sAvBEiNvqEf9kiOYU72VRXxnt/PEhui8Mhvi1Og=;
 b=dMJA4sSRZfBlddDezyGAUzfKCVKFEroR3E6cSn0jtmPydHzpaZedJxq6LP+DdW0Z/V
 7hJgXvdc7U0JG/E7PX5roLCJznugJHDkKO9MUgDQwBJvExb1igp2dDONfMEbC5q7+xTY
 lEKrnM6pJRbcy8tERZlylVndWAA8xYZ0plh0FPoVgC3UAW+RNdH9MxV8tjn9k/gMg7Z/
 TCZwwY4UA30pRCKVHhKNGx+4kZLtIgbszVCMr0iiI9IqUxJn9Zaz3kO2tX9nxGfnSzn6
 tOVaqXJsmJAjhnWaFxVOmNVPUdFxQBj52cYMQbqS/gH+NHymtaHkDIV91vWB8IIj7R9d
 pRXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760960142; x=1761564942;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=71R8sAvBEiNvqEf9kiOYU72VRXxnt/PEhui8Mhvi1Og=;
 b=ngFA6RQjKtQgLEGS/KW7E5OW8MV77pi+QmN2VR4evLiQyMgjXwPheLrbZJELbeWpbm
 /43eiRSPwBp6HFMXNXhjErEkxunmYw34iQgpXFMMErO8Uf/FDd95sgxhLhe/SwfVAnZy
 I/ryQr3ZZcQHSItAm71amkFJJj78cIC2HuOpHkeotZkxVVxgvxqIhUfOSUJl99EeMuzb
 efPiBGtigcRS1Up2RjKstyT1S8z6nBu9Ho8CPKeOH9yaKe5THganpdgT/S+aOcibxphM
 yvULTCGuxZdWNhqzoSHta2YTrhQETxYmDkEsx5LUahDcj4pjoZEbrtYTBpODjkhGFaKf
 kk4w==
X-Gm-Message-State: AOJu0YxEPgHzXozESOmrVjsOHRoo3UJV9HkCj8pYfdugMy+7Ms+BHsCX
 75yy9r6FlDhfsD7HQJOBqZrcXbAqxSFS8Jbwj+lV4UYNPhnjjlMDgpxkZkBMBo8g4IBmJPls7ia
 i/UQO8L4=
X-Gm-Gg: ASbGncvH6k5u0ETvAjnSvVSPSnQXDfZkBI2P5PG5WZ/EzGS/wvATzTDVfJn7UBngUw0
 1cDW8VbaNATnRbl7yG/ToUQBHvWRSN08t+7sz7D+jG8x9teqcn0fABXH1tAyMMQ3395fHJdh7Mm
 dI70JgsCZFFuSbCNLtX/ixy+1wi4JNggQU6+Kw0njGluE3vYoMX+FftgvuGiIXuSkBfmZjdt2W3
 gSZYXWLv6T2J15SS9DAd59dfcZOTk2wH2senmfGwmip4oz2rzepPHF3ehvl3+hHA1SVuNOtuFtS
 sMZ4q7ILurAgnj9sr6wBRGtDshCBVA3HC0OhvAs6vffDPjonJ6XCiS8IF9skLpBgqorIapzp9Ok
 yo5zczPONLOxgzx2rTTTIv8CMSW7/5DJo6zwxbrJuzRiO79FpjKMXMiZbxQIZ+8k2YbBbg6q4zn
 EGdnEO5fDhphDlTqqbeAUHpgHqDPODk5ACAigvphx9pKZiaZXM/gAeUh5PUOCp
X-Google-Smtp-Source: AGHT+IEPx0SE5xUIDTfxvhDNmRz2LWgkyKXl8jschWeu+y/qt79zcqlwmwc9t+0lsEUm/8AyI37oAg==
X-Received: by 2002:a05:600c:3513:b0:46f:b340:75e7 with SMTP id
 5b1f17b1804b1-471178748a9mr100220295e9.8.1760960142366; 
 Mon, 20 Oct 2025 04:35:42 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427f00ce178sm14714271f8f.46.2025.10.20.04.35.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Oct 2025 04:35:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Chinmay Rath <rathc@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 18/18] hw/ppc/spapr: Remove SpaprMachineClass::rma_limit field
Date: Mon, 20 Oct 2025 13:35:21 +0200
Message-ID: <20251020113521.81495-5-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020103815.78415-1-philmd@linaro.org>
References: <20251020103815.78415-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

The SpaprMachineClass::rma_limit field was only used by the
pseries-4.2 machine, which got removed. Remove it as now unused.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/ppc/spapr.h |  1 -
 hw/ppc/spapr.c         | 10 ----------
 2 files changed, 11 deletions(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 60d9a8a0377..b9d884745fe 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -141,7 +141,6 @@ struct SpaprCapabilities {
 struct SpaprMachineClass {
     MachineClass parent_class;
 
-    hwaddr rma_limit;          /* clamp the RMA to this size */
     bool pre_5_1_assoc_refpoints;
     bool pre_5_2_numa_associativity;
     bool pre_6_2_numa_affinity;
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 97211bc2ddc..52333250c68 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2728,7 +2728,6 @@ static PCIHostState *spapr_create_default_phb(void)
 static hwaddr spapr_rma_size(SpaprMachineState *spapr, Error **errp)
 {
     MachineState *machine = MACHINE(spapr);
-    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
     hwaddr rma_size = machine->ram_size;
     hwaddr node0_size = spapr_node0_size(machine);
 
@@ -2741,15 +2740,6 @@ static hwaddr spapr_rma_size(SpaprMachineState *spapr, Error **errp)
      */
     rma_size = MIN(rma_size, 1 * TiB);
 
-    /*
-     * Clamp the RMA size based on machine type.  This is for
-     * migration compatibility with older qemu versions, which limited
-     * the RMA size for complicated and mostly bad reasons.
-     */
-    if (smc->rma_limit) {
-        rma_size = MIN(rma_size, smc->rma_limit);
-    }
-
     if (rma_size < MIN_RMA_SLOF) {
         error_setg(errp,
                    "pSeries SLOF firmware requires >= %" HWADDR_PRIx
-- 
2.51.0


