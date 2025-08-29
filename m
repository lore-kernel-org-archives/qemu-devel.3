Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86183CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:53:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNkW-0002t8-O8; Sat, 30 Aug 2025 11:44:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7Xi-0003Ii-Fk
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:25:58 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7Xe-000347-JS
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:25:57 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-772301f8a4cso1238859b3a.3
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506353; x=1757111153; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tEbv4UWAVeKRp024G0xm5LxqRj77iPoKwjPkrVlHe68=;
 b=gNAonUr65n0ON59NaDQ+6ryZbCjngrlT58Sotrz7YrvOhjIJ7bnDHGp8Ix1umzWanw
 1Bmxj5GegAgIjUa0SEyqBdoOvC6eOyRXt0nR5iq/Yp8bnl9Ng9tEB2qg7pNVcU6N3PN/
 NcLzdvOd1RieIHnzhUBwfEM3mN1YhwjUuyjW7KNjI5ogt9jFrsM6cABNeARLHCOWE6Pi
 yYi83BsiiRW40asZArbcVhUU/T6gMyoDRHhkE/VVLgncnz77yripXKbexk2r7nCWQZQ1
 zMNyBmD4ud3Fz8JbHOSkNebPzvlMB4oH5MYZjeF0Sx1I9nirUXm2ycdQRtpztA9prN02
 ih8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506353; x=1757111153;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tEbv4UWAVeKRp024G0xm5LxqRj77iPoKwjPkrVlHe68=;
 b=ErUt3274oQAPBR2+44F9wqWYFH+d2j0JmLWEpdZS9VOTwMC8wm7bpHk3bcnO5HMcsH
 rG4L7HL9pxlXxTYmvvnYOJk9CT/OeRICDi58tI34IPFpxdrh6zSQub7S2ZpwXdClvWo6
 c3zWD1gkXbcdxzRQP/rC+tSsbowT3ftcWeDhudvnQF8Ag+8FBsokWImuelrj94H1a1vF
 hpyIlGvGV1qb33n5bbpDwpW3gSYlUvWKkIQxUiD/MdghgQUrW97zExP6IG82bF56Iead
 YuZ9BktMSBF5KukZjHJRVImoS7GJ5Wj09UEdsRbW/ornXSxq42LIq6XkRvGzJrF5Tb/D
 GZzw==
X-Gm-Message-State: AOJu0Yy7SNUu6DvpU1pQNp/JRDscN8SB8y+TShFgB3v/nuyZlpdP7QSU
 g07j5nbDve6r56V9LxWxxeeHqMCYFJkmjSYNe9+jJKvNhvwp8ned/fKej0GR53qYWVi7p6mp1dg
 01SXZ06o=
X-Gm-Gg: ASbGncvU7YO7GJvqmPkYxXmoK0tl55c3qxyVuxXPMdzXYTBWy//gq0APZG/yEWyIayM
 pTCaHz1AKqSp/sjBMB/IG5j8qfReJfEkbT/ENZNQMUziG7qOKPV4nO0XeYwB2Jb4p6g1dL56SkK
 TW5HR9z+2tVsc0f0RJwW+H8SC0GQaf/9HQGIcbqH2LpNLCBdDM6DFgHzIhEfVrz8sFVn1fhnFQS
 SHKkdZ4lJWraXNYXTl/TGWNXVhglHRnkrBPJMQUOuuqfoZJDaE9h5X4odxIe4yUkJF4Ri7Mh+7V
 rO/Pb98SBa7wH+23VFTZz9DZGsk9NfsBJRx2Gxclsbozfo6jR4F0VGrbdWVsJ08zHV5OCyD4Z+T
 KwD8q8OBkiF63/rbWfVWxKuwMX7iDc7wiWIHiiz1FQOkP8c3sLkRbeOhKSA09
X-Google-Smtp-Source: AGHT+IGuz+/A7UoWMl7Gx2tlriuWxIVfZEKuI1LJUCd8whbOmBT9WYWyNADPKVbO1IBJW4TwfYEwmg==
X-Received: by 2002:a05:6a00:18a7:b0:772:6d:428 with SMTP id
 d2e1a72fcca58-7723e3c3127mr236631b3a.27.1756506352833; 
 Fri, 29 Aug 2025 15:25:52 -0700 (PDT)
Received: from stoup.. (122-150-204-12.dyn.ip.vocus.au. [122.150.204.12])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a71c60bsm3302493b3a.103.2025.08.29.15.25.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:25:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 33/91] linux-user: Remove target_elf_greg_t,
 tswapreg from elfload.c
Date: Sat, 30 Aug 2025 08:23:29 +1000
Message-ID: <20250829222427.289668-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

These are no longer used within the generic file.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 5cdbdc20d9..07d83c674d 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -130,14 +130,6 @@ int info_is_fdpic(struct image_info *info)
 #define ELF_DATA        ELFDATA2LSB
 #endif
 
-#ifdef TARGET_ABI_MIPSN32
-typedef abi_ullong      target_elf_greg_t;
-#define tswapreg(ptr)   tswap64(ptr)
-#else
-typedef abi_ulong       target_elf_greg_t;
-#define tswapreg(ptr)   tswapal(ptr)
-#endif
-
 #ifdef USE_UID16
 typedef abi_ushort      target_uid_t;
 typedef abi_ushort      target_gid_t;
-- 
2.43.0


