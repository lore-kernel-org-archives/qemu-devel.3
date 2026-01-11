Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45316D25036
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Jan 2026 22:00:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vf3SY-0005OH-0o; Sun, 11 Jan 2026 16:58:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vf3SV-0005N4-IR
 for qemu-devel@nongnu.org; Sun, 11 Jan 2026 16:58:51 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vf3SS-0003t1-IZ
 for qemu-devel@nongnu.org; Sun, 11 Jan 2026 16:58:49 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2a0d06ffa2aso42935775ad.3
 for <qemu-devel@nongnu.org>; Sun, 11 Jan 2026 13:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768168727; x=1768773527; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fqO9HbfMIwt05kz/abBQlPaxORHTbzUMkp2EwctPJB8=;
 b=vsD1fTV591CXj8sdTs4TWHhKOi02YgTft+pcS7ClESYhHUMlO7xnYNXGitCaVweEX0
 ytilm0FFE7j+tmdltJczvhWxLhvdfW5YpIZKT0+OkYNxWowd/RnGNuo3p7YIgYditINt
 3d8D3GF/txP/Nz/4Do3a55M/zGau+YfG3KLODP1OkE2b6K2nFRaEmvv8O+ExH4ZkXKNU
 VEqYpFBQKrc6XSIVzsHq+mHZL31PsIkOBQRNxiFV4YxAwoodttebYu/5VDSEtVrqvT4r
 XdYAcW17iZnNPB6oJ+P2BI0q12KhfBiUL6V65SWQpRI8lBTauskant6rA5z7xEd8voHY
 eDpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768168727; x=1768773527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fqO9HbfMIwt05kz/abBQlPaxORHTbzUMkp2EwctPJB8=;
 b=pL+Bag58PlgRY/PrAVujsmR4rJQg5RSANrSJxMqcrUYlVIF8jideBPLBJ2Uv98fVF2
 96+kerKT9oGo2R/Ht7uPR69TytuRmcLS1QalkAhYF4GlcDiHkEYkWs1eep2oRbyn39fC
 YSc9rO4lLkNtvoHWzgGyylQM63OfcnKz7gx3HIkmEh0kKNRgwr8ZdanY1035XIrlwWFK
 zZcuyJM8Ieidd7LQo1uS8/hbdX5gs+WOFL2SQmjV2rUJU1F9wXYsYzPvx3quQ9TYCfPp
 pMoNWJeEUY6A3hD+8Rwf78JRJ3lSeMQMle7Fz+YyKG0HfvZLxSLuaXroMCwl/ttDYf8U
 Ex0g==
X-Gm-Message-State: AOJu0YzyzK2NZKEYvXvP3EfQLgnbX08MvBC4IiO21J7Wx2ZnwiPGYwkc
 U9V1vxhGSgFOX3M/EFKuiGyBh1ZhVF2ZVFVeX9saAiygvGChX6YYKKo2RchI9+qBp2SCJokkFTG
 LRMlEWPY=
X-Gm-Gg: AY/fxX5onGw7XE2AE00FdauoootZao2wnCImeJ+sppUlWWcucFcgW+bo8+6rt/FZ72c
 69ty+l+eC4zEONGdWyotzhTf6cS4spDtnOzy6cKd89/g6TeLr5NGAYEes7UGlAMS7VEbghS+Khi
 yUMfiH+Tr7StdHG7eQvE7lgXkNkGMFOwU8oHwAE01romZKiL0hreyyoE1VAy3ZWylxT/K4n9fyj
 j1OtfJIOTFac6Z+rfDIq21h2QlWo/AIkaaURCaNXFE7j6dX6suulvF8bWo+ADas1OeLLiwx7Dyf
 FPmD87MiEoUXorZuKmeOVmYp6mKYFmVGGcAU1wGw3PEk1H/Xx3CDM9duT9ZfDM+vRv7EI76iqrX
 sJW740oPz3Hl4ti0PLg4qQCVBFjH43jGTGH/JjKSljeSOfIo4CkGs0DFx6N/gw+uvOf3qo4PQlK
 5LlF/A7NU71f+YOwg=
X-Google-Smtp-Source: AGHT+IEFcCOXZaDRrSJlNXXGtve1MASzR4R4Ile1Q5YXLNaunWsUXKjzjxUa0hQhSQ1cn7YYO9GuDQ==
X-Received: by 2002:a17:902:d50a:b0:2a0:c5a6:c8df with SMTP id
 d9443c01a7336-2a3ee429962mr162657035ad.21.1768168727148; 
 Sun, 11 Jan 2026 13:58:47 -0800 (PST)
Received: from stoup.. ([202.86.209.61]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c3a31dsm155272365ad.9.2026.01.11.13.58.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Jan 2026 13:58:46 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matthew Lugg <mlugg@mlugg.co.uk>
Subject: [PULL 08/13] linux-user: fix mremap errors for invalid ranges
Date: Mon, 12 Jan 2026 08:58:13 +1100
Message-ID: <20260111215819.569209-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260111215819.569209-1-richard.henderson@linaro.org>
References: <20260111215819.569209-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Matthew Lugg <mlugg@mlugg.co.uk>

If an address range given to `mremap` is invalid (exceeds addressing
bounds on the guest), we were previously returning `ENOMEM`, which is
not correct. The manpage and the Linux kernel implementation both agree
that if `old_addr`/`old_size` refer to an invalid address, `EFAULT` is
returned, and if `new_addr`/`new_size` refer to an invalid address,
`EINVAL` is returned.

Signed-off-by: Matthew Lugg <mlugg@mlugg.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20251117170954.31451-3-mlugg@mlugg.co.uk>
---
 linux-user/mmap.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index ef3833a2bb..6163f1a0d1 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -1110,12 +1110,15 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
     int prot;
     void *host_addr;
 
-    if (!guest_range_valid_untagged(old_addr, old_size) ||
-        ((flags & MREMAP_FIXED) &&
+    if (((flags & MREMAP_FIXED) &&
          !guest_range_valid_untagged(new_addr, new_size)) ||
         ((flags & MREMAP_MAYMOVE) == 0 &&
          !guest_range_valid_untagged(old_addr, new_size))) {
-        errno = ENOMEM;
+        errno = EINVAL;
+        return -1;
+    }
+    if (!guest_range_valid_untagged(old_addr, old_size)) {
+        errno = EFAULT;
         return -1;
     }
 
-- 
2.43.0


