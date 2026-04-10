Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00DF4F45A0C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:27:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBHSR-0006Ve-9x; Fri, 10 Apr 2026 15:23:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHSQ-0006Qs-40
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:23:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHSO-0002CY-Ob
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:23:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775849036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fNtgm7Dc2sKWUhtRubFcPFp7/J/116trHEswWgG7p+s=;
 b=FQTtI6x9XeNeLOB0LHP6dRfnXm2yereicsgrZ87JQVQTt4OH6gZsNP04QPLYlsYqCskuHA
 2WZdcFMqEUnJ5iF2oRK3WyxaWjpltLPIkSC9k+4+iddMdex68YxJ1wyYVhuOk2nLNzFXIT
 NfoHwHRVobAcTS0P9TcmOwP2XHhDg80=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-235-0olYaZuFMSCsMpQ442sWWQ-1; Fri,
 10 Apr 2026 15:23:54 -0400
X-MC-Unique: 0olYaZuFMSCsMpQ442sWWQ-1
X-Mimecast-MFC-AGG-ID: 0olYaZuFMSCsMpQ442sWWQ_1775849033
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BEF2F19560A2
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 19:23:53 +0000 (UTC)
Received: from localhost (unknown [10.44.22.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A3A461800B7F; Fri, 10 Apr 2026 19:23:52 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 10 Apr 2026 23:19:12 +0400
Subject: [PATCH v2 50/67] ui/vnc: report an error for duplicate display id
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260410-qemu-vnc-v2-50-231416f76dc3@redhat.com>
References: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
In-Reply-To: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=626;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=mfbePML5bipQlj6KwnAkOKEr3720h6Lm42X86FPcooY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp2U0W32iHIweWZQB1LArz4q6UCrapUnPG/4czw
 tBvw3AfInmJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCadlNFgAKCRDa6OEJdZac
 5SI9D/9Oy8WwyMVBAry7QePW90J+1nmgeJuBWvwzel4zJ2Ti9PeKZKa3amVIW3bkkRjbX4bDb4s
 xeoMyS7aOyg371Vpkg6Apo87whY3WwUzNu3UIJ0YhCnCQ1YLSMWjPlJA8FMFAo/m3sKROLnVB0A
 E21lPTkmFpqQNVB0bjwNFKa7FlpOk+u/R/Kow/0u1rlwU+Gu7xH8AA07+OndLfDj2Ru4G/DFjVn
 vty3rtUPu5n6XUeFrrgRMCUTGt7BstLmKPLKW8APPo2/guW9DYFoDt8/PSG7ulVOOFQDwsge/Ua
 wkHEnTkDYciBgQdktbYJS6aPgMQ8ZIOLGiDMdyHd/uHq+P1gZxyr3EqyIshsKbeO5ihvBafrWGg
 ny43CKuYekZndVULPKCywMeKtanYqSN+LuLiw3cug30WDniJu8KV4PGezHcRX8gmrMlPxLBL+mK
 iTK5M4d3L2B6Ukj9Qks7xLAb65uIFXg7wsdLaaN9BMcLHX+hrYrleMeXq79nJDZrZN+xILi7dRD
 gqtij97pQiigUwTYpPWssMkYEE4oU3f1jY15An7aVu/nDp339Jtincc8jfHE9XL383n32N5ouO+
 e46itjTLcysN0RjEJ8zKsVcQZNF0RdZ03TYRRF0jluWBDJ23MK2djcfwSjGncWxQSEOjIt6Us9n
 w6aaHlcpHT6mVyg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Returning NULL without setting an error is odd.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/vnc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ui/vnc.c b/ui/vnc.c
index c26b581f3ef..6f9cc3f25a3 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -3430,6 +3430,7 @@ VncDisplay *vnc_display_new(const char *id, Error **errp)
     VncDisplay *vd;
 
     if (vnc_display_find(id) != NULL) {
+        error_setg(errp, "Display '%s' already exists", id);
         return NULL;
     }
     vd = g_malloc0(sizeof(*vd));

-- 
2.53.0


