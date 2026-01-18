Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 011D6C9830C
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Jan 2026 19:38:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhYb3-0000MB-PX; Sun, 18 Jan 2026 14:38:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhYaA-0007Dr-9V
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 14:37:10 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhYZv-0006su-Go
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 14:36:52 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-4308d81fdf6so1961769f8f.2
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 11:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768765009; x=1769369809; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZDayLa9IHiaG4d3i6+piUlKioZqcrfCwHQyt+SfPnIE=;
 b=E73CLYYU2PKFpdOoULWiO+B7f8X/qXDIQJrwQ2I/tzNyGunyIbynu4uvbbSSpGu+jn
 1+NaOu2utNGeUVL9pYgx6Je7jDHXPeFGKXOMiebP2tbkaNHjy7upglOyjvPezly9Hde9
 43Aw0A2zTeGNcjUyJW4ffhc8CybJARWnBznJdkkn6Lod2mWFJKTxjFx/vs3cfmU+7LCQ
 v68kzaiKLOXYgqCjPATm9nkqLanOJFztD1kh+apeycXIRq2cwYCy8XwcoKjIHwGiQ9oC
 535hZyoCXHbjGS3mCd6eEcMMkMoEWprJzIC3B8ZENta/AfXLjSMPghK9IeOfiHNQsdb/
 NoRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768765009; x=1769369809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZDayLa9IHiaG4d3i6+piUlKioZqcrfCwHQyt+SfPnIE=;
 b=Rups0S9N2Krz74ZBWjYbAVjjdTlj6WhYFhnN+uKTAQmTQCQ5ZTOQEtVkodKeNmXoYP
 i5qkNsqMELO0HXd5kG9NKb0lEUt0jycphbZtTs/V1LO2hCWR3Y5Z2FjeXLagE6bsVj5t
 xJBLJjjbTKqB23BFz2KeGM8BzBBzb54uO+h9iKEPrwT5/vejjMowxmMCYpBhTmeF4thW
 ZK7SN7ZE6eeD9xIOCkIdhjZV1OGSAmGlzxRpOMauZAcxUb5S87I6lQBAq1i07a7m3/VB
 ddnhYZBspd9pxZ522qo9g/apRiAAJg9OQrdJV0carl162fCKZ2kag7/OvidaFAaJ86ck
 xYWw==
X-Gm-Message-State: AOJu0Yx3AY6o5lyK/u/uu/1zMrcRDl7PxCCwnmVtWVNlZ0JGFawsa2rX
 t2/o94oPC+CVrTByC35rjPnF3u0rSKfYWgTXur9mRfcHywv5Jby1pMzghl8vlV4A0HbLZy0JOBG
 Bg9i/2jo=
X-Gm-Gg: AY/fxX46BModipEUl/6x/cYGGP+/ryVjR8bedp01IzdYANTP7dPKhl+Ri4ZPhz4PgWC
 7dA/n0DG0G9IBZB26HvsiO1XbehkkqochAGlq2LQqdQ0cndZF6p78K60q7jviRAkYXGcAqGjvD5
 a9GKLYwgHFJnqfeLiDgAgeVo1NV+U6f/aePctKG7NUJRNr1qtEjY//rwOlScVZsCcHTkPvPE9H6
 Is9uY/Q1NncZM7cdGUBatro7HMn/jG+kZmrh50PKS2qBRve90A5cwkpUos5fY1Ogu/ofchz7Etb
 KtkE7FU7pRZuUup67QGwdbiSEYsCJUbBhabarTpmnL+WOh0IBh5Momm7ZYGYUAVcv7IRqlPwGED
 lUvGraI5gPub5PsFPrr7oC3A0v1KOHHd4WNVCkr6e1L7nPOqxhjz+XvHdm5GJ3JRe68d5JuJIea
 osLbS/ri+GfsRe6tH4SxYpikLCcxTE0Z+0W3A/eUyZNQDAtTkZaEkeEwr8oRYIbdSKdDZMi4I=
X-Received: by 2002:a05:6000:2508:b0:429:b9bc:e81a with SMTP id
 ffacd0b85a97d-4356991be9amr9446437f8f.0.1768765008790; 
 Sun, 18 Jan 2026 11:36:48 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356992c6f2sm18429221f8f.19.2026.01.18.11.36.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 18 Jan 2026 11:36:48 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 14/18] system: Allow restricting the legacy cpu_ld/st()
 'native-endian' API
Date: Sun, 18 Jan 2026 20:35:04 +0100
Message-ID: <20260118193509.42923-15-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260118193509.42923-1-philmd@linaro.org>
References: <20260118193509.42923-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

Guard the native endian APIs we want to remove by surrounding
them with TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API #ifdef'ry.

Once a target gets cleaned we'll set the definition in the
target config, then the target won't be able to use the legacy
API anymore.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/accel/tcg/cpu-ldst.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/accel/tcg/cpu-ldst.h b/include/accel/tcg/cpu-ldst.h
index 0de7f5eaa6b..a5711bc15a6 100644
--- a/include/accel/tcg/cpu-ldst.h
+++ b/include/accel/tcg/cpu-ldst.h
@@ -428,6 +428,7 @@ cpu_stq_le_data(CPUArchState *env, abi_ptr addr, uint64_t val)
     cpu_stq_le_data_ra(env, addr, val, 0);
 }
 
+#ifndef TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API
 #if TARGET_BIG_ENDIAN
 # define cpu_lduw_data        cpu_lduw_be_data
 # define cpu_ldsw_data        cpu_ldsw_be_data
@@ -501,5 +502,6 @@ static inline uint64_t cpu_ldq_code(CPUArchState *env, abi_ptr addr)
     MemOpIdx oi = make_memop_idx(MO_TEUQ, cpu_mmu_index(cs, true));
     return cpu_ldq_code_mmu(env, addr, oi, 0);
 }
+#endif /* TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API */
 
 #endif /* ACCEL_TCG_CPU_LDST_H */
-- 
2.52.0


