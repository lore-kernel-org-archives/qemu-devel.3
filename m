Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AC16F9936D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:32:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFrKl-00012H-K8; Thu, 23 Apr 2026 06:30:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wFrJo-0000ZK-RN
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:30:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wFrJm-0005OB-Dv
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:30:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776940197;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mvlY+/LRKuKta0O23HLcvzCcFpZOHfGgT1RnwB29Db0=;
 b=IT2TciSvweJsP9h5y7cRP0S5Y88wb4dUjGrC/JLuNhoqPy25+UoQ1ImEz6guU5u59fgiDH
 Bogu861GQh93t2xt4rW2YqryL0P/nWr9XR/3sS7kwIfN55LiiePVHaM4jHHnT0A59R60Cl
 rYdX6KIPycNn3ukomq0k4I3qb8tZ36A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-294-YsPCU3-gMaGhBYkuzFcYrA-1; Thu, 23 Apr 2026 06:29:56 -0400
X-MC-Unique: YsPCU3-gMaGhBYkuzFcYrA-1
X-Mimecast-MFC-AGG-ID: YsPCU3-gMaGhBYkuzFcYrA_1776940196
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-48a5775d647so25606155e9.2
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776940194; x=1777544994; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mvlY+/LRKuKta0O23HLcvzCcFpZOHfGgT1RnwB29Db0=;
 b=bUoBNzKJC1g5u/cuSQakEISvayEhXxRA10CkoFOPnodB75dKCrFhecOZcRcefNxsDy
 uAaUX0D/IE3j2OQY1Pj3u7JsyIDnbdzxuW5fzdBrvLB8bNuPY0v5TOWb5Xy8UW27Wsik
 Ff27jY4lb1Je/zs8EzaFadftlCplIxJM4cMf8A9zRvIlVmEoqcBxfdtDAkyTUaqBFSU1
 P3qS+GmPNlns+XqTmWdDKKhcjCCuezbcQ2tiT45WfPAI5Jhw+8Zn6b6B9O8U0Jhbf3Je
 shh6tYhhU2dyqSTvbj2NdeHFy89gpEjIGEsirTdDTPLf6tr0E5P6NHXHWNOQdj3bJQzD
 LV4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776940194; x=1777544994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mvlY+/LRKuKta0O23HLcvzCcFpZOHfGgT1RnwB29Db0=;
 b=KViiNj4T+dmEEobNKG9For/3DKKeZjqpDReYJPR8ygCeUzItH8jdYpXc1FvoPgTgFt
 wevl8mrMiISXxCZ5D7ZY6lNJvbm5JUGgHbOC3jg0fGTCUAMSJfCjSgs/cFeIOr3ymlFS
 VSUXc1t1uBOSyytS0G8SUbFqcRybhJKWykU/lahviBVxx4HcPqQw2b+8ga8/PY7JsfJn
 FGIFtXZIIy9yuMNFoh2nBoAEb/8HJutAdtjjVHdgelITkUeBqSD5TIH/wANywDXYfoen
 lqEMzlxZ44XcgEU6ba/OVQbNaHEBuDQtJmo0QPq9bl5zuFZ+urB5gcuOJHj6dsSKFxRI
 4aIw==
X-Gm-Message-State: AOJu0YxWU7G7wee4H0ZDp442IFGb4JMOhbLnsA2IV81OiAXiLka7cpuS
 daI+9QM5VC39KAo0gK/+RJAzYxby5A6dvxXTaCUukreIeaTYIXksh8SieZcWvLBkOpTVJZxkmAM
 PZnqwsIdyRu1W66brIb1u4z8EFLjMhTMOzIwWdCYxcXTN6gEU3kYM39DSa1QIHelBpqZJc3sr7m
 yc/7l3RM+Judr5jq/zXn1Q2vVsWYNIrngFXKUUyamv
X-Gm-Gg: AeBDieuwPAEY8+qQnd4XQ5WlXc5bQRQBJi0kmie0dxSTBO7UuEp2kcLkAx89D3IptR5
 JHoY8VOHv3FK8BvmBCG3Oyje84OEVzek+WLLF8SesAuiSxAGlcBYJ2l6I/sONsJmEX1LEOIwoeG
 7UQZMoxWnrV2FaQfx6MKP57oUSi5X+Nf+e0ulNtysjCV5/JdPPMbUz1cUAAx932j0UHxGfPVxgF
 WyIYtp5nqtRUmUTptVLYzGbqugOxL6MQY0GXFaF6ePleeK4COeW/gE25uj2cl8PS+ug2HwVLeOu
 SGpjU2wEz3Or2pFZzAzKKXH/O9K/nZhu636J+hiRhT5D/dmPtbyG3SpwggLeUMP3OZeG+Xx8++L
 NXTwwQnNOsieySQnz9rSBShSKQtxsfz7ON0MRLxAjXsnyJTpJs/n8AJWkC2CBrUcv7q5rLSXy7q
 3h/V4Tyd2byx9QU/B4Xy79QeGvIyFsjIJ6j8c=
X-Received: by 2002:a05:600c:4ec6:b0:489:1f98:71e3 with SMTP id
 5b1f17b1804b1-4891f987487mr225663325e9.28.1776940194589; 
 Thu, 23 Apr 2026 03:29:54 -0700 (PDT)
X-Received: by 2002:a05:600c:4ec6:b0:489:1f98:71e3 with SMTP id
 5b1f17b1804b1-4891f987487mr225662835e9.28.1776940194097; 
 Thu, 23 Apr 2026 03:29:54 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb74c789sm152488885e9.5.2026.04.23.03.29.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:29:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 11/25] target/xtensa: Use glib2 instead of
 strcasecmp/strncasecmp
Date: Thu, 23 Apr 2026 12:29:08 +0200
Message-ID: <20260423102922.443639-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423102922.443639-1-pbonzini@redhat.com>
References: <20260423102922.443639-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Kostiantyn Kostiuk <kkostiuk@redhat.com>

This is a change in semantics. g_ascii_strcasecmp() doesn't honour
locale but strcasecmp() does. But this is OK for at least one reason:
 (1) QEMU always runs with the C locale so there's not an actual
     behaviour change here

Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Link: https://lore.kernel.org/r/20260327134401.270186-10-kkostiuk@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/xtensa/xtensa-isa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/xtensa/xtensa-isa.c b/target/xtensa/xtensa-isa.c
index 630b4f9da1b..c564af340fa 100644
--- a/target/xtensa/xtensa-isa.c
+++ b/target/xtensa/xtensa-isa.c
@@ -370,7 +370,7 @@ int xtensa_isa_name_compare(const void *v1, const void *v2)
     xtensa_lookup_entry *e1 = (xtensa_lookup_entry *)v1;
     xtensa_lookup_entry *e2 = (xtensa_lookup_entry *)v2;
 
-    return strcasecmp(e1->key, e2->key);
+    return g_ascii_strcasecmp(e1->key, e2->key);
 }
 
 
@@ -513,7 +513,7 @@ xtensa_format xtensa_format_lookup(xtensa_isa isa, const char *fmtname)
     }
 
     for (fmt = 0; fmt < intisa->num_formats; fmt++) {
-        if (strcasecmp(fmtname, intisa->formats[fmt].name) == 0) {
+        if (g_ascii_strcasecmp(fmtname, intisa->formats[fmt].name) == 0) {
             return fmt;
         }
     }
-- 
2.53.0


