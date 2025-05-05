Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4AA2C3ABAC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 01:57:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBl1W-0005lL-2K; Sun, 04 May 2025 21:53:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl11-000481-Uk
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:53:08 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl0y-0002fc-RT
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:53:07 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7376dd56eccso4378519b3a.0
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 18:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746409983; x=1747014783; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iyeC1dYqzIyRbq0U6QJpnfGNVlqEyh7oNHL1QwbMptA=;
 b=zrOEmSxYj6vHRjSVlC7KXHHNUdDpjqLjxbon28NcmqRq2BlXhnz0xUzwiQAe3LGROz
 NyJ1To49t5SFDKO6IEq4oHmHzVcB+FgKvO79mKeX43LXrpFZtKt8dXv2FOEqd6pfUrAU
 Bw1m4GU1i5C18ie2N7dcul+DAd/JZjXm8npB9z6pkZaSqwo44EwB2Gr8b3H56JyBCo0g
 jvUWlJ8tTaOie0Q6Ovc8rOglbT7or9EOvebgdTnHtqkCTRdb2hNzjE+TbLuYQ5WIRClx
 xHNNC2M6jBxJxM/7C+zCdoMSdOW+3RLpya1sLC2NJgptZdpHd1sm8jfK6iHZtJdcn3jV
 voeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746409983; x=1747014783;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iyeC1dYqzIyRbq0U6QJpnfGNVlqEyh7oNHL1QwbMptA=;
 b=v1Akvqi6yOtnHs9MjBHMCuKYTC3KR43/+jDUB46CQNAVbdDtgXH/rk0iH3KK0JUipM
 IFltxVKxD4eApDB2fRNbQcxOpJpQvAWdsEsjo6cxEC7NJ7jiLgFRN/yd+vSVBopM3k6a
 eYvJOJEpH6MsroPfbc8LqcEoR5PYdr9GhP1SELw+6XO55eqjgRW8skho102PdeqCXkUM
 oQM5E02Ufi3t83//q51jOkVoL+P+/6Ykk3sVI/kwZM+kaUR8fgsGjNK2aceUz+RJFbRL
 fWlljT6cJ3l3nlENCgAVy1xSV52EjTXj1zOz9ESDuawbqGgyUmU8Abs+yhns5P76e/6G
 XxJA==
X-Gm-Message-State: AOJu0Yx/MYaXcs8XnmLVlty9Xq7FD0Am8e19maTrbTUHKhS6+djosSKB
 yPs9k7JRGyAhCDZso9wfYlw5FcyzgQH6bjPkOf5Th4PUVeHnMveUlyQdxaR/J2JRBU7xAaqDFSq
 ST8s=
X-Gm-Gg: ASbGncuC8Je29ezqCHfaRaGFzs77KsCeNDmdzEnUb+E3QjxSDGM74ld+kiFlLled3zG
 DNG6uoygfULYmaXeHcgGUU9xrUMlXKq7aw69dR832WFjr7IkbFiikai6Kg+qO/GlAS3stwppmK4
 DUE1SORx59aOx5B9HGN2R5gKU1AYPmPjFUhmnhecMXHZmtd19HncMvEg/4W8KEFRF5YKI5dAOIA
 nsJO/zkwF4PgnvJR76hiKNvWjxDd1HfeCotpcBm2IpJrinr1a+Icw522ojddHjQaPoM3Uht+m7O
 hbozFaequeZVN+ttS0ua9oSk1JbxE7mXwq41Yi5W
X-Google-Smtp-Source: AGHT+IEGCmE06PM830ZmSDQRZ5/eVfg6TQfwRHwBXfC+nvoumfTt9BR5P8zxI964fF7NFvhtkt5Slw==
X-Received: by 2002:a05:6a20:c995:b0:1f5:8153:9407 with SMTP id
 adf61e73a8af0-20e96ae202cmr7538720637.20.1746409982788; 
 Sun, 04 May 2025 18:53:02 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b1fb3920074sm4462101a12.11.2025.05.04.18.53.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 18:53:02 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>, anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 37/48] target/arm/machine: remove TARGET_AARCH64 from
 migration state
Date: Sun,  4 May 2025 18:52:12 -0700
Message-ID: <20250505015223.3895275-38-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
References: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42d.google.com
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

This exposes two new subsections for arm: vmstate_sve and vmstate_za.
Those sections have a ".needed" callback, which already allow to skip
them when not needed.

vmstate_sve .needed is checking cpu_isar_feature(aa64_sve, cpu).
vmstate_za .needed is checking ZA flag in cpu->env.svcr.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/machine.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/target/arm/machine.c b/target/arm/machine.c
index f7956898fa1..868246a98c0 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -241,7 +241,6 @@ static const VMStateDescription vmstate_iwmmxt = {
     }
 };
 
-#ifdef TARGET_AARCH64
 /* The expression ARM_MAX_VQ - 2 is 0 for pure AArch32 build,
  * and ARMPredicateReg is actively empty.  This triggers errors
  * in the expansion of the VMSTATE macros.
@@ -321,7 +320,6 @@ static const VMStateDescription vmstate_za = {
         VMSTATE_END_OF_LIST()
     }
 };
-#endif /* AARCH64 */
 
 static bool serror_needed(void *opaque)
 {
@@ -1102,10 +1100,8 @@ const VMStateDescription vmstate_arm_cpu = {
         &vmstate_pmsav7,
         &vmstate_pmsav8,
         &vmstate_m_security,
-#ifdef TARGET_AARCH64
         &vmstate_sve,
         &vmstate_za,
-#endif
         &vmstate_serror,
         &vmstate_irq_line_state,
         &vmstate_wfxt_timer,
-- 
2.47.2


