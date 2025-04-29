Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53F0CC3ABA8
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 05:01:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9d5L-00081U-B2; Tue, 29 Apr 2025 01:00:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9d4w-0007Wx-M9
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 01:00:23 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9d4t-0005yV-Nt
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 01:00:21 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2279915e06eso62680865ad.1
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 22:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745902818; x=1746507618; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J1+mpgNwQQblB514w6gW7TOdOsjY6yGJh5E66/u+eSU=;
 b=pncYCfXlRLAwDiIcQYTGtm7L5DlaZwUOlrsIEVty0QqHFgkoWQFZGuvp8h6AnQN9Mc
 +JAp8+3ExTvWsbXlUT/adPAgNTVkhRRTyg0u2unBCVFXnDkQj+A3+KddSbS/ImL6cs8A
 81VjqtnRfouLp1U56xc2oNq2fGYOVD4DJoVXoYc6PLwrcSpei1riMS/4yrAw0OWFtJxj
 8EZ1OmSXWHRFHLbXe+ljLZzYtfuw5rfpGy98dktYu+i0zb10jP8PwjwOuIaxKFD+tMzw
 gVEy1uNdmh5YPoYL4cAYIcW8T4oc7WV9jZHs0ZsepRxU4FiHCEE8lje32kPcVZZkKEPG
 L4BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745902818; x=1746507618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J1+mpgNwQQblB514w6gW7TOdOsjY6yGJh5E66/u+eSU=;
 b=sLSojl3m2c3Wtwc72TTpFxieyehvg+5J/VauYsXIEDEDomeXabNAh2+xWqRPamOB9W
 LHnxrut4WHw/FWp+T1OuaE86JYCv4ND3JXYrmy1dAiVX8p91QfUq7JSpXZpjShfIFbiJ
 nZEOgiHiXp/x+1z7Nt2ADp9vnBvngFo/rdAocdjQ72jf4V8aWUkkklOJ4pVXbJ/Ro8VA
 W92pGXs+CS05OzlTRn+B9Mj8u479jvYY59nxk5FBNS3m/grJp73rPO0PWI++b19LzUrq
 svJXa6RDH3vS+3jmSoMh/mlCA2VZKQl2hpEtV5D4ZKEcF8iWk+hiWYNIPYbfaipxR0F+
 0Q4Q==
X-Gm-Message-State: AOJu0Yz4zBEznSvjaQp7K/KNbPQMM9h5+MTEQ7FpnZXJ8inCQ1UFeQWF
 mtvxPmblk8fnOU4cde0YrZTlWSNZWq6Dz+orVu/ubGACICowzgIGyrkOwonbMCKuJ0+d3F9zfXi
 k
X-Gm-Gg: ASbGnctyVzx/JguT3v4dE0ZZ0+MvjSTTVqmQr0bPwf1khGP6Kz5A9l0XPlgUWniyNIr
 x2UPX74i88ZmXh7HRda3qP1/5mDIH7US9ma3eq4BmuocQr+BMTOex5jTX2kFyw2kCZ9Hh7O8iXX
 mPhD1dDghG36UZTulKi8ewYa3W0Hjotm1uuLGkMfpMLmfhc0TG0BkYjLyMQWByBFN99ZotrRBrY
 lKQcWE8R+pVu0NO2F/u3EWNE9GAfo3tTO5rowSbn9SuAAvROCT8ueDVX+6IIfJOia+rvu4j2k3m
 T/6IzfbYKbglTAxWVE1FmD8m/pvKaJSP0Xap8hb3
X-Google-Smtp-Source: AGHT+IERHWhMGoawkxhND2r6sOYx5Beqk5TQos+njQ8aQ63QB1/yRMYJ7tUQDCBZu8a/05Bc1162dQ==
X-Received: by 2002:a17:902:d4d1:b0:224:76f:9e59 with SMTP id
 d9443c01a7336-22dc69f3b0fmr169007685ad.10.1745902818246; 
 Mon, 28 Apr 2025 22:00:18 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4dbd6f7sm93004015ad.76.2025.04.28.22.00.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 22:00:17 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 alex.bennee@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, anjo@rev.ng, richard.henderson@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 02/13] include/system/hvf: missing vaddr include
Date: Mon, 28 Apr 2025 21:59:59 -0700
Message-ID: <20250429050010.971128-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250429050010.971128-1-pierrick.bouvier@linaro.org>
References: <20250429050010.971128-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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

On MacOS x86_64:
In file included from ../target/i386/hvf/x86_task.c:13:
/Users/runner/work/qemu/qemu/include/system/hvf.h:42:5: error: unknown type name 'vaddr'
    vaddr pc;
    ^
/Users/runner/work/qemu/qemu/include/system/hvf.h:43:5: error: unknown type name 'vaddr'
    vaddr saved_insn;
    ^
/Users/runner/work/qemu/qemu/include/system/hvf.h:45:5: error: type name requires a specifier or qualifier
    QTAILQ_ENTRY(hvf_sw_breakpoint) entry;
    ^
/Users/runner/work/qemu/qemu/include/system/hvf.h:45:18: error: a parameter list without types is only allowed in a function definition
    QTAILQ_ENTRY(hvf_sw_breakpoint) entry;
                 ^
/Users/runner/work/qemu/qemu/include/system/hvf.h:45:36: error: expected ';' at end of declaration list
    QTAILQ_ENTRY(hvf_sw_breakpoint) entry;

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/system/hvf.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/system/hvf.h b/include/system/hvf.h
index 730f927f034..356fced63e3 100644
--- a/include/system/hvf.h
+++ b/include/system/hvf.h
@@ -15,6 +15,7 @@
 
 #include "qemu/accel.h"
 #include "qom/object.h"
+#include "exec/vaddr.h"
 
 #ifdef COMPILING_PER_TARGET
 #include "cpu.h"
-- 
2.47.2


