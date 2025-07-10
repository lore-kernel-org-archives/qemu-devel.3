Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 085FAC83F23
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 16:59:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZuav-0007Ko-DZ; Thu, 10 Jul 2025 12:58:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uZuL3-0003PL-Ol
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 12:41:37 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uZuL2-00018E-65
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 12:41:37 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-b34c068faf8so1368543a12.2
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 09:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752165695; x=1752770495; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vSHu2C6AHkdi6I2MI+MN+9VTwDs09gk+qY11owIPdS8=;
 b=NxrXbiQN9yu93AEExV/fCjmH6OgZB1JuTjSsrV7nUW3jopBDcojbK+/zETaCuXFO5u
 +bEPKPmggEIOQeqSZgoZPzxcmS3iXFde8Yjihq3K8WdfMxCYP6T2xQy2s0G2XShi43eA
 xjK26EEcNq/gB4UVei2HCA+e7Brd5DbeMT/FRyV5M5usM3OTXNtGp4naZsHqZ5fHzrRw
 Yo7WCUF8Gh6W3xg0wFB4hJj6oHvyTsRpcSl/GvWes/Pt18E1vHUgx3Tc+TcC6efCJeqw
 Tk/8SkhY2DpA8URs9z4RnKEaFMgULIPIf2v4oVSiiu3KKmYpgEM+0WuutT3g2ecyOPud
 ptzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752165695; x=1752770495;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vSHu2C6AHkdi6I2MI+MN+9VTwDs09gk+qY11owIPdS8=;
 b=UIPDtADF9xYwvaz5MjFNX0mFbZJabZYs56Wb6QS5QoENi7WEtrVevyKgTGaajUD0hu
 ll08WTQTJaOoV+DeWzJ0s/lASS9ia93LsujxA8EvtHSVY5HZAd9cAqGJM+BuvrZhkZ86
 12yYnTSbDFfhBY42iPcNdi2wNa89b/N7RNScq0BhYMT71vwcNsZZ8g8RmI08hM1RKOh1
 F9Mje7v+bkd+xnuoPy6dbXcbHrOwBpAaYeJJGrPxNYpEwFSqPVjFTIDJ/Fi2QVogWw/1
 k5aOf0S55yRpUqR9lWA4pJQtZQu2X/INKtpSRIxM21HlRuXbyDxh6JT80txmoPVilKmi
 E/Fg==
X-Gm-Message-State: AOJu0YzVroSQm1/FFUwTkuYBMjZB2Z+CjEn7AMeiEwtOzBOaHMiUKXK+
 PtRizyVqIjOU4f+Lwwc4DoDBcuc2cZ4I1rlQHsZMkj7NKzmIgCv/RT1QR1uNxH+WIzQ=
X-Gm-Gg: ASbGncudna5USpZ1KsnYsuIAeqPeqr6z8D5w0m0bCvZ5g3VPPY00dJjFw1x83wlrmaO
 ipBfpvLjsih998ryzD25V5XkDB8dfB5NPQx/s2tTgYthjMyBV05vSYLeVJnjD3GxpnFA2dv79dh
 bHaj/C+KT0DtLxAP1ZDoUgPmnu+sCDUUsxyVz+D593h24l+Vit/BemYMzkBLEO93bbLaBTgEKns
 NkGZK/XXPqqd5VWM64885dFqi/EvO+wvzG1kitmniK4ewDnKdLQ9HXYcjiYOE3yGeBwiAE7Wgh+
 WwA5Yd6G4R08uVISHSitrEdz5uYyKheECfFQh5OM/mrGVT1G4oGt+6Ddc7C93KBxVELrl2ug5qk
 BX7BSx+XOJLiV/emq9Reoig==
X-Google-Smtp-Source: AGHT+IHB9V2Vzu7afu7FqCHdjS/MfXtdEF5v+MV/DVnXUBFRlomNYDMZrcS7AKccHT6yeSWFB275eg==
X-Received: by 2002:a05:6a20:ce43:b0:1f5:889c:3cbd with SMTP id
 adf61e73a8af0-2312050277emr89472637.35.1752165694709; 
 Thu, 10 Jul 2025 09:41:34 -0700 (PDT)
Received: from gromero0.. (189-47-46-41.dsl.telesp.net.br. [189.47.46.41])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74eb9f5c7f7sm2919119b3a.142.2025.07.10.09.41.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 09:41:34 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-arm@nongnu.org, richard.henderson@linaro.org, alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org,
	gustavo.romero@linaro.org
Subject: [PATCH v5 1/6] target/arm: Add the MECEn SCR_EL3 bit
Date: Thu, 10 Jul 2025 16:38:54 +0000
Message-Id: <20250710163858.1094780-2-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250710163858.1094780-1-gustavo.romero@linaro.org>
References: <20250710163858.1094780-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pg1-x531.google.com
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

The MECEn bit in SCR_EL3 enables access to the EL2 MECID registers from
EL2, so add it to the SCR mask list to use it later on.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index c8cf0ab417..0f64c7b163 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1717,6 +1717,7 @@ static inline void xpsr_write(CPUARMState *env, uint32_t val, uint32_t mask)
 #define SCR_TRNDR             (1ULL << 40)
 #define SCR_ENTP2             (1ULL << 41)
 #define SCR_GPF               (1ULL << 48)
+#define SCR_MECEN             (1ULL << 49)
 #define SCR_NSE               (1ULL << 62)
 
 /* Return the current FPSCR value.  */
-- 
2.34.1


