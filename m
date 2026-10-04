Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB417CA5FCE
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 10:26:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDJQE-0001Qw-Eu; Sun, 04 Oct 2026 06:26:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJPl-0007qt-92
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:25:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJPj-0003MI-K4
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:25:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791109550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aO1cnU9hscYla7Ov0+lLi8H+wuRqEv3EcxOfUFAUq7c=;
 b=YhBswSxCHp9t097sdV9J1on0VxjZhQ/T5GnS4BqpzpQxRK9uOUwe7LOQB2zZPe/HCBt8K2
 x+KTPN46L7iFcp/Mg/Z0NKqjRFW5vFtA5w3Hjikd+REoKbMQk4uLDNM5sJgaAW7HMC1LxL
 uKpS2x3NOCtkDWxT+C/EMNqn43zB9DI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-x-eJXz4JPQaIZWiHCYi5wg-1; Sun,
 04 Oct 2026 06:25:46 -0400
X-MC-Unique: x-eJXz4JPQaIZWiHCYi5wg-1
X-Mimecast-MFC-AGG-ID: x-eJXz4JPQaIZWiHCYi5wg_1791109546
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E42F91800361; Sun,  4 Oct 2026 10:25:45 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 237011956089; Sun,  4 Oct 2026 10:25:44 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 04 Oct 2026 14:23:50 +0400
Subject: [PATCH 36/63] hw/char/sh_serial: fix RDF flag clear on FIFO reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261004-issue-4560-v1-36-ccbef537cbeb@redhat.com>
References: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
In-Reply-To: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Pavee Hui <phui@google.com>, Yoshinori Sato <yoshinori.sato@nifty.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=971;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=A39lmd3PAo+hALb5Gr7iBgWMDJ07O7/V3n+4JvVJMbE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqwikjvCuO2nF5yIm5NvIkOWhEijXW5xqsG4ZLW
 KbSLrg6WamJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCasIpIwAKCRDa6OEJdZac
 5TGoD/0f/+deWgc0sBzedIjUVflMN1hAPU3lerCJia4ZxDL2AUldZ0QEYtF+XQU/ggoqHwZ6Ou5
 +M6BKdkITYTT/8pOicIJEGUF73Shqp5C2I14ZvwYW64Uel+wsTCJsdwMyPQ3vIFwgSxhQ67t2wf
 SWcDF/ZHVOEPBRe+Wt3RuhzB2BZvtv9m98c9HpXiLRTa6tThDGHtLR8F8wn6OvHtxuVx7+p5X7Z
 ndoxtrkf4U0CiC/K+9AeJY77UW5LEJpLgvTQ0VDI/lUbrjg7Pu711klsZIQD/xD8NHAz/KUfdPd
 3Lyitv6eHGs3eByuLgDUuzOYNgs4QYg5KO9ea/xRQZ8QVzwCE+2jeyN64qvhBSMj+4qgyUinydE
 n87l94yN+Y0BDwo4tCqutuhCptCMYeOWUp/o270AZKnkf4kt9T0DLuZmViO0yIyUQsqIk2OJ9ra
 GSFtNCY7GKKD61JXS/h2xHWzXcZ6EcsB8OvbGL03AgBEp1p0i/Lpbz9HCxoh0A7br9AD0NwZBaX
 qM/uzst9X04SZ14BVj3W8PZuxUdsQW5bkF+y5Dj9Iqh3ZyOWAEEXCjimAIYIwAPvwvyg3kJIsGS
 +URtjLrwE5WPXmn0BYgWIeDlKJc7kFdGNXyq6vEdtM5mVaZXssTDBa9bBRnSduB+aqy7MnGLCIX
 wU2xU1pzazIk/MA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The FCR write handler cleared bit 1 of the status register (sr) instead
of the SH_SERIAL_FLAG_RDF flag in the flags field. This meant the
"receive data full" condition was never actually cleared when the guest
reset the FIFO.

Reported-by: Pavee Hui <phui@google.com>
Fixes: 63242a007a18 ("SH4: Serial controller improvement")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/char/sh_serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/char/sh_serial.c b/hw/char/sh_serial.c
index 10f96e3a44bc..30a22ea2d1c0 100644
--- a/hw/char/sh_serial.c
+++ b/hw/char/sh_serial.c
@@ -175,7 +175,7 @@ static void sh_serial_write(void *opaque, hwaddr offs,
             }
             if (val & (1 << 1)) {
                 sh_serial_clear_fifo(s);
-                s->sr &= ~(1 << 1);
+                s->flags &= ~SH_SERIAL_FLAG_RDF;
             }
 
             return;

-- 
2.56.0.rc0.29.g47ce80527c56


