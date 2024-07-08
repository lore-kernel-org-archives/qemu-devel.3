Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA2AAC41513
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 06:57:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQiIG-0008RH-1M; Mon, 08 Jul 2024 02:56:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sQiID-0008MT-16
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 02:56:09 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sQiI8-0001ol-Ve
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 02:56:07 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1fa9ecfb321so19386895ad.0
 for <qemu-devel@nongnu.org>; Sun, 07 Jul 2024 23:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1720421763; x=1721026563;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vIEfURKz+p1ePfxL4ZyEDkPLusmBWgHYvO+HKUIo2A4=;
 b=LmjHWBlO0E68jEEnjnYdjJw9uvaMgZFhlu7gNIeq5sw54fwmP8EsPWe0gT9I6dxSzX
 Uf3NX9t7DJMRxfYQRF1zPvx5klkbH1kVo+YuJYcQYpbUOeFE4m7uDAv7opwK0Rx8/wY0
 SqWSJCA/2YwhdHFuk+KyAmInJBhBOyks/7n9JXhqE72nUEPpwsAt/Z5MWqyP/lxiGj5a
 XuXuLSn/qBievx9QPUP72JBlMwfZQGCmRZB2/buGGvM6Wrv53LqbMqDcvDw4k9tNHBOQ
 nL8Z23ylDe/bRELvMRI5WyN/ySP5rjLbZS2N/H2NlNlbgbLNh+KK4Bx0Cnt9EdDrZ6gL
 B+bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720421763; x=1721026563;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vIEfURKz+p1ePfxL4ZyEDkPLusmBWgHYvO+HKUIo2A4=;
 b=lZZvj1Kctcm2RBtINKmlYDWpJ5tlYIGzR1ZGfsOlgIr5ED6EwpjXiiTYb9aYwAGtxt
 NyGGr5Qj49yMRGqkOoSP5iiWKbA4YMdOkYQsBQPZnx4gdgQzt4w6OxPOSwT/7e3HW5/2
 IPVWd3a1N/XobIXxOYumESqYi6dTKRM7UagMCmn5MG0//zlc7/cjH7J4H0tsS5sLygHy
 vI2C9zl5vf7eo/RYAKEBiMsRnpmM2uze2bbFcHY+IzAfJQ4WMSK5cMm4duYisK/N7SEg
 zk+Q8D/+GGJ0OonigVQ5w+/2j6u5z9yK4FtkabKF6j5TQ9UogEe3ppSSoMvpx2kbshI9
 pFTQ==
X-Gm-Message-State: AOJu0YxfuME89uiXRbOoU8RxQkgajgvgIMquVLMrXOx/ZB8sus7MnmNh
 Qg+riGO5GfHfyDxQpoNU6vRB7BiWVrF556T441gqu1nYZuGlZ3W56ARS3rW486M=
X-Google-Smtp-Source: AGHT+IHaHLFdVS3j6x0yV/mu2NdS069vJVNaVFKSSEeJYUo+CXcbTb/uvUGc5zl46xXmYEn41lnNAQ==
X-Received: by 2002:a17:902:cec4:b0:1fb:72b4:8766 with SMTP id
 d9443c01a7336-1fb72b4898emr28292685ad.49.1720421763375; 
 Sun, 07 Jul 2024 23:56:03 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1fb438a7890sm57605205ad.185.2024.07.07.23.55.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 07 Jul 2024 23:56:03 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 08 Jul 2024 15:55:13 +0900
Subject: [PATCH v3 2/9] ppc/vof: Fix unaligned FDT property access
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240708-san-v3-2-b03f671c40c6@daynix.com>
References: <20240708-san-v3-0-b03f671c40c6@daynix.com>
In-Reply-To: <20240708-san-v3-0-b03f671c40c6@daynix.com>
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
 Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Peter Maydell <peter.maydell@linaro.org>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::632;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
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


