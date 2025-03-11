Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1F4BC28B2E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 13:12:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trzIu-00034F-29; Tue, 11 Mar 2025 09:05:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzEe-0005XO-A0; Tue, 11 Mar 2025 09:01:30 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzEa-0000Gv-LY; Tue, 11 Mar 2025 09:01:27 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2f9d3d0f55dso8228505a91.1; 
 Tue, 11 Mar 2025 06:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741698082; x=1742302882; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vyXD5UzpUW0YaKhAXXjbHUshaxnE47RC+WIYwrc3gYk=;
 b=XNEiM5gAK3OsrCtpEp9VMs0G3iu5Tq/2ANyAqtl3CYwKX6ZgfYok9UUxHbl7chuT92
 uM0bBm8wkPe9KyIfvZKN/21/iSVmB5rJHRlkFd0vA4Ppyhz4Kw4Nn47BRF6YzTkofqbi
 NVo0zEYLSC/W0f3YkbKD7b7Tfbw25diI71DVQgWbGzFUjHB4p5njY5Ytnohxvc/8GkUU
 2dzOTTRLXw0+X0TEq8XcVhYmc8d3Q5yvnPCogkV7AYdroN+4G+b/B9cXBSHnyuLauSPk
 Y9n11kYeNkaehkLp86eXaQHxYtjer2zy/wj+vu70RXJVKWEMfVNolPW0iPkq8PqVkXy0
 YpQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741698082; x=1742302882;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vyXD5UzpUW0YaKhAXXjbHUshaxnE47RC+WIYwrc3gYk=;
 b=I+fcPISZ4fcYobtykJZY9vkq2qOjluiPbhSvuCbtLohl9DjaeTIkG0ypfy1TnvFMXK
 5hv7O+7sflQd92OYEvOX6elIry7d0+5mxeQn9M9oiiMz7kBONf0E/FT+iJY9+onVfAKB
 Sp/swthvplZYuMSCHJEQXuPZ0i6tjMlUJ5dR3l//51I+FxCJflPzyLngNxtGwB6P5c0p
 7frU0mjMdcI+FQEtTjHQZI+oZXYOCen7HBsxLo2CRWDXA9/DTdd/XI/cNUjURXV1wEPl
 t42UXLGpv7qV/+8kTXanR3ALsGAxvhOywS4OzHCU5ib566SFN5g7M09qDg4R8FznqdHH
 dIDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVV+7Nee8sdnDcyLt5o6eFppOv1YXdl0xtNq5WnVe0GIQm8d3y9YBByKCFT/d9XOzF0CjLjKRDcw==@nongnu.org
X-Gm-Message-State: AOJu0YwsMqaK3K1WkK5s75n/z6TZCXp/TOcnUbmr9Ei2C00H+CCXkLne
 6/YLwJgIQXsc6+0kYFI2PGfnVpuUFTghG/DBTexiR7aBCP9/AWG6/4q8Vg==
X-Gm-Gg: ASbGncs4W9QeT58sB1W+K6e0ed7kzeYi+dac0/a2Zwdkd7OAVhle873Z5JkRKkzx9lh
 qio0oenhN2JETzxytcvy4z8bw5Y0NUVZqets6G49QmOFh1+ox0yejO5C9xLAzahd+ni1LXyaPbW
 ViW34OzKmQ3U7hVr2yD779EMZw4D27PprW3ThX0gRocraJEFwxsxXYGVQ3MGGI9jJur0JPm/uT1
 hSu6L3oM8etI7zH1i5xaUz5WT7O7JDJTn2WHg6g8Zq+vMzxG6Y3g/8Czu0AZdza65l+0R4tcdYR
 tqCMQ1lSzp2/fSTmTXLU911t2uhYpd7ipsK5O3iruCNHCvsLakWF9RESTwSv6A==
X-Google-Smtp-Source: AGHT+IEMJZBUgVnye9Cur+e6qLx66fIs3LKKWKwiYdXdizHq23zqK1Kp7v7WjIVSvGuGTSNK+VlNvw==
X-Received: by 2002:a17:90b:38cd:b0:2ee:741c:e9f4 with SMTP id
 98e67ed59e1d1-2ff7ce8e5dfmr26796090a91.11.1741698080776; 
 Tue, 11 Mar 2025 06:01:20 -0700 (PDT)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e773dddsm11822318a91.12.2025.03.11.06.01.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 06:01:20 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 57/72] hw/ppc/spapr: Convert CLEAN_HPTE() macro as
 hpte_set_clean() method
Date: Tue, 11 Mar 2025 22:57:51 +1000
Message-ID: <20250311125815.903177-58-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311125815.903177-1-npiggin@gmail.com>
References: <20250311125815.903177-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1029.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Convert CLEAN_HPTE() macro as hpte_set_clean() method.

sPAPR data structures including the hash page table are big-endian
regardless of current CPU endian mode, so use the big-endian LD/ST
API to access the hash PTEs.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Message-ID: <20241220213103.6314-5-philmd@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index dd81398445..3568a97045 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1419,7 +1419,12 @@ static bool hpte_is_dirty(SpaprMachineState *s, unsigned index)
     return ldq_be_p(hpte_get_ptr(s, index)) & HPTE64_V_HPTE_DIRTY;
 }
 
-#define CLEAN_HPTE(_hpte)  ((*(uint64_t *)(_hpte)) &= tswap64(~HPTE64_V_HPTE_DIRTY))
+static void hpte_set_clean(SpaprMachineState *s, unsigned index)
+{
+    stq_be_p(hpte_get_ptr(s, index),
+             ldq_be_p(hpte_get_ptr(s, index)) & ~HPTE64_V_HPTE_DIRTY);
+}
+
 #define DIRTY_HPTE(_hpte)  ((*(uint64_t *)(_hpte)) |= tswap64(HPTE64_V_HPTE_DIRTY))
 
 /*
@@ -2215,7 +2220,7 @@ static void htab_save_first_pass(QEMUFile *f, SpaprMachineState *spapr,
         /* Consume invalid HPTEs */
         while ((index < htabslots)
                && !hpte_is_valid(spapr, index)) {
-            CLEAN_HPTE(hpte_get_ptr(spapr, index));
+            hpte_set_clean(spapr, index);
             index++;
         }
 
@@ -2223,7 +2228,7 @@ static void htab_save_first_pass(QEMUFile *f, SpaprMachineState *spapr,
         chunkstart = index;
         while ((index < htabslots) && (index - chunkstart < USHRT_MAX)
                && hpte_is_valid(spapr, index)) {
-            CLEAN_HPTE(hpte_get_ptr(spapr, index));
+            hpte_set_clean(spapr, index);
             index++;
         }
 
@@ -2273,7 +2278,7 @@ static int htab_save_later_pass(QEMUFile *f, SpaprMachineState *spapr,
         while ((index < htabslots) && (index - chunkstart < USHRT_MAX)
                && hpte_is_dirty(spapr, index)
                && hpte_is_valid(spapr, index)) {
-            CLEAN_HPTE(hpte_get_ptr(spapr, index));
+            hpte_set_clean(spapr, index);
             index++;
             examined++;
         }
@@ -2283,7 +2288,7 @@ static int htab_save_later_pass(QEMUFile *f, SpaprMachineState *spapr,
         while ((index < htabslots) && (index - invalidstart < USHRT_MAX)
                && hpte_is_dirty(spapr, index)
                && !hpte_is_valid(spapr, index)) {
-            CLEAN_HPTE(hpte_get_ptr(spapr, index));
+            hpte_set_clean(spapr, index);
             index++;
             examined++;
         }
-- 
2.47.1


