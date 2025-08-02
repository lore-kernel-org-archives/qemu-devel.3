Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C088C87FD2
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:58:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLhn-00007h-Rl; Sat, 02 Aug 2025 19:32:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLgO-0006Tu-Jn
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:30:37 -0400
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLgN-0004rr-7g
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:30:32 -0400
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-306b7eb492aso2040833fac.0
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754177430; x=1754782230; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kMQri4iirPxW00R1ccJFExnMIuYM+qTTYK6RBx2pETs=;
 b=v8HNIbN+U4CTTmuN5jgT4/dgj8FESShksQGGUD5vCXlSMyClaU2rZWTPyOh7SCgLoO
 mgFMtJthoPQzKwXr2ygtKxCFZOaqfRzFeSlczTVATzriycKb0sxV1HnUqIVMSEtQzjWt
 63LtnLb2iZxpbymOtgG2BZXyP50Y109Te0euXrqFJcgSbV80od3cpuRLRybMbXKUyytm
 cd3Frb2Qhx6bzJ4Om+aeXG0fzH/FfqBU/qpIm9nF9I8bKJ9twSmI5234iWqWrbegTeCi
 eYlVVtpGjG35RvOKfRIthmLn+wiawDgHnVdN53BhS8goWDWAGEKb9LWuSKZgjjTMdCCb
 sAKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754177430; x=1754782230;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kMQri4iirPxW00R1ccJFExnMIuYM+qTTYK6RBx2pETs=;
 b=nfRAvfPQbFeI8paLOhIAB7wDgXp1dMUfty6/h0YZPH51fPDdpCMMkgMdbf7hfhBF72
 J43ho0q1ykmX0/EdJnEDZbpnWrMNgkeCoA4bOiDHu+bLSv5E7TAle/bfaVn5oxWCF/a5
 EtjFSeU0tNGwNBjKxsfVVIvNncykYpAjmA20eHJ3tsrzeGr5Wz9geu+c4mqlVeXLfWgw
 KSxZgIzaUvjKq7AvKbr3oGP6ShuPSkjoLEkFxKl+ZZZ4Eorttxhsn9SYYTSg6YqorakQ
 WTY2PJvqjr2++6mT38Ff6PmW2rPAKd/du4tuEwNDSKPisNOi0dRjH9RPlwvM7A3QrQ9k
 GOfw==
X-Gm-Message-State: AOJu0YwdykdAQL9Il9nJ76VPzfwKOpki5h1wKQLKDS79bdFrQ58VQQe5
 DHkViXAXw8J51malA0L+J+d6PC0XwX6LPDu3ze9ztzIbzzAjduCUk7aHnZDyoPcPfATpKaPwQYb
 ITNsfxso=
X-Gm-Gg: ASbGncs349OISQrUAZp5pDos9Gfin3NsYTHu6mizfZLYA6ZSC5wwIID5/6PesAGj+7H
 cv6Mz7Iu3fMVina0VkhgdnCq+diG4V9Hfz+ZMo5AhJ8Hp5DjEYm5Md1tkkzcCCBHWlGt+6nJ966
 lkPQ5AZfXt/AQZoKsiGVwJNpOKlW2JT2oR7+momzeCjF/WGvSDfvqVn+CVkqBf+mC1t8GSj+r+4
 QQAtu47GvHR/EexguMYgX4kQ89GMDcbhCjFmdnQXksjNGSqQH3dfXIz5s3G+OSCsR+mVeTLaiAG
 kVTLdh0Y0UKyiSTyhvu6hVL/XpZlvJ5jcl+/uJtXeRbonHTABbHyePVDkN3CPlfUQJSIrkuuF32
 aDEHEjs5hKqx1Kh018lRxLgWxHj/hKDYnloAMLb6NMy2WIINzWxbb3L18c6j3G0E=
X-Google-Smtp-Source: AGHT+IGY/FToaI9Fxd/xqCVVMkIdnVnqNNpQAdXqKF/jyQpvFUtOvYIaYlQeE3PnPQUEogADRJujNA==
X-Received: by 2002:a05:6871:741e:b0:2d9:8f98:b0cd with SMTP id
 586e51a60fabf-307aa67e16dmr7214228fac.10.1754177430052; 
 Sat, 02 Aug 2025 16:30:30 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-30b8e3c9b32sm71031fac.24.2025.08.02.16.30.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:30:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 06/85] target/arm: Skip permission check from
 arm_cpu_get_phys_page_attrs_debug
Date: Sun,  3 Aug 2025 09:28:34 +1000
Message-ID: <20250802232953.413294-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802232953.413294-1-richard.henderson@linaro.org>
References: <20250802232953.413294-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::32;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x32.google.com
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

Do not require read permission when translating addresses
for debugging purposes.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/ptw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 1b90e33f52..c7db93b95c 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -3646,7 +3646,7 @@ static hwaddr arm_cpu_get_phys_page(CPUARMState *env, vaddr addr,
         .in_mmu_idx = mmu_idx,
         .in_space = arm_mmu_idx_to_security_space(env, mmu_idx),
         .in_debug = true,
-        .in_prot_check = PAGE_READ,
+        .in_prot_check = 0,
     };
     GetPhysAddrResult res = {};
     ARMMMUFaultInfo fi = {};
-- 
2.43.0


