Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F4ACE9A03B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 05:23:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vswV9-0002me-3D; Thu, 19 Feb 2026 00:22:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vswV6-0002lq-DK
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 00:22:56 -0500
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vswV4-0001p2-Rl
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 00:22:56 -0500
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-677a11d11e0so226552eaf.2
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 21:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1771478573; x=1772083373;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mA09Hvggqn9GHfS647IvNZqvRSaQAtXYvi8sqI7p/WI=;
 b=s+0L1mG+d2v5R36z2t0LyX9Oq7UYv5EvoIv3fRbsaNOLPgoofXBBv5fTApc0p8BUyQ
 QAwO08pGnZ1JKKlpxSWMAB76CZw6oqTVMAdEkqpr47udlR13Fpg9MoUsCLP25zUYIJZq
 DYk+GLLX2iRcVERhaIOKGRlUa12vsmvoyoJ2NouixnOfZMY04Ux+DhVGRQ3jeeb7qIAv
 +zwNRyiNhXIwKjxyzWtSd1URAWiwWXLZTaMxtSR5Z3Avjl8tT3Q584tPJh+9wSbNawkU
 btMLLEODGjAZI2IpKDw5rvRS3iklI/711V3B236+XTexSUaVb/nbs0RnFDg2R5OyAUhM
 L4Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771478573; x=1772083373;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mA09Hvggqn9GHfS647IvNZqvRSaQAtXYvi8sqI7p/WI=;
 b=OqDiFchhbeRp8OUKkskogcDc9jPqjQ3xCNi/2CF3kNBdxA2rBq/FuJE9EPEVbYLXdA
 +JPTHsqglUWHv7mUWPaBa8svx0Qgmn9HY3TxjUV529KT11jyCIsO5pBcan3MClFmpavw
 owVyNec8i2mvEJb0UVucKiFjGtkzbilSaDPdnWZC75n2O1O+vyDmWwY8Dp5JKNn+XxPo
 jl9fLC+v+E8i/wBNDv/4j4XlISQGkTjblm/QCGPAYcGE8nMJPJsOM1CXUVBIiReHNwIg
 IBtf4hphqMg7FSUbOUv1yFxEel3Vnwhh0E0vnbp0o2M/lu4ZtLXG0Y1fcbJsBTIpHOFL
 kN2w==
X-Gm-Message-State: AOJu0Yxh6HZdJRezgrfmtX39+9NVF186EoW2neoKbbXkEcdf8LuK+S69
 XijE/Y6iwoA0w8vaVTH1VuJTuNRPGMU0rGiY0ALX31GLFrrDqVojlLeNi2+dQo0U6rg=
X-Gm-Gg: AZuq6aIB+7FPa8FMc9Oii6GIb3ZwEtWEdL+n88b9VePJ/V+XBo+6cxIEV/hBzhhP5Lo
 SZRLv/hjJ6SUCxm6cImSQ/y4/2nmNmATiMZotaVZjOr4Uw5nakMajoHmZtNEY9T4XCwK0kj/8bA
 IAG20glH5F6Lexm19oZT8IY2ukhOYW8UNN2WhRXGOcK2g72TDrEoPbFQHs+/RtFyqwJgtpmCOx4
 EBljel5EL9aYadaEi5jiNOpdEXb0ZaHLibR7Bd+rF+tN0IA/Xw1FUr5Fl0eAxMIm77jXnDc/BP7
 EmW+FFKFKQE+Q8k/H15foPRAvl8UFlAE/MywDe8xWl5Rr1AsR8tInDrGxRWsQFtcp8tbv1UxmS1
 vLN2wdQyt0f6AYaldwje3mPIXKwgStnQQgabmS/BEJmX+nMk1bNHXjwPDT9Hj5XlY5NUjrEi0xE
 d1rd5Z8N7b8Q==
X-Received: by 2002:a05:6820:88f:b0:677:592:c1e8 with SMTP id
 006d021491bc7-677697878bbmr9808251eaf.62.1771478573373; 
 Wed, 18 Feb 2026 21:22:53 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-674758eb709sm14215326eaf.12.2026.02.18.21.22.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 21:22:52 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 18 Feb 2026 22:22:36 -0700
Subject: [PATCH v3 13/24] bsd-user: Add semaphore operation constants and
 structures
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260218-bsd-user-claude-v3-13-0137b37b221e@bsdimp.com>
References: <20260218-bsd-user-claude-v3-0-0137b37b221e@bsdimp.com>
In-Reply-To: <20260218-bsd-user-claude-v3-0-0137b37b221e@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>, 
 Stacey Son <sson@FreeBSD.org>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1782; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=JgJ6FfPtrykPcLDTkKP0gkFGiJijVzXyRUIWTkOWj70=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBplp4sGG12VfbZ5/YeG7UOmkUhoVtHpsaLJnm9Y
 RBBHV+fvfqJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaZaeLAAKCRBsHNEofbAR
 AAe5D/9mnf6O5+TN0KOueSYi79KhkYs7cVIxTUMHhuhJDyM1T7nMlayDFtPL26h2Owae45g/p2y
 6yFwkR9YnI5gLqJP62NZwcsUvfWLeGNwQph4JnJEOlxD9vutBr/2orNargqWThD77pv9PaHyGZr
 v4fdjszoKtFyzQ0RDv6XvYwWAWgMdKcBWRKon4sj1M5Apy2WOIC8QuZbydfhcf+7Z7sh/6FX4Jh
 w+PZvpzN7YxBr49ZAgVxETLJKfPlmLZoU/uWObDR/KFh2KzT5EbFGX/mG5uLkt3MDftL7nm7O9S
 XDFWj2NKZeEKB7gQLl6/EdtkCFw61jR4fIb9xf30BUxSglJK/Us2shf0Y5bcdtjFtdV6EroRuCA
 Strf2PbVDyo3yz74qhGUoRSyvTStSsNAf0VxLhGh8qCJmneVOmVIhgcV5E2KwF/K0V5XgII3+rA
 jTCBdMhvhurG22nGSjhCgXlvDH+7FKbq6lu/3RV5p5ttBuvfjPnlJKG6A43QkVUIahtZ4BIh3Z5
 YeTeDZwisUDGVOoJ34wRjDjGBq34JzjtkZpgGsuOPfICRoO1c4K6uq8YNr19ae/wSJ5oUJI9kEY
 qCaXKu2WCFgC66U0/4H5e2Vt38f3oeo+mrqLaBan3sS0s2mu097Xeh7HHEh32zmz2iyAvdm89Q3
 6+R+2zvPL9ukHNw==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::c29;
 envelope-from=imp@bsdimp.com; helo=mail-oo1-xc29.google.com
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

Add System V semaphore operation constants (GETVAL, SETVAL, GETALL, etc.)
and the target_sembuf and target_semun structures needed for semop(2) and
semctl(2) syscall emulation.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/syscall_defs.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index 972bcc425e..6a789b2a29 100644
--- a/bsd-user/syscall_defs.h
+++ b/bsd-user/syscall_defs.h
@@ -95,6 +95,26 @@ struct bsd_shm_regions {
 /*
  * sys/sem.h
  */
+#define TARGET_GETNCNT  3   /* Return the value of semncnt {READ} */
+#define TARGET_GETPID   4   /* Return the value of sempid {READ} */
+#define TARGET_GETVAL   5   /* Return the value of semval {READ} */
+#define TARGET_GETALL   6   /* Return semvals into arg.array {READ} */
+#define TARGET_GETZCNT  7   /* Return the value of semzcnt {READ} */
+#define TARGET_SETVAL   8   /* Set the value of semval to arg.val {ALTER} */
+#define TARGET_SETALL   9   /* Set semvals from arg.array {ALTER} */
+
+struct target_sembuf {
+    abi_ushort      sem_num;        /* semaphore # */
+    abi_short       sem_op;         /* semaphore operation */
+    abi_short       sem_flg;        /* operation flags */
+};
+
+union target_semun {
+    abi_int     val;        /* value for SETVAL */
+    abi_ulong   buf;        /* buffer for IPC_STAT & IPC_SET */
+    abi_ulong   array;      /* array for GETALL & SETALL */
+};
+
 struct target_semid_ds {
     struct target_ipc_perm sem_perm; /* operation permission struct */
     abi_ptr     sem_base;   /* pointer to first semaphore in set */

-- 
2.52.0


