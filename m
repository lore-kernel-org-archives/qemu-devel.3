Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A7B6C28B30
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Mar 2025 22:51:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twU9k-0003qG-N2; Sun, 23 Mar 2025 18:51:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twU9h-0003pv-US
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 18:50:57 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twU9g-0007Dz-8t
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 18:50:57 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3913d129c1aso2660143f8f.0
 for <qemu-devel@nongnu.org>; Sun, 23 Mar 2025 15:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742770254; x=1743375054; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cnaIE/coD7iehBI3M+vr/MPS6inHzuGVqj/KxNr6j7E=;
 b=Bc/IwGpfRUSZ81FA+sCWB0EnvEMuK+NWcB3c2+pWgbyEbNaKd2ysHzEaKyQzF3bfRF
 H7h447c5YqGPHVJLVPCpc2L0wZI5/Jgt05v3aNqF/RRPqIwGC9TgkbaXjolDEsiFbQpD
 UZldXoFPZgs3u+eJ9tLnNWrG2YRBqKwL2ZRmGz9L37Gvr3yNRsl3XSF9it8z+CRRWqBW
 WSVTigJoXIsk8cGdG5iJyWuNwPxQmLIdry4xYuI6JfRRcVQjjxGS3RJuOWQKvEh9wqh7
 03E2Y2+k4DdyeyRCAMhJfVGuj026Ci8GLxvjSE4qYj1ZYSkIcrOh6i7RITZYVN6wuPV1
 /MrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742770254; x=1743375054;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cnaIE/coD7iehBI3M+vr/MPS6inHzuGVqj/KxNr6j7E=;
 b=MB9cko3/IAEZUCG87zeFXXXQBCMuSwcSTP3KeVf+Bjj9NRfmf8nV3USLlpynJNY2W1
 zmEBF4hCLHohaHa/r+bBhBs+T8Tgf+SX8mWDPm9vFx1oQ66PtsjKubpBDNJAEzDVBdUy
 rvcGKVSLmgXTqay0lfrfvIIqpnaTOLf1fpvOMcKgTiKvMB0h3Jjw/lgFtFBl14FZ+lvr
 +r72wQ7SPR+oywrmknef42cwHnL8+xSZgntYc//DJxbXSU3Wsln8ovsPWmvATP/M/Ut/
 WIUjw5toxYHYXDnIzl6r/9QDedEJJ3yONbTYo8gDihVdkIZ7NxUaqoJ2Ns9qRVt9pv0h
 UJFw==
X-Gm-Message-State: AOJu0YxSknXB2ZPsG63QJdyZ+td9QjhxI61IwhvoUbPtpVTtdNeOVxCq
 cov5TbdNznE39QQ6msxOivFZuEwOBxH5tGYAsvg/zEekH/uRzyCl1rMbpluTNh3Jadu15a4Wt6Y
 D
X-Gm-Gg: ASbGncvhZqCHBz/GWSsPjp0QSZIXO553JHr76uSizzdApm7eFVvTwy4K7yul64xYZeK
 bxw8sV4wD1juREQTuuK5kSz1T0kV8L4J1zy03guKRbpp/06i17TmvjyAXlUV//o1mODUA/JA8PN
 UIxXbVEUDsiQS6iZULZ8GnkQJVg4a8Blk5IMLIjtMl+bL3WUCuBIicf9c3zKyEVs8pYuu1RZEF1
 ECgVThRebGqDsEBdy1PXNlw3yGcKShfJ+2/MlWZIDUS0XB6CMtoBrxJVQt9PaNaRK18w/XUd5Y9
 P+m4pjkFru3aqoqz4K0tb7I07u52Se6tNe0VLnIH860s3vKTb9QaRhsUlQpLvolGeu+m6xBY3M6
 g4cy+L6U8EKYFPF2c8v4YmXt9
X-Google-Smtp-Source: AGHT+IHJlAqx46cncW6TLKAt9HPyfMpIfVqSPWFtv4vnUMDmU53hBdSdswSfWDh+InrYpOKDeC+KLA==
X-Received: by 2002:a05:6000:188e:b0:390:dec3:2780 with SMTP id
 ffacd0b85a97d-3997f93c60fmr8091542f8f.24.1742770253834; 
 Sun, 23 Mar 2025 15:50:53 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9b5193sm9154958f8f.55.2025.03.23.15.50.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 23 Mar 2025 15:50:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>, Peter Xu <peterx@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Fabiano Rosas <farosas@suse.de>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 1/3] target/mips: Inline qemu_get_betls() and
 qemu_put_betls()
Date: Sun, 23 Mar 2025 23:50:45 +0100
Message-ID: <20250323225047.35419-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250323225047.35419-1-philmd@linaro.org>
References: <20250323225047.35419-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

We only use qemu_get_betls() and qemu_put_betls() once in
the whole code base. Inline them (checking TARGET_MIPS64
instead of TARGET_LONG_BITS == 64) so we can remove them
later as unused.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/system/machine.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/target/mips/system/machine.c b/target/mips/system/machine.c
index 8af11fd896b..c4c92a9a1ca 100644
--- a/target/mips/system/machine.c
+++ b/target/mips/system/machine.c
@@ -139,7 +139,11 @@ static int get_tlb(QEMUFile *f, void *pv, size_t size,
     r4k_tlb_t *v = pv;
     uint16_t flags;
 
-    qemu_get_betls(f, &v->VPN);
+#ifdef TARGET_MIPS64
+    qemu_get_be64s(f, &v->VPN);
+#else
+    qemu_get_be32s(f, &v->VPN);
+#endif
     qemu_get_be32s(f, &v->PageMask);
     qemu_get_be16s(f, &v->ASID);
     qemu_get_be32s(f, &v->MMID);
@@ -182,7 +186,11 @@ static int put_tlb(QEMUFile *f, void *pv, size_t size,
                       (v->D0 << 1) |
                       (v->D1 << 0));
 
-    qemu_put_betls(f, &v->VPN);
+#ifdef TARGET_MIPS64
+    qemu_put_be64s(f, &v->VPN);
+#else
+    qemu_put_be32s(f, &v->VPN);
+#endif
     qemu_put_be32s(f, &v->PageMask);
     qemu_put_be16s(f, &asid);
     qemu_put_be32s(f, &mmid);
-- 
2.47.1


