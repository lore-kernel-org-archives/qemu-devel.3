Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7180AC77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 10:56:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHbi-0003He-U7; Thu, 03 Jul 2025 06:55:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHbc-0003CU-L7
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:55:53 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHba-0000fO-Fp
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:55:52 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-450cfb790f7so66275425e9.0
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 03:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751540148; x=1752144948; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zSMALvjOcbwDFxdBZhQQT9TGvgwhtr1LjNKTHw1swdk=;
 b=uES0ARvqtqb9JjWHMWq70yZHbqSs3OQPykTGTBVCHOMwcwU/D1/mcTfRzevYk5d7QF
 NTDRWHCo+Vyn7Fr8gh0pFbh0l2iXm4KKfaoh7wjjR9skHsxQIbHlCgJUMWuAzLBUJ6zi
 +st01dkslofiCGQBWwwzKszyN0Fkfi0mMmhWLZPis9pxNcjqxmOgQS1ybmacw+aqGS5f
 FOETTfAW7PM0QkaGRBqk2F0I884wvWz7Ah3UFbgVnpJqPFwLJyKPZ3OPoYvQiM8ovzDI
 mFm5a48ZJId9XGHBOfpmB2qRe1oKkI6apM9dAzgVuFQE6461eUi60MQqeSr15y4AAoLd
 MOLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751540148; x=1752144948;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zSMALvjOcbwDFxdBZhQQT9TGvgwhtr1LjNKTHw1swdk=;
 b=nVjuoCS5JyB3j8sv+W2g5heaAA9rqFFk8v+hATsY77lBXaTpcWI2R3vI/Y9mBKMi+w
 DG94Rp6tLV0+GlZv1alyfeuU3MfV67tRGzC4xuY6/IYq3zNTZUQ5BOuokuWmqg2qFxI7
 38rcN2zeLgX1IK6ICbwocxfusRnSUo0tUdcKnyIr5MVW4cyFRRACh/b9s8DW2X89ig5F
 QCttOzhYyGf73tAZD363ignmbOmX4qbiPs4u4m7y4r0h6ubOkHwwr0r1QRJbgGrTHaAJ
 3R+siad+/xKb5WWXS/z4saA9ATfBeE4/uFAOdPbnWTjvrWTSw/ac338zPx/ruIE++w0L
 dOEQ==
X-Gm-Message-State: AOJu0YzH6tKxOKoRl4HNjFO02KrUwbtpCwnyqIPyYTADU4hr5cRIjKpf
 YlfZ2GorDoDG4e+17KWDcN6AKN6dw/0ev3E/yqHrS4Q39W7TzevNF5iPUwKPBjHqUpWWAP5vBVP
 sX4CORmc=
X-Gm-Gg: ASbGnctio7eUeadlSsZbmYX7lwvxzAcd1WJXzDj8ERYPDxMmd/aJIUph0AyypEWGM7m
 2xcJFFTI9v2TDHQ5olD8XVSC5j34RdGZ19hovmHoT2yL2f7vOgmuLlHebvpx5xH3WyjZ/umAHz2
 VdkP5iHPgDY0rdOLuilCxZkZ+dyzb4EfYSjGVa+e47Sz6M2nGZn/isz4orNhM7h56HCRoLyYlbY
 8MBGrH+hmcDsmiMdUUXdvB2IPesdGzQiC4apu5GHNL8X/yooq6IsDDyATlXu5GEvFfjvV/q+/I7
 HYYlwjKroTfTe7K28Mw1I8ipnCiei/vT63FD+TMzjtEnHAE+qxf0i7Ma3kTSzrjrOvuuReWMBGj
 HCNdSgq8/Udg=
X-Google-Smtp-Source: AGHT+IHsgLTYJuE3+vBF70Bo7sHjatYYUMFJS63YQEPTiYpJlKzOhW/uNLJUerhl3hURkYIrdf6sNw==
X-Received: by 2002:a05:600c:3b15:b0:453:608:a18b with SMTP id
 5b1f17b1804b1-454a36e5a0fmr80144165e9.9.1751540147866; 
 Thu, 03 Jul 2025 03:55:47 -0700 (PDT)
Received: from localhost.localdomain ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a99878acsm23317615e9.17.2025.07.03.03.55.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 03:55:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>
Subject: [PATCH v5 01/69] system/memory: Restrict eventfd dispatch_write() to
 emulators
Date: Thu,  3 Jul 2025 12:54:27 +0200
Message-ID: <20250703105540.67664-2-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703105540.67664-1-philmd@linaro.org>
References: <20250703105540.67664-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Commit 8c56c1a592b ("memory: emulate ioeventfd") added a !KVM
check because the only accelerator available back then were TCG,
QTest and KVM. Then commit 126e7f78036 ("kvm: require
KVM_CAP_IOEVENTFD and KVM_CAP_IOEVENTFD_ANY_LENGTH") suggested
'!KVM' check should be '(TCG || QTest)'. Later more accelerator
were added. Implement the suggestion as a safety measure, not
dispatching to eventfd when hardware accelerator is used.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 system/memory.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/system/memory.c b/system/memory.c
index 76b44b8220f..4f713889a8e 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -25,7 +25,7 @@
 #include "qom/object.h"
 #include "trace.h"
 #include "system/ram_addr.h"
-#include "system/kvm.h"
+#include "system/qtest.h"
 #include "system/runstate.h"
 #include "system/tcg.h"
 #include "qemu/accel.h"
@@ -1530,12 +1530,7 @@ MemTxResult memory_region_dispatch_write(MemoryRegion *mr,
 
     adjust_endianness(mr, &data, op);
 
-    /*
-     * FIXME: it's not clear why under KVM the write would be processed
-     * directly, instead of going through eventfd.  This probably should
-     * test "tcg_enabled() || qtest_enabled()", or should just go away.
-     */
-    if (!kvm_enabled() &&
+    if ((tcg_enabled() || qtest_enabled()) &&
         memory_region_dispatch_write_eventfds(mr, addr, data, size, attrs)) {
         return MEMTX_OK;
     }
-- 
2.49.0


