Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2453BC5AD49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 09:53:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJUVW-0005UO-9P; Mon, 26 May 2025 05:52:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJUVU-0005Tz-AP
 for qemu-devel@nongnu.org; Mon, 26 May 2025 05:52:32 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJUVP-0006yo-Kn
 for qemu-devel@nongnu.org; Mon, 26 May 2025 05:52:31 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-445b11306abso12175425e9.3
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 02:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748253145; x=1748857945; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+N+6R4mxE88DrF4nsqdXA3gOxd8TGsgCLjFuvRBD91g=;
 b=ZPoFmJYpedaq9vAijkN/CfHCjLl4ghIdftqXkylbtgVP9a4hZDVSp6VL/R1kaP3gZw
 0qYP2lf5Cal/1rmbi7uoxJHh19vFD6n7BS5j9pDERWIt3dHo/QGTL7y7Po4whqP6ak4z
 FS3P8CPoQfEG33rsNIOPfFtInm1DW1PLOrLUnjQGSRWUKG/dXn6oBisH/OVt+WFh1PTb
 EpFiQmdCL0q+nGrfte6nCYTLAy4WqNWVk2BxzwOolzLERjb+aLXTlBMLUfG/oLN7VtVM
 QFry5QlnDk/+vM11nnkl+3JQf8C1/Y9FA8j/818PyBoC4o1cYK5OEsLUnFKg6kfYjydk
 JUsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748253145; x=1748857945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+N+6R4mxE88DrF4nsqdXA3gOxd8TGsgCLjFuvRBD91g=;
 b=J001NC6/ei6i7Y4u428DIJNTYbHBm2H0n4VSi8/xeo8r+VDwZynVuPBLypjUCBbWxs
 5YmS6UeKfL2a3Ew2cVXINec1urvXxA3M2zAWSs0GvYyedCD3dpN3hYoCVvGhjbExIlJF
 xs+JwGpjood+u+/51eH3PkkJTssiBQhOYWFkAF5ibS8jCGqWFO1nY8BhjsZCJodC6h8K
 BVTisUImClbb4TwJhVI65OGhcQOnB62BlC9+LEFrHd/e2J9+Fm4tLTPWShGLc0jBBkpB
 +8uWfTAzGOstoWt3CCYzBhRTCc2P4iGXksG1PjAcVkgfqX6XqkddAdzEE7kDcw9MHEk+
 ukFQ==
X-Gm-Message-State: AOJu0Yzy/oYXDFBYs0vS583Yw1e59d2GRNx681nRmEjvW39mVQs1VB14
 y1OGJrZgB84QkiIAb08ff+4N6g5xQ4YrXZ72CHTR3jIkKxF7AAJ1jwRibZN+dir5AUPbVqe3c3X
 mL/mE57uR/A==
X-Gm-Gg: ASbGncvi+Fwqk2apVMJrN8mspBMl9CrorSaIOShH7hTDnr/2I6c5HnjI1aq5SDmC3/4
 iAGZ6uKiGsGXK+uM2QFBtnzQv0p6JbQqXZ1ttjlqiuCy9WJNNRpow2sesumDNvTjEc9wqMi+YeB
 xOaXsg8KPd0xUXSzHIJKh8TNpRJTwASzn01AHYvwYIQ6UZCb2cdy5P+sOsyypJKOQwjr+hYnDdj
 UQGx1quNLYR5n8yuw18ao5YnDAmWI4/zgFSi4SPVt5bowze+anENV8POnuONUz1jqdhqZseinZj
 C/qaDoASfyeKmglgO15RTBresGO48rP8hnGk0m8PfNkDvbCWdeckkPwxy9ScFKNahcdxOVvxm8Q
 CPczPVU7xd8Kh13lNAICV8VXhjMnsrCM=
X-Google-Smtp-Source: AGHT+IEgIhLEF5fFxpFMlSo6xHRUsOK/uJLoMyguUaKR4sUaiu8C0jjP8ERZCoKlWhhPNbpw4DZAqw==
X-Received: by 2002:a05:600c:4714:b0:43d:26e3:f2f6 with SMTP id
 5b1f17b1804b1-44c93016592mr56305725e9.5.1748253145279; 
 Mon, 26 May 2025 02:52:25 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f7d9bde0sm231245515e9.40.2025.05.26.02.52.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 May 2025 02:52:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 2/2] semihosting/uaccess: Compile once
Date: Mon, 26 May 2025 11:52:13 +0200
Message-ID: <20250526095213.14113-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250526095213.14113-1-philmd@linaro.org>
References: <20250526095213.14113-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 semihosting/meson.build | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/semihosting/meson.build b/semihosting/meson.build
index f3d38dda91d..b1ab2506c6e 100644
--- a/semihosting/meson.build
+++ b/semihosting/meson.build
@@ -3,15 +3,12 @@ specific_ss.add(when: 'CONFIG_SEMIHOSTING', if_true: files(
   'syscalls.c',
 ))
 
-specific_ss.add(when: ['CONFIG_SEMIHOSTING', 'CONFIG_SYSTEM_ONLY'], if_true: files(
-  'uaccess.c',
-))
-
 common_ss.add(when: 'CONFIG_SEMIHOSTING', if_false: files('stubs-all.c'))
 user_ss.add(when: 'CONFIG_SEMIHOSTING', if_true: files('user.c'))
 system_ss.add(when: 'CONFIG_SEMIHOSTING', if_true: files(
   'config.c',
   'console.c',
+  'uaccess.c',
 ), if_false: files(
   'stubs-system.c',
 ))
-- 
2.47.1


