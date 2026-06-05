Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0EFFCD6E7D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 15:48:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVWlX-00009v-C3; Fri, 05 Jun 2026 11:47:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wVWki-000863-Ih
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 11:46:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wVWkg-0006hk-4n
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 11:46:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780674389;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+NL8QctavYi5DdXdHAMIZ4f9HFFB9e2UpkzCtfuk8pk=;
 b=GGFkYtmWEuSfPFPZzRO7wKMRg3gdjjzamO/zAxGvr3WOSDBM8m/1mZFDic8iJrq46N6KWa
 dK8oqiXIR97tEOEmu/tE0hd6h5aOe3xW7uQgMXgDjyrauUbz3fGOr95wVD/CzL/A5UJTOa
 QwQtHhKipCaNCT/eXCdwbiVU2Fu5lT4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-131-uTogNy5ZN2uUKEgaKL74Lw-1; Fri,
 05 Jun 2026 11:46:27 -0400
X-MC-Unique: uTogNy5ZN2uUKEgaKL74Lw-1
X-Mimecast-MFC-AGG-ID: uTogNy5ZN2uUKEgaKL74Lw_1780674387
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 125A119560BB
 for <qemu-devel@nongnu.org>; Fri,  5 Jun 2026 15:46:27 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E511B195608E; Fri,  5 Jun 2026 15:46:25 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 05 Jun 2026 19:44:42 +0400
Subject: [GIT PULL 22/23] hw/i2c/pmbus: fix undefined behavior in
 pmbus_direct_mode2data
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260605-qom-tests-v1-22-3f184f382c2b@redhat.com>
References: <20260605-qom-tests-v1-0-3f184f382c2b@redhat.com>
In-Reply-To: <20260605-qom-tests-v1-0-3f184f382c2b@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
X-Developer-Signature: v=1; a=openpgp-sha256; l=1238;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=InibdptYukTMVdGxYJf7WVxUTmIyMdBTr0yibOubUdU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqIu7VtJDZ1MM002NWjuH45Ig/A4MaCTf3tRxoZ
 Nhu2BOwa5aJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaiLu1QAKCRDa6OEJdZac
 5UO2EACgRyZpg+LK6l2kJyLITl2yMmEY8zHGmsSrfG7aj4LG9tiw5vJIXBwz49Aqg/9k7RtMQwi
 c7e3xA5UV3pcSpa4o4XVABKfRhwo6H6wwp3DUI78PWHHIy2/dlEjmf8UJ3T4MIrF92Iu2i3B1m0
 ZJaNTs7cNOPgCKmOvSHxwe0FzoafssjvmDj4hNrBaYE85qRJp+tmRsnUmXcuL68Lynhfxw2iRrS
 5M7XLokkv849CBCvpQkRrF/xGGg9rMjs2ogqUDHXTGzjimiHmR4M6+cgdzD+R3i7Y0lOu3K1HjJ
 YAV+tik/9gHZRXNe6QnuynUUplBkRSOlIhHSysXWiKI5LtwUWnVNzOYsawyzIg2gG+3F6NdaBw5
 Yp+qsjfAbIftxHhxEK2Wdr5GWGKs6wE3ZHuUvmSyvy6kCgoIKiTFqoFTr6re75IGYRO12aOQx6A
 3yLeOzJ34/8e8m73I/7ovFdf1W1LE1o1fMcVOprX/MezNWnsYDgCyBYw6/zVWLMyKqUTEY/PXxD
 Oz90HhowiHS3BjyC2uatvyyaRYK/38MtK7xJLJFgs2zJnLsioGxbHBgzIBtVmUpOpqO+JvFZcNh
 hWaYll8eks1ZBVzlkfIhknLys2qMt/UnAix3JeIDZ2J9QSjLWFbeM7SbgmAmB1QNGO5WoDmSmKr
 2oCgWhRsonDk48g==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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


