Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9B93FF8868
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 19:47:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHRth-0007wE-DC; Mon, 27 Apr 2026 15:45:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHRtf-0007mG-6z
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:45:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHRtc-0008ND-SN
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:45:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777319132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4KHj4DqAixgKGdHuYS54zcv/K3U7GmPCNfmzT2qJpNY=;
 b=C3lHIV+oP7m9d7Z+LlXaukVExa2UNek9LeewYheemZGctSOP0IDIyuAILDFj4p8LLGTf+2
 KyvmPcMerWVGILbm1NcUm+jfHVjoGhSfkD5UXbIRTZZVC1dR60g4XC5ocWIzDqXelS/sUe
 1UByROZtBMzD3EbB/SUxLvD/wXuFRLY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-522-xZiJ-uQyMDCxZMmiLV_ZfQ-1; Mon,
 27 Apr 2026 15:45:28 -0400
X-MC-Unique: xZiJ-uQyMDCxZMmiLV_ZfQ-1
X-Mimecast-MFC-AGG-ID: xZiJ-uQyMDCxZMmiLV_ZfQ_1777319126
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C42C0195606C; Mon, 27 Apr 2026 19:45:26 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7B483180045E; Mon, 27 Apr 2026 19:45:24 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Apr 2026 23:42:29 +0400
Subject: [PATCH 30/41] hw/gpio/pca9552: fix state_str leak in pca955x_set_led
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260427-qom-tests-v1-30-c413f3605311@redhat.com>
References: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
In-Reply-To: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Glenn Miles <milesg@linux.ibm.com>, qemu-ppc@nongnu.org, 
 qemu-arm@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=823;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=3S6fSXjyZtEol8E2g5mMSZCzx5rxZBsHBZ3CL9TbmuI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp77wVK0C4iwVzskgkTX0g6J8GOfDk4Lj2dMQhL
 4AV5EeTFvGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCae+8FQAKCRDa6OEJdZac
 5VHpD/9YHfDTPdbCHzUL6KTtqT0i/O/aHZyHqX7yD4Ha0REqGtpXWx47X3ryM9XRoxJamQmB/3y
 dRyMB1xcwSkelCHeK7Z6dXvRFfzQZXRFmM3+XpJRI5/H4f0JL7yigKGb7jTipSgYzhq+ugfQms3
 USgNG4zcM6VGQLfv9NR6GM5vCluwgHl4ktZaO3usjCC79SwUTry6ESajrYg4JvYID/HWB/ekC1y
 M7cn5VjWvAFgaPJ6V9hkEystqETGOnpqoKcSjd1+yq/jnPL1ZiSfRbAi/kUYvoJC2fdAXVIhkpw
 coiA/8U2WfuWzb21hkG2Lb82Yvks7GhdNxUV+qkttbTYWuNaX7DeUq7IABFMy67adCS/qTBiAJZ
 SaPVZvtRfdGlNi3ZzhAyHXi+fBjY7CMDPwzK7PYfTfQj3eYMq532hO4N+Au4FA/JyzH+QH8tbjS
 P+ESBFuHlScLIryYBVVDB7c3QlfA2vIhbXILUVfI9Ms5XfnzCqNb1/gPdTDssNvbXRv6NexlExo
 Sohd+C1Uvj3gPJz8q1X07X5slARIlUCEM3xDAJB+8lLrj+ueyBGHtq5/ZaAJ8G0MTHKtxTGfiUm
 XOSSb1b/n5Qle6/MXuyiy4spVpzLB7bR/WJ7+Tq22Ob5wAgvPvL4EKBmFbghsT4Z7E5UzrIExiJ
 ioDNpKJD2mgzakQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
2.53.0


