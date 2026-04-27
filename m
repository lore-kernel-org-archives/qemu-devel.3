Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB294FF8867
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 19:49:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHRuu-00038R-FU; Mon, 27 Apr 2026 15:46:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHRuf-0002nx-Qb
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:46:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHRub-0000Gv-Lv
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:46:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777319193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P0KOMOV2ogglfBJzbaKZEamIRSJ3b0RsobP2ZvazQx0=;
 b=Ac0jO+erCTCFHnkItgONE0ulGfORY+UfSjbTbOgZJB+FrH+OM7U8X4iLlIzNtottM88qo+
 nOEmhh62KWHfsu0K340y9zTBmOXMrK9IIRt1qH8RCjRaW1WkjTX/n2G15Vfys2u18oco4S
 lW0HoBbTLZkNo4rqAls3H1o1nqohQGg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-596-e1jmEIloNt-gV5R66mKh2A-1; Mon,
 27 Apr 2026 15:46:28 -0400
X-MC-Unique: e1jmEIloNt-gV5R66mKh2A-1
X-Mimecast-MFC-AGG-ID: e1jmEIloNt-gV5R66mKh2A_1777319188
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D87181800282; Mon, 27 Apr 2026 19:46:27 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 781A7300070A; Mon, 27 Apr 2026 19:46:25 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Apr 2026 23:42:39 +0400
Subject: [PATCH 40/41] hw/i2c/pmbus: fix undefined behavior in
 pmbus_direct_mode2data
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260427-qom-tests-v1-40-c413f3605311@redhat.com>
References: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
In-Reply-To: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Titus Rwantare <titusr@google.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1137;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=2dC++hVlKU9GL8wkcDvF8pRIuTJVc02X3ZdB8ioXtmc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp77wWCSMLWSFlL5vt4DE7S0EM5qpi04Dpc02qu
 p6FV0ylYJOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCae+8FgAKCRDa6OEJdZac
 5aqGEACx0uhHWEOvrKH+OM/eJnMfLtK/oZ2FIQ06+ockve3mGc8evJRD6BiAD6iCEwLqKCuxT/J
 A4YMSPcegVtKYcFNcPYGogfeMIQ3KWDKOhuOmXHBCh2EBlEABp60YnPFb93dMCwbD3LsSllmP/2
 WXGMoAOmoHM7LPRulsKa6AFsQYZbrehZcJYt+cXwDpKa0rMJUHGs1VQ8PQBhDsJRCESEfGgPDhi
 dtsO1SX3ILQOQ7fValcvDFkKWxVNnXdKq5EfTKKy+VzT5bAisceOddWJsPcdHT5GIoBQLaz0K6/
 ZbapY7KqiC5yDY4hF84hz9aeeK6Ar8zOOmo+wnkYvr3C1Bs489Unpli9Uk2BJZGeZPvkfTncgM+
 U286pHCRVv+0Ngi91sNuB9Qrf/rvlDAQelxUimNZPj73Vu7qpJpzJK8vAutlLGKwBf8IM4hTEqy
 F0Wdcg6qJUiqtPhYWi5ZS6+PO9QIF5H+7+1iu7EDqs3vukoA7U2VV+7KMCd/x2LeI41H/yu0SK+
 PL10FcYWCS6Kok/b2djb7SMv2X2m1yxakQspVPnc6UaXuFdYDZURwSgGu7nI7rdOBQyb9/GDNnb
 1iwKqkTWmdd/Bs7GbtwDDEH44myq5pLgWDg7EXrpeI9koKc3ANE2cQlt96CWUHthMLvnLr15kMi
 n630XJ939sJxjXA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The intermediate result of (Y * 10^-R - b) / m can be negative when
the bias (b) is large and the raw register value is small (e.g. zero
on an uninitialized device). Assigning that negative double to uint32_t
is undefined behavior, caught by UBSan/clang.

Use a double intermediate and clamp negative results to zero.

Fixes: 3746d5c15e70 ("hw/i2c: add support for PMBus")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/i2c/pmbus_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/i2c/pmbus_device.c b/hw/i2c/pmbus_device.c
index 853dc4b4342..861f5b4fb63 100644
--- a/hw/i2c/pmbus_device.c
+++ b/hw/i2c/pmbus_device.c
@@ -23,8 +23,8 @@ uint16_t pmbus_data2direct_mode(PMBusCoefficients c, uint32_t value)
 uint32_t pmbus_direct_mode2data(PMBusCoefficients c, uint16_t value)
 {
     /* X = (Y * 10^-R - b) / m */
-    uint32_t x = (value / pow(10, c.R) - c.b) / c.m;
-    return x;
+    double x = (value / pow(10, c.R) - c.b) / c.m;
+    return (x > 0) ? (uint32_t)x : 0;
 }
 
 uint16_t pmbus_data2linear_mode(uint16_t value, int exp)

-- 
2.53.0


