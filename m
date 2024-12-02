Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBF20D7831B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 13:22:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI6JK-0005fa-0K; Mon, 02 Dec 2024 08:18:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6GE-0001xF-Iw
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:14:49 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6G1-0003Jd-Pd
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:14:35 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4349e4e252dso39840835e9.0
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 05:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733145271; x=1733750071; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=73eMz7OCXkqR25Bej28Tzkpl+eCdRMSro7tB3M4lS/Q=;
 b=s+gdHeQoZ15txiKdOQ+6+WcoNGCzK8gDyqo/GHLuniHd2qnUFEQEiA/pTpxXJQHL/D
 SN/ipZE/YvQt4E+7zdvylK20Sq0euunwXbqK/wgePJlcCG/npqffKqBw+5np8IbqXeor
 Ocl2v9x7Pleyh1rSg+cQbi6polk3CEcb1fQFTIgFuuUX/ed37KYiOwIf+JpXLS5hcabB
 Vf0d4b8iVABIXD1rCgw9fbJCJpxYSaAsqWALKSrEFSU5O2/w9GaQZsIQNJN8c5VvVsdv
 1xAvn8uaeccXWagXH99p7PcInOXf+RiB26DCLv1om1PNDiitysFG/hSjewM8/ZSkWC/2
 Rq6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733145271; x=1733750071;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=73eMz7OCXkqR25Bej28Tzkpl+eCdRMSro7tB3M4lS/Q=;
 b=sKYseNUwdHsFNcMHRopXqMmrRp8wimB6rfZpAq2+fQMhudByNM7KOTVQY5DbkMifAl
 2vbwA5c7BKBwS1ycQZu9no+wIsr+lLvn4lxi7giGxhmhEgcB3lV+sxXXqHKNDmPmvylz
 IMxMJJM+cflzlMmba4cyjudPLLBkx2KqSFHWrFH65T+tDS4fyvkKG9oyEvGADdJ5ua3E
 UEJTNADs9vNDz0CIkYCissz3qNtHXi0p4MbrDrOWIACjrfFn/W6FzyVVlSveFo3QYJE+
 3ZE9ipCftZOGzex7Al8FBMZ2yHoUhjlPlPvs2ktL7sob5zsDaO+hHNeN64u/BiXFp0wM
 /FFQ==
X-Gm-Message-State: AOJu0YyAz/oiwYxYiZMO3pQLiR2AflQeLKaasK/0/Lxmao8msBiU7x8d
 g5AAQxC3jXWlxG4oLJvRkuzHI84atJyCsPwRjBdSFUgTDRkGnMLNaNfxWtpK/6hbcrfq/agt02V
 k
X-Gm-Gg: ASbGncsi8uqZ3wNvopAB4iy3t0mtZXZccxyQC2LiK++vookr8v8I09t0OPbTgxP0HWr
 YuFHSD/7uoH2rGcypaqf2Yl1NmFqMx9DT/PMsZC5b4M3LYbsWYj+iPE5Oz06xWYebx12ovI/2KI
 bjN3xmlx7yls+hMj1iw6ooBVTZm3WfvcpYIjLtNngYFWkoE+r9zxRQxZ4/ubao5+Zlf6scH/E73
 r6wsPiYHugoA6xie1dtNqY/3REGWFDajmTp3eRSVeUuiCKOArrAx/w=
X-Google-Smtp-Source: AGHT+IG2/CSEfYg56kx1cobXlqN2iyYc1dWHh+2d87J+zwUjg8IA98GdHV2ZgCo25GDwnUjwcav3Ig==
X-Received: by 2002:a05:600c:4708:b0:431:157a:986e with SMTP id
 5b1f17b1804b1-434a9de43a6mr186298675e9.20.1733145271469; 
 Mon, 02 Dec 2024 05:14:31 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385dea1e4ebsm10160157f8f.1.2024.12.02.05.14.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 05:14:31 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 for-10.0 24/54] target/i386: Set Float3NaNPropRule
 explicitly
Date: Mon,  2 Dec 2024 13:13:17 +0000
Message-Id: <20241202131347.498124-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202131347.498124-1-peter.maydell@linaro.org>
References: <20241202131347.498124-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

Set the Float3NaNPropRule explicitly for i386.  We had no
i386-specific behaviour in the old ifdef ladder, so we were using the
default "prefer a then b then c" fallback; this is actually the
correct per-the-spec handling for i386.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
v1->v2: drop comment saying NaN rule is wrong.
---
 target/i386/tcg/fpu_helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index a98b4f67ff0..c8bc5b7cfb3 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -180,6 +180,7 @@ void cpu_init_fp_statuses(CPUX86State *env)
      * there are multiple input NaNs athey are selected in the order a, b, c.
      */
     set_float_infzeronan_rule(float_infzeronan_dnan_never, &env->sse_status);
+    set_float_3nan_prop_rule(float_3nan_prop_abc, &env->sse_status);
 }
 
 static inline uint8_t save_exception_flags(CPUX86State *env)
-- 
2.34.1


