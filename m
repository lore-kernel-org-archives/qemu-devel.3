Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58B43C021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 16:27:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkQR4-0005Qo-Sb; Tue, 18 Feb 2025 11:27:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tkQR3-0005MX-Jp
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 11:27:01 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tkQR2-0000nJ-2R
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 11:27:01 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4398e839cd4so9820575e9.0
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 08:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739896018; x=1740500818; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LY1yJOtl399lZ4AXgftr3zMqyDj58QmxjVcxn7qswe0=;
 b=EHCy7m6pch6CkBUMGrjAwOgyGfAVcuwyUmLPoHjryGaKFJclsfXYlee87uVWMbqp91
 YF/x5jedISIVR5i4fCMp9RKiPbYUrkwtdCPqWpdG0vaRo+KjtGlgMWB6zlvE+enOu7xj
 L6SA0O5uqx5fjbllD/ZS8XYZO2lzFTn7/D60Txj3B9Jlvxe1IsEOvO7TC42eZiD5Xts8
 w6yRqKC2Gj5LGu+cQNLluNLTzyUEgXqncg2g20DcMYoD+4bL5DSqkx5RqKXuax2516py
 oEpOJr5F1wgohKGxovUgVtMBTfcU0P1PWEVeneDhym6pVWR221eiAzUSF2uvcAFXkBtr
 wfZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739896018; x=1740500818;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LY1yJOtl399lZ4AXgftr3zMqyDj58QmxjVcxn7qswe0=;
 b=LNd0gNGp8NFfDUokKSAE/yP9Xi6S/7PA+vFWwdwUXvkrzZKasPSkvGisdoh4wvSljS
 N9zxvGSbAFCoh+0hY8l3fal97EOql95rSNvzFRVPvM4weWlNPuWy/zAqLZtQJX8ttNcD
 5kbQ/7G7MRZsp5ceNrujVzdZUMWTSqpxGkPYeVYDcBLWoA80UPdW3gjt0ogW0wwDTly0
 Nc/xYw/i5WEIpyBZce/aqwZvGKIB1mmhkXoOpJd/hVEvSDiWWtdMc/VC6sIizR4FvYdY
 KAuTtR5LLV1GDFSbkRdTKplNMvDFlFiKOMJpXgZi8pboxFxWvRKpHpffqmsEj2C6NzUK
 shCA==
X-Gm-Message-State: AOJu0Yzs2p304ZDE8LQE7Za4WrGF84zyyRYEwAqsGR0vWEWbCnWop8s1
 ada327SbDA6GY4qjtAhDcgPObPbJ0uKmIEVamRAMhyT4cLz2ICiU4fdqK3cMbZLt1x5kabR3e52
 cMxo=
X-Gm-Gg: ASbGnctYc0UvKVsP0Ct70nrPkNzsDlltkWcwabQPeqaez3w9vu6TYAyPu0MZW2U8m3/
 j8pj1jHprxZH3WajeCE10vFcWqU5dIkBtbDH1ZFHEzdDwVsgztKnM1r8cSCO8AJqiUQM70d1R5b
 PKIeBuTikvpEbdVP0eeIqmm9Hjfv0I6qehR15fDMpluT9IBiGWsLBfdnu414al5qNM0UrBN+xPX
 5kWXZD0R/F4UMbuFuJjm49benOS9ws2em1ln3f9hxGY5WOqLDEgbaLwDBsXTjLUNpD6icH26dMV
 NeaF4gii5zGT0IzHsjPed7q8mfZzT/+l1ilfJkjlI9KZsilg88yA/lUAva1BHqTynw==
X-Google-Smtp-Source: AGHT+IGvcnFycQQ+MA4T/mqzvg5WJga+EiuJJvKuRerbPrC+Ynhn7kdBWW+6S7LFCffDmzCAKYbQwg==
X-Received: by 2002:a05:600c:4f15:b0:439:4c1e:d810 with SMTP id
 5b1f17b1804b1-43999b0283amr4460925e9.9.1739896017978; 
 Tue, 18 Feb 2025 08:26:57 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439941bd54bsm23652215e9.11.2025.02.18.08.26.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Feb 2025 08:26:56 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 xen-devel@lists.xenproject.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anthony PERARD <anthony@xenproject.org>,
 Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>,
 Andrew Cooper <andrew.cooper3@citrix.com>, Juergen Gross <jgross@suse.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Thomas Huth <thuth@redhat.com>, Jan Beulich <jbeulich@suse.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH 7/8] hw/xen/xen-legacy-backend: Remove unused 'net/net.h'
 header
Date: Tue, 18 Feb 2025 17:26:17 +0100
Message-ID: <20250218162618.46167-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250218162618.46167-1-philmd@linaro.org>
References: <20250218162618.46167-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/xen/xen-legacy-backend.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/hw/xen/xen-legacy-backend.h b/include/hw/xen/xen-legacy-backend.h
index e198b120c5d..2d0cbfecade 100644
--- a/include/hw/xen/xen-legacy-backend.h
+++ b/include/hw/xen/xen-legacy-backend.h
@@ -3,7 +3,6 @@
 
 #include "hw/xen/xen_backend_ops.h"
 #include "hw/xen/xen_pvdev.h"
-#include "net/net.h"
 #include "qom/object.h"
 
 #define TYPE_XENSYSDEV "xen-sysdev"
-- 
2.47.1


