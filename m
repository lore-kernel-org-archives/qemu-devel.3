Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E445E77180
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 19:35:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMBNi-0008Qv-Mf; Fri, 13 Dec 2024 14:31:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMBNd-0007ya-5H
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:31:17 -0500
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMBNa-0004K0-TM
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:31:16 -0500
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-53df19bf6a9so2911095e87.1
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 11:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734118273; x=1734723073; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+4rdkJduZkbXz6JmK4QEKv1jKAaYDuIzC71PHld//xk=;
 b=B63d/NmfNI69OdSEksZuyj/v8mDEINqLsjO3PNjCLPaDgq6VOF/s8RPa85Itad30Id
 xL1cnN2gzlyum0zR17UczJrciVNyckVTLJqYjqEJhC0n8HhtPLSlo1HSDgg/yl6Awl9F
 HIMGtFBxJwVcogpAdDonUpVJQcl5AZvDeoyWBp2lzfrLan5Bp/Wg9Iy2R7ZWQaAX7smr
 SD7UVtZ1TXyDeVa5kXRQBGyKVT/IV1t2ezsjOJtzGzhLIzaH2E2YlwfP0pKoYHZ9+JRW
 qxTyNgpD/kVSG/sKsTMfxPNDYDTh2Lc/y1l6wI/zlkXqv1AXNuQvFmd3FXPQPwcP9l4q
 aCkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734118273; x=1734723073;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+4rdkJduZkbXz6JmK4QEKv1jKAaYDuIzC71PHld//xk=;
 b=PwLEgCHKMRjYDw/ioRqWZQwUqdEKafc1GLsg5ieCOh6rQmsNf6eMTBu2cTWKD97eV/
 t4D4rd41t4S6TtEkZhWRyijOg7THxqXbnY7P5QgibcEt0CKYV6pG1qVlMUN5N1Py9mLx
 /1ackE9b8c2BQ00dPSFnlevqNi5WnP1yUhNrAq14tlM+7d4VPsrlzYSQBqBX9934Y3bJ
 2unQYz8zvMQJU0Ol0PSUR6HmehylAv8L93xQa9umlxd9QvPa19sQjskv7Z7FI40IMkUW
 Y2eAmmbB1ST3VrpTlJikyYqSDL7Dw/nwHKHpmr6QuWX0zcL8thUu9Gs/KEAjBYbYDj1+
 lfNg==
X-Gm-Message-State: AOJu0YwjhaG0xFXWbyCJeLJ/9Ocr/mNSpUFTc3r3NcMJQ4iP+ik19IRX
 FtrsvyJBsu0TRvct5VfuRo+AaEZ4rkKgpAfTzftb1TMkj0SBHd6e38jjbWC22Rx5nt+Uf0mRkym
 nuxHSWqiy
X-Gm-Gg: ASbGncvuXkjtft6JpERa/h8L0BddCRRvrOR7PrSky86/zrMbUhDn+hC9u1nbzAsZ61D
 s/tE6dF03czQY0A3tYTo4AtSUYJhcUK2gpJkyynq2RckDNMncyBzgVrFCpvnSg9IpR3tZWcQRVY
 Ak80bdGla+WAaC2nNJ/wqIwELw7+2L6PMKck8zSpyXz9gJyYtAfs8h7WwyO4jQYiCP6LIt4nKsr
 xzIndfcndrrBkyl3WNmqge5khxOsrs1yRiR7ZtCXDU294DHLOE5e9+5NpafqQ==
X-Google-Smtp-Source: AGHT+IGZaw7fo6ASbUtjikNIXECL567eaI66j1GW7LxGSht1RWaflHkAodf93EpmqmK03VfVVYaaWw==
X-Received: by 2002:a05:6512:1288:b0:540:3572:bb6 with SMTP id
 2adb3069b0e04-54090557f0emr1423299e87.15.1734118272736; 
 Fri, 13 Dec 2024 11:31:12 -0800 (PST)
Received: from stoup.. ([91.209.212.67]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-54120c204ebsm6723e87.250.2024.12.13.11.31.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 11:31:12 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH 70/71] tests/unit: Constify all Property
Date: Fri, 13 Dec 2024 13:31:03 -0600
Message-ID: <20241213193104.2515757-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213190750.2513964-1-richard.henderson@linaro.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x12f.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 tests/unit/test-qdev-global-props.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/unit/test-qdev-global-props.c b/tests/unit/test-qdev-global-props.c
index c8862cac5f..1eb95d2429 100644
--- a/tests/unit/test-qdev-global-props.c
+++ b/tests/unit/test-qdev-global-props.c
@@ -46,7 +46,7 @@ struct MyType {
     uint32_t prop2;
 };
 
-static Property static_props[] = {
+static const Property static_props[] = {
     DEFINE_PROP_UINT32("prop1", MyType, prop1, PROP_DEFAULT),
     DEFINE_PROP_UINT32("prop2", MyType, prop2, PROP_DEFAULT),
     DEFINE_PROP_END_OF_LIST()
-- 
2.43.0


