Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08829CD1296
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 17:58:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtt7y-000205-Be; Mon, 08 Apr 2024 13:49:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtt7m-0001v9-Rx
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 13:49:47 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtt7k-0003cK-Iq
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 13:49:42 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-29f93c4946cso2932168a91.1
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 10:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712598579; x=1713203379; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JI74xSWz9fuppvIeUIbROGR0F/ne9t6G9LvnZBioEes=;
 b=gMe41AQwr23QosU50ARtALzjdIgT5uWpbqm7HqR7Sdilb/Qrp7vJraozul9j/7iqXV
 Av66F9MbqyCT+9c5UhJJBvHtGzmDw9KHM9fjUOSnp+bKL+WknMEVYLwKmYQR6/HmAu9T
 4LOB2yUVgh4A1Ts04bRgYxOMD7QJ4QzAhrub83u0APfXxZC6E9dIwYwbGHrUxAdRg68O
 Huk+U1OQVYdSubXajFPHuk9rwzxKbKaST/D44ZAc5YCBKFcy+ha7p6jmVcuVLQDLYcNi
 kTnwFOa0PZesZi994LB5Hlc+tOoYURLRcWO9gjOFF74Gd46mBTHulKMnGItgd6O7zJMa
 pHTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712598579; x=1713203379;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JI74xSWz9fuppvIeUIbROGR0F/ne9t6G9LvnZBioEes=;
 b=qPDygR/TgwErAW43orun3upcabRSlreYkT/2iwkJBw/wFACwBOJAppVO+br2x67QVT
 E1xFy1L1TbjLVVwXAhgSAgzI0f5Ll2cS6eEBjx33SmV/P6G8Tdtqvg0JjKO4F2kZOJLV
 BhqC0qBPH+MMah61PPHaf1p2XqlL1UTxE0DFBUAFYXxiXaTpE8sgZmoHDpDvxC/BxI7i
 fNYDh+7lgiphQTjcPi4ywOY97YcbXkH7G/DRXIo/RfBNkIqcy86mChAnGndpeMLNEeND
 5+mEcFzM1rOPbLqiz2kGPYJ6I+MkKKqrE9jNfQfgtBnEgITLidtz91iwUuygBBFQLSEH
 fupQ==
X-Gm-Message-State: AOJu0YwOgdRYioumX2W/OOqyKJt+ecw+e0Le1czsFxgIZKqpthXcOM6V
 UQ3pJnZwXM6edkjco1iNeJ7AMoR9vid75TZjF8B0blIiMX9xJW1XJZlq7KCJi5t9AXf1cCfB0a8
 c
X-Google-Smtp-Source: AGHT+IG4YEQvcCRf8ZKpThHT5AmaxBdn/Jxzc3I39PGqg1AQHeti0hR4etnWmqMNHXWrGANvh7Yc1Q==
X-Received: by 2002:a17:90a:d483:b0:2a2:94c0:38d4 with SMTP id
 s3-20020a17090ad48300b002a294c038d4mr7552188pju.31.1712598579264; 
 Mon, 08 Apr 2024 10:49:39 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 ga15-20020a17090b038f00b0029c3bac0aa8sm8658432pjb.4.2024.04.08.10.49.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 10:49:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 05/35] linux-user: do_setsockopt: make ip_mreq_source local to
 the place where it is used
Date: Mon,  8 Apr 2024 07:48:59 -1000
Message-Id: <20240408174929.862917-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240408174929.862917-1-richard.henderson@linaro.org>
References: <20240408174929.862917-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

From: Michael Tokarev <mjt@tls.msk.ru>

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Message-Id: <20240331100737.2724186-4-mjt@tls.msk.ru>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index cca9cafe4f..1fedf16650 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -2049,7 +2049,6 @@ static abi_long do_setsockopt(int sockfd, int level, int optname,
 {
     abi_long ret;
     int val;
-    struct ip_mreq_source *ip_mreq_source;
 
     switch(level) {
     case SOL_TCP:
@@ -2123,6 +2122,9 @@ static abi_long do_setsockopt(int sockfd, int level, int optname,
         case IP_UNBLOCK_SOURCE:
         case IP_ADD_SOURCE_MEMBERSHIP:
         case IP_DROP_SOURCE_MEMBERSHIP:
+        {
+            struct ip_mreq_source *ip_mreq_source;
+
             if (optlen != sizeof (struct target_ip_mreq_source))
                 return -TARGET_EINVAL;
 
@@ -2133,7 +2135,7 @@ static abi_long do_setsockopt(int sockfd, int level, int optname,
             ret = get_errno(setsockopt(sockfd, level, optname, ip_mreq_source, optlen));
             unlock_user (ip_mreq_source, optval_addr, 0);
             break;
-
+        }
         default:
             goto unimplemented;
         }
-- 
2.34.1


