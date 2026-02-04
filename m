Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0347EA7941
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 19:08:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vni9v-0006bX-7q; Wed, 04 Feb 2026 14:03:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vni9n-00068y-FI
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:03:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vni9l-0007jr-H0
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:03:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770231796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wqArM+1zzEyxKYPN9OWdDc0ZApCblVkq8XChZEwMZ3Q=;
 b=aRTARItdzJ1b8682SRACxQZBvq6vP0MDhXFdN6vnBMwcdwReegy0+HTZFFsIeLiTfIiVod
 zRobEcoMXXEGqjhLxjaVwkCtelSzBOAb1IFnSnBbesHKLnXHcxaBLxHlGbO/w5IL6Ned3Q
 l6OdLnlgL/VPJj5IDFpcpWpq0rv1tDM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-3vGC6Hf8Oh-evIHI78LJlw-1; Wed, 04 Feb 2026 14:03:15 -0500
X-MC-Unique: 3vGC6Hf8Oh-evIHI78LJlw-1
X-Mimecast-MFC-AGG-ID: 3vGC6Hf8Oh-evIHI78LJlw_1770231794
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4806cfffca6so1001605e9.2
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 11:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770231794; x=1770836594; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wqArM+1zzEyxKYPN9OWdDc0ZApCblVkq8XChZEwMZ3Q=;
 b=oUUAdnoDXEW7qkrKCGs02ex59U5v/bR5j3n7nN/Tbjo1cdbf+JTC62uNjjtLtGuynI
 n/yB5bfRabY3MrF5o1c8dJtpxmWijBQck2KJA4vjXVwwqW//87FonMvsLd7q3rI0EE0O
 I06dcj9TGxa0pKUNMrSxq2V7mBMx+uYC23trUI7cnlxJi4waxy3s5GCjG/q0brQO9kpk
 qOBy44BNZHv3gHO7Wdtg42pOEuDAesrfhZ97vmjbj51YTSs3urh5WUYNFumEXyMcPrQJ
 0tC1WWHMuz35mWy95nMyjCDIK5PkXcqKOeS7Y1Jl8uHeVTQKKB/4p1yaoXWouwCa0A2X
 yKZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770231794; x=1770836594;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wqArM+1zzEyxKYPN9OWdDc0ZApCblVkq8XChZEwMZ3Q=;
 b=VocaDiGNaU+n0L06SPgb66cUGKv3Af8/8wVCWAx+wHqqWBJFHzv36Yvhabho8jvC0u
 KhB2oZ+325jEH28h6m+V2u/KlLyPeYk3pq07qNytADaKBBcHyabcObcPk+4+fx5UjZLp
 iWoklYju0M/LNbLgFOskIw/H3lMpsJzdLcNnhb26hvvkra9Ai66ujBEHbLAcmbVXFi4J
 On7WhS8H4IN95Y1TcbWQ65DVwGJVoi6W+fLwjGu0gvRPylkTdxoKpEGIGLDovMbeQXnq
 qwF15GaZzx4s+ka+7zHdZUgb5Xx3Aj9KiG8d/RilZ5t8y9CDZIqFm3PRcTWvzMNYa6zs
 53Eg==
X-Gm-Message-State: AOJu0YwK2iDfdYgSMYJmWoluk6j891hAX9Sd6CAxnmzFchbVu93Wy9lN
 H1c1Fe0Z4esbREIrnkqUhaQuTpWPevAvg2yYQbbH9aw95Iw0+JcjyVYqW0+B2A76iTK0QcExx6n
 TRPWoDaxGOnKpzfo2ykm139MuyAYGX7r0U0cy97M2jSQyySXB5KcK3VQl40A4mOwvRUQMA3c6jk
 wwdr0LxrPcyQLq+Izbt91/PePUPQqmBmW4VQ==
X-Gm-Gg: AZuq6aInDBbUzo70FlBKy6Ja2/s4k0bgKQfDQWG4mY/+qPRqod0iBRMeXyjv1MCigrk
 vYwt1KirpRLOum8gRUMfCgDTvO+MeBKCbGiBvic48O/Sn9bzp5SUzNYRBERI+JhT6A+QOgPa1fi
 3fTMHB6uA4hQ4NiI4PgTzP0u2vzynXj+dtApXKu33R0cBiepotukSPnknwWU5XQSku7L21/QOUV
 iwOU5QnXhNE4dEVVO5lHNtbmjd84WoRP6Pmg2BKHpmCal9Sr3DK5iBAjx9QjYaMgQ393WDY5FYn
 WRoO4msbgJlp3nKv+KHjyljM0TLT26RKbAMJf13dsBnThhDtDD8P2d00ow9ueTgdMrnI0xFvoLe
 Kw3k26xuqmMnaC5UHg6UF731PfjNflbwByQ==
X-Received: by 2002:a05:600c:4712:b0:47e:e414:b915 with SMTP id
 5b1f17b1804b1-4830e934764mr52081585e9.2.1770231793960; 
 Wed, 04 Feb 2026 11:03:13 -0800 (PST)
X-Received: by 2002:a05:600c:4712:b0:47e:e414:b915 with SMTP id
 5b1f17b1804b1-4830e934764mr52081225e9.2.1770231793415; 
 Wed, 04 Feb 2026 11:03:13 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48317d7a924sm6151735e9.10.2026.02.04.11.03.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 11:03:13 -0800 (PST)
Date: Wed, 4 Feb 2026 14:03:11 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 10/51] pci/shpc: Do not unparent in instance_finalize()
Message-ID: <d5dc557a9e8ea9e3602ddd974bb5d17151ab1dd4.1770231744.git.mst@redhat.com>
References: <cover.1770231744.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1770231744.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Children are automatically unparented so manually unparenting is
unnecessary.

Worse, automatic unparenting happens before the instance_finalize()
callback of the parent gets called, so object_unparent() calls in
the callback will refer to objects that are already unparented, which
is semantically incorrect.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20251027-shpc-v1-1-00e9b20a355d@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20251027-shpc-v1-1-00e9b20a355d@rsg.ci.i.u-tokyo.ac.jp>
---
 hw/pci/shpc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/pci/shpc.c b/hw/pci/shpc.c
index aac6f2d034..938602866d 100644
--- a/hw/pci/shpc.c
+++ b/hw/pci/shpc.c
@@ -735,7 +735,6 @@ void shpc_free(PCIDevice *d)
     if (!shpc) {
         return;
     }
-    object_unparent(OBJECT(&shpc->mmio));
     g_free(shpc->config);
     g_free(shpc->cmask);
     g_free(shpc->wmask);
-- 
MST


