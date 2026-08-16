Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C831C5B572
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 19:15:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvgKK-00070f-QO; Sun, 16 Aug 2026 15:15:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wvgKI-0006pz-HY
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 15:15:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wvgKA-00088u-Uw
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 15:15:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786907714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fwr76LCKNxOFLBeBXg/E6mdqS+bZIDMVvsuC1iRbH+0=;
 b=binb7O0QAzL0im8ar05RTlDlZie3bLFZNlSpxuAotT1c8SuGDuQUGdsbN8PQxxQ+oaOhN/
 V1F0Kquh+h8KItuDVY7mp2npIO5FX528/QZfBUljAZvtFZJYBq0v0lJQ4tGk9ri2Y2Aymi
 pNRx16JHDNypS7lH6CwCqs77uGrDlTY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-bYWR9-3wMVWwVCbVHjnFpQ-1; Sun,
 16 Aug 2026 15:15:07 -0400
X-MC-Unique: bYWR9-3wMVWwVCbVHjnFpQ-1
X-Mimecast-MFC-AGG-ID: bYWR9-3wMVWwVCbVHjnFpQ_1786907706
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9C99319560A6; Sun, 16 Aug 2026 19:15:06 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C6BC930001A2; Sun, 16 Aug 2026 19:15:05 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 16 Aug 2026 23:13:01 +0400
Subject: [PATCH v3 34/49] qemu-print: switch to use monitor_cur_hmp()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260816-qemu-no-hmp-v3-34-e53fc35bc550@redhat.com>
References: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
In-Reply-To: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1339;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=vtbR9tAL+8maVG06CYe1fTcDDBCQLrWMYbbThpYR8Xs=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqgguzFPNY1DX6KTmMEwlzxQvcDncQPVoPl+q4j
 4KEwDq+H4qJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoILswAKCRDa6OEJdZac
 5WNuD/9mn+ln1Nh26jkNVdKzeTbgxSx7dNT7TEArnRtaiIPCN5OcbfvGT+E2zjrOZFNxOiYzaj7
 JjD8szaNh8QbV44dUX2uigK3KAfg8gzyKdJf19rIivxEWA19tsq32zf1xg4PtIkarguacI6InCY
 me5XOPmRBI29gv2IyVD2m45xvelMFjwvL1yF2P+fd0vKVvHW/RVa1ouK9r4S5+2owBo5AaKOJ/W
 LoOL2Vmsj552ElE/PSw39xpbToavyhRLATa/mcccOIzr2uy8b4ObP6gIaUdBUiXFXwfoEg3qpQG
 CbVD/voKKqDvZySDr1FLCpiuggFF0+a888bXbUbBG6FM409+sNWWcXFda5GBc+1YVGPAU2O8NYL
 1eLz2XWCbse/RtkmCUGGa99Bnhw+iZdZdpzCpOioTMlieIncQnslLH6zoagOmcGBacvwfljcq+C
 H1VvaaOSlmJZqBpv76PIc96/o2bSzfAitCKuPF6hipaJu0pkaFXU4fboqJa2OxlqviC+fEXscmY
 +ZBTAcDDzB3MuJwoL7pwaFk571UhhtR/SpGPi4a/2PhA+7vFzAAyA7MGGSYnDK5oAcUgHErz12s
 xtASoty6tojgJyfURd4A3Ir8eO4OcZGIeAfY0Go9miV4Bd/Zt2qyOmEf5qifnqbL2A972V9mv7q
 mfEPV6PJ7ENUdFA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.342,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
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

Note that this fixes qemu_vprintf() (and thus qemu_printf) to do as said
in the code comment: print to current HMP if we have one, else to
stdout, instead of trying to print to the current monitor (which may not
actually have hmp-only print capability/callback and fail silently).

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 util/qemu-print.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/util/qemu-print.c b/util/qemu-print.c
index a2d1f0244168..0eecc05b0330 100644
--- a/util/qemu-print.c
+++ b/util/qemu-print.c
@@ -21,9 +21,9 @@
  */
 int qemu_vprintf(const char *fmt, va_list ap)
 {
-    Monitor *cur_mon = monitor_cur();
-    if (cur_mon) {
-        return monitor_vprintf(cur_mon, fmt, ap);
+    MonitorHMP *hmp = monitor_cur_hmp();
+    if (hmp) {
+        return monitor_vprintf(MONITOR(hmp), fmt, ap);
     }
     return vprintf(fmt, ap);
 }
@@ -53,7 +53,8 @@ int qemu_printf(const char *fmt, ...)
 int qemu_vfprintf(FILE *stream, const char *fmt, va_list ap)
 {
     if (!stream) {
-        return monitor_vprintf(monitor_cur(), fmt, ap);
+        MonitorHMP *hmp = monitor_cur_hmp();
+        return hmp ? monitor_vprintf(MONITOR(hmp), fmt, ap) : -1;
     }
     return vfprintf(stream, fmt, ap);
 }

-- 
2.55.0.543.g5ebe2ebe4ea8


