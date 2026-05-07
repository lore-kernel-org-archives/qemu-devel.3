Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA485CD3436
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 02:25:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKoPq-0006ZB-Uy; Wed, 06 May 2026 22:24:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wKoPp-0006Wh-Ab
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:24:41 -0400
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wKoPn-0007gV-Ra
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:24:41 -0400
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-662efd1bdd4so203949eaf.0
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 19:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778120678; x=1778725478;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4gIyjcjDwEGY+mpVVIiM9bd7yEozKdmCDd7sqT0gqEs=;
 b=JdaETejZk346FA1cOXZePTSAmOdl/YKl08+8iKVPhQX+Kx9aTIdICKKzVHGZtgPamL
 uJZL/3IRMV31O5OC75ZZOFG2cgJlsPGwpbNpWGunrZHPLPY7jZYp4iqYV7vbBQ+33++9
 lpwPZA/WzKnqQ0tUsU4LaUl07mfHnFQB1Gzz0n1bX3QySiC9WEk7sQquhbeRiWukNekz
 J5c/Vg1haqxY2dqoKJ0a4njt8tYIrenD+YFSx9IJD65Xvy+c8ivvJYB9GdDWdqQsmzw3
 DavMFzeQYNthx8/pqN+AOe5VZyRPGgqtNXDvla+uc8+cNQxY88/Q2F5zXiEQLZXDShsx
 f8bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778120678; x=1778725478;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4gIyjcjDwEGY+mpVVIiM9bd7yEozKdmCDd7sqT0gqEs=;
 b=b3rVNPkRzQe3B9d7t4eHuh28ZXLOfvPOt+Cfxhw20iTHG3CdQFFdt0gjLs7ivrqGs+
 /8Qz6EtkQqWw+wl2wBzgPROt5HYxhZzDgDVux7Nur3pyMX7FzBy3BCKFBGiiECP70Fmv
 p5jJwe5lsRudYwkiYCgD3QZmeahalp9UZS5g9lb9s6XTN2T3Utrq6Llk8Qz/flZ5ZqPI
 1IPGiS1HelLbcSgzmaHw4WGWbdVXCBifBB9EnWIMlLKuCYZjVKhTsWNxMv1zp2FLTXVo
 T1C3pMwhPVO6iy50gVAzqgo/RGC5uAyIjzPldwcx0JkusMUq+O8jgUm8FsmkaS+21e5S
 5kYQ==
X-Gm-Message-State: AOJu0Ywuhz09dt/mL749ZXe8KXfBP9DoYgR/BmTOb2bOWm0q2icKo7UQ
 41WE4gJ+/1fCBEpi0NWI4CDUAba+Cqn43n0Wy8B3Bgt2rDE0qNHNtx1ggq+JLt2VYrm4XDkntiC
 IkETyTD0=
X-Gm-Gg: AeBDieuFPioj9DyiCdITNlO/+1HUFWtnjAC2+lsXl1OQB3xhuQTS7qzlXoE+pcTLI5U
 RoV1oRWGroxlGpZMvYsCHSUERorze8pTo3I5xX3aLzqmgHbb4NQekSF0ZTUifaFtkcnJ+75tFBw
 p4AqyPaHBqOFRefmBxsbWMRk27DGFq873LayWTnQaD0KsJpzOs6mKwhE3LpSQ9HlLcw2aJadVGg
 Xevbxc9qRw+DtRFI+r4buQUsvI52eSVYaDTjN8BPe7Ie8GdH4SERrTorm82N5rnRB1AvhfIOr6f
 zd3gbSbQKoxtBbLFN2//DU5LrjhXrt++fVqD5leX8XC5/+1zFzYzGurbSgHZIvoK/CHCdmwqlsF
 cVgKHBRQjF+/Swah+4G17pOMgYDrmX5N0+WmYQhhz/jwGg/ynhD6N3cvlNOs7xJADGZay2VdAG+
 al/7cvLXjPAdgf3oj0XMWn
X-Received: by 2002:a05:6820:4c10:b0:694:86f7:bbf7 with SMTP id
 006d021491bc7-699ab5726f5mr552347eaf.5.1778120678530; 
 Wed, 06 May 2026 19:24:38 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-696896e72c4sm11088118eaf.9.2026.05.06.19.24.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 19:24:38 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 17/25] bsd-user: Add target_sockaddr and safe_ioctl to
 syscall_defs.h
Date: Wed,  6 May 2026 20:22:11 -0600
Message-ID: <20260507022219.44171-18-imp@bsdimp.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260507022219.44171-1-imp@bsdimp.com>
References: <20260507022219.44171-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=imp@bsdimp.com; helo=mail-oo1-xc2e.google.com
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

Add struct target_sockaddr and target_in_addr definitions for socket
address handling and safe_ioctl macro for safe ioctl system calls.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/syscall_defs.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index 81f567cb33..0612be8bbb 100644
--- a/bsd-user/syscall_defs.h
+++ b/bsd-user/syscall_defs.h
@@ -537,6 +537,20 @@ type safe_##name(type1 arg1, type2 arg2, type3 arg3, type4 arg4, \
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
+struct target_in_addr {
+    uint32_t s_addr; /* big endian */
+};
+
+#define safe_ioctl(...) safe_syscall(SYS_ioctl, __VA_ARGS__)
 #define safe_fcntl(...) safe_syscall(SYS_fcntl, __VA_ARGS__)
 
 /* So far all target and host bitmasks are the same */
-- 
2.52.0


