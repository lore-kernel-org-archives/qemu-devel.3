Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10375E937EB
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2026 16:04:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBxIF-0006XO-7a; Sun, 12 Apr 2026 12:04:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wBxHw-0006RN-3U
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 12:03:59 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wBxHn-0004Vo-B1
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 12:03:50 -0400
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-46808125c65so1218834b6e.2
 for <qemu-devel@nongnu.org>; Sun, 12 Apr 2026 09:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1776009825; x=1776614625;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=X+vpUTgmmUCDm+9ikvEVgt8ooJ9JXNNdESCppn40+QE=;
 b=Pw/QeI20nd1QOLJ2ubLe+nVXfjS2IwoPn6EsFVOn+n4TZxhNL7BlaVRLoKM860/gbI
 0pEWLAuUPobwcV4P4H9v5YxjJUkIfPXeGhHI94iNZBJKntWlTZjJOpq7GBdTzxaWKSxl
 dgzqaGUUsl6aZOF9WSh27l+SJTfN7/6QgVLOhuhXpqhIG0sbOprNL9aZd2UsO4N6VCeW
 xJJjYKc7rYTl6g7xhAiztzeLGkHtOabTSYAWpg/PeMhWhTnJlzQQuwJq0AYVCMMpaQQT
 u82CVOZbr1vr8khrp2MOlfRahHnIg/EZxQX49Cq7osu3fN/PJZpUYNa0QKAcdxtuA/G5
 /+9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776009825; x=1776614625;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=X+vpUTgmmUCDm+9ikvEVgt8ooJ9JXNNdESCppn40+QE=;
 b=ehEeREXE6GGmpkb/uDiEx60GT003+NysojpvBlW9J8I/NM2U3aE9i+j8wa6eMSuFrd
 lpGg5B/fKLEvOiKPOwVT0NfUYjRV+/8K3wvD0cHNkJNm+UqqXwL4O7U+puIY/CasnRk0
 qwTZHWKZGvmLfIJ8j4TrrvD+QYtaJXWqJu9zTmGgyeLciCFQJnZAQ15oPBvnnv6u54x9
 jOtggHE4omiAmOSWFyeRqj0mhGAAKSnBelI/giJi+DQF7INjYKtggZ+tHjS9CtSje6N/
 asq/My9p16FvK+fnFAe1wl6x4X+P2etHtNwtGgOW5rg4Tl0WHBaZYB9KSAtESV/EQy2B
 eoCw==
X-Gm-Message-State: AOJu0YwkAEQFn9WxAxKyNNHHRRgFNpBdbrwU0LZWKnz8V/bAfrD2VNIU
 iobRzA+o57jP+LPZyZf3UalESIs2IvkvUCBHvxvS1+0EUf5SyWkgQzBJoKVFcd4POBdjY8EcItD
 cxb/ypP8=
X-Gm-Gg: AeBDieumgPJKR8qEmVtVol8sFpyus+qb80kridoonKW+9jLxJiFOJQhlElVvRkli+s6
 SNgDW76WX+h0/O/GZyxfsaRjWAdPs69zsXZp4S5MGHcLxHz9AaM1q4qgM5S0T1rbfPbrqpPFAng
 z9Pyv+dqxI9CWWT9blQ39WVnkORcn/P1umYSH5akJWRNm2D+kiMj4irHdVgM3UgGR8pUCk4ifSN
 0NmkgIaKe/0eS30gWOrVF2Byh8GniMSWuU+smCbO21Ybu7XIPWr/LsVYCeccZXISP+pXz3TMGZu
 VB5Yzpc8VCW1V/8swRKfrwlZgpdfE3Ys3tm/YVhLgorqEcK2FA9JXNesqfyVxc/FyiX10SFG9pD
 KtNDZR2QcM2Xd+M+hQB2gTHQvGajrORjgJ577qA3STF4WpUnDAOndpocL+aL/Da11alh3WyWN1e
 WujboWdy+GkA==
X-Received: by 2002:a05:6808:180a:b0:467:ee67:d2cb with SMTP id
 5614622812f47-478a0f16aecmr5426944b6e.41.1776009825512; 
 Sun, 12 Apr 2026 09:03:45 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-423ddbee0fesm6457006fac.17.2026.04.12.09.03.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2026 09:03:44 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sun, 12 Apr 2026 10:02:33 -0600
Subject: [PATCH 10/17] bsd-user: Add target_sockaddr and safe_ioctl to
 syscall_defs.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260412-ioctl-v1-10-1d998a460560@bsdimp.com>
References: <20260412-ioctl-v1-0-1d998a460560@bsdimp.com>
In-Reply-To: <20260412-ioctl-v1-0-1d998a460560@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>, 
 "Stacey D. Son" <sson@freebsd.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1053; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=1aWdqqfETnObSvDu3kjSpmHIrNfg8gEN8mkXnAbEnzk=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBp28IgU4KtGlGg8nMCBZKzl/nASQ/NTNG1UZ6xc
 JWnGSwD01aJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCadvCIAAKCRBsHNEofbAR
 AAVuD/46WAWQsX0tu7IVwahTsnM3Aj3pAO7r5x/wP0fMui+YvXwUWl+8gk+L6suYChjxYOEYelu
 oJQcyioV8SAgb50CHlcwr860QYBTwIgslYytACbGpO6vvOZ2FA2tfFSTX5xeIeNaK1kIwsJI35P
 BRX8P+qbsJFH9uzlXktXu9XLhoAR76FkvMTSKV9lSIRQQkZYjHUMpwsgFlaCJfuHgqsU5L6NE6z
 w5l30iZ0unSYJv7+mJ+KcI71fFXEn7QCShoShdED9gdPhIblbOqN3bMJfAolDS77bW9IpMpRgdr
 v9pyuCg1nNyYVu45QCi/cDmE1ItuAPqPA95iwXmJatu2zgc2ZGnHRrEAkspx6sKSAnycV2176lN
 V6I3Vm/ujn8cy56Id43uPnpD2YpN4MhE554B95A0f7+rZ6IAF4/wV8be19RhNVSvaDFKJ0hNLJz
 xGLVmgHOKj4WiiM/9i0WeQSlQE8/Hdb787IHvUNe2q/UpiWSKY0P0v74S8UNQ8Z14Dn2cXYBjPa
 B35zUCvgTftq/FIxWOZ2EriHhEgd81U1si2CwFwGXuYDrknvtb1gBdB1kU5zshQ8nrd4soiJn4Z
 F1B7KQHJnszuSp/swKV1hJ8peoBO7SiV0iTStSWHskqx2Tvm08elrO0wudAcKdycTxpBlisgi4G
 5BhkcZdV/Py9hlg==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::231;
 envelope-from=imp@bsdimp.com; helo=mail-oi1-x231.google.com
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

From: "Stacey D. Son" <sson@freebsd.org>

Add struct target_sockaddr definition for socket address handling
and safe_ioctl macro for safe ioctl system calls. These are required
dependencies for the ioctl emulation subsystem.

Signed-off-by: Stacey D. Son <sson@freebsd.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/syscall_defs.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index 4dbd90c2f1..873aea2fdd 100644
--- a/bsd-user/syscall_defs.h
+++ b/bsd-user/syscall_defs.h
@@ -565,6 +565,16 @@ type safe_##name(type1 arg1, type2 arg2, type3 arg3, type4 arg4, \
     return safe_syscall(SYS_##name, arg1, arg2, arg3, arg4, arg5, arg6); \
 }
 
+/*
+ * sys/socket.h
+ */
+struct target_sockaddr {
+    uint8_t sa_len;
+    uint8_t sa_family;
+    uint8_t sa_data[14];
+} QEMU_PACKED;
+
+#define safe_ioctl(...) safe_syscall(SYS_ioctl, __VA_ARGS__)
 #define safe_fcntl(...) safe_syscall(SYS_fcntl, __VA_ARGS__)
 
 /* So far all target and host bitmasks are the same */

-- 
2.52.0


