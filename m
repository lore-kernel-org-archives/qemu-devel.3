Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BD27E7718B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 16:27:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOfjh-00074f-Lm; Fri, 20 Dec 2024 11:20:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfjd-0006k2-2n
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:20:17 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfjb-000089-EV
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:20:16 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-436341f575fso22798305e9.1
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 08:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734711614; x=1735316414; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NxQ+7q83SaJtlq8bYsY160a0DRHjNW5w+/MWDLMvekA=;
 b=cYMxdh1ZjAZ0HdGDj5SJCjVSyAv4KQegrlE4iMOFPY3vqqA7roXfDTJGDsbM4Q919E
 Gvab5AwJy3U+gcUbX9g8OrvMpKcBrxE5zrUBrdJZ3f4r/as6gPHaPhvlusTS/M0BOkrG
 //aaUDeQZditG0gZYFn8+NSt7f/0EScx/KKD+4D66cGANU3vQQ/Be8m0kMix6K6wVox7
 fk5XOBUUkJPgxKU3zp8VRwiBJbW0ufEvTdEEPi4rc3ppf+48j3dNZhbBTyuNclUpHTh9
 dLvn2IO64e9SfO4NBTeWWDaprWxMtnk8PBZG9cib984ZsfOeWdaieeUBsI99lDdemLNS
 Q0fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734711614; x=1735316414;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NxQ+7q83SaJtlq8bYsY160a0DRHjNW5w+/MWDLMvekA=;
 b=xIj7DhLR6xkR+UIROHsn9K4Pph/BdALf2D8Hs5vimBf9otB13CJBVQ5APiRIdjtnAp
 WkjTm15zPO1Td4KZ1CEZP+Y9p3HwxGbZyUUpHpr+xZ6+bD4ShvvFXVopafy6atVQiqJd
 IKLeQjmeux/+dBHpc/peI2B1Kutl+WovfzGx4qENSvRgiAsTguTRGsZLh9te+psuy/ob
 SSeCbC1G6v90e7XlGCpfigj5gkdKrNffTAZAtm646y0frPXrDPt2QOwmA8trVd6mfCTa
 svXxksgQE7ejFKe3Dzub8g/T1oevWlMwp7PHRpTHBGuZoUFO7hQtwsGApqS2T6zGbxt/
 Plfw==
X-Gm-Message-State: AOJu0YzQmbGcPIw+b0gm7bkvLsQHvybCI1Io66CJ6An4slZQf+hEOvJ5
 b0RzJ8FMWEOhOsJLe9XyJl6iH3xyiWKZu48Hs/ZgVTit3dDKjKDlUiD1tLh6Yfw1IxKQ8qpy5Xu
 g
X-Gm-Gg: ASbGncvzIn84PeV8Nrqc2toM78Ep/EzzxQNDee4/9DFtA5etJEaLzUeP9kcEUp+/I4b
 3nXNcgVK2QSnLrEx61UHoAZwD/HFnXvukj/e8m4mVUmSVkCS8EFxstHXozLOYQol+jb3AWdndHW
 14ImwP+T99SENYMz2Sw6+hBKdFbseQGGi/VplR1OZJ0Mctu8pv5YoQ4ik464pfV0ucuQ5Ed9Vwj
 YQC2NiFrb/GnAKyt/9MiS7WU7VUyFww7BnOwVEfd2kcx4EUyERP8OxcuwsrilE/2KGaPU5zvMc=
X-Google-Smtp-Source: AGHT+IE0hCnlEVavwkFSWdXWIv2/UEfBRstI8KSwz9zMOavcZEm925uYy1xAZpQRvxRD1xB8cOB0gw==
X-Received: by 2002:a05:600c:1d10:b0:434:ff45:cbbe with SMTP id
 5b1f17b1804b1-4366864414amr36959515e9.18.1734711613653; 
 Fri, 20 Dec 2024 08:20:13 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656af6cbbsm83815085e9.3.2024.12.20.08.20.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Dec 2024 08:20:13 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 57/59] system/accel-ops: Remove unnecessary 'exec/cpu-common.h'
 header
Date: Fri, 20 Dec 2024 17:15:48 +0100
Message-ID: <20241220161551.89317-58-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220161551.89317-1-philmd@linaro.org>
References: <20241220161551.89317-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Since commit c4b3f46c151 ("include/exec: Move vaddr defines to
separate file") we only need to include "exec/vaddr.h" to get
the 'vaddr' type definition, no need for "exec/cpu-common.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Message-Id: <20241217151305.29196-4-philmd@linaro.org>
---
 include/system/accel-ops.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/system/accel-ops.h b/include/system/accel-ops.h
index a0886722305..137fb96d444 100644
--- a/include/system/accel-ops.h
+++ b/include/system/accel-ops.h
@@ -10,7 +10,7 @@
 #ifndef ACCEL_OPS_H
 #define ACCEL_OPS_H
 
-#include "exec/cpu-common.h"
+#include "exec/vaddr.h"
 #include "qom/object.h"
 
 #define ACCEL_OPS_SUFFIX "-ops"
-- 
2.47.1


