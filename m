Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F0F0C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 13:15:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trzD1-0003Qw-Cj; Tue, 11 Mar 2025 08:59:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzCa-0001kd-HB; Tue, 11 Mar 2025 08:59:20 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzCV-0007vc-9D; Tue, 11 Mar 2025 08:59:20 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-300fefb8e06so1880761a91.0; 
 Tue, 11 Mar 2025 05:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741697953; x=1742302753; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GVJ4vU5t7PULY28jxp4RCE9dE62+yidxPTM11DiQEfw=;
 b=OTPFDRfXg/X/QZgjMh/pO46kaWz6LsWcSUXvE2kHkuR/T04xow5lYJ/PmOoiPCXd2P
 KgKQDxeg3scljGV3QiKyv95j5b+AZghJDzqykUd361LE+zNE1R34mjs8Mkx01TNMOHjj
 MS2FwVCMEOhWBq+dkzyUGjlMMMw7TbbGYxgGkaX0I5tj1ZFrm2JtI5idNb5dlV9Rehrp
 9G0i32hbUJgCtmjnZ6+t2clPwwtoh8ptGkL49sMcaA/oqRe7b0Lp3TDXpkOrKWCACHij
 AlGK2q4HG2gf4Sv/+Ozw9uk6uT5uDfkgkSxmIMW/3jJfLFAnFetumqbymNzU3sMq5HvT
 Hu/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741697953; x=1742302753;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GVJ4vU5t7PULY28jxp4RCE9dE62+yidxPTM11DiQEfw=;
 b=O0Kmq55zpkJeMsLdLD8gv8H5zbZ4mwXHCj1Fz0pLC2SLcdk/p/smuPYIwDjIHYxoI1
 0PmoJZ/8YumLB4r+cGeGGZEkOfKTrfuIOna8R6iFUy/yskKsDZ1BS7eWWsMcaHnsnHET
 aHkF5acZRJFXA0QfPqIu8Ayk0QHemrFgdLma6RM7VAgaHUayTyDa7JNC0XcWHex9pryi
 +cg3IqibbPt+MJa3x1hw65I19kQahdM1I0ZBG84yHmSdtaINXl0dFJbzYuN6WeGJ6V1N
 Ruf18+aK3JMoDSV6AjpA5ZeVaAUCwhEwG1iSkeYYvH7v0BZPmuwAJVraBw8wx0tse62c
 QiQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQzWHnLvz+kTPHINTWzbXR/2i5um/ZGZjAwm4Tv7iGkC2yoP+L52Fm9cL794u7XaTKdpdVy75z2g==@nongnu.org
X-Gm-Message-State: AOJu0Yy8L9qbhBrgW+1HY/dj/ZTVzXOqDf+UnmHZ12fSOQxhX8dGEuat
 GgRT8UQs5Pyd7MVXE4hi8BGZk7+9q5TKSJEvaUFS71jWl8YezoHAcDBJTg==
X-Gm-Gg: ASbGncs2SnXLw8JmcP0HOM2T7eYAyt/iPozcdDbYl/7NEdtRyjYIZdSUj+HGEsOVRxN
 DU32o52VBSTeFuC6qgO8wfBp064LHC1WDBkSRiKQSyx59xAsjCO2D/j06rMaFTEHCNBueJHZ0S/
 zrk9zZyaE29416a2rAsNdtTITqwVVfCLzZr35j71vBwi2BA+RKkSE6wukG7PFDt5HZyRSIQNrYl
 D08abWkHFKH3aE3i3D4HR/aqoZrunMHvm6C/0K6JUgNfhRH7VC6uJEHnTov2a7fITqrg1SXi8xq
 BKVEY4TYgl+uR+/gV5i6yNfcWgGZSeGnTGvz0NyuX9AchfgIa38=
X-Google-Smtp-Source: AGHT+IGNLQJINQzXwusTn4U7ICPr6ESQca+Ph66QOCbxdJo5yFgbbe2xy2CYoQT0eo6NkqhkohgwRQ==
X-Received: by 2002:a17:90b:4c51:b0:2f9:c139:b61f with SMTP id
 98e67ed59e1d1-300ff0ca64cmr5142714a91.14.1741697952924; 
 Tue, 11 Mar 2025 05:59:12 -0700 (PDT)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e773dddsm11822318a91.12.2025.03.11.05.59.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 05:59:12 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	qemu-ppc@nongnu.org
Subject: [PULL 13/72] ppc/pnv/occ: Update pstate frequency tables
Date: Tue, 11 Mar 2025 22:57:07 +1000
Message-ID: <20250311125815.903177-14-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311125815.903177-1-npiggin@gmail.com>
References: <20250311125815.903177-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102f.google.com
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

OCC pstate frequencies are in kHz, so the OCC data was 3-4MHz. Upgrade
to GHz. Make each pstate have a different frequency.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/pnv_occ.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/ppc/pnv_occ.c b/hw/ppc/pnv_occ.c
index 22b07a415a..19ccfe1bbf 100644
--- a/hw/ppc/pnv_occ.c
+++ b/hw/ppc/pnv_occ.c
@@ -682,11 +682,11 @@ static bool occ_init_homer_memory(PnvOCC *occ, Error **errp)
         static_data.v2.pstate_turbo = -1;
         static_data.v2.pstate_ultra_turbo = 0;
         static_data.v2.pstates[0].id = 0;
-        static_data.v2.pstates[1].freq_khz = cpu_to_be32(3000);
+        static_data.v2.pstates[1].freq_khz = cpu_to_be32(4000000);
         static_data.v2.pstates[1].id = -1;
-        static_data.v2.pstates[1].freq_khz = cpu_to_be32(3000);
+        static_data.v2.pstates[1].freq_khz = cpu_to_be32(3000000);
         static_data.v2.pstates[2].id = -2;
-        static_data.v2.pstates[2].freq_khz = cpu_to_be32(3000);
+        static_data.v2.pstates[2].freq_khz = cpu_to_be32(2000000);
         for (i = 0; i < chip->nr_cores; i++) {
             static_data.v2.core_max[i] = 1;
         }
@@ -702,11 +702,11 @@ static bool occ_init_homer_memory(PnvOCC *occ, Error **errp)
         static_data.v9.pstate_turbo = 1;
         static_data.v9.pstate_ultra_turbo = 0;
         static_data.v9.pstates[0].id = 0;
-        static_data.v9.pstates[0].freq_khz = cpu_to_be32(3000);
+        static_data.v9.pstates[0].freq_khz = cpu_to_be32(4000000);
         static_data.v9.pstates[1].id = 1;
-        static_data.v9.pstates[1].freq_khz = cpu_to_be32(3000);
+        static_data.v9.pstates[1].freq_khz = cpu_to_be32(3000000);
         static_data.v9.pstates[2].id = 2;
-        static_data.v9.pstates[2].freq_khz = cpu_to_be32(3000);
+        static_data.v9.pstates[2].freq_khz = cpu_to_be32(2000000);
         for (i = 0; i < chip->nr_cores; i++) {
             static_data.v9.core_max[i] = 1;
         }
-- 
2.47.1


