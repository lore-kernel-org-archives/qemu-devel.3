Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51B71C369D3
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 00:59:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kvF-000157-3o; Wed, 23 Apr 2025 20:58:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7ktc-0005vb-2h
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:56:58 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7ktY-00057Y-CM
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:56:53 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-736b350a22cso307965b3a.1
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745456211; x=1746061011; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mc2cOAtXM3sBslJrk/AmmYQiAoPWaBHBs7smPxcUAZA=;
 b=Z3HXA7NguRe8BpXKALZ5se9yyCAmB2yPDqZpKt2Ie7HLg12JuLC4/vAZRqgHndZn/S
 tQEd+J6fEAEyvvCFNkBDfr7CnCV09uteyvLwAnjRostiYHPkURwaHT+kcbNsRFZ6kmTT
 kdvfhkjjKPOx1jrNks9uTyy+hrpQjW6f6T6KoscRiVlF1d0vtIaZEVyC2oAAcmgI43UX
 DCuhy8Hq+yL4cLxcozaGpvYhx3RIjpNdV+boqI9X9ff/C7iugBCNMfHbKqggqkTu1ui+
 o9Wfb6edJIgpVctq+yGTtAjs4EEravee61/MaNKb1QzdLdHqrrARqQpPk0w8tUxOlLjV
 ohHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745456211; x=1746061011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mc2cOAtXM3sBslJrk/AmmYQiAoPWaBHBs7smPxcUAZA=;
 b=jZcUuv7OYVPSg9+izMc3FjNZ5lPMQVWwMteKm+E3e2PX5aApz1TGacRGBOakYGe4af
 Sx19b9YAT+a0QwsWhej0uVANlQDwpdvWt+Wmw46YCEDsp+40p1aTMRw6jqy6kmSqYMgn
 Ream7gk7Kuv5svwf9py3RUgP3bmGpBP+txnVg6wu/kd1FJH7gGAO4U7ddJ+YjWkDvmpn
 ks7XkQo8bkg/W+v5b/7SPum6823oVKlbtVM6TCF8Y/Z2MCYkZRKpj3ytV6L1maL5rbZZ
 czCSbqcNNgyERgDt2FOx0gjHmRyEZMS52hp41nvCV7eeJHru76k0VzxWrIh95KJspjNA
 zRjw==
X-Gm-Message-State: AOJu0Yx2ApnVOE80ellaNOfNY4lx4S6a4dIx32BehM5cvjieVBdoTfdf
 TLFbQPh+b/fzBSwc7WFnk0UdmJWVlpUNgRNqwXul7QjI3Q5YUNDB6lsdFxSsUEh5P7/QKE/YLZh
 X
X-Gm-Gg: ASbGncu3cVAq8usCSeQUBkwLhY2QxqOq2cwpaIzerdM22dkezQBPcTkTyZvsLtAaAJQ
 ZvPOTh1ouMe4a+jF5FflyG3gBdNkhVoZYn38ecIYpr8NSU4Mv0dWDAKlh8VuPFIcLs4/Oye3vvH
 mkuS9QHAhWGSFcnIFvi4x+1L9s1RlV5ymluziNf2j151nt2BeiNO8EszYA/NIduv4Jop8OayWoP
 pnjMPfXfOLBUovcg5GWBBlJO0wNkyUlfFhoieETWa8m71jmpd89ghxuCDYwwNfK4GPMoQAor4j7
 +p5jFCtuQVf24BnP4ttUYza7WdtyvI3m7f0w5qeHOFFVDCcyEgEZrX0paOnRhW761B6qgKuIp3j
 R3Fq6ajxCFQ==
X-Google-Smtp-Source: AGHT+IGBam57zgnC87lda5tm6DVG5ATlneOSoLggY+pwzgWyukm740uGtX9gmvV3aNOzxCNcafWwHQ==
X-Received: by 2002:a05:6a21:181a:b0:1f5:80a3:b006 with SMTP id
 adf61e73a8af0-20444ebe0aamr878480637.21.1745456210867; 
 Wed, 23 Apr 2025 17:56:50 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15fa907fcdsm119775a12.54.2025.04.23.17.56.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:56:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 104/148] exec/cpu-all: remove exec/page-protection include
Date: Wed, 23 Apr 2025 17:48:49 -0700
Message-ID: <20250424004934.598783-105-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SPACE_RATIO=0.001 autolearn=ham autolearn_force=no
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250325045915.994760-6-pierrick.bouvier@linaro.org>
---
 include/exec/cpu-all.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 399fcbb9d1..957c86886e 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -19,7 +19,6 @@
 #ifndef CPU_ALL_H
 #define CPU_ALL_H
 
-#include "exec/page-protection.h"
 #include "exec/cpu-common.h"
 #include "exec/cpu-interrupt.h"
 #include "exec/tswap.h"
-- 
2.43.0


