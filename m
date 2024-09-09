Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61C61ECE581
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 23:19:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snnfR-0002ty-FA; Mon, 09 Sep 2024 19:19:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snnfP-0002sp-5k
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 19:19:31 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snnfN-0005oj-He
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 19:19:30 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2f75428b9f8so38277371fa.3
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 16:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725923967; x=1726528767; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M8rojel29tg+5U7aBtc/ocKZdcWEoHiWGG+uedYxRgM=;
 b=Y+VuE+Q0ssalsf7LVltWHnbtuA+5WNXs5Fmu0Sth1WdpGEJpqQlqKiO5GfCvBKk2iJ
 ejIaD2FKsXvOT7E6ZWQYSPhaxOBvlTO4eP30aPptVh+tjn2Re86Z43NkAdXsd0T+CVip
 ilw1+KHAaDZ6cEOCg4uYaiiP+OMNKaEyHcgrZJQcT+s6Hr1U6QCPBQRyRyz7ZGCTxYAH
 Yvnm8TW1NO4ek3Vh8nDlCpW0/Tmvo5mvoRUIzKP0kmLw7CCXdSMFWoyfLGX/agD1otOG
 8a1h+1cU2J2L7c8ANfWxtcusXGjLy5iVyX3OuFVgGlAii8/JlR8f2SAXoC25awvqM9dz
 KoLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725923967; x=1726528767;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M8rojel29tg+5U7aBtc/ocKZdcWEoHiWGG+uedYxRgM=;
 b=IpQfR+kmF51oS9y5pWUpQodgPXqQfClBuO7NrPQNPAAYrvMdapH0lPPV+UKqkP8oBc
 ZEekF+mgl92vM+z3x+Jppksyn+GnYpKZsp5/C9cfw8INnOrwfLlr5oYTKw1SwL97XLhc
 18FGFusEvG8tMW5RthxJEMMYaZFBhXv/VlsljShaA5KSrLx0byQQ0Md9OIO5niuvbBID
 mZjr0i4R5FVFHzl8pBES6Fo5WYZLjEvNsmX5SLBejkcJ7+ONyXp70JXubKNStaBPh+qD
 VqT4Ox+K2QldxnaKbgmelohWrOz7D1b5OIO+TQXEifh7y3c296orvAvUjtoNc9t+ACX0
 S0dw==
X-Gm-Message-State: AOJu0YzOXs6dZZIHcEqBldCD2z26QIvq4f18jFUPvTB9aupkHNUvX3Z6
 Lmoh6qIvn1EYiVXvjT9bPvCgmes2SrJ91kNGAtWgsQImIVuAmXpXpLFHOVrvzOEHUYFd84cPToP
 q
X-Google-Smtp-Source: AGHT+IFcD7K6S9XVIQ3ztv55SmE/zdud2ZELi4csLeR90j+ODUJWbWM7fP9ZApkwwAVXx/Q5bOxb5g==
X-Received: by 2002:a2e:bc1b:0:b0:2f7:562d:cb6c with SMTP id
 38308e7fff4ca-2f75a971341mr95792601fa.2.1725923967148; 
 Mon, 09 Sep 2024 16:19:27 -0700 (PDT)
Received: from m1x-phil.lan (nsg93-h02-176-184-54-166.dsl.sta.abo.bbox.fr.
 [176.184.54.166]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d2582d490sm406252366b.14.2024.09.09.16.19.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Sep 2024 16:19:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 06/10 3/4] target/s390x: Use deposit to set ilen in
 save_link_info
Date: Tue, 10 Sep 2024 01:19:09 +0200
Message-ID: <20240909231910.14428-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240605215739.4758-7-richard.henderson@linaro.org>
References: <20240605215739.4758-7-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x235.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240605215739.4758-7-richard.henderson@linaro.org>
[PMD: Split patch, part 3/4]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/tcg/translate.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 53ec817e29..bfb7662329 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -1429,17 +1429,19 @@ static void save_link_info(DisasContext *s, DisasOps *o)
     t1 = tcg_temp_new_i64();
     t2 = tcg_temp_new_i64();
 
-    tcg_gen_andi_i64(o->out, o->out, 0xffffffff00000000ull);
-
     /* Shift program mask into place, garbage outside of [27:24]. */
     tcg_gen_shri_i64(t1, psw_mask, 16);
     /* Deposit pc to replace garbage bits below program mask. */
     gen_psw_addr_disp(s, t2, s->ilen);
     tcg_gen_deposit_i64(o->out, t1, t2, 0, 24);
-    tcg_gen_ori_i64(o->out, o->out, (s->ilen / 2) << 30);
     tcg_gen_extu_i32_i64(t2, cc_op);
     tcg_gen_shli_i64(t2, t2, 28);
     tcg_gen_or_i64(o->out, o->out, t2);
+
+    /* Install ilen. */
+    tcg_gen_ori_i64(t1, t1, (s->ilen / 2) << 30);
+
+    tcg_gen_deposit_i64(o->out, o->out, t1, 0, 32);
 }
 
 static DisasJumpType op_bal(DisasContext *s, DisasOps *o)
-- 
2.45.2


