Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0928C67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 17:58:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtt7v-0001yi-C6; Mon, 08 Apr 2024 13:49:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtt7n-0001vA-1g
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 13:49:47 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtt7k-0003cC-Id
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 13:49:42 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2a4df5d83c7so884651a91.0
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 10:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712598578; x=1713203378; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aRT5ReX6FfNpi8sInY8Erna9AcoUcJ+9OuBKDiXG1pU=;
 b=w/ERickoXh3AXO+xpirUpwxBhY7FdLo6rDWA6G6MuFD67grVFC+jJi1zh2RO5XpOsT
 OVJOZ6+Ur0mLjvf5GjTRE4UJopWyTryrRae9qY5EZ7wA/snLfB069Z0NHp3/sw3CgTLt
 62I0gU0jWx8GEioF82MhokbFTAfcZIf6EUMuhuyoZR4FhsyRH6g7d5uz1cxmy2NQMuMA
 ZAHUEocCsey1ZV8dLnyS2ZeutRRsNnr/eDhXO14bk0O7CQuFmlS91PXoY6Pb/TwZibhC
 KuoBHV8cAlmC3fihZhiY/0OcmLNRH2Bux+qIuxu665HPxKjw9als5UkXavhpxzUbcI2T
 tkEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712598578; x=1713203378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aRT5ReX6FfNpi8sInY8Erna9AcoUcJ+9OuBKDiXG1pU=;
 b=ILeQ0sZNBowDV4RKd/i9EIkYys5GSpb2EiSucaVKDj0++oZWSNVk+ItakTy31SPOhc
 u5odOdn8fbOdm3a+hhmpo2PI5KahQC/XW3d9m8p1K23UGo6ABtF5WuVQcRc2B1MuwswV
 /ZheXNMBViCXQjXlyVC8CNigVeEH5baeAYFvOtIrAN7/cPghTOkTsXrIb8Av7ZS3Fyfh
 SKQQdYzg7HemvXbfypCZW3lLlBAvID9eeVSPEWZxX3bjhwgZ+a1MlkEg1GttnzkpXNs3
 cT420KyYuNK/yWj+/i1w6Zv608s2YP9lqoi3YDaf1g5T/o2G+n8xLdEpbaq6juATj0il
 2FeQ==
X-Gm-Message-State: AOJu0YwPctJ5nQvVZWnXWh+Onkh5A/MicuXpXOpaof60fTckecwr7X9x
 uZZAYSiHlRbUsvKhB/H6Auabu3qi+BFfobiiBt57Kj8UKC5H1bi8CKufXNko0YheT9SL7tCCQGS
 f
X-Google-Smtp-Source: AGHT+IGe1xVl6uyw639/WVojzofP2sD7cYwVPQzQ8DwRclGyF7i6hA+/luX2VwFI8uhiDVdoaL+5Tg==
X-Received: by 2002:a17:90a:7286:b0:2a2:d41d:2258 with SMTP id
 e6-20020a17090a728600b002a2d41d2258mr7678208pjg.28.1712598577956; 
 Mon, 08 Apr 2024 10:49:37 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 ga15-20020a17090b038f00b0029c3bac0aa8sm8658432pjb.4.2024.04.08.10.49.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 10:49:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 04/35] linux-user: do_setsockopt: make ip_mreq local to the
 place it is used and inline target_to_host_ip_mreq()
Date: Mon,  8 Apr 2024 07:48:58 -1000
Message-Id: <20240408174929.862917-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240408174929.862917-1-richard.henderson@linaro.org>
References: <20240408174929.862917-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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

ip_mreq is declared at the beginning of do_setsockopt(), while
it is used in only one place.  Move its declaration to that very
place and replace pointer to alloca()-allocated memory with the
structure itself.

target_to_host_ip_mreq() is used only once, inline it.

This change also properly handles TARGET_EFAULT when the address
is wrong.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Message-Id: <20240331100737.2724186-3-mjt@tls.msk.ru>
[rth: Fix braces, adjust optlen to match host structure size]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 47 ++++++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 24 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 59fb3e911f..cca9cafe4f 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -1615,24 +1615,6 @@ static abi_long do_pipe(CPUArchState *cpu_env, abi_ulong pipedes,
     return get_errno(ret);
 }
 
-static inline abi_long target_to_host_ip_mreq(struct ip_mreqn *mreqn,
-                                              abi_ulong target_addr,
-                                              socklen_t len)
-{
-    struct target_ip_mreqn *target_smreqn;
-
-    target_smreqn = lock_user(VERIFY_READ, target_addr, len, 1);
-    if (!target_smreqn)
-        return -TARGET_EFAULT;
-    mreqn->imr_multiaddr.s_addr = target_smreqn->imr_multiaddr.s_addr;
-    mreqn->imr_address.s_addr = target_smreqn->imr_address.s_addr;
-    if (len == sizeof(struct target_ip_mreqn))
-        mreqn->imr_ifindex = tswapal(target_smreqn->imr_ifindex);
-    unlock_user(target_smreqn, target_addr, 0);
-
-    return 0;
-}
-
 static inline abi_long target_to_host_sockaddr(int fd, struct sockaddr *addr,
                                                abi_ulong target_addr,
                                                socklen_t len)
@@ -2067,7 +2049,6 @@ static abi_long do_setsockopt(int sockfd, int level, int optname,
 {
     abi_long ret;
     int val;
-    struct ip_mreqn *ip_mreq;
     struct ip_mreq_source *ip_mreq_source;
 
     switch(level) {
@@ -2111,15 +2092,33 @@ static abi_long do_setsockopt(int sockfd, int level, int optname,
             break;
         case IP_ADD_MEMBERSHIP:
         case IP_DROP_MEMBERSHIP:
+        {
+            struct ip_mreqn ip_mreq;
+            struct target_ip_mreqn *target_smreqn;
+
+            QEMU_BUILD_BUG_ON(sizeof(struct ip_mreq) !=
+                              sizeof(struct target_ip_mreq));
+
             if (optlen < sizeof (struct target_ip_mreq) ||
-                optlen > sizeof (struct target_ip_mreqn))
+                optlen > sizeof (struct target_ip_mreqn)) {
                 return -TARGET_EINVAL;
+            }
 
-            ip_mreq = (struct ip_mreqn *) alloca(optlen);
-            target_to_host_ip_mreq(ip_mreq, optval_addr, optlen);
-            ret = get_errno(setsockopt(sockfd, level, optname, ip_mreq, optlen));
+            target_smreqn = lock_user(VERIFY_READ, optval_addr, optlen, 1);
+            if (!target_smreqn) {
+                return -TARGET_EFAULT;
+            }
+            ip_mreq.imr_multiaddr.s_addr = target_smreqn->imr_multiaddr.s_addr;
+            ip_mreq.imr_address.s_addr = target_smreqn->imr_address.s_addr;
+            if (optlen == sizeof(struct target_ip_mreqn)) {
+                ip_mreq.imr_ifindex = tswapal(target_smreqn->imr_ifindex);
+                optlen = sizeof(struct ip_mreqn);
+            }
+            unlock_user(target_smreqn, optval_addr, 0);
+
+            ret = get_errno(setsockopt(sockfd, level, optname, &ip_mreq, optlen));
             break;
-
+        }
         case IP_BLOCK_SOURCE:
         case IP_UNBLOCK_SOURCE:
         case IP_ADD_SOURCE_MEMBERSHIP:
-- 
2.34.1


