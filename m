Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B780DCF8840
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 16:42:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swlKB-0008BP-2h; Fri, 04 Oct 2024 12:38:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swlIV-0002Dq-MA
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:36:56 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swlIT-0006iU-2X
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:36:55 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2fad100dd9fso36948121fa.3
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 09:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728059802; x=1728664602; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0KcWyV0l74Ltt00k0SuMNwX9PI5KG07PSsGD0S0u9KA=;
 b=gf2/F9QbraxPaiXc1wQaBI1zwl4PbxhGiq4sIt+XqH4xA8fGrezjxjAL7zC3f9Ai+k
 psmiODmZV3aCRRIZW7MLfwukv/bHeqID4P8EHi3ErHb1xMSL3BIcdmBZIxx8Hp7sDQ2/
 /19VjHW0RTYXdyUujLHGNYI9lKzuDhgtsW2tXku5d0j/DNCfMkyrUPnWKq01o06mjwD8
 cic9kir4yO9o5oKr3dQ82zINlWZ1pxp0m6JGIWqaNxywQ67eOZNgjFCbhCK2fwJN6F0F
 X22sp2OnjkNV2WKi2YpCswQdAP7jkgiVf8Qwbv1Eh6r7zy/8dIsEhY4AYMDRWFX4r2f1
 y+xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728059802; x=1728664602;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0KcWyV0l74Ltt00k0SuMNwX9PI5KG07PSsGD0S0u9KA=;
 b=WnjRdPngoJ3L/es/taMzPUNI8L8NW0QvSo51DUjejIbJMzQCwi7mZoO/iypUbV0Hs9
 WyPOESc4S2wV0sBAHnWfFbEpppqkuA4aV3pOjZqOhOc3UJUXq95utrupQXS5onIb1oOL
 qclbef/4UvAYFllnBuRwZWFpKfQ5+/4oinKs7xDYaJhP+eIUOBuFyGYcrkXVx6g0s2NG
 /e9SPE0I7o88cWGtNDtj25l8jDoUSUxBZWzj4bFt8Tok25uRvTHWDDdDTDl7a3GVnSGy
 QOfu00rV0dadBJGTTAdaD62gRxPix0T26xSGhGYD6xbeNJNJqWi+AYTuaBhyvR+im33Z
 JhIQ==
X-Gm-Message-State: AOJu0YzjBXhUe907eCmPlL64WFHHgkvWVN5wNcvIhh1Y2rAx736UZ+hj
 /a03jSF+q1f+/0vtXScyEY5feINuA/xujVc/A05CM+zYoUXzBB7ZjeVaamEf+bxoR50CFo+b9qD
 IZk3wuQ==
X-Google-Smtp-Source: AGHT+IF8A/8sWLV5TdRzxw5qh0XNl7VBbsvFLTyOZ6rsSJNMzL1DNDdqCMQUu/CA7u+x5BcevOfwMQ==
X-Received: by 2002:a05:651c:1545:b0:2f7:712d:d08 with SMTP id
 38308e7fff4ca-2faf3c2978amr28480481fa.23.1728059802212; 
 Fri, 04 Oct 2024 09:36:42 -0700 (PDT)
Received: from localhost.localdomain ([91.223.100.150])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2faf9b248b3sm208721fa.75.2024.10.04.09.36.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 04 Oct 2024 09:36:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 24/25] target/openrisc: Use explicit big-endian LD/ST API
Date: Fri,  4 Oct 2024 13:30:40 -0300
Message-ID: <20241004163042.85922-25-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241004163042.85922-1-philmd@linaro.org>
References: <20241004163042.85922-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x231.google.com
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

The OpenRISC architecture uses big endianness. Directly use
the big-endian LD/ST API.

Mechanical change using:

  $ end=be; \
    for acc in uw w l q tul; do \
      sed -i -e "s/ld${acc}_p(/ld${acc}_${end}_p(/" \
             -e "s/st${acc}_p(/st${acc}_${end}_p(/" \
        $(git grep -wlE '(ld|st)t?u?[wlq]_p' target/openrisc/); \
    done

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/openrisc/gdbstub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/openrisc/gdbstub.c b/target/openrisc/gdbstub.c
index c2a77d5d4d5..11f5c50423b 100644
--- a/target/openrisc/gdbstub.c
+++ b/target/openrisc/gdbstub.c
@@ -55,7 +55,7 @@ int openrisc_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
         return 0;
     }
 
-    tmp = ldl_p(mem_buf);
+    tmp = ldl_be_p(mem_buf);
 
     if (n < 32) {
         cpu_set_gpr(env, n, tmp);
-- 
2.45.2


