Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB468CEACCC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 20:09:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vK04y-0000wt-Bp; Fri, 14 Nov 2025 15:07:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vK02U-000715-LC
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 15:05:02 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vK02T-0004my-1i
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 15:04:58 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-47754e9cc7fso14766405e9.2
 for <qemu-devel@nongnu.org>; Fri, 14 Nov 2025 12:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763150695; x=1763755495; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3vM9mNF6BeM3+aPg+3EGb1A8W564ICSX9mM1UAAGdK8=;
 b=bG6xtzGR0oPHYPjcMclXgQQcbQMYYNRaNlzGRhSoGCARUIqLwtQqfNeO/CtZqxbYI2
 unzLknag/A8FWWeK1zd4VXgBaq0x94XVU6dvatLHclrRfBsN6wofv7rqBiYZwJzZO3BB
 9HUrTUUlbuPzv1qqSeAwnCK/vTkpI8t8ey/hAH8sC7Vsd4Ds5zzl3Xyq6Ll5WpAfk0G+
 id7UYTZ9lLjwVR4XTqDNbbPw2q9NGXKh8wYbdcIyv72o9KWUoXUyvRlbCkIXyxQR+hg4
 7E7/lpDD5DxAjLrzsblzhUZY4QRZjzQfBKhuMuH9gYNMWVXqQ8VHKOpc28CP7dCF3yTe
 9eDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763150695; x=1763755495;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3vM9mNF6BeM3+aPg+3EGb1A8W564ICSX9mM1UAAGdK8=;
 b=pPY7sJSee+/m5X05IGkLT7JkfvRWj0IWps4Xzwaf4PpMm2LJd7ZUdy0Ph5IOWUFsNz
 GckudWeACQATHtxT+K6WEBmWApbmymvL/XAPjI2axyNbduFjCCab7o2xZHo7D8siHb/r
 4LhMv+RSrHbX2AMmxy7nTStD2dkhWd385qlINve3B+Wd+lKQ4m8tYDmbPDVRqiozn44K
 fS+6GuUlzK8NoepcJg4PrTy0vx5TiEX5nQ1wcxDxDTSRfhQhdCXwPvvwzBQFwqDjWcTE
 3WQNL0O3V5a/ELJWWqTVKtCmPlCJTQlulmLdx3wosKC70vVgL+phqvdCwhqvRP458R1Q
 xc1A==
X-Gm-Message-State: AOJu0Yzt1NLa9Uc9xHjAGbRQI1AIJ14LmEUR/rcMFne0gXdbDLu79FN3
 kA6XLbRaWWhxosqOCnPvHLbnXPkjvkLIioOaprrru40eCARYeBlMy7DEVh8MoWgqCcHWXzX/Q0e
 lDoylzQol8A==
X-Gm-Gg: ASbGncubw1bl+DXufgxw0sIFSistnTu6cSO22adFKqVvE4V89g2DmQrplRtLj69Y7op
 h0M+Gd1PckhSwnKF+n3wNK4AnpLFECWmes60gT+9agVJshEtnLK9bt3RoeZ0UervUfqoUbaBB9b
 1aUJcvMzdXqb6yMGpEsao0v4WG6NGkQ1SLNbxNJo83XAX2MkFk7AE8l0KQKj16nnlX863Ew7WrJ
 f5xjeP2+OTHVDulKlHfvXLcSrrHlZzgFfbX73zbnXrYgmpH14Jodtoch+wGb7N09HkQnHQouCvF
 yGJuD/jfQQPo/VTxftsrEFea8tqOmJvZ0B4ZkpLsWEelADVzQAD98ArjwokqgvdiqpltzQzbM6/
 It848Z+bJfE4GApPimyfoV1XOMoT3ws6oOOSPpknbpwNC0shD4rWoX9AsbGqRH9ot0tehrsS56b
 OfRLzhctdQaaWOrwC+moOq7naQk8QP9iOnx7UDG9mhTHDpVrJFww==
X-Google-Smtp-Source: AGHT+IEiKxGhrTEgLzENSnevx6enHCioG06T1KRH3DFZFwCTQ8BPLRi6W6KiJQa2qdo4zftnEMUPrQ==
X-Received: by 2002:a05:6000:2888:b0:42b:3978:157a with SMTP id
 ffacd0b85a97d-42b5937876fmr3995888f8f.39.1763150695107; 
 Fri, 14 Nov 2025 12:04:55 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53e85627sm12622781f8f.16.2025.11.14.12.04.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 14 Nov 2025 12:04:54 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Collingbourne <pcc@google.com>, Cameron Esfahani <dirty@apple.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Mads Ynddal <mads@ynddal.dk>
Subject: [PATCH v5 04/19] target/i386/hvf: Use hvf_unprotect_dirty_range
Date: Fri, 14 Nov 2025 21:04:06 +0100
Message-ID: <20251114200422.4280-5-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251114200422.4280-1-philmd@linaro.org>
References: <20251114200422.4280-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/hvf/hvf.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 9a1bf026a4a..de06ec6125f 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -142,8 +142,7 @@ static bool ept_emulation_fault(hvf_slot *slot, uint64_t gpa, uint64_t ept_qual)
             uint64_t dirty_page_start = gpa & page_mask;
 
             memory_region_set_dirty(slot->region, gpa - slot->start, 1);
-            hv_vm_protect(dirty_page_start, page_size,
-                          HV_MEMORY_READ | HV_MEMORY_WRITE | HV_MEMORY_EXEC);
+            hvf_unprotect_dirty_range(dirty_page_start, page_size);
         }
     }
 
-- 
2.51.0


