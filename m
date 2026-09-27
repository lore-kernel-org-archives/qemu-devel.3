Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F629C9830E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:00:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAkkA-0002Pc-Sv; Sun, 27 Sep 2026 05:00:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkk5-0002P6-9h
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:00:18 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkk3-0007O0-TB
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:00:17 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-396ccb1a98fso1602219a91.1
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790499614; x=1791104414; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=K0rAvylJFCDebhzyBWGh1HPRhJRm/GjXARu1Rx20O7U=;
 b=AekehUuFXpzrBANwrc+6Pv9gzfXxMboLzt4zzIK4znck7YpOdUmt6ZrYfKqxVwxTnp
 P2Yv7dWzgg483V5u0wpwWqFVZHzeeNgdF3UfEWJA3t45KS0bKk/0Pn4Ta7W41lVu/uAL
 cWSQlWW/jLH0KUlhBD6k+xC4r5AFGmrAkj8AZVvhnfGUuBwmp4SIuNOmNM4LEXneYyT8
 2eliUPe+ydOHWqVBEvORioCHSEPZd8rBb7ABBgF2Vt1HHu1tDNabVC/n448FIjGXGwC1
 SHquwMM0ogNuNOXGUxVFL7APQJMcF5p2WiPOY4KG32Dyg49y5zFsPs+cUfBO9k0QWEC8
 JboQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790499614; x=1791104414;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=K0rAvylJFCDebhzyBWGh1HPRhJRm/GjXARu1Rx20O7U=;
 b=VbOvexKJtmeITH0rQL485m56BBVe8Nz/gLgJiAicJ8QuDhY7c3SSidA+DOGnPwKLj8
 W6w3Ij3uvCGsVhHtWZR527f2fBQz0aWAPtzyZaptFn0cV/jRbNdWY5zpnMvT3clHGgyj
 8bRRR2XpYHzGcHI0zZuS3dp5RfZ8uiP4FNMwnZ/6e1cusCP3DvaWCIDROgmcCaOv/p3Q
 qjVmC/W0nQDmv3ajK3gkgbsuQBX8ev6gmUlbVLJd+nFf9qOTET8faaqik23qVXArBTOf
 8LteR8MdwcttoqFq+kGmMz/FYk0L/8e7OWMaOKlsCTkI2ZOhs38l1iGFxgsJUfImufHl
 aeew==
X-Gm-Message-State: AFq9FYJlNjhobYhLC5aS13vAB5h8h7sLn4Eqm0yp6ZpJyb6rnZp8YP11
 i42gq1jgmUlJhKicfFzrac6mtA6pWR4uvAfHOa1+yoZrvNBMFTOgAQf2v1JibY9gmY0YeIYAiIL
 wgr5O
X-Gm-Gg: AYBFou1OmXTinFLC2R5dPUqODA52th615DnFx8nUGcXRCpeXVSQzSLJfPWlLwqqyQeW
 5szTymPfJCdLVbSzDlxxZ7YPKEpS72HOW6gRRzasECrhX4m1NaKyDjscV37kUN5OYYur8z1t2vZ
 gfTJSZUugaPFgosU7f7lvk8d4k0uWys9ajeHAWm3bQQ3NUg3pX0bFW9LxCNW5o4e8ngz72lpj7L
 5DxokrVXVPb3Oi8qb3J/lOVEQgGqtBY/L4E+IIRYbeuOjP/Ac+weZ/hgZzYokR5sVlMoygnaZ9Z
 8y+wYTTVIC3onf78ZTE4bwyeprhNJAqIjmlVuB3CwdfiMOhC5ZbPxjSJnAxiF4EOh9tmybeon3Q
 VtvFw+MUUn2LiZSBvFFYsk8Z75qwGd7mUr7jOUke1E+yLKbK1PaCwvhgiGF051vPICMcIaM7f1h
 LbTq0RoUhjEuglDc6T+M6cb7DECaRk6ek33UFUNEU8hqlyycCCFRI0hMHpZQpaLIF25UK62n/5F
 xsEwIFPZnKIX+sZ6/7PFPUekUl9yQ==
X-Received: by 2002:a17:90b:4a01:b0:3a0:b50d:50e7 with SMTP id
 98e67ed59e1d1-3a0bb552f31mr5595734a91.1.1790499614200; 
 Sun, 27 Sep 2026 02:00:14 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0b8efaeb3sm14014181a91.2.2026.09.27.02.00.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:00:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 001/101] include/qemu/compiler: Add QEMU_*_NONNULL
 attributes
Date: Sun, 27 Sep 2026 01:58:31 -0700
Message-ID: <20260927090011.10724-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/compiler.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index 4c49f52eb07..3661dc5fbaa 100644
--- a/include/qemu/compiler.h
+++ b/include/qemu/compiler.h
@@ -25,6 +25,14 @@
 #define QEMU_PACKED __attribute__((packed))
 #define QEMU_ALIGNED(X) __attribute__((aligned(X)))
 
+#define QEMU_ARG_NONNULL                __attribute__((nonnull))
+#define QEMU_ARG_LIST_NONNULL(...)      __attribute__((nonnull(__VA_LIST__)))
+#define QEMU_RET_NONNULL                __attribute__((returns_nonnull))
+#define QEMU_RET_ARG_NONNULL \
+    __attribute__((returns_nonnull, nonnull))
+#define QEMU_RET_ARG_LIST_NONNULL(...) \
+    __attribute__((returns_nonnull, nonnull(__VA_ARGS__)))
+
 #ifndef glue
 #define xglue(x, y) x ## y
 #define glue(x, y) xglue(x, y)
-- 
2.53.0


