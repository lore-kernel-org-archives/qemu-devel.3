Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D81BACD98F2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 15:26:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZs8f-0000HG-Vb; Wed, 17 Jun 2026 11:25:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZs8L-0008II-AE
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 11:24:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZs8J-0004SU-T0
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 11:24:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781709891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NFLLmTbFzn0bWMghy5IUlnpMCQHdNh4voXAbjm8vvpE=;
 b=GQY3Od8TQ9eS5g42l2j1OtNOJfCx5wDddvtEe5DEbOFiSQdxF9MKAlBB4Ll+2rvEwo+LzY
 O0ZKECWtHSPwoyVGzzLY+Kf2KDSvH5Sn1610pgS9cPxbUEdMRIGYWlPrDYEU9AEP+wWj/l
 X//QLY8GIDEwXifjUBg30p4r//ZobwI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-508-UsMywOEbNry6I0rgcWHJ1A-1; Wed,
 17 Jun 2026 11:24:49 -0400
X-MC-Unique: UsMywOEbNry6I0rgcWHJ1A-1
X-Mimecast-MFC-AGG-ID: UsMywOEbNry6I0rgcWHJ1A_1781709889
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E9044195E90A
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 15:24:48 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B9C53180049F; Wed, 17 Jun 2026 15:24:47 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 17 Jun 2026 19:23:12 +0400
Subject: [GIT PULL 15/27] ui/input: qemu_input_handler_register to warn for
 unused result
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260617-ui-input-v1-15-79e9aedc5899@redhat.com>
References: <20260617-ui-input-v1-0-79e9aedc5899@redhat.com>
In-Reply-To: <20260617-ui-input-v1-0-79e9aedc5899@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=750;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=mm8Sen1rAYQT+tDCGEUKaXUqU1jKwZd0fWekh4tNr70=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqMrvpe2ta6Baq/3JBacw6MrDllAWnY63sja1bU
 l+fVK8+PL2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajK76QAKCRDa6OEJdZac
 5a3oD/97b0D2pMHJ2MZNyAWzU0mwP7KJym++47qo3ohxY5fkapPOABAEvGV8aXYvzK5U6cNz1UH
 oagnAZBEE08ITX3z5b+2ZPRPx1WSEuQAzdkkix9DWm0EB1OaYXhEfsHScS5ic4aV4sN/eMYQ0FI
 bkiZxEO8RK8HJ44tAW2G1dwt/YI2zcGSRYxysYpWEuTxLT7x+tztijphH9+hIQCwBQZ+alOynw3
 t1DOgtDvH+kFa4kwQdB29B/c/KV3GA9RZsJFHma1+yOwfy5u0AUSqHpauZhTRLoSA5Vsr+hUP7W
 Yzcjb6THglcsR3QSfx1I4RFgBzTSXEFxZ8ufveewxLKy7yv3brzYjXA8aB+3hjET/57rZmYnFXU
 axZELonJDtYctw2Q+UoX9KeCFD+eorZfGSBG252oKuqoTt9eF4bFNMQw6myALbnijzGyPJW4Bsc
 KNkqr3z+y5+e4aTNQo7uwYzMzXGsLnnDHgAM163g1kjd+pfZSk9EuzEcn0AT0Q+N8kPPl93iwNo
 vnISO6EbBJON4eYXgCIt3/Tl22n3Dlm/lB4O/LUeHATcKIkL1Ic6o9il+6FvH+xb4843lmqMVIx
 9RzGuIxh1snwuEO9bWzoLDjcsq+dJpRWYd7M5kikCM+jSsLQipO1K34yyfc80zwjXqo8hyCRL6+
 75TUL0KTkJNpNeg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Suggested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/ui/input.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/ui/input.h b/include/ui/input.h
index 11146c92bd4..18088babe2a 100644
--- a/include/ui/input.h
+++ b/include/ui/input.h
@@ -45,6 +45,7 @@ struct QemuInputHandler {
     QemuInputHandlerSync   sync;
 };
 
+G_GNUC_WARN_UNUSED_RESULT
 QemuInputHandlerState *qemu_input_handler_register(DeviceState *dev,
                                             const QemuInputHandler *handler);
 void qemu_input_handler_activate(QemuInputHandlerState *s);

-- 
2.54.0


