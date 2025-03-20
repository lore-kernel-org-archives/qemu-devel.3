Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22DA1C28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 22:36:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvOQi-0003gH-DI; Thu, 20 Mar 2025 18:32:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvOPm-0002af-GG
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 18:31:04 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvOPO-0007B4-AV
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 18:31:01 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2255003f4c6so25981235ad.0
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 15:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742509831; x=1743114631; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lGjkhQ7Rm7y3SPTNm83ItgGSoGlWsmhX663zoINx/mY=;
 b=qD7FePaf4YpqL7+TgiD1157XDCIjUUI/p/nasjTyMRRVqMAwg/x42ngLc2BQV4uqcs
 ofDY0CYOWKlWfw3oJX8hjz8K/BPJVEDyxS8uBCSTpcvwaFEgzV6JE3vgsmRn5XbKB3ei
 LTqVWd4MMHpnGotkROMrK+eyVP0YdBEj7UEQLaDmiub/8o2V96s73OXdYL5Q5/z2QX6A
 DV6HQ90Rf6tBAIowqIdXSi/DOstoMQr3gXxGE59pUEnhCECmmjQKAvA4KAfNq/UDYQUx
 AvlP8wflVEeuBcf1oxGnSJMJls49/eZWiZazllMDxdWtUWXomjHYzxo56egWpAcKaFPM
 wFmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742509831; x=1743114631;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lGjkhQ7Rm7y3SPTNm83ItgGSoGlWsmhX663zoINx/mY=;
 b=L8vL+7dZo5nXSTbsdNr12w75l3wPCODaJPQN2B+792PbISYPFYrczoJUW4JrMT5fzQ
 axbeLGlahNoO96MZdf7ypHC6qSZ3V0djGTaZYjt6kva4GdUXtGBs7RzrO8b2BZwbqhAl
 MIpU0pEgWt77213AN06mk2T3r118LDEfZ+EyKg0JMtNaLc6OXZaczGG5mWvP28GpYfJR
 9lbCVleRYa9HhBZPD4/GeXhSUbK5W93vm5IXC40+QB0lmzB9S1BKI+s9ZP1Is15APqHv
 ZwOAJ/ilBkd4IX7VDp/VGDIAV+8TGHScNNfHe1fmZgCHpuSuc20UGO4EqGuajxAmlXbt
 y6yg==
X-Gm-Message-State: AOJu0YwcM36kduXpJj5GechtzixxxL1SUoRZmUludQfuuZaTrLzjdB58
 BkMP27L2UYiTWIBOt13brB6WgQTuUhKG+vybaRmvPvBkMpvZz8SsR6+ZUsNMmodVkkqTcX9hlp0
 +
X-Gm-Gg: ASbGncuz7vx9yRloDHka+mPCnqQhllne+4laDKLgdmmzs97sI17qLhHBXyi5vaqcYi6
 MU/2qDyju2m/oK0Y3fOAIST4nEGWYu6lBzaOeqVoBuZ/iGZuMUH7rjoHmDlrNdQvrSmiRt60nTQ
 LSxE9ceyMVkDcFv32Ruj/8NXDi99i4QRKaYn24r4LxA7x6mZLhYrZh6a8/YuvkImTmZGsZ0jSNi
 95tJg9AW4Z87x2KOZGeARNP4AntM6wa+flxLqMOuPYCzmNNdW7RbVzHITlbmMCBR1ubHbTOE6KF
 8b0p9nUfSLWhElgGQYLtC1vcbym6325thoyTN2GarePu
X-Google-Smtp-Source: AGHT+IECC2u96EUAdCu+nIhzRGOlzelUPCPjSbY+gS5iVhhPcKqW1YWZqHzKBvuL+vB+mhXdR/p94Q==
X-Received: by 2002:a17:903:2350:b0:223:517c:bfa1 with SMTP id
 d9443c01a7336-22780e10d13mr14113105ad.38.1742509831103; 
 Thu, 20 Mar 2025 15:30:31 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22780f4581csm3370145ad.59.2025.03.20.15.30.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 15:30:30 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 19/30] exec/poison: KVM_HAVE_MCE_INJECTION can now be
 poisoned
Date: Thu, 20 Mar 2025 15:29:51 -0700
Message-Id: <20250320223002.2915728-20-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
References: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62a.google.com
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

We prevent common code to use this define by mistake.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/exec/poison.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/exec/poison.h b/include/exec/poison.h
index c72f56df921..d8495b1d358 100644
--- a/include/exec/poison.h
+++ b/include/exec/poison.h
@@ -74,4 +74,6 @@
 #pragma GCC poison CONFIG_SOFTMMU
 #endif
 
+#pragma GCC poison KVM_HAVE_MCE_INJECTION
+
 #endif
-- 
2.39.5


