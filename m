Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6970E7718B
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Dec 2024 17:05:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRDlP-0000l3-Ob; Fri, 27 Dec 2024 12:04:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dominik.b.czarnota@gmail.com>)
 id 1tRDlN-0000kT-QA; Fri, 27 Dec 2024 12:04:37 -0500
Received: from mail-qk1-x72c.google.com ([2607:f8b0:4864:20::72c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dominik.b.czarnota@gmail.com>)
 id 1tRDlM-00044i-13; Fri, 27 Dec 2024 12:04:37 -0500
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7b6c3629816so360746485a.1; 
 Fri, 27 Dec 2024 09:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1735319074; x=1735923874; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nW5q9sfNRrykMumwkGRsHtr3G94t25PdnSrIWjuC35s=;
 b=BO/tTJoB35E8FC6t+XnuL0a0J2QR4NjHYv9X25Iiev7smJDTE4gAUqF8B493H9Nnzy
 pgOXD3sbcgsF0QMK9kA+NfB7XAuYXInEcJ24YYqKtKJlg8eCOuQQMal2GbzYL3+BY2ZN
 mngpQyxZT0CHIUaKhP+ty5FsAAEtMeqdkeRjOBPSlI08Xgad+daDtUBhCuSBYnQ02u40
 YD76thErAsPV6YflkJIEOQVV12CphtN4l7f6n7HQHyItQ864y2Q+/tRwlksFd9VYTYtS
 xn6vuCtHfsHnI319VWVM3Ximt5BKlmhAkcGZYkleADM0wmMfNgJQSNVsbhT2wjXeQleY
 Z7Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735319074; x=1735923874;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nW5q9sfNRrykMumwkGRsHtr3G94t25PdnSrIWjuC35s=;
 b=KIQ0tc30TXhobsOjsT2uoRzGsO/zz6kmfxTZExft7KIOOF9eZCRtcm+qIjV0fH54qc
 EhsEVPoEknyBo8viX+Rdoe3ylwBU4GXqTJLyzOm1TYpgjrqmOJHPsCGzyunDOJ+03bXY
 js++grRCiBxHjvuz2Vuv9rCKwW7k7CFS7jwUO1INQV2Z4yQOZfRSTn23QoQVLsiolAuy
 7RNlq7rxeQWyc0gAxNvSeIt40nW/3IhRbQFczuevwzCRwmUDSD0AKF1Fjm6X7iUejoUE
 8r4aQIYba4ZcNfyLoJQSZrnWnl8YquKhoDwh6WxVdozx+HBQT6Vs3rQHIYXAhA7GKavN
 yGfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPm6Axg5uud9+NBDfoTaEsa37kgXrSzhANrH+MdjdSDQlvVmVcZRToMT3TutrpDqWjM0nE4arzLkLrU4I=@nongnu.org
X-Gm-Message-State: AOJu0YxOsICysctFSlo8Mu9AVxFrk4kRkRdQ5VLBdBY1TylKGx2cR6DG
 6lodKkm9lqGX9aN6MWcxkQOMvMZ9FvsPYT1NmJr+ib5h5Ajm+KGazaEyqRB7wW0=
X-Gm-Gg: ASbGncv70SRA0c0/rRhQ1M76MLMUOzFlJzl79ItFue29K5+e8/xXU2fdXY8axnpOnaT
 XGoPY0X7J+uE3kzzZZ7ET+3jVf4EKoH+tHngb9BsQJmYx9gTjkeKU5XuyhYCznfWCYJyn1B1FHL
 vcGX2WvjZ5wyFzHhovcTDN211zj2qhGov6rr9RxpB4/fhhiSxdxOx1jlpZtQxfneG/HmOUgVtGY
 Q4PNlwu+7ROIsM74NZKLgOO6ciWSNpHLx1v1/RbEtDC/xevd0qMuZ0MsP9998QgzJOtHbuNSPqu
 WW5iv35++3sONm/LDg==
X-Google-Smtp-Source: AGHT+IGpOUJ+3dTsYSsn4Ra1hlr8TTpQCxSR5tl7GrtPhdA3dZX/joYBqcZnUS5i9GDRf7fY2aWDJA==
X-Received: by 2002:a05:620a:2492:b0:7b6:e697:2090 with SMTP id
 af79cd13be357-7b9ba6efae9mr4018702185a.2.1735319073712; 
 Fri, 27 Dec 2024 09:04:33 -0800 (PST)
Received: from localhost.localdomain ([151.217.199.135])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b9ac480ea7sm711371185a.94.2024.12.27.09.04.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Dec 2024 09:04:33 -0800 (PST)
From: Dominik 'Disconnect3d' Czarnota <dominik.b.czarnota@gmail.com>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, philmd@linaro.org, qemu-trivial@nongnu.org,
 disconnect3d <dominik.b.czarnota@gmail.com>
Subject: [PATCH] gdbstub/user-target: fix gdbserver int format (%d -> %x)
Date: Fri, 27 Dec 2024 18:04:13 +0100
Message-Id: <20241227170413.72438-1-dominik.b.czarnota@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72c;
 envelope-from=dominik.b.czarnota@gmail.com; helo=mail-qk1-x72c.google.com
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

From: disconnect3d <dominik.b.czarnota@gmail.com>

This commit fixes an incorrect format string for formatting integers
provided to GDB when debugging a target run in QEMU user mode.

The correct format is hexadecimal for both success and errno values,
some of which can be seen here [0].

[0] https://github.com/bminor/binutils-gdb/blob/e65a355022d0dc6b5707310876a72b5693ec0aa5/gdbserver/hostio.cc#L196-L213
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


