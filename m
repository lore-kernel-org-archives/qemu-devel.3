Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB209E77183
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 19:08:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMB1S-0002Tj-1c; Fri, 13 Dec 2024 14:08:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB1Q-0002TI-0C
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:08:20 -0500
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB1L-0006Tu-5m
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:08:19 -0500
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-71e163493efso1026973a34.3
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 11:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734116893; x=1734721693; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jImwOjJ09GIg50zurORlHyEBWxYYv3iz1UDBPMlQCZc=;
 b=RYIVVx7wCoE1e+avu5fpJbCM00f+8SpJOSrFh/9OX/xYcpf8VXSCSDulPU2+86BUb+
 32wsrmciW4WQXIMUCypt5QGKvJOjap7Aof6SCnWksc2sHs+Fb9AMOyspn1GX/Oatxw9H
 XGvrrAAdTUnCajb+6tEbmBwVYW8JWmsLWHMe8ZXJADcEWR6WnSl7R3gBG7gbsSXE9SQ8
 gSrye1+ApBB5cPEiXJB82EVPgXFnRyAh52r7ta0NEfsRnFfikFrZrDqXL9UAIXIgEHYN
 IAJHpzsokYwKoDJNCMK4bP7PY71G5gqTrBQ8HSBNNAIq+pwmnDoUFnacY3Et9GRKchbg
 aDww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734116893; x=1734721693;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jImwOjJ09GIg50zurORlHyEBWxYYv3iz1UDBPMlQCZc=;
 b=jKoWfs1xw+vso6Z9cDlOl/qu+H7bbbQIRfuQnZkBn2f2WmAAGqWwV7oAG+H8e+2pfP
 6obyO9kJHSClvIwppCXLcRliLjQ0w4vzQzKf7L50H/xmq57rv+67unFG7qjuLfOzg9ul
 6RqwStyPvPIDJHVhfSLrjG0JbjnBnn3FJ9jUMZbr/nVOEfHpi95OHNJb0FB40zWT73kD
 smOV/cIKwFld2Y1PjbHZMkyICypbzwUA0ZA41IFM4ibLF7mvXRic6qyRdios1P5WiIwH
 cBYouD3mgdFaKrmVrjW6L5Iv8mprOWNyzO1Jb4GznJPrwYt2FovqUXJFwiKYQHosRJfu
 bxBQ==
X-Gm-Message-State: AOJu0Yw0d3Rb+VIufzVF6OCEKxNytHFIJl6K9ftX9kkwXRzv+tBOWt1S
 wdI0c0qsfLBcym3iEy+KWCye8rmyF2HU1Q2HSpN9V3w+qs6R8534E+jEf4bHouPJgCWSgm3KVZF
 L7h2v23jy
X-Gm-Gg: ASbGncteutGYQu0paa7+vQ+DrjEa+uCCW4F1Qqpz+C4PiCc1Zzeq1mfCNhIK5xT+oVL
 Ta3n1LQFvlw+W+fy7Sv37nn+3g+rwUF6pPi11sB2DC3H102TcVOPQN2+ZEyeNNz6JdQ8dLUOiCF
 TSdzzB3sQhe5yzdq66Yn+orDavqBxQ1Bgo2dK19bH07RkywiGavMogbwvXv+X6odmeXLYpZOaSq
 mAS1uKRZmW256oiSXNdVxvwbJbEb3UTQ830jFrA7YkMtckB+QwkO/NbY3izJ1rl
X-Google-Smtp-Source: AGHT+IFABWsnhXiIoWGMmQAbS8lAIh6RqMdZdcNCROKnGNeRQ1ps5qgfTtWM7Ae/bjgFsPgWYJoSAg==
X-Received: by 2002:a05:6830:388c:b0:71e:240a:47fe with SMTP id
 46e09a7af769-71e3ba33ad3mr2014950a34.19.1734116892755; 
 Fri, 13 Dec 2024 11:08:12 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e4834da91sm29697a34.18.2024.12.13.11.08.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 11:08:12 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: [PATCH 05/71] target/microblaze: Constify all Property
Date: Fri, 13 Dec 2024 13:06:39 -0600
Message-ID: <20241213190750.2513964-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213190750.2513964-1-richard.henderson@linaro.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x334.google.com
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


