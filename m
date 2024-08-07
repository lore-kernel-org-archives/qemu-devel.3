Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 738AEC52D6F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 08:36:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbc9V-0000wb-VA; Wed, 07 Aug 2024 04:36:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbc9V-0000sP-6f
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 04:36:13 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbc9T-0000wu-I1
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 04:36:12 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-52f04b4abdcso2211506e87.2
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 01:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723019769; x=1723624569; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/I0FsiaKLm1aDdY+hG7UBHBo01pYVAJcpIt4G782Pr4=;
 b=GA2tNaKLZv6YVm+QxaiGhus8DmoPxcJWuGyK7DbyHtFcaa5wUOuSXtWYzIW+tge0jy
 Pr/NXgP0lj21+DrSKaxa1l0TR7Ugr5olwKsHXy3Z2NqyqlldRhIl+qxdU/fhZQA9GUrT
 WU32FToyzniUNZ9ikRsnQ1cw2jqhhgp1PzvpC2TvqRjbrJsYaD1gftbwIvAPfzENZWgC
 vTZnP98IuWDNRS8DSuyLoIEIDkqXcRnH2lcZCN+Wgnv4hg0EDRY6Cq+xU14WBNAytsrI
 sQZLY+FiNC77l+iDeMJWk2FK1iugxkyIy2RJmEhcxDHzuxHKxR+3WCeOSK+7jYrocg02
 EEug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723019769; x=1723624569;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/I0FsiaKLm1aDdY+hG7UBHBo01pYVAJcpIt4G782Pr4=;
 b=MiFlg2Aj2IXirCx0dGCFrv8MI4EA6WXAWlc2yjKU75MkKjhYWNjQIWhvBfeIgKhyV/
 W5gxm6rd6Fr/nKP163v8T4m1Juus1R0kqgAvaqRpPoT5ZoENbYg9mnL+mTCFW+e9jAuF
 Wm7nadhd16AnkPeRPqzNg2EyyTiACg4Skz0ZuK1nHDZ+9O4aCm6Egn16nFRVuVOmTxum
 HD0Z3GmEUXpCCvqpKcG/0T2Q244mAueYsFe3m35dXyiEqcgG9ckyeMl1Xlj147fKi5xI
 42vjO5fh9GfW2aAy4P+G30SlSxiluoFfkJ+psnhQfqOn2yLkVNi6U4SbEqpMVpiIIWiw
 EPSA==
X-Gm-Message-State: AOJu0YzuWYaRbpCxOXCFQEezbYUxyErUe2j3Dyfz9T6qeUvK8ImAKkbj
 SkuomfE4Sn80eHFvcpqBkYP0RdX/NXPSPVtFQeFOJi9hYyfmh97iqyy9CIdHSS4uIxntsdBi76I
 z
X-Google-Smtp-Source: AGHT+IHuWEQ/sKSztZ7BfUM4kQXTXyvKvZ0PrvveYwZ61Iz+NFZT9kxRLei4yzFErMn45bUGpyF39A==
X-Received: by 2002:a05:6512:1115:b0:52e:98f6:c21f with SMTP id
 2adb3069b0e04-530bb36be93mr12512090e87.16.1723019768990; 
 Wed, 07 Aug 2024 01:36:08 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.120])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbd01efb1sm15153509f8f.52.2024.08.07.01.36.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Aug 2024 01:36:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Zach van Rijn <me@zv.io>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/3] linux-user: Add strace for recvfrom()
Date: Wed,  7 Aug 2024 10:35:08 +0200
Message-ID: <20240807083508.28134-4-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240807083508.28134-1-philmd@linaro.org>
References: <20240807083508.28134-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12f.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
RFC: Not sure about get_user_ualx() use here
---
 linux-user/strace.c    | 19 +++++++++++++++++++
 linux-user/strace.list |  2 +-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index f55b62f0c9..f03e4229d6 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -3122,6 +3122,25 @@ print_bind(CPUArchState *cpu_env, const struct syscallname *name,
 }
 #endif
 
+#ifdef TARGET_NR_recvfrom
+static void
+print_recvfrom(CPUArchState *cpu_env, const struct syscallname *name,
+               abi_long arg0, abi_long arg1, abi_long arg2,
+               abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    abi_ulong addrlen;
+
+    get_user_ualx(addrlen, arg5, 0);
+
+    print_syscall_prologue(name);
+    print_sockfd(arg0, 0);
+    print_buf(arg1, arg2, 0);
+    print_flags(msg_flags, arg3, 0);
+    print_sockaddr(arg4, addrlen, 1);
+    print_syscall_epilogue(name);
+}
+#endif
+
 #ifdef TARGET_NR_sendto
 static void
 print_sendto(CPUArchState *cpu_env, const struct syscallname *name,
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 5a86419e7d..77ca824f9c 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -1135,7 +1135,7 @@
 { TARGET_NR_recv, "recv" , "%s(%d,%p,%u,%d)", NULL, NULL },
 #endif
 #ifdef TARGET_NR_recvfrom
-{ TARGET_NR_recvfrom, "recvfrom" , NULL, NULL, NULL },
+{ TARGET_NR_recvfrom, "recvfrom" , NULL, print_recvfrom, NULL },
 #endif
 #ifdef TARGET_NR_recvmmsg
 { TARGET_NR_recvmmsg, "recvmmsg" , NULL, NULL, NULL },
-- 
2.45.2


