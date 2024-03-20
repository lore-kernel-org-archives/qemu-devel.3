Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9538FC54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 13:10:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmvhk-0005Ow-Om; Wed, 20 Mar 2024 09:10:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zheyuma97@gmail.com>)
 id 1rms1C-00071N-TU
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 05:13:54 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zheyuma97@gmail.com>)
 id 1rms1A-0007SA-1m
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 05:13:54 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a466fc8fcccso783640566b.1
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 02:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710926030; x=1711530830; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4X7UGJU0c/S1jV5qTDHfvL2iI1yqhVnKXQplMriEpBo=;
 b=lQhuLvJecIgImJiU0ZSeBHoZ5mKmyO32AivFrYbLU+PYY0i3hjm6C/bn1JWEOtADN5
 AoYBCCtEaVrg3ZXG1Pf8ibbJC4w2UzJYylhG/6t+AI3JdkqY2CJPPijVQ1cU1uL3l2YM
 kfmEvdX0B4HU4zusqPHzHS4mJcBvvfPvO7s+vJVcsue7YgM4mS/2oUIL93ZQGE4146Sx
 MWdngsQX7VJht/QN9vKTTWka9n42t6UUV/JVAPu+jVCTs06uKN292YWd4Z2RetSbCAUJ
 qMVtKGuGTe4nkKDMtj55z88j6ZutIQIlL5BpQy/TTFWLJftnxD7tt0eu2D7ay3BRBeFS
 qXaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710926030; x=1711530830;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4X7UGJU0c/S1jV5qTDHfvL2iI1yqhVnKXQplMriEpBo=;
 b=JtGm3fYA9A8eduAlFhv1eO2L2JPs25I7LLZYYFOkqw88RXYWFbn/PgS/tkbHI0zZgk
 10Sl+aBOX03JsM64YV2hI6aV98IjBCaH+HYHTXf9fAKqShB/PEPJYq7nk+enhCYp6q1c
 PIuPOvbN1xqUBn13JOSvlyUQaKy5vhEKS7TknPBg4TXXSIP4ETSaljANPk40jxyldNeA
 kYZdEL+0wiaQ31DB8GpbwbLkJkxzL+qDawq1n48TFEjMaNpyPLFVrv7C7mZzn0Z1KsaC
 a5LYwaSe8/9haHJA/v65WMoS/psb/VnRim0tfBAUvZBRVEvfZ+e2Rk4zMDc81m8OsQ1s
 CooQ==
X-Gm-Message-State: AOJu0YwDf+fFULz3DoRdsH7nRnW8uisOoO6QjEIPbwt5iArFV4r4pbv/
 uaImESieYjC1ydMBE7ktbXJgVxc7IFzIXM2kOVHn+aihcPm7tpo=
X-Google-Smtp-Source: AGHT+IHefPvEoF7zz1UOayOUKX14wD2WzOzwLKaAInRYDTpG0BQbT3E/QVUp+5BRAu8g2Pcv20h57w==
X-Received: by 2002:a17:906:2b50:b0:a46:f6ac:22e5 with SMTP id
 b16-20020a1709062b5000b00a46f6ac22e5mr609064ejg.7.1710926029699; 
 Wed, 20 Mar 2024 02:13:49 -0700 (PDT)
Received: from wing.epfl.ch (dhcp-122-dist-b-021.epfl.ch. [128.178.122.21])
 by smtp.gmail.com with ESMTPSA id
 wr6-20020a170907700600b00a4623030893sm6925696ejb.126.2024.03.20.02.13.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Mar 2024 02:13:49 -0700 (PDT)
From: Zheyu Ma <zheyuma97@gmail.com>
To: thuth@redhat.com,
	lvivier@redhat.com,
	pbonzini@redhat.com
Cc: qemu-devel@nongnu.org,
	zheyuma97@gmail.com
Subject: [PATCH] libqos/virtio.c: Correct 'flags' reading in qvirtqueue_kick
Date: Wed, 20 Mar 2024 10:04:42 +0100
Message-Id: <20240320090442.267525-1-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=zheyuma97@gmail.com; helo=mail-ej1-x634.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 20 Mar 2024 09:09:53 -0400
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

In qvirtqueue_kick(), the 'flags' were previously being incorrectly read from
vq->avail instead of the correct vq->used location. This update ensures 'flags'
are read from the correct location as per the virtio standard.

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
 tests/qtest/libqos/virtio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/libqos/virtio.c b/tests/qtest/libqos/virtio.c
index 82a6e122bf..a21b6eee9c 100644
--- a/tests/qtest/libqos/virtio.c
+++ b/tests/qtest/libqos/virtio.c
@@ -394,7 +394,7 @@ void qvirtqueue_kick(QTestState *qts, QVirtioDevice *d, QVirtQueue *vq,
     qvirtio_writew(d, qts, vq->avail + 2, idx + 1);
 
     /* Must read after idx is updated */
-    flags = qvirtio_readw(d, qts, vq->avail);
+    flags = qvirtio_readw(d, qts, vq->used);
     avail_event = qvirtio_readw(d, qts, vq->used + 4 +
                                 sizeof(struct vring_used_elem) * vq->size);
 
-- 
2.34.1


