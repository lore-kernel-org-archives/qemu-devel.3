Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 003F2C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 21:13:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZyXx-0000YA-3h; Thu, 10 Jul 2025 17:11:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uZyXl-0000U7-KS
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 17:11:02 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uZyXg-0006c7-PR
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 17:10:59 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-23dc5bcf49eso18862885ad.2
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 14:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752181855; x=1752786655; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vSHu2C6AHkdi6I2MI+MN+9VTwDs09gk+qY11owIPdS8=;
 b=ofyjf90Pg16wJUTe9NEO9WaOKWpdpYOn6/j/AkYngzHXeU+RC7Ipch0A2yYjEGSKVr
 BVmdBTQpk3R7eviHbjE0O74zw3DcDPirfj8i9Ovnfs6D1l462B5PvLLvaS0by4UlArcn
 jxyu5Snn1Tim77qmeZf8Z6aSaEJEqwGnViMa+GKYvIRjq4cYWWLsxNvvN2bLDTNCKhtT
 q7BdGq9ZWEnOxxdMPxJmPrtZuDxsX6Z+zUCjOUbW/W8kmB/aS7HzVwP39U4bdIkQHw/s
 RhR9GQv4Qjdcwvbgm2eComA/8W38tZGODzGdEvM780qDsbk/4fUAoUorBaRf1pKexlya
 UM+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752181855; x=1752786655;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vSHu2C6AHkdi6I2MI+MN+9VTwDs09gk+qY11owIPdS8=;
 b=FSvXJuilUS9eVPvaE0g3LpvHLVswCe5J058nIdXsU2S/AQiSzM4TT7Sh0HR6OwPL/e
 ymXjdovUhwu4D7NN7TZfisK8TG1fSZu6h8ihwdRouA6Y2ksv1yFbkAnkTf9ClYpLbT7d
 E/33h4mc8s689VOwuEG8DbeTalGGUttZU9gZGXS/+oHT2InGFrMJoLNZaiqRwJmLz/dx
 kMLUWV4T7II0WLVdbIObzL4MN869UPIaum0sJ314e8WAPk0+Apqf1hbHeXqv2EekPRT8
 OzbRIDF3DKN3OqnZFSWRHjoMK6PXJro8kwsl63sET/r4kbnim55nRIDyTk6K0seFIwyk
 R/Tw==
X-Gm-Message-State: AOJu0YxzB+gstfiiwX/tlYXFZLODlvVAgdVJv6b1A+ilVR1eObVkHZCG
 w9+GCCsZn149n/ccQl/11zaswJhHWlFzOLaeu60+VUNdbxVqpsmp8iAiAgUj2R58BxQW40Qefi+
 g4KClvGM=
X-Gm-Gg: ASbGncuzsSSOSOb0JLrzRyhUej6fNHoQpa4XUzJRZwrPcubnEON+5VcM8JqJUumOgmp
 Jzr9ouhUbIllz2vU9Cz0KjwlNEhL1p6m53RALva9cXl6mjcFCgaNLOhnYBgqZWy65n8DFFu5suB
 8pwNU9Vu7LaMnyqQhZdcy4W0vQ8Jeu1Keds3MMX3K8mwuZwuQ6xsr9CVXCiK8xZFJOumu0GQHVX
 KkniGm0BJ1UNKADgzzTQqIZVlpIiUHN5fy7tpmnw8rQso3KWmH+to7B5NY0VTN2iP8tyS0dD2mG
 z5qXCisgYamXi2dYIo+VbA0olHEk2axDneK4G07lYw2WKTmMSPeI9q7SFtAbxoMpFajFLS4G0MM
 5zaIMkYXGrln6j1/ABjdb07Xa2D+qUVxGLincylIZ4hGI4OiTAryUFYn4Kg==
X-Google-Smtp-Source: AGHT+IFjvy9s/b0/ogkYqDCs3lNQdLvnHAhV4Ukb9EsKXMqntoyQEQ+tOFyDtLocoOIiMfcaUX+vsQ==
X-Received: by 2002:a17:902:8b8b:b0:238:f2a:8893 with SMTP id
 d9443c01a7336-23dede984b9mr5877645ad.42.1752181855268; 
 Thu, 10 Jul 2025 14:10:55 -0700 (PDT)
Received: from gromero0.. (189-47-46-41.dsl.telesp.net.br. [189.47.46.41])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23de434d6b0sm30447775ad.203.2025.07.10.14.10.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 14:10:54 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-arm@nongnu.org, richard.henderson@linaro.org, alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org,
	gustavo.romero@linaro.org
Subject: [PATCH v6 1/6] target/arm: Add the MECEn SCR_EL3 bit
Date: Thu, 10 Jul 2025 21:09:36 +0000
Message-Id: <20250710210941.1098088-2-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250710210941.1098088-1-gustavo.romero@linaro.org>
References: <20250710210941.1098088-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x62a.google.com
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


