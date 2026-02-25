Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6F9BF55452
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 03:58:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv62Z-0004Nk-Fk; Tue, 24 Feb 2026 22:58:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vv62X-0004Hi-CE
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:58:21 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vv62V-0001jP-Py
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:58:21 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-48373a4bca3so37766105e9.0
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 19:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771991896; x=1772596696; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SMyFe4eu+iHwvsCBuCGa19xh1sbiwWJBIH/uf7QzDZI=;
 b=rvxaDjcVaYGyV0DNrTR3+TgHZIWR/UfUs0xM4W0arFITEvvV7S/6e4GrxwKW3qg1Ec
 Z+bLiNwsqfVx9xNf6519fzIBGTD1YUAMqu1qy8iPu0yso243CsS5WXROBKVUmY7cV2QN
 XWF9pt1OKKyvPGU5vxisTPHMg5wX1YVkGSjLLql9UKnyfzewotCuGaB1OeCok2my/F/c
 CGgSFzFf2n53awg4m/8QaMdpHiEPq5l8gOE8gKVfC8CXsipiBg0JwLbg5WGGyFZJRv2t
 d5eh7LIwyn0P7lSj9NfIIprmPJyMI8/5ts9cQOMF9Xz91bCHzMny+JrR4NUd8s/3Lsir
 l6Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771991896; x=1772596696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SMyFe4eu+iHwvsCBuCGa19xh1sbiwWJBIH/uf7QzDZI=;
 b=xOvfVfCPCdrxKT94jLCQNUe/5UNq+SE3wwhFvg+cGlVUxJo20kNSOhuxERP2ia4CdU
 ysmXXpzT8OdGgtdnCiuPKywZNXJTpGpt8gic/Mr26bBpWgZS+xu0elgUqqYdiyBsP8uf
 d/vHTeYP3Wljz6YYaoofSpThL+ewwXKVr8m0sMkjCO7S9wFzvcVKo0aAW2NWk5aWAFRE
 0TtzP+58mcNMgqPoj/fHzCXYqVB4FfEjbtqQQ8rcE0ayO/dQlEJHlYhH2J35rCVgJuaV
 S1dL6JIWGu4it2Xl6hEwes/2heA6lSYTlgPbuSlKNlwoYKq7Ii82F5xb0Gco62qGtD1B
 CpRg==
X-Gm-Message-State: AOJu0YwbzL2lbphv9wHMbvc0gNQp5do/T58faMDuRMD7byDLPhS9yCp0
 ljSAyi65ThGOBM5hBdsadRImy68MOWyPd/R1SOAlKL3pcb1O7OX6iTADZuWMr3QplGz54jfo+1J
 AzZOwFJY=
X-Gm-Gg: ATEYQzw+8SGIGIgVLcmKdSBCsxKHgjAKX319X038WCvgohLAE98LVKHuZUju2dWDCs1
 5ba7qBCFqTTuFOLxeoOfrLHBSwb+FywBN+TLeHrn41r1PAkxF+VKN6MtQWAGAhRLU94ILLJM5d7
 4T2BQbcCP7IDNlCzxhAVd5QWkjtRRUbanfyye5mpZQQg/7EUT9+CGRsGeRgCy0vMCy80y4/t3Cm
 F7jIg9gq0QHv4iVed1roN2QObuyF0MX+R5pu/rmNYYo+XCHYvCiRm3/iaSZxgvYcfuyt2M4J3lj
 hvw6cHBPzpqkLay3SGcAdJYvZze8fqipwjAYZUfioj03EKWlff3pQjjXgekITT54EJpBNlsrJId
 9G8MbEODBEdokO5AmUm2fhcPSy1N+W7ereIfMf0CrgF6NYnYSvW6dJuXWOlo4zJ70oiZrjffKq4
 YLmsx1vG212SLlzBFqQ5UPOnf0aVQH1c7y9Vk8+2iARRJpzDsm4jxPquW9WuGdIj+Y1aVvMADrZ
 PZeW9JWjIQ=
X-Received: by 2002:a05:600c:5307:b0:471:1765:839c with SMTP id
 5b1f17b1804b1-483bef5400dmr11753475e9.20.1771991896473; 
 Tue, 24 Feb 2026 19:58:16 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfcbf5fbsm1502215e9.18.2026.02.24.19.58.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Feb 2026 19:58:15 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 05/11] hw/nvram: Build fw_cfg-acpi.c once
Date: Wed, 25 Feb 2026 04:57:33 +0100
Message-ID: <20260225035739.42848-6-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225035739.42848-1-philmd@linaro.org>
References: <20260225035739.42848-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/nvram/meson.build | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/nvram/meson.build b/hw/nvram/meson.build
index b66f23605b7..26343359875 100644
--- a/hw/nvram/meson.build
+++ b/hw/nvram/meson.build
@@ -18,8 +18,8 @@ system_ss.add(when: 'CONFIG_XLNX_EFUSE_ZYNQMP', if_true: files(
 system_ss.add(when: 'CONFIG_XLNX_BBRAM', if_true: files('xlnx-bbram.c'))
 
 specific_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr_nvram.c'))
-specific_ss.add(when: 'CONFIG_ACPI', if_true: files('fw_cfg-acpi.c'))
+system_ss.add(when: 'CONFIG_ACPI', if_true: files('fw_cfg-acpi.c'))
 
 system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
   'aspeed_otp.c',
-  ))
\ No newline at end of file
+  ))
-- 
2.52.0


