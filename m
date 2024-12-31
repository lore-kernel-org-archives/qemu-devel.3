Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00645E77194
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2024 19:07:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tShZw-0004RZ-6T; Tue, 31 Dec 2024 14:06:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tShZr-0004QS-TD
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 14:06:52 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tShZp-000852-PN
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 14:06:50 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4361f796586so106522825e9.3
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2024 11:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735672007; x=1736276807; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b7UfBZMFotuOZuG+02/D0eezoHBGpYOKCSHoS+es9Cw=;
 b=J0TY4nxe6eF69xsSNjlY9N2pX7/ksjd9cPBzmJcAXyKh8agsKwbZwS1cncwlF8NzUk
 qRyNmPQ0sCOOQJsy7ag2iS56YSwNCkgXAHPFepoJ9MqWg9EEoJRcz9mb8KMl2TOiXkg9
 CIXjVfczFDzdiH8g1YfwooJ949qRrahOxI2Z4kuvc6J0Tl5Wm9m0tKghoZycWEL3z8uf
 wHVhzXvavxQknDqIz1lQpTXnymp4CjhThumh1ULvS6MY9D0c9rDUOvogy3IEKrVNWGWg
 It2RJcudLH2xAwPlazbePyB6yz9Asz+++GtQzHy9gP2M//MG76hXnSiTfYV2fMaMrRpf
 W1Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735672007; x=1736276807;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b7UfBZMFotuOZuG+02/D0eezoHBGpYOKCSHoS+es9Cw=;
 b=rhfBvV0fu8QreQKocG3+nRFT5Kpu9enB2FmmgNbYQCy8irPy0jDsqMsEL3AKvn2zuK
 v68UuU7UUzkixTeV7ooqKvl/aPoX5jPmQz62lalbfV4qEUkVaOzhco2KaEsD1Q2BCVxH
 9vn6AM0tMsj5uWlxZUNhLct1iWL+NycbLwGCZqyntXfFiBwZTN2g79RiiRNC0ce4vaTT
 mbR7I+19j7aDuxUEwVp58FrSdcme0d0kL8f+2tK+wrxhqgPbYNOLEMM4e/uHyuxqUFpV
 /0a72ji7t4MyFpIzOhoFIfF4VCfC7vfO43U3HVSBKTJ4yjGnHTiKo0B9OPx0i5CzOZSG
 xULA==
X-Gm-Message-State: AOJu0Yy8//RHK7JdIcRp1T/WFTbXLASOTPnewpXSd8uo7W904Otxih36
 lKnePTyx0PmJYsHC50HtLohU/psvt7QKUpUaxEZAs8CfpGeSEEfx4U+AsQuwRRTKvq4BmUY4YLh
 OD9A=
X-Gm-Gg: ASbGnctOR6F1J+Lgl7x2JLSPyxgnOBYVSfo8M/KOSvrMjPBV0RQSnT1az/JMfjhDdR/
 v+ca4/YMvQx9DDkfCFWwFzLEAfUVA1kVyTZT1lgytKw9XbpH7CCO/tS/v5/WBzBwaYH13QoGLFK
 jFL0Ns0j9W78K7keufcRdsD+hoLAjm3SSypRx5F0U3ZGQ1uJJOR61sUbpLDVJbQn9EJ03NjnKy7
 Epr7vBCJ/7rlpEZodh1xD3OUJoS5lWK0LBYmWcEVt8Gp7c99Seyn94e24/z113ROnIjcSX2iT8n
 1/c7157Qjb2nUFIQUMjOT+G9AFmyeUY=
X-Google-Smtp-Source: AGHT+IEwKWPJ76b1AZvTMdnlRWZemrNNTmBmLN8PbHrePgJ1PEhG/xUNqNI2nol6PRdjF7H/87gNNA==
X-Received: by 2002:a05:600c:1d07:b0:434:f739:7cd9 with SMTP id
 5b1f17b1804b1-4366854c049mr360717005e9.9.1735672007211; 
 Tue, 31 Dec 2024 11:06:47 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b0145csm432054725e9.15.2024.12.31.11.06.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 31 Dec 2024 11:06:46 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 5/6] target/hppa: Set PC on vCPU reset
Date: Tue, 31 Dec 2024 20:06:19 +0100
Message-ID: <20241231190620.24442-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241231190620.24442-1-philmd@linaro.org>
References: <20241231190620.24442-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

From: Helge Deller <deller@gmx.de>

On reset:

  "The CPU begins fetching instructions from address 0xf0000004.
   This address is in PDC space."

Switch vCPUs to 32-bit mode (PSW_W bit is not set) and start
execution at address 0xf0000004.

Signed-off-by: Helge Deller <deller@gmx.de>
Co-developed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/hppa/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index dbd46842841..7278b7ca6b5 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -205,6 +205,7 @@ static void hppa_cpu_reset_hold(Object *obj, ResetType type)
     }
     cs->exception_index = -1;
     cs->halted = 0;
+    cpu_set_pc(cs, 0xf0000004);
 
     memset(env, 0, offsetof(CPUHPPAState, end_reset_fields));
 
-- 
2.47.1


