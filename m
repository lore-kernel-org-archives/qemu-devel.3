Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF503E776C0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 16:10:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYRRZ-0007uh-CW; Wed, 24 Dec 2025 11:10:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRRP-0007lW-Pt
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:10:24 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRRO-0000jk-4X
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:10:23 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-47775fb6cb4so37476275e9.0
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 08:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766592620; x=1767197420; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EyzKowdGuD/HgDmhTw3SYmjOlYcXG3JMfcYyRHBygGw=;
 b=TGLwjUR2wx5pwVQSsWw2WunOlVU/Jt79FzQv1GYfxYSBa5A+zv8DATmeFhwzDA4K46
 mgo9g3XMDbqUsCt+vUS96oNRMuFDPkobZ1s9eOQlj/K596gICatk32XH/MRjh7suL16p
 S/FKKD222MKsvEIchi3OsDKJrwH9/KT2O0WhVkKhi2/GtKVF44mIsilGGAvK8ue/XxKx
 nUiWjT2Qc4Qb4ejWQlKn4Cd38bzCy8kp28Crq51MXMz+HRi4Kd8X6tNeuaTbX+M9vbqf
 tRy0DPpbgU6tY+hOJE2NCU7kD1Vhp92IRL+Vm1vkRcxOaDiqaPFY3rdTaP3A+vN0pZxh
 fbDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766592620; x=1767197420;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EyzKowdGuD/HgDmhTw3SYmjOlYcXG3JMfcYyRHBygGw=;
 b=wHLbeISqQaogKVj+SMiT49l6LLV22+GqzQw5VSPfrsJNmAy1E0tmE/pmn6AXlWI9sm
 IK9w+u3lVJeGABquTyPzK+moEKuT1l97/UTv8UsKqxbnGzRPBmtggBjYPFKP1y/pfceA
 FOuLhiEeuK/CVg6j2rOmpCj4tadTnuigPMaPsmABsJDfkLplkzQ+fhFDSU3nbTVq2j0J
 NdOLkTeiM+bURyLnAbz0vNjy4u4JKKOSZOz0cZcKQh9uEolRebeV1f6A2VFt75D+CntG
 huxdVB4iboBZpqFluJDUjf9h/UpDYIyuZQuF++xh1We/Qyhm/kGfrI9s1UXy04zr1g1P
 mDEw==
X-Gm-Message-State: AOJu0Yx3irwASYCC4TheEVGdFiSapZ/o1Eavc1HUMPUC30TZ3oefmkA6
 ZagYBEhAK7XC6n5oJmcxdg9vAaZqap8g7R80WWrXycebi30DQZLCp58yDBoiWj2KOMsnMoxmMl6
 KF/rSB0I=
X-Gm-Gg: AY/fxX6xAdR18WKccmmd5SnAAaPte8tdxz3lkNPiuwUfhmv/pRscEAURQc38khuFGYf
 3pYCfL8SUmjDsdKkzKW3p1Jir1JGKmNf/2Jc6MLS7+rSLAGggKTzihS6cnBxCiwlZnj/gW5pXi4
 Ve55NxAUCEXPmaeV1Fsw/NDT/Kl9TjfHb6Gvwr3Yd34upGTVLMt8FSdwdBzyltKA0J/mzSZD/XF
 PKIJANBtyO8rpi9AA86wrV5b+tehoe6a6HtbccVOQWqwFAEF3RkmqPRlX50nFt6jqB+xvA/t9uO
 a7ZREd5FR+iOKNzB4HloKwg1KlAXO0njrF5AzJBYaBErZC63qkxmQuJ5tPg93Ox/wNKiZ46gJoS
 UMf6xCo0sIbWDUQdztXpEocIYn6PZbjQ6aJSUieEtCJ3KYd7CRmNJXOymoKSm31TMR/pXKhGV1w
 PfJR6FtQDmo6G1L9QHgXmqgIx3e6wtSqDN4l52Wc0EpvebUnOOT9rwMYKiP9AkY5P0Gg==
X-Google-Smtp-Source: AGHT+IG2XegaIdHs6m3uEhQ8IqXmjjaIA6JoXYJFi7N/wqxHUnprc8ZVeJlDLF6l3SUZ+G3/MRdCkw==
X-Received: by 2002:a05:600c:3106:b0:47a:829a:ebb with SMTP id
 5b1f17b1804b1-47d1957b115mr179174215e9.19.1766592620142; 
 Wed, 24 Dec 2025 08:10:20 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4325b6bfe88sm26782192f8f.19.2025.12.24.08.10.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 08:10:19 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/4] configs/targets: Forbid HPPA to use legacy native
 endianness APIs
Date: Wed, 24 Dec 2025 17:09:42 +0100
Message-ID: <20251224160942.89386-5-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224160942.89386-1-philmd@linaro.org>
References: <20251224160942.89386-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

All HPPA-related binaries are buildable without a single use
of the legacy "native endian" API. Unset the transitional
TARGET_USE_LEGACY_NATIVE_ENDIAN_API definition to forbid
further uses of the legacy API.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 configs/targets/hppa-linux-user.mak | 1 +
 configs/targets/hppa-softmmu.mak    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/targets/hppa-linux-user.mak b/configs/targets/hppa-linux-user.mak
index 59190f63358..a0c7398d599 100644
--- a/configs/targets/hppa-linux-user.mak
+++ b/configs/targets/hppa-linux-user.mak
@@ -5,3 +5,4 @@ TARGET_SYSTBL=syscall.tbl
 TARGET_BIG_ENDIAN=y
 # Compromise to ease maintenance vs system mode
 TARGET_LONG_BITS=64
+TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/hppa-softmmu.mak b/configs/targets/hppa-softmmu.mak
index ea331107a08..003f9f46dcc 100644
--- a/configs/targets/hppa-softmmu.mak
+++ b/configs/targets/hppa-softmmu.mak
@@ -1,3 +1,4 @@
 TARGET_ARCH=hppa
 TARGET_BIG_ENDIAN=y
 TARGET_LONG_BITS=64
+TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
-- 
2.52.0


