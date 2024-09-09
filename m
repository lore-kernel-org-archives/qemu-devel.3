Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF948ECE581
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 23:20:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snnfY-000360-Lt; Mon, 09 Sep 2024 19:19:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snnfU-00034w-TM
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 19:19:37 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snnfT-0005p7-EE
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 19:19:36 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a8d2b24b7a8so421245866b.1
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 16:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725923973; x=1726528773; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=95ObwF1MTlJ97wXepvdzu/O64mSpqzSBN5cc2PEU7ps=;
 b=HZ9NrIoqN/SWVr8ogUQhRyPJ/mDrM+/etnJNr9CKTNg4Xbk+cE4jDePZnv4wWItKcM
 2P1S7/WjFPbNX8OiaiMaAP8E6Xz1if1YFNQUdziaZKXUMg1jBHblVDC4M+uO1LLXFiS0
 BA0upVakyGQKbWqBwbmx+3k7FlxrZCJ3GjHE2T+QAe09LDjN4eJDQkHLWOx7XcYYSGxp
 MBdezGvUbO5Tq8wg08shczeHMdwnbXXJzAMWeOyXSq5SiBcE12nt9NIVdWPLU9kWl8mU
 nDBcT4dPVy8+AxJF0le5pA9KPMqHIp1XvpZjIiMo0b47b5yKvEwFGEC9u3CPek/UsSX3
 ybKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725923973; x=1726528773;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=95ObwF1MTlJ97wXepvdzu/O64mSpqzSBN5cc2PEU7ps=;
 b=E3acyA38FjGrBgAJ1U5gOM0MhOZTQNaiB5bxCFDsFIKQT2E984u5PBO74tWS1/yBpr
 8Q/imezVMvrIxfIm6yXff0QCMC80W2pkx9AG3NHkIn1+V8lhjKDN0fPrOCvXg/9zsM+w
 K+fjy7rE5my3JNPtJ10/Ud1KxUvkDKOt0HY5lanOolYQpaCbRIsoAgp4ShWshH5wo1aD
 NlUjH8VvSz4ZEkft8vT+twtod/h1tjBGiuq8RnBVKxRisvaI/vbxXcPIf+FKmQok2h9H
 goed/rI8aKGi6MoMp491WHZjEXpeMZN0vLEtGYbRB2OD3rGMch6vQN6LvxkzcROHfij1
 BaFA==
X-Gm-Message-State: AOJu0YzEGC7NMZGQzIEs8vVF9C+mxlK8JZmCL+6kF13OKA430e3o4/t2
 YScpHgPQurxc+NXW/FKWgT+RSU/pV65lL8JFOqDLIN7CY3pQAFLpJiEtiYe0fT2nTTEHaOS1GBn
 h
X-Google-Smtp-Source: AGHT+IHypTtKGl10pDKkxFray0o2fqX/E9OKZegMB2IfMkhHOEAWKe9ukAs8Xs7HR9xEmmNamBcC2A==
X-Received: by 2002:a17:907:6ea6:b0:a8d:498f:640 with SMTP id
 a640c23a62f3a-a8d731a7c8cmr93664966b.21.1725923973543; 
 Mon, 09 Sep 2024 16:19:33 -0700 (PDT)
Received: from m1x-phil.lan (nsg93-h02-176-184-54-166.dsl.sta.abo.bbox.fr.
 [176.184.54.166]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d2583177dsm397876466b.30.2024.09.09.16.19.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Sep 2024 16:19:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 06/10 4/4] target/s390x: Use deposit to set cc_op in
 save_link_info
Date: Tue, 10 Sep 2024 01:19:10 +0200
Message-ID: <20240909231910.14428-4-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240605215739.4758-7-richard.henderson@linaro.org>
References: <20240605215739.4758-7-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240605215739.4758-7-richard.henderson@linaro.org>
[PMD: Split patch, part 4/4]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/tcg/translate.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index bfb7662329..b9fdfdc85a 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -1433,11 +1433,13 @@ static void save_link_info(DisasContext *s, DisasOps *o)
     tcg_gen_shri_i64(t1, psw_mask, 16);
     /* Deposit pc to replace garbage bits below program mask. */
     gen_psw_addr_disp(s, t2, s->ilen);
-    tcg_gen_deposit_i64(o->out, t1, t2, 0, 24);
+    tcg_gen_deposit_i64(t1, t1, t2, 0, 24);
+    /*
+     * Deposit cc to replace garbage bits above program mask.
+     * Note that cc is in [0-3], thus [63:30] are set to zero.
+     */
     tcg_gen_extu_i32_i64(t2, cc_op);
-    tcg_gen_shli_i64(t2, t2, 28);
-    tcg_gen_or_i64(o->out, o->out, t2);
-
+    tcg_gen_deposit_i64(t1, t1, t2, 28, 64 - 28);
     /* Install ilen. */
     tcg_gen_ori_i64(t1, t1, (s->ilen / 2) << 30);
 
-- 
2.45.2


