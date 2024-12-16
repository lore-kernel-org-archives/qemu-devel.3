Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F728E7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 03:55:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tN28v-0007HM-8Y; Sun, 15 Dec 2024 22:51:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tN28r-0007G0-U6
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 22:51:35 -0500
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tN28k-0005xL-Ub
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 22:51:33 -0500
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-71e2851de95so814203a34.0
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 19:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734321085; x=1734925885; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=erU6zn+OhBWNmEfsxWhLXaeN8yOIETd3sIFSxTHF/88=;
 b=iSJlBBwDrM6hKE6CS88DFGp7mC9UL4TqFrPBJyZLIDPbpZkkKxCpUsojy4dcGQKx9T
 pqaXS4UvxHCvTvcT+U7b6ccPltOW8JLCbxISghZLD7PVVJG6ygWWWPY4FM7IQcAw6FBf
 DNgHn72FaMuTJCDXjnY7wv4D/LI/hr94tdGucvWSyvbhNxKdFA3wtgpQoqlX9pWW6vfG
 uTwK48BwnxgA0sy8VtSvmMRMiNBiUqXGkY4h5jxYLJ5yPkQ6/mFXMYikURKukXtGQ+Z6
 oyZJcFfOHeVqbcdf/c6TfZZ6Vlzn+4lLD0rASoWW9wXD3bj4yuaxVWm0lIJ/+VU/0/V0
 2ntQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734321085; x=1734925885;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=erU6zn+OhBWNmEfsxWhLXaeN8yOIETd3sIFSxTHF/88=;
 b=hHmL7OQcLTK3DAQfgTzVBhFaMNogKPb2d0UrBEn4G77C3JB+2aJ+VRd0FCM3I3AEuV
 224tos30QkGL/SMJqzQMNbanCjtg3n4nZlfwkusx/TnLGEyOYHggwdA4+xaQ6Ned55Zl
 WDXXS2oUeROmm7C5gYiJnsmIpLE8d8SP+8dkvjgH73dM5Yf1qLUKg2e2ATfLTVMY7JQe
 erRwcqtKMlXsCFlXTTOCxkn8wFkwgs1KvpoG5rwc6E8T9lCSQR6eiKL7RizBPnHn5Y/z
 8LwuGDn4ADzlFC/zycRi7fBYZLZqNUL+dh8kLzHI8MrBq8Gsqj9pZLrU6CeDXofpDa3D
 /upw==
X-Gm-Message-State: AOJu0YyUg3mSzSQRXvSEisH2WYtyPtJOnzGdTBsQX1680mgYHDMuVivt
 0ppW4PorfuOhtI1K8n081igVT/NGhrS5N34IxjUcooDRqLQDq6ec6x1xU0KnsRSDbacb6TfwE7f
 Ma29M4YF/
X-Gm-Gg: ASbGncuBN2mv5fC3j+2wPZKUuOjquW0SIHtpxFuEwul5MahZfE6hnyAz1PUJU375T2T
 EjNOlsWxsQCIXL4YL0jUi+raL7EKfDv4BgCSNTlDAIlUWdZ4PXBs30lZ1qqVBX5ZUsWm0Hxt1qT
 wjZWPDxogmYFrkWGky2ycJ0c5SwGlJ2q+wM/7IaaUZ3Txpv5/9QDkD+B9qfr7jrxEjOpatFDfiQ
 lMIxDFxffwR31IPyiJQU6IHS7RJMovAPL0U/1i9yU7QA5txxytyb4woYNB6f8uO8DwVNaNrEZtO
 BYhNX/nXO2dryhNfb2gcNwjVh6j1RUz66lpfxmli6as=
X-Google-Smtp-Source: AGHT+IFXSkeOrNahCcS7hlm+hirO28G3W9xhmO+ub7Liq1zm8Gh9YzpUsYI4RY4MQwzu6RintfPNnA==
X-Received: by 2002:a05:6830:64cb:b0:71d:f239:c0a7 with SMTP id
 46e09a7af769-71e3ba2683emr6305262a34.19.1734321085335; 
 Sun, 15 Dec 2024 19:51:25 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f33a93a6d1sm1287493eaf.33.2024.12.15.19.51.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 19:51:24 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/24] hw/ide: Constify sysbus_ahci_properties
Date: Sun, 15 Dec 2024 21:50:47 -0600
Message-ID: <20241216035109.3486070-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241216035109.3486070-1-richard.henderson@linaro.org>
References: <20241216035109.3486070-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32d.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/ide/ahci-sysbus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ide/ahci-sysbus.c b/hw/ide/ahci-sysbus.c
index d43db0923f..2432039290 100644
--- a/hw/ide/ahci-sysbus.c
+++ b/hw/ide/ahci-sysbus.c
@@ -62,7 +62,7 @@ static void sysbus_ahci_realize(DeviceState *dev, Error **errp)
     ahci_realize(&s->ahci, dev, &address_space_memory);
 }
 
-static Property sysbus_ahci_properties[] = {
+static const Property sysbus_ahci_properties[] = {
     DEFINE_PROP_UINT32("num-ports", SysbusAHCIState, ahci.ports, 1),
     DEFINE_PROP_END_OF_LIST(),
 };
-- 
2.43.0


