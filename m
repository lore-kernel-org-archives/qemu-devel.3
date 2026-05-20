Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B243CD4F5E
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 21:50:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPonz-0006ru-Cf; Wed, 20 May 2026 17:50:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wPonx-0006rc-Fr
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:50:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wPonw-00044d-3U
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:50:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779313815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mFuMg9Nf51Fo+RmvZ9wx8GSLjsCdERWDd+BzDg9qt+I=;
 b=VoRJsoQMAxgNy324S4ZXBYkDmOdRgDuCNw4iFTrYruCZ1neimxH3hFysBHXPRpyqpyE+Pg
 3u3KSiTBaDjwUqlzhx8ltfGmO3M5e8TAUkxioxxoAPkVIMlIrN+W1aY1WLrugb9JlizfUY
 /WMicxEl1LHxfglm93ffir9bQ9lJBzU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-395-vk9_6GmmPRyymEs5Yc3e7Q-1; Wed,
 20 May 2026 17:50:13 -0400
X-MC-Unique: vk9_6GmmPRyymEs5Yc3e7Q-1
X-Mimecast-MFC-AGG-ID: vk9_6GmmPRyymEs5Yc3e7Q_1779313813
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C9FD6195608B
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 21:50:12 +0000 (UTC)
Received: from localhost (unknown [10.44.24.26])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7E2F130002DA; Wed, 20 May 2026 21:50:10 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 21 May 2026 01:49:02 +0400
Subject: [PATCH 01/40] vl: fix -monitor none prefix matching
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260521-qemu-no-hmp-v1-1-d104f809e145@redhat.com>
References: <20260521-qemu-no-hmp-v1-0-d104f809e145@redhat.com>
In-Reply-To: <20260521-qemu-no-hmp-v1-0-d104f809e145@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=861;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=MbdsVT0QB2pfR6fNSqyjIdKPIfOJTSHpYH2VOh+5gng=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqDiyCucvsUmDvfrLcuYzWGvu9EB0nZcKfB6Hin
 IsOXksn59mJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCag4sggAKCRDa6OEJdZac
 5ZS4EAC1Lq35St2k7ZwYPLFSrGYRZn6S2R8eiCdvXsoajeghye8FB7spHhBeHUdaLajMX7hXz6T
 ZzaS9d2ZPOtesXDloUBnbceUAiaGDATRK0yOSaMdqFPP1gf05a3sb/mjtmYwG3+JCDim7Dl8ReZ
 p5a1+ulub60felMpcWxWSKzQCyZxVwxf+MXRlVX7uGZ3MbIw/lRIiUGGdX8Rf0VjzJAWRqMMNu4
 9FBr9oYr9+vODqiRI7tFaLUCyJTLfudSEQcxrIXQUdOtcXGK135JQK/kvTF26kyvoIks0gbARmm
 QuN5fzmqvlD2usbazCGWiwnw8BeVEPJQsdfy6tLqTIVmVT8BuaZi64aIZpYoG7lWXwzLABGxvYR
 QJCEbbCR3ag1hHKXe4QunHWwpADnuflcxkVYDeeTqsQfKqOQNeaeW4dYvqcykn/eJLr7GO39QCM
 jDhvWTLQ701q0+fLnPg9eGhACnbpEoRB//cnNr7QY3qG9XuKkpqAxZ32ghdgSG2/oWX6mqSvF68
 zZ/rVeTzRYO8XymxrjwytC2vZ34/rKSzztgdtVMLBipmEW9TgQUyPEBxQmtEuVD1kyZi6g9hRnW
 VO+4UMzjbO357vjFq7stFxVBFvNdL7OI8k7qSItH4halFkXJFRkfnY2H9LisgaVtDyLiG7qDUhq
 WSFW13H7+XVG3EA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

Use g_strcmp0() for exact match instead of strncmp() which would
incorrectly treat any string starting with "none" as disabling
the monitor.

Fixes: 70e098af88f ("monitor: allow to disable the default monitor")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 system/vl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/system/vl.c b/system/vl.c
index e690aa3ed8c..f4d55f0addd 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -3216,7 +3216,7 @@ void qemu_init(int argc, char **argv)
                 }
             case QEMU_OPTION_monitor:
                 default_monitor = 0;
-                if (strncmp(optarg, "none", 4)) {
+                if (g_strcmp0(optarg, "none")) {
                     monitor_parse(optarg, "readline", false);
                 }
                 break;

-- 
2.54.0


