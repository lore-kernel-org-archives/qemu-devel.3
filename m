Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 246A8C48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 18:04:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rag5L-0001vC-Pk; Thu, 15 Feb 2024 13:03:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag4m-0008Vr-4a
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 13:03:17 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag4c-00031Z-S8
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 13:03:08 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a3d159220c7so149194566b.2
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 10:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708020180; x=1708624980; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WEJdbRYZWg5QsSQgBLhE630AfThAxul3xJqfLIQC7T0=;
 b=HIzhCUfMFArrAr7NvD/9RyU6GhxskXXZoCtFNqoHVtaT6XXrMGsK3mDO0ekDRDM60j
 XENZGajeUlsM3VCkdCmPdP3QhQo0ytlSK2QgRsjTdDqphr6QXgxooERi6F2lHULnzz3t
 1KbBnaY9966R8nIWs82Delc2n2dq/J+PSdS87bMOiHYnf/qC1s7+j0f3/shCg6ovWwkN
 b4t/9xgs4vMK7OecEM/EgxfiDZ4ItCMWOUFn86rM7GaSLVDySUSrEfZZybBsPmoja1zn
 7rb2SU1mSazmWwnzsxPQ5LjBSogmSmv2RiycOukpxHSK0oQDgxcjHaPINWyVX9g5U1pr
 HMbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708020180; x=1708624980;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WEJdbRYZWg5QsSQgBLhE630AfThAxul3xJqfLIQC7T0=;
 b=CJkCT8B1NPuAz7s0MmMMdzee0LCaCW9zK2Gb2XnEFBQYS6okCPVebWp83KMZFYm0U5
 liiVpY0SSM4Kq1NSU3XdhSrP4N10koRRM2dRBMvtyS4ouNxA0WQ5xs7WnyS04YFo3JlQ
 rV9kXWKQk862j1aSjyqcOwCv9w6H4dem4CAX7NrbmVTF+U4fOm7fe55yxsvqsmPmrc2x
 WENoid2d3WYPMHn+fvrPZmjXWgejUKqxBKp+KX6WxfABhJ491LBRNLH85ujEO1Q9otC8
 Obigv38CHQsD220O7zt1Jr+lI5vkM/ZY6LWOFn8HMMRPCDE+lqkWMY5b8hSYdFtoh+jL
 vMrw==
X-Gm-Message-State: AOJu0Yyapzazj+6Rh9FDzbx/IRuCp/BB+RR9EbWv5Wmr/2/WBtH7KuRH
 ulolyZihOhy2Ma8245adDxYIbGo3vLc8QwQDJ4Xtne681zuVlWicp0JqREeA2jtcB6fztJMpTC4
 SyQ4=
X-Google-Smtp-Source: AGHT+IG2+R98jU0XayLaSJJLttWHqTfuRB4b2o+ZdYa1vSDxbEvUr90lfj5k7l9wYK1PXl7fdRddBw==
X-Received: by 2002:a17:906:3c18:b0:a3c:ea61:9359 with SMTP id
 h24-20020a1709063c1800b00a3cea619359mr1621901ejg.77.1708020179824; 
 Thu, 15 Feb 2024 10:02:59 -0800 (PST)
Received: from m1x-phil.lan ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 lj8-20020a170907188800b00a3dbc39a376sm190751ejc.52.2024.02.15.10.02.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Feb 2024 10:02:59 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 45/56] MAINTAINERS: Add myself as reviewer for TCG Plugins
Date: Thu, 15 Feb 2024 18:57:39 +0100
Message-ID: <20240215175752.82828-46-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240215175752.82828-1-philmd@linaro.org>
References: <20240215175752.82828-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20240118032400.3762658-14-pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0ab73b265a..6c19ea41d1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3706,6 +3706,7 @@ TCG Plugins
 M: Alex Bennée <alex.bennee@linaro.org>
 R: Alexandre Iooss <erdnaxe@crans.org>
 R: Mahmoud Mandour <ma.mandourr@gmail.com>
+R: Pierrick Bouvier <pierrick.bouvier@linaro.org>
 S: Maintained
 F: docs/devel/tcg-plugins.rst
 F: plugins/
-- 
2.41.0


