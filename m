Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CE27C48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 12:57:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd8cX-0006Ut-9W; Thu, 22 Feb 2024 07:56:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rd8cK-0006AE-Gz
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 07:56:00 -0500
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rd8cH-00055T-Pw
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 07:56:00 -0500
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2d180d6bd32so90478861fa.1
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 04:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708606555; x=1709211355; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VVZ+VNqHmOLRPOXAqtL522gDrsWtXXCXM5mqlJag8Eg=;
 b=up/ubXLt10k3QO9vkwX6g75lvOJJffifWJ5o6q5dZPkORoguw2VqOmVLaLTnWlNqkE
 4uUWlo+g4s/Vg2caSShVMalvoBJmXK83nR0IFZw8foBAc44AY1wk/Mty1Fys/bxntVbQ
 EAFTBtPLwDXFP5DHZwNQOHU1UmjW/QFQltW+hcscqWwvhwuKLaMwYIlAtfkMKLL7VIrN
 CZoFL5ScPKiaZhiikT0j3z8ASq9Wb0P0JVoKNZchehWSb2ovDd58NAXvWFZXG5p70GGF
 iq/WSW+uK1LxDPiT1IUmqtSStlS81xfge9PUz52CVQwEyd+wRsCI059/WVARkjJuW5nQ
 8giA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708606555; x=1709211355;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VVZ+VNqHmOLRPOXAqtL522gDrsWtXXCXM5mqlJag8Eg=;
 b=GLu7DEheoD/exMIYsBwW3YqtvAUj5mApJlbOsnOtXvvpAJHNp8Ztw16CgVHWWYCNJd
 j5mascRAa4KRV+36SjbyrUuojWjjhA1MAiBYOGvR5DcwmMwFyDyIYZkIU2U/zl5b480W
 OE3jCJOz6mPIggU6wMaIuybiZxNSf9I7zvCc5bWrd8pDKxkfBOhZWU6IBefWH5xKSLT/
 hKMnxItudKRe8Gs/wMKnRcq55bCe8utCNfgd3Ktgvozu/gG5rPF9DhrnYUbqtHzXw0Zd
 cY+gA+wT99XgP3equaV7VoZacTadQwx5syyOMgB6K4GI08vJlatVIpblHRaHzBsvB5vY
 UxNw==
X-Gm-Message-State: AOJu0YzPmIT8yx559eWhBfmjxOhWFfd3XkiMujIl079aHWWiRzQiNVfW
 NhEV3skRxV3iKA/lm7ZOarB7gMYXqunRimEtwQeEXMFpBrc9CrLMxILA/hiQoLa94UrOWlQSrpp
 Xb/U=
X-Google-Smtp-Source: AGHT+IH+5m4FP6Rw8ECLndls6vPlryhMExW7aHeIfdvZ0AQt8MHfnbmecs0xcZ6SU4d6sEGxusU3fQ==
X-Received: by 2002:a2e:9807:0:b0:2d2:43ef:e4c with SMTP id
 a7-20020a2e9807000000b002d243ef0e4cmr5926953ljj.45.1708606555634; 
 Thu, 22 Feb 2024 04:55:55 -0800 (PST)
Received: from m1x-phil.lan ([176.187.211.34])
 by smtp.gmail.com with ESMTPSA id
 fs14-20020a05600c3f8e00b00411a595d56bsm21418920wmb.14.2024.02.22.04.55.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Feb 2024 04:55:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 23/32] hw/acpi/cpu: Use CPUState typedef
Date: Thu, 22 Feb 2024 13:55:14 +0100
Message-ID: <20240222125517.67131-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240222125517.67131-1-philmd@linaro.org>
References: <20240222125517.67131-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

QEMU coding style recommend using structure typedefs:
https://www.qemu.org/docs/master/devel/style.html#typedefs

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Message-Id: <20240126220407.95022-2-philmd@linaro.org>
---
 include/hw/acpi/cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/acpi/cpu.h b/include/hw/acpi/cpu.h
index e011d01adf..e6e1a9ef59 100644
--- a/include/hw/acpi/cpu.h
+++ b/include/hw/acpi/cpu.h
@@ -20,7 +20,7 @@
 #include "hw/hotplug.h"
 
 typedef struct AcpiCpuStatus {
-    struct CPUState *cpu;
+    CPUState *cpu;
     uint64_t arch_id;
     bool is_inserting;
     bool is_removing;
-- 
2.41.0


