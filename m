Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EB72CA0FF0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 01:24:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ur4jT-0004wo-Hz; Tue, 26 Aug 2025 21:13:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4hm-0001b5-2n
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:12:06 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4hd-0000H5-Uy
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:12:00 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-3254e80ba08so4479126a91.1
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 18:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756257111; x=1756861911; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XsyjxtX0JYNFc0VvXMsSTJsOh4qPBkbGNiMGxVJ/tuo=;
 b=UZ+W2H6ye2MQacrGbniliOW8n19hVFs5iFrK8lq6fUz21aVu62cNUOE14dzSyuycsd
 AL9t0qPZxV+QdnYNypxJe9Kfwt9svHyk1z1tmI+2CRBu3NauFEQ8Hv/6vkimMFX+ePI+
 CqtbNtAvNWuQ+au1B0QrrpVKX+VMf8dk9wzPNwVPKsyOo6wKi2N9oLboXudF1wKAr65s
 N1QkzPXGaGGlyCyeent2FRuPGPsQbDSVrvH6zisOVBQllo//+d3VRLfxcChpu64sFfFs
 GQp31QUbxFRFCk1JGhnS+8AwkZgXWD6O5DwTD4FYLeukNx0hg88CO5yG2HGg0qz7FCAJ
 D7Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756257111; x=1756861911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XsyjxtX0JYNFc0VvXMsSTJsOh4qPBkbGNiMGxVJ/tuo=;
 b=McKAzaR9q6EHfEaAKqH614jq9cGu9BlPkzO/8aZreyVD9Y+DKi9ChpBYCXzThtT++w
 e+NrPYdDkqF4JCXVCZ4W3jnRM6licVwX49OkVEFxNosU9BMAtOKj9bZzORL8bzpzZWor
 IQ4LG5+EaIN7jrRezObQAqJuNVMEqOTcCR9Y5WD01jgEbCObSVop7kJ2nOsVLwprrG87
 iAbuyvSQhOTMOyINGK6eJMpksHnEsDYpIoIYWaQYqIavEUGEy8R1o4mssr/xZpjinEjc
 XajKC4dOpYwshnq7HScoLMglEOpVRfd/DrY1attVZobSOrCz5d+TT3QdbOuFzPYkQHRA
 llbQ==
X-Gm-Message-State: AOJu0Yx/4rIVwhOVMGk6u8ro8gXCh2qhZm2oJVeatLYv4Sk0lmO4owmS
 YwhVMrjf3fS98QmV4C2xrqbb98eJPRYH1Vj2bXFU0s+vcKBryRB7TZcfRed87THUEKe9vcp8XmY
 f2eCnurI=
X-Gm-Gg: ASbGncuDoux2iojFum/cSsjaoajVd6csZzMo/bJ9Y1OhClHAZYqs6PdtpYHiui6bc1j
 NQBDl9pARy10CcrRT042UqoOhROEljb0s+omceoZ/DRwKfABibgS9tGNCyxY1Paxsb7Tn6ECEud
 fIIKTvYooayRZiY7Zs2n2e3pbOL5lsvkZor/jOx/MuO5h/sfYHeDQMSGtKfrMyutyClHzK+FWrz
 PV7OyI13dz4VWW/zwLDZmlr6ypjNM83BBVR0y8uSw7328DEnB9pSpGOLMrJuX5SUlODx0++2oUU
 sC7KL0d4Z0rHmK2aXa+0GJ3N/SiuI1iVbnHOyNbChfjzVUzXfTP9MKIQyZoOR7A6Dd7f1nY/eSG
 brQf+BzYVA8MGft3qQNs04OE1S5PDVyPFjYaD
X-Google-Smtp-Source: AGHT+IFxAsRUdNyCVAI9FPmKLgxUmD4b08fvfwC9yLXeKkvxukf/slsZifs6KQskWixROMwKvKPKGg==
X-Received: by 2002:a17:90b:384c:b0:324:ec53:138f with SMTP id
 98e67ed59e1d1-32515efa487mr27532199a91.15.1756257110812; 
 Tue, 26 Aug 2025 18:11:50 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-771f2b2d2bfsm4348408b3a.93.2025.08.26.18.11.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 18:11:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 53/61] include/hw/core/cpu: Use HOST_ENDIAN_FIELDS in
 IcountDecr
Date: Wed, 27 Aug 2025 11:04:44 +1000
Message-ID: <20250827010453.4059782-58-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827010453.4059782-1-richard.henderson@linaro.org>
References: <20250827010453.4059782-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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
 include/hw/core/cpu.h | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 5eaf41a566..2c0edc2912 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -341,13 +341,7 @@ typedef struct CPUTLB {
 typedef union IcountDecr {
     uint32_t u32;
     struct {
-#if HOST_BIG_ENDIAN
-        uint16_t high;
-        uint16_t low;
-#else
-        uint16_t low;
-        uint16_t high;
-#endif
+        uint16_t HOST_ENDIAN_FIELDS(low, high);
     } u16;
 } IcountDecr;
 
-- 
2.43.0


