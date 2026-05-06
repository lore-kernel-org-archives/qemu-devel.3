Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36F4FCD3442
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 15:23:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKe5j-0008Gc-1m; Wed, 06 May 2026 11:23:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <munkhuu0825@gmail.com>)
 id 1wKe5h-0008GK-EB
 for qemu-devel@nongnu.org; Wed, 06 May 2026 11:23:13 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <munkhuu0825@gmail.com>)
 id 1wKe5f-0006yi-6U
 for qemu-devel@nongnu.org; Wed, 06 May 2026 11:23:13 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-36505450d0dso5086789a91.1
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 08:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778080989; x=1778685789; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RW1nafJmwXfg+AxhDXN24jZEiFjt3xSnoItD1s8MvLY=;
 b=lQoKv+AIh1xUrbHwQeSlwEjsqnskD8OdBQTQ73cJIKywga3d1sj0Ue1est8WxhGzzN
 TtbdmBwp23u+LKcm4l/lW2/C/hHexuBPwp5k4iD4YAJZk/1hoZYOMugGQTRsWJmj3+iJ
 LUUzg1MZ4jywG1uLzbb4wjq6aOjsPGLhRmE0EGotsOSsP+rfs7V/zWAAVr+Oofjq+F+l
 0neANPgus6HOSPYzL+dyNEO+l/MrTfgmeyFxx6aR4h1vD3HUlcV/YXw5+vtt4WB3lGaY
 2JOCzoQ2KAOJbJkVPaoNDG0wSQ29jbdjVmQu1TxPsZmhtqQNDyzQefyIBTQMWbV+Hf0A
 mQqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778080989; x=1778685789;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RW1nafJmwXfg+AxhDXN24jZEiFjt3xSnoItD1s8MvLY=;
 b=lVcNRP0mOGi+lpFJqOly8xJ9AoWg8wa7wHJLNfc4N6jkt8hcQ4mrx55LA6AN3PS2Lf
 iaystRu0+vlDlaGtFG2RINFDSI/hf8gi1SL46DkfIbzDZqtpZn5DXWt+QPWmfiPrCL7b
 xJpNhLY1Uwp9gMkstGU4kZkSfhp8tMS8J5d5JABH90r9+78xhE689t2nH/hwwh2toN6U
 nsNOxemnh7HHVoxtEfNOlTOx9hKqF3qN4lv0dkb8un2I9Uq0s70xs8C8ckINCRZBALoz
 p6yjAp/TpT5/qNN4LSPVN9b4jhHiEOWT/GR9c6ounGEOh7+87vu3Pq8woXXPeRvgW5PW
 IBAg==
X-Gm-Message-State: AOJu0YxUcBHrNAux+01Bl81EefcumupVFoVMVocBqtQpW8XunglLiWDq
 Wpp+9cXji4sqhV3OBt2qaD//KVnCJAOfO32iylS8+DwN8QPL7re220CkR8ofAOfzYE4=
X-Gm-Gg: AeBDiesUpgv5scWrkDG4j5CWUpYYow6XpISiYIThjWzqAnmxWjyttNSVT0O9zrQTE9D
 YZYt55aEBGAVzrGQY3PPznpDUIyfZZZYLeB7PR1OznJB1Uouo7rN0LJdM3dlRq+o4u2QwEbHEv1
 LhETyRWSGRKJlyoaiZAjVRGF7NaoJQVCrAkFsnfQa8RLOHqmljd0J6cq5uvlVoTo0Ua41UBmXNg
 aAB4+b/K/4O7Qt0+3a35sEn5ddZPLxPx2rcBDamOID4w3jxoZQ35jA1CbOoqp6Z66S/3ayEO5G0
 ppdYcBfvzIPe5kIhS6M04/M3GVNY9s6P7q1FQfTK3498gwDu3o5yoWcxB3V0o6FmkUBCWYMkvRp
 AjqupzHuLeqLKjXWi9mGAC056BN2FhBCrE4e+ioKSCHM/lT2KoaSKwQ3TNQmcKmXIoHJ+gYH+Kz
 i3rs6aOxGje2QFl9vL3TrT1/V1skuiAlAfBNzq7HQkx+3wvsxABI62f1TNoSqvTjPP+aVFArp1a
 w==
X-Received: by 2002:a17:90b:4fcd:b0:35f:b6d3:da7a with SMTP id
 98e67ed59e1d1-365abe8a3f2mr4037221a91.15.1778080988857; 
 Wed, 06 May 2026 08:23:08 -0700 (PDT)
Received: from localhost.localdomain ([2407:6400:c000:f1c:edf4:b0bc:edd7:a9ab])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-365b4c8a8e7sm3800052a91.13.2026.05.06.08.23.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 08:23:08 -0700 (PDT)
From: Munkhbaatar Enkhbaatar <munkhuu0825@gmail.com>
To: qemu-devel@nongnu.org
Cc: Munkhbaatar Enkhbaatar <munkhuu0825@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 1/2] hw/usb/hcd-ohci: Assert isochronous TDs are never
 deferred
Date: Wed,  6 May 2026 23:22:46 +0800
Message-ID: <20260506152247.82336-2-munkhuu0825@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260506152247.82336-1-munkhuu0825@gmail.com>
References: <CAFEAcA93342r1oKDBDv=7LRoAqT4WpVEqRpb-ThM=OjJUZm=BQ@mail.gmail.com>
 <20260506152247.82336-1-munkhuu0825@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=munkhuu0825@gmail.com; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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


Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Munkhbaatar Enkhbaatar <munkhuu0825@gmail.com>
---
 hw/usb/hcd-ohci.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index 6ed8046fc2..8f4de0066e 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -746,11 +746,10 @@ static int ohci_service_iso_td(OHCIState *ohci, struct ohci_ed *ed)
     usb_packet_setup(pkt, pid, ep, 0, addr, false, int_req);
     usb_packet_addbuf(pkt, buf, len);
     usb_handle_packet(dev, pkt);
-    if (pkt->status == USB_RET_ASYNC) {
-        usb_device_flush_ep_queue(dev, ep);
-        g_free(pkt);
-        return 1;
-    }
+
+    /* The USB core guarantees to never defer ISO TDs. */
+    assert(pkt->status != USB_RET_ASYNC);
+
     if (pkt->status == USB_RET_SUCCESS) {
         ret = pkt->actual_length;
     } else {
-- 
2.50.1 (Apple Git-155)


