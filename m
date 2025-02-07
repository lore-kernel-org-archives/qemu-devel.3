Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA984C02196
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 21:08:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgVZA-0007lX-Ch; Fri, 07 Feb 2025 16:07:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tgVZ3-0007YA-G5
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 16:07:07 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tgVZ0-00023I-Sn
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 16:07:04 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-21ddab8800bso37027255ad.3
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 13:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738962421; x=1739567221; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fip2/rIH5+8K8AfzM9EeP9RZWJjgIQDR5WgBQOHzq8Y=;
 b=fa9WAsvGGYEwskdDBCBERC9CtbQo1Px5Ki0IH3U5+Ij16cda+9rgjHJLZWDnQUBVdo
 pIrIeviw2fjLICAwQO2+dtBVSFbIc45egRt7Js5VdJAgRVgCpENw8OY0cPQzLlkPvXqs
 cMguqJDeRb0Cy+CQGkSZjKXOrE7HHNmfUWySx7RJaxYNa4rAm+Jv7yLajZZq7k/eQiU7
 vIe6fFa+MM1C+lCvykBTtl95a2CgHPhDoT8fSNX2JmAsPpi9i7DKHEzWB/AUF8EBj453
 4fbU9Rzlnag0Kn4CyKhumNls8Yw4OJH6upH6Ykh4318avGmkJKbVwD8XEh8G37SGFBMV
 uVZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738962421; x=1739567221;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fip2/rIH5+8K8AfzM9EeP9RZWJjgIQDR5WgBQOHzq8Y=;
 b=TFt8u4lVyemM4j4y+UETuYL7dUTuQ6wqU0r94Pqkn8+dOYtFBcC5tpjIx45bPu1Cyl
 T0KY6XqYAOmQX4JP0WcYDvIBwrp/5veMQ5NNEdfII68rmPlSfhc+9u7Ik14omq4PU6O/
 ZQFakibyWZQwipO/UACfc4gDq7Y9NhSlsxvh4M2XciVxJMU1QjpwW1/rmDDdU/i/8YJV
 tYFgVGkMViybF3b+um2lUHW4Zb/0Na4RcH6eig4urInkQWv6+qmFaYc8ObgwttvWe9iy
 j2FXGdyObQSfNH5ajFEo1yHOytW/iWoXS8zdrZcMProDus/BT5UxpXOg3eud8uuTcGIs
 evMw==
X-Gm-Message-State: AOJu0YwQMSedz7QEk/f2P5d2b/me+loO3aDR6UPMk8usoLGhdH/joAR8
 /idURTJiQGMnexEHpCtTphfF2hdyQk9McERIemaCla59s3yIzaT1U03svUuY+7JVZ9R51iXoh4C
 S
X-Gm-Gg: ASbGncsOtdnGYHCB5+bSDxhGTSe3u5vNp+Jh3GxsX4yCXMEHea1x9WxbW/0i0E+PfRO
 6fRkLIbGwsWVA6V2NfWtK0nwWyQck3OQp1ei+w2q8ySbI18UJv8v/+AYCrx+2jAcflgyzlAyltM
 5BrUPNeXN5o5uBDq+jvbALVwFVeXbaXa5dSDuGUnoL6YsCTONkjBOwqiSTyaSB1/JTrp9cfX4Vj
 STMj53EViezcifs87scwvruFLogxn5mhXzIopPenWtSy9lqrbYL/mn8k3Aos1sRnSNxkeYWfKBB
 mex8L5Q13TexR2X5N989NMwtKb31Yu33iz36wJuKlS9Qwsc=
X-Google-Smtp-Source: AGHT+IGbTfeyEF8XvNAO/4wOHjq1NJ0sJaHKoweK3qPUpaHF578ZmeLCdmsapeYpTJ0Z5SMRn7A+Mw==
X-Received: by 2002:a17:903:32c7:b0:216:39fa:5cb4 with SMTP id
 d9443c01a7336-21f4e6ce13bmr83084215ad.25.1738962421506; 
 Fri, 07 Feb 2025 13:07:01 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ad51af64c1dsm3539043a12.52.2025.02.07.13.07.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 13:07:01 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mark.cave-ayland@ilande.co.uk, berrange@redhat.com,
 philmd@linaro.org, thuth@redhat.com
Subject: [PATCH v4 4/9] meson: Disallow 64-bit on 32-bit HVF/NVMM/WHPX
 emulation
Date: Fri,  7 Feb 2025 13:06:50 -0800
Message-ID: <20250207210655.16717-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250207210655.16717-1-richard.henderson@linaro.org>
References: <20250207210655.16717-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

Require a 64-bit host binary to spawn a 64-bit guest.

For HVF this is trivially true because macOS 11 dropped
support for 32-bit applications entirely.

For NVMM, NetBSD only enables nvmm on x86_64:
  http://cvsweb.netbsd.org/bsdweb.cgi/src/sys/dev/nvmm/Makefile?rev=1.1.6.2;content-type=text%2Fplain

For WHPX, we have already dropped support for 32-bit Windows.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 meson.build | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/meson.build b/meson.build
index 911955cfa8..85317cd63f 100644
--- a/meson.build
+++ b/meson.build
@@ -319,13 +319,11 @@ else
 endif
 accelerator_targets += { 'CONFIG_XEN': xen_targets }
 
-if cpu in ['aarch64']
+if cpu == 'aarch64'
   accelerator_targets += {
     'CONFIG_HVF': ['aarch64-softmmu']
   }
-endif
-
-if cpu in ['x86', 'x86_64']
+elif cpu == 'x86_64'
   accelerator_targets += {
     'CONFIG_HVF': ['x86_64-softmmu'],
     'CONFIG_NVMM': ['i386-softmmu', 'x86_64-softmmu'],
-- 
2.43.0


