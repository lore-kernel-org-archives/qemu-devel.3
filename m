Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0056C369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 00:57:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7krc-0005H9-M8; Wed, 23 Apr 2025 20:54:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kqX-00015m-Nb
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:53:46 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kqL-0004lL-4Y
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:53:34 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7398d65476eso360412b3a.1
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745456011; x=1746060811; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WONVWesSZ8uE3+nlVXH925QeCM8w4OWegE2KeFmY578=;
 b=rrLVx+ALS8OfemRipVPsvlXnKEKbAiabqW+OOd3RZWfR4ReT5AACuFMxWgzFviEAqK
 cowY/gDLNJJNpXkmFvXgvDTAcGEfcl64Jm/rhIM4N/DdGGDp2zEo99CU4A87Tk3sJncF
 4fkFajMe2zMyUCVE7XQMn/PwL8eZi+jFvx7BPdhiVxEGC9iwJlyFqQU/Dm5+JmRQAxc2
 qK9RkrY7J9IKbCS9BdDZ/J+TJy/ju2g8A4X9v9gdnbjhx7hZzR0jNiboyGsWg/nzrPTW
 x5ydinFcKQuQAK+iSVSIwvufUSNyG7URvRVbaKCjbrGOForT1SJXODSTScPkBqIOWZAg
 +B+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745456011; x=1746060811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WONVWesSZ8uE3+nlVXH925QeCM8w4OWegE2KeFmY578=;
 b=CA/DN0JfxT5JukmbSMNxBM8DYYBjanQFzDFdxiquyMHEeTiBFV8KsbHdDhZy5YV7qb
 38O5G39yJnhqxTJYeQiRta1LIAd1qAzZy+sfKK16EHOKcsENw77J6cfB0JCquX0+tw+Y
 xapeCVE9qWcLFsBIuFPN3i9qxhW1xVBJf8zAqUv+e7n9Q3SK/LHXxyiceg3O+UL8UKv6
 xuL25Pk45YNV27d585uZISO/f9JYo8dfTqK2jS6YHVuHvh9uKbRnuxkID7zSw32x/8xH
 o8/pqxCZwvGn3AAjpFyzlBA8apYkvxLDXM2ANBr111nYRRnYt8W79yRWxyaJT7eh4Cvo
 gBNA==
X-Gm-Message-State: AOJu0Yz5mLpBPOX+Ef1ts6oqCwOwqh9JyKnDzZyZAtYl3Qr2MrGWt7oy
 XmlNbUzxR7JzzU24CzxihtsnfgflW305glQezDC5w1ZI/J5j5lSmujavZoJmMI9R311EwMEX6AL
 x
X-Gm-Gg: ASbGncuwKiMNQBC5iBd4EQFgaouCwp+syV+A3jqYboK97p64j9j8pfZ1lO7V30GAIo5
 y7PRnYLl2TG0oI+VJ8wBrY2n94GWfbBFvf5Vgbwes+NPM7JNF5USUSW+1j5vi9xwB86tceUvku7
 PcHt+jyo+A6xpW+wL+w35qbMgKPE1foP/L8zcH0pBr0FIFW+6uRar+wDEj3n4pPuByHuvwdZuSr
 5P47vBguFh8fGGs36oRMHaAuO2lccD857zGzcujxIU/OZ85p0ftlE6dvxhN5t0/bexA44v4Hd8p
 +apjLN6GBPNpnUHaXW8qPQb9QB4qnOLW0ce7CK7WYCNCkWI1ldCkFMXb2BhVXqYo3OWYjIm36/A
 =
X-Google-Smtp-Source: AGHT+IG3j5/mwo5f2ifgbeIhk5am36q8tuevvdGEoD4fziYcjZ3UDwiAJ/4InKaill32Mf8JSib2AA==
X-Received: by 2002:a05:6a00:acd:b0:73b:ac3d:9d6b with SMTP id
 d2e1a72fcca58-73e267e7d8amr619708b3a.4.1745456011417; 
 Wed, 23 Apr 2025 17:53:31 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a971sm209353b3a.103.2025.04.23.17.53.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:53:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 076/148] target/avr: Restrict SoftMMU mmu_index() to TCG
Date: Wed, 23 Apr 2025 17:48:21 -0700
Message-ID: <20250424004934.598783-77-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250401080938.32278-6-philmd@linaro.org>
---
 target/avr/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index 1121822470..feb73e722b 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -228,6 +228,7 @@ static const TCGCPUOps avr_tcg_ops = {
     .translate_code = avr_cpu_translate_code,
     .synchronize_from_tb = avr_cpu_synchronize_from_tb,
     .restore_state_to_opc = avr_restore_state_to_opc,
+    .mmu_index = avr_cpu_mmu_index,
     .cpu_exec_interrupt = avr_cpu_exec_interrupt,
     .cpu_exec_halt = avr_cpu_has_work,
     .tlb_fill = avr_cpu_tlb_fill,
@@ -250,7 +251,6 @@ static void avr_cpu_class_init(ObjectClass *oc, void *data)
 
     cc->class_by_name = avr_cpu_class_by_name;
 
-    cc->mmu_index = avr_cpu_mmu_index;
     cc->dump_state = avr_cpu_dump_state;
     cc->set_pc = avr_cpu_set_pc;
     cc->get_pc = avr_cpu_get_pc;
-- 
2.43.0


