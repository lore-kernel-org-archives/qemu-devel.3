Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9598EE77361
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 15:25:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYQjp-0005JW-Qc; Wed, 24 Dec 2025 10:25:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYQjP-0004r5-4V
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 10:24:55 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYQjL-0004od-OB
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 10:24:54 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-64b81ec3701so9181042a12.1
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 07:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766589890; x=1767194690; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E2FATmjfi7jbn0wTMj7Ch37A99U3l9p/Q36CDzawdLM=;
 b=QDZHUkeGRHs1J7F4ZjfMqUOe7yA8qRROZG1i+qSD5CNNS7h/qODqFmW1XzFumIdIcO
 4FJ3hmy4syvJVP8vZt/Z2jDtxnm495XxZWzHiUdcxU6R8ZbJIB/ivpR+trt4X1eR0tU0
 RMAw+h9Ux1QvkS/PEhv/FKMiFI8ehVRMapDS4n/4szM7KdE9Pa+/6ARqlTzcR6Sgmxji
 M7+PBnqzTZrOTPsZVsiPscZrBDkMz3uoVRbTw87RI7UrRSKBW/nfQsuG3gOP0FhIBjbd
 /0NQrjHp7vchdPs7xT8tnAl/zuwmP0ur7aKTcWYakFdODlgznQWRnS1H28OB2XFJAY3v
 ktbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766589890; x=1767194690;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=E2FATmjfi7jbn0wTMj7Ch37A99U3l9p/Q36CDzawdLM=;
 b=vJUIz8tYpj0iy8g3w6mBljWyCFtKpj5LvdPhXs8fmXNcsFv5fhDFRDFup7rQdOmAiE
 wyiW4CsDx/Qa7ByZcqa7MmEOMCZgjDQih2isYoVy7vI+HJ8+HAeFKq6BL8gRyu8kfW0j
 Q7/XaKimGxxUQDgRS4++tUq34/GZ6bM1Sli3qCp6YSPlt8kNYzANc9/EGU45hx9kfQwv
 Bo9w8LhgY6FCiNiS5ueAYOjKoFa28fGhsPPsnljDeokAAWWV22sAaKFZ+2b8jwRIr1vR
 8vQ+xf5rPiczXvcmNhqYGKV1CCz5IsrxH4MYHkQNSGCOPiXHWrJNiy70cJ7AoyxU/yc2
 fU2w==
X-Gm-Message-State: AOJu0YynzV4XfB4jV+iSTO4ScCa6D69vYzguFcq160Fv2wcudX76Z/3q
 zqZjlkDmRM7PMZFPNdDlxcyFAdJRvq46OCHthwPZuWqvrfMGhUjJAombQS2q0z+bm1Px1jUqsSB
 t0ADfffU=
X-Gm-Gg: AY/fxX5C+aCVaIKK2Gr4UAiymO3IVrcbZQANGgIOABmweMJiEmIa1f/WjEUlU3ZwsgC
 rjlxJam72PvZeXWSFGGMmHaV2LCmBIHPA5MbOFjFxQfm9Rs33mzC9+MAkzzHQBfgEPN+Qrhu3ph
 dTi2xMSbDGl/c1JOLQY3VUO3Jd42icXCEsqio7R847N2Yas9l2gF6F3gduuZE37h0VuYJxqRUz4
 fkYGe0UBVsU3qSzP9YgD3BFppnYxHRUayU+cStkUTFwpmK8sE9kFJaILve+cNIuDXYrUKD0rRlB
 fpEfzdRt02YPhQFj18NnH6jwXfD5gTwSszAsjwPe419l+BTxo+9q4nZWtnz1j+xX07dTcxd11xZ
 c5BhcksOMnStc3Kta+EWVHLG857+7HRdMQLk05E4dbM0o4W25GlcBfnYICIxBq/2svZG76pbGae
 zY7Rt3tr9C7Xn9nZpkC7vra2dn6a1sgDxWGWNen5rGWXyAecBVi/nMKBc=
X-Google-Smtp-Source: AGHT+IHzIcvDRnQKADSpZ8zkhWaMire0DZ/61QKA39Pw/VZv+dRARkJNkDeB1+iylVPc9WhPlMC/5Q==
X-Received: by 2002:a05:6402:146c:b0:64b:6dfc:dd34 with SMTP id
 4fb4d7f45d1cf-64b8e3a95a6mr19985940a12.0.1766589889840; 
 Wed, 24 Dec 2025 07:24:49 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-64b9ef904bcsm16476641a12.22.2025.12.24.07.24.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 07:24:49 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 16/25] system: Allow restricting the legacy ld/st_he()
 'native-endian' API
Date: Wed, 24 Dec 2025 16:21:59 +0100
Message-ID: <20251224152210.87880-17-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224152210.87880-1-philmd@linaro.org>
References: <20251224152210.87880-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x530.google.com
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

Guard the native endian APIs we want to remove by surrounding
them with TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API #ifdef'ry.

Once a target gets cleaned we'll set the definition in the
target config, then the target won't be able to use the legacy
API anymore.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/bswap.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
index 65a1b3634f4..d1c889e7bc9 100644
--- a/include/qemu/bswap.h
+++ b/include/qemu/bswap.h
@@ -412,7 +412,9 @@ static inline void stq_be_p(void *ptr, uint64_t v)
         }                                                               \
     }
 
+#ifndef TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API
 DO_STN_LDN_P(he)
+#endif
 DO_STN_LDN_P(le)
 DO_STN_LDN_P(be)
 
@@ -423,6 +425,7 @@ DO_STN_LDN_P(be)
 #undef le_bswaps
 #undef be_bswaps
 
+#ifndef TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API
 
 /* Return ld{word}_{le,be}_p following target endianness. */
 #define LOAD_IMPL(word, args...)                    \
@@ -494,4 +497,6 @@ static inline void stn_p(void *ptr, int sz, uint64_t v)
 
 #undef STORE_IMPL
 
+#endif /* TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API */
+
 #endif /* BSWAP_H */
-- 
2.52.0


