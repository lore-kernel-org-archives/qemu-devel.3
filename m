Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A172FC41513
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 06:57:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQiIP-0000c3-NZ; Mon, 08 Jul 2024 02:56:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sQiIN-0000RK-H9
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 02:56:19 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sQiIJ-0001q5-JI
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 02:56:17 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-70b0013cf33so2235463b3a.2
 for <qemu-devel@nongnu.org>; Sun, 07 Jul 2024 23:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1720421770; x=1721026570;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dYsCw1FmqSn/YuppQ6AhBdpL7b5hTddKWxjDOuy7dBs=;
 b=oyMsnlPmLQtNJLkmP55dvZl1kcbPpJMT5UANwbJO7TdlwwE+ma1zHDhTBM7o2lJVWG
 /Xd1WpMAO5LQ5plbqETRc8/9wN427dFQrsOxqRhAglRku4eqbmhpsyK2iwRQUoLEdCVo
 STytmkgkcG7aYf+JVHuk5NJCUSmdSBc2ywuknuLujksdkfFZWAHUr25I1Bo89aMzZiMe
 8ScHw6aaO8OgysgxK1OlGNSILxnzeUh+pQjmOIRZgms4SYNV5HWy/bSKByfYXJmp6To5
 oYD7uPZpqFWZ7+6RfEOv/T1M01GNJYKQVdVZGBvRyasdVxIEMX5LxFkg4nhosGsOYs2+
 enSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720421770; x=1721026570;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dYsCw1FmqSn/YuppQ6AhBdpL7b5hTddKWxjDOuy7dBs=;
 b=ei8Z9hJcfxRcBBs/I5ixXbmV9LUSO9/D7p+StvPEVDiO7PCxQc/0zxZd8Ly61N968q
 yi2QEq6R2lpxR1na8/PB/kWPyIJxBoIfJ0OsBXJljqG1tQoc8KnZyWmwfcfS3GQBSXMi
 7GjACwdbQ6gnQSkkqoS51R1nTIKoqGjgTmqg5X/UsG1uTaSwhdmSa8datA3I/lVtWJrb
 Q44EzQiIWd/arLJNnDjqBPPyPi+/MWZRDNV8hpoFy4lth/SbDsHU06Qc0d1TltYm7qiH
 YfM10n9Dpiv/QvF0AcAaozSZeOunUzXstTm3jOLU7j3dq2fPC9LWIXZ5fLbDfX5luGSv
 Fyew==
X-Gm-Message-State: AOJu0Yxe1ezNc0ZHoXEbFxwVKNFZyTTM7MZoxbMeDLeopB76aDdiusHB
 43GAwRGZU/2rYD7pk/WW19Yq33dY3jhaRNfV/9unIiDyJOGDokfNQmmMj68Swv8=
X-Google-Smtp-Source: AGHT+IHfgbo/reFIOcNODiDMFxa4Po7UHW8YYN/I4KGCJzL8ZmEaHuGkly4b2a/dS/pDNoFvPtU0xg==
X-Received: by 2002:a05:6a20:244c:b0:1c0:eb46:96f7 with SMTP id
 adf61e73a8af0-1c0eb46973emr2272534637.61.1720421769497; 
 Sun, 07 Jul 2024 23:56:09 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1fb111382f5sm95501885ad.175.2024.07.07.23.56.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 07 Jul 2024 23:56:09 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 08 Jul 2024 15:55:14 +0900
Subject: [PATCH v3 3/9] migration: Free removed SaveStateEntry
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240708-san-v3-3-b03f671c40c6@daynix.com>
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
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::431;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x431.google.com
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

This fixes LeakSanitizer warnings.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 migration/savevm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/migration/savevm.c b/migration/savevm.c
index deb57833f8a8..85958d7b09cd 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -874,6 +874,8 @@ int vmstate_replace_hack_for_ppc(VMStateIf *obj, int instance_id,
 
     if (se) {
         savevm_state_handler_remove(se);
+        g_free(se->compat);
+        g_free(se);
     }
     return vmstate_register(obj, instance_id, vmsd, opaque);
 }

-- 
2.45.2


