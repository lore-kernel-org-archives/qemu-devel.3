Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE11DC52D6F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 08:36:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbc8p-0007PU-Sh; Wed, 07 Aug 2024 04:35:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbc8o-0007P0-LW
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 04:35:30 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbc8m-0000mn-Ey
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 04:35:30 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4280bca3960so10958335e9.3
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 01:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723019724; x=1723624524; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HJKTi/26cFELKrR1LQH5wnJ4Q9ilmbfS3RnCQSRRhdo=;
 b=hDpTs1KxxnBdhrEKrqVHdA5QMaNpo4ao9624vFsy/sNfXysvoKJNTxAoCyj4ctZ5UE
 wiPYkJTqSWH+HIUpIND+d9+y45QB2zrl3YMsByVkPr/u4sbq3CEB9eOZNp20pzhWArxj
 Mhb2XNtPYTuO3ZmKGVucwJ5+hlhN/49AEhGwHyheNsiwpeqH/s5w/0lZYZaTZbzh1V8C
 sYdljiQt7qAdzNChD6LUmS2j22UQHdUbMyTbypTG9U2+Ebxs6Gpb/ZySLdq6oCz9Uobe
 HFOmXWGgBh/STBn2X34pX3s6meVht1IOT/7HE9Z39unAdHoKV43xNmYX9beA0c1dJqJ3
 WXtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723019724; x=1723624524;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HJKTi/26cFELKrR1LQH5wnJ4Q9ilmbfS3RnCQSRRhdo=;
 b=PWQD8knmY99Pxlse4bpgLYnH+lt1SqUqTjgjkhIfrwVj/zSJhQHVJayJ5nQYcVJ6ne
 X+O4vIPlLuTkeKnmCr1EGGkUVnlUndDxr2Zb0CSqtLjmMNlGUiodr2Z6T1uSk0yJ+b0T
 nQqbB9AyMuuOpinHeNcXbD6BPLDzs3KxYG2b8KTvNwg/Y4V0vLwHzMRxfiIe+DCn0Nei
 2f7lNmtl0at4FJt3aPnyyDUcfsvlLklkCD5fKnDmgx+6ym3Fl/qtdUs++efh9HWB+oS3
 57p6Z9Glo5jYSlbzCbqZM6k4id9uvd8aQvbjs176qtdNaX1XAAXucSVGCTVoUyTkeCd/
 mS5A==
X-Gm-Message-State: AOJu0YxO2Lfr+jSV+AtbbFSh2xkbxX1Wbhshot2/xhKX0NvnVjTI1ssR
 M/D4/SMY8ARSWoN4/zIsB6IAbS7cnBvHqIrnX7kXrtD5W+4Pja+Df7PDjfF7V12erxreaa6kHXM
 p
X-Google-Smtp-Source: AGHT+IHHRw0lhhE87wxJMFDB6mce0N2To0lh+p6/WHY7hxXlxQkPeOLC0elGwJCFLBodYvuuxmgV+Q==
X-Received: by 2002:a05:600c:6412:b0:428:1ce0:4dfd with SMTP id
 5b1f17b1804b1-428e6b83782mr119365695e9.34.1723019724285; 
 Wed, 07 Aug 2024 01:35:24 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.120])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4290598f30asm17940975e9.26.2024.08.07.01.35.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Aug 2024 01:35:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Zach van Rijn <me@zv.io>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/3] linux-user: Add strace for sendto()
Date: Wed,  7 Aug 2024 10:35:07 +0200
Message-ID: <20240807083508.28134-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240807083508.28134-1-philmd@linaro.org>
References: <20240807083508.28134-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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
 linux-user/strace.c    | 15 +++++++++++++++
 linux-user/strace.list |  2 +-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 7064afb486..f55b62f0c9 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -3122,6 +3122,21 @@ print_bind(CPUArchState *cpu_env, const struct syscallname *name,
 }
 #endif
 
+#ifdef TARGET_NR_sendto
+static void
+print_sendto(CPUArchState *cpu_env, const struct syscallname *name,
+             abi_long arg0, abi_long arg1, abi_long arg2,
+             abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    print_sockfd(arg0, 0);
+    print_buf(arg1, arg2, 0);
+    print_flags(msg_flags, arg3, 0);
+    print_sockaddr(arg4, arg5, 1);
+    print_syscall_epilogue(name);
+}
+#endif
+
 #if defined(TARGET_NR_stat) || defined(TARGET_NR_stat64) || \
     defined(TARGET_NR_lstat) || defined(TARGET_NR_lstat64)
 static void
diff --git a/linux-user/strace.list b/linux-user/strace.list
index dfd4237d14..5a86419e7d 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -1285,7 +1285,7 @@
 { TARGET_NR_sendmsg, "sendmsg" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_sendto
-{ TARGET_NR_sendto, "sendto" , NULL, NULL, NULL },
+{ TARGET_NR_sendto, "sendto" , NULL, print_sendto, NULL },
 #endif
 #ifdef TARGET_NR_setdomainname
 { TARGET_NR_setdomainname, "setdomainname" , NULL, NULL, NULL },
-- 
2.45.2


