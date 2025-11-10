Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD806CCFA13
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 15:53:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIUA7-0000vB-CZ; Mon, 10 Nov 2025 10:50:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vIU9a-0007fp-Fq
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 10:50:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vIU9Y-00016A-Tv
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 10:50:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762789800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jZKk3/icQIlk4wS9kJz5czI40TKjQtbEM/Odynr7F5U=;
 b=gA2CFlopR79lEmkuQWL3O7VHBwtxR6O3pGqtUCF6yf3NO0Ij+WQMrpqD7c7EtUKQuEnDfw
 PkOs53xnCRQN9dOmVBwAXXXgnV2XjQtsCyeGdjfVGAaWUHwPuEyifw90fPWwXBWm5/QoTR
 bhkfc8I8rKjt3K7+Gmk3PTx7wlpvQ1E=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-LJpHF8hsMG6Xe_XsTNf22w-1; Mon, 10 Nov 2025 10:49:58 -0500
X-MC-Unique: LJpHF8hsMG6Xe_XsTNf22w-1
X-Mimecast-MFC-AGG-ID: LJpHF8hsMG6Xe_XsTNf22w_1762789798
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-429ca3e7245so1362885f8f.3
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 07:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762789798; x=1763394598; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jZKk3/icQIlk4wS9kJz5czI40TKjQtbEM/Odynr7F5U=;
 b=p1Dw5K5/WtQi4CxCe6f1msodAvByjmP63I60D0VxTkahBOw8A+gLCKIfheJrk8sbyy
 WIpPGSddsFkmycKMKqm4UjEUyzBaIxIV85h3mHgDuSSXodz+qezPMffCxhjdPLCpI9i6
 wFesagpbRQ9aoW0LMD2Hxrtecjw7Qn24Dwsu2vFhHVZXc5uFEAzkx2pTtk0dOunzJLof
 gf6fLybTmJua1OcwXi9RW/073tBsxnd7rmjm6LEJsgDBcpInq6XIaCu5ci/GZLS79yat
 A6wkPHb+/TGgcgCGJBWRABK/So+jMIUFGwlvnoVS9zahVhV1yzS96BQH9WSLpIZUO/mx
 FEaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762789798; x=1763394598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jZKk3/icQIlk4wS9kJz5czI40TKjQtbEM/Odynr7F5U=;
 b=vcMTG5NMSN3qzO86ClCb1TDBPvhe45sEuQgUddEsK4tphVbNw7NVSPRXG+ovzaPvtf
 R6S3MNTRzZs/r3p1uYwafFzipmLpE1i8dH7qiYq6UZ0TLrFY6iIg2XuDAGWDHJPgXUCH
 WgOddMzEuiAJrQ1JzqGke5pOAErGN7F6QUlYbICf12phlVgCNUjqsU2Pwb0ebowaOTTq
 BRdekH0KNijfKGnmUqQxia2eowVUEniyiv7nfntZQkQbpy1XFoBwNhpb+WXrf7cgI9Xn
 i0596zmnY/sceqyjWwDnHPzoFL0D55mjrUNNnvVTr8jP+dYqiSLXHKExRVC3tKBxDlPa
 Gwig==
X-Gm-Message-State: AOJu0Yz0IcytYpdIn1tuwM2kwnNg7s4IUDbd97h89bS97U4NPI8FDW2R
 5mOUxMEDGwvE9qEAKOndHN8C8HD/sm0ajsad65NAfTosXgZGR054Vox7SSfQ2t7RvaK1+ZpUDmc
 bbdsj87hDeV93W0csCJWXapLNE2FRQN//YjD0gTgwrdYMnc1RXWyywytP
X-Gm-Gg: ASbGncs4MHgx30WOGeVMWiTCyVYi1CO3mpyBIgLwM5Bu2GlHPQJnDcc1HRgGlHOl4vU
 y9BtcWHApN6uEhjGMJCfaxheOS3Tumvjbfdzdx3lt1N/RypkrkqWyfDTUUM1GK4CJsAi26YUGMS
 a8Eqy3+WjfMRYfZTLYLxoXEKdIKMf2Hwez40vOusQiYJr18y753HhU4+hkGYWRtkov93lpxLiSA
 vb4DFxU61K+phKYsIXB/5pAq/LcfmvW7/J4mmOu0SWQkKPDB1ZSBYcCGYv0YEv4MVJzn2kCu9h/
 e6RQhbxAOTzBdAwHQfkdnmu6Osy6+OUDU3vQwe9LGRqk0/cpI3bLJM6qHb738lH5C44IKytMAq0
 n5LBs2vg/ZXYEo03/8lsWaxXw9Jf7Wo+Wxpq8dO8MaoiWSvG3EK64XYLFQA==
X-Received: by 2002:a7b:c304:0:b0:477:259c:dbd7 with SMTP id
 5b1f17b1804b1-4777324670dmr46774505e9.12.1762789797647; 
 Mon, 10 Nov 2025 07:49:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFDtZ2ceebBnyfWsJcOyvXIF1H3PO2b8f4d6dIOB9jgkxA3txlU7R04FlkUvUF4LakHm2eaUQ==
X-Received: by 2002:a7b:c304:0:b0:477:259c:dbd7 with SMTP id
 5b1f17b1804b1-4777324670dmr46774335e9.12.1762789797187; 
 Mon, 10 Nov 2025 07:49:57 -0800 (PST)
Received: from localhost
 (p200300cfd7171f537afd31f3f827a45e.dip0.t-ipconnect.de.
 [2003:cf:d717:1f53:7afd:31f3:f827:a45e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b29e4b9bdsm19094756f8f.32.2025.11.10.07.49.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 07:49:55 -0800 (PST)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Richard W . M . Jones" <rjones@redhat.com>,
 Ilya Dryomov <idryomov@gmail.com>, Peter Lieven <pl@dlhnet.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fam Zheng <fam@euphon.net>, Ronnie Sahlberg <ronniesahlberg@gmail.com>
Subject: [PATCH v2 18/19] null-aio: Run CB in original AioContext
Date: Mon, 10 Nov 2025 16:48:53 +0100
Message-ID: <20251110154854.151484-19-hreitz@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251110154854.151484-1-hreitz@redhat.com>
References: <20251110154854.151484-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

AIO callbacks must be called in the originally calling AioContext,
regardless of the BDS’s “main” AioContext.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/null.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/block/null.c b/block/null.c
index 4e448d593d..253d20ccbb 100644
--- a/block/null.c
+++ b/block/null.c
@@ -173,18 +173,17 @@ static inline BlockAIOCB *null_aio_common(BlockDriverState *bs,
 {
     NullAIOCB *acb;
     BDRVNullState *s = bs->opaque;
+    AioContext *ctx = qemu_get_current_aio_context();
 
     acb = qemu_aio_get(&null_aiocb_info, bs, cb, opaque);
     /* Only emulate latency after vcpu is running. */
     if (s->latency_ns) {
-        aio_timer_init(bdrv_get_aio_context(bs), &acb->timer,
-                       QEMU_CLOCK_REALTIME, SCALE_NS,
+        aio_timer_init(ctx, &acb->timer, QEMU_CLOCK_REALTIME, SCALE_NS,
                        null_timer_cb, acb);
         timer_mod_ns(&acb->timer,
                      qemu_clock_get_ns(QEMU_CLOCK_REALTIME) + s->latency_ns);
     } else {
-        replay_bh_schedule_oneshot_event(bdrv_get_aio_context(bs),
-                                         null_bh_cb, acb);
+        replay_bh_schedule_oneshot_event(ctx, null_bh_cb, acb);
     }
     return &acb->common;
 }
-- 
2.51.1


