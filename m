Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CAD2E92FF7
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 22:56:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaM9c-0001qv-4u; Mon, 29 Dec 2025 17:55:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vaM9R-0001pC-Gn
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 17:55:48 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vaM9Q-0001D6-4N
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 17:55:45 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-430fbb6012bso7901609f8f.1
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 14:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767048942; x=1767653742; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lGYkc1H9/lsxRR3MoTUEzNJDH2iC1/n24u+6XvBjahc=;
 b=alg/uHCxHIBX0jQTB+rPe+ZHk63wpsuw6e04YKCNJ/WzW7Ymt3oqAqhkCVxev1dV/u
 BIlhGltDqBR+/gWdIgKgfAfkGlunz3rBjd+qR0W4enHtvmWzLegGg8vGoa353cJwyPm5
 sQYQ9sidEkNSOzDA6LrCdG2/EOMFr7dPF/EPRmD2Xvrzr8ZugoNFvdZv9IrudXMs7XPE
 gqJwtvz0uyRYiNnG4o5dwvZeVWWBgHaQq+SxeVVryKYUCmkpHrNEBeTEdyPPwcIQh71w
 v7yl2Os0wVvcosNXaZNkqcJ1DEKlu2GkRQhA73ygLsvMrbR/ZPz59BnvmfNBUAwomCZR
 fUnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767048942; x=1767653742;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lGYkc1H9/lsxRR3MoTUEzNJDH2iC1/n24u+6XvBjahc=;
 b=c24Ax4qrUNHTgXhyh4xYqW8xOgUcwSFvEaIJzc4N9eJt6jGugjxjKIXI+uMcSSOO+s
 Dtmvwi6Uu5L/lPfguXP00chBh35Qd/t82SVuvOo4l9nWbOjpGyxQPAx1/XOtG6LqBy9D
 w8SH4kmJ5WXxl2qzrFzRY8f6WUw0G/rNn2gZbv9mZgIy9KHLRSck78h/FlhwBHtMnnZf
 0iYAMbrQXfzeLpxOUjFNJ/M90nB/7SfZSV0Ofk7wu2ku/3eZSZLmsde2CRLvpnry/fGr
 RXO3D9RH+1rdtsfTSh62GXWtv/V2l+/JXgE0V8hP0ddpaQcMvICDqxYFX9ZdJoL76Z+O
 MJlw==
X-Gm-Message-State: AOJu0YxdA2kmqIQgWMEe3rBVi72CxdfIQGGH4V5ac4fE3M41thotBMZi
 U/FQz5qWRPUDigwCPfKJgLkGlzxF+GTA0DZ+XBrH4wxsuSrvN3fb7IzibxEZH4ePRTy54J19emx
 stmHMCeg=
X-Gm-Gg: AY/fxX7h1XVv7Vpz7jrZheF3XqYTLizK0VFqQtEhtdvrjJU3+GcNGr0YlEEw8kcIDRJ
 fcP+NksQunZ8ZzBYr93yO5RKE3pz0ndFJ64viJNthGvVlasq5JGnYsUc+KHGe2mre3rC03c5oja
 qOj6hhk5gK9EubzGM2EppoMfj8i6F2c5Rmu//YU8bsE1N57pkQeyEuj0WgDT0zAQV2P898+KdW7
 S52am9hi9v1l/TlkTPmrS2FC2GcrxKOrVHccCfxEYCOANtaRTcPnC75gcKn0lYuRwfiSzGN9XdD
 dw7E5uKLSEVWZewTOMMuFz574/tuosT/GJYQOc3LY9V2O+EI8sOE//T0IeKGYYZ48XT3A1G/ZMR
 rnNK2EuAGsFXP1bvNEmv/4TP+WCE9Q5PeNFB1irm/28GUQrFvMbEbKRehmeXBxu+0OzDPqelgLS
 oJH7UivxBDHrkTktJc4djFIucYY2F0IxGVju1+AqOE8/q7tmzDlL3nJdiMBQOc
X-Google-Smtp-Source: AGHT+IGBjUeon2Q3CDufdLqBpow/V73ALV0slnC9Xt5iuA4ljZQjy4D3fohhhjIaGebb/8pEno51oQ==
X-Received: by 2002:a05:6000:4202:b0:430:f5ed:83fc with SMTP id
 ffacd0b85a97d-4324e4c7127mr43216838f8f.11.1767048942306; 
 Mon, 29 Dec 2025 14:55:42 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43264613923sm49491231f8f.26.2025.12.29.14.55.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Dec 2025 14:55:41 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Sven Schnelle <svens@stackframe.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Helge Deller <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 3/5] target/hppa: Use explicit big-endian LD/ST API
Date: Mon, 29 Dec 2025 23:55:15 +0100
Message-ID: <20251229225517.45078-4-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251229225517.45078-1-philmd@linaro.org>
References: <20251229225517.45078-1-philmd@linaro.org>
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

The HPPA architecture uses big endianness. Directly use
the big-endian LD/ST API.

Mechanical change using:

  $ end=be; \
    for acc in uw w l q tul; do \
      sed -i -e "s/ld${acc}_p(/ld${acc}_${end}_p(/" \
             -e "s/st${acc}_p(/st${acc}_${end}_p(/" \
        $(git grep -wlE '(ld|st)t?u?[wlq]_p' target/hppa/); \
    done

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/hppa/gdbstub.c    | 2 +-
 target/hppa/int_helper.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/hppa/gdbstub.c b/target/hppa/gdbstub.c
index 0c5e41410a0..4f016a0e61d 100644
--- a/target/hppa/gdbstub.c
+++ b/target/hppa/gdbstub.c
@@ -168,7 +168,7 @@ int hppa_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
         return 0;
     }
 
-    val = ldn_p(mem_buf, hppa_reg_size(env));
+    val = ldn_be_p(mem_buf, hppa_reg_size(env));
 
     switch (n) {
     case 0:
diff --git a/target/hppa/int_helper.c b/target/hppa/int_helper.c
index 4e4869285b5..d5a20cd549d 100644
--- a/target/hppa/int_helper.c
+++ b/target/hppa/int_helper.c
@@ -178,7 +178,7 @@ void hppa_cpu_do_interrupt(CPUState *cs)
                         break;
                     }
                 }
-                env->cr[CR_IIR] = ldl_phys(cs->as, paddr);
+                env->cr[CR_IIR] = ldl_be_phys(cs->as, paddr);
                 if (i == EXCP_ASSIST) {
                     /* stuff insn code into bits of FP exception register #1 */
                     env->fr[0] |= (env->cr[CR_IIR] & 0x03ffffff);
-- 
2.52.0


