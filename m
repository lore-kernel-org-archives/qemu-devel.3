Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0FCFC02199
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 15:35:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg3td-0002Z6-KW; Thu, 06 Feb 2025 10:34:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rbradford@rivosinc.com>)
 id 1tg3tS-0002Sm-4T
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 10:34:18 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rbradford@rivosinc.com>)
 id 1tg3tQ-0001Fw-7w
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 10:34:17 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-38a8b17d7a7so494695f8f.2
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 07:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1738856054; x=1739460854;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O4fAi/WFyk5fUA9AqpTcM5pdirl0mVctIzxsel8zKVc=;
 b=RCactgeaRbwb7gMcVIE6DIG4QrZlN3XtBDGEHIh16M6G9hst6StOBQdFVldo7w/r50
 z2PQa+Hk8AKVSM8Zy1Sh+yqUtRSQdNDjqazPEuVsNYt2JnL9+Whnw6q933Ia/LuAiFfj
 C7Ey3/sAtKSEjULsfRSkYiPNCj/4vgPs4/ua/MvoEHtv9dHZfKCQ8isOkDnHMtPQL5VU
 syeQM8GEsfU/VTV5yC/mYXk6FHX6K3VBz55PM9srJ7TG9XLP7wmozODt51geHU4ZU5Yw
 t8J34KMD9Bg7zNnDRE6VLwCmc8/Blv7d6CiS6WM8+yxlcG51H/WOORvjikNJ0pi43Clm
 SSaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738856054; x=1739460854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O4fAi/WFyk5fUA9AqpTcM5pdirl0mVctIzxsel8zKVc=;
 b=EK9zr2Lgi39g0dm5bgi1Yi5lFjlVp7jcOo2DFVU57wQWTkirYPY/t0DdzmMhTgA+Z/
 PTtH0WBzQmGSx2kzgbJZoWNrWy6319mbpPEQZ9VuWIr+IQTMY4UEngZlJvM9kA8HYWai
 fyLujcNjBmrw3rd9DcgV3qVHZa3pRSgLbR5nRyg7OBvp4EsBV5hUXh2jrn+i2W31mwms
 1Suk60Xg7ZW/OFVQY22m5ibJ8prUgID43dI0SDigc9ciJVgYZev2YpoOw0mgbEMrWkUD
 OyAfVDGZ9Q6H+ERXchIAzGUopM7bQW0LNC0+IFWrW0JXssaIKmsXb8+UuvyOPddUBPOL
 55fQ==
X-Gm-Message-State: AOJu0YzXu7qyzuT0EA8VDT36iGu6d+9c3PNAmqo6H0PgV1OX+nvYGRrX
 bJ4NGKI9SjxtTlOrfV8IhFOtWwYhvLm8OGdUmPjy0vPtbjlCJB8/+lUUHiNKC7OBaInb6LD4JvB
 V
X-Gm-Gg: ASbGncs6DhdrPEQjDCNQldFH5KkWliYwKe3c2TCDXrauJrd2PuLXIeJ9JJS0KF3y5jo
 h6EfkOJxQdI3QhpFvIWwO2XbX9yBVoT82tvgxglxe/+UM8VbmAKjv8Fmq80JVJhvlAitDlxwvUn
 YqX7oBbyH37JsbeR1qWnc2RzgdJHWqMVZ5kQgOFtgsDhMt46kKKHzqF0Yeh6ir+PujBC/NGTyUj
 aMKeHdkrljcTlo0hWlI1/4wVYMUk3u0zec7c8II2A1K8GxtmVXRU+7D8lBw85ZSGC28neKytINz
 gM/S9IZqWCXb6DvuvU5bVCvYMp2haPSJlfPgXYAhBIKwA1q815Pf0FC0K4cP7xScY9A=
X-Google-Smtp-Source: AGHT+IE+lIqtmzQFCpof9gOpI5qAce29bO2n7sMxfQ6jcqolHCidIieIJjlkCp49engQ87U8LkLoZQ==
X-Received: by 2002:a05:6000:18a4:b0:38d:bf56:8658 with SMTP id
 ffacd0b85a97d-38dbf568bb3mr1841968f8f.24.1738856053891; 
 Thu, 06 Feb 2025 07:34:13 -0800 (PST)
Received: from rockhopper.ba.rivosinc.com (214.11.169.217.in-addr.arpa.
 [217.169.11.214]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dc45c26f2sm850516f8f.51.2025.02.06.07.34.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 07:34:13 -0800 (PST)
From: Rob Bradford <rbradford@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Rob Bradford <rbradford@rivosinc.com>
Subject: [PATCH 2/2] disas/riscv: Add missing Sdtrig CSRs
Date: Thu,  6 Feb 2025 15:34:10 +0000
Message-ID: <20250206153410.236636-3-rbradford@rivosinc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250206153410.236636-1-rbradford@rivosinc.com>
References: <20250206153410.236636-1-rbradford@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=rbradford@rivosinc.com; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

This reflects the latest frozen version of the RISC-V Debug
specification (1.0.0-rc4) which includes the Sdtrig extension.

Signed-off-by: Rob Bradford <rbradford@rivosinc.com>
---
 disas/riscv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 305dd40ac4..85cd2a9c2a 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -2438,9 +2438,11 @@ static const char *csr_name(int csrno)
     case 0x07a1: return "tdata1";
     case 0x07a2: return "tdata2";
     case 0x07a3: return "tdata3";
+    case 0x07a4: return "tinfo";
     case 0x07b0: return "dcsr";
     case 0x07b1: return "dpc";
-    case 0x07b2: return "dscratch";
+    case 0x07b2: return "dscratch0";
+    case 0x07b3: return "dscratch1";
     case 0x0b00: return "mcycle";
     case 0x0b01: return "mtime";
     case 0x0b02: return "minstret";
-- 
2.48.1


