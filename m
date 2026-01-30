Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8D95E6BF06
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 12:16:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlnOj-0003nS-Mm; Fri, 30 Jan 2026 07:14:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vlnOi-0003bg-M8
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 07:14:48 -0500
Received: from mout.web.de ([217.72.192.78])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vlnOh-0001ua-2F
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 07:14:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1769775277; x=1770380077; i=lukasstraub2@web.de;
 bh=M2jFhXPCX0sbCrhLuma1ApN2w7hxb6oUVP/cm1G3QCw=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=Vq9+ePF4jzGFDEr4p+LEreC4jSjZbicUU9uhT+/MSLLsDUIFNo1QPEKeDvu2n2OU
 Xpsy0J8j3Xj6pZ+xjanlEDtaQnoia/vVXF7oTYmLOo3iZ6A3Q/Oj9f6Jsf9eNvWan
 WVSN6isz564EL+aYcxOc8gf9oVZeKtx4Ibdi/+38zTXVUqNTGflvREokTiZuR3FC+
 R8+029Nl8nC0k9WB/QqD9CdKiELTxP41YI7LFoDcRwrO6hk4pPR+5OIJfvm9XF7Iv
 ikGvzsfvAhIhlpXG44DmhpizGf1SbXI1NgvXeYUHaxiEM2jXpl4G9tq0cUsgvyP7u
 11yW9dKeEQGPxembfw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([217.247.97.172]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MCol0-1vcxgr0Gem-000Jyq; Fri, 30
 Jan 2026 13:14:37 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Fri, 30 Jan 2026 13:14:19 +0100
Subject: [PATCH v4 11/16] colo: Fix crash during device vmstate load
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260130-colo_unit_test_multifd-v4-11-7115ab6f0e77@web.de>
References: <20260130-colo_unit_test_multifd-v4-0-7115ab6f0e77@web.de>
In-Reply-To: <20260130-colo_unit_test_multifd-v4-0-7115ab6f0e77@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Lukas Straub <lukasstraub2@web.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1145; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=hNCOCvljjAHxBTXF7n8RYho9qkZfmlDlYGy0wK00HjU=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpfKCmd5hbPXKETL7gpyz9iGWuLOuGvd1gXZD4x
 8oyjECtYPqJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaXygpgAKCRA1qwsonF2y
 WFRFD/sEIB+juM86TniaBJmwIHlMpe+JDDGaPiX6KdqksqDrzcLggt+GQkrdFnH5lbsrInCnezY
 7//Iq1lh4LB7M1r0JU2uQWsFPmrHdgQy10gHPIUbguoHDvsUDqKtFZL/tQZRC6UuUp27ZzeW159
 VGs/3pGnaUSxL+Kp0AiJ8HKdVbK2NePCb2rnDyCpuyCu5wbEuuRyEMQ6ottgOlwITk9ZI8Q3GLN
 cW7GLcejgde0V9k4n8273Ne6GtrjZ7W480nSEyhsV/GHOZqCksWzLeN2qpdWiAOi1O9ZWdbU3NK
 EVK3msO3zF9DBWdDhzv8EKNzpKDVGKZ1g+bQOJ/kX3/B40dJg45lGolLvvAroVcBX/SK6qRu6vR
 Ycy6JFXjqN9a8TlYs08jO/gqN5RlWtsX2Xx26H9UaUq8D6LmtuB/0d8/hfRqQHmkHihoIuVfGUT
 hxd8L3E6LrTkTWPlGNSNXDbxFb/iT7ngwTqFs+HJypsQfblEGASlOHmF9ZuWDhTNf4KLJ5Y1HQW
 1sSx1OB453T76CbKZgCKLKfnRfyyxjEmjsSNQ+D8NHXgM0ruUHEDIBJ0fJdK+ICtaEQDvrErrGq
 21CG3FJlLOZGcuWERoNKjxiz0E7NkBteZm31CTWY60daw+/t6abYaBEkUQyzbVHYX0xP6r2doGA
 b7rcauFr7Oo5jcw==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:gydLbEC98ei7UkPvPh13g3NQRlHdcj5H0rdHTAP70bBqrgCcFry
 Zu0Jv8cEd+EWGAeCR9fLCrBolAU+lFDHZWFKuw0Wq/P03cWMfBJE1NBZM6DqIjKjX7nIggO
 0yavdqaj6r4o63ebmPx8BlL9uGgXbAOf1//GdC7ykkqSI1fpvmnoN39iUJG3PssBSia1Yb1
 WhNhiWbnVLwDjiBGdaO8g==
UI-OutboundReport: notjunk:1;M01:P0:vq5wLGAL/EE=;+kIFPg/5gmgq9rOcQz+qGHr12K6
 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
Received-SPF: pass client-ip=217.72.192.78; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

With colo we load device vmstate during each checkpoint, on top of
a vm that was already running. Some devices expect a reset before
loading vmstate on such a previously running vm.

This fixes a crash when using COLO with Q35 machine.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 migration/colo.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/migration/colo.c b/migration/colo.c
index d3534d1a32ad82f02101ac092ebf818a0caee6f2..afab8eeb14d09c1db9b235121c=
5845b11a80deba 100644
=2D-- a/migration/colo.c
+++ b/migration/colo.c
@@ -727,6 +727,12 @@ static void colo_incoming_process_checkpoint(Migratio=
nIncomingState *mis,
=20
     bql_lock();
     vmstate_loading =3D true;
+    /*
+     * With colo we load device vmstate during each checkpoint, on top of
+     * a vm that was already running. Some devices expect a reset before
+     * loading vmstate on such a previously running vm.
+     */
+    qemu_system_reset(SHUTDOWN_CAUSE_SNAPSHOT_LOAD);
     colo_flush_ram_cache();
     ret =3D qemu_load_device_state(fb, errp);
     if (ret < 0) {

=2D-=20
2.39.5


