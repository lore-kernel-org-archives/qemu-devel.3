Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC19AC5321C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2026 09:50:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnZ05-0000ct-Tc; Sat, 25 Jul 2026 05:48:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wnZ04-0000ce-Ai
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 05:48:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wnZ02-0004TE-VV
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 05:48:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784972934;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dPp6/Iz6emP9faagVMHidtrIEEZa8zoC+YjDWgEts3k=;
 b=WZAjdlbIX9qW/vnhIMoVW8P1fbgxdtlfEzwOiSL0U1iC24U/zlhK4fbMv3ygS5zf7Io6x3
 EXVu8OM9qB0NrXtM0sA9UmXHkhvRjK6kVXPJ/5brpVvt7ktvrcmEECssfuKWycqte98+Ik
 ah/12j/60crB9zabXgyUqWrSuF5rfmQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-481-hS19_nqnPV-v5GQmSfJy_w-1; Sat,
 25 Jul 2026 05:48:50 -0400
X-MC-Unique: hS19_nqnPV-v5GQmSfJy_w-1
X-Mimecast-MFC-AGG-ID: hS19_nqnPV-v5GQmSfJy_w_1784972928
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 61DA919540CA; Sat, 25 Jul 2026 09:48:47 +0000 (UTC)
Received: from localhost (unknown [10.44.22.7])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9ED03180049F; Sat, 25 Jul 2026 09:48:45 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 25 Jul 2026 13:48:32 +0400
Subject: [PATCH v2 1/8] monitor: annotate monitor_qmp_dispatcher_pop_any()
 as coroutine
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260725-co-v2-1-d3552ddb3931@redhat.com>
References: <20260725-co-v2-0-d3552ddb3931@redhat.com>
In-Reply-To: <20260725-co-v2-0-d3552ddb3931@redhat.com>
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
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=859;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=u5SYt6HOlXpoYkBe8zmUhNbcCVIM7I1SQQWsPqoY/1g=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqZIZyN05xG4NXEjp7mfqsDyp6EpYKKkClYQD6/
 vLFKlVVeWKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCamSGcgAKCRDa6OEJdZac
 5bmAD/0etydKiTihIbMRuX/QQ9wrH5bzVGnC+3T31ACvjR4qTcz/43bEIlxz5UP6OLL+J8FdHoY
 /COMIj4ImeEQTd8X6VM6tIgL0lP0Ix3JBRw585jIfUcBtcbe9WBYp8GuBQ/J70zcai5YSbBjqHM
 YcJDYDb0fupMLYz7uMfjEYEt+LMRExfvUZowMek7pLggUHuObZ6PBcMo2KiLk/9BkxYXmfh1Py0
 1VL9qz9VJyrx/9mKA6AMfZAlO7X6w8Uhb4OvPQdS9yaheMGMMNof3XXs/7rMEJp8yu5hw2yGwKV
 tUsWdgRxcW9oikYq1xs8FJGEQuxJcWevVMUKgtOMxvcog53d3aqqDPPxbODdQqaoJh77uUWtx1D
 yj4W1GWLrjNuNMWfW52mst+gwenpI7ERZPzJyjqyKIGq64C1D8hoRUe9SZBfMDvW88CYeoJy6Ox
 AwaNB5CM37R71NilBZZJ8H5kI/MUtOfRopA2tI1rzxTYPuk+2s8SRyajUOzEobyjYVzzJah7xnl
 Fj5LczdvoJoLDlx1Sg4jKKJgUd40UBCFw2k1dmKZAIeGgMP9qHpQl+7Nzu4E4QnzYqRcDNMlZ4Y
 mFu0qczXin1ELgN8KEVORoq5zbeou4KrGwVpb6sgnQGCa2zrR7zGbbLdFpOc3+fxpACvCzuNLVv
 yY86AryIhC9/2WA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.419,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 monitor/qmp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/monitor/qmp.c b/monitor/qmp.c
index 223e0643c2ad..338d37cb7e5a 100644
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


