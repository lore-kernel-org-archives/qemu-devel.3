Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F4EC28B28
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 00:10:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trQfn-0002Ax-PI; Sun, 09 Mar 2025 20:07:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trQfl-00029a-SJ
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 20:07:09 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trQfj-0007P0-JU
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 20:07:09 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43cef035a3bso4986095e9.1
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 17:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741565226; x=1742170026; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=erRrSHMQeC5BJ4//qt9VD1yvOjST1dyAioJ5r7a/Pw4=;
 b=s4lh0pR2Iet4mZM8ga22CVeDPbu3VEUtsJU84T6ZkwVKlT2MA8aK8P1dRistp2W7sp
 8AAU948Nt8rs0uA5Ovksyw6uzJotRSVAXKD2QIoSLfe6UV59t7BqHGrCoiDjiYgSheSa
 Wnymz9m8W4Pt3EMGA+dh+vqTwV+5KqI0pZNGsr54taPQ9+swlpP4+ozBvGgujQ7TDxJ7
 d5AbUubSs8pVWaKhqXvVpJgmOKRsyAp38DTN2KqeQH/tDGjwknZpUtxw7/+sRcu2utji
 wdpesBrG53tXOrFmnm/3rptQGQfby/Dq+buE4bpVbAY1CdSi4K1wW2Wl20C17N9iYT5a
 4ApQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741565226; x=1742170026;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=erRrSHMQeC5BJ4//qt9VD1yvOjST1dyAioJ5r7a/Pw4=;
 b=nDea/5mN5ilwP3xz+UT5mCzLfWdMYx70jrnPsByjjlzJd9sFC7n7FWQ68MvsTygLaW
 B60OE0ds55/L8zJASlaqYNhbgfK2PBSEJRKc+AYPJEd/dhtamnYEyCrkmdfgpwz2k5ca
 qfNefa59tQjR0lVSb/XVA8quLSvrM7KP92ub4dXHY7ZwM1+cbklCPyv4bWYUjzi4mmAl
 JUkkJ1AjTHfBvTRqG2/nMjjw5aajjHH8zKHBkVMt5n+oNVYwp4pD/4dgKUv0aTTYVjsl
 DOhXnhzpfAy3MCYMKR0JoJnav2kemQbhpU8d72pnkt+jjSzxqwu95ELiIZzTq+SwIp9l
 OhaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVu445G+A7h6UN30j0rzOnB50/MNKBh5TOWaLK46Rp+9wbE93djZe7yiO6K1KjGpArEHhjLI0djrKOE@nongnu.org
X-Gm-Message-State: AOJu0YxCSmRI1yuIu0Z8R9AcbNkidHz4BHbrwMkRYVrCic9unmMUq+B7
 1ShARk1oZ35zotbpjAg1ktf9P5LQ0AF7q7HHVybYiJ+hJJot0vdLLVajb9uAxzg=
X-Gm-Gg: ASbGncvngxrp36Zttn0vAFxGA7KnCPG1S+JV/3GZCs3Innf0z7U778btpkc2OlUvXq7
 Zf01bUTfSsYCuZFrm5N8ZtkcOnYTPvLZxwbVgx84SEwG3iUfO9G/wQG88dHoJYOLHcbW9sxtwGO
 o7qv/713koiVaZKLRDljgKBoqKw8F2EA27RMBwDwg1lhmaUJBqlgDkuwIrNPsj8Be8wU1uj8rn+
 lYRr8PW4vkMYvcGti7tBdkmgacyEPK//YnN54qeOXOlLs4FgIlzdtplXxa+fXauRN1HZT7ssdYS
 Z+cbHvZrSHsMeT2VCW2IilzuW+01NWCfpN9aiigDKK9/N7Oax2Df8JmiZKTDIzPtx04C+0yAwOj
 3qeQZ0xf8UsbuDb1sbpRISvV2anN9yw==
X-Google-Smtp-Source: AGHT+IFoUKQN3o8/uk5fDCkuNHeQN81/vS5tNxy9v1yzDrZ1OFvhclzk6VdjfEEq91eND2ZCZqjdcA==
X-Received: by 2002:a05:600c:3544:b0:43b:c878:1466 with SMTP id
 5b1f17b1804b1-43c601d94f1mr66442495e9.8.1741565225940; 
 Sun, 09 Mar 2025 17:07:05 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ceaac390bsm60613665e9.35.2025.03.09.17.07.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Mar 2025 17:07:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: BALATON Zoltan <balaton@eik.bme.hu>,
	qemu-devel@nongnu.org
Cc: Steven Lee <steven_lee@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Bernhard Beschow <shentey@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Guenter Roeck <linux@roeck-us.net>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Troy Lee <leetroy@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org, Jamin Lin <jamin_lin@aspeedtech.com>
Subject: [PATCH v5 08/14] hw/sd/sdhci: Make I/O region size a class property
Date: Mon, 10 Mar 2025 01:06:14 +0100
Message-ID: <20250310000620.70120-9-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250310000620.70120-1-philmd@linaro.org>
References: <20250310000620.70120-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Be ready to have SDHC implementations to cover
a wider I/O address range.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 include/hw/sd/sdhci.h |  1 +
 hw/sd/sdhci.c         | 10 ++++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index ee1e7ef4b10..dfa0c214036 100644
--- a/include/hw/sd/sdhci.h
+++ b/include/hw/sd/sdhci.h
@@ -118,6 +118,7 @@ struct SDHCIClass {
     };
 
     uint32_t quirks;
+    uint64_t iomem_size;
 };
 
 /*
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 570d825d130..3467385490d 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1444,6 +1444,8 @@ void sdhci_uninitfn(SDHCIState *s)
 void sdhci_common_realize(SDHCIState *s, Error **errp)
 {
     ERRP_GUARD();
+    SDHCIClass *sc = s->sc;
+    const char *class_name = object_get_typename(OBJECT(s));
 
     switch (s->endianness) {
     case DEVICE_LITTLE_ENDIAN:
@@ -1469,8 +1471,9 @@ void sdhci_common_realize(SDHCIState *s, Error **errp)
     s->buf_maxsz = sdhci_get_fifolen(s);
     s->fifo_buffer = g_malloc0(s->buf_maxsz);
 
-    memory_region_init_io(&s->iomem, OBJECT(s), s->io_ops, s, "sdhci",
-                          SDHC_REGISTERS_MAP_SIZE);
+    assert(sc->iomem_size >= SDHC_REGISTERS_MAP_SIZE);
+    memory_region_init_io(&s->iomem, OBJECT(s), s->io_ops, s, class_name,
+                          sc->iomem_size);
 }
 
 void sdhci_common_unrealize(SDHCIState *s)
@@ -1548,10 +1551,13 @@ const VMStateDescription sdhci_vmstate = {
 void sdhci_common_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    SDHCIClass *sc = (SDHCIClass *)klass; /* No QOM cast check due to union */
 
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
     dc->vmsd = &sdhci_vmstate;
     device_class_set_legacy_reset(dc, sdhci_poweron_reset);
+
+    sc->iomem_size = SDHC_REGISTERS_MAP_SIZE;
 }
 
 /* --- qdev SysBus --- */
-- 
2.47.1


