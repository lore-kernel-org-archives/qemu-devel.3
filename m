Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6BBFC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 23:23:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whbas-000139-Ue; Wed, 08 Jul 2026 19:22:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1whbas-00010k-5Q
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 19:22:18 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1whbaq-0004ep-MD
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 19:22:17 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2c7cfa17fedso13967195ad.3
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 16:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783552935; x=1784157735; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gaCR9whNkf3wxjnKoTXYYtGy2bKkbknm+RvdndRsphM=;
 b=h0ZTRdUC+Bt9kiz5MODDN3D6s+8kThZ+HXIyUJb9/BJfYudXIy6xGtBYwb+QYZYS52
 X6MS0epvCo60kT/w+dOFQpYmfijy6Vr6DfdoEE/4Ray8zNdixadHs7ppUTaZRdtCXMMo
 xuActAE9UKHEovsNrsF0UdsIKhbw+WPMCKRozm28iuTiEytxX1wahFhgyApxmYepepmL
 pJqtOc468cglzgdvBfDy47NXaiMTyh59KsKoTOQNaAkHmX695DlkRgwmIABdF8Hc7A0o
 LxMQhEyLK52eEE2Szvrp04kI/X3FWbTrmqTQbAsdvjZY4kBjl5PidvoiyajxnNoPSqG7
 MIfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783552935; x=1784157735;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gaCR9whNkf3wxjnKoTXYYtGy2bKkbknm+RvdndRsphM=;
 b=LkpJYhzSpAaq2c88VojxAIRqRyZEGsOUUXKZxjdfNZT9Ye7Yqr8uEcBRyKGIo5ty3X
 0dlHjsa3MVpohh8PW9bPs2q5w6pacRrxac25UDwePfY66R6/7y4rFLIUGyU219yHtwJE
 Na1rutS4Z9rvmc3jmg9ZgtULdrtHul4HH58TjUg/j+S04/3i1L2eo4CxtT61OOpuBXBd
 ukYErtbW9pxFA8bFx8e2ZxuwoU6xtgfk3xVEoLBlj+0e4yRj5RYnx3nphsK1D9ac+qq6
 m4of/0XnzUZS0/5wHifiULNYGrW14OTzcx/L+559BADVeF2RQR8xJXDwFj3R9FuRyE7x
 JySw==
X-Gm-Message-State: AOJu0YxlK2A/Nzqq7m+fYRCCYeDDIOaP57sX6ZxtM0t56uNZnc8w5eBQ
 qg8FxDf+GJnBnwYu2ZpaFPwLvqSaKzcIU9MZyXQwnYr1pA3LEViuCMCT2AsAIg==
X-Gm-Gg: AfdE7ckF1VGkQGT5MEvqXZ5nQZwywxMMTqUD8DdVkbJzTqp9ApwJ0cIG9Me+J10QPo4
 AiGrNmZQfPUCiERbj3yud/YP+ylYk7SjunRFB72YGjuMaySWOd074wf1cpbepYV2Qb+WVpcvDRG
 LvSvAPoSCGt6gyEYV4I+M3UmTd2VOyeGE+tEhAQ4avKJ0BxDSkUBb4bTRBVCJfiTOo9C1u4WGfu
 CsAtlf7GhDJn9H+ujXuVS22y56VvJgOETzVII000+n9Lk0bZSgXE1avkD4EefZ0jKxjmgW2oCbz
 SCRoEkP5jpo1ORM6nEDHe3KZClJiTU1Q1ljAMP86Z0h8a4phNUbE6ZN/waZr1t6dlzEvagBJWck
 cpL6a5DEVwf2ptEaJRVSlMYyVZdhDmE/ehiIoBkH5HkfqBE0H72koFP44TGBfJZzgBJ7A17bqHz
 BomUV4dsa8ju18KhuasOGogOIwJOGK
X-Received: by 2002:a17:903:3890:b0:2cc:84e7:73bc with SMTP id
 d9443c01a7336-2ccea3a29f9mr48516965ad.32.1783552934579; 
 Wed, 08 Jul 2026 16:22:14 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([211.226.54.223])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9bf74cbsm33961225ad.18.2026.07.08.16.22.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 16:22:13 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: qemu-devel@nongnu.org,
	qemu-stable@nongnu.org,
	stefanha@redhat.com
Cc: pbonzini@redhat.com, farosas@suse.de, lvivier@redhat.com,
 qemu-block@nongnu.org, jeuk20.kim@samsung.com, j-young.choi@samsung.com
Subject: [PULL 0/1] ufs queue
Date: Thu,  9 Jul 2026 08:22:02 +0900
Message-ID: <cover.1783552661.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Jeuk Kim <jeuk20.kim@samsung.com>

The following changes since commit f893c46c3931b3684d235d221bf8b7844ddbf1d7:

  Merge tag 'qemu-openbios-20260707' of https://github.com/mcayland/qemu into staging (2026-07-08 16:01:29 +0200)

are available in the Git repository at:

  https://gitlab.com/jeuk20.kim/qemu.git tags/pull-ufs-20260709

for you to fetch changes up to 90aacd5bc405cb71f77472616093f9e5ad9afd2b:

  hw/ufs: avoid double unref of wrapped scsi-hd (2026-07-09 07:58:38 +0900)

----------------------------------------------------------------
hw/ufs: fix double unref of wrapped scsi-hd

----------------------------------------------------------------
Jia Jia (1):
      hw/ufs: avoid double unref of wrapped scsi-hd

 hw/ufs/lu.c            |  5 +----
 tests/qtest/ufs-test.c | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+), 4 deletions(-)

