Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99ECCC3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 14:39:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJQv-0001lZ-59; Tue, 06 May 2025 10:38:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJPz-0000bo-2Y
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:37:12 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJPw-0001Cr-CK
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:37:10 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-39c13fa05ebso3595155f8f.0
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 07:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746542222; x=1747147022; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6XW5xHBO3SA/+mZJNPOxITj6/tX70uskRNb+p6Q8bM4=;
 b=RYFzugPd+JAX9FBQdupOrhLVJj6BLPgroVC4QuYGHj1MwScSCR/8VaxhG6OJYU0Msf
 pHbo8WNDAkeDW99psne4SxXvPdXlEtr9YCnikBNm3/0Djz3TPrjRDLyevt5zAyoK0jAZ
 yS5RFJePcTPwwRfz1IQUwOq5wBg2WHgw2xe7CiFdWQogo9HHdvgp4MArfeHZXcEf1jDU
 otirPhXYlVnXb16gCMC6i1QL19NVjha8Zhuxsc6wv5gUqgBsG1hKYY16l1Og6cKRAtsX
 O6s4yshko2uPE3gxXAdPs6SJvWcgf6388TczM9jJupfUAzARUyA3z2ywwyfszUu0RrbY
 zdyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746542222; x=1747147022;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6XW5xHBO3SA/+mZJNPOxITj6/tX70uskRNb+p6Q8bM4=;
 b=jZF3Bcg0K1waVG6wku/zOZL3jtufwbizwQb6DP/n/6u83N3uEd63SHYT/BfU8g+Lhb
 JJliZU5HNJMCgk8Zy2BHFVAuDyfwmZolXKIRdC0w/48QE+g6hVz88lfw62piM+kRukyU
 SqNvOCSN/TbzMsUMIdb1QTveKFY+sS36hCPU1/Tw1xgAAHatGkmp4ljklxhEz+VzomdK
 qDjNc/wENYrDbdZxNjmaYwfGYB3ra4+aZ6DLfex4fwh2YyjzF62+5NmydV4KbHY0xAqX
 xckwkyKwSQqgxEZr18qY75OFqGso/c9/170LJNgyFG3qQIQKpzxIZUdef5mct229Gei2
 Ntog==
X-Gm-Message-State: AOJu0YwOUGXwFYTktPPLoViqpL3eJrQi15tuHF8LMatVx2HeWaEzyG9q
 G0stEbMhs+GTf+ud3euL4GNQ41PIQiDQ3PiS1w7aSJGwTRzY136LMNMmV8lwrDcqrH1cCYB3u0l
 b
X-Gm-Gg: ASbGncuEyyxkLt3UJLzYmNwvH/w5K7KIrA/AjZJtxwZeHf2bIr7otIsH+NdLTyx50JT
 emG215YYU9aQ0589SqsMRJaX4QFlOD7Ld0sytODQFiOCNwKKMAhB4vcRnFxgMwNOS+jSvGuZ7Bd
 +rhkJypXV5JGJXz8G956YckKqquIA2lBqAMibC6/EZgt58glvn4RDvMYdteuy3wupjGmS85/qsg
 sEuhaFq4A0mfqNrNNO/iUX7tDZNv8WNtrTOFmNeTmYmX6hQcoJO7G43A5v0Bl+SO9uiPFKa1ifR
 6s1IgcDXlyhsCrCWjNx8Ri34J6VqvDzx2QhP9AQM5Jjvmz/x38Zqh+YVHC7Iwnbuz+epaEdryJR
 igPl+QKjCz9FR012wjA1M
X-Google-Smtp-Source: AGHT+IEA/O3UeOwrj+KOS5WHOwcW00MJEnP2JBKABRoxfMtJOGTuL/L+vRywczu9WgzGCPWUiByzZA==
X-Received: by 2002:a5d:4b0e:0:b0:3a0:b3f1:6edf with SMTP id
 ffacd0b85a97d-3a0b3f16ef1mr113668f8f.21.1746542222517; 
 Tue, 06 May 2025 07:37:02 -0700 (PDT)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099ae3b57sm14185821f8f.36.2025.05.06.07.37.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 May 2025 07:37:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 22/22] hw/isa/ich9: Remove stray empty comment
Date: Tue,  6 May 2025 16:35:11 +0200
Message-ID: <20250506143512.4315-23-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250506143512.4315-1-philmd@linaro.org>
References: <20250506143512.4315-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

From: Gustavo Romero <gustavo.romero@linaro.org>

Remove stray empty comment in IRQ routing function.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Message-ID: <20250504215639.54860-3-gustavo.romero@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/isa/lpc_ich9.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index 71afb45b631..304dffac322 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -182,7 +182,6 @@ static uint64_t ich9_cc_read(void *opaque, hwaddr addr,
 }
 
 /* IRQ routing */
-/* */
 static void ich9_lpc_rout(uint8_t pirq_rout, int *pic_irq, int *pic_dis)
 {
     *pic_irq = pirq_rout & ICH9_LPC_PIRQ_ROUT_MASK;
-- 
2.47.1


