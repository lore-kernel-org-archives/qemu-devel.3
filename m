Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE4D3D3B7C1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 08:50:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFrGR-0003T6-1w; Tue, 26 Nov 2024 03:49:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1tFrGO-0003SR-J2
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 03:49:40 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1tFrGM-0002jb-RF
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 03:49:40 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-aa55171d73cso321471066b.0
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 00:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732610977; x=1733215777; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vt+DBc9E7puNWklMEXZgAviwA5/ofl4yBlgoefDshmI=;
 b=tQg3Jq5DZnvfe9doH6WxvWW/akicfU3lIpu8GezrivQC1w2ZhycvhPMCY9VHcuc528
 ROtGO9fcjagM1aUFLoVSskooSeJIVulSuRT7nOjCaPBafslXk4qFzcH+0NLG0cO2ZNCy
 SxzQbrEOaxeJKVZua5KEYV8UqznE52gYZ8iLDlGoMWMy1Dud9IOEB4qzxFjUqVAqFzk9
 DzYTT7cd6vUiudaq/SuhQ9OERHSv4mvAL0WaMR+25T2UgE5xEuIaYck5S8tPJcH4iscK
 sXmtIOjnK4igDsVRgJgbi6he4JiXTz7YlHt6DSiz3yLdJ6RMrZhJFwnt3bH/fWg319On
 K6cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732610977; x=1733215777;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vt+DBc9E7puNWklMEXZgAviwA5/ofl4yBlgoefDshmI=;
 b=HkZYHMXiF4dKnn3SUZYUlhJighI9Ce1I5qKWgBVyMqQZkThebK2zufgK/VxTt6VbNR
 gxD0QJZRgpHk45vY85sRx8R7nxnMlNNQQJ3+Dxzon6+b03K1/4KcUVvOZvu20BYdCSLI
 Pkn5dobro2NxnQMoZYeebDs+4K4dCJ0L/3gvn8bbcftru48NQZr0yWgwpTJFxVd0YYG3
 kk7o00AD8mz0LLLpqML19ajF+ClTul/zvJevv5LUE1Pu+6pGQxzShctzFWPeyZyrv0Jn
 avZZHbR01ck8gEi/2STg0RaC2iFhOVsQgn7eSc/y9AIlrvpTWg7TTBJ450bL+3f9Gq7M
 c1JA==
X-Gm-Message-State: AOJu0YyeAMUV/hsL1VjFk6P+hs2rfzBNjvWwisMaGQUh3/BnUNsuRJ7V
 Rf8LzLBJEmTLTI4mp+eQPTyDkk1HQEDQ9l5KAZE0z45lGpgmG0CfeXrBLNFj4UlOaqDBjPicMQ9
 +
X-Gm-Gg: ASbGncs1RDgTxNVzbLbE8MpxZDma4hqvp5LrQrzB1p8iForLCsyBEyiM15pFzDeUp/n
 yEY8Lx7fU3ppDgy283aVFX8VjTtQ0hfEQQJ44/t37juCq9WHJQVWTsZ/kA2Lh1StjDcXjh0DBUC
 qfX23MONYDBKzoS3yalEjaVwuqnxcMyOb3spDlURiAWD/dSzkMY6Ktvsq5nui1oarUcigR3cGb9
 ypVBfTcJjt0VEexw3g+hECYM5cf0wd7JGxVOg9J/zOiXjlk6EGntXdNY8IHKEPcfaJBfJRDWn3T
 80ohc1HAAhWsSzJI9YBaNbjAug==
X-Google-Smtp-Source: AGHT+IHidfZq/knKBoKFvpKkkEHxCbz/LGwO+JDb4GD0DM9pFMqQQC9eBUApKNGu2ZpNIhOsX6Tlrg==
X-Received: by 2002:a17:907:7809:b0:aa5:2e06:7e18 with SMTP id
 a640c23a62f3a-aa564891059mr223979966b.10.1732610976879; 
 Tue, 26 Nov 2024 00:49:36 -0800 (PST)
Received: from applejack.lan (83.11.10.28.ipv4.supernova.orange.pl.
 [83.11.10.28]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa50b2efbf1sm568553666b.44.2024.11.26.00.49.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2024 00:49:36 -0800 (PST)
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>, qemu-arm@nongnu.org,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Subject: [PATCH 1/1] hw/arm/sbsa-ref: bump default memory size to 2GB
Date: Tue, 26 Nov 2024 09:49:28 +0100
Message-ID: <20241126084928.252067-1-marcin.juszkiewicz@linaro.org>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-ej1-x62b.google.com
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

We are working on adding RME support to SBSA Reference Platform.
When RME is enabled then RMM (Realm Managment Monitor) takes 1072MB of
memory for own use. Which ends with firmware panic on 1GB machine.

Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
---
 hw/arm/sbsa-ref.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index e3195d5449..2195465202 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -901,7 +901,7 @@ static void sbsa_ref_class_init(ObjectClass *oc, void *data)
     mc->block_default_type = IF_IDE;
     mc->no_cdrom = 1;
     mc->default_nic = "e1000e";
-    mc->default_ram_size = 1 * GiB;
+    mc->default_ram_size = 2 * GiB;
     mc->default_ram_id = "sbsa-ref.ram";
     mc->default_cpus = 4;
     mc->smp_props.clusters_supported = true;
-- 
2.47.0


