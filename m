Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0845C8302D
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 15:41:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWGSK-0000lU-Io; Mon, 30 Jun 2025 11:30:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWGRt-0000UJ-JZ
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 11:29:43 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWGRi-0008GP-R0
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 11:29:37 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-736f9e352cbso1292672a34.2
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 08:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751297363; x=1751902163; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=32arHOqUz/2QYMB4koRoPWzjpJFn+P5kUiG3AP584V4=;
 b=ncf32nqTuBxS8pBNzgIsvvE8vWOlJiEWxNLpRxIJXk4YK/sENCTxtXF4RNrmrSoTJJ
 wYlwWT0Fsz6CxejJ1Qk70/eHZfjUtds4TMJp4GT1dEOXIFPAtiFnNDldrDDXi+QziGhr
 29nURhW+v9qmbWENrUIFvq3roIN3+9mvTlnyIz3/XUISQfzVYNEM0LT6B1OaymJOXjsu
 P6CuijmhvOXtvz1tAwL6z/BE/OuG+FuqwwdEjef2KgIPM1Gj8cgvOe4Gb8CKvKZ8Rqqy
 kTbWYWNhWwTOP9FU+Pai6X6Gg65XSviJDIA+2Rgkqrh7E1OSHg6QGgjBeMus2FQ2l2zJ
 XTSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751297363; x=1751902163;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=32arHOqUz/2QYMB4koRoPWzjpJFn+P5kUiG3AP584V4=;
 b=amidcIud4fhQMKbd14OPgnX7m39s9KWyA6habE6ohYFZirL0bckHO3uQeCqAiIzBco
 eualokSWbvFQ7BnbPR6+z8XwqvLRT8bWapVM/QnkVTZDtJFwIWaPI4yNU0y1pBdUkJ9O
 +b/BMQGfIG5DN4dmTqZsDGBO4CvtYgDh1EVMZMlHXEJuZ66Dwz6kfk72ZtI/CrOlTQL0
 wSNF4TgWU5xvzP+ucNCO9nBS9WWwB9sBuI2NprrkrBmsocEhkbLNerdG6qxuO4JAcNI2
 zzCRK2srHB9xs0Q0tVhdO9MxzDe6KLAUuKKKpT+uzeRekTPWySRWqpkjYM/cVVuPkIGm
 3Qdg==
X-Gm-Message-State: AOJu0Yz/9WhHXenk0ca9y/g/9KQ+4PAVA/WXfXsLVgFa0nrEwuqJD/1/
 QCPM6jOPXo2hHwY4BYNySSWF3ERugX10tQTrXDZPZI5qYnZuNHVlsFqP+byUVIGJCPdMxs+LAKO
 ztvCq
X-Gm-Gg: ASbGncusAMqlJzwkG1SEN7T0XFWg7tu1WsUqC/S2H2jZdViIlJefTk79fHO4DkUR7gK
 +ntsyEKR8C5+uffStcqOJQcv/iM70e0qFxheg/JS2bBxa7XJsk77temgQn91KkhH5aSk4DLrCgk
 ReAKd/Qbzsouo/rrAogYXXfHqiC79IvUsBnSbJXVyIBQbvNoZtIQunihsbcm5xAADbBFIfu7hms
 wgU/ITVv7EWJr20xcLFU+hp7C5tAUAgf4VYVDcBjb+iXO1QKUHmMuBiF8o6AHKVHaOCKGJ8FhgI
 k4jcgIA8fCzIXC21arLeKxV+MNwRF6vnP+CcSqxJ+hEzBiTn6HzyVP6yqPcFyhWZ5+zNvw==
X-Google-Smtp-Source: AGHT+IGqhZHyZ2gYk5zajR2um4+PxOjl3wsGDtofa6hnwr3FP65huF1dHuGNEaUFN6pICioXJ4MQDQ==
X-Received: by 2002:a05:6830:6c0c:b0:72b:9f17:1da0 with SMTP id
 46e09a7af769-73afc3b7b1cmr10808369a34.7.1751297363506; 
 Mon, 30 Jun 2025 08:29:23 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73afb00c48asm1712478a34.27.2025.06.30.08.29.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jun 2025 08:29:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Andrea Bolognani <abologna@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 28/29] tcg/riscv: Fix typo in tgen_extract
Date: Mon, 30 Jun 2025 09:28:54 -0600
Message-ID: <20250630152855.148018-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250630152855.148018-1-richard.henderson@linaro.org>
References: <20250630152855.148018-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Fix the direction of the shift, introduced when converting
the codebase to TCGOutOp* and small tgen_* helpers.

Fixes: 5a4d034f3cb ("tcg: Convert extract to TCGOutOpExtract")
Reported-by: Andrea Bolognani <abologna@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Andrea Bolognani <abologna@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tcg/riscv/tcg-target.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 1800fd5077..31b9f7d87a 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2502,7 +2502,7 @@ static void tgen_extract(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
         }
     }
     if (ofs + len == 32) {
-        tgen_shli(s, TCG_TYPE_I32, a0, a1, ofs);
+        tgen_shri(s, TCG_TYPE_I32, a0, a1, ofs);
         return;
     }
     if (len == 1) {
-- 
2.43.0


