Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C0FEEA8546
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 22:37:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzMkI-0005Pj-8e; Sun, 08 Mar 2026 18:37:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMkG-0005I2-Re
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:37:08 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMk9-0003UL-KC
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:37:02 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4852e09e23dso11705685e9.0
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 15:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773009420; x=1773614220; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YdraAJIIot1yfwSJGFLiSFzXGzYWkhfXgYUTmBdOKqw=;
 b=pivD5Y9G9jC/TvSLWrGcSjM26DSf/tn69h+XU7bYR9c1BKpSxx4rwTYS/CVqF3WtbJ
 TPuKOAQsK3N5OnDeaIzQ6+UBnQJ7U7QCQJF9pcy60GLsj6bYHILM1dtnnJICN0sQ/nQW
 7qryXA3btH9gJC4ChgvyEVow0gcHfjLuPU7iZ6is0hjt/Nl3KOnUDzZl5UoVzhwUfryv
 tE7Y320atcUF7x+V+czucFRMlYSGclFseLKxM1niHbewnDzM6YyHE8CxcPgQWpkdLobr
 wo+erM4xp2FS/3IrCncdNVAgUs0aFC8iNOMMsE5nvESpFAtjaDnbYakR2izbxa6SFZsk
 sQ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773009420; x=1773614220;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YdraAJIIot1yfwSJGFLiSFzXGzYWkhfXgYUTmBdOKqw=;
 b=ogpEU+WFaDgp52CDY+NYCU98euoPn0W/Ia770meZJ6AlUjYEjK6jka7Z5vyee8GgYa
 ozY5Bxqr6T0D96KwgTrF0jMwRivVcrEHW8YSfTin1zA7axFGZ+dUbZGmZGaqtftX/n29
 +/cArGD163KJp2gU5n47LJ7MpkYi1TwD6UeLjqIq9+wyhIDzO0H/luMBwr6uErJ8Z90X
 jTMJY9wiqcHZjDV0TCB7t+eQvDtCcPqqfc7awywoXRAlqvtZjY4v7wcCRMADlx3DDjAQ
 dZ8HgYXluhpeH7Dv0V11laKgatu1eCRnorcYLsQdwlnHn6JUJe0E0u0mGJTiRS4M1vxb
 kXcA==
X-Gm-Message-State: AOJu0YwlF3kh1a/iB/num3BX+K/42qDhFLTSIN/JBamFE74llu8IO9+1
 eZjoUTnPXw/WzWgRs3ezXCzgOxlGUXo0xE8AdC2/WaP7YFYhyXad1WxWaDWMX6TUmK+v6+euuqx
 u5cy9MNY=
X-Gm-Gg: ATEYQzyTE1cogGSPb/4tnWWA/nury0jqSi3SMRnV7BVQ5f5mQcFYIh4UhWjsda40+w/
 cT8gWbgEwWOQ4sfDmXnuNhLp5OgPmQHdbjifJUzjMykbJbO907Vi+tatad3nh3rJ3GhLdx47vbR
 aOmBlzk0b7N8wS2A+GhPugZDBSiP1t60HSbu/SqUDRf3247FocoevHOWwekMk/IhWy8XgiaKoo/
 cf+eEKTvUg2TQGm6NLyORTsojrqJjKdrT0rSjwx84SHtvbTzKO1jeDJl2FkJwi22pG+VpHnUp9U
 CHJZldETvU5wThO2ZlMz9/0OIeP4X50A90UKTEW3DLJ2sPgFxBjtO5PsUcD451eYOmzrUOKvTXh
 w0R1jU1PG3uR1hDwqWM4Y35yjQNtprL81J/7udC6VXG4NX6HGzLT8DIpQBG3cRGIU+joAPQcJaL
 itX1uvq5253VXz5omdlsmxRhRoXKTSFbUYdT5JWndjjUP2lK7HBvs6X5MbW2ZgLToZQVdbkIha3
 Z9L8w==
X-Received: by 2002:a05:600c:1395:b0:485:3b34:2f61 with SMTP id
 5b1f17b1804b1-4853b34302cmr25177155e9.7.1773009419473; 
 Sun, 08 Mar 2026 15:36:59 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485237f2d2bsm73353225e9.4.2026.03.08.15.36.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 08 Mar 2026 15:36:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/49] ati-vga: Implement foreground and background color
 register writes
Date: Sun,  8 Mar 2026 23:34:05 +0100
Message-ID: <20260308223433.25503-22-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260308223433.25503-1-philmd@linaro.org>
References: <20260308223433.25503-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

From: Chad Jablonski <chad@jablonski.xyz>

These are straightforward 32-bit register write handlers. They're
necessary for a future patch which will use them for color expansion
from monochrome host data transfers.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-ID: <20260303024730.1489136-6-chad@jablonski.xyz>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/display/ati.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index ce23e5e48b9..26fc74b19b3 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -924,6 +924,12 @@ static void ati_mm_write(void *opaque, hwaddr addr,
     case DP_CNTL:
         s->regs.dp_cntl = data;
         break;
+    case DP_SRC_FRGD_CLR:
+        s->regs.dp_src_frgd_clr = data;
+        break;
+    case DP_SRC_BKGD_CLR:
+        s->regs.dp_src_bkgd_clr = data;
+        break;
     case DP_DATATYPE:
         s->regs.dp_datatype = data & 0xe0070f0f;
         break;
-- 
2.53.0


