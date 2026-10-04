Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A94EACA5FCE
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 10:27:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDJPp-0008BK-7f; Sun, 04 Oct 2026 06:25:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJPd-0007Xf-Qz
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:25:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJPc-0003Ll-Cf
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:25:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791109543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LznLPZNigXaIitkk7V/THghYe5BCWR5CvGtYpm5mJzI=;
 b=cpO9MzaAMd3Zo+CLskXcnT48ihPEgO0XnUuQ6FeIMSb8kl0xqxs4nQ/jNJzB/lGkF16fBi
 q7nntSZBmxll2vR7L9EZ+5eozoOOU7zSoHMzH2npc2dmYbRCOg1uhvwHUuPGh6wdKmJNA1
 ZSKZA5pqY6iBujFuhmDMMYK53tQGCIE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-319-BDiW8Y46M2iCjp8XgmYJng-1; Sun,
 04 Oct 2026 06:25:40 -0400
X-MC-Unique: BDiW8Y46M2iCjp8XgmYJng-1
X-Mimecast-MFC-AGG-ID: BDiW8Y46M2iCjp8XgmYJng_1791109539
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1C8AD195410F; Sun,  4 Oct 2026 10:25:39 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1283C418; Sun,  4 Oct 2026 10:25:37 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 04 Oct 2026 14:23:48 +0400
Subject: [PATCH 34/63] hw/char/imx_serial: update interrupts after status
 register writes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261004-issue-4560-v1-34-ccbef537cbeb@redhat.com>
References: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
In-Reply-To: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Pavee Hui <phui@google.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1412;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=JxGPGVg7QZA/OsUv7NFpoXm0d3HC/czC0QUUyMXs5aU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqwikjenEZa64aom7JxQ7hhHkrZphyktVXR+wVb
 V253E9vWwmJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCasIpIwAKCRDa6OEJdZac
 5Y1kD/9poL9Gyxb1itS8762nsoPKuweHBUHjXwuyru5xOaYWb7XPHU1NhJgpn99kq1fmBaH7NBA
 W28yRpA97XXuapo59UWJXSEWlqnek0lHwdQdy1DWePcUIXDaJu16DYs0ODwQkalpCzCWZ4xQ2z5
 ZTunQOxz0jYXZ2X1g68l633OeppcbR2hEQ8yvMPDoYL990VRc2bRN0YF/PflsGomEI+ng6v6Z7/
 ZSQ3pKw9B+bcI4KiW1O7GMPobMQzVoqVEaz4fQTyWgN78+PYmVPlXUBTxO7rlTlWvkJFDRacOQ4
 7c23AiOtSAMIyS4c0fFmLH/TprhtPWrkAazHtowsjWuVautIdltOy3BxzSx20zlhRb8sKRw0SRY
 yc8ECpOlqQ1s/V8TjVmMSBnhnhLv+lJbThBdHuHZcCTIu0Tl/RKmFhfDQIoMNlRS9eM6cs9tX8B
 Qq4roRWV8VWkq+aqYkJpRIOiigWNf4HH+bavVLoAs3DRDQjw60jsksT5Fu+v56FLOWgJsdE/zkC
 XtXAxMyqRHNLRTt3Rgr7vk7rBeopDXjQwvLPaBQQc2+2vuV/fou1eJmDjf0rljrAGoHSnMhJjsl
 Nvdsk75hzs/uw65yiiVmNl9GVmjY6tRcEkMebSgoWCZLtqkAujE1DrFUeFL/95I3Jk49BV4TC+w
 J5XllU6ftRD26GA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
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

Writes to UCR2, USR1, and USR2 modify state that feeds into
imx_update() but did not call it to re-evaluate the IRQ line. For
instance, a guest clearing a status bit in USR1 (write-1-to-clear)
would not deassert the corresponding interrupt.

Fixes: 40b6f91151e7 ("i.MX: UART support")
Reported-by: Pavee Hui <phui@google.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/char/imx_serial.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/char/imx_serial.c b/hw/char/imx_serial.c
index 8ac4efbb5e98..7a3d575c964d 100644
--- a/hw/char/imx_serial.c
+++ b/hw/char/imx_serial.c
@@ -324,12 +324,14 @@ static void imx_serial_write(void *opaque, hwaddr offset,
             }
         }
         s->ucr2 = value & 0xffff;
+        imx_update(s);
         break;
 
     case 0x25: /* USR1 */
         value &= USR1_AWAKE | USR1_AIRINT | USR1_DTRD | USR1_AGTIM |
                  USR1_FRAMERR | USR1_ESCF | USR1_RTSD | USR1_PARTYER;
         s->usr1 &= ~value;
+        imx_update(s);
         break;
 
     case 0x26: /* USR2 */
@@ -341,6 +343,7 @@ static void imx_serial_write(void *opaque, hwaddr offset,
                  USR2_RIDELT | USR2_IRINT | USR2_WAKE |
                  USR2_DCDDELT | USR2_RTSF | USR2_BRCD | USR2_ORE;
         s->usr2 &= ~value;
+        imx_update(s);
         break;
 
     /*

-- 
2.56.0.rc0.29.g47ce80527c56


