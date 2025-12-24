Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81680E7545C
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 15:26:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYQkR-0007yG-Ru; Wed, 24 Dec 2025 10:25:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYQkP-0007ki-FP
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 10:25:57 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYQk3-0005Bf-Sf
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 10:25:57 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-64b8e5d1611so7292261a12.3
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 07:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766589934; x=1767194734; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rHOVluu9kB0fVsABBF3cJLWm84ZoSOynpEXEKwuisGo=;
 b=VSYF1D8VFLoVpij2uN3yTn0PoTvo7XAnfmvRZcETT6FhuvV0+g1r9DCzhhC3pBbsPl
 dLFCXpqU2gEgpWzx6dDYNXGLjPP3qnaE31lTkTXK3X3j/ydZBEtRxraZiq58yI3dvooa
 z6F3irBbl/Tz26TTT/B3xo/uJYWdRuXTOP75ptQJwXukpUslP291Ydrv2c6a7Qm5UXLi
 0CY2TTqCt+S4q1h7LIjFSIIiLc1fQpF9IGfrAvcc6OXP89ho6QcUrJGhypImPVXh5a5V
 aJesJpkaExVUaTqwF86d2PkiMyNBZp7TB6Uq50F5HpfazFV8HfyLrX1C/FvE+PwkKS2L
 +DcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766589934; x=1767194734;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rHOVluu9kB0fVsABBF3cJLWm84ZoSOynpEXEKwuisGo=;
 b=r5rENd9AG1eKDHrgEnPDoqmJa0g2lxzCmrq0pxTQNEp9FC1g/yPTp5n3a9HkULT9rb
 eg4hwVggIWMCp+dT5fp0WvTrcLWE82P9OwioLP1m8wJIOLgo78Fno16xndNCoqVUlxlF
 b6rLh0tLDAVRZfrP8mw5h/ytMrMvPZm+H/MEKEhysP1LKJrShb4jEaXKhUE55XsmGuhB
 niZrX+l5djPsXkQlQ1LH8mSycHOHID+beMLCeLVZVzZxkCe0j/RjQ0sLhlmaGljZ5T6/
 XJF8/ljGy6Q4qxEdtQDXunluLaOO72PCW4bIIyd4lOLzcAAMsiZzBeDGmWjjQObPv092
 /mBQ==
X-Gm-Message-State: AOJu0YzVaoVtgz9WqSmiES62YFIR5C1CsPdbuhqdONthhfoyDE685HWE
 xDyrwNV9h9WcoOEYeoL1V68K2tSldquiw+edvTKCuc49ftwEye9pGVg3O55tAKvr1xxZHS12RA6
 jg0yfFQI=
X-Gm-Gg: AY/fxX5UomlJ3F/1+EcmnmzYCHqil1Hw95wpo71fd3yryDNBFbtu+aM8DFOhM78R9Wc
 SRjn5jYe4/4xKZlZSWrji0au1GC9aB2evd/9rJYTZH2M/WbxjNKSb5jHN0HFDanWrLE5AJnrTNM
 ImDrAGXwxqXUKayu+9VXQBYvF7wyO6z60tmrZjOkxJFcVQ5OVfae7GzLBO6Wa3E/bFW+0bvlaJC
 cdQ7/4Odjo3LdOYsgzDVssUcxUhAvoX2yi4Tvgs8yxoH6CiFCObzhQlE6EY9PnCttjm9lSog1vo
 L+9oL56WJNvJOXOXaYvT/al+6UPLOZxW8O8VA42gtO0aNYXwmskNjObVfxMSNeZm6erPiIfzQG1
 R3wf6YIPYL4nOifsqdeQrkUXp6HAHGjm+tHEYQxoIEoE2P6ILsQ43ghoWRaSoD8IVUYcbs3T2UM
 21czIhvrVMgo9XE2zbi6W3Vpzfqj9wwMytd2ibY/QNRgrbg5iV4tG9n3Y=
X-Google-Smtp-Source: AGHT+IFmSjHTpcIezrUwuMTY1I1Uo3+p9B7kn5YPyAoTTTJVwxlfon9CwCYKgZB+1cUuZ6o58HyRtQ==
X-Received: by 2002:a17:906:7315:b0:b73:398c:c5a7 with SMTP id
 a640c23a62f3a-b80371a7253mr1830677166b.41.1766589933937; 
 Wed, 24 Dec 2025 07:25:33 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8037ddffd2sm1702183166b.33.2025.12.24.07.25.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 07:25:33 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@kernel.org>
Subject: [PATCH v3 21/25] system: Allow restricting the legacy MO_TE*
 'native-endian' definitions
Date: Wed, 24 Dec 2025 16:22:04 +0100
Message-ID: <20251224152210.87880-22-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224152210.87880-1-philmd@linaro.org>
References: <20251224152210.87880-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x535.google.com
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
them with TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API #ifdef'ry.

Once a target gets cleaned we'll set the definition in the
target config, then the target won't be able to use the legacy
API anymore.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/memop.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/exec/memop.h b/include/exec/memop.h
index 799b5b42218..4aaa6a0ab02 100644
--- a/include/exec/memop.h
+++ b/include/exec/memop.h
@@ -36,11 +36,13 @@ typedef enum MemOp {
     MO_BE    = MO_BSWAP,
 #endif
 #ifdef COMPILING_PER_TARGET
+#ifndef TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API
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
+#ifndef TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API
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


