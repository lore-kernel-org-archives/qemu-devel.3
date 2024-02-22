Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A154C5478C
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 20:49:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdFvh-0000Bu-9L; Thu, 22 Feb 2024 15:44:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdFvf-0008U3-Kn
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 15:44:27 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdFvc-0002pq-1M
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 15:44:27 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1dc5d0162bcso613605ad.0
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 12:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708634663; x=1709239463; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KYeT1V/wjgovpdrb0SONHx5NJHYkyLqzQDA/KKTsreA=;
 b=QI42+2rj+7GidUYbORxEOjUYcCvca6yba9mtOkpm4TIhiDR/A+IPE/EAmnKUMw47Y2
 IFF0bOYlGd0xVssNDAo+7hcGY87ceNdm3lvaPWIEDyVP+mQhw/JLSto0F6s9m/QVeTmF
 d2+c90ZuGfcSwGv5htTHoeQxEmJfQHGcOn9l3nH2fQdUP6/jBR21PM671bpf1VsAzs+M
 HEMXWhKVuFh6Ntns0RxFzfEFCXHb48bkCnM5/mdp05sWRvi0n+ldL8RgSOaSkQFgYNLO
 jfn4pzGUUJ2v/o3J0R8jZAedHH2yWuy4Hx61ZgElht6dJg80Zhme+2pwgfrK+mesHq7W
 Y5Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708634663; x=1709239463;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KYeT1V/wjgovpdrb0SONHx5NJHYkyLqzQDA/KKTsreA=;
 b=X3bC1pbOScLhCTbKo7mMZfC426DgI93tjlj7gLnlSr5wQVgIX8UDy1h3cOaOIYhjIq
 LXFWosbSdAYPu1Rds/xIIe20WJsjj+gy0fGBgXqqg73x6QjRjFRYVByszSVLpf0TTwlj
 S7JvAKMf6k98KCVr49yG5Jd78UFrc3r0usoG/qIj5eaapWbPmkc50q9YiKVCT2TDse5f
 yAv47R4HDbYWuuwhFMWM3jstlPniq1rWvKvMT1sQ1du883OW7jYTCDscY840hWkbWMYb
 XbibqYAK/gsT3GZeJ2FerQ9/G07ipeLwSAAACqVeeQvdtnpwsNxIcEx77iCAqjjetxiB
 QPVA==
X-Gm-Message-State: AOJu0YyZgVw8mBZApzHBCsReAag0nzGBLJ+LDO4Ko4C/CLghAK4zdiRw
 32UtbvO2EY+xK1Is8u4Iv3aet8fzRQNZm7hA8Ypr83p76Fzg01yZ4igeEtolg8DuYyLwnezK4Bm
 r
X-Google-Smtp-Source: AGHT+IG4megIkJ/DOoXf3Swsa/+1KpgVYZ2p24cETZIU/FgFKa+qM2MtubqK6bETL4ILS90GdrccSQ==
X-Received: by 2002:a17:902:6f10:b0:1db:9fa4:c770 with SMTP id
 w16-20020a1709026f1000b001db9fa4c770mr14920062plk.34.1708634662870; 
 Thu, 22 Feb 2024 12:44:22 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 l12-20020a170902d34c00b001d8f81ecebesm10275500plk.192.2024.02.22.12.44.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 12:44:22 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Helge Deller <deller@gmx.de>
Subject: [PULL 37/39] target/ppc: Enable TARGET_PAGE_BITS_VARY for user-only
Date: Thu, 22 Feb 2024 10:43:21 -1000
Message-Id: <20240222204323.268539-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222204323.268539-1-richard.henderson@linaro.org>
References: <20240222204323.268539-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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


