Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81C0FE77197
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jan 2025 08:58:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUMRP-0001SS-2h; Sun, 05 Jan 2025 03:56:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tUMRN-0001SA-Li
 for qemu-devel@nongnu.org; Sun, 05 Jan 2025 03:56:57 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tUMRM-000328-5q
 for qemu-devel@nongnu.org; Sun, 05 Jan 2025 03:56:57 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2f4448bf96fso14724141a91.0
 for <qemu-devel@nongnu.org>; Sun, 05 Jan 2025 00:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736067415; x=1736672215;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FmQmqRoZoVpBuUWMsWoA3ZXBC95hvdxu9mQlkpJR1U4=;
 b=uKpbojEg1Ur5qQJh4LcC8mk6ymO2EaN8DmY11KLgqXHVTay2G3y8Rk957Tng+ALiqK
 hSPPfE789BFHBKs8llHnPVRTlfUUrK5uvwrQuvkTQxWmma4ZVrQT7LnyEFUMivd7T2dm
 8dPSdsRqGohSL+xblC2ruaqaS5T177RqkB02+TFPsB3fpUrb62FYksioTDJ5UwhykT1E
 QSpiQQ4QhZC7bu9K/TOWeba6yiBj0Wqcthr8LLqn1yv5g3CUmSER3GRC8Pab9xaaHMrU
 MhCzXTPFSUrcW7t2WunOhch/Df8ndo5umctlrwP9bl5MpOWSS28qBWdO2pd7iQKHycgu
 LAHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736067415; x=1736672215;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FmQmqRoZoVpBuUWMsWoA3ZXBC95hvdxu9mQlkpJR1U4=;
 b=PxYCBNaL1sng79NUslv4oMSdgZYPjqs2ifkADJ2vHt5u/swxSAorrO9IsS3JGxf9qH
 VXinrtxceuLpdphI+KxMMm1fvsUc3KwbGcyXUZFWi6koMLpJurhwDby1mUzkXtdexAia
 0upe2sX118YT+WpXkZsSqN21eZwcLU9sT4wBLfvmViaaFi6venl/AhJ0Rx4YefwjhLyE
 iCju9HtShx6jAG7GXdjv/JCdaO42tEN9UMDNE/K7kN3maxpvIR7InNZYBpK8QqXevGQK
 PCQlAjmIFJUBIu0JoXi0s8CU9KfNhDdPGhrxdpVqX1TUEP2IIFhde1xiHen+7UgScTQr
 upbQ==
X-Gm-Message-State: AOJu0Yz6ccumf/07XVBzSEGZ8UqiPMuO6oTHJCrsiWblDp+eC/Fp4e6p
 1K0DqyD17ySyzdOUVqicmw8MYlcnefC8yi7BHlSOkub12gbPLkq8zQfTrTtLEMQ=
X-Gm-Gg: ASbGncvgWu1Irh8Iqpoaew1mi4iuTwoPcKkYNKqEN+R2dHDD4CNt7kzb2ZYem4bxnTj
 Yzmnk+lKcy5z0k1k5GgpC8SwLpfafzs+Mf5zKV6JAdCRmJrpAkeb+HpnSLw8h4sOwnDqcNdsjRE
 hBdu7e1KeVFBljeEWb32Duw0SDLJLnA+Ez/27EjWmqyH+JHXYnRoZD41KaD59CimbKnmHH2NDtO
 GsRdJNsTk+ADYT+/OSRW26pIacf7aw5H7diBBLowrx6uFlrNfWpb3qw9N/L
X-Google-Smtp-Source: AGHT+IFqEHZ/pf5jW+3+4HJoAdNdstOqzB+ea1JvMn5AIOlNTL6PtpsjOJsWh3kh45C92Nmj57zcaw==
X-Received: by 2002:a17:90a:c2c8:b0:2ea:6f19:1815 with SMTP id
 98e67ed59e1d1-2f452ee5eb9mr81365955a91.24.1736067414868; 
 Sun, 05 Jan 2025 00:56:54 -0800 (PST)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-2f2ee26b131sm36844362a91.44.2025.01.05.00.56.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Jan 2025 00:56:54 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 05 Jan 2025 17:56:19 +0900
Subject: [PATCH v6 2/2] memory: Do not create circular reference with subregion
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250105-san-v6-2-11fc859b99b7@daynix.com>
References: <20250105-san-v6-0-11fc859b99b7@daynix.com>
In-Reply-To: <20250105-san-v6-0-11fc859b99b7@daynix.com>
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
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org, 
 devel@daynix.com, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

memory_region_update_container_subregions() used to call
memory_region_ref(), which creates a reference to the owner of the
subregion, on behalf of the owner of the container. This results in a
circular reference if the subregion and container have the same owner.

memory_region_ref() creates a reference to the owner instead of the
memory region to match the lifetime of the owner and memory region. We
do not need such a hack if the subregion and container have the same
owner because the owner will be alive as long as the container is.
Therefore, create a reference to the subregion itself instead ot its
owner in such a case; the reference to the subregion is still necessary
to ensure that the subregion gets finalized after the container.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 system/memory.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/system/memory.c b/system/memory.c
index 78e17e0efa83..16b051249c5f 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -2644,7 +2644,9 @@ static void memory_region_update_container_subregions(MemoryRegion *subregion)
 
     memory_region_transaction_begin();
 
-    memory_region_ref(subregion);
+    object_ref(mr->owner == subregion->owner ?
+               OBJECT(subregion) : subregion->owner);
+
     QTAILQ_FOREACH(other, &mr->subregions, subregions_link) {
         if (subregion->priority >= other->priority) {
             QTAILQ_INSERT_BEFORE(other, subregion, subregions_link);
@@ -2702,7 +2704,9 @@ void memory_region_del_subregion(MemoryRegion *mr,
         assert(alias->mapped_via_alias >= 0);
     }
     QTAILQ_REMOVE(&mr->subregions, subregion, subregions_link);
-    memory_region_unref(subregion);
+    object_unref(mr->owner == subregion->owner ?
+                 OBJECT(subregion) : subregion->owner);
+
     memory_region_update_pending |= mr->enabled && subregion->enabled;
     memory_region_transaction_commit();
 }

-- 
2.47.1


