Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22A7FC48BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 06:24:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raV7U-0003Ek-GY; Thu, 15 Feb 2024 01:21:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1raV7S-000399-75
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 01:21:14 -0500
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1raV7Q-0005cP-Eg
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 01:21:13 -0500
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-5c6bd3100fcso366417a12.3
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 22:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707978071; x=1708582871; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KYeT1V/wjgovpdrb0SONHx5NJHYkyLqzQDA/KKTsreA=;
 b=KAar5FC8e9We9YfaelMA8tDRcPvZrvRLb91Q7YnxlfG21E82bxIs0aT1KYJaPJfexu
 8+Ujq92RpoW+TxTuTqANBiMVA2ym7gryIL9x6jS9tY8t/yTGi/rJ72OVgy6nApq33cik
 mhVgpL+oCin0KctKIhlVJmmw3OWh1exiJcIMZDT9ue7rIfRblvQNSrpY9Dutg6hOWuKa
 l3V0yPqPUvnRKqTH6CGTQXjYLTyvSTPqvgb+yryCSGMJvOajF/uC3UOvMF7nFC5ZXyNl
 ukaNLAtsUNbrnS0mpZNMComLlo+hSuCTwZdSDL2HE7J4T6wqoUCEwwqS2Ec9joytFV69
 7Zfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707978071; x=1708582871;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KYeT1V/wjgovpdrb0SONHx5NJHYkyLqzQDA/KKTsreA=;
 b=bpcCsqGA37z1AMmG0FcWUgOoSVruRKvJMak9DYD+7zzo4MzwEz3M8kpaprOmWQb+Mz
 GXllTzknm3vKqiuWdFXKe0WeGCNo8QMFQDP565P2UzDc+xEyPHYgcI31aWWMGDNdn3Ci
 juwoPIXp1npNuVVMxUaWx4gtNb1D4iNQDdKZsbFY4DjtQy3oslF/b8yw2f/g1kOXnwj7
 +QdMgCbvuD7xJzH9VtIUXprqQ5CPlr9C8IsYsJJ9UmxZZD1yEvffq9KBWNjhYRwxUzp2
 mkm+OdcHLUHfC0nkoRKEKucCL1Vnr8xMQpZgxFAEHEU6z1DbwIFGcj1fqrOMMLxELbi9
 z+KA==
X-Gm-Message-State: AOJu0YzLxfnYOO2p6cmg8JuHO7dJzRZaW6xkOWhRo8z44Pkz+Ywd1RmQ
 AP51DVZHtpTITo1U7Io+hMz/sbQNFz7F0MdQKi3x2yqlNWAxnF708Pr3gAom2dGwYUYnwVvc3oX
 c
X-Google-Smtp-Source: AGHT+IEcFwrTySXHEPBzoFN3QXP7ciY96FfYsMTAFNXShFtVdL+Wd07a3AVq+6UvkCrZPdc7dllnrQ==
X-Received: by 2002:a17:90a:cc12:b0:298:a449:d3d0 with SMTP id
 b18-20020a17090acc1200b00298a449d3d0mr697976pju.47.1707978070971; 
 Wed, 14 Feb 2024 22:21:10 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 d5-20020a170902b70500b001d6f29c12f7sm464418pls.135.2024.02.14.22.21.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 22:21:10 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Helge Deller <deller@gmx.de>
Subject: [PATCH v4 34/36] target/ppc: Enable TARGET_PAGE_BITS_VARY for
 user-only
Date: Wed, 14 Feb 2024 20:20:16 -1000
Message-Id: <20240215062018.795056-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215062018.795056-1-richard.henderson@linaro.org>
References: <20240215062018.795056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Since ppc binaries are generally built for multiple
page sizes, it is trivial to allow the page size to vary.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Acked-by: Helge Deller <deller@gmx.de>
Message-Id: <20240102015808.132373-33-richard.henderson@linaro.org>
---
 target/ppc/cpu-param.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/target/ppc/cpu-param.h b/target/ppc/cpu-param.h
index 0a0416e0a8..b7ad52de03 100644
--- a/target/ppc/cpu-param.h
+++ b/target/ppc/cpu-param.h
@@ -31,6 +31,13 @@
 # define TARGET_PHYS_ADDR_SPACE_BITS 36
 # define TARGET_VIRT_ADDR_SPACE_BITS 32
 #endif
-#define TARGET_PAGE_BITS 12
+
+#ifdef CONFIG_USER_ONLY
+/* Allow user-only to vary page size from 4k */
+# define TARGET_PAGE_BITS_VARY
+# define TARGET_PAGE_BITS_MIN 12
+#else
+# define TARGET_PAGE_BITS 12
+#endif
 
 #endif
-- 
2.34.1


