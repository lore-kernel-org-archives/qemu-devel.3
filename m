Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27D42CD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 21:36:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPoZY-00033B-5b; Wed, 20 May 2026 17:35:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPoZW-0002ox-5f
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:35:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPoZU-0007lz-17
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:35:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779312918;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cnCkeAl1JEVCHcp/i80JvKig343l2L+FI2gInquK9G8=;
 b=i2p6vajmaknBp4p6gPyew1+QQtCXgwudHMcQ1TAqxusO7ndSA/0iARcqUhS3H0S9ak/iFB
 vCbCpJM/IPNSrOffhA1KLv3954PvFRLriFiyMbZnGm3nz1tDDWqcHa3ShC83gBuXlkMsyV
 PrVF9jPGk4gxk6Rg4Mna7+QjTVIw4eQ=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-2a9HaV4lMIGCr-O0UgEspA-1; Wed, 20 May 2026 17:35:13 -0400
X-MC-Unique: 2a9HaV4lMIGCr-O0UgEspA-1
X-Mimecast-MFC-AGG-ID: 2a9HaV4lMIGCr-O0UgEspA_1779312912
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50f13da9684so70330221cf.3
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 14:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779312912; x=1779917712; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cnCkeAl1JEVCHcp/i80JvKig343l2L+FI2gInquK9G8=;
 b=BWA8Z+Kktcy1hgN9TNCn8a9j02Y3oJbBkTH4kNyiDG15m2a9mM4wED0Vx5gvxJLlGa
 xyudw00b7ntWgZgHUAj7kvdWdkOvM8YRSNanuHkdrdMwwu2Uk7761Ph7RpU2KsGjzRRB
 RTQx/sGJb6NCJZbxHbR5HfdsfA+ChbUAcsvu5LTN5Z42aIHry1k026FpnQoHjd122cUP
 l1MdL3ECkuz+ol3BDnaLdYrbbPPd0KqWQaga4hNgN2QcRoA78I7TJQcHzhCovLU0Tisu
 Jo+8g/LyVSj1b+DtWOu+Etry0K5l6taUk4sTouithKmNp6afYKd5NEIQZpPax9lXHeA8
 K5sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779312912; x=1779917712;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cnCkeAl1JEVCHcp/i80JvKig343l2L+FI2gInquK9G8=;
 b=Nz0hOfjvMy3EY05PEXLgRO049xqPfsJZsLUHXoxRM6BzsaiI0oNhuDQSqbxk4R3z4+
 mn1g6MX+uoZ6JeG6xu+09JtcUNS1m+BO/yIp7yYm405TYFlIrXNO3STGpbh8ZYtzK9G4
 iEjGtG92r96SoRXN8IXm80ln1ao87Ybx2iv/8wi/S+rkZeNtOdCoGrPGgNUflX6EBpko
 kWKOkgUzSbed8VeVZrEa3c4Llc+z2T8q8M8ImQg/jnPWEJUhMoWo1SXxDw60+TLNn0d4
 0KdLgmG+jLsMMgLqzTlgR6HwNaZILkj1/UkA0eHQe0bz7i2xDEskiMfHoVvtQGu0ZHkT
 mrgA==
X-Gm-Message-State: AOJu0Yy47ULNVxEd46slMAHJBF2JlDMScHW/0aDVgmJVUDOohbc5eEah
 v/EQ5QlhaxTY4FVdxUxe5eSGQKDwUHvkhGMJ+JzklN8px8wXid/Z8PAQPFpJ+4l3OLWw+fpPH2W
 Q55zCAoBd4nKpRP+jiSYHoqxg0QZ9MZ92v+VM2xW4GnDA7Bjy98ZWTESQmmE0cg+7DYG6zDdBtJ
 vHxm87xBnxF3uFLVdFDBm802cOR+oKZsuq7uTKyQ==
X-Gm-Gg: Acq92OEg2GOAk0eDtkOBwiZnjogBFq2hWR7lNQZzEaNIWhjHJijcRUwR+daaV4jj8kd
 ++MNaIU7hsl8SntTwOv1TqlN58SG7gZQbkB38m7VPRYTqltlp56HcCepq37G7d2w2mZSGYL6dwH
 4PZ69Wjf+N8wzwXftZrLNJS8cvfrm7t7Qj52R0hpPOg/KHOIHjHjcFL3P4C5olDVYF7UKpjDODl
 kcy5VfPs17VSoshLuaXzdwt21oRxXDtnBEMXBOcFpxFCwYQGHw/9wyVEizgMoqlY5exoXTJJ0aJ
 PuqRpZQ3swgK0oefl/Y0QkKOg+trXQo6yhVUUVSndWvKM3BN5YCr3ZDH2230Dkj+G9DDp8ue0Aw
 iduqwvPXwRJ6W8tyaQgKQLjx6mrUNngRxcC9oEfXDl1jR
X-Received: by 2002:a05:622a:4d95:b0:50e:62ba:3ff7 with SMTP id
 d75a77b69052e-516c5507428mr3897251cf.26.1779312912118; 
 Wed, 20 May 2026 14:35:12 -0700 (PDT)
X-Received: by 2002:a05:622a:4d95:b0:50e:62ba:3ff7 with SMTP id
 d75a77b69052e-516c5507428mr3896661cf.26.1779312911527; 
 Wed, 20 May 2026 14:35:11 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ca360b362fsm133062716d6.22.2026.05.20.14.35.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 14:35:09 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Hyman Huang <yong.huang@bitdeer.com>,
 Hyman Huang <infra.ai.cloud@bitdeer.com>
Subject: [PULL 29/29] MAINTAINERS: Update email of Yong Huang
Date: Wed, 20 May 2026 17:33:57 -0400
Message-ID: <20260520213357.40646-30-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520213357.40646-1-peterx@redhat.com>
References: <20260520213357.40646-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Hyman Huang <yong.huang@bitdeer.com>

I left SmartX two weeks ago. Update my email to stay reachable.

Signed-off-by: Hyman Huang <infra.ai.cloud@bitdeer.com>
Link: https://lore.kernel.org/r/b3bd81c3d9f425bb750a76d7bad7ad0284e55123.1779178180.git.infra.ai.cloud@bitdeer.com
[peterx: fix address, s/biitdeer/bitdeer/]
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c6ce786b5b..a8906677fc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3785,7 +3785,7 @@ F: migration/rdma*
 F: scripts/rdma-migration-helper.sh
 
 Migration dirty limit and dirty page rate
-M: Hyman Huang <yong.huang@smartx.com>
+M: Hyman Huang <infra.ai.cloud@bitdeer.com>
 S: Maintained
 F: system/dirtylimit.c
 F: include/system/dirtylimit.h
@@ -3795,7 +3795,7 @@ F: include/system/dirtyrate.h
 F: docs/devel/migration/dirty-limit.rst
 
 Detached LUKS header
-M: Hyman Huang <yong.huang@smartx.com>
+M: Hyman Huang <infra.ai.cloud@bitdeer.com>
 S: Maintained
 F: tests/qemu-iotests/tests/luks-detached-header
 F: docs/devel/luks-detached-header.rst
-- 
2.53.0


