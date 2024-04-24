Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DAE4C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 22:52:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzlSe-0006wo-Pk; Wed, 24 Apr 2024 18:51:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzlSd-0006wD-7F
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 18:51:31 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzlSb-0006fH-Jq
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 18:51:30 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6f043f9e6d7so447691b3a.3
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 15:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713999088; x=1714603888; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aRT5ReX6FfNpi8sInY8Erna9AcoUcJ+9OuBKDiXG1pU=;
 b=ZYvc565Ov5sPmas60DlESQLgkhQ2oQL+fMrxUUfdFbulH7qvJ+x6kELuo2YRSoOAzU
 823JwHPCfhfsRojqhn82kdMMEhpX3zN+DmzyPuXHiGeuDSKki528ORXRL+goqF/8DVFW
 NzccURbvqNPbztkmKFMZRmsNhasQF2ad74RIpbZEzHPmm+0o9SSaNn98qTdHpDtBrkXb
 MOqKjz/1T5/W94fGwHtSvp508qJOZloSZxqlbowyX2ZTFuYdkcvR07Iia3kqpWTcw8F8
 mdC4P1iBzu/Su5onPah6ppZ4G4qYWtXrnyFRcFXVOpUC7XlrJkB6/eQU+z789gi9UxsI
 sNnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713999088; x=1714603888;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aRT5ReX6FfNpi8sInY8Erna9AcoUcJ+9OuBKDiXG1pU=;
 b=EM5t++AnWy0vzohuZumXWd6njQ1jKKb+HQzCURisdgpZbiUZeIoTm1QxeDxNf17UOQ
 MF3LGy7dc4uAmTBgoN8Q5wnOltbQXRG/l+Y+96vlHFmZDbzocoWl2RUBe5jbYimv5AyZ
 j7mE3MR51UjTHcfE1LOGxP4IyoMZZO1uANLgrOwsq/kPSnB9DrdCrajLvECUM9a5Ndni
 9dgI1e2VTladRqI4Lw4krTNsO5fBURp8VyG2PuY+dkbYgI81Hj9XgPeALoTSaGGMcn3w
 jv8rCZtGacaDe9wS9srDywaswcy8F9idbWVptzGxpWDr6FNi5hngAdm9rpA8iCpyWIua
 VkfA==
X-Gm-Message-State: AOJu0Yw+dSeez1xWj/NxVwKBMvNp4NCidkVr/x+JCYxWaoWCPmFBmdvn
 D8OblTAAALnRRASB+qeRvBbiw3P/irDts/ke/ncXSL9Zig7oVnhN0xacqSvd5nQnmhPEZUWcjp4
 O
X-Google-Smtp-Source: AGHT+IEzRWpJMH9y3KYChUNeXKu5ktJl6zedosbWkGaGEIqAm0WgOWcIEYfAyx4D2PK0lM+q4kaVPQ==
X-Received: by 2002:a05:6a20:daaa:b0:1aa:5e75:d31f with SMTP id
 iy42-20020a056a20daaa00b001aa5e75d31fmr4467385pzb.16.1713999088291; 
 Wed, 24 Apr 2024 15:51:28 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 it12-20020a056a00458c00b006ead792b6f2sm11960864pfb.1.2024.04.24.15.51.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 15:51:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 3/9] linux-user: do_setsockopt: make ip_mreq local to the place
 it is used and inline target_to_host_ip_mreq()
Date: Wed, 24 Apr 2024 15:51:17 -0700
Message-Id: <20240424225123.929152-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424225123.929152-1-richard.henderson@linaro.org>
References: <20240424225123.929152-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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


