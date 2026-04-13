Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 660B6F34C64
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 15:34:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCJI5-0006JB-3N; Mon, 13 Apr 2026 11:33:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wCJHQ-0006Fs-Bd
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 11:32:55 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wCJHO-0002xT-9h
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 11:32:51 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7d556c1a79eso6249112a34.3
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 08:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1776094368; x=1776699168;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nsZzqiCeHObMh6Bh4gb9lxnGMx8xUKeqe78737tmJYs=;
 b=mE5AamgnBvlkuE6E/JZ6Fzb9SveScsI+5KzL4HrmpVOn8WWLofBrRP2G+ENSEIiJZP
 uaPbfTaJV/P4p8An7e1GtTXiZJQgEUSoK/eA2YwJr4GytksibCeXOefWi0X4LYEQpTkg
 +VX9c1/nbZo7m9hNF+2ux6WRO/m8ow5sqKea4Y6IrvnGdgd5mvf1PsxMhz+AaIo9Oa5G
 +5/rsIInox/0xlnn6ZwRYps1TL8fvencUyZUKnmuEm+3hnWTXJT+HHk2ZDpUQuC9M6kC
 IcmlFGw3FhSEcHTyaNKNx/jR5XOQfKQzdJNtXAzZN3qWhAoAJBBR7SLGOvckAKbDXm8o
 BO/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776094368; x=1776699168;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nsZzqiCeHObMh6Bh4gb9lxnGMx8xUKeqe78737tmJYs=;
 b=nfH2Hi4IEl0nJ9QTyXSljPZ4OmgcmVtWGywv4EAKXhg6196L9QRPrE6iVw9R234emi
 GDzAB8g8pS0dXNauEoOgqVq6zexN4jaYMhdwPRj4Z2p+W7tvSfg/dLvxuaChqKN4RPfw
 jWbxB0+GlpAOQcMFQGMhLefWM1pyvOz291XiLOkn0jS3/ZbMuubW2w2WWE05o0JF/w7t
 NbLAMvjDfGLpWWZUdB/1Uku9qSqjm7o10uoUa7pVhcbK6cQPTyUbYC5U/Bi7tpNjRDKA
 xMTJDfLcQo4b5e11RM33XtPBSr+ouz6dU7odup0oLEjmUU+KUUMVJePUT3wOlxLvNhxb
 zetA==
X-Gm-Message-State: AOJu0YxMQ2gfFPDM2KPtRR8Y0s6o2LZbEKdIdjX0uKbr24mzNUekDj7P
 a3fjTT8HoT2tWILspi15XFy/8bcciGzERMGLteVElNKaybFZmNIabgQ0nC1bgPxtm30=
X-Gm-Gg: AeBDieskE5Yz0oms0ekxdDVj7cw/qi3M3msoyIuAP01tBTXQNPQZdCZK84BBqmGc+iv
 tOuhTaDmArxbZ6ALfj3qnwN5tvrJ5H40n2BT6BLu7Fx2BG5Qmq4OSUdYsKjxgNLK0W5MjNZKPgV
 nPRYhy9irePlzQknr7iCSvMc/zVYfAOv3GURUHmOXZwaFNaQkE1u/vxLwBnqgx54CEIZRAnlf/8
 0haylbur/vJgLbpNvtG4NhtiQyHK+nyvpj/mmzWPNKChorcEVOqi5YViwkF5HRKugVrPxg3aMMw
 XOCy6WSZ0O6sQ9yHnEIwGtFbjLcmVgGUJWlcTCX9eaMOLwFn6fLf/W4wOI0zYTGQb10LY4fER8W
 7zcKUjVJB6G+zcvsCtJk3/az+yeCumuEeIlJfK+EBmyCooAsisZQwum3U2k9qf12Vww98qurzdq
 vwSdQUdK7yrQ==
X-Received: by 2002:a05:6830:34a1:b0:7d7:ddc2:540e with SMTP id
 46e09a7af769-7dc27c6731dmr9772860a34.6.1776094368095; 
 Mon, 13 Apr 2026 08:32:48 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dc2696c463sm8659192a34.23.2026.04.13.08.32.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 08:32:47 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 13 Apr 2026 09:31:44 -0600
Subject: [PATCH 2/5] bsd-user: Generate the system call numbers in meson build.
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-syscall-nr-v1-2-f70408d042ea@bsdimp.com>
References: <20260413-syscall-nr-v1-0-f70408d042ea@bsdimp.com>
In-Reply-To: <20260413-syscall-nr-v1-0-f70408d042ea@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1217; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=X36aYeaQXGyEFGdQRLNGg1zEFe/4/vZEyNQKObpVU/0=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBp3QxoFOiegTWxFcJLWUbeqWWJOK+zsb5C4jrIN
 z4ryM12pMCJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCad0MaAAKCRBsHNEofbAR
 ANHwEADBgR3eBIGzWJLbSwL788y42A7hClJVWYnhRgDSPvMSbNH4jODSOlbK6B5e7W8lvTHLNmn
 svI2fghDhUp7CPF3C+bDM7WzZ6fppMQgqfpjAQl9uKpG/O68wlEqdq427yAKZyPACRjd6oe0y1P
 7tUnnrvINpiKrdaxiEieOZVou9u9sL/2hRh1oxAPTVXkeOXVDfMjASDFYaINwFLQpAnyVV6QwhQ
 wsgYWB2RXB0UPMuVG020RBG2xlW5ghAVPtgb5lGVyXuT4E4WjMpvfKK+hxG5LbR3opDW4CUYTiB
 fpEF3XLKcPM6+jIqNbxT2r77AyrS2y1GSRYSiNng+/hHTO6uES892EbIO15XzzVukb0YXvDbJxR
 WPBUmu7uB5MSlyPkHZ1sCVo9aIfPcXskdLVRNoi3cSjtWlCYPvRHKuWtAfc60JndmBRMQZ4KEHC
 B7HKKF1rnsGrCC5xuPNoSnzfF7U9YHyqDYZzPBWVwF4EW2JKd/USX4PZqtVY/nDFL0Zq6KYKchQ
 tsXvUAYFRNw4sJhCRGdczGzTODSupsvelMBvLRtg+Tu/6CbpVACn7P++8w+tQupbkjdZBiDogQP
 8FPB8C3jMJOy8mBAt5wK36cz8ABHYLK1nGjp4z8lqvd6sSjYutc6hd0tguFF8LNLu8W3qMQhMQt
 3T7qqEZi3gmb4oQ==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::334;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x334.google.com
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

Build glue to generate system call numbers with the meson build.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/meson.build | 4 ++++
 meson.build                  | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/bsd-user/freebsd/meson.build b/bsd-user/freebsd/meson.build
index 8fd6c7cfb8..21d4bedb56 100644
--- a/bsd-user/freebsd/meson.build
+++ b/bsd-user/freebsd/meson.build
@@ -4,3 +4,7 @@ bsd_user_ss.add(files(
   'os-sys.c',
   'os-syscall.c',
 ))
+
+bsd_syscall_nr = generator(sh,
+			   arguments: [ meson.current_source_dir() / 'syscallhdr.sh', '@INPUT@', '@OUTPUT@', '@EXTRA_ARGS@'],
+			   output: '@BASENAME@_nr.h')
diff --git a/meson.build b/meson.build
index ab3e97eb9f..d42d5d47a7 100644
--- a/meson.build
+++ b/meson.build
@@ -4307,6 +4307,8 @@ foreach target : target_dirs
       target_inc += include_directories('bsd-user/host/' / host_arch)
       dir = base_dir / abi
       arch_srcs += files(dir / 'signal.c', dir / 'target_arch_cpu.c')
+      arch_srcs += bsd_syscall_nr.process('/usr/include/sys/syscall.h',
+					  extra_args : host_os.to_upper())
     endif
     target_inc += include_directories(
       base_dir,

-- 
2.52.0


