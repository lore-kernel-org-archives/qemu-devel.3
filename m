Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4417BEA8546
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 22:37:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzMk4-00052D-NK; Sun, 08 Mar 2026 18:36:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMjt-0004Vi-OO
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:36:47 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMjr-0003Rt-KG
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:36:45 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4852e9ca034so12193505e9.2
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 15:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773009399; x=1773614199; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OBGHDfQs2oR/GEstE9rCn+hZYYqj8r1706LFc9l+Cs8=;
 b=yoetW2HeoYFYoXjRKxHxy+fUqGZCAvSqMRpwf4f9qreTV6AuHF4U5/v42FqOULEyIJ
 yE+sPk6Tzb5Z5WDldSdqesp7PaP20R1EHzA+HGubwBI5uN20Jjq7kmXswppU6SFaoeK9
 P4pwcKelFS8TgyCUWKlgQWipvSv1WlOZFihOSAmp4RwDIUjgZPAX5LwkWKOh9Dv9yfS4
 Pcix8ypQ3VLEprlg8VNsz8JYwAanq+uymWAvPBUec4m2rqupvvYE07xwkAmW1aV87SA1
 Fqb9Y0BFZeFC0x8zv+GVSEbJtgP4j9jJMJbWh5sG3lv5AgwF2n4cIVLzNA24OodRJHAv
 nmJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773009399; x=1773614199;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=OBGHDfQs2oR/GEstE9rCn+hZYYqj8r1706LFc9l+Cs8=;
 b=tLQgYcOeZ+jj/jAVIUIiINvYfjsVlQ318SFhNMAakx0BZpU5GESSa8SKe1iUxRD4Ig
 Y25xYxy0IqKXQ1+CAwcW86YBjD91BkoGzBxv2+Xa01NhLarbkBmIAL5LS1+Z0PHISRts
 qFWeweyDTjUHAEKfLzxUndgQAWF/hj31/9CBmexfvfnrMxdYTtCw4vTKx1IPkVsRPqO0
 qxfQPNqeJDGhBpz8GKUJvHC+4zR46jx40P2xovNfiM7vo3MC5quVCy+HL8TmL+btZ0bl
 aZxzokiuoU9bYct/8eEuEiKRMxULMGh1JQ5+HJOygnKMaT1tA0a6sU4y9leBfIEX8Sks
 AiOw==
X-Gm-Message-State: AOJu0Ywc8Uh18dyfV2XMR+HM4ZCe2krpsGv94obwbI/eA8YPttk0Emsq
 V7tXWdIbCnh2qnP9bwmymaKLFBvF2gptPA2mQJdHO+LuvwFi4BjN/wjYkFyQfXshj8dG5LZ2tsi
 3CJ1zy0g=
X-Gm-Gg: ATEYQzxi6SV7l7dCAi7rUxsr8kjsPnLfoNsBo9jXysIzz/fFIucYZ/f4BBjVqLEmD5W
 JOOpykRGes5CGYetFuIPHieHt1nYicjd3vn+6wx79p5qgRCRE1PAYEFxYVaT13yMWutTg081WBc
 EF6mYuNASOccKQwfT/3vW6QYMHR3us6hhSPkRDr8zuaHQT7eTDAP9ubk3x0KjynNa62v+DVwmDK
 KP/Q8kE7yLFaqIOkK7wEkkFbrHtfe/RnJ7ZLjk72wBugBK8eyQNZS5LSDjojfryhKhvvcCDnI8m
 Af5d0VD0wso5BK8DLYLh9Zc5ebUieX7pWgrcrMCK6GxFFAl3SfMdwA2t5gIdDxLhBwlOkIjOZ8L
 T7OFydukQvAk/gp0TydT9kyjWZlNzLGeHQNnFFkyS+6mx5ymZZIddDufjCUqta4LW05VKThMed6
 kG60xlK6PEi65gYClKARhyqapwG/DBjIZwGI6vy0szzLsIaLfBiv+VsnYic79cUXJ/x0NXBfpPn
 WMgFQ==
X-Received: by 2002:a05:600c:c166:b0:477:a978:3a7b with SMTP id
 5b1f17b1804b1-4852696ae0emr142665085e9.22.1773009398700; 
 Sun, 08 Mar 2026 15:36:38 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae35cf7sm20495415f8f.26.2026.03.08.15.36.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 08 Mar 2026 15:36:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/49] ati-vga: Fix DST_PITCH and SRC_PITCH reads
Date: Sun,  8 Mar 2026 23:34:02 +0100
Message-ID: <20260308223433.25503-19-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260308223433.25503-1-philmd@linaro.org>
References: <20260308223433.25503-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Reading DST_PITCH and SRC_PITCH on the Rage 128 is broken. The read
handlers attempt to construct the value from pitch and tile bits in
the register state but mistakenly AND them instead of ORing them. This
means the pitch is always zero on read.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-ID: <20260303024730.1489136-3-chad@jablonski.xyz>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/display/ati.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index 8438a77de04..777a6b0a2ea 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -438,7 +438,7 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
     case DST_PITCH:
         val = s->regs.dst_pitch;
         if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
-            val &= s->regs.dst_tile << 16;
+            val |= s->regs.dst_tile << 16;
         }
         break;
     case DST_WIDTH:
@@ -468,7 +468,7 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
     case SRC_PITCH:
         val = s->regs.src_pitch;
         if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
-            val &= s->regs.src_tile << 16;
+            val |= s->regs.src_tile << 16;
         }
         break;
     case DP_BRUSH_BKGD_CLR:
-- 
2.53.0


