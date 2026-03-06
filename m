Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B7D6FCB608
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 14:59:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyWei-0003qN-T2; Fri, 06 Mar 2026 09:59:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWeg-0003mE-QW
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 09:59:54 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWef-0002Jg-7W
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 09:59:54 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-483703e4b08so91110475e9.1
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 06:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772809192; x=1773413992; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZX+SSdfmU5nT1e9Fk2QahSpoug4gowcMeR6aG8EzY+A=;
 b=bYA4fcIVdzXm9nWDWYO0+6H0esUiHsNPR8yK0pYooFFh5MiFikl/mC2Enyav/YeUab
 TRclOmbgrLNm5wyxcVQpjItdsD4X4C5Y8RJsXOPWsdJ26P59VgisMppjd0PP1VZllifN
 T9bwmWx/FWPm4rx8AKX1uY2V1A4eoqdII/tXHI52UAHGrBqyhvDFAe2A1euWA+enkjM0
 jxlyF/D67CodB2WHUq+o4wC38wV+wFp/Q25P7Hm35vuWKoTCU4uwZHnWS9L3ekfdYB8q
 mdLGt4IXy1F3f6b5H++0C4vdq38qOoqUjjOGrldCm+Xi4yB9w+ZZVtI3oKB3EWBuAxNC
 PA+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772809192; x=1773413992;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ZX+SSdfmU5nT1e9Fk2QahSpoug4gowcMeR6aG8EzY+A=;
 b=kJR+/I2GKMdx8ZCjUmJo3Rr2L6VW/2Qs2Peqhw3gUCJ2X7FqaWTzKcJdq+5wbSn0nG
 l+avU5AhjxDipTxwbO4rldDobWyKRBq0UWjQmEwfxV7zktrIYkaewbHlLj1rHKN5/BfD
 otsPOK3nbJB92WLzsXAavnrXzQIXEtCA/P810QhesIbfkLaFEyZ6OraZXT/ohIGXdPHa
 Cen9J9Q7LPRFIvFisYkFW51U/NLbMpmUw5ElK+0q6AXLgvgAtLRR196qUM4qLQfexDEq
 XwzTItzNz5xeF8G7jKfS4qieXIoHSPMh4G5ftGOS9XLbUsTUndEhRV/zQ0/FEjbf6opu
 Xfww==
X-Gm-Message-State: AOJu0Yz31iJ7n/rjNaxW5C62FS2x7740SgbqWrSE+l63gWIV6Zgud9Nu
 iutdaZMtK3m6F16eeuD/6tRJSNDvLh4k52HJBRL5xuigKEdjpsLiRzPggSjuQm2jRCtxLdZP1nN
 2fBnc
X-Gm-Gg: ATEYQzxoAaJUMP8UCyWXdvoS905w4P10xrZCB/o3jw39VjhPPDZ2WIEbTu9dgtybuZY
 B9OKKhmp071sXT+k9JnarEhaj2CN/0F63h91EIEMHA87crW4+e52gr8u4SVmzuP1mR37rphY5fT
 MbFIWAfChhKO2qmToS7JrMBrhSIhVq/bGmAO7HmAbgck+Foq69AOR8rqmvJm4ROUuKxXeTvuLnW
 hbpm+WzK6p0HKWQCrl3pmFkM9PPjRBfswhIdtAmZgNy5xc568tp91Vz7DNwVcQwtgCtQ4W11Vzd
 InN6xgxLqKpNfi0PlY34DtHm/vNnO/h5/fbiWXBe3mUOG/gA6sgfiCWkKGqu2bk/nLoc/jiz4zq
 MEeeX04eq3izuNVweUT+a8XNBa+96m7oZQhKide7jSnL92jiLW5WfsfPlXBalj4UlOW/MQGck2Y
 dnQqGrw5eSt1neKa12XvQ/MfhZJJh2Hwvla+Bdd0vMxaP2dwOn7qkWgF14i2aeclZGSIpqaKYDB
 flCxlP3ez0CmLmYjG7hx1XPHvuMbPc=
X-Received: by 2002:a05:600c:8b6f:b0:46e:59bd:f7e2 with SMTP id
 5b1f17b1804b1-4852674e8f7mr40228525e9.11.1772809191655; 
 Fri, 06 Mar 2026 06:59:51 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485246ece8bsm28681845e9.4.2026.03.06.06.59.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 06:59:51 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/49] system/qtest: Support comments in input commands
Date: Fri,  6 Mar 2026 14:59:01 +0000
Message-ID: <20260306145939.2162189-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306145939.2162189-1-peter.maydell@linaro.org>
References: <20260306145939.2162189-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

Allow the qtest input to include comment lines, which start with '#'.
This allows writing an input file for qtest which includes commentary,
like this:

  # set up TCR in bank 0
  write 0x1001000e 2 0
  # TCR TXEN
  write 0x10010000 2 1

which can make hand-writing or annotating reproduce cases a bit
more convenient.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260226175700.1319767-1-peter.maydell@linaro.org
---
 system/qtest.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/system/qtest.c b/system/qtest.c
index e42b83ce67..cf90cd53ad 100644
--- a/system/qtest.c
+++ b/system/qtest.c
@@ -71,6 +71,7 @@ static void *qtest_server_send_opaque;
  *
  * Extra ASCII space characters in command inputs are permitted and ignored.
  * Lines containing only spaces are permitted and ignored.
+ * Lines that start with a '#' character (comments) are permitted and ignored.
  *
  * Valid requests
  * ^^^^^^^^^^^^^^
@@ -370,8 +371,8 @@ static void qtest_process_command(CharFrontend *chr, gchar **words)
         fprintf(qtest_log_fp, "\n");
     }
 
-    if (!command) {
-        /* Input line was blank: ignore it */
+    if (!command || command[0] == '#') {
+        /* Input line was blank or a comment: ignore it */
         return;
     }
 
-- 
2.43.0


