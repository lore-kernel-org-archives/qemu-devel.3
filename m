Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65F23CD3427
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2026 17:12:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJDsY-0007vC-4P; Sat, 02 May 2026 13:11:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wJDsT-0007tk-0g
 for qemu-devel@nongnu.org; Sat, 02 May 2026 13:11:41 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wJDsQ-0007G5-Ud
 for qemu-devel@nongnu.org; Sat, 02 May 2026 13:11:40 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7de46b8e432so2764955a34.1
 for <qemu-devel@nongnu.org>; Sat, 02 May 2026 10:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1777741897; x=1778346697;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yOKFPgBMLiOQCpxJ/HoukPsjgqhmFBu/kKtVTLDxNuI=;
 b=Pyq6tAUaaRgT2R7Icq5xepr/dBVvaLra1BFMmldA2NX8VxbfEfqdPJEs+TVmh0B9zG
 yjhMF7s2uWoTdypfGxaDGHOx5nnTh6G9ZnWlikwDEUouAAaznzmJYIhR9aIwsN8hFtef
 tJ/F34CpQ4lXZTli3NDHYuZt8Zfo1TA5+3air8iwA0QviemTKRdudfg8SA7F0tB4XdHj
 co7FdIW8zVJylrvXBKcatmCZHwRaczbcFJKZcBGlNMzR2aYP9H/Tt6bx/7XoJNzLSyz6
 Qwz+ZJ3DVVnJ/sdc8JkPNvKKrMgebldD73KX93bad/npEJVvlAoe4Adljh3UT+rQs53n
 Vybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777741897; x=1778346697;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=yOKFPgBMLiOQCpxJ/HoukPsjgqhmFBu/kKtVTLDxNuI=;
 b=nWXwBarNI8dOWQ+aGpmQs0r0rAoIwEeLF60ogVAO+5z8niO4KNMr6TrpsJnQVst8OB
 gdTOtPwvG2Uft4qzoYJ0BZiHxa9+iMpDozvMXN5D61zoXFBviolN34JEsRz2EfcNje0r
 LoCB8e8kPHtenYQBJQgneqCSuU+MdnaquP0SANkQPRWlkv+EheSwZuwOKGksqdbrBfMV
 TIpccEvhTmWOKTF32axhv/kLFagLAlJjsxafRImopyB68Gs7d77TEtBCBkH4X099xBCw
 9ORqNqCIiMuQcnzCOiamNp+CC9hd94f4qtIefC8YtaBw0UtLNuIhQeeFEuYx81A1CARN
 PwBg==
X-Gm-Message-State: AOJu0YyjjMtYpH7exZZlzQgkCyBER6pjYtj1tFs+Y203SOTheOmRnER/
 RdyFjJ3xDioIcj4teEMbwa9SM8RVTu2VK+W95G8+5h773guSJvJDvz4JAoRiB0sI1VcjYZdFj5T
 WB0nwATw=
X-Gm-Gg: AeBDiesYBgtoauZNx3QwA0rbLjYaX8iYLqAtRv9/I09IGyVvWxv8PIQhob6W59TDpQh
 OZhJsULuSfpCeBdSNOiNfvBauFY9jm0xowxT6G91zFZBeTSKliu8QEr+38Vt48pZnzh5CBBC5rV
 Xx/F7D2+n8dFVa/AcfFRcYshEWOS+4Rw0xtHpWKSQvkAhP8G9dJ3qZ2z1xdSr6kfwIaeobNK3r5
 2xCsujj/ult88wG89i0xF24ESUxO22rN3BN5MioU9HQs9bvjjUjGvlI1pmuo6CNgHDH8hvsqVnq
 69rFzrHEfK9CSjjnxi18kmZMHoWaHHZRnO2h7yMNgTDUYqXd5C+6All53xMyyUN25NFl6REw7ya
 BeCfdOoaSU/1Ndu7qT+rDQXfENWF9/aYwJY71kMPThLl6C+a20vRCIyjp8mu6PT66OQQgJHByBt
 BXKm+LoM4xNPH6jjvxXv4i
X-Received: by 2002:a05:6830:2b0e:b0:7db:b7ae:ef0b with SMTP id
 46e09a7af769-7dee143c081mr2496632a34.24.1777741897590; 
 Sat, 02 May 2026 10:11:37 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7deca824746sm4334355a34.11.2026.05.02.10.11.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 May 2026 10:11:37 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 02 May 2026 11:09:40 -0600
Subject: [PATCH v3 19/19] bsd-user: Add call to do_bsd_ioctl and add
 bsd-ioctl.c to the build
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260502-ioctl-v3-19-a05d4cb1bdff@bsdimp.com>
References: <20260502-ioctl-v3-0-a05d4cb1bdff@bsdimp.com>
In-Reply-To: <20260502-ioctl-v3-0-a05d4cb1bdff@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, "Stacey D. Son" <sson@freebsd.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1572; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=pgP0eEEHq6h/GuDoYbSsIZvY30awmIOGPBgt3Kks/ZQ=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBp9i/RrO1Aq2gKVDrYvrQkuRyrZM6NABEWu0sPb
 vXeHFLlHmCJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCafYv0QAKCRBsHNEofbAR
 AA20EADtdS+/hNHMsHm1Ce5JEnitj6AffWFQvLtj9O+G9hIszMpxQWng0WWhrqRPx/OmL+/eDpp
 2bbxBJnp5y+xkudovY/ETumrvyE1efNo537lw+tboTjWGsyg9Sow5gLm4aLoiIC3M8FGDrAFSBm
 ec1cqYRuqf+UWKJ8iMr0sG4aBb98wLW2j+s6m6/AU0wqTkSPfTtA2tt8jWdd9gN3CQu00PC9Ocv
 suptdKGT12+zViwZ/Ys7KpTMHjoZxBq7nzl/Dg8fYtC+uRkTmFFRVTQXcaN5412ry01Br3RzSM4
 o58MGkf/4gquDwu8opC2l2NMld/KyJb0cInryzUGqnOORzBPx7YY6gUynfsLO0JWXPDWFyMEVz1
 U/nArHkXrhK8oxb+6dbqAfG4Sy1U5KNObTFJCMY9NZc6HjjqefuiyWhHrpJ28cXIWJ/BuO/gCHZ
 1maTI3mYZUoER/QwKqM05eE+6Qa6c/Oy9hlbEkgS9ucMbdQq5a05b4BJ6QPVCkD/Foy27fXEqOD
 ZW5qdIGKZTXUFQ8HOZ0+X2jrRZppOY1ywCvjlcwdqztD7octMnDuuIWvsirEFcKyCunXTibL7Qn
 fIQhkmmpetGfddMMoDgaGxshs3sfNWV9cuVjbv7LhcVcWbhmy2eOhktzGihopA17PZm4Y98e9YE
 xDEuuyNuRB/5hIw==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::32b;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x32b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Finally, connect do_bsd_ioctl to the build. Call bsd_ioctl_init() from
syscall_init()

Signed-off-by: Stacey D. Son <sson@freebsd.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-syscall.c | 9 +++++++++
 bsd-user/meson.build          | 1 +
 2 files changed, 10 insertions(+)

diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 85e5db19a3..07fca396bb 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -34,6 +34,7 @@
 
 /* BSD independent syscall shims */
 #include "bsd-file.h"
+#include "bsd-ioctl.h"
 #include "bsd-mem.h"
 #include "bsd-proc.h"
 #include "bsd-misc.h"
@@ -689,6 +690,13 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_bsd_undelete(arg1);
         break;
 
+        /*
+         * ioctl(2)
+         */
+    case TARGET_FREEBSD_NR_ioctl: /* ioctl(2) */
+        ret = do_bsd_ioctl(arg1, arg2, arg3);
+        break;
+
         /*
          * stat system calls
          */
@@ -1001,4 +1009,5 @@ abi_long do_freebsd_syscall(void *cpu_env, int num, abi_long arg1,
 
 void syscall_init(void)
 {
+    init_bsd_ioctl();
 }
diff --git a/bsd-user/meson.build b/bsd-user/meson.build
index 9cc5c6c459..2abcae5122 100644
--- a/bsd-user/meson.build
+++ b/bsd-user/meson.build
@@ -7,6 +7,7 @@ bsd_user_ss = ss.source_set()
 common_user_inc += include_directories('include')
 
 bsd_user_ss.add(files(
+  'bsd-ioctl.c',
   'bsd-mem.c',
   'bsd-misc.c',
   'bsd-proc.c',

-- 
2.52.0


