Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAAD3C19F4E
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 22:53:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzlSe-0006wp-Sk; Wed, 24 Apr 2024 18:51:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzlSe-0006wg-4O
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 18:51:32 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzlSc-0006fj-Jd
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 18:51:31 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6ed04c91c46so440465b3a.0
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 15:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713999089; x=1714603889; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JI74xSWz9fuppvIeUIbROGR0F/ne9t6G9LvnZBioEes=;
 b=vFFYISOWbkz8WiNiX8NK85XdoRJFaLvVP0UtTB/eC/2cdLyQBF+JDdRIQkgYVgIZte
 b0XS3NjHKPj07e6RFvp31rxsOQl8KKH68o/ImMi1UqKMYjnnq81O3+hrETts0otDg5tQ
 wbFvMC5Qqqsn35tTEMatqtUPjWTfqQa7j5xij+c3BSvIUf+IOzG9b9FMPMBDFZ3ymBAM
 DxcJn1+FRQM8IAyb8Sc1N1+L1cEJi/ydKuvia3rgSiwvqOOrXk0dAoqiF0gUTKniyrjO
 17n5/wVQkr+0YhHWi+MoVDPw+aMdiMZay/rRdF+8QDd5yB04Bn/n4Sb7vVEyqxVegxfX
 eyHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713999089; x=1714603889;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JI74xSWz9fuppvIeUIbROGR0F/ne9t6G9LvnZBioEes=;
 b=FWGLdJvnUl4q+2sySUphS7WnbNY7L4vGNmqxCd086WPUp4JiZvtQOeokBwhq6UkV6G
 5ABhhQDTu4UU9QC45NFWkq9HSAeQ+09XEl2wtK1BrvVJWDsuGy0ygTUCS191jiD04VQB
 Xv6auRA9NmqEkLdmkeARiy6AWN5SjGDvvg5LY95S+aEhIBRSH7iPG8ADMC7cTQ1XrqLV
 zcC6vPXOfguHuSyxuaXHjhnhuilD3d2aPMzZ1N2ykw+bdK02sndqJCIdj29NeOYdgXu9
 leuM1baJgH0FOrSNIs/iz9faWG7jOT60Gx1WtR0AQGHRNel5o+uGPSOZ3xevPQz+vE4g
 Shrg==
X-Gm-Message-State: AOJu0YzX24+LGIDOVYq/4r6scZBZGegVgtbSizhI2LIxTzARYy9aJFi+
 GbG7Q4vRf7xP4gonBRHIFtftzlF1Ry/Ht5wY/rvsmoAPNVS0LMsPk9pOINc8D9uBIr5/G88IKJP
 J
X-Google-Smtp-Source: AGHT+IExAPxa7FlTzJEu7qVqPW+srTBf6nmeVL0NH1/UaH1bC49s+Z/VgT8P91AmLXA7p82GBHSSGw==
X-Received: by 2002:a05:6a00:190c:b0:6ea:8793:6d64 with SMTP id
 y12-20020a056a00190c00b006ea87936d64mr4605726pfi.23.1713999089139; 
 Wed, 24 Apr 2024 15:51:29 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 it12-20020a056a00458c00b006ead792b6f2sm11960864pfb.1.2024.04.24.15.51.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 15:51:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 4/9] linux-user: do_setsockopt: make ip_mreq_source local to
 the place where it is used
Date: Wed, 24 Apr 2024 15:51:18 -0700
Message-Id: <20240424225123.929152-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424225123.929152-1-richard.henderson@linaro.org>
References: <20240424225123.929152-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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


