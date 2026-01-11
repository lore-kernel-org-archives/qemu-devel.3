Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27078D25031
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Jan 2026 22:00:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vf3SW-0005Nu-QG; Sun, 11 Jan 2026 16:58:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vf3SR-0005Lu-IC
 for qemu-devel@nongnu.org; Sun, 11 Jan 2026 16:58:49 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vf3SQ-0003sc-6R
 for qemu-devel@nongnu.org; Sun, 11 Jan 2026 16:58:47 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2a0834769f0so40546005ad.2
 for <qemu-devel@nongnu.org>; Sun, 11 Jan 2026 13:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768168725; x=1768773525; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f5ww/TrGKj3Nrn5+V3rWPu1QkcqhU9+Qwg+gP5Flqv4=;
 b=NChOnuMm84uTsNgDgIw5W77IXsSHCYmFyWK+N8XFkNQLNIn/ZBXtmz+A0aNmHYpfsN
 Qb3RGgVUvD/iAxh+va4DOsmT+GWubPtjFC6zaPGnvHBqa/QUG6Baw3QQMqnzgyomfy89
 F1yV38haP1YY8zaiGo9nA2b1t39OSHYBC85B8OqTY7KO3IEr+jpOluSNyFWwNycnZZCC
 X6CxtXtffkLFOo6etjKUfIisLPr+mVoBctjdxuFinSSnsw8onoaDeA1AY9zKoo9ycVMv
 iq2tAEgsfgcbyhbsec0yOgDUkKxqicv6zdF25lDtOQvxNwb5no0mOTk8Kzp2YNJB/+0W
 CT8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768168725; x=1768773525;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=f5ww/TrGKj3Nrn5+V3rWPu1QkcqhU9+Qwg+gP5Flqv4=;
 b=Zy7IwUwcws5z0hFoOd1KqmKzIIOKuB6scShmJoRgmrK6IvK3jt2SzpG2VfM30gTT3Y
 ixnahvvmOPluJ/6YW9dAl+B5/dBaCsQS4bmaGrHU039YfNHqYcu2e0rLlpT6IVHF9PrC
 3ymBJsd2BtfpZIyv5IkRvu5QdkTE6iyLGOecdqAnFa5ysfCCl4H/V0EbhcSQU34/51g4
 dAKk60ydnrvP+nlpvrsg9hRGHGn/Vj9ht9ndTTxAs76XGMRvnvnQvtTTSt4TSOyBmq02
 d8bx1YkOCV7Xt8MI3zvkK+p7OUdADLHJoX6hGwS0bRi/kAKwn00GvRF3FMgOyosupT86
 bTCQ==
X-Gm-Message-State: AOJu0YwKFEdgPf0/sf43xWKT2MApLWXuwCaQ9CwdX2MbhQ9uE0BSVF+L
 tMIcf6wD73iuqVMfobFeLDhMtRwv/dhN3Jv51U627gvi7jGtCjdRPe+Zz8HUwyu65NAWsg/na0f
 m/ozUutQ=
X-Gm-Gg: AY/fxX7MP+knxJ9YQCvaHZ7djpb3W7BrdJAI/jkRwzpedhhW7PZSXVbCHp8rEhZsc24
 yQfZQnI9JlK/z8Y3c59DM39a18G1PXddtMTLuF9mnmWdtzjuiyR4h4h8pcOHwEeo2wyXADXIEAL
 52bQXtHr8sNS5pTby779OYUtKAqwt4A6d5AEo3UxcgxSH/MUyqYJFa6FVIidkTIMZxYO6CWUkeJ
 LGneZI6zffsmD5ChJg+K7v5h4R5GuKKIrp0knt6tygUIFse/r36ou2nNmel0ylkxdadgdH62/pj
 mkwhlT7z5afpAZ6s3S999ar4XAxnat23Iq82ECNY+/pHIOuM42j403dFEg/O/1GAQd3UvMJjuK6
 Bp3UjAnOGpSrToLcGlY0atNUDpTF+ny+lZ+vyRK/I5bkrCBOFDNMcQyURaDiea2bZMaf7RU+Rd9
 DttptqyYmoubBrdow=
X-Google-Smtp-Source: AGHT+IFJDPQNtbJXHa3ghWtmzGLh1buc5SvxAxWWtGyR1JX7wgcUvfm/zqPKNtPWTW79B9TJJCc4aQ==
X-Received: by 2002:a17:903:2ac4:b0:2a1:3ee7:cc7a with SMTP id
 d9443c01a7336-2a3ee43434cmr179988155ad.17.1768168724668; 
 Sun, 11 Jan 2026 13:58:44 -0800 (PST)
Received: from stoup.. ([202.86.209.61]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c3a31dsm155272365ad.9.2026.01.11.13.58.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Jan 2026 13:58:44 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matthew Lugg <mlugg@mlugg.co.uk>
Subject: [PULL 07/13] linux-user: fix mremap unmapping adjacent region
Date: Mon, 12 Jan 2026 08:58:12 +1100
Message-ID: <20260111215819.569209-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260111215819.569209-1-richard.henderson@linaro.org>
References: <20260111215819.569209-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

This typo meant that calls to `mremap` which shrink a mapping by some N
bytes would, when the virtual address space was pre-reserved (e.g.
32-bit guest on 64-bit host), unmap the N bytes following the *original*
mapping.

Signed-off-by: Matthew Lugg <mlugg@mlugg.co.uk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20251117170954.31451-2-mlugg@mlugg.co.uk>
---
 linux-user/mmap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 423c77856a..ef3833a2bb 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -1171,7 +1171,8 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
                     errno = ENOMEM;
                     host_addr = MAP_FAILED;
                 } else if (reserved_va && old_size > new_size) {
-                    mmap_reserve_or_unmap(old_addr + old_size,
+                    /* Re-reserve pages we just shrunk out of the mapping */
+                    mmap_reserve_or_unmap(old_addr + new_size,
                                           old_size - new_size);
                 }
             }
-- 
2.43.0


