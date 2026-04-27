Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FAF5FF886D
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 19:44:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHRs1-0001VL-Vo; Mon, 27 Apr 2026 15:43:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHRrU-00017l-4Q
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:43:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHRrL-0007mG-0D
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:43:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777318989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dkX4SaBJSWzoDN/sOyJvVpRC/vSgOt3wi3wuQ84cUVk=;
 b=QepGUPc7ydkDS0Kqkk+XA0k1WNAakvGbDH6VQgAA3C0GznQj7B7BIV5SQkKFR+HiBHd3YA
 VDvASYvQeE2JpTiyU1Qc5b8IPNhl0kg5pfol558I1nBbJkDqKEAEyVVMUwGN00q9MhHobh
 puZpwNSzla2OxNO4iyXTdCPxDMMxrSI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-511-owOWmJtIOk6rRrLYNehKWA-1; Mon,
 27 Apr 2026 15:43:08 -0400
X-MC-Unique: owOWmJtIOk6rRrLYNehKWA-1
X-Mimecast-MFC-AGG-ID: owOWmJtIOk6rRrLYNehKWA_1777318987
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 423B41956094
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 19:43:07 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E0ED33000C22; Mon, 27 Apr 2026 19:43:05 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Apr 2026 23:42:06 +0400
Subject: [PATCH 07/41] qom: skip link property check callback when clearing
 link
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260427-qom-tests-v1-7-c413f3605311@redhat.com>
References: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
In-Reply-To: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1162;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=vC5EqRuLT1EHVRF50SbrOTYnlQJlgmg5h0I92toPkN4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp77wUuEHAbsYlatMksb7LilqMPlMdLwvSSQuJl
 9b1KUoGSH6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCae+8FAAKCRDa6OEJdZac
 5RYuD/sFkxlPXbMwzaV6K6bhiZH2HINk243XPDTtBVV9408K/K28p5QpmJFcCxnJPqyCF8EACkQ
 Cpn1L1irJP4EqS9YVShUOVlBDA5duSI0a+sGT396B5AM6mIScBXnNY/TpqSORTRR6WuqS4KafzY
 XcydlKxzP5HocaxiE4Jts5J1ODhVFRrEg+OCbZ7OFHP4r/gitaXslJDatrH9NidHdW2gixaR63p
 FLvWnG3ZB3k5q/6ajWR93MYE5Ahpj+34GPAu9a1Ex+d6FCTU/7E8PMyok9uPL1jZy88+1CH2pfA
 CBu8DK3e5yO1j93ykVKYTvCkfuIdVfujJyhnEfouSAVnglCNUCk0V3rAJRvePy2cpsaZjYAnQbZ
 f/T041/yRT7VoPEFtPXnoz2Cofi8TgTeEV+NXyeeuI2sikiPPUixyvcj7ecz308sCVwLtpyatuE
 fItz+BikPN3kFoN81TG/cK4tjtWIOPBYluaP7nA+7UI2nLU5e1MFgRnkn1y5mXrpIAAJ7k8CfGX
 jRiIED/i2Grt5S3dW30zWsC+Pba/RN7tUDiXGsXqmz/KHgf793A+sesrz9pyZwtb/H3/mwCSn5p
 9nrDqTD96OWKtabsAU0sOp6TIeNL025tSeBQev04e7dp+noKD8p27tK5PDbi7RBANxSFe9VGodC
 XtRPbqT5PmDKbug==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

When setting a link property to an empty string (clearing the link),
new_target is NULL. The check callback is still invoked with this NULL
value, but callbacks like isa_ipmi_bmc_check() cast it with
type-checking macros (IPMI_BMC(val)) which crash on NULL.

There is nothing to validate when the link is being cleared, so skip
the check callback entirely when new_target is NULL.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 qom/object.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index f981e270440..c50334b3023 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1903,10 +1903,12 @@ static void object_set_link_property(Object *obj, Visitor *v,
 
     g_free(path);
 
-    prop->check(obj, name, new_target, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        return;
+    if (new_target) {
+        prop->check(obj, name, new_target, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            return;
+        }
     }
 
     *targetp = new_target;

-- 
2.53.0


