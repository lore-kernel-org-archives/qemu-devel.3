Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8550AC5478C
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 20:46:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdFv3-00076C-Uy; Thu, 22 Feb 2024 15:43:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdFv1-00074w-60
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 15:43:47 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdFuz-0002eL-Pe
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 15:43:46 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1d94b222a3aso1907475ad.2
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 12:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708634624; x=1709239424; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QqsG1I779d9YjbXcffYW5wImE5mXquA1bGyFgIG+R5A=;
 b=YefzncufOad2toW6MD2Us6LvBb1zDA/aUbJET7ef/SieWxd0bHhKSGuAUFxGcYCvZb
 1QlctQM0vhXsvp5y42vSALv0V3WxKRPD0slOYlvtr+B+yfoAxoXb7/omFu2SpPGdbo75
 l+WdWpXkEH2C1ecgMo1n3ybt+Fl5wLlgrAw6Y+yIX/tGD8R4Tu8rNHXPJu3B4B2oDN1J
 rQVAF5Kdy58J2e17cnFrPrglYgM4k4qvP03jY1bGI/WDd2bpqDN4D+Hw+O0mitrawo5i
 CK7ZS7DxeB9QpWy8ayCgy/peDSjJ66CkxooD7gQI0YqyZVTMIDdUe8Ckwu1m1XmQ/Nm2
 DBXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708634624; x=1709239424;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QqsG1I779d9YjbXcffYW5wImE5mXquA1bGyFgIG+R5A=;
 b=i7SuZ3vPfm1qTsSzrhowFcyoIPPMuPuIY8VR8EdBnKTfXODmW0dJ6DefaKvBBL3vvc
 U7FqyVBaRlreouF54caxjJ4XpryNAnn8jSSouWCBNCvNGusj6MJHTYCbx1QD0tohNlQJ
 v3Fd6tdcAE6IGvEoZrSED+1SKTrHAPC/bNiyEZL9S29YxnZnflKzyaVKEW2G45OWdMek
 IDxnUE0zJL/tdHHYT0RxOImAmUks9IaJkOE5/u+VE8lcq8jJQZQMXPB/eddNJ/IXBqz/
 w6iVNTreKbSE3Erriw07q9wZMklop2PHJ2qx7YqH9MfdCNJduWDddPcmFt7uHXUSMbvM
 v1IA==
X-Gm-Message-State: AOJu0Yxj8o+7/GpfKLoOJQZcprB22bVRrtZsCcB5vymExPXr5EC/8uPg
 ZHugOBx2/ZXNtfMobolcNoDi4n4/id1o8Kv09gf8RVFMdD0krooG7UeiJm2hBPc4teYqxcOiFeJ
 u
X-Google-Smtp-Source: AGHT+IGLAQIiCdkn4JcgGvYppS43mkFBwl0pdDGUPCeFRj4Qp9DKME1aiwGDZPaRA7iUYIFtkjcPGw==
X-Received: by 2002:a17:902:e789:b0:1db:fa84:9be3 with SMTP id
 cp9-20020a170902e78900b001dbfa849be3mr10994096plb.8.1708634624592; 
 Thu, 22 Feb 2024 12:43:44 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 l12-20020a170902d34c00b001d8f81ecebesm10275500plk.192.2024.02.22.12.43.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 12:43:44 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Helge Deller <deller@gmx.de>
Subject: [PULL 12/39] linux-user: Remove REAL_HOST_PAGE_ALIGN from mmap.c
Date: Thu, 22 Feb 2024 10:42:56 -1000
Message-Id: <20240222204323.268539-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222204323.268539-1-richard.henderson@linaro.org>
References: <20240222204323.268539-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

We already have qemu_real_host_page_size() in a local variable.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Acked-by: Helge Deller <deller@gmx.de>
Message-Id: <20240102015808.132373-10-richard.henderson@linaro.org>
---
 linux-user/mmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 4d3c8717b9..53e5486cc8 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -585,7 +585,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
              * the hosts real pagesize. Additional anonymous maps
              * will be created beyond EOF.
              */
-            len = REAL_HOST_PAGE_ALIGN(sb.st_size - offset);
+            len = ROUND_UP(sb.st_size - offset, host_page_size);
         }
     }
 
-- 
2.34.1


