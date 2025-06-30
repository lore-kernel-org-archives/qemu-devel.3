Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA687C7EE2A
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 04:34:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uW6Cj-0004Wf-I6; Mon, 30 Jun 2025 00:33:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uW6Cc-0004UZ-9B
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 00:33:10 -0400
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uW6CU-00053t-Du
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 00:33:04 -0400
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-4a58ba6c945so29157981cf.2
 for <qemu-devel@nongnu.org>; Sun, 29 Jun 2025 21:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751257981; x=1751862781; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NElkJwQRf1CyYZ1pLfGMEkRff1YKnUUmnNhqdv4yZE4=;
 b=iuxfAfzs7q3dQts3Y2Jz7aFBUJMIZSSY9613x1t8miYCqXKHjE2QhZGHSNsScYJh8M
 6vnebPDqqM5Nh/TVt53SFRhmyqVuPKDIQFAEJJDT8pl41YmvUY0h7F0QHTZIMXwQkmFZ
 nHzqqLqDSgHwj4L9Oac0cdq5tP01THUICvDcFRM2CsGb0H4EJn3eS56cNWKGVcjwOH4H
 YuIHh3kcrHVfw/eCoFWdNzIk2D8lx7YLj3OUKgal6NWlcM7LNrF/k1zppKuvaMiEu5iw
 kodt3uKQj6dxhdYrEl3wZp1DHkidkm7VgBikrtk6FxRR3k2uScgh3nRSinvtYNhXJvv6
 sUSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751257981; x=1751862781;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NElkJwQRf1CyYZ1pLfGMEkRff1YKnUUmnNhqdv4yZE4=;
 b=r2Ckvfjs2dJRjmGIAN0GwcfqvJDiYza3fK/S8ggI+sPY8yEyWfdEP+SxQB3TeFJDQ9
 Z/IRhp+wNh/p3BC6VbGCJglxLqaKOhr1jNchWqlKtPGnnI39eLO1fbGKcPHpLumsHaUT
 4ddn2Y2u3fEcQTeiOF+UrVbo1u8gD7OwQbpZurtd3ahwcQqx2tZq71diP8D5REoSmNgf
 g2VdzOtlmO8CSXhOPMVNHQA91W8mlixEscoM9qe57t9OgdWznuwcoO/n5bDoCl4W/ux7
 mmd2ovPLUkZ/pHZE0OTvek9zK2pyJHSSAGtZ8c6VpveWGq/R64HelpM26faPN1C2jxmx
 ECMg==
X-Gm-Message-State: AOJu0YzT344ZH5MXH3v5Nsj5YCgW0CVFu1uEXBplP9ML2XW0J53udCtS
 XpPJl6sluso5LzhdGB5KS8TkmexkglTE8Q5ufzJlFJX/OC0+iVNULJ6pR0YDaAaXFP2H1Yiy5d9
 sSb4N
X-Gm-Gg: ASbGncs3eo8IAI8/c/nIKjZ3Yvyahb+H9dUZxu8fH39ZgZXV/pWb9PFa54ggn7R+AvG
 Ircx8MECtx5PAScaNOR8/tTruMBSkMmL8cPFGYf5xip8crATyoz9YYmqS7DQWPqyfk5mz7s01vH
 yidnCIR2Vg7oCjIKaWOmWqnVaFsBNFQnRrMH0MqFu/KjNuujeZ7pwXCm6DJ7V7Cx6NXyR9c7pi7
 L6j8S7iIq+Oh2v6oIEWMA+VsUPtOVqub58G/n6e9tvECibIqGsJFFj+NAPixxGMNIFSHgFh5wPi
 XLiOiJInadu5Y9mBd+O1w19LLYJz6tmHQbtkajA+ZpuwGFEU81OIk7u0dMA79UcIkho=
X-Google-Smtp-Source: AGHT+IHVfyDFenWheXr6gxrFqO5swCx1BFaOdEsGs+vJnNU4yAPok30BqXoy6P++i6BxgdOU9F1tLA==
X-Received: by 2002:ac8:7d0d:0:b0:476:95dd:521c with SMTP id
 d75a77b69052e-4a814226439mr58055621cf.45.1751257980989; 
 Sun, 29 Jun 2025 21:33:00 -0700 (PDT)
Received: from gromero0.. ([186.215.58.88]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a7fc13971fsm53470171cf.20.2025.06.29.21.32.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Jun 2025 21:33:00 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, gustavo.romero@linaro.org
Subject: [PATCH 1/3] target/arm: Add the MECEn SCR_EL3 bit
Date: Mon, 30 Jun 2025 04:32:35 +0000
Message-Id: <20250630043237.996788-2-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250630043237.996788-1-gustavo.romero@linaro.org>
References: <20250630043237.996788-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82d;
 envelope-from=gustavo.romero@linaro.org; helo=mail-qt1-x82d.google.com
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

The MECEn bit in SCR_EL3 enables access to the EL2 MECID registers from
EL2, so add it to the SCR mask list to use it later on.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 target/arm/cpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 302c24e232..8ce30ca857 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1683,6 +1683,7 @@ static inline void xpsr_write(CPUARMState *env, uint32_t val, uint32_t mask)
 #define SCR_TRNDR             (1ULL << 40)
 #define SCR_ENTP2             (1ULL << 41)
 #define SCR_GPF               (1ULL << 48)
+#define SCR_MECEN             (1ULL << 49)
 #define SCR_NSE               (1ULL << 62)
 
 /* Return the current FPSCR value.  */
-- 
2.34.1


