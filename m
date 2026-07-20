Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3D51C44524
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 07:57:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlirP-0003d6-DA; Mon, 20 Jul 2026 03:56:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wlirO-0003Yd-Al
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 03:56:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wlirL-0006jq-Pc
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 03:56:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784534179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=COHT7p/iqsTdPamcZicw3oA4ocmXtjDA5E14rv82Tas=;
 b=dE1oyd43t6NRm7CdJ0494aNUwuoLcfGDch+Iasrb4m5N8+ty0MryUdpHxCJwhVGN9Ibyx1
 HNU33IE3oN7mTeXi/+nRo3ODTx47dvEAMrk3w7egKgwYclXmavvij1dzH5JLwH7D0d51oz
 fjZDrFALUfcxzKDghD0n7PqLvaeFU/Q=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-329-1ephcCtmPOaVdVcRD1KrdA-1; Mon,
 20 Jul 2026 03:56:15 -0400
X-MC-Unique: 1ephcCtmPOaVdVcRD1KrdA-1
X-Mimecast-MFC-AGG-ID: 1ephcCtmPOaVdVcRD1KrdA_1784534174
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A9EA41944EAB; Mon, 20 Jul 2026 07:56:13 +0000 (UTC)
Received: from localhost (unknown [10.44.22.17])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6F35E1955F73; Mon, 20 Jul 2026 07:56:10 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 20 Jul 2026 11:55:31 +0400
Subject: [PATCH 2/8] migration: fix qemu_get_counted_string annotation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260720-co-v1-2-fabb4db3c204@redhat.com>
References: <20260720-co-v1-0-fabb4db3c204@redhat.com>
In-Reply-To: <20260720-co-v1-0-fabb4db3c204@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 John Snow <jsnow@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, 
 Fam Zheng <fam@euphon.net>, "Denis V. Lunev" <den@openvz.org>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Anthony PERARD <anthony@xenproject.org>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 xen-devel@lists.xenproject.org, Li Zhijian <lizhijian@fujitsu.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=799;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=N6+L/HnMPoOeFVHLSkUq4poAfMYUnwCM4couCI5iOrU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqXdSJlx+ej+bpFQ3bSPwwRWhu1sAyEaprMReIu
 r6EYhcqf5uJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCal3UiQAKCRDa6OEJdZac
 5RAIEACPwUGNBa4OSzulBfcHmirufW7Q9ZWtVD8WRKl4QUwYh0x8Vw0wi8AIy8fzd4vXzHG+9SU
 iuJwNvxODCPewrohwvuzDEFNhfj/d80OL7s1wW4zuYWr3mt3I48r0HpBZrG6GFx/fh+JKh/lV9V
 yHM74KG/iXF33Qf21gOX2aw/KCFAfGjQ+YgMRf8j55j3uoZOV4rA4KEho/PctuD0xF8GPfRLBUa
 V4gpAf8InyTVps3Qj068taPoy3njqHXwytycp4WeAG5Cr3DG4QP20zkw2ufPGebXcbm9WlkW8Kj
 lANa4PkcYh8h6j6oWGX6Tp27ajZeemLSXckz0ZtPS1cVcoWquGHMHe+fBJMisXqkkRawGqShLQ0
 9aajHGOdymqfU7zpvfYOKwyhW9YuCLeZ1am7ukvgliGx0pa5mAVUARArVHBV8XY2Wg2Rao3IPFs
 a9TW6Y5biJGr3YAKMD6SkBXZzq+86hHy/LFyOw8G0iMixpfLkvb7L3yROPwHKC53pa+xUIIfEkZ
 SA6L6R04xlo7Pyt5ShqF80J3DWQjzHwmr5tgOOjiAXaP6HLGUimlycrzPfKsC0hEEGdvVzzmtSK
 qxwC2l46fIJFl/BebrwRX2f81u5r8fg9dW767+2Wb9FQ8HUHoxPKpKXBDAfBPHEhPX6Ufv1LWIi
 NwJ4kSn5fS9vNnQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
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

Fixes: 394b9407e4c ("migration: mark mixed functions that can suspend")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 migration/qemu-file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index d5a48115bd6..f30e13c66d7 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -830,7 +830,7 @@ uint64_t qemu_get_be64(QEMUFile *f)
  *          else 0
  *          (Note a 0 length string will return 0 either way)
  */
-size_t coroutine_fn qemu_get_counted_string(QEMUFile *f, char buf[256])
+size_t coroutine_mixed_fn qemu_get_counted_string(QEMUFile *f, char buf[256])
 {
     size_t len = qemu_get_byte(f);
     size_t res = qemu_get_buffer(f, (uint8_t *)buf, len);

-- 
2.55.0


