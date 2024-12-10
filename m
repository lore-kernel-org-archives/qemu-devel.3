Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A166EE7717D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 03:07:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKqYv-00005V-JU; Mon, 09 Dec 2024 22:05:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tKqYu-000056-3H; Mon, 09 Dec 2024 22:05:24 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tKqYs-0003G9-Jw; Mon, 09 Dec 2024 22:05:23 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2167141dfa1so3548605ad.1; 
 Mon, 09 Dec 2024 19:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733799920; x=1734404720; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iwlscf/yHkFwlKkBbkoVTudgjbVzWybWKSC3cCOM7sY=;
 b=UCNVUmnqi/tRQEfJjDsntQJfKJiJ1PRDD+uCgnSDi2l28RgqH3bd/8RA84ySMJKWLh
 2BjtOV81PTeBjhYgvwrEaQRI2o54uAl3PddGZ/cr903dp9yL5IrbW6pA/3dw/FZQdaJJ
 KrcUKTo9BXZzH/BKqk2xfaXoSwt5SjzJJk7T91LDNchajoncXbw1ZJcqUTLDXIBiAT2/
 TUaDjyUHvB1ks6LH/Ddk73LGmyZXtJam8lnPg/3vVQljUqDhF/tboXar9kinf+tXkPQI
 g+2AaV6iHWYMbV1o5rrbjrojDXT6lVnGPoibdzbYYYEt9WeINAp+dykRTXsninKbPyzg
 Gs4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733799920; x=1734404720;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iwlscf/yHkFwlKkBbkoVTudgjbVzWybWKSC3cCOM7sY=;
 b=sZFFa/6Vjd6mbyXwCjtyWgKC6n3A9AHS5hd29du0/h2Z6HQ1AlgeG3kR8mf12IqiSZ
 nDipM0vgJ2tdY5G1zG2K7wWbCmP1g+mfcuigOktSWNHjSZYG6KwcLzWG3uKd59Vw+Kh2
 5nDRHDQsydXkvVjpYlTkLEUkYPP4mkgAA1CKRm2i8GHwR9UyCXSoGPd/HPhzz3Jq3n9i
 yTnUp+VnT3A14l0UN6UFx3gAsmzcV9kTOFE71Gd9V69Iuciz3St7R10h0/xGDubX04MQ
 yS2dMOLFy7ygT+wOmKeeFyaI1ZwoCYsNi9XxQBncncZvayI++bQLhZEV5/KnF2xXfxco
 tf7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTHtUVD7l8/D/fcrdq95veCxUkGnxRF79H6/KkwuO06D8CLtDSblE/b/0DVulXbxVRiM/Dh6Lqbxkx@nongnu.org
X-Gm-Message-State: AOJu0YxYMFObBWtchcKavOkmYqet+u8JIjgLKXIC77hnHc7nBv9W7qci
 Z/yoUXXihcCuBJsHI5LD1QByHIyjUS6WUs+HZsIWOeH6INJVu3uoZivq2w==
X-Gm-Gg: ASbGncv86s3OMLjOSEjjo8LhblowmdeQRg7mvSbyO/grnHjvg3csCyFEEbwHAbsXq+r
 XevMKBK2Nv6cFomxAVAYY0wu2lSCVRFQyki4LOUXC9ngz6Ee8oAA1V5kBHZFkvOH5Zi6A4eKrAW
 DTNkVsO4gciRvw+vh4wzsW27fQ5DuGAcJkXJtTU1+E+4dVfbheNb4QamTvFXVzzV3ryQmxWv/CP
 f9jEdhejSh3FTNtUlvkrW8NjeYCt9Tsfy8HR1dwERFi7wYDzGDJ5BADnYoU
X-Google-Smtp-Source: AGHT+IEy/NDADGuSH/dKILIqAmBCe6e29nl/xE8A5SNJGI59ClrjBWou9AM/cHwdSQdTm7XmW7XlKQ==
X-Received: by 2002:a17:902:f706:b0:216:39fa:5c97 with SMTP id
 d9443c01a7336-21670a06bbemr28454995ad.11.1733799920522; 
 Mon, 09 Dec 2024 19:05:20 -0800 (PST)
Received: from wheely.local0.net ([220.253.106.119])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21631118cedsm44813865ad.150.2024.12.09.19.05.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 19:05:20 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Subject: [PATCH 7/9] ppc/pnv/occ: Update pstate frequency tables
Date: Tue, 10 Dec 2024 13:04:47 +1000
Message-ID: <20241210030451.1306608-8-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241210030451.1306608-1-npiggin@gmail.com>
References: <20241210030451.1306608-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x630.google.com
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

Make each pstate have a different frequency, because that's easier
to observe and test.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/pnv_occ.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/pnv_occ.c b/hw/ppc/pnv_occ.c
index 918b08ba2ff..5567fbf008e 100644
--- a/hw/ppc/pnv_occ.c
+++ b/hw/ppc/pnv_occ.c
@@ -681,11 +681,11 @@ static bool occ_init_homer_memory(PnvOCC *occ, Error **errp)
         static_data.v2.pstate_turbo = -1;
         static_data.v2.pstate_ultra_turbo = 0;
         static_data.v2.pstates[0].id = 0;
-        static_data.v2.pstates[1].freq_khz = cpu_to_be32(3000);
+        static_data.v2.pstates[1].freq_khz = cpu_to_be32(4000);
         static_data.v2.pstates[1].id = -1;
         static_data.v2.pstates[1].freq_khz = cpu_to_be32(3000);
         static_data.v2.pstates[2].id = -2;
-        static_data.v2.pstates[2].freq_khz = cpu_to_be32(3000);
+        static_data.v2.pstates[2].freq_khz = cpu_to_be32(2000);
         for (i = 0; i < chip->nr_cores; i++) {
             static_data.v2.core_max[i] = 1;
         }
@@ -701,11 +701,11 @@ static bool occ_init_homer_memory(PnvOCC *occ, Error **errp)
         static_data.v9.pstate_turbo = 1;
         static_data.v9.pstate_ultra_turbo = 0;
         static_data.v9.pstates[0].id = 0;
-        static_data.v9.pstates[0].freq_khz = cpu_to_be32(3000);
+        static_data.v9.pstates[0].freq_khz = cpu_to_be32(4000);
         static_data.v9.pstates[1].id = 1;
         static_data.v9.pstates[1].freq_khz = cpu_to_be32(3000);
         static_data.v9.pstates[2].id = 2;
-        static_data.v9.pstates[2].freq_khz = cpu_to_be32(3000);
+        static_data.v9.pstates[2].freq_khz = cpu_to_be32(2000);
         for (i = 0; i < chip->nr_cores; i++) {
             static_data.v9.core_max[i] = 1;
         }
-- 
2.45.2


