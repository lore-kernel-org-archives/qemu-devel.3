Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07BBBC4453C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 11:25:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmV4X-0006Ql-6X; Wed, 22 Jul 2026 07:25:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1wmV4T-0006Ju-Pv
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 07:25:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1wmV4S-0005qj-CX
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 07:25:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784719503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OwIMjyFIP+qlwdPkq7veT0IMBIvjr7F/c9zAWO1v/7c=;
 b=PGr8o5WIAwQvZ8iSpr8t4xR6DOlbqCs8SomXzt5CWMHvtmaMTyR05lzhymlyOIG5s71SLU
 AMs5OTEV3QwOGVczpQj3kilEDTqWzeehglcDVN2U7BaD+iOZ6HypiE4WJEp8zy8dNF8eav
 isfBvffYDK6NU5cfykykRsgSundn3Ls=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-505-5Otf1zOAOIO_GYmm7qExQw-1; Wed,
 22 Jul 2026 07:25:00 -0400
X-MC-Unique: 5Otf1zOAOIO_GYmm7qExQw-1
X-Mimecast-MFC-AGG-ID: 5Otf1zOAOIO_GYmm7qExQw_1784719498
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 54A0B197750F; Wed, 22 Jul 2026 11:24:58 +0000 (UTC)
Received: from lenovo-t14s.redhat.corp
 (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 58C541800626; Wed, 22 Jul 2026 11:24:56 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowangio@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Laurent Vivier <lvivier@redhat.com>, qemu-stable@nongnu.org
Subject: [PATCH v2 2/2] hw/net/igb: recalculate rx_desc_len on migration load
Date: Wed, 22 Jul 2026 13:24:49 +0200
Message-ID: <20260722112449.1386162-3-lvivier@redhat.com>
In-Reply-To: <20260722112449.1386162-1-lvivier@redhat.com>
References: <20260722112449.1386162-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=lvivier@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

rx_desc_len is migrated as a raw uint8_t from the stream but is a
derived value. Currently igb_rx_use_legacy_descriptor() is a stub
that always returns false, so rx_desc_len is always set to
sizeof(union e1000_adv_rx_desc). Recalculate it in post_load to
prevent a crafted migration stream from setting an invalid value.

Cc: qemu-stable@nongnu.org
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 hw/net/igb_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index 45d8fd795b84..2a4883907353 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -4548,5 +4548,7 @@ igb_core_post_load(IGBCore *core)
     igb_intrmgr_resume(core);
     igb_autoneg_resume(core);
 
+    igb_calc_rxdesclen(core);
+
     return 0;
 }
-- 
2.54.0


