Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A1BC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 19:29:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxXRJ-0003Ui-C6; Thu, 18 Apr 2024 15:28:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxXPJ-0008JO-Sw
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 15:26:59 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxXPH-0007Xh-57
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 15:26:52 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a52223e004dso121561966b.2
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 12:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713468408; x=1714073208; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KYZzt8h+xfLtt/f9EJkGkN8nzUXLIiHe8tAqM2sJg8A=;
 b=AkYNy8cZkrIeC2UlaNyVYL+Dl8CmRsdJxbOf0Q5Ja1NxpWPTEkYuiKXG8fK/Y1Exoa
 5e30y84zHPVWK/RXqc3HZ7SUFrkbZtEPIh5CxObnd51HaSdvEzbSmhSnp7ONtRsoIUZs
 Zy0tR+inQKdLuFafn6WVW8P8jRpjihOX8SYJGj/TKrH8obeaNiQXGdZ3Gs0XkuWB8zwc
 orthIHWxjlnsCUGGzSLgaNwMndfXyMslvlCtUvkxHYTJ8ijR1SGtAvfkamqIkpeDTMOE
 Hd42Lf6YK2QY7Kmq0hZ5X2h7EewqNBwQHzQ/1ZvHTqbqlDfueNPlShMhdeeRVmaFpKhD
 Y0bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713468408; x=1714073208;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KYZzt8h+xfLtt/f9EJkGkN8nzUXLIiHe8tAqM2sJg8A=;
 b=CLq5yL3sR8jwEOJZ1doB9ob1Ffkure3+yEAhhposOyH+bPHlv+rjlbeyE8s5+B8Cqz
 PE3uV9YQjNaQhv06wgpcWBB5uch7b+AG4R0kl8uGTSY2EhH/sZfzk/1NkOhAC2LHFd6+
 NCfdTeNbk06JRIFe2+/SgAnlfe/nGkEbF+AfA/OSEE/tYHIZ8qSB96TiU7fBc/FPfac5
 G2qhTu9EGb5rHon+e8w4GWzZ0cDUD6RHbVdXQ+D2/RkyJlafCyb/dlyMrYZ3lkfqSzzc
 S2TTBmQfjvH+wPsH38hNYQiBknOV9lVEzDRGBjYA7I+wjGvpkbiA5yq6CAn0MVuX55ii
 E+aA==
X-Gm-Message-State: AOJu0YzPgueeqEUPIx1kzWBstYMijfb4jCfq20zLUqdKenzPCB3zsAVx
 Q188RehoyKAXf2A02HSmk02ZazSPsDAnQ+qsKALjhQuS2dGuVA1ZGW8sqZ2XS91t9QLNE2n0i36
 R
X-Google-Smtp-Source: AGHT+IGGSoNOPuz4j2WvvNGODM+4AEJcNNx0Thxm9FrMRXdYVHLgsSyAWa6ZsVOCsEkdfnN1Xh2oBQ==
X-Received: by 2002:a17:906:34da:b0:a52:2e08:207e with SMTP id
 h26-20020a17090634da00b00a522e08207emr43995ejb.77.1713468408261; 
 Thu, 18 Apr 2024 12:26:48 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.151.213])
 by smtp.gmail.com with ESMTPSA id
 u21-20020a1709064ad500b00a47423b4c33sm1255791ejt.128.2024.04.18.12.26.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Apr 2024 12:26:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PATCH 13/24] target/sparc: Replace abi_ulong by uint32_t for
 TARGET_ABI32
Date: Thu, 18 Apr 2024 21:25:12 +0200
Message-ID: <20240418192525.97451-14-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240418192525.97451-1-philmd@linaro.org>
References: <20240418192525.97451-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
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

We have abi_ulong == uint32_t for the 32-bit ABI.
Use the generic type to avoid to depend on the
"exec/user/abitypes.h" header.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sparc/gdbstub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/sparc/gdbstub.c b/target/sparc/gdbstub.c
index 07ea81ab5f..ec0036e9ef 100644
--- a/target/sparc/gdbstub.c
+++ b/target/sparc/gdbstub.c
@@ -108,7 +108,7 @@ int sparc_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     SPARCCPU *cpu = SPARC_CPU(cs);
     CPUSPARCState *env = &cpu->env;
 #if defined(TARGET_ABI32)
-    abi_ulong tmp;
+    uint32_t tmp;
 
     tmp = ldl_p(mem_buf);
 #else
-- 
2.41.0


