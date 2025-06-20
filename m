Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68DBEC7115B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 22:29:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSk4s-0001Tf-2r; Fri, 20 Jun 2025 18:19:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfb2-0007xI-Ld
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:32:12 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfb1-0006aZ-8d
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:32:12 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-451d6ade159so16811775e9.1
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 10:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750440729; x=1751045529; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p+T+2Jvew1IzQuyoS89TBpbUUpmO8FRMZ4WfKglS/Bs=;
 b=j5gk7RuYGJYk1P2AIjT/H8KUsrG8j5hrdNDKHDUqoSD1YrVCLoZSspb+w6sSoBL1tG
 YHVq9nReIM1KERAfdwCpUgkealMmYIhQ8icRACMU1hf2iDGC2TsIn50SFtbDLPMVp27P
 uTCJY8QyOLMwpAVE4JIWDhVEjdGC/zGf5Fq6K6NltzH2OxQKTNssTMMirdncSaeIChLU
 ouU0rDFVZgpMZotHvImYYOijX/vQMPl8hn37LFBsrAeiLckWW+w2yKYBBJ9YQ66l3XXp
 a+1oRf7TjOTsu7EN53kGSX1cYmsnFkf71vLx0/AUBVGkF4PXsuKEGbWofsObmGyc6OJL
 l9IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750440729; x=1751045529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p+T+2Jvew1IzQuyoS89TBpbUUpmO8FRMZ4WfKglS/Bs=;
 b=OVQt0xLDt6GXia7FhL74BfTZCwIzRx7aYo6foVaJ3YqKeXTV4n6C9I5rARx0RnJc77
 H43JzKBuY820XSCY/9fD2Fi6MQ9j00lJ2un1vHt5Vj0lSPCvng7WUPQXy/JVAFhGy0Op
 LtbFhu1va2cGJKKrL8Iu8+SVXpCZq8WMw6KOk9zHYRL489eYVmCMOTsM3F2NIlZ0+RRB
 UF8mHiH2XKH+IDRXZHzVPrkM4H0ZMYTz8z8ekF1UcmlAi2qfxEIK+863sci81f+2e8bk
 NlZFL8+b68bTdYBmKOqbO3J0z3Mwcwt3PcgLpVk3qdlqsAQpegucEKYZE5V0txIgAgch
 P4Gw==
X-Gm-Message-State: AOJu0Yyyl/b4MUIXuM9mfM4M1ONoC9k6Yml0a5jO7RsgUeAwpA/IBDO1
 ssk51CWRpPAs1bd7Isi/Q6OPF9slpSaBaEbnyHJ2vYWOEbw1/NbXg10JOsX4u9MuoE7TgQDG3AW
 oS6E93R+2eA==
X-Gm-Gg: ASbGnct90yG2Y7RK09brks1Dl5qFVFm65K7XHeQr619eCpwxeT2Xvd7hAkITZDejfbw
 CWO43kpki61WjXWKc6dFooDbpIo3StBn69dp8WJQ4Ou3QFa90PUhQ8gFtLuMgfB9E3wP0qVej+Z
 dRgwZ70pRHiNs8ll5qfSwIX7Kx7AMkj+KI+vrjj/zSHP2CYTCX4gD9focWRgwt9qOS/t1s/iSTe
 Du3NrVLTYViefYortE92G6fZYh5uKRyxKalhCMQY0+i9eH2ET+lrqVweutXeotSTm9x107+VOl9
 NHp8ZXgCVVgRubyZDKvyEf86+GhL8Dhx85sIbBj9/ArOL1sy2oa4SLfm0ldlzpiYP2U3qsh4TF0
 3DdXj9GoYUXnSLMAV9GjIjPGNE8LzBzEPBO9HD/Qil70XlgDbM4vHWiCB
X-Google-Smtp-Source: AGHT+IGUkY0v1ezvr682KvTMMK7ELOq2YTX096JUkmHJEsIBRpfyedSszGbntLIJyMOi2Vu71ZnZDA==
X-Received: by 2002:a05:600c:8b52:b0:453:62e9:125a with SMTP id
 5b1f17b1804b1-453655c60ffmr43295175e9.18.1750440729542; 
 Fri, 20 Jun 2025 10:32:09 -0700 (PDT)
Received: from localhost.localdomain
 (101.red-95-127-63.dynamicip.rima-tde.net. [95.127.63.101])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4535eac8e19sm65166385e9.21.2025.06.20.10.32.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 10:32:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Mark Burton <mburton@qti.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH RESEND 29/42] accel/split: Kludge qemu_tcg_mttcg_enabled()
Date: Fri, 20 Jun 2025 19:27:37 +0200
Message-ID: <20250620172751.94231-30-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620172751.94231-1-philmd@linaro.org>
References: <20250620172751.94231-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

../../accel/tcg/tcg-all.c:59:TCG_STATE: Object 0x600000c42740 is not an instance of type tcg-accel

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/tcg-all.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index f5920b5796e..96104915eef 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -61,6 +61,7 @@ DECLARE_INSTANCE_CHECKER(TCGState, TCG_STATE,
 #ifndef CONFIG_USER_ONLY
 bool qemu_tcg_mttcg_enabled(void)
 {
+    return true;
     TCGState *s = TCG_STATE(current_accel());
     return s->mttcg_enabled == ON_OFF_AUTO_ON;
 }
-- 
2.49.0


