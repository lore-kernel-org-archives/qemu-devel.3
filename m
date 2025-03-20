Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 152C7C28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 22:41:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvOQb-0003Lo-8I; Thu, 20 Mar 2025 18:31:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvOPM-0002RU-Lm
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 18:30:42 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvOP9-00077r-Ha
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 18:30:33 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2235189adaeso25861415ad.0
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 15:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742509819; x=1743114619; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WV3LW27U1S6CRR8HQ+KHd++BnCAdzjihbbqDVw/7qvo=;
 b=UCOv2ZJJTdfPFr4p25bouZmZWfjdoKWfXR6kbLuGIL8UlUJHfUmIoD8IA76FQXewu4
 i4kDgf3WRJisbTUf1t+gWyl5Hnl36Idf+qOOYd/StOUepvs32So8/y+NlakWTPvX6Nb+
 K7iyqG9FWx3k6tBD3NDunwWbUlYezxf9wLdT1siK5HBjfgdEalTFSduSspoVAfrsV8wY
 jWOAdL2gyVV0uqf5M9EBxWvBxdtRGZNyJ48HbOQVqNIgBv8JhsclJUJnZ1Hatea8CbZX
 YK/z7PmLsHTbGIG1kN4vjzU9vVf3YgNW8ibUWTrU30P8RIPfa39TB5fN0OIMjTWq5VvJ
 ezaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742509819; x=1743114619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WV3LW27U1S6CRR8HQ+KHd++BnCAdzjihbbqDVw/7qvo=;
 b=VCdaEi/KOaIDiRRwG/CUoIM5Biq52Qj0bhpU/0DEpVvBHkxOygrCCzr/vzq70llXhy
 LxkkzsAB2mxnAv27dkgysch90MD6QUvtubaMYFDBPd65egR0fJILqu9kVadrMxImKmZJ
 htRwDGUiLvLhGKz703avyOPu8cF2yfNtSc5VdWIN/Ck0w8/RAB8CDEIeuRdZu+x3dJMV
 1mIYmc5tmI05DJGfteHIUBDOsEaiZd6zrVNDBNkQYFF0/8/IK4WQPSYnZf0j9tBqTomo
 fGRdOcyRtNYgFW+WaUXgqho07PNij02Hph6irR6aZEHjTmwAyIa1Vj/UNb7DGmiY3gUx
 XtKQ==
X-Gm-Message-State: AOJu0YzTBV2kVNfnP/F8gKGI88SkEViSJaQIQEIge/WD0g1/B+ExFmNy
 mxf+OG7BVMQG3KvNwRHHNm1TNfa9IKbPyzb+u29UT5pkkwbqKp63FMXZjqCvPC98i+Nhna0rdCZ
 F
X-Gm-Gg: ASbGncuVRi+09/pO9/EEH/arp7zkSmaEmD4W+A13L/PLHnpjtSBQTp3h+A1oJD3qel1
 L7xEpK7ACL4D+t8cs5D2LAFTmXpNLr5YvYVSBd5LSKStcWau4yA3p55mlRwCbMfIlFP78Vdk0BW
 zgMdYvpIkgVfKAVIQTgTv09rYPUG1AjX7d+h5JgHW6l5ydhEAs3p4eIEFesOCRYjlYSedmVC3Bd
 PEgEBC1KPovAlo6J3HfRMqIjhINcERD8LWNWrrGrEIdCpa+P4KGnZyWwvN8AmuDsUv/Cnnz1pFn
 LbQs1ghfbkn1d/y2dPwCp5n+NDRIjUr0HyJuENsvZqnJ
X-Google-Smtp-Source: AGHT+IED8IFTqMazkDY9snv2i72ahMAdbHAQB5NY/WUQDtMA8YVwdGtezdctsB52KsHL2IZ1WgTdvw==
X-Received: by 2002:a17:902:db06:b0:223:5187:a886 with SMTP id
 d9443c01a7336-22780af52cdmr16943575ad.22.1742509819670; 
 Thu, 20 Mar 2025 15:30:19 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22780f4581csm3370145ad.59.2025.03.20.15.30.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 15:30:19 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 06/30] exec/cpu-all: remove exec/page-protection include
Date: Thu, 20 Mar 2025 15:29:38 -0700
Message-Id: <20250320223002.2915728-7-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
References: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/exec/cpu-all.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index eb029b65552..4a2cac1252d 100644
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
2.39.5


