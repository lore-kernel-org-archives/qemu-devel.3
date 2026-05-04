Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B45CBCD342C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 11:40:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJrdP-0007aZ-9i; Mon, 04 May 2026 07:38:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJrdM-0007HG-Nv
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:38:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJrdL-0001Je-4m
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:38:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777894722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pE6Pca7W7tBGiOTIVoQ+zK1N9Z4QVqZ8xEfNADow84I=;
 b=ifZUWnEefo2g0fCZUx/EQCAJBX5dx781UJa/1HNsJDmGwTqt7g1bGHCPkNnyuCRrIe2D//
 aeJkkhOaSVOrbEyc8kCuY+nGCE8sq2/Tv989MMuwQEoPKRO9UGN50fj2F6kkZgosF5yDj2
 0uxQL9ZPfdVJ5CIZnQXAQoRemqBz+js=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-456-IddKBZgKOvKx3xT3MPB0Rg-1; Mon,
 04 May 2026 07:38:38 -0400
X-MC-Unique: IddKBZgKOvKx3xT3MPB0Rg-1
X-Mimecast-MFC-AGG-ID: IddKBZgKOvKx3xT3MPB0Rg_1777894718
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E1FC018005AA; Mon,  4 May 2026 11:38:37 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D1DA619560A6; Mon,  4 May 2026 11:38:36 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 04 May 2026 15:35:23 +0400
Subject: [PATCH v2 35/46] hw/gpio/pca9552: fix state_str leak in
 pca955x_set_led
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260504-qom-tests-v2-35-ef7e3dc94f7a@redhat.com>
References: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
In-Reply-To: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Glenn Miles <milesg@linux.ibm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=930;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Yyqdk4pqgUvsNBnd22QgjuieBpuRTzwJTZeeL08X0pU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp+IRtH0un1uSz1Bb/OU6ul3laQWKoZiN4dZE1f
 3PZdd5HWgOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafiEbQAKCRDa6OEJdZac
 5WR3D/9OYyZdGvCz6KFa6bFLMtxwCIJjxG20speZdkTR6W2lTwXTNIOztZhYcyRmmzZjQt6PvME
 II1Tb6lLCrInlElu7wZDLDYsIZzRp6rtwD74wJC2klLF1JHGkKa4PyVsz8gKIGNrJq8R5aZ/vJH
 mWbwhxgCeYcATFCpfDyj21ynB6IXTYBUrYCVbz/off1OZutvb2OPENZeGPNuvBCEXXHsT7Xc6QT
 mjrq6Y0KyWh1rr9FEFGLYqgUr5KwbDiVrd4GC/4NYJzHjYdswErwN9gHfl/sAZO9We6PMC4gnyD
 DKbHQnEbcUSuDLVK0f+//bys5RBL28+AjSWhiLB7ffmiWI0GhtIYZHSytL76UnD2IykyD6W74tv
 t2qltbZqlt6mp2jYadC+FjUFszhLhAohRr1eqANhWiZG6uRBfgG50iNT8//Gw7Uugz4PDhllC41
 sdOd4cD/bfCFzpVgwOSlonfGf0roPhkoCtfmIXEl7LpeAkAzY2yVvtvyhOupY3Q+l7F850JaHdN
 4fU/JZowuxVWu/DX8qBH7/UuqnLIwAeDGN3wrC7PW4CjpM4WqShUE5io3nAv/E2bJfihHcuiKSL
 NTK9PTznYbyJyhwNdM+wvGxOYmGqUXkMhutbKNL5nCdPIIcjORHmeaY0pueKPn8XwGJ/3DN8HBo
 nk1lBk4/cWXke2A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
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

visit_type_str() allocates state_str, but the function never frees it
on any code path. Use g_autofree to ensure it is freed on return.

Fixes: a90d8f84674d ("misc/pca9552: Add qom set and get")
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/gpio/pca9552.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/gpio/pca9552.c b/hw/gpio/pca9552.c
index dd3f1536b65..472d8ad9571 100644
--- a/hw/gpio/pca9552.c
+++ b/hw/gpio/pca9552.c
@@ -342,7 +342,7 @@ static void pca955x_set_led(Object *obj, Visitor *v, const char *name,
     PCA955xState *s = PCA955X(obj);
     int led, rc, reg, val;
     uint8_t state;
-    char *state_str;
+    g_autofree char *state_str = NULL;
 
     if (!visit_type_str(v, name, &state_str, errp)) {
         return;

-- 
2.54.0


