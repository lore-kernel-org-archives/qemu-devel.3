Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5B26C48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 11:05:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raw1J-0007vz-Ux; Fri, 16 Feb 2024 06:04:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1raw1I-0007ob-3R
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 06:04:40 -0500
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1raw1F-00015c-3m
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 06:04:39 -0500
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2d10d2da73dso24658561fa.1
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 03:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708081475; x=1708686275; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lSddd7wgwT+Aw6mIanqA0vHkbVR0NSdWvof0YaVRHNk=;
 b=WbTSvauYQUvypxaPw7bit1QwCQNsVWwbnLkc3pLQ68kU9yiuZL51QGjnbMpjGQgW/C
 ziDpm3zbxWJdm/MB1GDpF7+r6//ZHSuOvioOGfhD626hWVbYXbBQczQm7paG7LWidfVU
 zcWMU418X6f6M9AYr37k6OAcK+7gcUDFOqjWVHD7p5U4Can6PBstIius9Z5OcUbtV4Ar
 aVzZL2kIN32tUZqF9TncJ6EtMFOtw3wIQMy8C5g/IVxgTUbvnEiqa0BgTCmFXHdBvwly
 zmMfizwkmlqej5VHWsqe1U8xmd6pUurRXbrATufityGMy+RS30LWkOeXilgea0EWponF
 lRYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708081475; x=1708686275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lSddd7wgwT+Aw6mIanqA0vHkbVR0NSdWvof0YaVRHNk=;
 b=jGfMPCuY0Ix4gWJkApVq0mzmHlSRVetQnaYEn7k6YMUOg9ixRVXOoB+wfo2XYy2JqS
 A+i1kcjAoGmhBj8iE+Ea0adtBdOih3HYNqOxThR60BjYSnNVg0wpMXjqzM4LwXjQM/Yc
 7f2rv+0wSZERWBwWF2hnBFDvoOebVHs621cjyhdPz7OXkcHl+UzfkfaInlsKeNwnO6f8
 Uwi/C6Hf1x8sXjIeI2/qm5C+nj3SOu7DPfh+4nOw6Ce6rk6W+Oc0kq7iF5esyW0qUCQP
 Tg5gkaSnMNxfdt1lWkgv6ycqiKvQ1m0e8chjJdUOdvEGdoy5lrpByglBSpAxWlaqrn+j
 vwvw==
X-Gm-Message-State: AOJu0Yze2d0ptQVrz331EovXJQBZER48r6EAziVtewcTkHKgK7QhwdGb
 u4BzJNQ/D9CHHvphsvHKdXl7Ib1QWtZ4lMrbVbhAwhs5CreJZXfI4430CMsAv6lac7X2LE20C7g
 O
X-Google-Smtp-Source: AGHT+IGyXkQ0ouvPr+qbHCSb1OxQsk2lwXY11CCMwzwoOEGTC5K/SkLtqlf3Mj1gPHh6dxJSBguLZQ==
X-Received: by 2002:a2e:9247:0:b0:2d1:1e31:c178 with SMTP id
 v7-20020a2e9247000000b002d11e31c178mr3333201ljg.17.1708081475351; 
 Fri, 16 Feb 2024 03:04:35 -0800 (PST)
Received: from m1x-phil.lan ([176.187.210.246])
 by smtp.gmail.com with ESMTPSA id
 iv6-20020a05600c548600b004103e15441dsm2036535wmb.6.2024.02.16.03.04.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 16 Feb 2024 03:04:34 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH 12/21] hw/pci-host/q35: Update q35_host_props[] comment
Date: Fri, 16 Feb 2024 12:03:03 +0100
Message-ID: <20240216110313.17039-13-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240216110313.17039-1-philmd@linaro.org>
References: <20240216110313.17039-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Commit aff39be0ed ("hw/pci-host: Use object_initialize_child for
correct reference counting") replaced object_initialize() by
object_initialize_child(), update the comment.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/pci-host/q35.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index 0d7d4e3f08..0eb1c7034d 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -165,10 +165,10 @@ static void q35_host_get_pci_hole64_end(Object *obj, Visitor *v,
 /*
  * NOTE: setting defaults for the mch.* fields in this table
  * doesn't work, because mch is a separate QOM object that is
- * zeroed by the object_initialize(&s->mch, ...) call inside
+ * zeroed by the object_initialize_child(..., &s->mch, ...) call inside
  * q35_host_initfn().  The default values for those
  * properties need to be initialized manually by
- * q35_host_initfn() after the object_initialize() call.
+ * q35_host_initfn() after the object_initialize_child() call.
  */
 static Property q35_host_props[] = {
     DEFINE_PROP_UINT64(PCIE_HOST_MCFG_BASE, Q35PCIHost, parent_obj.base_addr,
@@ -211,7 +211,7 @@ static void q35_host_initfn(Object *obj)
     object_initialize_child(OBJECT(s), "mch", &s->mch, TYPE_MCH_PCI_DEVICE);
     qdev_prop_set_int32(DEVICE(&s->mch), "addr", PCI_DEVFN(0, 0));
     qdev_prop_set_bit(DEVICE(&s->mch), "multifunction", false);
-    /* mch's object_initialize resets the default value, set it again */
+    /* mch's object_initialize_child resets the default value, set it again */
     qdev_prop_set_uint64(DEVICE(s), PCI_HOST_PROP_PCI_HOLE64_SIZE,
                          Q35_PCI_HOST_HOLE64_SIZE_DEFAULT);
     object_property_add(obj, PCI_HOST_PROP_PCI_HOLE_START, "uint32",
-- 
2.41.0


