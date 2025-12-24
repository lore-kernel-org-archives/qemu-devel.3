Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DF3FE776C0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 16:16:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYRWR-0002Lc-Du; Wed, 24 Dec 2025 11:15:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRW6-0002GN-4I
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:15:15 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRW3-0001VA-IT
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:15:13 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4775ae77516so54960675e9.1
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 08:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766592910; x=1767197710; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AuNDL5oqr1HBVF8J41qriSJKpqYUj2HAsQkBmVSSoO8=;
 b=fssgFw921AWc8lALzKPjKYttlh0gmzkJ3La52V4vFwLsgsS8nt18MFhG0Tphh/ZVhL
 L2ETFI6MD9QW1D/1BZ7S2oU8XvHaziUmX8lrIKeyQGmMPm2qy+vpsuAkC6sSeiHottgL
 2mCg05SG9a3hMc+1QDnefAC2/4CEmh3K+LLXznhS/S9cVZSwzIfDHOB8RDJxI3enWrrU
 8E/S8k5ooXOj6V0xZgN3vANr5AmUK3ZwAy5CH+z3oPRIdA8MtoNcX+YjsfmTzs9U9mjZ
 zHgY///B2WAci1yvr+lMKuE6PZOvQAYTRfRGBHycqAUe7fKNPG2bqwHDAkC/skYt7MnJ
 J8/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766592910; x=1767197710;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AuNDL5oqr1HBVF8J41qriSJKpqYUj2HAsQkBmVSSoO8=;
 b=hkuGURL6RAjljIe14oVu32g2frgLnvSSlWTiYk8DBMeyqatg8VS2RN8TpOqX0oI3KM
 4pYq9eBziLl+tPcYWe9LYCbPQ3eB87gbX/6XFvDCjloQ8tYw8S0o0ectfgV82EJdKUHD
 IUBkE2JJ8pQEzND726D+6AdHI8gaNtJxl8qesg07wmMefars8gsltTKe22kGMBWHu9W7
 1DXt9LlUWAjdxmJSP6Xta11b3KxqEMl5I3XSIiEpb3vV/u3+XvLRgJ+XrjOqOjSGJbvM
 fg74IQn1C7v7j31mVMevn9swiMVQPJOAdOj2Yxc6pAYwKiBmDdj9uBReqZaezBqrwZGn
 0U2w==
X-Gm-Message-State: AOJu0Yz6PPglq1gB4vV0qTyRbAl2m1rZ77xRx/+d6WSbHyj8lo6x4Rqu
 P6xBtvCsh/ShsSrsXX7D1pakLT7XounrrPbc4XjHOrlkFteEdkg6FFiJXwr5qqwQFF43Xp+/ZCU
 CIyKRE/s=
X-Gm-Gg: AY/fxX6IyirHKrUiPaP/8xNwO6gwQ1QcCB0NTOuaXO0CU6bfdZy8O2rNJ15aCsU5qPm
 u6F0NGBGl8KMxXKLrj75Attt7t5sWMDyTI+a3ZmV7IAdG71DiV3bfacgAzYU58UAaFSo0tJCLpW
 /JseN42rsC7IrRrFuVutSZw6vNChMaF2ebCcGw5O3U2Bt0TPOJ0tBty1qEFjzFr7BMSSZURihS6
 hpyghG489LbG9one3BtJdOoQ7IupRrjGYqOihuzmenTw4EeauNP9zbMg5a4iO9sl5926b386vlG
 /zN/XPk6ZY+JVs9ohC86fD5XGkkRo81dl9OE1WWO/jvIY5rj/zMRxlWoQ/whjjFsP1YPMNy0xjU
 dCrDYLUBqwwRvv2SdY56OjCqMFydsFv+NdNGC+pOJXh3lU28AGWZeprR9crxcmLG0NkcY3GGaXY
 X6543B4lKPAu/Kcy/63SnOV5ohEzBF6RxQpx8XBLqdCmoZ+K9cUA56/CM=
X-Google-Smtp-Source: AGHT+IEAuWV4OolmTdgfsQwUiDkpJ92iupFWAPYEPAG0cJivtefMBqzDS+haZyN+8NtkwTuozwc94A==
X-Received: by 2002:a05:600c:1c1b:b0:477:9976:9e1a with SMTP id
 5b1f17b1804b1-47d1956e545mr199408825e9.6.1766592909642; 
 Wed, 24 Dec 2025 08:15:09 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be272e46fsm346979985e9.4.2025.12.24.08.15.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 08:15:09 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Anton Johansson <anjo@rev.ng>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/8] hw/loongarch: Use explicit little-endian LD/ST API
Date: Wed, 24 Dec 2025 17:14:49 +0100
Message-ID: <20251224161456.89707-2-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224161456.89707-1-philmd@linaro.org>
References: <20251224161456.89707-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

The LoongArch architecture uses little endianness. Directly
use the little-endian LD/ST API.

Mechanical change using:

  $ end=le; \
    for acc in uw w l q tul; do \
      sed -i -e "s/ld${acc}_p(/ld${acc}_${end}_p(/" \
             -e "s/st${acc}_p(/st${acc}_${end}_p(/" \
        $(git grep -wlE '(ld|st)t?u?[wlq]_p' hw/loongarch/); \
    done

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/loongarch/virt.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 49434ad1828..2a0e225d813 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -607,9 +607,9 @@ static MemTxResult virt_iocsr_misc_write(void *opaque, hwaddr addr,
             lvms->misc_status |= BIT_ULL(IOCSRM_DMSI_EN);
         }
 
-        features = address_space_ldl(&lvms->as_iocsr,
-                                     EXTIOI_VIRT_BASE + EXTIOI_VIRT_CONFIG,
-                                     attrs, NULL);
+        features = address_space_ldl_le(&lvms->as_iocsr,
+                                        EXTIOI_VIRT_BASE + EXTIOI_VIRT_CONFIG,
+                                        attrs, NULL);
         if (val & BIT_ULL(IOCSRM_EXTIOI_EN)) {
             features |= BIT(EXTIOI_ENABLE);
         }
@@ -617,9 +617,9 @@ static MemTxResult virt_iocsr_misc_write(void *opaque, hwaddr addr,
             features |= BIT(EXTIOI_ENABLE_INT_ENCODE);
         }
 
-        address_space_stl(&lvms->as_iocsr,
-                          EXTIOI_VIRT_BASE + EXTIOI_VIRT_CONFIG,
-                          features, attrs, NULL);
+        address_space_stl_le(&lvms->as_iocsr,
+                             EXTIOI_VIRT_BASE + EXTIOI_VIRT_CONFIG,
+                             features, attrs, NULL);
         break;
     default:
         g_assert_not_reached();
@@ -665,9 +665,9 @@ static MemTxResult virt_iocsr_misc_read(void *opaque, hwaddr addr,
             break;
         }
 
-        features = address_space_ldl(&lvms->as_iocsr,
-                                     EXTIOI_VIRT_BASE + EXTIOI_VIRT_CONFIG,
-                                     attrs, NULL);
+        features = address_space_ldl_le(&lvms->as_iocsr,
+                                        EXTIOI_VIRT_BASE + EXTIOI_VIRT_CONFIG,
+                                        attrs, NULL);
         if (features & BIT(EXTIOI_ENABLE)) {
             ret |= BIT_ULL(IOCSRM_EXTIOI_EN);
         }
-- 
2.52.0


