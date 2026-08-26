Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00904C61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 18:18:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzIBv-0005Zc-Ce; Wed, 26 Aug 2026 14:17:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wzIBq-0005Yy-Ll
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 14:17:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wzIBp-0005Tg-8O
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 14:17:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787768251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=yN24mDFpsvYWcO2byq9jA4bIJJM+NRMqBTCh6dwDx0s=;
 b=Yuu1NR/XbG5zEA/gQNnSz/ZfU7VSNbkDw/Yg3FCyIgxXd1yHEFPC7t8osUFX0JAyPfInfn
 l1/dakB3dHyRNJJYr1PzAiVPnL2fKYZQ/FHM2NguewVCx3H4EFWJqXQyTrV3IguUrTSmvp
 BU2he32ecqfgeujJmRBykkGcZCJMeXI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-9fsxKaepPgCI9D0COqjeoA-1; Wed, 26 Aug 2026 14:17:30 -0400
X-MC-Unique: 9fsxKaepPgCI9D0COqjeoA-1
X-Mimecast-MFC-AGG-ID: 9fsxKaepPgCI9D0COqjeoA_1787768248
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-c160b9c0676so68213766b.0
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 11:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787768248; x=1788373048; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=yN24mDFpsvYWcO2byq9jA4bIJJM+NRMqBTCh6dwDx0s=;
 b=FKxpdun0ftSJ2d8aOcIbgryVnGAmi2WZNeppeuzeZXrUgHgh+ALeMUYcpSd8nyKrs8
 wUOQjve8tj6sem6nC8+zzE/A+XmATxp51NWgO4JulhuO6QfX8RYt4Ptd2yQ/Jvc1ne94
 Xs6zoOPyXcOgSmSF2YJh2sLpZCEpizaEH2GKrRnwy9mHraMvjar724mDOsIFeyCKFnfI
 wjbTL0EydXVviQwTMNp8R0K38StHT0gx1KTC3ppDxYAWDu3SR7XW9EzzVPJyHI3qnJTD
 Xs3IowvSAH2Siy5nu5TfoSRWlZspBg5OlGXQFEMIxnuFYBAobDjRJx5l4mBJQIpKGndq
 ocTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787768248; x=1788373048;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yN24mDFpsvYWcO2byq9jA4bIJJM+NRMqBTCh6dwDx0s=;
 b=IVb6I14ex2rIIPK6WPF7IzsoqbSFmp1DzXFCeG6GfR9uZBol3CRFWAXF/66IJ3Q2hy
 j7LKzeGJ1c+qqJ/+q+fPb5FU0/hsUruGyO3yU/kpAmsYHp3rYe71a4SOG33Qk+KZOZPp
 CM2RFOauAvHsPMxORfbdFlqO8Lxrr/eRLuSvY6xZgLneGKFG52ukiA4mfCMX0+iMrZAC
 1ZV/3iE5mWETO6iulh0/HcnJuPLpwIxqh3YGjg1fHHh1u4TIV9O2dfUJ3WG/84p0hYIo
 af1WoJjmQzBds0f6HSV4cUw+Li8bu6dFb5QwRWgCMH3HGLXcocKX8B0HJVzgT0Lt1MGD
 sRXA==
X-Gm-Message-State: AFuF++kV+WxYwB4BsopaZCPky6AE5A+EIp/zp/DEVotwzWujVVKxs1XU
 DSy4rL+cwsMeIWh6eO4u/LC7H5nNJ1iv5eXlZBB3Vb2Ipt08KTkw+F9N8oamHzP8Hov3sRbJTpm
 x9zj0++74gp81EYpZsPQ0UgdZ393yq57rPyTL/pNNGuZXMug5rFyPRafTVi9X6oziYSlVWYXFkb
 hO8L4j27irevXzx+doIbKG12zOt3Oz5dvc9xkqF+ec
X-Gm-Gg: AR+sD13PqA0uc0LzGoyeFloy6g/2TYbE2pRMJ5J+2vrp2hP3QvITFU3AE3o2XKqamhD
 6THk3I5pmhT30mugZQD6Yy3jy3xyREHDsfu1HFymYvf7/MGIPIq3iKW7CTwKhRBIfKdLVLBf8Ef
 2/TerUsZTKuGhVfGU7MO7yU00fArTSy3k6p4htWHvFmUTpaMEbJJPCQKunknI0qers7X4WAxd66
 UJvwt9/udQjBf3YA3lqRDBUjYJ8Lpumf0uuI766YMapemLiI8k7hZHNUvU5YrLDEz8FFVcTxGYg
 h5OJrOdm+hcvRcdN3zYyVaq1qkNahYKUU1eAuavJptwFRLXQMgrIdSPgemNks8Mw+d24SPX7X7k
 ZWcA3oAQa9/hEGfy/+nehOKT793YEoeVEGK9waDI8eZQkTmfbNMdMg/LIdoa6Wz9SXxk0HuTqBL
 L3oQ==
X-Received: by 2002:a17:907:6d0e:b0:c24:b11c:6c05 with SMTP id
 a640c23a62f3a-c250bc2df70mr1197761466b.14.1787768247774; 
 Wed, 26 Aug 2026 11:17:27 -0700 (PDT)
X-Received: by 2002:a17:907:6d0e:b0:c24:b11c:6c05 with SMTP id
 a640c23a62f3a-c250bc2df70mr1197755366b.14.1787768247290; 
 Wed, 26 Aug 2026 11:17:27 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a9b4e9csm637533066b.54.2026.08.26.11.17.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 11:17:26 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Mark Cave-Ayland <mark.caveayland@nutanix.com>
Subject: [PATCH 0/2] scsi-disk: fix race between WRITE SAME and MODE SELECT
Date: Wed, 26 Aug 2026 20:17:23 +0200
Message-ID: <20260826181725.849718-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
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

A guest with an attached scsi-hd can force QEMU's SCSI disk emulation
to read roughly 60 KiB past the end of a heap buffer, copying that out
of bounds host memory into the guest's own disk image.

This is due to a race between WRITE SAME and an obscure MODE SELECT
feature which can be restricted to the Q800 machine.

Paolo

Paolo Bonzini (2):
  scsi-disk: fix out-of-bound read in WRITE SAME
  scsi: hide MODE SELECT block size change behind a quirk

 include/hw/scsi/scsi.h |  1 +
 hw/m68k/q800.c         |  2 ++
 hw/scsi/scsi-disk.c    | 17 +++++++++++++----
 3 files changed, 16 insertions(+), 4 deletions(-)

-- 
2.55.0


