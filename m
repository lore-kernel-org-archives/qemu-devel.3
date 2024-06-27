Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE726C41513
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 13:39:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMpKx-0001Ek-Kj; Thu, 27 Jun 2024 09:38:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMpKw-0001Cw-8t
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 09:38:54 -0400
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMpKr-0006Qe-6T
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 09:38:53 -0400
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-25d5333989dso1256777fac.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 06:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719495526; x=1720100326;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UtuCMhxUWw1DUkDzmxPc06M4yVAzJqdA967oAcSFqUQ=;
 b=F1dG3X3TWPB9MXJKsI7+ya5OpeWHWBLL17c5SmjmZ76jc3XRALRPlsyyqqoCV0RM0j
 FnY2hLEAiMpBP2hfUnEZLtibcTvC/iX8v0wef5P6iDuChmKG5HrlCMjCfQ8b1+nNkK9o
 CyqPFUIlT3EIwXOEyQOxyloxcLwfvAVVEFWLxZmOrxgFxaKDm/unbVI1MhsO4qBuqE2u
 aXBOw2M14si5rxZVDKuUsCdhYBqtvTIscjlvAVK9/stpjSxe7upnftCFRSu2KUhsDlrj
 fLxAvkoFJaZoo2o4XGEw7l/pPObHJ0oRbCoScoi4rAJd2zDpJWb2vg7WhLNpK6P3HfVr
 QZOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719495526; x=1720100326;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UtuCMhxUWw1DUkDzmxPc06M4yVAzJqdA967oAcSFqUQ=;
 b=v9uqnYBMbfpktqK2rT6us8vLRDnQbvps85d2dxzxPyUWSu3NOWJLpvcd7cjifDWTLW
 wM65DKkdvxOcQI4F3/onsTPGY8xpnZQog87111aLsPPKlMcjT4ja9fje52w/CinLyVMC
 O/EHkBnzA1R83T8DvW0ANNor0/qgBb9rLD7rREZZJwDR9wH3NLaCg9sNSl7wXQpkXhbM
 tMUwlmIBznJ/eL/lYekvgfs+KJpuamQbaLGdHukw6v2Z/cRC5s7Xr+YaW+ftntVPJ+XO
 kVMLKTdOazbYL5Avnl8liIERZMYQcW2ycxlhGfKPenYIiH8DzJ2VcFS3fzdAbCVvvgRm
 4klQ==
X-Gm-Message-State: AOJu0Yws1b2mcMPzx3I7FhLdmjI4VCs8BjCXhpnFpbKWXdapFpzVwr1S
 hB1E73gOCCkUF/Qp2LztPSM4uhd9dBuHjfMXgQMj8hjDJSdUSLzMywWuGWqOHLk=
X-Google-Smtp-Source: AGHT+IE68QrvJItc29/tXsB2hhrn925IlwaD+nMu6WIGfpGM9AqZp/e9DNODXCKlCLfsXKLgBm7gVg==
X-Received: by 2002:a05:6870:9692:b0:254:c27c:1b19 with SMTP id
 586e51a60fabf-25d06ec3501mr16894009fac.54.1719495526263; 
 Thu, 27 Jun 2024 06:38:46 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-706b491c898sm1333327b3a.77.2024.06.27.06.38.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jun 2024 06:38:45 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 27 Jun 2024 22:37:49 +0900
Subject: [PATCH v2 06/15] ppc/vof: Fix unaligned FDT property access
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240627-san-v2-6-750bb0946dbd@daynix.com>
References: <20240627-san-v2-0-750bb0946dbd@daynix.com>
In-Reply-To: <20240627-san-v2-0-750bb0946dbd@daynix.com>
To: Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>, 
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 David Gibson <david@gibson.dropbear.id.au>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alexey Kardashevskiy <aik@ozlabs.ru>, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2001:4860:4864:20::35;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oa1-x35.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

FDT properties are aligned by 4 bytes, not 8 bytes.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/ppc/vof.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/vof.c b/hw/ppc/vof.c
index e3b430a81f4f..b5b6514d79fc 100644
--- a/hw/ppc/vof.c
+++ b/hw/ppc/vof.c
@@ -646,7 +646,7 @@ static void vof_dt_memory_available(void *fdt, GArray *claimed, uint64_t base)
     mem0_reg = fdt_getprop(fdt, offset, "reg", &proplen);
     g_assert(mem0_reg && proplen == sizeof(uint32_t) * (ac + sc));
     if (sc == 2) {
-        mem0_end = be64_to_cpu(*(uint64_t *)(mem0_reg + sizeof(uint32_t) * ac));
+        mem0_end = ldq_be_p(mem0_reg + sizeof(uint32_t) * ac);
     } else {
         mem0_end = be32_to_cpu(*(uint32_t *)(mem0_reg + sizeof(uint32_t) * ac));
     }

-- 
2.45.2


