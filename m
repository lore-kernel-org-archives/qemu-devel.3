Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D72CC531C9
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2026 09:50:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnZ0Z-0000lB-4V; Sat, 25 Jul 2026 05:49:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wnZ0M-0000fD-M3
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 05:49:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wnZ0L-0004UW-8B
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 05:49:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784972952;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HBzav5r/PRxvX7B889078bhSww2+z17xh67+UFrqARc=;
 b=SuSivA7/HKQ4+24PKwqbYEw+t7YFhMN1q6VO13ZsB3V9861eKG0rV+onXH95QpahdaK7gE
 TyxVygE1lDZoa92IeOGJw8SY9uFP5KrpemcKn0+u3CsA7AlljqGUcW/78iSUp0jIKiwJm/
 sXlXTSq68y0J5ZhLCSU90RVLbd22fG4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-258-KQRq2d8_MVSDC6JQEZgt4Q-1; Sat,
 25 Jul 2026 05:49:07 -0400
X-MC-Unique: KQRq2d8_MVSDC6JQEZgt4Q-1
X-Mimecast-MFC-AGG-ID: KQRq2d8_MVSDC6JQEZgt4Q_1784972946
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 809991955DB5; Sat, 25 Jul 2026 09:49:05 +0000 (UTC)
Received: from localhost (unknown [10.44.22.7])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 81503300019F; Sat, 25 Jul 2026 09:49:02 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 25 Jul 2026 13:48:35 +0400
Subject: [PATCH v2 4/8] block: add missing coroutine annotation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260725-co-v2-4-d3552ddb3931@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=971;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=abdp1jnclsipbx9mt5zdr1x5wsYMVTEvTXCKXSBolV8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqZIZz9grl3rujFFr0nC5HACNLTbHVapJE30Tmf
 AxKPYXjJrKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCamSGcwAKCRDa6OEJdZac
 5b19D/9DHwTT2RdkS9aJSCsfO+Q/NGFEh9JrYG5r24XOrgePClcjmV6TX6TPmooLrmYjGYUxepw
 MS1Q/eR46z0qBQZjFcnkKGCNcmTDAezrz02GCkl0hx34GcbFD39HfIAtMBuQ1rcnsMh0QZYqVcJ
 6fwbJdczYk7txUDhNzcNggOrBEgxw4Nv3dlib8ml/eS5+Q+8gTcaPAlsnn5NRKJ8uU+Ug+LrJme
 uuhte+vOvucePU8FIfb6xLmBvizXiujdEfxytHNMT7zNW7jv2zUk0A1brsZv2lNEiCEUtaLbSQK
 W42RevaVr/PbVh7K+ZMD4EABp+13+qwcvlzfeKihasmbFrbA7KK6P/2/WaHW3+q78BeDyJdI7uw
 TzVPZT87QQFcT0U3Ie/+8z5JpDYd5G4ntBrW32oNIMc+eKVFH9a/8+9XKw+yYZZSvfbagLllckw
 OypJubbbIDZxk6TkQEcMyMZk8UvH+2N3U0OeeFn4DY7LTTW5gM8zwjHqDMDUXArkaPjnySvgB7F
 oEgFoj9skf+OzmtyuOhYCVTwErqMi+RslzhIDu5/Hy6FR6zIyA4epj3pQWfwtuUS6ek2iMw+JxD
 qmDqWeFF56u5d/lccsQqUcchkfXxlWrYfADVWRzD9om998gZ6CWAghc/uwUCzFsC2DhLTX9Cx1f
 Ejr+wyhOvjIwxQw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.419,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The function was extracted without carrying the annotation.

Fixes: 23743ab282af ("block: move commit_run loop to separate function")
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 block/commit.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/commit.c b/block/commit.c
index c5e3ef03a21b..2d52c39594cd 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -128,8 +128,9 @@ static void commit_clean(Job *job)
     blk_unref(s->top);
 }
 
-static int commit_iteration(CommitBlockJob *s, int64_t offset,
-                            int64_t *requested_bytes, void *buf)
+static int coroutine_fn
+commit_iteration(CommitBlockJob *s, int64_t offset,
+                 int64_t *requested_bytes, void *buf)
 {
     BlockErrorAction action;
     int64_t bytes = *requested_bytes;

-- 
2.55.0


