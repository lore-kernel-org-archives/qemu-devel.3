Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C2A7CD4F21
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2026 08:01:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wO9wb-0005NO-Mc; Sat, 16 May 2026 04:00:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wO9wP-0005BK-Io
 for qemu-devel@nongnu.org; Sat, 16 May 2026 04:00:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wO9wN-0007OG-Jc
 for qemu-devel@nongnu.org; Sat, 16 May 2026 04:00:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778918406;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9RujeSeL6ldPtOVDgPmFhHQObOMHuElmXzcyIjBot6M=;
 b=OWADxoVCJ1HEjtKF9srDAuMJwnJazd87MMT+mvrazVMtz0/xGhyNqCO1HhlGyv2Qfm4Cuj
 A7o7+jnw4JWudlPMAywii2wBz3JSB64CVdldbg5ui3vgxF9MOzaCTQYrl6L2tLXcLXToLl
 A0F2d3CM598Kr2Gi3P4fU+qEcnxfOpA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-458-qA7-LmdHNdGh9QgeC1E8Vw-1; Sat,
 16 May 2026 04:00:04 -0400
X-MC-Unique: qA7-LmdHNdGh9QgeC1E8Vw-1
X-Mimecast-MFC-AGG-ID: qA7-LmdHNdGh9QgeC1E8Vw_1778918403
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CFF411956096
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 08:00:03 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 96B2330001A2; Sat, 16 May 2026 08:00:01 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 16 May 2026 11:59:07 +0400
Subject: [PATCH v3 08/24] hw/xlnx_dp: reject NULL 'dpdma' property rather
 than crash
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260516-qom-tests-v3-8-3f20c3a029a7@redhat.com>
References: <20260516-qom-tests-v3-0-3f20c3a029a7@redhat.com>
In-Reply-To: <20260516-qom-tests-v3-0-3f20c3a029a7@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=750;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=jBOueGD3usojug1hoofNgWECywbfWUjlS8RM/1Fkkik=;
 b=kA0DAAoB2ujhCXWWnOUByyZiAGoII8/IHnbvLkus4ER0ZD5kzq3BvTI4GEcd12WjtbZUbiXcO
 YkCMwQAAQoAHRYhBIepvZM/h8YG0nb2Ldro4Ql1lpzlBQJqCCPPAAoJENro4Ql1lpzl+88QAKxA
 aAg/02bXucX9VgcwH02ndsg6Vg5vPljbYRY/BUrXs9G5u4xSRPRYfgBJ+3+AVkdkNC5UhWaIfpk
 h6aLTRWNErDGVk++dnujOD299xgyb843QEix5IvlpP0VXphh56iXGul4Z+rj+jWZzb45ggQM73e
 nMF2EVkt69h1PtN5doD7J/VSDv4m9d5Z4qoJadfXrDQc9jkAAuYjQ+13PjnUmVvflABflI6S56/
 +sm6BY+uBowH5cIX/XJhn5roGAHQE93UeBgZcdqf6XlD7RX5MxjZ180iJPOtwMqNuzyJStmXqz4
 44Y5YaV+JYZp2G9irMFULfhmI6wyfmgc2NPcdMynMA1FnrNwpi3hXGzAHeD3b3kEC4vrkagWmWx
 WB21LQdECZnXX8bBFFJ2tVVi8WOcM/jFgfk3l12vFBMQGuIUf59ZRGwSXdSwujEoSUS3RxciRhJ
 vN75AvBfPTJrbH4foZRvfvGyaPcZMQluh70eIGF+mcjoghV35bdb0WzvoTxRQjQu5Z+7UMCSjFE
 T/mHvrngjbHrxci3V+UzMTNR3ojCd6zvzzKfGBbF6llRzPromLPIiSIllvsmtYCaKz+esgdR5xZ
 gfCziUa150RqDhRj0vfyTJqFYaAEcxLWLYrFQMN2/N/qG0sIrngCkjfNS8Dtnt9ZRY9oYEbyBiM
 s45qc
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/xlnx_dp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
index 2486d9e5825..98126ef320d 100644
--- a/hw/display/xlnx_dp.c
+++ b/hw/display/xlnx_dp.c
@@ -570,6 +570,12 @@ static void xlnx_dp_set_dpdma(const Object *obj, const char *name, Object *val,
                               Error **errp)
 {
     XlnxDPState *s = XLNX_DP(obj);
+
+    if (!s) {
+        error_setg(errp, "%s cannot be set to NULL", name);
+        return;
+    }
+
     if (s->console) {
         DisplaySurface *surface = qemu_console_surface(s->console);
         XlnxDPDMAState *dma = XLNX_DPDMA(val);

-- 
2.54.0


