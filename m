Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2647FD7879F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 16:23:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWdFf-00051N-CT; Fri, 19 Dec 2025 11:22:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWdFd-0004ec-7g
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 11:22:45 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWdFb-0006SZ-Hx
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 11:22:44 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-430f3ef2d37so1433125f8f.3
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 08:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766161361; x=1766766161; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IvOQucxMKvOFTIzzs4UAQ1T/36cywHOclRzJmHaR2bo=;
 b=IArLtXfXpz9aGGHj5/gs01uUSMa0nkw7GuIbRHshm4VfkvJ+/TTZlnsr4OkyyYUp5l
 PAFa5thiEOQqVn9y28/gWlMQ2HYnaPjcAEOq3BTHFfa0j96URvNi+iq08fy+ap1WbZnn
 G9a6N68hMiAObYBtyyrEQXLkBXZhXMT3JyZ/s9mp/UdsvD8ZlIe9af/zoYIouAu43XYK
 RqinKEEULar/8yW6krZTVZ2OR7W8I0F81Tzvuf0ZTnebpmIZYBuTikhMkWTTuSn4I/hi
 m1VUCvEGellLgDPET16K3lkeAP4vHbhXPrAF2hr4wkbBPg5ragxUCHGltNlOL6FNLqC7
 bmuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766161361; x=1766766161;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IvOQucxMKvOFTIzzs4UAQ1T/36cywHOclRzJmHaR2bo=;
 b=KRBwXkxwph6CE9GrtpnjFIzkLIMZ+6xKIUagXJlCL+wpYTudsFWSNj5q2fY86+cE4X
 gwmET1fs2+VlqwQNZ3/g2KgXmcZraq2J1wblGk1OMm7T1YgZDR0n4JZfVL7DLRhsR04q
 niMCBML1vI1ha3n5PMXvvuGMF1BupIkBzGT+bgDJQXyUzLZUsUg398PnmIcw23FaSPRU
 IoTkhcwsQ3NgYJBgZ+7EHyFx/ENlwbLx/3tQOHC1sX62Lqm4wYi6DYEDrxpf5r9FZj54
 221T8mFKvc0Xlv0mXapX4kNczTfMMjoaTV7D7NsphiR6dcXBALnuUhwLo7tga4mJiwwb
 h49g==
X-Gm-Message-State: AOJu0Ywcm+xu4aHeZhBJfaEyAayQefNll7u1ph5+uIHZV4XN6X6YeinR
 1UZLivgeYH/gXTTiFvKV3y3Fkz0bUNFjxmPIzlZC4JhAzzp6n4y3JVD6wYfY7jhnagDAC8YLvy3
 1XaZU120=
X-Gm-Gg: AY/fxX53Uf8/0FLXMKGks10fV4Rrr++ckm58X6niwK2ga6mDouwUVwJOQVH9pN4V4FU
 z2XrVJy5avWcJyaONGPtvBMCLDJxP1lahHn/po9t+k8aLluOrKjd22vNbbrNE9FmcCXBozLYc5u
 X7f2QWSL1RaiCs9k6SXJjBPGS43rkBRNf4znC4makOIrjXAGOwX0BfZYefXhCAANKqPoL5pNty+
 RndgNOkOSTYMHbuIzOFIVuxk6ltLwCqqNA5iIaHJ0aEBe0Bz1EsGBriWxD2tx2uCeAH/C5Hx2RJ
 i9n50JDiwpQJsfEilTKZwp6sVQ0QXU3k/7BRJSa8k93yL07W5vvHaEDhizrixjGqn2vkif9476C
 T9PIKlGb+3DLT7cRHrQPK5i8z+ghnI2niR6CbAHZd6nR45CtUTwqp5x0rGSBRY7pROr4+Kpf7RR
 BqI1ewQOaNeoqEHtbYJG4rZbbofoOoOyu9EuOW7gdGrl9XwpZqrzQz5g+JOGue
X-Google-Smtp-Source: AGHT+IEDcFQLFxGPpCMUvcpMVn+BEzVAnKgvVjCtXGrLU5lVRO3p4pg3MpdlPeVuUQXIRurVkSYjkg==
X-Received: by 2002:a05:6000:2403:b0:431:35a:4a7d with SMTP id
 ffacd0b85a97d-4324e708fe3mr3576594f8f.58.1766161361524; 
 Fri, 19 Dec 2025 08:22:41 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eaa2beasm5854160f8f.33.2025.12.19.08.22.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Dec 2025 08:22:40 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, David Hildenbrand <david@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 23/24] system/memory: Restrict legacy MO_TE 'native-endian'
 definitions
Date: Fri, 19 Dec 2025 17:19:50 +0100
Message-ID: <20251219161953.72724-24-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251219161953.72724-1-philmd@linaro.org>
References: <20251219161953.72724-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

Guard the native endian definitions we want to remove by surrounding
them with TARGET_USE_LEGACY_NATIVE_ENDIAN_API #ifdef'ry.

Once a target gets cleaned we'll unset the definition in the target
config, then the target won't be able to use the legacy API anymore.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/memop.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/exec/memop.h b/include/exec/memop.h
index 799b5b42218..3545592765f 100644
--- a/include/exec/memop.h
+++ b/include/exec/memop.h
@@ -36,11 +36,13 @@ typedef enum MemOp {
     MO_BE    = MO_BSWAP,
 #endif
 #ifdef COMPILING_PER_TARGET
+#ifdef TARGET_USE_LEGACY_NATIVE_ENDIAN_API
 #if TARGET_BIG_ENDIAN
     MO_TE    = MO_BE,
 #else
     MO_TE    = MO_LE,
 #endif
+#endif
 #endif
 
     /*
@@ -150,6 +152,7 @@ typedef enum MemOp {
     MO_BESQ  = MO_BE | MO_SQ,
 
 #ifdef COMPILING_PER_TARGET
+#ifdef TARGET_USE_LEGACY_NATIVE_ENDIAN_API
     MO_TEUW  = MO_TE | MO_UW,
     MO_TEUL  = MO_TE | MO_UL,
     MO_TEUQ  = MO_TE | MO_UQ,
@@ -157,6 +160,7 @@ typedef enum MemOp {
     MO_TESW  = MO_TE | MO_SW,
     MO_TESL  = MO_TE | MO_SL,
     MO_TESQ  = MO_TE | MO_SQ,
+#endif
 #endif
 
     MO_SSIZE = MO_SIZE | MO_SIGN,
-- 
2.52.0


