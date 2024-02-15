Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 908DEC4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 06:21:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raV76-0002Nd-So; Thu, 15 Feb 2024 01:20:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1raV6z-0002L7-Ay
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 01:20:45 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1raV6x-0005Uy-N3
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 01:20:45 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1d93edfa76dso4049355ad.1
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 22:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707978042; x=1708582842; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MJwI7j8qAfDRGrC+KBy3NdL40EXjR4qHacqKh2GDQwg=;
 b=b6PaTaZmEC5BKo0TzRJqcR8Cp5VsAbyS39upUhfg2IimeDdId6ntz1ONy+W1OVqAvW
 3gzaurdQmMLKMf6tMPIoOktjX7rYtWSqngNSY0kVAZA/xgo6ufJ9RZOj1FcuVzF9i1Rl
 0GSPo68/qUGiawA3VcgOE4sZc+vFWAM55qFX4E2CDaJJp0ObEeO7Jy6UW3kGiZMzAc8e
 hua+R/A7Ilu7HGjRHokL5PuUtkclONNp/0JMV7I0sCebwzFhcauVtgDIXw1coRGaHSOt
 fea6B+qUT1cuv8iRTHTszmGcIJCotkAiPzi9r1h4QafFR7VA8IZykOV7De1QKeni9un8
 JUGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707978042; x=1708582842;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MJwI7j8qAfDRGrC+KBy3NdL40EXjR4qHacqKh2GDQwg=;
 b=urk8PXqZzKAygUPbyDKYkiXuxU0cpMQKFItCo+AHeWQiBh8P0nVAtknDFlpUm7i1M7
 iDWLEQ8fpzYanItaEzRgV2xvRsDNGelRPf0ZSeFwccMqQUVXhrmHKlkDPkOBES4+bv3M
 5fG5omYsal2KFntuS15Jqyp+LKu3xXWu59AXRZnuHbAjsYFNzrQyCG9oWAU5ChfOBAFa
 +OFOFYfFwibZIEA8CvnwMW+3GI5Q/HN/DG9g1oHGtjAmk10j55wjx/cb7R/RUep6kmDg
 /CVGlbwvr8gg9K2tuRI8siNo1ZYzHDtGkK3oPknGF3FkDXr4fce+nk/veSKCiMKRantL
 xXaQ==
X-Gm-Message-State: AOJu0YwDVFh1qDe6msU13dGubEqBlMK/pT5mNxnpQQxuLsqQO6taLky6
 KWlFX+IXCllgeT5FQx1isR6bhvqRhWBtoDgCVaiOrY0uEdXPgQMcokJqqPS5lrfZcfE8p7Vf1Fl
 T
X-Google-Smtp-Source: AGHT+IHL09jobZaOXWynFqV8jUYEXLonUZWHHv8Atf7B2fptXqs6SYacy0N1dna0cLGBrerePXmakw==
X-Received: by 2002:a17:902:6502:b0:1db:65a3:e17f with SMTP id
 b2-20020a170902650200b001db65a3e17fmr698708plk.6.1707978042587; 
 Wed, 14 Feb 2024 22:20:42 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 d5-20020a170902b70500b001d6f29c12f7sm464418pls.135.2024.02.14.22.20.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 22:20:42 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Helge Deller <deller@gmx.de>
Subject: [PATCH v4 15/36] linux-user: Remove qemu_host_page_size from main
Date: Wed, 14 Feb 2024 20:19:57 -1000
Message-Id: <20240215062018.795056-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215062018.795056-1-richard.henderson@linaro.org>
References: <20240215062018.795056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

Use qemu_real_host_page_size() instead.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Acked-by: Helge Deller <deller@gmx.de>
Message-Id: <20240102015808.132373-16-richard.henderson@linaro.org>
---
 linux-user/main.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index 74b2fbb393..e540acb84a 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -781,7 +781,7 @@ int main(int argc, char **argv, char **envp)
     }
     cpu_type = parse_cpu_option(cpu_model);
 
-    /* init tcg before creating CPUs and to get qemu_host_page_size */
+    /* init tcg before creating CPUs */
     {
         AccelState *accel = current_accel();
         AccelClass *ac = ACCEL_GET_CLASS(accel);
@@ -804,8 +804,10 @@ int main(int argc, char **argv, char **envp)
      */
     max_reserved_va = MAX_RESERVED_VA(cpu);
     if (reserved_va != 0) {
-        if ((reserved_va + 1) % qemu_host_page_size) {
-            char *s = size_to_str(qemu_host_page_size);
+        int host_page_size = qemu_real_host_page_size();
+
+        if ((reserved_va + 1) % host_page_size) {
+            char *s = size_to_str(host_page_size);
             fprintf(stderr, "Reserved virtual address not aligned mod %s\n", s);
             g_free(s);
             exit(EXIT_FAILURE);
@@ -902,7 +904,7 @@ int main(int argc, char **argv, char **envp)
      * If we're in a chroot with no /proc, fall back to 1 page.
      */
     if (mmap_min_addr == 0) {
-        mmap_min_addr = qemu_host_page_size;
+        mmap_min_addr = qemu_real_host_page_size();
         qemu_log_mask(CPU_LOG_PAGE,
                       "host mmap_min_addr=0x%lx (fallback)\n",
                       mmap_min_addr);
-- 
2.34.1


