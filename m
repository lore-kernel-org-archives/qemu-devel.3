Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08316CE7B09
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 13:13:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smYlL-0003Xc-43; Fri, 06 Sep 2024 09:12:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smYlJ-0003T4-O6
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 09:12:29 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smYlI-0006WQ-6Y
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 09:12:29 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a89c8db505bso281646866b.0
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 06:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725628346; x=1726233146; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xlW+VXX8IoMKaXfrpm1YbHCvNIPynyn64aMHFczAQAA=;
 b=MUl+/r2eV+Llh2jRFh4QKPcnmKGyKcbS/4jwIj4qLqDUp+nbcjD51vCjSZM3iGW1jx
 WfGnJmgIJZtBEtNb1/VfXl+QzgHfyZGgxrahREyll90oMvQGHBvtbE2DE1iBvB/IIRSQ
 2u+EoVrvu07fVODGHfJ3/OTeQhC+bJJzU2ScwQt9nfvk2520ThpmcqRMijkTSqNqYPH6
 YuLeh4QbuLpYizQlHHZ/A572iuhl8LmlnOC209bHYOcQvpDMPjYcA0oL+0qLJunyT7oV
 5yjWwTgQ8aEMZmtGZx4VxsO+NDBB8QOFT0AZjcrcMAgHfmCOAA6WIypI5fFigM2kAelf
 3DGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725628346; x=1726233146;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xlW+VXX8IoMKaXfrpm1YbHCvNIPynyn64aMHFczAQAA=;
 b=WkQeKNSayTnE7LCHq5Zmf60h97PNi4C8/jJV12kedZyYtKDCHScduIVpROTRzR6xA+
 WOP55/AlFL6xVXp516oZzB+3SNq+izLGaFsH2eI4O0iYt/mIcWwTEafjd41wrbstny3p
 NdySo+azagyBgA17WpQKH5xM3/WBSiVm97G+4M/5SC+Uv0LETy2UsEz3MYHX0tRv4clZ
 DgJj6x/nSM4J3AHnT5xoizAAsnOOKkpFxmwchXecPpWHGQwnnmLcC+IyxByWT2BdxT3H
 lBmwcMoaQvu+7kNT7uxy+UZAoxGenwM99vl8wpp7RXiGjNXydoia+Lbnrs7It37CMpf8
 rbUg==
X-Gm-Message-State: AOJu0YzvqG41bmazg942cJHawL8VsU+fzz84S7/4DoCp6+LP5jkQgmsE
 FyZ2j3YDVSzHaXG8utlhnFgXUCMJAGcp0hzYUZeugvkzPS2v5NTzJwaADA6ECSKU1rlziwr/N1E
 8
X-Google-Smtp-Source: AGHT+IE0adYOLiwLwAxzEbot6AnY93c1UwstU6m/jyZOIAhewC8qhi9wFF74baHKxOshu0GL+7Zgyg==
X-Received: by 2002:a17:907:703:b0:a86:78fd:1df0 with SMTP id
 a640c23a62f3a-a8a88668305mr207090666b.34.1725628345695; 
 Fri, 06 Sep 2024 06:12:25 -0700 (PDT)
Received: from localhost.localdomain ([80.215.236.92])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8a8b7da1d0sm93248566b.50.2024.09.06.06.12.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Sep 2024 06:12:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Octavian Purdila <tavip@google.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/3] tests/unit: Strengthen FIFO8 tests
Date: Fri,  6 Sep 2024 15:12:15 +0200
Message-ID: <20240906131217.78159-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240906131217.78159-1-philmd@linaro.org>
References: <20240906131217.78159-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Replace reused bytes { 0x1, 0x2, 0x3, 0x4 } by { 0x9, 0xa, 0xb, 0xc }
to be sure a different value is overwritten.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/unit/test-fifo.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tests/unit/test-fifo.c b/tests/unit/test-fifo.c
index 1e54cde871..60436a7600 100644
--- a/tests/unit/test-fifo.c
+++ b/tests/unit/test-fifo.c
@@ -22,7 +22,7 @@ static void test_fifo8_pop_bufptr_wrap(void)
 {
     Fifo8 fifo;
     uint8_t data_in1[] = { 0x1, 0x2, 0x3, 0x4 };
-    uint8_t data_in2[] = { 0x5, 0x6, 0x7, 0x8, 0x1, 0x2 };
+    uint8_t data_in2[] = { 0x5, 0x6, 0x7, 0x8, 0x9, 0xa };
     const uint8_t *buf;
     uint32_t count;
 
@@ -112,7 +112,7 @@ static void test_fifo8_pop_buf_wrap(void)
 {
     Fifo8 fifo;
     uint8_t data_in1[] = { 0x1, 0x2, 0x3, 0x4 };
-    uint8_t data_in2[] = { 0x5, 0x6, 0x7, 0x8, 0x1, 0x2, 0x3, 0x4 };
+    uint8_t data_in2[] = { 0x5, 0x6, 0x7, 0x8, 0x9, 0xa, 0xb, 0xc };
     uint8_t data_out[4];
     int count;
 
@@ -126,8 +126,8 @@ static void test_fifo8_pop_buf_wrap(void)
     g_assert(count == 4);
     count = fifo8_pop_buf(&fifo, data_out, 4);
     g_assert(count == 4);
-    g_assert(data_out[0] == 0x1 && data_out[1] == 0x2 &&
-             data_out[2] == 0x3 && data_out[3] == 0x4);
+    g_assert(data_out[0] == 0x9 && data_out[1] == 0xa &&
+             data_out[2] == 0xb && data_out[3] == 0xc);
 
     g_assert(fifo8_num_used(&fifo) == 0);
     fifo8_destroy(&fifo);
@@ -157,8 +157,8 @@ static void test_fifo8_peek_buf_wrap(void)
 {
     Fifo8 fifo;
     uint8_t data_in1[] = { 0x1, 0x2, 0x3, 0x4 };
-    uint8_t data_in2[] = { 0x5, 0x6, 0x7, 0x8, 0x1, 0x2, 0x3, 0x4 };
-    uint8_t data_out[4];
+    uint8_t data_in2[] = { 0x5, 0x6, 0x7, 0x8, 0x9, 0xa, 0xb, 0xc };
+    uint8_t data_out[8];
     int count;
 
     fifo8_create(&fifo, 8);
-- 
2.45.2


