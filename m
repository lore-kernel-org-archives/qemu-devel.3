Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19022FCB608
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 15:01:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyWfw-0006hZ-Fy; Fri, 06 Mar 2026 10:01:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWfR-0004qc-B8
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:00:53 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWfN-0002oH-88
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:00:40 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-48329eb96a7so61723355e9.3
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 07:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772809235; x=1773414035; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FBrDFEUptpl9cHiWMl6sDAnkc9qy5JYX5xLKqU0fAtY=;
 b=sGDuEvCZZRaxUgasgJGvsFQGV9+/HuZ1aqSgskMeSt6wbwYcWGV1Hcmzvzg8kwdast
 67HRoZDi4F0EZqiYdQBUYbcLTfrh5ZXrW+jgra1fsJdcTLMSINE3CD75UgK9W7HIHyTX
 Ef39DLOHA7gEswIw/sa+C+0LiyGQj0eYICOEGCQLW+kf0JF3gKiw86Skfzt/dUUwQ+P+
 WQ/BgOcULyLpUcu719Ni5tJz0Kbq2Z/mrfHodtJ8tUgRL4p8L4J4uy0oN5LsQNbcf+px
 Hkfj1XY80OmEQwToWOWCga+yN9gIen63HpciqGs6d2CkCIJxWKF9uGKM4Msz2x4D8GH6
 dXPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772809235; x=1773414035;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FBrDFEUptpl9cHiWMl6sDAnkc9qy5JYX5xLKqU0fAtY=;
 b=mbtpscBpQx2t11nEpoW7w5pKUoCsZhloGee26gdogh11ORcvgzv6YpnSc1wvJlg0w0
 UxrMxOHPtuuU4jQbgEoZurvonRImq3SZq7gNkGGsyvoozz9Ek0kA0ib1PIDdgULbsLPs
 1j5pQc0OlX4W24pYgWkko3VgTCclESKiwFj43ZLtlxg9vbYRVVKPZbE8CnzcJIjXwuRO
 fiDWoeFs+SybPvWtkvuTOxCSrdH9PsFqy6jQEXLVA5pxP3moUH8T9f+ZUhv73+y5d2O9
 itFvsLJrU33N9UmSvw+Mq5m6KHqKCeYOHL5poXqMUJSI3BE67WrImTiRjnMkFQJEDNny
 nkOQ==
X-Gm-Message-State: AOJu0YzhPXBHYfHIT4my9e5yXtqetae5PbJEl/9NH60nKYvZbzxacca/
 0k6qVkACkeMmhVTkOfeOaVyOZWiCDCQsL0prf4237C5X9G3CCIik4ftFvqKZSFJK2P4hIT2tBj2
 y1WiS
X-Gm-Gg: ATEYQzzvR3m+f3U9r+gCciuK1EQBSHOnPf4k7Sxe8JLQ6KgiCOMjdjitccIw1j7HEam
 d/nS4eAm4IXRj21W996E339r5xQCDGExx7344OnLVB/eSBU3fLxrpQvVMe0QOUGO1KS1TAZhCal
 HUXtX8XwHP37JNCL8VlLrn8we9uKbnhx7yoLgroZjbyavikaVMNMde/PAF3Zh9dPedX6yttqrso
 GzR1YH5V8C7atgjERjJB6jIep8TtIxoT3ihLuDcf1R3a3C4iTEMG3nXcSCUR2Aeev5MdL3zPqiG
 rTvuWe7sgIT6m/sRWeETUkbX7lSK6Ld04OgOnUPtSr6c1jAPAocYDwMoTApsDLT4134bmm7/Z0e
 IIsAQAR3tA3GzW0aA6zDq088ffyq0vb5THLDYRnbDmsUTDf2aLoiw1DUqMVNMHPQ+hD6JwR2kqk
 6s4vm2h3fGnIQPN+/mWWqbDdNIyoqKFra9UHgFXx2+rZifkOLhIPn8Tw+seGf12CN07rcwjeAOs
 /oSFRqHqJzfdnqCy2kYSeh/EmwsowEzps8zdeCmag==
X-Received: by 2002:a05:600c:4710:b0:483:a21:774c with SMTP id
 5b1f17b1804b1-4852697987bmr35696625e9.25.1772809234352; 
 Fri, 06 Mar 2026 07:00:34 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485246ece8bsm28681845e9.4.2026.03.06.07.00.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 07:00:32 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 44/49] hvf: arm: allow exposing minimal PMU when running with
 nested virt on
Date: Fri,  6 Mar 2026 14:59:34 +0000
Message-ID: <20260306145939.2162189-45-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306145939.2162189-1-peter.maydell@linaro.org>
References: <20260306145939.2162189-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

When running with nested virt on, a minimum PMU is exposed by Hypervisor.framework
if a valid PMUVer register value is set. That PMU isn't exposed otherwise.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260306130107.35359-13-mohamed@unpredictable.fr
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/hvf/hvf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 91bbb2013b..b50400d295 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1145,6 +1145,10 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
 
     clamp_id_aa64mmfr0_parange_to_ipa_size(&host_isar);
 
+    if (hvf_nested_virt_enabled()) {
+        FIELD_DP64_IDREG(&host_isar, ID_AA64DFR0, PMUVER, 0x1);
+    }
+
     ahcf->isar = host_isar;
 
     /*
-- 
2.43.0


