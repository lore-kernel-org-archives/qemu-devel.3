Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04CD1D711C6
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 21:31:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWLat-000421-CT; Thu, 18 Dec 2025 16:31:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWLam-0003pC-4x
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 16:31:25 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWLak-0000Cm-PD
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 16:31:23 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4775ae5684fso4552245e9.1
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 13:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766093481; x=1766698281; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rm4QE5DZffmJMRXvEQpcNSWzIzngXUmmcZvTA3tgWo0=;
 b=KlNyaclm/naO5l58Y3OKtdHu97M+Z2inTgcTA6BiBvwLIYTe7aXtB+KJgRfA0GGUcg
 CEFYXcQ4Dqa6583YDwZZUEPt69Byh7XkYU9XPIS/50mOdU6g4LHjj9pY3qMO4/Jssz5H
 vReQBp4L7++ckGv4JgzAC/BDCdchDecMduYiBHULL0YgRgnVmoQcaByXYrZt5rW1703t
 4sAk3jlDgJRnker970iGnGj5Sk08ZfiIEYd9BUWCxk5/Zd/a1yV7v7qkrmqrmSA/a1kz
 F+87WOyzmGqqGfrBeLz/8a42z2T1EuqN7VllmNrWwlBRw2gesi0WapKhT+cmeGHqdtqe
 Euqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766093481; x=1766698281;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rm4QE5DZffmJMRXvEQpcNSWzIzngXUmmcZvTA3tgWo0=;
 b=e+6AdrCiHrmK9fUUMbyttLAlgXOgeTjXrrIPPDNPnBh1fpUSLEjD1vVUOgar4275Y6
 M1EQ3PLklg8UrZu758umP7XUoOsU+eC42Q+iqaakAVBuEaODopIq2gFpx+qivZ/btCDw
 cr0DeSCDjUp+JPm2TxulGj5ZaAmRWj265/F0fAkccb/xIxaf9WYg8aSB05eQY8wBdjhV
 capux9Jg82S7578NvNqcYGV6pFuaqZvIJOUzAJWmU9YBZMjft8fyTrdOLf3pnjQedxUX
 FaTg1I++hnyeKcOMITct2hsLnZNEhj6In8iBPvZljrCBGOmn0Lsx6HkoaHHnXw/U8ayT
 twTw==
X-Gm-Message-State: AOJu0Yx2vHzQdsNYeqx686EruLvECt4okeMjN5MyPTTuMYbBNXmvVNHG
 0OpRkj9xqAvzYgy6UE7s3TG8t3H+N0hvY5bFODXJJkzZqU9RS0fdQyXhVhfgbr7YigcGtcld7w9
 uFxjrliA=
X-Gm-Gg: AY/fxX4hSKlqRyaUtOetQyME4DBZH3Kj25wsu7n3BtN5eTyoxD824ZP4/e3i5ZCLBUg
 51BkD0wSGDNOQsq5F4Ie9WuziuAMAEuxhdQxgN6ZZFbpIf1RtpS7wNIE4UFX7Dmei1R4JNMjuRe
 UYF0dSIpWNkesBALVgcL7YlG/h2KVfh1n0N8ZJ4gv1Vv1Y4L8z3aDHQmxMsTus89KW7Ud1EnlSP
 gwrsGhQF49rfdbSR99IJElyz4NJ9tJ0GymB7RJpwCxWDte21Gu9vWyKORBRcHAbbqBwY+TtK2BE
 1ixA8oz9fQ/s+jABZWukYGtxkzs05YzvWnLTAhQt+rCfWFAzCvXotVIAl+RgaqoccszRJls81Mg
 0lLoG/zT9HnWSpcechywFWubunAYTEJulMnyL5Oz9K8wAd+/PLFWuswuIbTAFHyJjVft8I/3J2d
 vckPWsTmmXrhnwwVVsYoEWACMb5/mdBXt1PMDCqZwswMXggxRNc1mGYLFfTwuntQIcR//4sfM=
X-Google-Smtp-Source: AGHT+IGtEfNvrJkAnMlrx/rHc9NUSbky0mhysBuAmKhRwIDfIqlVSnd7ElPYchOPKs3qOAzkLZo2hg==
X-Received: by 2002:a05:600c:3e0b:b0:477:2f7c:314f with SMTP id
 5b1f17b1804b1-47d19555af8mr5777855e9.10.1766093480893; 
 Thu, 18 Dec 2025 13:31:20 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3ac5409sm20158105e9.15.2025.12.18.13.31.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Dec 2025 13:31:19 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/3] configs/targets: Forbid AVR to use legacy native
 endianness API
Date: Thu, 18 Dec 2025 22:30:53 +0100
Message-ID: <20251218213053.61665-4-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251218213053.61665-1-philmd@linaro.org>
References: <20251218213053.61665-1-philmd@linaro.org>
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

The qemu-system-avr binary is buildable without a single use
of the legacy "native endian" API. Unset the transitional
TARGET_USE_LEGACY_NATIVE_ENDIAN_API definition to forbid
further uses of the legacy API.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 configs/targets/avr-softmmu.mak | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/targets/avr-softmmu.mak b/configs/targets/avr-softmmu.mak
index 1aba1ccf13b..b6157fc465d 100644
--- a/configs/targets/avr-softmmu.mak
+++ b/configs/targets/avr-softmmu.mak
@@ -1,4 +1,3 @@
 TARGET_ARCH=avr
 TARGET_XML_FILES= gdb-xml/avr-cpu.xml
-TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
 TARGET_LONG_BITS=32
-- 
2.52.0


