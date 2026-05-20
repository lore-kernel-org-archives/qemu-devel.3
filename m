Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06397CD4F5E
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 21:51:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPooA-0006tI-Kq; Wed, 20 May 2026 17:50:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wPoo8-0006sv-Vr
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:50:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wPoo7-00046h-Jj
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:50:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779313826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0eJdJcfyGT1m9XhcdoBH46HTaYnr0mwJYyndbnLTphA=;
 b=HSCX/c27EGpvM4/WkyRQ94Ob7BIrefpZjzasBSOfIWMoOkBzCPzsollkqbHf3r0HhWO1GT
 XRcvHUBH4z97LHNXG8xL+iOyCefqVq3DoE50wUcn50D5ZqEpiKLkteuch1ymNQQNOD6KrR
 uQlqCqcfZYaloHOldCsJYtOW2m56PMc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-KCKaaaZuNZWdS3KBdo7HjQ-1; Wed,
 20 May 2026 17:50:25 -0400
X-MC-Unique: KCKaaaZuNZWdS3KBdo7HjQ-1
X-Mimecast-MFC-AGG-ID: KCKaaaZuNZWdS3KBdo7HjQ_1779313824
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 942131956095
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 21:50:24 +0000 (UTC)
Received: from localhost (unknown [10.44.24.26])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 048D91800357; Wed, 20 May 2026 21:50:22 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 21 May 2026 01:49:04 +0400
Subject: [PATCH 03/40] hmp: fix snapshot_blkdev argument type
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260521-qemu-no-hmp-v1-3-d104f809e145@redhat.com>
References: <20260521-qemu-no-hmp-v1-0-d104f809e145@redhat.com>
In-Reply-To: <20260521-qemu-no-hmp-v1-0-d104f809e145@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=908;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=cmSXXEvy+S/p9NUPm0pNCoVfh6+SHKQEGeOOZ3aepek=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqDiyCeToatH0zY34OITz8+Yr3AoljK1ZQnU703
 KvSudVawtuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCag4sggAKCRDa6OEJdZac
 5RW9D/9nWnNhp4ViH3aUMX9HbqZxVAJD3STvdMRON7ZIB+QW+BVsWaHgge+Ysc0ErUFfWY+OO+u
 alkIojIkBND3dG5i9MguHKpb8zTPQ6eiaDYEfzCNSNG+rqdS82pwbB/8BFQMAXdFdyWSwOm+EyZ
 ap+I66DOyn94BBz22CmAy4QcctzboEzRwWcuH3v4/+YVhVFi7fxr3GODrn8g0QBXiEcbOCDSg2j
 rm32aW2vL8vhje+gPvjIlJ9ofrJuohJT7DplGIHmqyGggmqDGnNFYSuQWC9znk5RVeaJWp7bO2M
 rzu8+QDtpBqbUC0HyQDeHPKi67pL/IrUIOUNZYRUrJTvxxEEAaXmQF+9a+xvKgm2hwM8nURfRJK
 6KN9K3snFcOoa4c1paeHRi93qSyOkV+C/b3XE9mTDwXlXIzjXg5ngEEhFKc7jEdlYQzq5kTvUbf
 6aYHKIxibOtLuaNXm/2laM4Eqr6k0XJTMps1V4gC+savIDTwWZ3+eW7PR56qswRq+3O8uUOVJTm
 2v1Y+zbBkypyFx5Sk4DzT2VNm7pUMf/QLOpEVlNN3FrqA1/QmbssJChiNcnEUF9waf8vfPe8/0F
 eNWotv374x0b3nvaXF+Wec5gTigogou6wp8EOjxOzWg8xJ/M7OPZygA17FOzNI5t9L6w43EjAz7
 tNPRhfGneAwwt0A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The `snapshot-file` argument for `snapshot_blkdev` is mandatory. Correct
the `args_type` definition to reflect this.

Fixes: 6106e2492fe ("qapi: Convert blockdev_snapshot_sync")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hmp-commands.hx | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index 750a2f42a80..705c8662f4b 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1168,7 +1168,7 @@ ERST
 
     {
         .name       = "snapshot_blkdev",
-        .args_type  = "reuse:-n,device:B,snapshot-file:s?,format:s?",
+        .args_type  = "reuse:-n,device:B,snapshot-file:s,format:s?",
         .params     = "[-n] device [new-image-file] [format]",
         .help       = "initiates a live snapshot\n\t\t\t"
                       "of device. If a new image file is specified, the\n\t\t\t"

-- 
2.54.0


