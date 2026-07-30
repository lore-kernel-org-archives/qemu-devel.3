Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AF86C531D0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 07:14:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpKyV-0000Iy-2t; Thu, 30 Jul 2026 03:14:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wpKxr-0008CR-S9
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 03:14:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wpKxq-0007x0-G9
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 03:13:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785395637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qM+b5aTyMUCYSNkRyIr+jo3JihxZ+8QW/4Sbx+B2E34=;
 b=AHeQ7qVRtToeZjy2GqedhMcE4r7ratyw5GY5U2QhtzztUKUg7RWjhFlqGNutjzVaZnpTah
 xbz1z5p0PsumDIkjUHwXI38mgv5IZCA0egrQ8dZSqk3PKdP7JAB9KOsNBx/57qsx+SY0jL
 hWvUA4IYcjKlFEg2OzEr//4s2xnpJ3U=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-kqYBrcJZP3KXieO2cHQ0mg-1; Thu, 30 Jul 2026 03:13:56 -0400
X-MC-Unique: kqYBrcJZP3KXieO2cHQ0mg-1
X-Mimecast-MFC-AGG-ID: kqYBrcJZP3KXieO2cHQ0mg_1785395635
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2cacd6d37edso24975395ad.0
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 00:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785395635; x=1786000435; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qM+b5aTyMUCYSNkRyIr+jo3JihxZ+8QW/4Sbx+B2E34=;
 b=kNFPOxugZRD7jPBxgXsnaooPvmEVybnF5tRM5BdpBdzqN3rnDJ8QDK5N+4P1adczr8
 dVhUcBHHXh7A2vyB3S/o4U22tST6cckkmGmdXRJGE9s7HTHqt04jXXZ7TZGUQMStRMma
 iucNTV9AM2KnRo2vYhPMs4pMwO2NSwetSHjhoCkg7YHDn0FhHv7YZF5/t7V9g+lcZcWh
 7Xflz+aTRGgPhX8i82R3kiVQjJ2W62TWVTGZTipp15ROypcPx3ZWZ9OCWuNZXIMRRn6x
 xOzmshwbzZ1aUvlNIMb+iqU6g5EF3tSzhuDkjneE3cqZan8SO8qHgH4MdepQ840Ecd3Q
 UvdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785395635; x=1786000435;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qM+b5aTyMUCYSNkRyIr+jo3JihxZ+8QW/4Sbx+B2E34=;
 b=oU3xSatQvh6dVHB9p3q3ASxyGHH6MWJktI0Aj6svmUfnw9Y7khRYivvsY8nitahNEW
 XDimR1E/UOLJjD3yMeOHaU+9T7BkyAbzzRvXlhLKdOZpRsEpbUvuPJhgDIjSl2q5jCv4
 SvcJaiE0+bl5vhlE+wk/lNNE+MLdPqePnAR+RdKUIzsa1kiJrP4vMLV+q5OLH8aaNQoY
 q1ZcPVxy4TTfPcYGDnQSdtN5YCtnIWLE8e5sK0Tw0nGHST0tLEhye//ZPaWMKchoreaT
 /LYLs5vR7Yo0FriMGhuqlu5aRmR1t+4yVZyklwsf6szElzRLETmus4RS8BxFadsfzU3+
 UWjA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqLlkj/0Eah8Ove/ag8SHOXCj2jFnzijqOycEnE3FgiVbg0xMCUHWVyZ1RI3bScNtvZEvGuysTthm0v@nongnu.org
X-Gm-Message-State: AOJu0YwKpNq8LrKKZ9o/L/BErLKsi7UM/JZ0DFOwzwvrmvlK2RjxnVz7
 95CiQuE/s9sOlu7Bvu/DJ6l7uFcq2LvpqbhZrp2tY/S0H+MLLqwlaVOzqAkKu3n4dfbK1mVIviz
 E/OfIzR6F/1sX5W/G0Cfxy9xFI/0ghOwo25vJ1zNI6y66l2ResO+9gtBe
X-Gm-Gg: AR+sD10rejFB7tVkf2E6og8jtgbNwj0/iUEvXX1hW2qt0UdT8+QgZfqOPvj/cHBBlA1
 XcsgNLm4Eul+E5BFHJ6SJhVvpcRqBN5NwN/MpbEFC/puiUBtTXKkpYTU0OhC8u/o8c97OXtWnq2
 HH7ZMBeT1A/A3Ejqt5J6OD8pVGPhpshuRsYORFhn9LNs9HD3K6J31IM9yzCvAfIpyr7lu+GbgWw
 Mbje8NAvqTvApjGA+RHjnDnqhk8JhW6xJDygmi+VsABg6Nw/t6UFwoO0ErSib5HUxcpQ8zcY+OA
 s3GjAtyCiHMD+d4YgnmPEnvlnWre3Yb9WKXLuP5ChbOqU3iQ0XPVo/ml6Zb7a7JZvkn/LWVKYg9
 S2Me7h8txb1Don/5XPQ0KovN1MAD0kQnmBN0=
X-Received: by 2002:a17:902:f54e:b0:2cf:9f0b:b560 with SMTP id
 d9443c01a7336-2d035ccca4bmr15877775ad.29.1785395634887; 
 Thu, 30 Jul 2026 00:13:54 -0700 (PDT)
X-Received: by 2002:a17:902:f54e:b0:2cf:9f0b:b560 with SMTP id
 d9443c01a7336-2d035ccca4bmr15877575ad.29.1785395634485; 
 Thu, 30 Jul 2026 00:13:54 -0700 (PDT)
Received: from rhel9-box.lan ([223.236.229.143])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2d022a15893sm21864835ad.4.2026.07.30.00.13.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 00:13:53 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: 
Cc: Ani Sinha <anisinha@redhat.com>, graf@amazon.com, agraf@csgraf.de,
 qemu-devel@nongnu.org, kraxel@redhat.com
Subject: [PATCH v3 9/9] Update MAINTAINERS
Date: Thu, 30 Jul 2026 12:42:36 +0530
Message-ID: <20260730071254.80695-10-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260730071254.80695-1-anisinha@redhat.com>
References: <20260730071254.80695-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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

Add maintainers for vm-launch-update device and associated documentation and
test code.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 MAINTAINERS | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 902db77218..b8523d4cc9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2833,6 +2833,19 @@ F: include/hw/acpi/vmgenid.h
 F: docs/specs/vmgenid.rst
 F: tests/qtest/vmgenid-test.c
 
+VM Launch Update
+M: Ani Sinha <anisinha@redhat.com>
+M: Gerd Hoffman <kraxel@redhat.com>
+S: Maintained
+F: hw/misc/vmlaunchupdate.c
+F: include/hw/misc/vmlaunchupdate.h
+F: include/standard-headers/misc/vmlaunchupdate.h
+F: docs/specs/vmlaunchupdate.rst
+F: tests/functional/aarch64/test_vm_launch_update_aarch.py
+F: tests/functional/x86_64/test_vm_launch_update.py
+F: tests/qtest/launchupdate-test.c
+F: tests/data/igvm/*
+
 LED
 M: Philippe Mathieu-Daudé <philmd@mailo.com>
 S: Maintained
-- 
2.42.0


