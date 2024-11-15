Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCDC3D68BD7
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 21:00:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tC3PD-0007Y7-Uo; Fri, 15 Nov 2024 15:59:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tC3PC-0007Xh-FO
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 15:59:02 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tC3PA-0004OC-VB
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 15:59:02 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2e5a0177531so1839409a91.2
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 12:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731704339; x=1732309139; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N8YgKFtlpType92XaAQCJX7PrwLQwlz6/nj0VnkynWY=;
 b=EIyrJj0znoxU0nEE8Go29udHwTLMSN0hyjM6ogal7CgNNPhny7QuM0/Ulk7jLO7fu9
 DMdamVnLore3WZjF0s2FfFT6DXmPj6DOp8HKGAQCq6wgAU3baXC0vCRi8RGB1j1bZBCL
 hDXB4TIXGKw1auoLEhQtNCX4rahPvET3jWae51QEFcFzgeZKu3j7deD+LhDT6vM6pZDG
 9P24LcKZenRgepKHR4OWQGx+CvK49Jlvy3vVhuYzyW9pJOlGkwPUQwaUFy4LfecI34oG
 5bEv6RCYlLAkVAfFeFlYtsu8ZdGUau9G/1cvqyJTgpH8OlP20Dn/EVux8H0Cduaq7QlL
 mdRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731704339; x=1732309139;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N8YgKFtlpType92XaAQCJX7PrwLQwlz6/nj0VnkynWY=;
 b=uB9Z9oopisP1J7/t56KoA4rqe4A/BN4CPdHx0aXYyl/2ayRQ50l2i5id/2r3ujxmrJ
 0yR6q6OL4NbphKor3GokTapgnaQAdVI1h/TPNoNTsuLMsIvaVsAocqGp/5rqIVawRCmm
 VDUfZRNY9cYVaBp5+IC55n8gl2Oh1YY+ReKIOStQBojcBn8rImS5N2pPWnYq7A6oCxcN
 PBZC8atfLMbd4ZTYCTEG3ycxX7pOeWlB6how1eZU0iCkLLe1qM7QuyBn19Ck+NLKNKWM
 Y/cFzFtU7cs8Ddac5oT5ioNSLgM8olM8gEK96FZulj9dRlkTW/flG1JofzFaEM0pCELA
 dK4w==
X-Gm-Message-State: AOJu0YwozdF9psnHZfiivc3sEO0ZDmXiwu//UiBvY1EwYI0Gu2hB+2fn
 RzZ1Uq429pXa4KpVFOvdYwDv6A/ED6gjNiwLvaKdzu1BbFjiOpAEHUd11SaPS3YFfct6ongoZSl
 y
X-Google-Smtp-Source: AGHT+IFX/JONM3qw8PaqY1ZiiNz4oAuWccQPN6yvoDKsC0EeZIqHDBHDV9Q9q61H4vNiM6KSuO7TJQ==
X-Received: by 2002:a17:90b:2b85:b0:2ea:2a8d:dd39 with SMTP id
 98e67ed59e1d1-2ea2a8ded97mr1714013a91.26.1731704339437; 
 Fri, 15 Nov 2024 12:58:59 -0800 (PST)
Received: from stoup.. ([71.212.136.242]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ea024a49a8sm3362274a91.23.2024.11.15.12.58.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 12:58:59 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 08/14] linux-user: Drop image_info.alignment
Date: Fri, 15 Nov 2024 12:58:43 -0800
Message-ID: <20241115205849.266094-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241115205849.266094-1-richard.henderson@linaro.org>
References: <20241115205849.266094-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

This field is write-only.  Use only the function-local
variable within load_elf_image.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/qemu.h    | 1 -
 linux-user/elfload.c | 7 +++----
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 895bdd722a..67bc81b149 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -44,7 +44,6 @@ struct image_info {
         abi_ulong       file_string;
         uint32_t        elf_flags;
         int             personality;
-        abi_ulong       alignment;
         bool            exec_stack;
 
         /* Generic semihosting knows about these pointers. */
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 90e79a01b4..ef9cffbe4a 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -3220,7 +3220,7 @@ static void load_elf_image(const char *image_name, const ImageSource *src,
      * amount of memory to handle that.  Locate the interpreter, if any.
      */
     loaddr = -1, hiaddr = 0;
-    info->alignment = 0;
+    align = 0;
     info->exec_stack = EXSTACK_DEFAULT;
     for (i = 0; i < ehdr->e_phnum; ++i) {
         struct elf_phdr *eppnt = phdr + i;
@@ -3234,7 +3234,7 @@ static void load_elf_image(const char *image_name, const ImageSource *src,
                 hiaddr = a;
             }
             ++info->nsegs;
-            info->alignment |= eppnt->p_align;
+            align |= eppnt->p_align;
         } else if (eppnt->p_type == PT_INTERP && pinterp_name) {
             g_autofree char *interp_name = NULL;
 
@@ -3264,8 +3264,7 @@ static void load_elf_image(const char *image_name, const ImageSource *src,
 
     load_addr = loaddr;
 
-    align = pow2ceil(info->alignment);
-    info->alignment = align;
+    align = pow2ceil(align);
 
     if (pinterp_name != NULL) {
         if (ehdr->e_type == ET_EXEC) {
-- 
2.43.0


