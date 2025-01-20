Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FE6AC02182
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 22:30:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ta0H0-0006GL-9f; Mon, 20 Jan 2025 17:29:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dominik.b.czarnota@gmail.com>)
 id 1ta0Gx-0006G0-FD; Mon, 20 Jan 2025 17:29:32 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dominik.b.czarnota@gmail.com>)
 id 1ta0Gv-0002d0-HY; Mon, 20 Jan 2025 17:29:31 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-aa689a37dd4so939631866b.3; 
 Mon, 20 Jan 2025 14:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737412164; x=1738016964; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JNuI6F34CaAr2EXYPzwQhJW//zyLJWT68fhJ/Taz9IM=;
 b=MKDTx6/WjpJ9VsaYMzzIY4Kb4GTq6dQSXCoksmAJkMoKuS27ARLqQpAQPvv/tgXyLU
 tvsZLULmlwRq0HF3sF0DE9TeoWBe8dEWyNfBQqxC1aFaZ70qVwQ34+QPdeTwZecV/LLp
 JEGkfscMFJWVjLiPfXXqoa0T6yRP8Mc6vGHy8WhUCPuqm9xY/bbq/yPiE+XLT7XQGS6E
 2POyvakdE3N3eLWgFRxFmBqgjSCvu1F6OG4Nuj/HQ3uI0ZevWK3ILfJmRvnSkv9xqQkw
 RcQ0m8l0CnlyD9RTrIsGHL5CR4GngcEFoIhjVr+qF5uid2ZRt8PxDltIeU5d4DO89vE0
 D2+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737412164; x=1738016964;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JNuI6F34CaAr2EXYPzwQhJW//zyLJWT68fhJ/Taz9IM=;
 b=Gl1VOTVOzuljwZmzBEhp3QptHLTVGO+Utioii+KPtsK9CLZ26dRFuXk2aFV4nv01P2
 +R4t2ZOl0MrPnrCSMIj6TxgUWOTT3zKJYfg8GmCJxrEKB5LSNBMda88SaNXZKfjKS1mM
 boBYKDumAR8v6zb0EDAcRFKEj3wCQchfoHy2tShSZ9MxxugBQAz91yxdTMlBw0Ay5/MF
 4+Q5w7f7TNcWDSyH5LQyfu5xCGhE2PUF6oPpzPdmtxCSLUqMRPfTrnK88h6htgxkVbH6
 MBen4XSWxy+jqnFFOUQs7f2t0lOa6XpwxwfS5c3oAphCi0C36uxERC6WY4G5L5MPPXNn
 40IA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWC4dD1MMRHcld6qaFYKSVfRVr9Ggbes5e4UPQq6HtcpyCnmELWz2x9oBvt66xQWxqY/xWW+yHomEzledo=@nongnu.org
X-Gm-Message-State: AOJu0Yz3r69ZEOkg+Drw7BAmIWl113q/o8V/vRooaSmHRysPvDCG5rCl
 OdjVgMxTsx98UA8ePYKTJ0r5SWa9uuwSbkdYgg4Q0rjySa01+hHCu7w7Gb848AE=
X-Gm-Gg: ASbGncvFBxGyywp8c84ESDPJhdoDsQm2cjT6A/NkvIq5Lpe6I6CETJer63TbSfo7EBt
 40YsA9Jg4hwD18Qf0VH/2IC3fsmHa9w+jydtjn63Uhax/aIcd9nmqyEO4XFeckNkg+OD2X1JPv5
 CFdESsb9czVwJmS/0Oedj7eilO4LbNp3VskGn2uC8bRuXTJTmVe2umBLA8ckO6T/XOyxJnqNZe4
 DOswedQDx1BDtpGPJ/Up4ANuPN0+25L7rq5E2u8wK5uMmFIaV2lVzVmG9OzkOUAY8tFdo2r9FI1
 ZrCqxNOe2zK+kEPAh6HiuVMLdvkbx+MKLsMRloi2kT4k/E8ZALH76IBB8wpB9A==
X-Google-Smtp-Source: AGHT+IHxbu9QV4aDQTFRArTihgj854Qug58xAo6INuqie8Bj6RquCPYC2mPQ8xPamcrRp5yb/udXYA==
X-Received: by 2002:a17:907:7faa:b0:a9e:b150:a99d with SMTP id
 a640c23a62f3a-ab38b1b45aamr1454180466b.5.1737412163852; 
 Mon, 20 Jan 2025 14:29:23 -0800 (PST)
Received: from localhost.localdomain (77-255-209-16.dynamic.inetia.pl.
 [77.255.209.16]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384f86fe9sm672380266b.135.2025.01.20.14.29.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 14:29:23 -0800 (PST)
From: Dominik 'Disconnect3d' Czarnota <dominik.b.czarnota@gmail.com>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, philmd@linaro.org, qemu-trivial@nongnu.org,
 mjt@tls.msk.ru,
 Dominik 'Disconnect3d' Czarnota <dominik.b.czarnota@gmail.com>
Subject: [PATCH v2] gdbstub/user-target: fix gdbserver int format (%d -> %x)
Date: Mon, 20 Jan 2025 23:28:58 +0100
Message-Id: <20250120222858.39547-1-dominik.b.czarnota@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=dominik.b.czarnota@gmail.com; helo=mail-ej1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This commit fixes an incorrect format string for formatting integers
provided to GDB when debugging a target run in QEMU user mode.

The correct format is hexadecimal for both success and errno values,
some of which can be seen here [0].

[0] https://github.com/bminor/binutils-gdb/blob/e65a355022d0dc6b5707310876a72b5693ec0aa5/gdbserver/hostio.cc#L196-L213

Signed-off-by: Dominik 'Disconnect3d' Czarnota <dominik.b.czarnota@gmail.com>
---
 gdbstub/user-target.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/gdbstub/user-target.c b/gdbstub/user-target.c
index 22bf4008c0..4bfcf78aaa 100644
--- a/gdbstub/user-target.c
+++ b/gdbstub/user-target.c
@@ -317,9 +317,9 @@ void gdb_handle_v_file_open(GArray *params, void *user_ctx)
     int fd = open(filename, flags, mode);
 #endif
     if (fd < 0) {
-        g_string_printf(gdbserver_state.str_buf, "F-1,%d", errno);
+        g_string_printf(gdbserver_state.str_buf, "F-1,%x", errno);
     } else {
-        g_string_printf(gdbserver_state.str_buf, "F%d", fd);
+        g_string_printf(gdbserver_state.str_buf, "F%x", fd);
     }
     gdb_put_strbuf();
 }
@@ -329,7 +329,7 @@ void gdb_handle_v_file_close(GArray *params, void *user_ctx)
     int fd = gdb_get_cmd_param(params, 0)->val_ul;
 
     if (close(fd) == -1) {
-        g_string_printf(gdbserver_state.str_buf, "F-1,%d", errno);
+        g_string_printf(gdbserver_state.str_buf, "F-1,%x", errno);
         gdb_put_strbuf();
         return;
     }
@@ -352,7 +352,7 @@ void gdb_handle_v_file_pread(GArray *params, void *user_ctx)
 
     ssize_t n = pread(fd, buf, bufsiz, offset);
     if (n < 0) {
-        g_string_printf(gdbserver_state.str_buf, "F-1,%d", errno);
+        g_string_printf(gdbserver_state.str_buf, "F-1,%x", errno);
         gdb_put_strbuf();
         return;
     }
@@ -375,7 +375,7 @@ void gdb_handle_v_file_readlink(GArray *params, void *user_ctx)
     ssize_t n = readlink(filename, buf, BUFSIZ);
 #endif
     if (n < 0) {
-        g_string_printf(gdbserver_state.str_buf, "F-1,%d", errno);
+        g_string_printf(gdbserver_state.str_buf, "F-1,%x", errno);
         gdb_put_strbuf();
         return;
     }
-- 
2.30.2


