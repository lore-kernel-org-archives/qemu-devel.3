Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F60BE87834
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 15:07:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnI0G-0000S0-9v; Tue, 03 Feb 2026 10:07:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnI0E-0000Rh-QU
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:07:42 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnI0C-0002S3-VN
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:07:42 -0500
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-4801bc32725so44396565e9.0
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 07:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770131259; x=1770736059; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IIzLo099sN0zLD6WkV6sS2hjdaNXBnyFWYmlkZWjZxc=;
 b=pfJL6xAA56I01iC9Pk0jJMUD7iFDyVg2Z7ZpgdpbO8dzToOSyhPPsnniWjXLz3BoHb
 YrqN72zpbs169kAv5onfgko7+1hd7Ubdm4F0m9R2Gl3UrRUcN4dKjfM8WFoW6AO2iLU7
 9U6MF/EQKcMtnRhcF4LpEN9hDo+Rp2eQbEPrtS8ip25uOrDFvAJtpVkYoa52Pk/HY+Tj
 zoNAzTp2qJ9FOj14HK75lquyCVf6HSN+MPuKpowxkmc0P3P+YYEwimajzxWDlOfp+MGO
 fATNqzBTj25d6oRrS1X7oaGlN0TS6UdJNsJgpyEQwuSihzmGAG++a98G5ygi56Rd87qf
 Uppw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770131259; x=1770736059;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=IIzLo099sN0zLD6WkV6sS2hjdaNXBnyFWYmlkZWjZxc=;
 b=lTsMIVzoL8QhioU1ODA5RRxGY2Ew6vSoPrBKDFaiAdR+Y+t2Cmf+TwV/mukAMnzMBg
 bzKqaZidbb9ng+0fR3PuqzU6+8lKAl6V7L8Y5Z5WLb0TsO73ZlTNnzMxSA80Gx+D3raN
 oAPdqjrrAWUwWOZgtETewkhEEQegAZVevi047sCl4a6cHhVIQqApFSauahWc9N03WGbU
 bT4FnC7ImTdZwmjHmder1BF6jrNbwchwyG54XdYwIFQvGZhqL7/RzMFyvA6RtFyQGMFJ
 69//eBKkdJSXqb0d21i6ypSOffWW4A+7TydVLXPIy6QD4lSD2vZMIXsMMkx+JMf9bUyx
 l0jw==
X-Gm-Message-State: AOJu0YwO/sxioyV0+EGr18JZxYkaSUfW9IYmFRhW2knE8MeJEcn9FH7H
 9xzJ8kEz4JLTMQ5FCxNNyn6LzaQPdUT4y7vhH4jdJoBhpEWscY3riwUnx7NCjTRdkDACdKhy5G3
 OdZA2SQM=
X-Gm-Gg: AZuq6aIxp+wxse9ujyyrKEOLNjYEPF/0TRxbERKtvaazVa0UiogWAOk/j5nt55pyHtL
 egeJEjdfMUm2mnn9WHu991XC+t/Vg3UjGGjT1Wzoi302gef/Z3khv4OD4u3UXJhXrp77wZQSPa/
 Oyf/mwIWO6v2k+iNpK69Z5MjZypehUbw0DAyLKsatkXTqsy9PlmYXW3w4lefT9ChbZvBoPkhIrF
 4ZnXWMOgdv6me6pJl2nz4XnCIPIU5gOzN8AKa3l4es+Dca1g0DpNR8nvZ7BGcuSBKMeMD6JrG0h
 yORATGYSWG0QmBE2KEAXhAuhzthqc4PsdNJdX/FjV3gHVgRx3LI77NKRBd7qcAQ/Z+5AOE7TkE0
 ldaUPlcqlYsqvmMMBnWExsRqTUiey+U2zdZs4PuIW+CJKq4AfeWPuubSijl5XYLAiKjdPFDFfTq
 lsgUfJrtQ5iUtoLJnR4ssZJ04U6quceODqGTiCsmH66VCL4Ee838Em9Qe5dryd
X-Received: by 2002:a05:600c:3ba3:b0:46e:4586:57e4 with SMTP id
 5b1f17b1804b1-482db49228cmr243053595e9.24.1770131258652; 
 Tue, 03 Feb 2026 07:07:38 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48305153842sm73705515e9.10.2026.02.03.07.07.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Feb 2026 07:07:38 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/30] target/arm: Have is_64() take a const @env argument
Date: Tue,  3 Feb 2026 16:04:31 +0100
Message-ID: <20260203150436.71907-27-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203150436.71907-1-philmd@linaro.org>
References: <20260203150436.71907-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x341.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

is_64() only access @env read-only, make it const.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260202222412.24923-4-philmd@linaro.org>
---
 target/arm/cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index d4a146b4202..40237168419 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1345,7 +1345,7 @@ uint32_t sve_vqm1_for_el_sm(CPUARMState *env, int el, bool sm);
 /* Likewise, but using @sm = PSTATE.SM. */
 uint32_t sve_vqm1_for_el(CPUARMState *env, int el);
 
-static inline bool is_a64(CPUARMState *env)
+static inline bool is_a64(const CPUARMState *env)
 {
     return env->aarch64;
 }
-- 
2.52.0


