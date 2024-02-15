Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EED5FC48BEF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 06:21:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raV6y-0002KF-B2; Thu, 15 Feb 2024 01:20:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1raV6s-0002JJ-5U
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 01:20:38 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1raV6q-0005SV-GL
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 01:20:37 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1db562438e0so4115615ad.3
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 22:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707978034; x=1708582834; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QqsG1I779d9YjbXcffYW5wImE5mXquA1bGyFgIG+R5A=;
 b=u++Z0SWJyJ/Qkfh/aAowtDc8Yiyd3wOUOnq6/Y0U9OY662wVzjZI5XdCkLfdMW25sj
 ibcS0e9H0akrR6JaVnt32Z2/5gs66TK1Rjlc8upbiUXZdMiuR1qdPq3pEGmBrjj/QKlg
 k914j1vHQPBaQ7LGy4imfcv4jMuCNgyxKjG7Jf3zUJeZKEKBGN4rwcWo+2kSgcpwlZqy
 gqp9eKLLEgIQW7Y64q7r4KOfPJEiMqyVHiXK51ZjW4LTeYn3u2V3bQo3xkJaxvCPIvwr
 OIj9iW5ojMOcqvZ23JEzx1R3io5iS+j8gW3wFPzZmjfpXS8R4e7olBzcMz/1ZIHbNBBz
 PwBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707978034; x=1708582834;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QqsG1I779d9YjbXcffYW5wImE5mXquA1bGyFgIG+R5A=;
 b=oFhizmgKcOj/TsvQ00Y6oinMjpvO7a2S+GIJEnf5sd4CinkQFjbRmvqrkAiw9XzIEw
 kkQo9OFxCZv3ZGKug1xRnRQxHFhFRnHqDrj7twBlJr3x6dDSz7+7GKpgRfUuyNPgkCDE
 ioBcxz0suMnlTNYpnaEUmso6L+Cfr/Bc8FBwVyEkIF0BfC2Ndwn639aUJBU+Rqsis6X0
 ddo5zpYOQjS3Z8AXcrQdD1HAmRO8SXtPL9gN8/pa9mScDkJGX+5/ev5UJNmxLJR9vctM
 yg5MEWEhxxKRO3thGIroPpiNVaS3MDItjX5/E4I1ituvV4sY5uyaHIxAGBiCJJS/r8Wz
 aQlw==
X-Gm-Message-State: AOJu0YyeZeKN1+ij0x0+MR7fujRW13kh982Nq5y+RGQ7SQvAk3shpqT0
 Z3barSwBnIrP7kbEvv8nadUtFIY8i2a5iRUh0eicRqDolQbNC8VdvC/scBFHaFqt8hFohvirCb3
 2
X-Google-Smtp-Source: AGHT+IF9A4Oe5yYP2/x8YV3UrRqkWacjyPe1m51pND9X/vptygIIXqJYelNQZ8nxDDH5fW7i4zzcEA==
X-Received: by 2002:a17:902:e551:b0:1d9:5ef2:abdd with SMTP id
 n17-20020a170902e55100b001d95ef2abddmr1119429plf.0.1707978034007; 
 Wed, 14 Feb 2024 22:20:34 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 d5-20020a170902b70500b001d6f29c12f7sm464418pls.135.2024.02.14.22.20.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 22:20:33 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Helge Deller <deller@gmx.de>
Subject: [PATCH v4 09/36] linux-user: Remove REAL_HOST_PAGE_ALIGN from mmap.c
Date: Wed, 14 Feb 2024 20:19:51 -1000
Message-Id: <20240215062018.795056-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215062018.795056-1-richard.henderson@linaro.org>
References: <20240215062018.795056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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


