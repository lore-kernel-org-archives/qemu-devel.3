Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30F22F45A08
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:26:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBHSX-0006a6-CJ; Fri, 10 Apr 2026 15:24:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHSV-0006ZT-QA
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:24:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHSU-0002Eu-Dc
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:24:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775849041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LbD5bApnct5r2F5XxoCnsfV4wmuuaWmgTLO38u520H0=;
 b=SdkzQGBkayKSl/+IbkdRgVk8G/ZLpgWKiT+U4CW8d5SOF88/arwn/znH55WyeA83HbDoz6
 CtN3L0UIMS0CwOJDuON7C/6LYRtgG95TZE/dYlIfBTcPrX8G9yYzV/2kVTvCGbmeeT5gtd
 vLsgJ2cWGyevhZCgUrVkCK7OdkiMfFk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-466-Fv05_hy9OEqxnFVwybAWCg-1; Fri,
 10 Apr 2026 15:24:00 -0400
X-MC-Unique: Fv05_hy9OEqxnFVwybAWCg-1
X-Mimecast-MFC-AGG-ID: Fv05_hy9OEqxnFVwybAWCg_1775849039
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 974AC19560A6
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 19:23:59 +0000 (UTC)
Received: from localhost (unknown [10.44.22.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5A06B180049F; Fri, 10 Apr 2026 19:23:57 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 10 Apr 2026 23:19:13 +0400
Subject: [PATCH v2 51/67] ui/vnc: defer listener registration until the
 console is known
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260410-qemu-vnc-v2-51-231416f76dc3@redhat.com>
References: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
In-Reply-To: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1763;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=D0sNYAf7b7syfLNSN9v3FM+l0V9XmMPf8r84aEh9Pq0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp2U0Whx5b0xAqA9vG6lhmn/9pHsODDfRH5jyEU
 0tauD5hpfKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCadlNFgAKCRDa6OEJdZac
 5T5dEAC0+nSDBe/NpO+wVW/F2rXuXEruYD0CDfCmrkNc2cZf9VMdZT//3zCr9YxTFX/kyhJ6Am+
 aE7MJB5lJzLbVtMTx2Ns9++34xiWCg4P4bd34cNKFuvo88bomyj2b/lFBRkxoNEJSG3vdmhyLRe
 WzJ1LktgFNt+hlNxrz42U0vmAroBNlTJPy24ecvOFmYE3RkFiR2Oj28WmS/aycWPc7LK+7a6jN4
 LAmI4C6VPFnc4PkPokSyTsj/xffMJa9PpUSouVAIuPREPVXECcWp3QxSsQpTERgmYDo9xlFIETB
 5+ZQimyhN4BnqFzjrA4MbADNnTEEjhi1NZmshCo0C1+bBt80yg20+W0XlAr+QX+fq5XLtHL8gJH
 tZHTXUV8uh0GekTbcoRYy+mFTZh89ZIq7aEkfMX5nppFZrq9hFSS7vA3OP3/VxVB1SSMUSGCy6k
 wllLvw0AfNkNr3t1vKCRQU7n33x3dQPbb1iBUiS3EOmqfW0kV4fkR55pJto1arW4TWimHNoiIrD
 JzyFeYhndn3jPgNEjzaKcah3sg20jzZOy0URV6KfrLOBGycAlkEENSC7dz3XKclL+Wt0T2gYaJJ
 Xraw7LMqhjzlohUNEzHD+ix/N4zUOsAWFb+xqIGCND57ZcDwY48MZyDzKUTbtS/NYbV94A0F2lD
 /MriBDqmKhsn48Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Previously, the display change listener was registered early in
vnc_display_new() without a console, requiring vnc_display_open() to
conditionally unregister and re-register it when the actual console was
resolved. Since vnc_display_new() and vnc_display_open() were merged in
the previous commit, simply delay the registration and keyboard state
initialization to vnc_display_open(), after the console has been looked
up. This removes the conditional re-registration and simplifies the code.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/vnc.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index 6f9cc3f25a3..747b1c44e36 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -3460,8 +3460,6 @@ VncDisplay *vnc_display_new(const char *id, Error **errp)
 
     vnc_start_worker_thread(vd);
 
-    register_displaychangelistener(&vd->dcl);
-    vd->kbd = qkbd_state_init(vd->dcl.con);
     vd->vmstate_handler_entry = qemu_add_vm_change_state_handler(
         &vmstate_change_handler, vd);
 
@@ -4269,13 +4267,9 @@ static bool vnc_display_open(VncDisplay *vd, Error **errp)
         con = qemu_console_lookup_default();
     }
 
-    if (con != vd->dcl.con) {
-        qkbd_state_free(vd->kbd);
-        unregister_displaychangelistener(&vd->dcl);
-        vd->dcl.con = con;
-        register_displaychangelistener(&vd->dcl);
-        vd->kbd = qkbd_state_init(vd->dcl.con);
-    }
+    vd->dcl.con = con;
+    register_displaychangelistener(&vd->dcl);
+    vd->kbd = qkbd_state_init(vd->dcl.con);
     qkbd_state_set_delay(vd->kbd, key_delay_ms);
 
     if (saddr_list == NULL) {

-- 
2.53.0


