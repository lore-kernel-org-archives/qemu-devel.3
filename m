Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B73BDC88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:22:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6paA-00064j-Ao; Wed, 16 Sep 2026 09:21:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x6pa8-00064G-N0
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:21:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x6pa7-00035Q-BZ
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:21:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789564906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i3ab9f4ObETvK0c9uUipMHw3PnKmaGztWZYlVMHBWk0=;
 b=ahLb5Tos/k4TJl0LZIjcWZ+VLEHejR5BZB/0ri7+cWUCXWQ6kjFx4Yc/8h4n/D1Ikh2WBp
 grGUsdaKTRoP+SD+aCC7sQFoHEwJz0X255zKSZvzFJ94zuWiiAhkoL1AJ5EHpgdObEoSQ0
 0ygG887Q1OyNVSjyUNjO470+K7KazMA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-NvPLE4WdPBS4yd3JnXh6Ig-1; Wed, 16 Sep 2026 09:21:45 -0400
X-MC-Unique: NvPLE4WdPBS4yd3JnXh6Ig-1
X-Mimecast-MFC-AGG-ID: NvPLE4WdPBS4yd3JnXh6Ig_1789564904
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49e82768ac2so9270385e9.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789564904; x=1790169704; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=i3ab9f4ObETvK0c9uUipMHw3PnKmaGztWZYlVMHBWk0=;
 b=lauCwFsiyrnyIU2pImqObRa4v82pk1ymJiFHraZa6+AUcbBgpGJB+Qs01QtHQjk8lR
 GzCw/GC2knLkyTLqf/AZfitCf96mGl+2H8sMD/CxfawwdhxPafR0VWadtuXelMx5GRWV
 Z5G7gsJyrqPzfd8ij4QQfAxXnJmYoQKbgPKORv2/TEkK2uL3ly6A/NoDl3vOWO55Weng
 xEdq7xz4Z5UQxmukARsABVDZa9oKvvKcw/fhMj5C9rsn4+5PniZoG9JSM+ICiqlqgJZh
 17Dtt9RD9LW69qp/zrT3iWM9AeEFiPXnhuufR3YY7F+ZATYvV7jD9Gtr1N1yO0qCFCjr
 IjCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789564904; x=1790169704;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=i3ab9f4ObETvK0c9uUipMHw3PnKmaGztWZYlVMHBWk0=;
 b=BCLuyvn0qCruTNy2VNPEiDLBD81EgbYQVqCwZ1xOW2vUIbPggX0VglcQGHqR8K0rOC
 d35MSlZyBCD63KIidkD2KP3/NA3mvddlKCVSYtngrE/FnCGsR129vyngit8RziSpFf3n
 q1g+bYONPA2Y8qTPZvxkuUYI+c0RPY8ETsTesNIxu2f/gx1A0UG1W7md0j4hxY9iRV+m
 72HoiYp12DQgCMpqOHtk6Of8Q3oFTNC3gdzDJfJEtCEWh/uswZPq0ptlSLFGgi8/iqVa
 4TK5VGeDcdXZNOlWEnM4dy0V+OUcv8P/LBUfcp+Fb7uL0AKlhDtTXkTFc7T2LpRpJa5c
 XSpQ==
X-Gm-Message-State: AFuF++ljE//hq6CnJsI4Yx+p/tfEo8iK16yM0Y5DG5mcvETmR+1tvDis
 9DPxHGDFvMo5yfHsjJa3WVzfPu0mr0u7S+K3Ps1gqiEjNsaev8UcSW0AkuaxnS4iJ1vhfR/aKmQ
 ONI3MxBcouDR239wyxwa3vp1aDFw69x5XvUJknTLO5q8vybkiaFw1soPXa+WyRSLtW7gq0eUIuc
 BeUVAHvLg6sgf8ZQZJwxS2m6pXW+VaPIoixiqg3ozw
X-Gm-Gg: AYBFou37ngpC8vEt0qN8D4f7CMv6yh32osJKZVLtuxGbZWEriCJoMGHWDlHClf5o+W7
 Jzru38uXQnEiZdYZ2XzU+PMUwemikxAU4xguWbylOhWTTR3HGMNaOLM670uviM5KpnE9B7vMOh6
 F4rGlabUn+iPyZr1nkD9avJMqzBFtC1bUYd91MduYf7b0C4WS67W/FLbBz2ey7EmiF/1trhrq9j
 ehtZCMtEksWDZ2TGTiOvkeeKJvXpF0WQN6wpupAnrz2MuninbE2ffQE4Iwjb0bC6FdCVs97o8j0
 FrB6IjTC9sk79Qk/cRqoJUsJOqX+gHXTUCCZGfa+tLq8xbouVpcnGyktZPsOecuF4et4l1O2Zz1
 UChdiWJWGCAH1RIY0EXFlvEXxUDO9Na1YcXIjPvbZMV/t02VnaW85oy2mpHTLfSSsA/6c6kkA8D
 SR4RJX
X-Received: by 2002:a05:600c:630a:b0:49c:e37e:4389 with SMTP id
 5b1f17b1804b1-49e9663bbf2mr32670675e9.4.1789564903980; 
 Wed, 16 Sep 2026 06:21:43 -0700 (PDT)
X-Received: by 2002:a05:600c:630a:b0:49c:e37e:4389 with SMTP id
 5b1f17b1804b1-49e9663bbf2mr32670365e9.4.1789564903642; 
 Wed, 16 Sep 2026 06:21:43 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e83b02211sm82792655e9.9.2026.09.16.06.21.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:21:42 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 8/8] ncr710: unify two conditionals
Date: Wed, 16 Sep 2026 15:21:20 +0200
Message-ID: <20260916132120.860910-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916132120.860910-1-pbonzini@redhat.com>
References: <20260916132120.860910-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/ncr53c710.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
index 18c3a4e8c51..fad3d3113e5 100644
--- a/hw/scsi/ncr53c710.c
+++ b/hw/scsi/ncr53c710.c
@@ -797,13 +797,10 @@ void ncr710_command_complete(SCSIRequest *req, size_t resid)
     s->status = req->status;
     s->command_complete = NCR710_CMD_COMPLETE;
 
-    if (p) {
-        p->pending = 0;
-    }
-
     ncr710_set_phase(s, PHASE_ST);
 
     if (p) {
+        p->pending = 0;
         ncr710_request_orphan(s, p);
     }
 
-- 
2.55.0


