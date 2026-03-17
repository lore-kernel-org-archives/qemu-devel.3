Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AE18F33817
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 08:52:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Q9A-0005hn-1p; Tue, 17 Mar 2026 04:51:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2Q8x-0005gh-TJ
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:51:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2Q8v-0002h2-Km
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:51:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773737472;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DVU+u9znA0LmB6+lQGjatBWdik3RAB5u2zSQZx8LHaI=;
 b=UVyLgh8188r/Twlo0S6hGGo8ns2iOyfY3KCSIhuy9jTl8cHfDPSLQbk8nfju3N4UM316Rt
 YyxG/bpYcRy8HWnqDQWP8QzwqObvUkiO7b6+KPVhh4Ii+HdCGXUvD7Ib5XdlybDe3qu9tg
 n9dVachvrNnBCfQeiO/n3lPmhyJP5i0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-499-AGIP-ia0PMi3YfdG7UiJeg-1; Tue,
 17 Mar 2026 04:51:11 -0400
X-MC-Unique: AGIP-ia0PMi3YfdG7UiJeg-1
X-Mimecast-MFC-AGG-ID: AGIP-ia0PMi3YfdG7UiJeg_1773737470
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3073D195609D
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:51:10 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2F5231955F19
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:51:08 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 17 Mar 2026 12:50:19 +0400
Subject: [PATCH 05/60] ui/vnc-jobs: vnc_has_job_locked() argument cannot be
 NULL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260317-qemu-vnc-v1-5-48eb1dcf7b76@redhat.com>
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
In-Reply-To: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
To: qemu-devel@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=630;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=kCY0fa1LuCzGT8SKN6LbHbaCvZ4fFL136UFG+eXA7r0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpuRXamQfsY2AtgeVY0rzVTqI9gQ/L+DAZyKmc9
 qsrjadgOSCJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCabkV2gAKCRDa6OEJdZac
 5SBQEACFoMsUDeT21EwN7HL0Pf2YnEA9z388OlXAffC9eNFEYQD3PsUiWZnUmkeBDdJsBKIe+cr
 cvZfpHwL0T+toWwpoSDZPcIktd9tJHP+VIhaqPSDAvpNlnnTzAsJ3yyOjzkyAjMajbbjq9ZipJJ
 gN3bjBD4mQk5uNaVwyzdFIia9Ui+PbgQbk4T0fhwPZd1ZgxipZ/LK8e+DQYSybW4u/pWBp57/nb
 yRHQR6k+VcckxdhY/fmGpW9Q+BlEPRUqYfoqurqCOapII+CLXm6LesPkeaH+UGJvnBTsUgUv8Xv
 d54U7VB9oymBYAutZQr4kW2S/Xi7zcYycmZ681Q7G/iMfakQW++RkrymBSwqoKNw5svNoweW6Ss
 Y6dtHg5Os7eMjIeW+730QaHzIQ9Pm9Cun9+ifd0NWDLZJWV/Jf4up/DebYPIo3v1UMhzOIV8R0G
 Dry2HxGxkLSUZw47DN0FeJ/ZjAveqVtSGjZ0z8bwRMz0XTuYJGXMaBo425Ylgh5lph3nPRCzzft
 vHhqM2Vtr14sZa8+Kv1bluy1NnfrsKcfSMQpEeUZCylYQ+mRgnQsVy0vcX/qHlcaKPDv8/ul8gd
 i1Ecf2dQ0E6V3tQMQmgrl9ormG9brbpaOZRTALCap6WDr9yXO7ZVVGvR7qmH1WDcfLR9MK0ekqZ
 W/qBE6m3tecS57w==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


