Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3377D7879C
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 16:22:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWdFZ-00044M-NU; Fri, 19 Dec 2025 11:22:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWdFP-0003pR-Q7
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 11:22:33 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWdFN-0006Po-6Y
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 11:22:30 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4775e891b5eso8164005e9.2
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 08:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766161347; x=1766766147; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BpjgfT5VSI3t/6S6vaApflnZkyWTsFc2Sy1vcWpsXLI=;
 b=tlU4f6dVCNrDU9aB7kiW8ph7NOx9eMUbfppTIkrVhVsTfGQ99uZNk1k1n3NleLrQZh
 /ZevyRoi4WyAiqHOFwFZ8qQ8RkOTSiyK8uO+shStkDOS7i3CmzUCrcrVDGah3pnIJWhD
 XOVqyMkz8cAegbB7l2eB4JCg8qRxpGansDvOqXvzfm9JLEx38X7ficYQjIOmJWrZsoX8
 ugsdHMzPtA7sMBaCouAdBL3e6Qn675QmF1aI9YWqoqAmnpadDUmopW/7ubaesMZ21gmb
 Hsi0HegyHsc0WRZ8CO+xgc/RItNgvmFEFBi90/VaKt44znc7f/mvvCUoRbzVnwd85PMy
 LS4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766161347; x=1766766147;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BpjgfT5VSI3t/6S6vaApflnZkyWTsFc2Sy1vcWpsXLI=;
 b=s5N45xDqzhdkCGHSx6KNs1bPjEGJatgTDA02TX329zP/YYWKcq007Cpbb0wMLh2W/l
 edGSx5OwlmiZqFzmwAJGyuHvLS1DlN1H0L7Uuxbui5rmihXVst/q5wJAdiIfPDQSNGFr
 EQoncXBDBoR+iLCXM4edK2oYhUBXfoMXhLLBy9s0KcjPJTflC/c9X//aeWu2163hOerm
 2J95v1pRxcwCQaxgkMMsHNHDqPQlwcIrK5SIV+14ckmXM8O/oNvJWaDs2/3tFsmJ9hdp
 /Ba5qZewEIrNgFnz5uA+eRcEsK1YplAjv7G4mhQafIpl18EK15vekAs98LnUfNl6ocNy
 71kw==
X-Gm-Message-State: AOJu0YyYwzKvikY2ygecSawLxXysHrk3LOda3d/ZbP1b6CoXpaz12eJJ
 EciWogozlbjoTtYdgfY056i0ZxI/g6HQ9y2naOEx7W5iB3sUXqOz5+hY/Y03RfGD7sT8iGLrznp
 DEh93qw0=
X-Gm-Gg: AY/fxX4bPg9ouuFIrYhT+wOyd0CYKwh73Oa2cSfgAaC/BWpK9oct5HOmC7idCqo7pvF
 eGDh25PC7gFvIpc8zL6L+thn3IG0Q/3xaGMO3gayXADht93PuWAMxLilW7TPD2QmftQKDxLR/Tn
 8YAXrurHA/H/unJfEIeOjgSikjL7gxFxkVR/DqJQWsgpDDmWVtNc+8L0CSYyPqbRHRm6xmf1n76
 h7Ab3TPb6jgTiiRIojrS/tADF6bDg5NDW1UCGuBDY36Mc2z11baPrvcBLzVoujiqGJsUaAl5/QJ
 BdD48eihe3zOjd62XW4v3evuBaskF0elAzvmAiFLgBrsAO68MI4wJToNFJXVzXZHZ3qwNXuHl/9
 dlGLuyJ+dsuPi4CvW1FTesngFkA0XpTqdBqd2VfBsfSvucv4vLSJTrne3Du6xnC86mC7uCRJBvi
 5Hy6IqCEJCHgamVSVbY8AEAu1vBQlYqmdpXID0o+ykbq7/Dnl0CQUvyma2fKy+
X-Google-Smtp-Source: AGHT+IEIoop5UneoLJ0ulg3j7HfIDhkh8nnEHCs1MnnRLTrcdx/hSuqQmA8K8qB9dza+R65emYP0oA==
X-Received: by 2002:a05:6000:2386:b0:430:f718:2388 with SMTP id
 ffacd0b85a97d-4324e4bfa20mr3195495f8f.8.1766161347302; 
 Fri, 19 Dec 2025 08:22:27 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eab33f5sm5911303f8f.41.2025.12.19.08.22.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Dec 2025 08:22:26 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, David Hildenbrand <david@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 21/24] system/memory: Restrict legacy translator_ld()
 'native-endian' API
Date: Fri, 19 Dec 2025 17:19:48 +0100
Message-ID: <20251219161953.72724-22-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251219161953.72724-1-philmd@linaro.org>
References: <20251219161953.72724-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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
them with TARGET_USE_LEGACY_NATIVE_ENDIAN_API #ifdef'ry.

Once a target gets cleaned we'll unset the definition in the
target config, then the target won't be able to use the legacy
API anymore.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/translator.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/exec/translator.h b/include/exec/translator.h
index 3c326555696..30e6596c5d7 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -188,7 +188,7 @@ uint32_t translator_ldl_end(CPUArchState *env, DisasContextBase *db,
 uint64_t translator_ldq_end(CPUArchState *env, DisasContextBase *db,
                             vaddr pc, MemOp endian);
 
-#ifdef COMPILING_PER_TARGET
+#if defined(TARGET_USE_LEGACY_NATIVE_ENDIAN_API) && defined(COMPILING_PER_TARGET)
 static inline uint16_t
 translator_lduw(CPUArchState *env, DisasContextBase *db, vaddr pc)
 {
-- 
2.52.0


