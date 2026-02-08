Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 203C5EF06E3
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Feb 2026 19:30:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpAT4-00031g-EJ; Sun, 08 Feb 2026 14:29:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vpAR7-0000dJ-Dx
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 14:27:15 -0500
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vpAQl-000052-2p
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 14:26:56 -0500
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-669f0b0290fso2107107eaf.1
 for <qemu-devel@nongnu.org>; Sun, 08 Feb 2026 11:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1770578800; x=1771183600;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kS+FxLUGWYLC1nwSoO0by1zO1Afg4TGqPqgu75Wprhs=;
 b=17nmKko+E/lpOrVC9svrw4nly51tRQ4Q9fJSfcfH/WzUFzx9TKqEOMK5COAfLud8Re
 /9c/KMk/1wa6khJLrhknOzoWtFG8C1cyRFjtfKRWzh/PBRQSUozqHg7MTHi3MvVxmKf8
 eXhzMK0Qy8F+hriuS8zg626APd1STUwxhsyyYf1DyWXMM7iGflcy6QfT6Q9gESlyb2h2
 aZMsILDrtZsn3Etvgb/uDfd1Bzsl4dKHucZtepfB5uqRXJymD1YWepxp5IrGIHEI+irs
 uhr/A4EMdY2TXHlSI4+Px7bcpY0IbjpwVVXFJtriw5EiZbUYA7YYIo4SeYbkeNfCg6cL
 ZYZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770578800; x=1771183600;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=kS+FxLUGWYLC1nwSoO0by1zO1Afg4TGqPqgu75Wprhs=;
 b=ASbPuWG7sb4i1bprCA+9QVZEaGiA+d0X1EcBVkU1ooF2mZBlEaZ/XyaytlQEanjVkC
 SyINQSolxQBjEVgGS3el4uyei4DjmxEkgMKouIQxAI7PBhdmoNtNk/Zj1UWlFkwtY8sa
 78M2yKGG4tl9Qi1FvgeuP4T4BPlr8Q1b8EMXEvi/PsgYHdB+RrBWdT4ktyYajjElJd8O
 jBzjztnCwsCVqp3XljIlrutBxCDzwQyWGdSlLVbsU3GMeJlcxM76tApDk+8cm7X0a7VH
 ugHuFvDn5v/sY8cMACSGjGKAgDkFleryUE1ty1KwnKqpUCqunTzlwR7SKXPIAxwBlaDD
 POwg==
X-Gm-Message-State: AOJu0YyeyDTKtygj5s1B7J9D1t2VKgEJqKa+sBWcFyAtVt/M7yY2V+UJ
 DAfr7Q2b95HCGCUbC2c5BGMVlrJtxGO31HloZD1mL1JaftQnLvB1wjmZDlFxpZX5wnU=
X-Gm-Gg: AZuq6aJTcbbDI3IxjRTrkbqSQXfdRDSYWBdOLGS7EmM7TLs7UEKYKnj2dqxHgTg7k2y
 rQNeFgpBD3kDpkjcUklbg75eUSNtKh0FlSB24QJzDsXdt9psBLN8pUp/2hGYfQU/7Nw1a3jKqjC
 +Kj+5/U54bDfgJ4cqs1HJn255ZBtzoIDiZWWO6mwbU5Zm5eja6fcBNdAHxdZo7TMoqQAPkWQGBd
 qD98o3G1H6y/kCYkvz79bTBlUlgN9UvK3TPjrBbgHxbzB3kkJSO35TG0qnRHgGlog2gQR52A3oW
 z9baxE9ARV1iWAdSDxJ/HZ+cJbygUUxWV4XgQpBeVn0PuOIKpGrvFqpajfpc6IszivlPUfZ4Kz7
 qlrrXxqXBiJGHMuX+7CGFqNHJILBM+goUXqvvIo9q5JIQBA2mx9b1GIs3Xa5KbKoqFsJPOYCokg
 ==
X-Received: by 2002:a05:6820:2010:b0:669:fb20:e9f0 with SMTP id
 006d021491bc7-66d0bea8c50mr3980344eaf.50.1770578800454; 
 Sun, 08 Feb 2026 11:26:40 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-66fdf303607sm1741301eaf.14.2026.02.08.11.26.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Feb 2026 11:26:39 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Sun, 08 Feb 2026 12:26:21 -0700
Subject: [PATCH v2 12/24] bsd-user: Add host_to_target_msqid_ds for msgctl(2)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260208-bsd-user-claude-v2-12-58e5fcfdb84f@bsdimp.com>
References: <20260208-bsd-user-claude-v2-0-58e5fcfdb84f@bsdimp.com>
In-Reply-To: <20260208-bsd-user-claude-v2-0-58e5fcfdb84f@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>, 
 Stacey Son <sson@FreeBSD.org>, Brooks Davis <brooks@one-eyed-alien.net>, 
 Sean Bruno <sbruno@FreeBSD.org>, Mikael Urankar <mikael.urankar@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1823; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=w+zLwUowI8yjbhBidFtj/kJkjt0tPPhU2WqFAMGwMPY=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBpiONg9fZAV+nEtDYj0R8dgjG561ilHPjr9zZrY
 SgzMq6tvr2JAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaYjjYAAKCRBsHNEofbAR
 AIrkD/9FxaMjW6Gs+3XACo7ZyimlGcLIrpaDQEiUrza1M1ze1zazAI+QI7qtnGXhnI0XVpS9uIo
 JK5r9fvDQqtcqYX9koP9s6io1mMrk7Ti3mLna3CZnMaCxUBKx1wwa9doG1gNSFjmN5hqWqIHikq
 rKCJHDLwWtUHZPg4rRVs0xvGgChznm+fuWq8OAJzf6UvTpXNQdpZPTkIlmJ/wS+6j5t7N5HojKo
 BQmVlsngpENeYy/vpMYqKo09a9ch2WIOOaL2sULbUGbLQzpjAVAMwRMRjukd3HXNTNOx1ZvywMI
 mFSuaZqSIGq0RjbpfoNPmc0ShW+WUYsjPkAesVcB+xE0FZ4Iq84GeQKkdbmLF6raUvvaKUtpfzQ
 faCr0QRLA+lIapQvT+dmlay+qqfl4eKvwogLxfNYHDMdQV/S4I0EJER05uaS89Cz4qQ7/en5YiE
 C18vf3O/YnXoaLY3U4l5zCCmTu/vm20Rjy933tKc3crGUcCO50zi4cxcPD0B1BjMG7tMyZZqewc
 DmJgWW7vphZ8Lm2C5aZNo7dyG742/qY2SBjwdsA2Lz5K52loBvzAIeqgNUUCeYhTe2vTQUtzKxV
 LQ121ssWIDhfukBWJYxH1o2PKtTiQoCJTh99JP5A0EbDt/VN+jDCaTN3nVMtI1F3Gki/EcCWwLf
 d2xCRIktchV6cNw==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::c36;
 envelope-from=imp@bsdimp.com; helo=mail-oo1-xc36.google.com
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

From: Stacey Son <sson@FreeBSD.org>

Add host_to_target_msqid_ds() to convert host struct msqid_ds to target
format for msgctl(2) IPC_STAT operations.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Brooks Davis <brooks@one-eyed-alien.net>
Signed-off-by: Sean Bruno <sbruno@FreeBSD.org>
Signed-off-by: Mikael Urankar <mikael.urankar@gmail.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-misc.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/bsd-user/bsd-misc.c b/bsd-user/bsd-misc.c
index 62362e8204..6163b7ccf8 100644
--- a/bsd-user/bsd-misc.c
+++ b/bsd-user/bsd-misc.c
@@ -177,3 +177,30 @@ abi_long target_to_host_msqid_ds(struct msqid_ds *host_md,
 
     return 0;
 }
+
+abi_long host_to_target_msqid_ds(abi_ulong target_addr,
+        struct msqid_ds *host_md)
+{
+    struct target_msqid_ds *target_md;
+
+    if (!lock_user_struct(VERIFY_WRITE, target_md, target_addr, 0)) {
+        return -TARGET_EFAULT;
+    }
+
+    memset(target_md, 0, sizeof(struct target_msqid_ds));
+    host_to_target_ipc_perm__locked(&target_md->msg_perm,
+                                    &host_md->msg_perm);
+
+    /* msg_first and msg_last are not used by IPC_SET/IPC_STAT in kernel. */
+    __put_user(target_md->msg_cbytes, &host_md->msg_cbytes);
+    __put_user(target_md->msg_qnum, &host_md->msg_qnum);
+    __put_user(target_md->msg_qbytes, &host_md->msg_qbytes);
+    __put_user(target_md->msg_lspid, &host_md->msg_lspid);
+    __put_user(target_md->msg_lrpid, &host_md->msg_lrpid);
+    __put_user(target_md->msg_stime, &host_md->msg_stime);
+    __put_user(target_md->msg_rtime, &host_md->msg_rtime);
+    __put_user(target_md->msg_ctime, &host_md->msg_ctime);
+    unlock_user_struct(target_md, target_addr, 1);
+
+    return 0;
+}

-- 
2.52.0


