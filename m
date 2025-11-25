Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70422D0E6C3
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 10:56:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNqiS-0005g8-81; Tue, 25 Nov 2025 05:56:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNqiQ-0005Qf-8Z
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 05:56:10 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNqiN-0001tr-Oe
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 05:56:09 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-42b32900c8bso3088419f8f.0
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 02:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764068165; x=1764672965; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HqbvtytwZhlAGHOU7hmLAcqlvwP/xTJGGdaDHqryDAY=;
 b=S6G/zLYIFutIk2e3jnEXqKV1445hTeQGV7Cxo3h2x3ni39CWPyPCMTjHPFb/IiLQf8
 wmSoZfCZvQj6NbbtllCKliPIzUlxOTqFxXyOrTFVwQj4hE1/M7+IZzBAInWa/XPV0/Qc
 C6rN8THVZSHEVV4sV8iHAe1Pgf11o8kIN5FOxVcWr6OLo9pk5knG0/j19LfW7MP/F0Uh
 y0xSwZVNbA1vsYn9XUlhRqBt9blT5i9/TO/u+DtcW/pmnw03A84CY+J+5DhPKQ2Ur5MF
 5gIZXw5XWl1UAGjvk9LR1ykvcaeWUbFjbGhRMOXrLj6XUj4CnCD2Mki0hBQI1k1BzFhm
 bnlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764068165; x=1764672965;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HqbvtytwZhlAGHOU7hmLAcqlvwP/xTJGGdaDHqryDAY=;
 b=EhZ9Gguu8FkzNrZYvmw4rh7aWsvYVPkkSzTw6GL1n9FkCquXSPX/nel+i69tDHr1uN
 /1pkRXaVYQBc38IPHEc+Uot5FLGyg0PkHlldxGgXjusVoKyFuYuttbSj4jNmrTclJyON
 nUkxJCsvA0XJJUnwvsIYqxolmifb8WiTXYLYAGmvo9OrwZuzaInxnqrYhkxq6VQ47ZXA
 dJ+aOT/63KpsXP9jpDvwmUjyn0AvN9ElD+PKHf7HG1n9kxbRgQyUIPB9ciqwZ5y+TG8I
 6lZCST55JXA2OHiLQhcGiEKbXHYAwv/JqCX1/AF4nyKeJbVTzD/HjRYkUTes58D+9FhF
 5hyg==
X-Gm-Message-State: AOJu0Ywg7by/sZNdOwiU6RRSIvl4UFaCtyJE6yGQ2bg2C3q33kKHmOoZ
 BHR7njEBEPQyoDyndMafazfvTLgBnOLUskYTkWRKjb9p9mqLaNxtWgFwH/94VOCFLnOuq6+9tZ1
 tzeq4zcH62w==
X-Gm-Gg: ASbGnctUJdnctd0N7EgjZR6W1RvQMCd7zUUJO3Gs5XtxIKAc63Ua/To1eYfAgOYbnmL
 zZJOXDkuQAhE9J0zmbWjPYQcYlfda8o6Aa9KetcD0mP5W+7hfPISMmQKQyscmYnYthi/tTuPO8+
 4BvOhtZ5vtxvL6mkJsREMHQUkCicOYlS45u+04r0bNyP4Ffod+JFzr4zDoWOVwvwNmIjUI5T0HA
 VGUgnWQwYTcq5W2oWniTXmuDaXaQcy1LtBiPi6dn25iVRjPMtS0QddRLm1kpANC32kb1asmGzYj
 70/aBOOb4wZMSMvRdoMUiyvyOGBHqu0lC2v0+vS4PA6LdRJvCBWq0L4Jyfb2eDGX0nffSn6XTJp
 ujtP1FufEe8qvLJjqBnQHM4+67ADEfj0i3N8ReuhuNd3TK4cBYguMLlNyRi3D7FNr4LroMoD20Q
 mhJ0uf/yz6KAXhGTmMIzE7hFGNDaBd4MrYGjXTQXosJsafdQ3WTXSWMMT4scHq
X-Google-Smtp-Source: AGHT+IEi5lbB43t1hen5gtYZrTis4D86qp8KTt2V55htTR5tlKY+FOKUCP4/Mo4dCjJthpO9zgxAoA==
X-Received: by 2002:a05:6000:1a8e:b0:429:cf88:f7ac with SMTP id
 ffacd0b85a97d-42cc1d35d6dmr15171928f8f.44.1764068165307; 
 Tue, 25 Nov 2025 02:56:05 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fb8e62sm33608840f8f.35.2025.11.25.02.56.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 25 Nov 2025 02:56:04 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH-for-11.0 12/12] accel/tcg: Remove non-explicit endian
 cpu_ld/st*_data*() helpers
Date: Tue, 25 Nov 2025 11:54:33 +0100
Message-ID: <20251125105434.92355-13-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251125105434.92355-1-philmd@linaro.org>
References: <20251125105434.92355-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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


