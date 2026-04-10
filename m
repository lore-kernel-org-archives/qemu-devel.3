Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A983F45A08
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:20:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBHNv-0002Gp-6G; Fri, 10 Apr 2026 15:19:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHNs-0002Ga-JD
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:19:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHNq-0000On-9J
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:19:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775848753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YNC6v0P1xzOIZIP6aHqQfMFudfdgW80spUvHLw0+FaM=;
 b=csGdwrojnXH/V8pg0pzIDZSOUswysNsKQ6XxYTzifQRZ9XXe4u0j7/FyKdfcBEHPzdznSt
 7hmBSIPaO4N3R+JI1l3XizZ5H272nR5xoHndiIO+J4TZ8kcVUorgbQFysCJ3C/GqvFb/3m
 HELqQvVvH6QnuYtCidr2TWk1bKtzD2s=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606--WHcnR5mOeu6OJUR6XBkRg-1; Fri,
 10 Apr 2026 15:19:12 -0400
X-MC-Unique: -WHcnR5mOeu6OJUR6XBkRg-1
X-Mimecast-MFC-AGG-ID: -WHcnR5mOeu6OJUR6XBkRg_1775848751
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6E0CD180034C
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 19:19:11 +0000 (UTC)
Received: from localhost (unknown [10.44.22.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4BA2E3000C16; Fri, 10 Apr 2026 19:19:09 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 10 Apr 2026 23:18:25 +0400
Subject: [PATCH v2 03/67] ui/vnc-jobs: vnc_has_job_locked() argument cannot
 be NULL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260410-qemu-vnc-v2-3-231416f76dc3@redhat.com>
References: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
In-Reply-To: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=686;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=8lTDGJSHd1oC47RSN2DU3h4RCwiGcEBrgwXT5KJMEUs=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp2U0TzoSrmap6Ei8tkfeYA6nR9/46PRkHe2AdY
 gZ3TlkHo5iJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCadlNEwAKCRDa6OEJdZac
 5eNZEAC0Es+Bs67QOPOtfiazyqBCWDmeGBiYt4Ev0jxETfW7IylmSgTjMCbeQlaFs+cEaJGXim0
 tmLR2+eHwtbPA1Jz/3YCs62m21A1pdhQw1PORjSd0kTQbCByM+VCLufcQQefteyYcx8hR2Ibz7B
 UFa9OdUQ0vkR+oy8vvxjeYDR5nw7SGyoEYSqHhNjgWVqGwzhEfFCp5sj/0udfniwVbt9PSsV8If
 cmPKange5piFbaHwEf9ihfrMAf0iWdNi/eY15WuLK5T0sY+R5VSL1DzC4YjPoNC+hSiMtWhCd3+
 seYMO/a7sNwhauqZxVgAzGD+NE/jC4+LM7M3luSQSR9UwcHWlUFOeSv5StnU9BDWGQwoX0N0tPZ
 6PMvsYdjFcUzeizyiRXFRgJKQ8OKvC2epMyl9kFWak/RscUue9q3z5BMy7ZIh0VNHCT1iQjGVVJ
 oJVDtw2HYtapD09EvTqVOcH3cAH2+byvBnnFyo8lts5sBDKlQay7BNbUwUaowib8YHTS8LcpjsP
 UGlmS/X7Zt3k7GloRchfF7feF8lgHOT0tsVMUXsdvF+Ew6HFrfi8wwfAItnE6coAlWrsfZIAFe9
 zU7Um/NkUn5craRWHkFEm51+mTaoyOYmoWsS5R9qCCoXcocdpZ1HX/uFaNhaWymEAk0JJTYeCPh
 s0N8mB+MCuJKI2A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The only caller, vnc_jobs_join() cannot take vs == NULL argument, or it
would later crash.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/vnc-jobs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/vnc-jobs.c b/ui/vnc-jobs.c
index 4dd7ccad969..8cb30e72276 100644
--- a/ui/vnc-jobs.c
+++ b/ui/vnc-jobs.c
@@ -138,7 +138,7 @@ static bool vnc_has_job_locked(VncState *vs)
     VncJob *job;
 
     QTAILQ_FOREACH(job, &queue->jobs, next) {
-        if (job->vs == vs || !vs) {
+        if (job->vs == vs) {
             return true;
         }
     }

-- 
2.53.0


