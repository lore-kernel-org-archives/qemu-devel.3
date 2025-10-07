Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA1BBCCA470
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 14:14:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v68R8-00069p-E5; Tue, 07 Oct 2025 10:13:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68R1-000685-4G
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:12:59 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68Qg-0002Of-1g
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:12:58 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-46e4f2696bdso76077955e9.0
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 07:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759846348; x=1760451148; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=N9YvFJw1BE7TLxHV/uM9H0ZKT4t2vSS9XAmGq0QeqZQ=;
 b=gHELE98e8CW99EXgZd63l+bo5MPShYtoe6H9LzjoGJdYp1DDqfbYNKABZMvz2PCWxf
 h8nzmW54lcKNEwZvZ1pVxjtszra5RdDt/rtxrY0m8Ho79mLsi1dMkGI7t8hdjtGa4JqF
 TU3bnm/O48RnDERKNm11tJhDSpMGR0eDMHzqBbdwUUueLLw50LyO9Zmg0euLkJlpRdSa
 NooWHs1OyeWHcHKL09gJoCD0FSNJBk75KNzj5SBGUtKNXqUERGuThwAz3LGlLI6R+dNM
 3Hw2kVLVZlejOBTrJ7ktc8+5snsy/jrSgAkf3lpUp3uYrWhDAbR4/TP+KymwUmX4gF1H
 8eqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759846348; x=1760451148;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N9YvFJw1BE7TLxHV/uM9H0ZKT4t2vSS9XAmGq0QeqZQ=;
 b=DgSXhYRh319EnUjT89WfspKNlMgGJeoMjdwXvl+H1jkDylTFQlqygdsHlUnuiWfEwp
 RJ3Fn3eVbXzLsjCoFODdlasJIsXST118qgOD80jcgD8R0cADuuK9TmHyVTfoptJR6Dwv
 jPK5mkMXcO7yujyXhfKUgD+h5FJbe1kL0h27x4mlkQF8gemh2Mstt3QCGx9OwJMSixDi
 qLT5uhGIySiJM18LnUvqkSR5gurePOCpfmvNYfmhth9WqtkmQW3ypGWseRpTWEOwyvAs
 vIjNfOWv8JYRnohnw9gKuonwGCj6nYZa5oT+zZysy3VV1SkyfcJ4YVyPIALH1td3u6H6
 Cpfg==
X-Gm-Message-State: AOJu0Ywrxv2xVI4gZ+6G1JACEpRaxCegJ3MdwMSwzSaASNmCC3PfqcRD
 wpdfgONPuubaNczBA/oV0XMXyGT1OhlvF8bHXex0ItapG/tx2z8gHmDeHIMLgh7CA9d88HEVo5s
 CP4FI
X-Gm-Gg: ASbGncs2jQ2RTGFcScY6PFd3FVE1OSUxYuW9NMGO37yfv8MJ+cY2P4NMGnMSQNn0chu
 ApmwtWQBztvh1/2Q6xHfx4FoWQ+SauWez+KiDVRw2evBywZYMF5AnLhAulehr7iDIBqAcHQTXnm
 2iXe+u0zTCBv5BazmgMXc+SOoIzS4baCuyvXVDcH4UDz/J86MEocewjZPvABp6pIWMFxnMiqsKe
 +necIqamGB0wkinGkcYw8H2rdE2Az8Wb4so73JUGsD/Ira7Kl6zRTchwEIK6Ja1ijzCldBMR/Pi
 iBJSyI1gNnVFzygo479xQgykj238+LHVToLqS/yvPdrtidRcbCKMcp76B2XTrvN6tCS7Xan2COC
 VF8QbjrAjEPmXeVkKoXvm3vNkw95qBAQtzYr4KWonqau0RsYD3YyMBY+2
X-Google-Smtp-Source: AGHT+IEgAuJ/94BqGnKnWob05mGXwKVoMbqedG/jCpJQJNfef7ZTg2xWX7SwI/J/qkcpi9v/KVik5w==
X-Received: by 2002:a05:600c:8409:b0:46e:5aac:54f9 with SMTP id
 5b1f17b1804b1-46e7115c89fmr120915525e9.37.1759846347723; 
 Tue, 07 Oct 2025 07:12:27 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e78c5d290sm167037135e9.0.2025.10.07.07.12.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 07:12:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 57/62] target/arm: GPT_Secure is reserved without FEAT_SEL2
Date: Tue,  7 Oct 2025 15:11:17 +0100
Message-ID: <20251007141123.3239867-58-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251007141123.3239867-1-peter.maydell@linaro.org>
References: <20251007141123.3239867-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

For GPT_Secure, if SEL2 is not enabled, raise a GPCF_Walk exception.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20250926001134.295547-6-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/ptw.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 1cafe8f4f7b..3df5d4da12f 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -478,10 +478,14 @@ static bool granule_protection_check(CPUARMState *env, uint64_t paddress,
         break;
     case 0b1111: /* all access */
         return true;
-    case 0b1000:
-    case 0b1001:
-    case 0b1010:
-    case 0b1011:
+    case 0b1000: /* secure */
+        if (!cpu_isar_feature(aa64_sel2, cpu)) {
+            goto fault_walk;
+        }
+        /* fall through */
+    case 0b1001: /* non-secure */
+    case 0b1010: /* root */
+    case 0b1011: /* realm */
         if (pspace == (gpi & 3)) {
             return true;
         }
-- 
2.43.0


