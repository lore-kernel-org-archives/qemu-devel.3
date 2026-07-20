Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 010D9C44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 07:57:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlirO-0003ZZ-Hf; Mon, 20 Jul 2026 03:56:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wlirJ-0003TM-9H
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 03:56:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wlirF-0006jM-VF
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 03:56:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784534173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IjhaPEySj2ajiT+j39JgZYAcWp9YnSZM59v8er2az0s=;
 b=XUn4+4IcevL95IWFAa50eXx8RX9m+UmgpqOS8/YBC4VIpYoLXlhrTVrA+J6ED0bKUkIsld
 BbLnEEq3rYBSvpLuBF/vnKP+ZeMqd7hNXtXpne++SZkELCR44Vzj5W6B0ySGg4kiNj6IRw
 n2VC+8erkH9jPr5DVIQPkTvd9KLstmk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-284-JgVuit-kMgK1jPYX8qS_FA-1; Mon,
 20 Jul 2026 03:56:09 -0400
X-MC-Unique: JgVuit-kMgK1jPYX8qS_FA-1
X-Mimecast-MFC-AGG-ID: JgVuit-kMgK1jPYX8qS_FA_1784534168
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2C2E5195DE19; Mon, 20 Jul 2026 07:56:07 +0000 (UTC)
Received: from localhost (unknown [10.44.22.17])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AEE44158C; Mon, 20 Jul 2026 07:56:03 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 20 Jul 2026 11:55:30 +0400
Subject: [PATCH 1/8] monitor: annotate monitor_qmp_dispatcher_pop_any() as
 coroutine
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260720-co-v1-1-fabb4db3c204@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=741;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=yCQTIOZ3vdGSd0wX9FrJ+Idz4YTHnIHGhg0Q7MfK0Pk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqXdSJm3lJfJ6ohY7uz1cUw8l9YT42D+RXR3qnr
 vkvsHJbEpaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCal3UiQAKCRDa6OEJdZac
 5fkOD/9cRo7MNM4+pqSDsys8gDgW3GuMHh1KDecO9oSlPlFqHPZR8xKJW+UBUPeBLfzWe0SkXVM
 EgwtKvxHf2nJFxJIXoQ3RmYPXZvcu0bbwW09aoTgffW0SvZ90NvdVu5gGRJL77VN7OX13se0qrk
 Nq/FOmPbOi7mlgoQJR2E0tP3td6Pm8T1XtUwoDEDFu+jTS7UUPU7nCNtgL9R8bnpp2ZeYQ+t73l
 jBkM71m6SEkFlWlnmb/EYAedmt/GVhFMfty1Jw32BLdWR5cVsEK+PcKuPluonj2ieIUEyrSnFzc
 nx0SYxXkUVKwQLSgvhaTUREGh1tsD1mic9T97mHZXIdXUtjAPfpF07kbvHFAGGQBpRv5I+fw609
 IF9jB2Ca7v11FvsXm+u2dAservR9BMb14AIdjuPXfFdAFvqkvNoHAqyHojAjgLLFJJ8O2elle1B
 W1og6muJNAUKv7Whp4O6iogUgKaWqfyq+Cxv3v4nmywF80qu3q+gZw42NQg9q2bYR1CtlYN6e22
 +cVsnQvg4S5XHkx2WF0quyrrz/K+xm15m4e0PrLWvLm+MivthT3jm0FDbf5x58HGlcJf7/ALfV2
 2UvvhgcA6bBTr9KZj/idyZw23D4534bk/iDP1Knx34kY6MkQV3ZNsoNln8fFL63llOBZynv5swW
 M1sHhwUCyZ0bglw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

The function calls qemu_coroutine_yield(), and is called from
monitor_qmp_dispatcher_co().

Fixes: 60f4f62efeb ("monitor: extract request dequeuing to a new function")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 monitor/qmp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/monitor/qmp.c b/monitor/qmp.c
index 223e0643c2a..338d37cb7e5 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -342,7 +342,8 @@ static QMPRequest *monitor_qmp_requests_pop_any_with_lock(void)
     return req_obj;
 }
 
-static QMPRequest *monitor_qmp_dispatcher_pop_any(void)
+static QMPRequest * coroutine_fn
+monitor_qmp_dispatcher_pop_any(void)
 {
     while (true) {
         /*

-- 
2.55.0


