Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF058D10386
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 07:54:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOAKc-0004ik-2V; Wed, 26 Nov 2025 02:52:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOAJJ-0001XM-Aa
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 02:51:33 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOAJH-0003Yx-NV
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 02:51:33 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-42b32ff5d10so329955f8f.1
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 23:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764143490; x=1764748290; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HqbvtytwZhlAGHOU7hmLAcqlvwP/xTJGGdaDHqryDAY=;
 b=rjtEanewijlZcz/mMto5yZyoarwwOKNaSIYcVZFdqRx7VGR+9p6EPpxoMLYNEOcL34
 a/Z73YNGACeOA9GASeOFPAxsdEyhMzZOuoUg1z5gnB7OdUQb4AvHM6fNMc5uNrWdjNoY
 UAA5FnDin+Jj1nGg1uD+ic0WlHoFWy+ZYx0wPmmMCVP7c42H1AeQhw4kGZVe6R7rXpFJ
 J/VuBzLAmvNjFO5MMlMr68Pk4W7rDz4Jc0zXs/6kpoYLCI+59IrDkpf1xir3AweVNFhS
 Q6fjzFgUHnO7elvIZ5Fc8J3XoigzEgJzl3UZdm27tO4HIO0ML5+JLzt5zPcgYmWiE4PZ
 uIGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764143490; x=1764748290;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HqbvtytwZhlAGHOU7hmLAcqlvwP/xTJGGdaDHqryDAY=;
 b=epyMfWrhiRU8wjlxOmBCvOj7aBPVvyf4TAiw71OtkDxYnKMBFreDtx481+oYPToSUT
 F3SeedXiLkMcLunTbNzcI9/CGeMUmpH0mQ9BmGZkVy69Z7gOtpAjKcmj60z2n7OYebuH
 jmnBrj/b0L94wJ0jlfj6Op10vaWRonNhBcvwoXTfPame0Rye1NLNBjKXDWV7kGR8/Tu3
 zz+v0W/zWdTQeYPoIe0BlX/eQvZ+TRglMpet13a2Ua4gh30b0D6P4ScOIC2APeCjUnl3
 bjmquWahv3pCP33b6o8Ps3WnbyZDJ857lmkzG+b5/KVCaEHMf2jE0Cb41ysSDriBO5md
 2uYg==
X-Gm-Message-State: AOJu0Ywse12Aorb5hsFwRkBVDbHAlm09kOSsgj078gkElcaRfxMDeLn3
 0ZuSY0/rXxAMdCjyD7FVh3LEE3n+gWM8etmh1qLoAhpFpuwalg34xwpTwJ/53WDmi4/sPx1svCv
 3q9N0u76UMg==
X-Gm-Gg: ASbGncvNANkPazigwihrzdI/kQPc+yoTc8HpqL/WnKNlK3Jpbqq90du1YDb3v7JPqWV
 rUR9zanhqvg6aaomUK/QiB9BMaY8tpEjGGPPQFxEw5xGyKuvXf3c2FNNvJT7EFyK2QAqYy4QExe
 zeI3JztZW4IfhD/uBQgzeCnmDWrg65sWTQ+UOEEvgD8LVmAfuwNN0/va4Tni/p3L6VBqveSfKxJ
 5t0SY16Q4qoYvUM2+veqaFQLJ7iGSn6+pyaS2Hy9Owi69dOFkA1+SJ9fUkYegvDFytzFb96E9Vz
 PhTIvppWuG0tx9lqyraEo1A5Gw+VCd4o7jwYJ7b+7ukC5oRbuAGSsHy0XTgg0UWpf+wZomn14y9
 ivXpVrgBTJezpu4XvMy9UgtD3d1y8RZbk66S/uqVe8uZOJ8KEZPLuYhBuVqPyTRj2uyl8DZOOG6
 wRZiFy3ACzNyV/nD6JPXuK4JYMjckTh8su6bOCIydwyjKDCh2j+PhJgQaKVQVT
X-Google-Smtp-Source: AGHT+IHpSR0NnJoOLu/JwAvtYSzeagSgVnGTII6FUzX/es2jtWdWjg6Wg9lcy8drKdyigjrAYbi4Wg==
X-Received: by 2002:a5d:5f88:0:b0:42b:3383:bcf4 with SMTP id
 ffacd0b85a97d-42cba63b5bfmr27111195f8f.1.1764143489728; 
 Tue, 25 Nov 2025 23:51:29 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fb919bsm38622783f8f.34.2025.11.25.23.51.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 25 Nov 2025 23:51:29 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH-for-11.0 v2 12/12] accel/tcg: Remove non-explicit endian
 cpu_ld/st*_data*() helpers
Date: Wed, 26 Nov 2025 08:50:03 +0100
Message-ID: <20251126075003.4826-13-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251126075003.4826-1-philmd@linaro.org>
References: <20251126075003.4826-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

All uses were converted to the explicit cpu_ld/st*_{be,le}_data*()
helpers, no need for the non-explicit versions anymore.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
FIXME: Still some PPC/MIPS uses
---
 include/accel/tcg/cpu-ldst.h | 46 ------------------------------------
 1 file changed, 46 deletions(-)

diff --git a/include/accel/tcg/cpu-ldst.h b/include/accel/tcg/cpu-ldst.h
index 0de7f5eaa6b..12dd38599a6 100644
--- a/include/accel/tcg/cpu-ldst.h
+++ b/include/accel/tcg/cpu-ldst.h
@@ -428,52 +428,6 @@ cpu_stq_le_data(CPUArchState *env, abi_ptr addr, uint64_t val)
     cpu_stq_le_data_ra(env, addr, val, 0);
 }
 
-#if TARGET_BIG_ENDIAN
-# define cpu_lduw_data        cpu_lduw_be_data
-# define cpu_ldsw_data        cpu_ldsw_be_data
-# define cpu_ldl_data         cpu_ldl_be_data
-# define cpu_ldq_data         cpu_ldq_be_data
-# define cpu_lduw_data_ra     cpu_lduw_be_data_ra
-# define cpu_ldsw_data_ra     cpu_ldsw_be_data_ra
-# define cpu_ldl_data_ra      cpu_ldl_be_data_ra
-# define cpu_ldq_data_ra      cpu_ldq_be_data_ra
-# define cpu_lduw_mmuidx_ra   cpu_lduw_be_mmuidx_ra
-# define cpu_ldsw_mmuidx_ra   cpu_ldsw_be_mmuidx_ra
-# define cpu_ldl_mmuidx_ra    cpu_ldl_be_mmuidx_ra
-# define cpu_ldq_mmuidx_ra    cpu_ldq_be_mmuidx_ra
-# define cpu_stw_data         cpu_stw_be_data
-# define cpu_stl_data         cpu_stl_be_data
-# define cpu_stq_data         cpu_stq_be_data
-# define cpu_stw_data_ra      cpu_stw_be_data_ra
-# define cpu_stl_data_ra      cpu_stl_be_data_ra
-# define cpu_stq_data_ra      cpu_stq_be_data_ra
-# define cpu_stw_mmuidx_ra    cpu_stw_be_mmuidx_ra
-# define cpu_stl_mmuidx_ra    cpu_stl_be_mmuidx_ra
-# define cpu_stq_mmuidx_ra    cpu_stq_be_mmuidx_ra
-#else
-# define cpu_lduw_data        cpu_lduw_le_data
-# define cpu_ldsw_data        cpu_ldsw_le_data
-# define cpu_ldl_data         cpu_ldl_le_data
-# define cpu_ldq_data         cpu_ldq_le_data
-# define cpu_lduw_data_ra     cpu_lduw_le_data_ra
-# define cpu_ldsw_data_ra     cpu_ldsw_le_data_ra
-# define cpu_ldl_data_ra      cpu_ldl_le_data_ra
-# define cpu_ldq_data_ra      cpu_ldq_le_data_ra
-# define cpu_lduw_mmuidx_ra   cpu_lduw_le_mmuidx_ra
-# define cpu_ldsw_mmuidx_ra   cpu_ldsw_le_mmuidx_ra
-# define cpu_ldl_mmuidx_ra    cpu_ldl_le_mmuidx_ra
-# define cpu_ldq_mmuidx_ra    cpu_ldq_le_mmuidx_ra
-# define cpu_stw_data         cpu_stw_le_data
-# define cpu_stl_data         cpu_stl_le_data
-# define cpu_stq_data         cpu_stq_le_data
-# define cpu_stw_data_ra      cpu_stw_le_data_ra
-# define cpu_stl_data_ra      cpu_stl_le_data_ra
-# define cpu_stq_data_ra      cpu_stq_le_data_ra
-# define cpu_stw_mmuidx_ra    cpu_stw_le_mmuidx_ra
-# define cpu_stl_mmuidx_ra    cpu_stl_le_mmuidx_ra
-# define cpu_stq_mmuidx_ra    cpu_stq_le_mmuidx_ra
-#endif
-
 static inline uint32_t cpu_ldub_code(CPUArchState *env, abi_ptr addr)
 {
     CPUState *cs = env_cpu(env);
-- 
2.51.0


