Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5685C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 09:59:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEQvN-0000if-5L; Tue, 04 Jun 2024 05:57:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEQvM-0000aq-62
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 05:57:48 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEQvK-0002GC-Id
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 05:57:47 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-354f14bd80cso664836f8f.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 02:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717495064; x=1718099864; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Maqg614wB6IQJrQoZvf0lrAnLMpTuuWUZ3NE8tvuj7U=;
 b=SuOeEavAjG+sdjApvbmzVNN+BA1o6s+ZqildnXCUUgGwJA5UGE3sNbskVLIbMXaNcz
 BfEXHv8Far743LZ/viGzDGiLdju6QIaLBFYcecBZxFSTiN+qgFYAl0cz+BgPX4AbQZ/0
 MrzLqwhihHHUo3elpHfYDzueMycsI4S84yOvfMU15Bt6uZw68erdgVeH/5N0/YbrRNTi
 //r2uoE3p0C6SlP6ZCcOv25/5F41JxBw0oinEN0I++aXZB+sQzn2gZFgd8KXzdBcZXjw
 6XQbqRNqNmzpkV8BnplgsrPEoRG69tInLGUprYG8fzrgmjgEk1T//MJ+wnN//wzncSZb
 XT9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717495064; x=1718099864;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Maqg614wB6IQJrQoZvf0lrAnLMpTuuWUZ3NE8tvuj7U=;
 b=a9foHtwAT+xAoGp8J/cYCZo/IFkHiImvbxgBMpiAm/Zv2Sj63O710wblTbg0d2XqvQ
 i3tf0H1+hIQYm570W8Ni2ODmXMcl8kwpyx3yCUwo7XATVAbnfAVWGzygjE3SVVQLbe4Z
 fO7XieR6dRY0xCDVaWyruJ3YkrcinaVBG3ESWgjwkozz0qqoJfyDhYSCKWLburIRXvHs
 D+gAlZr+ncMndHNYJT1fLVB8nnPbBbvtv8AWRygCaKFG2VF9BzoxDBQMWsiFKVDUFFI0
 tLhwb4RBkSDgMrFhW/yn77FFUWxVZh8DuG8GsmSjxKEBWlNLhyOopJyNqp7J5GiAlwEA
 snag==
X-Gm-Message-State: AOJu0YzfGjPosnQbjHzCdxw4/e/CksER0wmX8EfDViW4Yz/2hyEaAHFK
 pOqpb3C1y7R0FmmgQjNQI8UaFYQMdafgZ6JYpvs6eFVqfxjugy8SEFwnQupauTnQo2+YhE4ocBz
 Q
X-Google-Smtp-Source: AGHT+IFzseSKmBMsrErO0w7gvhlDM7DV7/ZOnmum0sFQowJRB5MOtgh6TIfpudOka8cP2kJpPxhm8Q==
X-Received: by 2002:adf:e2c2:0:b0:357:ff92:ab06 with SMTP id
 ffacd0b85a97d-35e0f25b2e3mr8934642f8f.2.1717495064467; 
 Tue, 04 Jun 2024 02:57:44 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.159.34])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd04c0f57sm11125532f8f.12.2024.06.04.02.57.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Jun 2024 02:57:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 17/32] cpu-target: don't set cpu->thread_id to bogus value
Date: Tue,  4 Jun 2024 11:55:53 +0200
Message-ID: <20240604095609.12285-18-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240604095609.12285-1-philmd@linaro.org>
References: <20240604095609.12285-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Alex Bennée <alex.bennee@linaro.org>

The thread_id isn't valid until the threads are created. There is no
point setting it here. The only thing that cares about the thread_id
is qmp_query_cpus_fast.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20240530194250.1801701-4-alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 cpu-target.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/cpu-target.c b/cpu-target.c
index 5af120e8aa..499facf774 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -241,7 +241,6 @@ void cpu_exec_initfn(CPUState *cpu)
     cpu->num_ases = 0;
 
 #ifndef CONFIG_USER_ONLY
-    cpu->thread_id = qemu_get_thread_id();
     cpu->memory = get_system_memory();
     object_ref(OBJECT(cpu->memory));
 #endif
-- 
2.41.0


