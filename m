Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6682C35FF3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 06:27:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvVpq-0000he-FM; Fri, 21 Mar 2025 02:26:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tvVoG-000808-OI; Fri, 21 Mar 2025 02:24:48 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tvVoE-000309-He; Fri, 21 Mar 2025 02:24:48 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-223fd89d036so30893035ad.1; 
 Thu, 20 Mar 2025 23:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742538279; x=1743143079; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SqViPbJrwkFdFnQi1kgDINENtOBtFE3qJ3dGXQXwpNg=;
 b=X1yFSua1JjPqLE1uXq1Jl6WXqn2S/IqqYVfqb1KSdc+O44vt9DWNuLTX03hAVP7Maj
 7w2ptpy9awpA4bdWD4GcaUqmHhT0Mia1i8vmJ8zdvvOv7Y2fd4KD4DcohIZ/3czMXn1U
 Myhe6Po4Mw8RwzsRESUDzApqxKNTHyq04+im6CD0k/q5A0F/Jdixr4kNSI39sXX76/2x
 BWprQuUeTqdm89IE0gm75WFIJrDqJHUKqmXMWu0TSv/L+8i6pz1TVoDpbBODwXBSn8sV
 CzwnQH0zY3nJ5B33B99hw9e59O8SmAq7cio1FpNzr2amcHLK6ewpSCdaAT/1FsXYqwoO
 ZrYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742538279; x=1743143079;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SqViPbJrwkFdFnQi1kgDINENtOBtFE3qJ3dGXQXwpNg=;
 b=W8f8Jyqy/M0ZhqP5zehEmsS0c/2VkbV7/oGP3rzSh1AQrCcaRLJfAW7bcojxa4qXUH
 z8S+Xn8EYWqrj6XsjnoxnDMyG+0iBK4xFvdphVLYFp8GNZI5P5nH4ntTTqVuEegIqihl
 RMVvR3w5S6OuOTSx37gdeQyJkzcoaUV7Lr36vbb1PMh6eWJDlIW5YcEKpBG+7fyTaMTh
 CUdkdCLQ5yEOHp5eosAeIYzu7zlg1EYAz3JxAHbdXnDX7CylVhJWAfxF+q9IC34LdSZn
 VRbpzESWOM25Bx6HawZeuRHHEgWTxknEvJlomLmgphDHafgeE1UyOrjsSUflAonW0U1k
 ec3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8CI2WRKCVGH55kzeht3i/Hu4dfYgMKTJDe/Z5DnYZ38q8SzdRXN0R3rFTWSeExm+cPIkJYYUGUg==@nongnu.org
X-Gm-Message-State: AOJu0YxH7STPDtt2kdFFyJydTnK2bDZJt0gpD21lryaNK7+RRuPRk5Xo
 alXR8Wr3Sdo+Wzz589ycaR13+IK8NRtKIpwI6PIXHwyqiW975UzIu3pmew==
X-Gm-Gg: ASbGncu2024o7iGj7i8GpjD/eZ8C/lAUsQgCywvZhOnni0XhDM1/30Rm7yIp8M18Xw/
 C+iFsh2H2L+3O2OA/EWI7dMOYjKGBcz27QvKtVchZnDQjY6bG2xhM+4Dkc3R5ksI3kN4Rv5VTP9
 RUmQQ8rvwWWWKPqouLVKVfNo+e1VdfT6imtEo9f/70K4pq//R2eAALIMP7WchPIUsJpqATBbCtW
 UvK6rteXuVspv9AHP11l9soV4UfxQmQqx8mnstJdxo934EzqJc+tddI/aH4mwRYHfVklgUKQa9O
 Xv0OcH9ODG7VMpRuFddXLTWBG66GAQAs5pvwnHfhfeJAGIV43g==
X-Google-Smtp-Source: AGHT+IGhTE2seVPaGLaeE3sDq2xR7yTGaBdO/okZaNXp3hmqtCtqbwn9Hbd6fAfsIdSkkD/1Oxbznw==
X-Received: by 2002:a05:6a00:3d0a:b0:736:4d05:2e2e with SMTP id
 d2e1a72fcca58-739059667damr4118480b3a.6.1742538279456; 
 Thu, 20 Mar 2025 23:24:39 -0700 (PDT)
Received: from wheely.local0.net ([118.208.135.36])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af8a2a4761fsm941381a12.65.2025.03.20.23.24.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 23:24:39 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 04/12] ppc/xive2: Fix logical / bitwise comparison typo
Date: Fri, 21 Mar 2025 16:24:08 +1000
Message-ID: <20250321062421.116129-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250321062421.116129-1-npiggin@gmail.com>
References: <20250321062421.116129-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The comparison as written is always false (perhaps confusingly, because
the functions/macros are not really booleans but return 0 or the tested
bit value). Change to use logical-and.

Resolves: Coverity CID 1593721
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/intc/xive2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index 311b42e15d..7d584dfafa 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -1344,7 +1344,7 @@ static void xive2_router_end_notify(Xive2Router *xrtr, uint8_t end_blk,
         return;
     }
 
-    if (xive2_end_is_crowd(&end) & !xive2_end_is_ignore(&end)) {
+    if (xive2_end_is_crowd(&end) && !xive2_end_is_ignore(&end)) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "XIVE: invalid END, 'crowd' bit requires 'ignore' bit\n");
         return;
-- 
2.47.1


