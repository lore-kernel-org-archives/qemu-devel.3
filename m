Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB398CD3442
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 15:20:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL0Vp-0003pf-9G; Thu, 07 May 2026 11:19:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wL0Vn-0003pE-Bg
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:19:39 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wL0Vl-0003go-9t
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:19:39 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7dcdca9aa0bso1513626a34.0
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 08:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778167175; x=1778771975;
 darn=nongnu.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xs/zqoM+iU2s9WJ31pIOecbhbjrDvkfs1gp7ZCM8dnQ=;
 b=NExL/NRtbDoXVe6vluR864Gf3bB/JbRxuWiOJv9SEfEi4o/obAT6u3rOzV43eKbl4b
 v/EezfY1r0mos7hkBh3VOIu375Y0sJ5FPvymEelAwMsnnE0FoCzz08G7UQmnJD/wry/9
 8DlSnjwKOaSKXA3ViB160ZTtC681SWhJxY+DiwyA8JmkfsLFWTRBf5y48iO2gmk0hGZM
 a0U3ftEoamlz+XotBcgpdTdzK5cGe9+FlSOO81dBYLG3FmFvBkCvbNB/QvKd3+kuEK/7
 ZXMkBSEt7Lm4ScOCYf2GgMOB1RBQIpZ5VEVKcWjTG8/LKVJiJpKVWiw1tlVX5f77GXFP
 MgTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778167175; x=1778771975;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xs/zqoM+iU2s9WJ31pIOecbhbjrDvkfs1gp7ZCM8dnQ=;
 b=rSJWT/VgXPw9lx4TkxxblpFSpyiSKyE4Aw0372Bn9rR5tXf3ecojQRto7SQSH1oWci
 LVmkEf3sQySdAyp/QMiS6Jlc7pnc2SStBXNQKcigJknvpGvEsrma0vrfOHwxUDZ9jdpI
 P8dJxtCdecemNlXcIfDG8AwfZ1eWA+TK2VAEROnTD6CmUd4TbAeI4BOCPEtEq5f2N7kk
 d2rtKNOIPx5m3wBFkY7hmuSXONtFeMcAcQTG4nK/4GBXnas15dvNxCm8AFgQBV6fiT0q
 Fc+9ZjcJnP3vxh5oi4qjMO94RouG0G3S019IxNd3MkYd33A/S2tzjX7IhqEQXwTPYJe4
 NTDQ==
X-Gm-Message-State: AOJu0YziOE6YLZaKXN7swiKoP/3j5MH2GFzdH699Wub/ArNCXQGI9aSs
 CmmldwfFPMzeuXSNcLfhJPOKuv2XIHm4bgLUtzyKhPKafhgCYbTKSIfU1EF7cs51+RU=
X-Gm-Gg: AeBDieu2S64MxMW5L2esQrq9kxk/OTKx3WE7M1WE1AYZd6w2+rssrXLI8b4GWzTJDby
 QtApy8PAx68Yo/B3nDqJsI9F9x+XYQZDhHcEvb+eUNiQGNLiQAAJ1DbSIILwjPm2HWjz/vX3oSJ
 82G3dmUmlNPwQ8rE4Pt0gxUcF2+EKG6OZsZ+4nv62Pnx0+3PaQQ11BLDiK2QquI3bCl1gdxC6ba
 9+KMbZb6vj43Eq6ptNu0VHN40zH+/qJ4sk1JAChys1BtFsTPesfkP/en3HGMD+29jth0W3Sl/Iv
 hhR0Q7nSzmsPuT+sSQCxYYStbQr9HY+0f3f4m9XZD0Lh5TvhUmIof74sPm0BwoaE9Xvtp9wlsv5
 62xJnxu66GPDTqlmJSswY6XNXuzzqGQdEy4s7eLe7qsxIeJUN9IRRbqRv+yY4OVqHlI33x97NLP
 0XwP5tJT7cT3VHCm1cwltkf1qNRR4HoHg=
X-Received: by 2002:a05:6820:1844:b0:696:2c6f:b99b with SMTP id
 006d021491bc7-699ab64af6cmr1743496eaf.21.1778167175560; 
 Thu, 07 May 2026 08:19:35 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43454d324a4sm19733472fac.14.2026.05.07.08.19.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 08:19:35 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Thu, 07 May 2026 09:17:30 -0600
Subject: [PATCH] linux-user: Fix a memory leak when pthread_create fails
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-linux-user-bug-v1-1-25831e9bc22e@bsdimp.com>
X-B4-Tracking: v=1; b=H4sIAAmt/GkC/x3MQQqAIBBA0avErBswUYOuEi0yJxsIC8UQpLsnL
 f/i/QqJIlOCqasQ6eHEV2gx9B1sxxo8IbvWIIU0QosRTw65YG4MbfZoVk1KS+Wks9DQHWnn8g/
 n5X0/j/ui6mAAAAA=
X-Change-ID: 20260507-linux-user-bug-6a5e4524d2db
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1566; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=AU/Zar9DdDqbR01R7CWBObodnEm+RdgSnukKekDXNMQ=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBp/K0SeUhnndRPqd5pkufs71r3Oa/zecPz1Xhvu
 HHD/s94N3SJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCafytEgAKCRBsHNEofbAR
 AEUkD/9/uC6xES6gXeu0kR9Epd2KDJPEniGvjF7H6ZeYNduJCnRH4JjGjH2suRUlDZEFuW/oIr5
 GP9FeLm4mLbNLo+tCeQhqONknNN/7nRb31Y7huaSPFllSHjax8BuAY3Rf6q9gKth5o+juzEy1af
 yHrKVpCR5qLpj+jH1vNsGPBs/2Q3whnmvr4ug8Vpt4rpXXmWZgmirvKTNq5iT1g6mgU+YC1wwLs
 p6tJ91HP6fLf4LEAxoNYSLaI8nAFN4jYEROfB4xQJ9xgdewutjkOaPawZHqa5OOl6UqXFgZYzIb
 IZ4hjf1KMIO9SwcQUveoE3zzUxh/MQolE3M1ay/ePlAIuWIXLaRSgcWDcnelblUbvIDNTvS9LZU
 nWlHlualInQ850U1DvUVwBSNq9pf2LnPAS70STPznjh3Dt15Z/v3w1I9Un6cJYb6S5oIrggt3/7
 HIBTnU/6Iav59O1uYfWBRDNymQqdyNGbvGgEZsKu0Fej4o8zRthOV5iXVEJqnRI6jllm5sxL+IG
 XPSpur9tL6ljJDlAgZHH8+Nkd5qgN9ewF7iJK1Jwk4WKkrfQFyLhri1kNmEUoyBN9orFNbfe5bU
 yk7KPsF81PYjEE3LlYK7KYHGr4G778KYGzqYqz5tPTGQmhtZaIJFo8aX9saa8YM/CZZnMBCpWs5
 zK50Xvm/YZBIiCw==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::32e;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x32e.google.com
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

Fix one of the TODO items when creating a new thread: release the copied
cpu and free the task state.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
Free the new task state and drop references to copied cpu structure when
pthread_create failes.
---
 linux-user/syscall.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index d3d9fffb54..7b2e32bcf5 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7005,7 +7005,6 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
         cpu->random_seed = qemu_guest_random_seed_thread_part1();
 
         ret = pthread_create(&info.thread, &attr, clone_func, &info);
-        /* TODO: Free new CPU state if thread creation failed.  */
 
         sigprocmask(SIG_SETMASK, &info.sigmask, NULL);
         pthread_attr_destroy(&attr);
@@ -7014,7 +7013,10 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
             pthread_cond_wait(&info.cond, &info.mutex);
             ret = info.tid;
         } else {
-            ret = -1;
+            ret = -host_to_target_errno(ret);
+            object_unparent(OBJECT(new_cpu));
+            object_unref(OBJECT(new_cpu));
+            g_free(ts);
         }
         pthread_mutex_unlock(&info.mutex);
         pthread_cond_destroy(&info.cond);

---
base-commit: ac0cc20ad2fe0b8df2e5d9458e90a095ac711ab1
change-id: 20260507-linux-user-bug-6a5e4524d2db

Best regards,
-- 
Warner Losh <imp@bsdimp.com>


