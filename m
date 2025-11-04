Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9918CCFA07
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 16:10:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGJbb-0006gd-2I; Tue, 04 Nov 2025 11:10:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vGJbV-0006fq-JH
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 11:09:55 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vGJbT-0007K4-Vm
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 11:09:53 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4711810948aso40756635e9.2
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 08:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762272590; x=1762877390; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a5F/yooW6pnu1OikcO4nD2DRUAh0kt3jpTBeUpOiYpU=;
 b=MMT/Q89QumS+f5WQ5BFCaDFRYjZZ7DhFlAWwehxr9Uhp3s1xgPxu7Xe/y5ztttuXI5
 3A4ENITMMjIJ9QjWDrnxz+BpXjccoUtCaJ9I/NfD9rcn5/kf1tvdSDiZmIVFfoKd0xuz
 m1CJBNsOt6RYK7kUVJeEZzerqOwITs1SlBpxL6yxVOuHT+pouGjnufQW0CuOlsVwehY4
 5zKoYlPXSeX0LpP7UlTy0FWJFaBSdlSujHYqM1bPNRWk2XIpfIFKfg9hI0uDWTc85Wc/
 haZ6D/Ide8eW1knD4GbyGZTCyZDIIx46KH0aALRXz+LD9zC+KYMFx6JRkErEyg1L7VMB
 fwKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762272590; x=1762877390;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a5F/yooW6pnu1OikcO4nD2DRUAh0kt3jpTBeUpOiYpU=;
 b=sc9N2cEMxsH8Y3e9Gh9ODgoXnErE/+BimXXwu3FP7lTKP8xZBRg7FSXtUZWgNj+bS2
 z14dcb36+WpgVhoM1wTapv/6dib5ZEwn0HzzpHxYqX5htnApO8YiirCecwOimZXaf/NJ
 3VY0XYmj/yOXtBlGxDXF0Gow0FK3lpoJTKVZQdieUHyUbZEdtuYYj7NvC6N6pUTSSRmU
 6DozVkj1PHeaEcMSHocP/8Gy0g72KMWRyxZYI6mU0Mc21kXuroJ6qezpvOghWjsAyum+
 Qg9zW1Ai9UN6CpBNY/KB8EmObS3cyeik5zzpErcGuuMYxOxwpazJiQUO6lYFaWbD4xYg
 jj5w==
X-Gm-Message-State: AOJu0YwhjkJp7ExCkr3/sm38yIG1FioyQCOaRDWmoBqeNuj5r/zlP+8z
 MfXCBtqG62AwFES+1TwCtBrKx55cSXKMc05PPpGv4W8FcYU0pnPKweH+IDEx9cOGs0AvgZocabn
 /Er58
X-Gm-Gg: ASbGnctGxIn4taQhQsMQuBSddZXECid3cMJ8k0QDhDy/dJp4v307/87M/ZmQaLbYbpR
 KgY8cbUNtf7E131rz4cBApb9SgGKIlym8afzKTGz/tKZDtVH3HSHaGT0wbxK+HXdIOmLBQhng+1
 lTzB+ukptDwVq17TWxbZjV3WHIklUEZtbiKy5pQEnIusnD4gUtgRTRkUk9ypwz451Tyodb376lg
 Bd5duEKyjJ/Ir+A0aqGvIyfJXX8cFRvCVISe+dmLzDrxJk0e0vtkICmLhOURTB/3X2tiflrrWHf
 MzJxim3iNtJzsPEdmcsLaR08JTud6UG/IDlZy8E0ZzTljBBUTJyHlr9ZTCylKKuICFcEWR7lna3
 xduCXVQgvinnSHo00IrNSC1rd8qXn+WZaZ26kGoFecn7zR73tH91URdw3QJv022n0G0vkVUZl/k
 t6chULJQ==
X-Google-Smtp-Source: AGHT+IHia4kgfVTRl0WN2/dJ53EnZfa5whxOOhQqoOtPN+vqI8LI0Ja7TaGKV2Z+wIqOUymeW7e1fA==
X-Received: by 2002:a05:600c:348d:b0:477:54f9:6ac2 with SMTP id
 5b1f17b1804b1-47754f96ce4mr29353415e9.0.1762272590273; 
 Tue, 04 Nov 2025 08:09:50 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47754adcd08sm57314455e9.5.2025.11.04.08.09.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Nov 2025 08:09:49 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>, John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alex Williamson <alex@shazbot.org>
Subject: [PATCH 4/9] scripts/clean-includes: Do all our exclusions with
 REGEXFILE
Date: Tue,  4 Nov 2025 16:09:38 +0000
Message-ID: <20251104160943.751997-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251104160943.751997-1-peter.maydell@linaro.org>
References: <20251104160943.751997-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

We currently have two mechanisms for excluding files:
 * the REGEXFILE which excludes by regex
 * special cases in the "loop over each file" which make
   us skip the file

Roll all the "skip this" cases into REGEXFILE, so we use
a single mechanism for identifying which files to exclude.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 scripts/clean-includes | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/scripts/clean-includes b/scripts/clean-includes
index 5ab3b071967..a45421d2ff7 100755
--- a/scripts/clean-includes
+++ b/scripts/clean-includes
@@ -104,6 +104,15 @@ grep -v '^#' >"$REGEXFILE" <<EOT
 ^ebpf/rss.bpf.skeleton.h
 # These files just include some other .c file and have no content themselves
 ^linux-user/(mips64|x86_64)/(cpu_loop|signal).c
+# These are autogenerated headers
+^include/standard-headers/
+# osdep.h itself and its friends are expected to include system headers
+^include/qemu/osdep.h
+^include/qemu/compiler.h
+^include/glib-compat.h
+^include/system/os-(posix|win32).h
+# This is for use by plugins, which are standalone binaries
+^include/qemu/qemu-plugin.h
 EOT
 
 # We assume there are no files in the tree with spaces in their name
@@ -137,21 +146,6 @@ for f in "$@"; do
     *.c)
       MODE=c
       ;;
-    *include/qemu/osdep.h | \
-    *include/qemu/compiler.h | \
-    *include/qemu/qemu-plugin.h | \
-    *include/glib-compat.h | \
-    *include/system/os-posix.h | \
-    *include/system/os-win32.h | \
-    *include/standard-headers/ )
-      # Removing include lines from osdep.h itself would be counterproductive.
-      echo "SKIPPING $f (special case header)"
-      continue
-      ;;
-    *include/standard-headers/*)
-      echo "SKIPPING $f (autogenerated header)"
-      continue
-      ;;
     *.h)
       MODE=h
       ;;
-- 
2.43.0


