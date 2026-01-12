Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0ADFCF45D5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 22:51:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfQjs-00040O-FB; Mon, 12 Jan 2026 17:50:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQjq-0003oW-4s
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:50:18 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQjo-0002qq-Cm
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:50:17 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4779cc419b2so65409125e9.3
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 14:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768258214; x=1768863014; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Lau280OYPr4LKCU1Qh/T1V/cxVbt3OgpTTw56BZGZ9w=;
 b=d8/lN1/s0o7TV1jGHKJIyF/MnUfPNlH1nVYEvuvv0dBvspCkiXpkXmejnVn7kstiAT
 WAKK83N4D1Sc76IVN6ZA56i8Ebf3QfxyF/6P8MzmMpmRl22IXLPnzwO8mBmj7mjw+Eb3
 UMjvr7NOK+fENJi/2HFmur5SclGh+6GmH0/0rDWufCEzhj9gezmObnGspHTL1RFl7Xwy
 7DIlbiZfTYUq14Hr76C93co0d7/ldPDThciiU+VnXslKDF0n7DJ7L2ZGrNEJy+Fj9NxR
 p/mKM7DdslHZPX1PDOScdw1l56mRu90j/+W9LEBk3PB9sMMY8cC9ywqmKQVuGeO2FrN0
 FACA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768258214; x=1768863014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Lau280OYPr4LKCU1Qh/T1V/cxVbt3OgpTTw56BZGZ9w=;
 b=u6kpKX8R6qP4FQIdBU7IlukjO0+0dVGOKwck2vdoHH4LJXFIOYdtWvS0tPlgBzqFEc
 y0aagvKLcGnjeAQ8N2KdWj2TxfC5FLDwUY+jK837AUPl5vB+8K2Tm/ZErjc+5cxPA+Zf
 DHF+qZPmWtBuNPExmPRsfSgNuKkNgY5yz8vAibn59j4AEwIQXUfbd/mS4xg5HeYmQymW
 P30NzAeeGg01c/SNW9hJ+rMiG5NyfB44e/uwmXWOaisEm8s1jYQ4Cz3FZp54y2mhd8cs
 K+ryvASpsE23ti8NsloFJMOir0tKNzSl0CHNlV/Bp67Ok0Pvpagj4JO7seZOU69P0TCW
 L4gQ==
X-Gm-Message-State: AOJu0YxGIVOw2XO7VJZjoKN90+fU3YyeBNpSx9ImJs/bqCFURt6TD4fD
 VGkGfhbsQDOhwOrs0zVpKiUWwk7MUO2ZpgthBeOPL0IHxrt5Fc4DeqBJUh7b4yAMTRbBRMdjHyv
 WxwGpWSc=
X-Gm-Gg: AY/fxX5Fo7vghgkNydX8gjAtt/SK5UW+VKmoiTWj4/quOJwx/cF8J0zYiE+Uwtl9y1Q
 B9ACDfcf+DdTSS3epKaepuxXMyJbSFv/a7IPXlFArroX+iTrpy9gRh+xd6lUh6EJfwrPBnyLeBx
 yt2r4vURBttNuX2zcOoA02bkIKOvl/qOXXFQV4HPpQxLvpI59pXiOsqI9QUyYejMXB1n/m3Mv4L
 bkG7sgKd8pBLOwJeHHQmijOAAOJ8TWwBLAT+L2gPdWNHpm7W9tYcQSep3mWQav7WIrnTdZSgrxR
 dRX3fo8l1pr8MPseRCAk7Y2ovPhvAeZQfgBKoig0V1f1Pzq1i23nO/mPAo9REn+8PunzH9AoMky
 8UlsTx4LiE3+y1G+SHvDkcQ++Xjk4J+O2x6HEGN9DV6hQpis8ci14xwAUYiaRCwz3BB1k+psuDz
 P8fj35zX62kekIDHDY3IxWw7HBpx0O/bjoXoow/gsWsbFYR/d6S/k3J4O0ZTjB8g3J6ANTH7E=
X-Google-Smtp-Source: AGHT+IE1EtxgzNovINOx/gaaNlDjyHklx9rzc1vueUXXzjZa67SQ+Nh9BarrGo/NBFS5DasNbns0QA==
X-Received: by 2002:a05:600c:8b43:b0:477:1bb6:17e5 with SMTP id
 5b1f17b1804b1-47d84b3983dmr241907905e9.30.1768258214423; 
 Mon, 12 Jan 2026 14:50:14 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47ec5d95edbsm159068975e9.3.2026.01.12.14.50.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Jan 2026 14:50:13 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/61] meson: Allow system binaries to not have target-specific
 units
Date: Mon, 12 Jan 2026 23:48:06 +0100
Message-ID: <20260112224857.42068-12-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112224857.42068-1-philmd@linaro.org>
References: <20260112224857.42068-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

As we are moving toward a single binary, targets might end
without any target-specific objects (all objects being in
the 'common' source set). Allow this by checking the
target_system_arch[] dictionary contains the target key
before using it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20260106235333.22752-2-philmd@linaro.org>
---
 meson.build | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/meson.build b/meson.build
index 56df08c10ed..c58007291a8 100644
--- a/meson.build
+++ b/meson.build
@@ -4284,9 +4284,11 @@ foreach target : target_dirs
   endif
   if target.endswith('-softmmu')
     target_type='system'
-    t = target_system_arch[target_base_arch].apply(config_target, strict: false)
-    arch_srcs += t.sources()
-    arch_deps += t.dependencies()
+    if target_base_arch in target_system_arch
+      t = target_system_arch[target_base_arch].apply(config_target, strict: false)
+      arch_srcs += t.sources()
+      arch_deps += t.dependencies()
+    endif
 
     hw_dir = target_name == 'sparc64' ? 'sparc64' : target_base_arch
     if hw_arch.has_key(hw_dir)
-- 
2.52.0


