Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A763CE7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:24:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPSX-00013g-2d; Wed, 11 Dec 2024 11:21:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPSV-00010s-I5
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:21:07 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPST-0007pC-Ub
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:21:07 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-432d86a3085so46141855e9.2
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934064; x=1734538864; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QOZvZF6lfd13HN9sGqs8XH84RBO0cCUPe2GnmCUxM8A=;
 b=pnpPf5zPG18jPY8dWJaRPuzWSQwBfXLlxlXkcwRCZrtB8yjHIk+fnyDt1Swk7fv1O1
 vu90chxusvWeWIk+aKYYwQPu3HtwjOFbsAD4kKdnJ2Dt1CXjtwTpqWySKQ6sAmLjJugv
 lZGJl+gZwEpz1choFBhBxo9mGpMdPyfm3KzYKee+D9OenXGwH8ojpMIQ7kJe8aCEYCPV
 LhWJLcaWyFI/bamz7/bTHAPjWYSiaXCk14dAC7Gub6v6VJPgVFtZz8VmyB+L76yElgsY
 DLYI9mig3lpMX+DfMLxqX+uDpPSgF74BAXNu5t8PB4CMLIiQD0IAp/xKK/0kWinlYD5z
 AV5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934064; x=1734538864;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QOZvZF6lfd13HN9sGqs8XH84RBO0cCUPe2GnmCUxM8A=;
 b=vVNNhYP1/CATWHtGyEeux0KFLP4XGfl+EcMc/bGaWMO/STpiTuFVb5kAvDVASKhvEh
 MO+tmIuheLAs9QRwXeg9fuYaiFiE93NcZA3ECRK4+sgjfqYmeNJcTYcOwNIaQax8oP06
 JrqSc4Fb1nEgL9aj06g6do/r1S8jUCjv/uywnURvG6igiLOipfhKxl3E3qA21HqGQQ6B
 WXQJoW5DTdw5j/KA/nTTwk9JvS3HchSSIpP/fKTxcU1MK3q4khr2jHvYMFa5P9cf488J
 cxGEp5HE7Esyq5r3d7ZoXLh1L1GB+1PnESNBZEpi8dwa7oXgOQHkIpWLYOiZQ362HsWh
 dMXA==
X-Gm-Message-State: AOJu0Yy/cYJBpv+4uHGj86mc3lBfd3KkVhsBFYrsJt/j2ojFl2/3xLwZ
 RegOieEwtD7+tim32vyP2bVj5j4GHkcr7PAY8Dk6aJUxfm5QDj6lwpo9aX4pqxpJbrGRjznUCfq
 V
X-Gm-Gg: ASbGnctu7neprQ1i+dP4eLYfi8HvCWE0OVonuf11PnXkndDr1LeLyQC7IOMnE8Qu+lB
 3n2KzqedOZqL764zTfQMK9xegil7MwWauBUCQr8SbMmuahnIljCGSaa413koUdQW+STuIjifgUX
 MHRZETfAXBCQ9Y3bdOkPv0jXpwHO3+OSFRU2Dpo+r67EasQ8sv7n7kD9k42yReqF2SHhrQ7k0FD
 1dnEZUPUq0wW11aDp/vxF4MEehyFLK8A6qZsSHhmdcKA/juQtjtH/XISWMg
X-Google-Smtp-Source: AGHT+IFQrHdSfh4uQwEiwZk1opfLaXFZGV+Drf4WLkYL5n0pxUJKq7F54DkFHkMWpsM7QWSNH3Dk+g==
X-Received: by 2002:a05:6000:2ae:b0:386:4a16:dad7 with SMTP id
 ffacd0b85a97d-3864ce495c9mr3622598f8f.10.1733934064670; 
 Wed, 11 Dec 2024 08:21:04 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f4dfdcdfsm121460595e9.39.2024.12.11.08.21.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:21:04 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 50/72] target/openrisc: Set default NaN pattern explicitly
Date: Wed, 11 Dec 2024 16:19:42 +0000
Message-Id: <20241211162004.2795499-51-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211162004.2795499-1-peter.maydell@linaro.org>
References: <20241211162004.2795499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

Set the default NaN pattern explicitly for openrisc.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241202131347.498124-45-peter.maydell@linaro.org
---
 target/openrisc/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index b96561d1f26..3ccf85e95f0 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -111,6 +111,8 @@ static void openrisc_cpu_reset_hold(Object *obj, ResetType type)
      */
     set_float_2nan_prop_rule(float_2nan_prop_x87, &cpu->env.fp_status);
 
+    /* Default NaN: sign bit clear, frac msb set */
+    set_float_default_nan_pattern(0b01000000, &cpu->env.fp_status);
 
 #ifndef CONFIG_USER_ONLY
     cpu->env.picmr = 0x00000000;
-- 
2.34.1


