Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40991E7718A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 10:44:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOaUV-0007LA-SE; Fri, 20 Dec 2024 05:44:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tOaUU-0007CF-Hw; Fri, 20 Dec 2024 05:44:18 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tOaUS-0005Rd-Tj; Fri, 20 Dec 2024 05:44:18 -0500
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-7fd17f2312bso1312076a12.0; 
 Fri, 20 Dec 2024 02:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734691455; x=1735296255; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gK96j8dWCREGXgJwMGuVlSSEE1tC1GR6d2jBmPlZZVA=;
 b=Td4f1Tv/JfnZL4Elus48aX0gwrTK+3D9BAR1rhG+S9ZDf5r+MbPpEej2OHWGQ9SE5q
 NX5tXU+yPVS14BSZv2j3Zzjtz80qT7PIsfs6YueG0QE57p0wgBENEKQRHOsJ1s1vYVjg
 kli6C0VgsCrdwdUGX5OonMoMPmx65TVMVCYnUDyOmVX3/06Ke6JUPxxUyoxiVy9oVzw7
 S+rcgBa9KtXNHVoc/FXXNeiT2tkotVB3CnCKfD5Z5GgUMua6+GIKNKEPdYcZ+usKfkRF
 svcnv2yzPyqA1H94YfG0ct4ySqFQrCeM/DDB89dTcbMTq9Si1eHoal9NXOW5tWkGRikU
 8SKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734691455; x=1735296255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gK96j8dWCREGXgJwMGuVlSSEE1tC1GR6d2jBmPlZZVA=;
 b=Ahsmf0b4d2pVjYjf+e2Sh1VuV0AdmxQySgDFkh+iMuvp5/BhF0jR5r/OU8G88nwEaf
 AdU/XgE45NkfHpqDUUXY/aj2lHtYrwIIV3B77fCS/xKNQwjrIuzJViu9hPO9cBFvyLxq
 r/L+II3JqParF4+uC9TiRAC1oPrFEcNiCN82jdWKfH1+OtfAF6QAY9k9PfgrL2KWslcz
 2bLJfwHFq8Go5G/wReOXJQlDicXu2Y6+WnOtu+N1Mqv/+ibzzC73FdDA0pNXE/CDmVVq
 Uu5YhBqBd4IqiwyVotsDtrCqu+EMf1x3F+wcnvNaYMVLRUwmdZeLhXN/IZSAx84esNuJ
 4LKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpuaqZyI4QlOFVqeC4+iIctq/SkI79apOe8eSZRS/pUeA23moMPCj6c8FbudjlpiEJ5Mw+pE8L6L5K@nongnu.org
X-Gm-Message-State: AOJu0YyG5HUbnjwd68ewoFiT2WsWipkRa75IcOMuIGgHXDM0N20Hrw5C
 MhlzvJQTlb8ntTswDgtBwMnJ7que1YNBG9WGBjo/2xlxqaW23/BHi6KEzQ==
X-Gm-Gg: ASbGnctQUD3J9C6quxt+dsm0jA+2MQNqntBnpBNWuj2Exg6Z2PlfBRYn1OC0DuTEY51
 qTHygBFoL7S13cpuc/SiqxhgLUcPinKBFBOMQyzNC1hvJ9u3O/EwaUdVIq8ft3r/9bYSpyLZIDu
 GK9skYJ785Yrr8UamCHAr5QVtC48MecGSMN3+K7DxbcQ+nZJykfqw5QI6Isn4l/NsqO+NQ1zjXP
 uSzeiqdOb4oRBEeNxaReHGi6mtEY5YZNw/HzRHtvHQQVfKIdDDgRTBTIdJq66HhjiF/VHRc2r1c
 PQc8gTsNpw==
X-Google-Smtp-Source: AGHT+IHZFHLin5x6wJnLdKPCeP9ORVvAm7tn/Fzr3fGVEOIA6Fdk4Fw0nxh1zvmUre6+GFtkqiZjSg==
X-Received: by 2002:a17:90b:134d:b0:2ea:4c4f:bd20 with SMTP id
 98e67ed59e1d1-2f452eed773mr3451099a91.32.1734691454890; 
 Fri, 20 Dec 2024 02:44:14 -0800 (PST)
Received: from wheely.local0.net (14-200-18-130.tpgi.com.au. [14.200.18.130])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f2ee06dfd3sm5376942a91.32.2024.12.20.02.44.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2024 02:44:14 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>, Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 John Snow <jsnow@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: [PATCH 13/17] hw/scsi: Convert to new bh API
Date: Fri, 20 Dec 2024 20:42:15 +1000
Message-ID: <20241220104220.2007786-14-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241220104220.2007786-1-npiggin@gmail.com>
References: <20241220104220.2007786-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x530.google.com
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

Convert aio_bh_schedule_oneshot() to aio_bh_schedule_oneshot_event(),
which can specify the clock type, making it compatible with
record-replay.

Operations on SCSI reqs do affect target machine state, so it should
use QEMU_CLOCK_VIRTUAL to recorded and replay the bh.

This fixes hangs in record/replay when using SCSI devices.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/scsi/scsi-bus.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index 2f1678d51e7..16f294ce6b7 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -166,9 +166,17 @@ static void scsi_device_for_each_req_async(SCSIDevice *s,
 
     /* Paired with blk_dec_in_flight() in scsi_device_for_each_req_async_bh() */
     blk_inc_in_flight(s->conf.blk);
-    aio_bh_schedule_oneshot(blk_get_aio_context(s->conf.blk),
-                            scsi_device_for_each_req_async_bh,
-                            data);
+
+    /*
+     * This is called by device reset and does not affect the observable state
+     * of the target (because it is being reset), and by scsi_dma_restart_cb
+     * to restart DMA on vmstate change which also should not affect the state
+     * of the target (XXX is this really true?), so QEMU_CLOCK_REALTIME should
+     * be used to avoid record-replay of the bh event.
+     */
+    aio_bh_schedule_oneshot_event(blk_get_aio_context(s->conf.blk),
+                                  scsi_device_for_each_req_async_bh,
+                                  data, QEMU_CLOCK_REALTIME);
 }
 
 static void scsi_device_realize(SCSIDevice *s, Error **errp)
-- 
2.45.2


