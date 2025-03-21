Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FC60C35FFF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 06:26:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvVpl-0000TR-4G; Fri, 21 Mar 2025 02:26:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tvVoH-00080k-1J; Fri, 21 Mar 2025 02:24:49 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tvVoE-00030N-IT; Fri, 21 Mar 2025 02:24:48 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-22438c356c8so30779395ad.1; 
 Thu, 20 Mar 2025 23:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742538282; x=1743143082; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fONuj6OGToGS6hsbceww1Dv4M/MhW6pQYlSp4fRXGvo=;
 b=TORJMf7Bv6qtlY1eRQKfew5uPcZC0qJ+T6ZPEf+l0SjSBtq5XMVkc7ehSQnRGd4/lE
 Yf4TchRBZAORiEnPTtVDgNLzIpU9HpGeSc/T5zlzwrc+L8jikMqCEqDmybFYaI/ZxLzG
 JE+FK6Ig6SX3Y+iTXNLmhbpw6etXGXhn6c4YHcIneUOQD/2x3XnWWyg2AIS3eHLXJ8Q/
 7oJJQr5V3iN2I8TZ2MNijCAgdTxquwMfCuidOGj11Z6xTv1XrXvqDMUrMeTQJLzoJgTq
 faCOrQa4jiuXxtO3nxQhBqVxxAAcvlaG8W6cuf8eS94elJNRR7E0YTw6A5wOVyTl4pSS
 hWBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742538282; x=1743143082;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fONuj6OGToGS6hsbceww1Dv4M/MhW6pQYlSp4fRXGvo=;
 b=XDCgWZMUL83w2EujY+CaSMv3wp65NyhGTz1WW1INVtlD2Rff7mw8eMRkwawWaknhNX
 g0jULKt9gM4lOcDcdBNttAOk+LUXkDBgVn44pyMg4aKwNSPOz3pwh3E8noc6lB2uIsXu
 82mIJdgrJgoHZcuSmVR9gnYCqiDXdBxahyJ/bbFI8mRzWRubIsgfaF+WZqI+tbhTd8ZR
 Y69iWR7eoDXyMW/N6MQDG7Gngj4R/vqsq1C7yFtxSbTDca7S0B/c5LeOkiiytSu9oauO
 Q8xEBfGwO7PxxM3iYIBX+dJCMudkgf/H9rIkOvHPM8DI6hPExmB5WOqpWvZsa/d21HDY
 xipw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUN1Vms6YXIUHL3m8uqDOph71kC1pI/UdO0frXbqIvtTTrF6/ALyVEjdGquWMs5B0alSQlpAHPj4Q==@nongnu.org
X-Gm-Message-State: AOJu0Yxcv9BOUXYsyFkEEBmvT86+eJX6tvwzZp/gt35I8/jOZlFE7tsD
 0dF7LPVpL4/MPIU3VhHtIOyEiM8BDnAvRPMLr4sTlbMi0eF75ZTsO6ASMQ==
X-Gm-Gg: ASbGnctW24tzsBxIDefK3KHAaBH2aQs4QJI7w7czFIb+EXLycta5ndxmiYSfwZzESDI
 8zFYrnTs9vgTzYq337T0iSTiHpMLRQH97VqMI7LxCN8T5KKx/r5Evwhtvr3w0KhKRtka0C1s2K9
 bg5xZOeDXMfuYu86Z/LB/Ncqv0almKk1W2aV5zhFzwOEtLptba6KeaUCnZSZRrXHfCXEyyqPZ00
 cDjidisQfCGa1gD4T/V+RQua9oCPl0U2tn+wc1r8HwSjV1Ciz91eKk64FAlaBIXk+ekKoCjkXl8
 s/tiYmmX/sU9g2xbbmknZe6BXPMAxAYD1wgTCY75jtf3CXkIMA==
X-Google-Smtp-Source: AGHT+IGJqmzLzF8cDK5wd50Kx26k9BjsuTZU+sQzltLa1wCV4wllfzX/N/bsclhojFd0kSyxLIm4RA==
X-Received: by 2002:a05:6a21:4cc1:b0:1f5:6f61:a0ac with SMTP id
 adf61e73a8af0-1fe42f2a01bmr3851582637.5.1742538282562; 
 Thu, 20 Mar 2025 23:24:42 -0700 (PDT)
Received: from wheely.local0.net ([118.208.135.36])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af8a2a4761fsm941381a12.65.2025.03.20.23.24.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 23:24:42 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Shivaprasad G Bhat <sbhat@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 05/12] ppc/spapr: Fix possible pa_features memory overflow
Date: Fri, 21 Mar 2025 16:24:09 +1000
Message-ID: <20250321062421.116129-6-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250321062421.116129-1-npiggin@gmail.com>
References: <20250321062421.116129-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62c.google.com
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

Coverity reports a possible memory overflow in spapr_dt_pa_features().
This should not be a true bug since DAWR1 cap is only be true for
CPU_POWERPC_LOGICAL_3_10. Add an assertion to ensure any bug there is
caught.

Resolves: Coverity CID 1593722
Fixes: 5f361ea187ba ("ppc: spapr: Enable 2nd DAWR on Power10 pSeries machine")
Reviewed-By: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index a415e51d07..9865d7147f 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -296,6 +296,7 @@ static void spapr_dt_pa_features(SpaprMachineState *spapr,
         pa_features[40 + 2] &= ~0x80; /* Radix MMU */
     }
     if (spapr_get_cap(spapr, SPAPR_CAP_DAWR1)) {
+        g_assert(pa_size > 66);
         pa_features[66] |= 0x80;
     }
 
-- 
2.47.1


