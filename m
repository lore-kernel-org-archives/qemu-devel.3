Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55C65F513E5
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 22:11:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyGt5-0001EH-Ra; Thu, 05 Mar 2026 17:09:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vyGsu-00012F-Pr
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 17:09:33 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vyGst-0002Gh-Dz
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 17:09:32 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-48375f1defeso64610575e9.0
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 14:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772748569; x=1773353369; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T/8vBrNspQwC+4wrO/zavy+wMEo5y5nyjJoJrIaKZns=;
 b=FMxzRkv1Cw7z3y72SyUoiK5N7TKDkFp7m9YV05ocumUtloutuV0ud8jvPSHDZ+RoeS
 4sPbW9tWYq8HEPWr/rbcYTMIYADUKXTsN2JRt1M14/5tbdVrv3FQ4xt3FhxTZOUmdpkH
 pkZp91XSCyOcpoEaP9SptY//L+fgRPf4MuuvDWFxEE0dmkr8CzeLt9S05WBV6P0qSfOX
 KNWhuVLskN3a28bVb3BimyHYhioRmSi9qg7m+u3+mHxyat8JnnXiNLMcnpCpzMvZIYDV
 b91wjUcROrwpQiOqpN6baGsNxVXMTVIg7a4HwhdzCBtzo8HGfnLN82hmXFpYaTFctKdX
 90vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772748569; x=1773353369;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=T/8vBrNspQwC+4wrO/zavy+wMEo5y5nyjJoJrIaKZns=;
 b=UZcOeMO4PMIOM4Yf726QHcS/NrrO2HERbeQNvD3LdwwLVC+Q5kQ/0RaWrxNIUkHFdz
 R3VbjTlffm0ZmOXTpA9KAaygVuYUxoPMN/dTyypAymkPhyimrOPiiWw36b0DqmrENU39
 kU77e4PdV1IE1+jtE/umCsP7EcNgaecnGgXS8mUMANEzGV9QLktLCs7LxDWbpCR+Buwg
 t3QtVrlA6IphuF9uLYIbxMFwj+i5PJYkwg9KYHIwMX/1ZSeDbLBXHQXMrTwfUj36KJi1
 WVHRpKvbM6ZYY0Prn6SMZQNuf/JnwB0doMeRhAlRGHSIIWk906zJQUQfxIj0jbPTKIka
 3MIQ==
X-Gm-Message-State: AOJu0Yx+tl3SFniAb97QzTIi6ULYMde5fFXFPTKJwxjr0wTZvVxfHair
 aHhp5nxUgHQRbqg/janjGmrlQcZQMMn3B/4jc710MzF5FvCfDD3PY1iazat76g==
X-Gm-Gg: ATEYQzx4C6F+dwpW1T1MOSlDNEKNGfmMKi1PcjiYp05f3XxYjJkSHYcyr7jcZOCz35q
 98oL/Xt2mA8kV6bYbgjdNR04ZiOMQS2Qy47XC/oLloPo0X6leFhXsPI7Tvev4jvM0mxu5oYYtgD
 nuJb9GmInjtxFRisWiIY0Jt0U7HNQ5qs8hzGVuLLsWPLQZvXokTYGrwbbXTEtV1yq5ayiR3wo11
 lvbIibp5I1L38pv55Z72iOvQfaq73Rq2IaNWAk/4fVN1h/XK0Yoj3Co89GqMKF1tdROYl7FFPxw
 9krVAXo6dw8JO4JGegT3Wulf3oum0EORVMSr9cDmJPmDk8v2QH3ytndL5kU+lbQpDJv/0dumNeX
 g/onoVDSayoEsjjkYwIzLb+yYmmJl+Md3cFf1vofQQYJnmSJ0pjMZ3JXYg2Yfc4UgiIOtgsxiRB
 6rxuzv7HBPq1QcnIaX09rPRjpId+qIDI3o4WjjekIvKbnzjNBI2b0sNorI+A+4CGUVCxUefXWnK
 OkOOKckNdyp4egAtwgR087v4BVodKLYTnFb/2UAJGH+5UI=
X-Received: by 2002:a05:600c:198a:b0:480:f27c:6335 with SMTP id
 5b1f17b1804b1-485235fddd0mr17724115e9.25.1772748569104; 
 Thu, 05 Mar 2026 14:09:29 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-2a02-3100-2989-c400-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:2989:c400:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851fa87e56sm67419615e9.0.2026.03.05.14.09.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 14:09:28 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Troy Lee <leetroy@gmail.com>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, qemu-arm@nongnu.org,
 Helge Deller <deller@gmx.de>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v3 08/14] hw/char/serial: Remove unhelpful comment
Date: Thu,  5 Mar 2026 23:09:05 +0100
Message-ID: <20260305220911.131508-9-shentey@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260305220911.131508-1-shentey@gmail.com>
References: <20260305220911.131508-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

There is no "is_load" flag and one can tell from the method name what
the method does. Remove this unhelpful comment.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/char/serial.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/hw/char/serial.c b/hw/char/serial.c
index 2c558cb9fc..f73de1ae4f 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -281,9 +281,6 @@ static void serial_xmit(SerialState *s)
     s->lsr |= UART_LSR_TEMT;
 }
 
-/* Setter for FCR.
-   is_load flag means, that value is set while loading VM state
-   and interrupt should not be invoked */
 static void serial_write_fcr(SerialState *s, uint8_t val)
 {
     /* Set fcr - val only has the bits that are supposed to "stick" */
-- 
2.53.0


