Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65904C28B2F
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 20:04:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts5lD-0002WD-LG; Tue, 11 Mar 2025 15:59:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ts5k9-0000zZ-Ax
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 15:58:29 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ts5k5-00005U-G4
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 15:58:24 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-22398e09e39so111119735ad.3
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 12:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741723100; x=1742327900; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rp8GQC6vA5rTxSSazblnkjuLZPjrJAYUOFg9uGM493s=;
 b=YMk6V4mAzrEE/ZKMLkAUwNWcE2naemKzoo8ci0wTZJR4qzOja326LLcYK92e+gpDEg
 BWmJmyn5QJ5GCF0xzIM8pVH4B9Rk6yUBzZvYIWDtl65IIDp0XBMZwFo7c9SHGQFnws/5
 rIhV4HMa0WVJZ85Tj0GE3ulBZOPfvv33dHrBzG+ZPh2uAZvng6Y3qyxXCtmuXR+Bf3xQ
 TcjBuYl7mPUQ7VLvajwlovg/8WVHzbG+Z3aDqfn+7sm3Uu8IqjyQqNVWDtVrxLVWjtq9
 f5QdkpFo4HP61OmF6W7KldHLPbMofFHqv4pXJsedfpGBeGkVQ3L8vJ0gAHbQkDW4USy8
 +Rdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741723100; x=1742327900;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rp8GQC6vA5rTxSSazblnkjuLZPjrJAYUOFg9uGM493s=;
 b=Q/PM9+jb4i78B97O44W70AtHyvY3gyuxyrO7HICyf7tZG73T95C8eqLvZyhIGtShWd
 FMMpp4TUo08ViPEng+4PVnOlfL94Lz8YjVbG+BhX9arEJ1NvVVdW5s3bSr51FEqUTrpD
 Uz3tkAwMeO3y0V/NM8xsiE/Z7mm/2Vv1iC0q55z9WDn8x0xQMQ8oAoFWzR3hzB8AVmAu
 NdEaqfRkgQ5+Brgs2FvbTFUabmYOmaVk6AniP5DqozGGzmeKV6/ed8ozcnAk2esVr4FC
 9EQH0eovn3o57IwnZSYQVitG6hsCwO3bVXWX+ZKdubUjXa4y0VlRH0zq7ovIcNfyZptS
 /5iA==
X-Gm-Message-State: AOJu0YxGjEv83AEa/Gpcvo2RHckgPMf+Hs4bTfYthaNVXUYl3EQNN2C3
 wozkLJ+NhGRvIgAJwm99ZabKvdRCuv1Qu2zYXZydSgFNzzMXJWcPNUEpSir6HZeajWioMZBIm/2
 0Ooo=
X-Gm-Gg: ASbGncsH2EfXekCBSBTkgRHjT0e7qRMv6Z1U6bX0Oz8GoWKvEv5if/VoKB7F2AFY1rS
 WTHueSeRD3x4Kx+asAvy15WrccqoDzOATZElPG+iCidFmZEL+vE8jm/GU0xTEuhPXeIpsefrcHg
 zfQafIgVoTH383Lz3TRRnHHAfmC7mfOgu16AGg6qNwqEFwbRqQowMGaQdNPUeaflY12BGtOqiJC
 45qzA2aQglu36EUdZHw4Q5xxBiKV/xG5hfHRd4rR4dBKM7D4LNF7GjWuB2XxxTSua4T1qYEkc2C
 3StAvK/6OfC48XgsgfiUmN9aTtyWmR6j3M23L4/u0JfKfs6jGhsLSzc=
X-Google-Smtp-Source: AGHT+IEBCxz8tAPvpmfBsP3Ukq6OIHQbs/5ODtSLSGAs7fop1NjSulQH4pEJZaQn/aXi1ghSaJLALA==
X-Received: by 2002:a17:902:cccd:b0:224:256e:5e4e with SMTP id
 d9443c01a7336-2242889d3a7mr298318035ad.16.1741723099862; 
 Tue, 11 Mar 2025 12:58:19 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736a6e5c13asm9646981b3a.157.2025.03.11.12.58.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 12:58:19 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Anthony PERARD <anthony@xenproject.org>, xen-devel@lists.xenproject.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, kvm@vger.kernel.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paul Durrant <paul@xen.org>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 manos.pitsidianakis@linaro.org, Peter Xu <peterx@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alistair Francis <alistair.francis@wdc.com>, alex.bennee@linaro.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 08/17] exec/memory-internal: remove dependency on cpu.h
Date: Tue, 11 Mar 2025 12:57:54 -0700
Message-Id: <20250311195803.4115788-9-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250311195803.4115788-1-pierrick.bouvier@linaro.org>
References: <20250311195803.4115788-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Needed so compilation units including it can be common.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/exec/memory-internal.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/exec/memory-internal.h b/include/exec/memory-internal.h
index 100c1237ac2..b729f3b25ad 100644
--- a/include/exec/memory-internal.h
+++ b/include/exec/memory-internal.h
@@ -20,8 +20,6 @@
 #ifndef MEMORY_INTERNAL_H
 #define MEMORY_INTERNAL_H
 
-#include "cpu.h"
-
 #ifndef CONFIG_USER_ONLY
 static inline AddressSpaceDispatch *flatview_to_dispatch(FlatView *fv)
 {
-- 
2.39.5


