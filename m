Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34E42C3600C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 00:00:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0UT5-0005kA-Rw; Thu, 03 Apr 2025 19:59:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UT3-0005am-6n
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 19:59:29 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UT1-0002Zk-8U
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 19:59:28 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-39149bccb69so1289865f8f.2
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 16:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743724765; x=1744329565; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fZ+iRFzlsz++4RFD9fl5KNYh6wELAyZ06jqDq2TXAd8=;
 b=wtHBVSDB8Ig+oxRV2b2bCTyaHdzDVvFzQ4KTQpJse/U0Tb4uOG+vdoXvwqV/SnETkY
 rOLWoUvlVR+KMaDHtNtwOuBgYdcdz1lbnD1ClBAymOyTgcm32t9Dsp+H2JYgSCJ23WVX
 vOK1vNJV2hLKhf4i/qp21ewGOPwxtIn3o9JAxvzHSYGsLtdEt1Uo/mXwS3n6Hm5GW9Hy
 JNvzDk3kB7JvSGaQagjhQAg12pzVCDeT3nhbultAmfMiRdhPFBDEwzy/tIL7Fto0i918
 b6T0bJsgf+VSyxR/m8weuHzkTo9isX2+VE6bt15iu/CMnxg8vul2u1gl20rSRnxOpryu
 VXnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743724765; x=1744329565;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fZ+iRFzlsz++4RFD9fl5KNYh6wELAyZ06jqDq2TXAd8=;
 b=sD77EtNsvlgR/PGD3Lc9vnpLb6gTiOeTU53KqSHtD2zjMGSLhJblhIbhL74wZOJ2Yh
 LkVpbm2NlY/BML7BT8OyMMt8KFfIJ+aK6tct5zk2zmiKZtOB15ngcPZrmBeNXCIQFxE9
 HDUL8NKkGouP365PohA54dZ3TEdcnkusbs7xTT+sq971xqiKJvUMkECHg9L/tivL0HSi
 0epHDIHGCa//3SMN04Kp9RR4io1SIU/SWhHhUWyM7CIKA/K6Aw1iNF3YFt3EO/7QnW+s
 i0tKDdFkBfSh9qNCVuXswsVb4Urzh98XQxx1E+y47S7lioxwhK2mUE0lKRFdXyAfD5qM
 qtVQ==
X-Gm-Message-State: AOJu0YzTRRQB3grvQiU/1Z/iSc2bDjj/tbUX1Hi01dFEANKykMe0I4eW
 t5f0oLdZaAossmr9YvSSn75C/P8TcatSuLoAAFGxc5GdnVfm72JpJS0ucosDZjctHutjnX/axEZ
 Q
X-Gm-Gg: ASbGncvRP16LrU38WTNE00yrv+oozalk3u5TBrKf1/KeMj5Taqo8J4trUfpdEIVs1Z1
 RaOtYynsbBXjddkGYAn8EpBEzVGDxHXwejIP8N//MqC/Fl2QZ9IgBufvAb0FLYQy/pXTuBHBmJk
 NmWZPJ/jG/ePP5LIqUVIv3ztm/hNdOO6KlgKnsF3zuDirgacQxppRetAr3BUCG1RGjmXQXDnVEh
 mPziMukTfO6FgKMc5zPvH/6Uyw6pFpzJeVBH7/SqeKaTkEB3MefQa4F492md9oWJbv4kB0ybDKZ
 2FUA5Gig9pTw3lL/6E1kbnkBBkdJ7/+bqLk+fMWhtuzXP4DseM2CD+TlIaAeLx7eb+WqIC6MO34
 H6g4s/okyQ4MyZFA1sAI=
X-Google-Smtp-Source: AGHT+IFDi4N6v091m/aVxYSW+ih2q0MZgSTv1p+Z1fu0gkZqLgTfx2YLZMDBMupadXdY9Hqwny6vyA==
X-Received: by 2002:a5d:648d:0:b0:39c:13fa:3eb with SMTP id
 ffacd0b85a97d-39cba9369bbmr904227f8f.39.1743724764991; 
 Thu, 03 Apr 2025 16:59:24 -0700 (PDT)
Received: from localhost.localdomain (184.170.88.92.rev.sfr.net.
 [92.88.170.184]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec1660bcesm34148735e9.10.2025.04.03.16.59.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 16:59:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [RFC PATCH-for-10.1 09/39] target/arm/cpregs: Include missing
 'target/arm/cpu.h' header
Date: Fri,  4 Apr 2025 01:57:51 +0200
Message-ID: <20250403235821.9909-10-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403235821.9909-1-philmd@linaro.org>
References: <20250403235821.9909-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

CPReadFn type definitions use the CPUARMState type, itself
declared in "cpu.h". Include this file in order to avoid when
refactoring headers:

  ../target/arm/cpregs.h:241:27: error: unknown type name 'CPUARMState'
  typedef uint64_t CPReadFn(CPUARMState *env, const ARMCPRegInfo *opaque);
                            ^

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/cpregs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index 2183de8eda6..c1a7ae37356 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -23,6 +23,7 @@
 
 #include "hw/registerfields.h"
 #include "target/arm/kvm-consts.h"
+#include "cpu.h"
 
 /*
  * ARMCPRegInfo type field bits:
-- 
2.47.1


