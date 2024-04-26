Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59BDAC04FFE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 19:44:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0RUN-0002pV-Td; Fri, 26 Apr 2024 15:44:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0RTk-0001cD-UT
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 15:43:29 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0RTg-000354-Gn
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 15:43:28 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a5872b74c44so296808166b.3
 for <qemu-devel@nongnu.org>; Fri, 26 Apr 2024 12:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714160595; x=1714765395; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zCHikf9aNyk3WhcB018t8YJhGkQVI+bzenRpRAy8E10=;
 b=ymlZhQlQ1VzKm64oGfteRO29nS8XfmuSYGxOpxtp75eg5VF6T0AXaKCFqrYEYnalCN
 w5fnhEJAfmhJ5FLLmyu0YSFBkEenyCKXOEY71UVl0z2jT2kD7d2PmTgkc1KwILTHfVse
 tvz0BkeuXjdPKqIxNJcK/5BIbX0LDMM8BT/OeihwEjz0Roh5+npNOLTipXTozn0GOC+x
 gAES0+cAdICfSTPg537+z9gOoWaiuImQpFebi6Yq0WIPJg0OMgSBZxAOvqprx7UKwkLT
 dyfkuWZxsY6Q9xXuhlgk/2rfXRqPZiR0jokMgpvdA47M37PRKrNS2jmtlyjucDBdsW6z
 /BWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714160595; x=1714765395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zCHikf9aNyk3WhcB018t8YJhGkQVI+bzenRpRAy8E10=;
 b=u6uy5Cu93TR59LMQKN9kGoyj/dixWqDHqvxdDBNEK0g9P0r5SbdM3GwRdbEpNMwpS0
 bRm7WLBwTcz6fJs/XWpeYME94onLdPpJSHvJAyOSVXFXrnyog8lg4Z2KIemVpzktxY08
 hxTIHfhWsg8FjhXNvWGK8wRt3ObC+DO4fky1AhY+1GqTqx+50mv29zdEiVetkrcVWlw+
 jeh17bRPDJEAx3+PLuGAcDynPef9izx9mbqH7VqI0exRAgtfKW9onUB90bqU7AVpKNL3
 V/D3YBpnktxf2Cnh/WSsqYW+qCxfgu9oU8doI++zCaN29oUCkyQqfTnT+HbtakAsQ/JU
 8IPQ==
X-Gm-Message-State: AOJu0YwEyZK44vFEQIfAaC0hC6o4/npir/hUYdjo2niz7KA9o0u5GMpB
 itaeEMI7OkOxGmjch4klt1OQ6FPUyQX2SI90XBJUbPE3Rq9M+WkFB0ntYQuJcmRnvHIBwyJ5N4s
 vohQ=
X-Google-Smtp-Source: AGHT+IHAZlHFUggQbgP5LoyQ+dR4w5wTimxNZNrshdiG5IUEa5nAABnp/2nVbkRYKWVJWzJOKgtGqw==
X-Received: by 2002:a17:907:97c8:b0:a58:7857:fee7 with SMTP id
 js8-20020a17090797c800b00a587857fee7mr3023416ejc.68.1714160595167; 
 Fri, 26 Apr 2024 12:43:15 -0700 (PDT)
Received: from m1x-phil.lan (aul93-h02-176-184-11-147.dsl.sta.abo.bbox.fr.
 [176.184.11.147]) by smtp.gmail.com with ESMTPSA id
 i13-20020a170906090d00b00a588dab605dsm3666771ejd.88.2024.04.26.12.43.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 26 Apr 2024 12:43:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: [PULL 12/38] target/ppc/excp_helper: Avoid 'abi_ptr' in system
 emulation
Date: Fri, 26 Apr 2024 21:41:32 +0200
Message-ID: <20240426194200.43723-13-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240426194200.43723-1-philmd@linaro.org>
References: <20240426194200.43723-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
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

'abi_ptr' is a user specific type. The system emulation
equivalent is 'target_ulong'. Use it in ppc_ldl_code()
to emphasis this is not an user emulation function.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20231211212003.21686-18-philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/excp_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 674c05a2ce..0712098cf7 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -142,7 +142,7 @@ static inline bool insn_need_byteswap(CPUArchState *env)
     return !!(env->msr & ((target_ulong)1 << MSR_LE));
 }
 
-static uint32_t ppc_ldl_code(CPUArchState *env, abi_ptr addr)
+static uint32_t ppc_ldl_code(CPUArchState *env, target_ulong addr)
 {
     uint32_t insn = cpu_ldl_code(env, addr);
 
-- 
2.41.0


