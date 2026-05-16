Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71C28CD4F25
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2026 08:02:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wO9xt-0002B8-Hg; Sat, 16 May 2026 04:01:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wO9xn-00021B-Hr
 for qemu-devel@nongnu.org; Sat, 16 May 2026 04:01:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wO9xl-0007yk-Qd
 for qemu-devel@nongnu.org; Sat, 16 May 2026 04:01:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778918492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0OfyzipyaFyY1CMp4s0Vws0Sy7SQL4ehZCVUgrOMSFM=;
 b=NAl/HL6qVfiKu0bm5eFcoVEN3RvWkhYSp+ffR/YhoEPAunxkA4dW6eEzsMp4gbPpPgJlGL
 LypV45VDAk379ZelwOYAsPl9cH2C+3ZDC3ic97VlhUpKj3CZTq1NOTG0sSz3RMRUPM7eVJ
 htnUxk2K1igQxil44GWKCXWW+dHOgGI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-492-GIrYqC9kNDC7GmpINsl3FA-1; Sat,
 16 May 2026 04:01:30 -0400
X-MC-Unique: GIrYqC9kNDC7GmpINsl3FA-1
X-Mimecast-MFC-AGG-ID: GIrYqC9kNDC7GmpINsl3FA_1778918489
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BF7B819560B7
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 08:01:29 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7F6541956053; Sat, 16 May 2026 08:01:27 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 16 May 2026 11:59:22 +0400
Subject: [PATCH v3 23/24] hw/i2c/pmbus: fix undefined behavior in
 pmbus_direct_mode2data
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260516-qom-tests-v3-23-3f20c3a029a7@redhat.com>
References: <20260516-qom-tests-v3-0-3f20c3a029a7@redhat.com>
In-Reply-To: <20260516-qom-tests-v3-0-3f20c3a029a7@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1137;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=tLDFCKiyZ3IHoxFsadnpmt3a+eVCWPPwxdz50j2s6oQ=;
 b=kA0DAAoB2ujhCXWWnOUByyZiAGoII9CjBP9pOTrKkBw8FODUs+r8Sems975be0j7nkIEd+gsO
 YkCMwQAAQoAHRYhBIepvZM/h8YG0nb2Ldro4Ql1lpzlBQJqCCPQAAoJENro4Ql1lpzlvXAP/3lD
 uCS/BLbWgLZXNCVT000dA4ZKYrJUA4gHUkq8W0voMJCUH3OS2E4QbTrlHwzqWDwcF2Wp2YkhC00
 qAU65ClLqy7lQHyLJ5MA3JM5esdJtwCwJIzfN4tZK/67TIjP92dKKfalVkbeJoVT5H5RgilB1Dp
 rgi5IRRljrmXvkYYC6puwLLxqo7iauUekQr6LijOBfje48lrmlDaxLACWEvv1VGuWoevZbzI1Q0
 9QPC7YcnKcMK3Y8WpPWNhZbU3IO2YO11vQnglLoiiXUn3yXpp8b4Hvi28JdfI2j0yndSVjN/bXh
 OGtLCX+Se2XyJZjDwzaiySt2bxNzApumkH5dEChMnmnJY2MfZk3AiGbttVLblbmFlNPk+/2KJbB
 /THuSVMVNB+4y6BiFAzpsX2FWXOsqwzzC/dzNJ8Jyp4zfW3YUsZbW9miiq/KKqY+p+Q6XBJUYZx
 c8wY1o+mj0vgLI7HnbBxiCzolu43kgsO9yJjJiWDy8hhYnaBQlTDc8gi9fwhRDSONMVSpnS5/70
 TuF4z97Cqjd2WSA0z9LAjfC0jK+tbERIAfKOwRq+gkFDiPA5kbysHlqAyG5U0iFpT73PRXjqx/H
 prVAJLodAPtr+/IfY7kLBuQfurMSWst9GlJSQ5fWkyY1i9lFDF7WghOyLtS2r4tDNVRlNedNsrr
 BoRPe
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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
2.54.0


