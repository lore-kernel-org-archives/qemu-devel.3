Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A5EACD6E75
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2026 05:18:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVjPj-0006UG-5G; Sat, 06 Jun 2026 01:17:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wVjPh-0006PN-Dh
 for qemu-devel@nongnu.org; Sat, 06 Jun 2026 01:17:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wVjPf-0008PT-Um
 for qemu-devel@nongnu.org; Sat, 06 Jun 2026 01:17:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780723059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7Ah0WHWmKz0+75Y+bK1794xcADk+Gy/ok0cQpjpA/gI=;
 b=bUYFVlEVTDtW+C4L2ViJECk7fJq9H2+2IZm/0s3PG4S/Dj1aP7M76fL6h67eutOS1iuWEG
 rDSJnwli46s3ZDMj0+p30NBKm0YEUe0cpind7/s2mv9auhyhJc3Ikmg5lGBThbWFLsb+n/
 Q4WUf4tyM8naI5SDCtORv1pXQ7Ur9DQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-323-au0sKjbQM5qD8MBEv0lM3g-1; Sat,
 06 Jun 2026 01:17:37 -0400
X-MC-Unique: au0sKjbQM5qD8MBEv0lM3g-1
X-Mimecast-MFC-AGG-ID: au0sKjbQM5qD8MBEv0lM3g_1780723057
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 27E4D1956089
 for <qemu-devel@nongnu.org>; Sat,  6 Jun 2026 05:17:37 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ABA471800480; Sat,  6 Jun 2026 05:17:35 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 06 Jun 2026 09:15:54 +0400
Subject: [GIT PULL v2 22/23] hw/i2c/pmbus: fix undefined behavior in
 pmbus_direct_mode2data
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260606-qom-tests-v2-22-55832d978a9f@redhat.com>
References: <20260606-qom-tests-v2-0-55832d978a9f@redhat.com>
In-Reply-To: <20260606-qom-tests-v2-0-55832d978a9f@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
X-Developer-Signature: v=1; a=openpgp-sha256; l=1287;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=lVMXoPQIwGHUW/fpGSA36uE1q5DyN8PE8U/Si618GEc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqI6z1I0t4OrjH+WOcUsZXGxNvHPwcRgpD2Sh1F
 LyhC58wftSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaiOs9QAKCRDa6OEJdZac
 5dseEAC5+1pva0y5WaasLMNWfptzDTVpA4EOcT0dfrxXy9FIXOQoag0eJlfMyRym7rlGVh3bu84
 +BedGCS2lpCncLYhGZRoz/0oK4588uM/B+xiJ59xQHhGJ6CmBjO69tlR55jJBXkcrAtL5o/guNg
 Y7WFctRP0sMmX3JLzr54XwsXK+qMxFk0xiqOv90DZPPRcGdNW9o+akZfMzjlt+iTezicvDP2kH6
 kVbn9GUPgZ43FNzsW3cfbydq3nq7pxK6AiwxBMCFaMZhfGx7r/7j4e154NRoKvDOW9ncRvyUFRS
 vOnsEAshrvKww1bAAfNgPHDXTP02OKeW9ZRw9UzE20h8yWYiXJ4Qmuqm0i9loh3EUhlYiK4W7tu
 YKbRKIz1ujMoUDQ7K7BxKOTAO+XfR/BTbrrS9d7pMsSQfhD0vYGwLr67i474hBxyH0tkNuXc0OU
 6jkGLvsXdCnoa5D0XU+CQJRREGGBC57aW32iQjNGrBnxn4PdHAWxEk/iONjyTXOEbSKs8j69175
 kM5u9QXx5rSstA+ZOyTUMYoktSvQoHxhw3DpKf9yayeMe5nAct8MUV6Lw5G5pflsb8rnDWhjPTL
 9eBTbI3pq2bEOnXr15FvWxqQ9r9f5rxhQWnFM2PGkJfkls58bGmINyD6+STSlrfYl5e8m+XuSsk
 OZ7FMbCXR8j6qew==
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

The intermediate result of (Y * 10^-R - b) / m can be negative when
the bias (b) is large and the raw register value is small (e.g. zero
on an uninitialized device). Assigning that negative double to uint32_t
is undefined behavior, caught by UBSan/clang.

Use a double intermediate and clamp negative results to zero (suggested
by Daniel Berrangé)

Fixes: 3746d5c15e70 ("hw/i2c: add support for PMBus")
Reviewed-by: Titus Rwantare <titusr@google.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/i2c/pmbus_device.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/i2c/pmbus_device.c b/hw/i2c/pmbus_device.c
index 853dc4b4342..b1f9843f52e 100644
--- a/hw/i2c/pmbus_device.c
+++ b/hw/i2c/pmbus_device.c
@@ -23,8 +23,10 @@ uint16_t pmbus_data2direct_mode(PMBusCoefficients c, uint32_t value)
 uint32_t pmbus_direct_mode2data(PMBusCoefficients c, uint16_t value)
 {
     /* X = (Y * 10^-R - b) / m */
-    uint32_t x = (value / pow(10, c.R) - c.b) / c.m;
-    return x;
+    double x = (value / pow(10, c.R) - c.b) / c.m;
+    return (x > 0
+              ? (x < G_MAXUINT32 ? (uint32_t)x : G_MAXUINT32)
+              : 0);
 }
 
 uint16_t pmbus_data2linear_mode(uint16_t value, int exp)

-- 
2.54.0


