Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5777BE7716A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 19:07:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMtw9-0001Em-D0; Sun, 15 Dec 2024 14:05:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtw6-0001DI-HJ
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:05:50 -0500
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtw5-0000y2-2S
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:05:50 -0500
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-5f304ac59b9so1729665eaf.0
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 11:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734289548; x=1734894348; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MWAg3fJJW/8AMfM3/0VLXGSZais7amzaqXuOjIhJ+9w=;
 b=aR8QjwEhy9Pw/WzCw9ax2m18BPy6LyQ4kZNmfI+LgWt/n1FymxD2EWImx+X07enxoe
 69KJMUbuADD6Ao0IC2oFto3XWV7WYoGQXp5JjxwtTyLgW7i+BuLrZmEN18+tUKXffQ0+
 RN0WnwhU2aKL7AdiNsmiJUtkSfRN+2A/jfoRu/Of/6pzjOTTi1E3RiIlAI0rO59b2h4F
 VH+Nd4t9jjqNSsbwKnP8Y9xq+SnyM50wDKW/19g94GC0IyRlm4IZoSxjwYTwR4PPLwwB
 xK8PEDyzPUu6KVc6sNwFOUow7ZOkIwuMJX1iwdgpBgexob6oPgR78UgEN60k5h7Lmgqx
 pUMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734289548; x=1734894348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MWAg3fJJW/8AMfM3/0VLXGSZais7amzaqXuOjIhJ+9w=;
 b=QOZa5jg/axT2YeD3+jr95LXtVX1Gb3H8l1PolyE5h9i4HhCLNRS/AYPz904I9uiCJf
 /Ql9dGZM2fYT0JF3dDa235iWl8C9griBhkY9160IlV82r3B2HhYlkkk0uSlmPELh89WR
 M5nntLJv4fzyif/b1Daw+3I9vnnBF8lZDZtYjptE0uQsqYgJfIVz6o7IXoxAauC7ZLAw
 zvO8pAS3NmKNmZrphcAwmKgU6WOCgKIEmYgompB9us7kBdfBn123llZ3pKllCcFen0Vb
 AIcXqZTB+SzsGHQY5Ej/ISkfjUviJcvNyiOTzGRVkPIPwT6ed0b3cc3jhy/3+RAxiAAG
 5MBA==
X-Gm-Message-State: AOJu0YzbvYA9lJdAXMv6Tma3q1iQzCbTnV7ZGrf3qfD4BZYG1PkZnomy
 yx14c+jx6K7rcNSA4tNNTvoln7FGyW9EQ35OWD2j6GTqXfgSgua3jCKjZrUxCSWhcmiCPqD0aIZ
 nFhUWyS4N
X-Gm-Gg: ASbGncvg5ZQNdPa5Yz8EktxblytkpbXIATHrERVoaNgnDqyOyi6TeOgR7oAqegAOSE1
 6+VFEe1uWvWjFQeHofCOnKEtxdwwm8JS8mtORJbv76/cnXL9eMbNUES81SGpEVEmfpxvfRjxrf1
 bOPY6+LIln2ZqtpGewX61rLFQHyWuOED8S0drno20Eajj2f0TToXDxh2vSE9aCR67DYDiZLxMtf
 QdOJOslbTB7nrrXKTSxNqGsCAU0NEpJPyfezrhOkrKwZv2VOe9YSQDJFaQDL8WzAZji5OmyNl0g
 r6kZkmFCVNLngfxIOnxLo1lOOTBcEHgGM0Wg10GYsTU=
X-Google-Smtp-Source: AGHT+IHV7pKS/cMUx+UqtAql4b8xm0zapfAsopjDEFYTUr0B0rmPBnm6FQRdfPmM7GTfNuHRkFiBwQ==
X-Received: by 2002:a05:6870:9124:b0:29e:362b:2148 with SMTP id
 586e51a60fabf-2a3ac7b0172mr5259173fac.19.1734289547776; 
 Sun, 15 Dec 2024 11:05:47 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2a3d2914ac6sm1423214fac.39.2024.12.15.11.05.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 11:05:47 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 05/67] target/microblaze: Constify all Property
Date: Sun, 15 Dec 2024 13:04:31 -0600
Message-ID: <20241215190533.3222854-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241215190533.3222854-1-richard.henderson@linaro.org>
References: <20241215190533.3222854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc31.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 0e1e22d1e8..0e41e39c0e 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -339,7 +339,7 @@ static void mb_cpu_initfn(Object *obj)
     object_property_add_alias(obj, "little-endian", obj, "endianness");
 }
 
-static Property mb_properties[] = {
+static const Property mb_properties[] = {
     /*
      * Following properties are used by Xilinx DTS conversion tool
      * do not rename them.
-- 
2.43.0


