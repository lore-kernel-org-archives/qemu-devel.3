Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 766D0C36002
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Mar 2025 22:51:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twU9o-0003qu-58; Sun, 23 Mar 2025 18:51:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twU9m-0003qh-K6
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 18:51:02 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twU9l-0007EO-30
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 18:51:02 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-39141ffa9fcso3277188f8f.0
 for <qemu-devel@nongnu.org>; Sun, 23 Mar 2025 15:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742770259; x=1743375059; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2ONHD5d7pAXIaEH45P/RlmSMtYEst+nDWdheP9MRJb4=;
 b=bHerPZeRvZbS6/1ml7IZckksN5V92FsNnyLTh8FpZY449Ay5WU7yF9wKnZBwd9MYLc
 4bf7fKrZwfvo4AT1zESGpD2GYBr3U687svh5USRYowCZAgR5j3H35YYCtqnYJUmif5pn
 kNjUbEp4hdXiHpia3qdGroMiuWv0vB8P2f0w6oy5eo/pmsq7HxPBl47ws41q1R8KqYM4
 aPoFM76rB0kb+JdytJtY6zO+AmaRe2FZ0QbYClP4zByZ7byn4wmLbuJi8KZz1feFycb/
 K0PzKTOrDtX0DFdtS1sFsfEprZN6CCJls/82neCTlemTDp8AHkhigDGsWieq+0KkcrGa
 KIRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742770259; x=1743375059;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2ONHD5d7pAXIaEH45P/RlmSMtYEst+nDWdheP9MRJb4=;
 b=IhbGN22uu1ytHSxNn1u0jYjvgZ2+Y7EyNHoaIRrzJlISjdnuST2ebY63huwMbtH7eS
 6qBU8MD46l+jYwtUnEg2T8WNV0aK/voZpnxdO4P9DnNknub33XlM5bQ1CAPNiUsmxza+
 YGp2iLAfCUQbhSMy4rhZbwyNhz+sP+WvSAXEZOw0O8wMprYah/v9Sv3DHjQoCXNMDIcU
 RYIRfBF2MPBgVyVgsQge4SXX3iE2ooafwjYTCo0Qtc5nsS0j1oeR2B8gZDzToT19FL4j
 aIMRftBArUd1drn6AmRNKBwRcCKtqXhHIyZ5WYCSdUDrGPcvZbpQal9ixE0+e8YlDbwB
 7E/g==
X-Gm-Message-State: AOJu0Yzpt8vyMX8AbAvqos1YymwgYkv4aPXNVotaOsvNiV7vGkHYqQJF
 x/Hi9vXuR++VyXH5bBGwdJZkhodu4gma318Q7V+x445ecqxEzagcx4g1diL1Ngj1mTc9MASjFvB
 E
X-Gm-Gg: ASbGncvCiYbWr3EEzH3Gjra20HeDcpVg2+By0+y+EQmWCbC67ihWkTBoraZgwyqRKWr
 3gKXRslOdxKSvC8V5uWE8yllX9W18E3LmTmirRb3ZA8jXcZb5kQb3s/YzlNsEBGuWTaCTd7lp/0
 N8sy3k+JS2Le6JqDQ045uW4czGQ6lz/Ds4ISQzdZ/8wfhZAvnZ/FBo8ak4f2C3i/AL2J3TIJ04Y
 g46exVbeTh6Yd63zzc9IFAwUzTB42QalSrAA5Q6xgU+lNNyiWsulPb2VGSVMJ5xMIvLvBCph/fF
 7sV2CR6WsRBsvDu6KvSdJorJBVe6qgHS5XAyFZIJMpvom5UEM55nyZaruGaUO4wicYBxQaJDaTc
 gXVegLoUFA3/B3xNFZxnpvzYC
X-Google-Smtp-Source: AGHT+IG3KHvGSRFsYNuAs2SQQv6JbQY2xOid3/f3amHs7sT6/jnouF5HMwMfYIsL8tbr7m8odZhfoA==
X-Received: by 2002:a5d:64e7:0:b0:391:13ef:1af8 with SMTP id
 ffacd0b85a97d-3997f9423admr9035105f8f.54.1742770259316; 
 Sun, 23 Mar 2025 15:50:59 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d4fd277c9sm102906645e9.22.2025.03.23.15.50.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 23 Mar 2025 15:50:58 -0700 (PDT)
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
Subject: [PATCH-for-10.1 2/3] target/sparc: Inline qemu_get_betl() and
 qemu_put_betl()
Date: Sun, 23 Mar 2025 23:50:46 +0100
Message-ID: <20250323225047.35419-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250323225047.35419-1-philmd@linaro.org>
References: <20250323225047.35419-1-philmd@linaro.org>
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

We only use qemu_get_betl() and qemu_put_betl() once in
the whole code base. Inline them (checking TARGET_SPARC64
instead of TARGET_LONG_BITS == 64) so we can remove them
later as unused.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sparc/machine.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/target/sparc/machine.c b/target/sparc/machine.c
index 222e5709c55..cc58812781b 100644
--- a/target/sparc/machine.c
+++ b/target/sparc/machine.c
@@ -87,7 +87,13 @@ static int get_fsr(QEMUFile *f, void *opaque, size_t size,
                    const VMStateField *field)
 {
     SPARCCPU *cpu = opaque;
-    target_ulong val = qemu_get_betl(f);
+    target_ulong val;
+
+#ifdef TARGET_SPARC64
+    val = qemu_get_be64(f);
+#else
+    val = qemu_get_be32(f);
+#endif
 
     cpu_put_fsr(&cpu->env, val);
     return 0;
@@ -99,7 +105,11 @@ static int put_fsr(QEMUFile *f, void *opaque, size_t size,
     SPARCCPU *cpu = opaque;
     target_ulong val = cpu_get_fsr(&cpu->env);
 
-    qemu_put_betl(f, val);
+#ifdef TARGET_SPARC64
+    qemu_put_be64(f, val);
+#else
+    qemu_put_be32(f, val);
+#endif
     return 0;
 }
 
-- 
2.47.1


