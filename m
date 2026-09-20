Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16A86C982EB
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2026 05:21:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x89zP-0006WW-TA; Sun, 20 Sep 2026 01:21:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x89zN-0006VO-Tk
 for qemu-devel@nongnu.org; Sun, 20 Sep 2026 01:21:21 -0400
Received: from mail-oo2-x16.google.com ([2607:f8b0:4864:31::16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x89zM-0002DS-6E
 for qemu-devel@nongnu.org; Sun, 20 Sep 2026 01:21:21 -0400
Received: by mail-oo2-x16.google.com with SMTP id
 006d021491bc7-6b390bcab0cso1111771eaf.2
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2026 22:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789881679; x=1790486479;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nKe7LLTqkRkvtpxWs6z0GvFfhDsAnPyVD3zRaVIR3pc=;
 b=yrIIvBzRjZnVyAlCjANy7v5695zsDmUeLpUevcvdbn+wFuKzpZYOZP1mc3rPngYCD4
 iDdRxds92sNPyhL/biX0Z+PobLw9NjYxuJOk1xbu+ZQY+ucooxyFOOxvNTOKnPxLAPNl
 bnSijeYK+9L3JNBDYHW2cID+Bp4JXP6oTCrLRbUqQSX6icl7GTMsdd+gGiQeG3JmNIUM
 odCB/EFljS1wdzqUa2vQq6AkLilr2q1d5ojkkLKwfU8ri0anSkaLhxqXLCBeMLEhPO3J
 SGit1CoooVt0Fl0Tm/bU1W05s2kdSjKKh0BTskTDRk1b/3Sd7RQ9pTK0mWU4GKdrWmui
 PLmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789881679; x=1790486479;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nKe7LLTqkRkvtpxWs6z0GvFfhDsAnPyVD3zRaVIR3pc=;
 b=EX3Fgpi3yOu711PAS+voRuE4vBt9rnl48ML4jobiLj7jUYn8uNYQmpeM+rVeh0W/Yu
 HlbpuMl4AV0h5bj63/j/Cv+8vTzqPnokM59HwJDL54eoqhfWu+CTBO+9D/44h50NBJCN
 zPCVJM9SnCsKucZ2vhffOxuYidiGcTMwo0NasC7xaRjlb+4Uk69UZJLdLbEI8YCeLqmB
 ndacgmDIHdWzhEfhbsIFXibycEKBBiSFe4EV6bfHXdZFxKerrBASq1aieaM1i14IEb/7
 fi/oF/mJhnV088VpXeuPwNGJar/n5wsodmoQFM16PYy0M9CkWcg0gH3xfbtq2jYLNn7B
 zVuw==
X-Gm-Message-State: AFuF++kx7H3pGApFXkBwVKNtwHBU4HZ7BI2uvASITbe7h+mD4wcaDeQl
 Iwv0dQpWGw8pFbN47jx5rqyQPm9ypbpU2GY/VrDAJzGyA5jXlBCwucMPBxmKMIZ48tI=
X-Gm-Gg: AYBFou0TVjrMKieFOhxb43UMJFSyX1AxGRqCHwDc7k7sWrv2S9PbB9N25n5xmA4on1k
 kR1XQXTtV1jAn8t254zQviCsltphT8VO3/KFBfHfUtBce9a9Po4NHnQhmUXQCAkRkHnal7/tuDX
 Y02PUK0W9aMnzhHOL9c+9Fh7WoIYPIwrUWd8pG2sCNZ3JB4zIKYMOXiMy0d2MvLunFdGlK3KK5Z
 +pfu/F7V/KL2Efcro99gxE0Lq9cTM7dotl0VcjPnFjJN9a4eesBFDRJHLXyczhsgVR5Kv0AHmzK
 VC1IQMOWV/oVsENmsSEdnab+3rWfvzIySax4W506WzWR/+0HU0F9JUxXj9mZcSHRx9n7CuC7t1H
 II4GNoQzcroBN3DHZoLCtGJYkmaY1jP8F3ufJTPn134LAvSbgwVWSunagVyINmIszBd9SxLx8Kg
 2+5KN4HJ/23Rj8qel4bp74U6bgPUM6MEuM1kZIBC6MboSynJsbhUWIRg0WWw==
X-Received: by 2002:a05:6820:198c:b0:6b7:46fc:1e6 with SMTP id
 006d021491bc7-6ca9da68ae1mr6318571eaf.69.1789881678751; 
 Sat, 19 Sep 2026 22:21:18 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-48821db3b4bsm3936865fac.17.2026.09.19.22.21.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 22:21:18 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 19 Sep 2026 23:20:50 -0600
Subject: [PATCH 14/14] bsd-user: Remove host-os.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260919-misc-2025q4-v1-14-ebfa61049bd7@bsdimp.com>
References: <20260919-misc-2025q4-v1-0-ebfa61049bd7@bsdimp.com>
In-Reply-To: <20260919-misc-2025q4-v1-0-ebfa61049bd7@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1752; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=rBzHaFcCT9FJegT2MRMI3bZoInYVHkTuEBvpgiGyEak=;
 b=owEBiQJ2/ZANAwAKAWwc0Sh9sBEAAcsmYgBqr20x1b8/KwT1BR05fr/Ofmo8TPtr3VNIGWQXp
 6Ij5KoSfd+JAk8EAAEKADkWIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaq9tMRsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDMACgkQbBzRKH2wEQCN/g/5ATW3767Ds+14Sj7J5rGM/s4u/Kddx7c
 y+YiTotyA2fvJANI7kDv2HBLWVpkzT4Gdi+Yeo2tvE+Q4k13ZNFxxVMeZ92mM6LvOY47vPYKRU+
 xjqlNIEEAp2YsGo9pjLXejEBupGkaFVxlZbS9NTisAXL4ndbwi4Lwp63E91YxiXh4wtu0ZtEUBw
 F5ceUcDbTQ0YIBw1a2Os4rXikshw8j1+x9gOhJ8IPvE8WP0j9jNHfZKUlPD8LBvL5IfU8hIIofV
 n07nxlLG6IxIctRUC8IcMfK8Mzx7Za+MUD8Ry9qhsPJQMQN2D5oX3tWtPYfEHeU4jzfqFusc9gf
 hMWjQRDXJNWmye/2qZ0h3Kih+Hpvik3fkmNdadgt6FYRtQwnQyQICBWm5dEoO3Usp2gIPgDOPpY
 r34Ej89D0w/YNwa3n6r2ydtHITMjiYEfEhoZ6YXxiv1+tM/uDR6AoxoO+CSk4+dkB4NpXMyaAIh
 eaN7ovE7oGOcpHcW3jQenjRH3l89kUR/1G89HUjCYAC3SRDyc0Z2cwenK9BcNc6ZlqptaZDcjis
 xpaouXenFg5s3+2dRe/e6Fv6Zju4H6wwV3klRr1yrik+jABHG0H36oLSfrA0nGgvEheq7IM8H8d
 YVjLe3Lz8FwLJp57+cQU57maj6UFff0QXOK2SaQ0BAC8WHR7mSzA=
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:31::16;
 envelope-from=imp@bsdimp.com; helo=mail-oo2-x16.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
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

host-os.h was used to just set the default bsd flavor, but it's no
longer used. Retire it.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/host-os.h | 25 -------------------------
 bsd-user/main.c            |  2 --
 2 files changed, 27 deletions(-)

diff --git a/bsd-user/freebsd/host-os.h b/bsd-user/freebsd/host-os.h
deleted file mode 100644
index 40cae72ec9..0000000000
--- a/bsd-user/freebsd/host-os.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/*
- *  FreeBSD host dependent code and definitions
- *
- *  Copyright (c) 2013 Stacey D. Son
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
- */
-
-#ifndef HOST_OS_H
-#define HOST_OS_H
-
-#define HOST_DEFAULT_BSD_TYPE target_freebsd
-
-#endif /* HOST_OS_H */
diff --git a/bsd-user/main.c b/bsd-user/main.c
index 13cd752b99..29ee59de2c 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -52,10 +52,8 @@
 #include "exec/page-vary.h"
 #include "exec/watchpoint.h"
 
-#include "host-os.h"
 #include "target_arch_cpu.h"
 
-
 /*
  * TODO: Remove these and rely only on qemu_real_host_page_size().
  */

-- 
2.55.0


