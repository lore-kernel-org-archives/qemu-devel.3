Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E03FC79F89
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 10:50:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3WwC-0007le-B3; Mon, 07 Sep 2026 06:50:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3Ww6-0007dt-Dw
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 06:50:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3Ww4-00081k-Ok
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 06:50:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788778248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N5XLuA/DaZ16/oHm1JbndQR+5uaembUXJMCN9FVfTk8=;
 b=KAKfHHWTwm6wh+ct1JhLxkdkeYVSc7a7mamdLbK7s/UF/2YFl6pXx/WIADZUNf6InzHvpd
 vU7bklEbpQgcsXpkkM36t/VYkpNSznLQVXCHjlDcc/cPb75JAjxcKTbgGKaS64a/p0/rgD
 doEfYIN4Mw1OvW8bWhoCG2BhWTyArTw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-217-xWt9yh3gOTWOttp3J4cyoQ-1; Mon,
 07 Sep 2026 06:50:44 -0400
X-MC-Unique: xWt9yh3gOTWOttp3J4cyoQ-1
X-Mimecast-MFC-AGG-ID: xWt9yh3gOTWOttp3J4cyoQ_1788778244
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E9FC319541A0; Mon,  7 Sep 2026 10:50:43 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 22A2A1800257; Mon,  7 Sep 2026 10:50:42 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 07 Sep 2026 14:50:08 +0400
Subject: [PATCH 10/17] qga/vss-win32: guard CloseServiceHandle calls
 against NULL handles
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260907-qga-v1-10-86456ad356e2@redhat.com>
References: <20260907-qga-v1-0-86456ad356e2@redhat.com>
In-Reply-To: <20260907-qga-v1-0-86456ad356e2@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kostiantyn Kostiuk <kkostiuk@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=959;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=nIIKdQW59ljnqDumnnb7RBfT3LgkJf/UzhFaeYI2fNI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqnpbj7DTk1J0uVNJi0jy4YWbGISsKlQBhQ1Cxb
 xBbQIHLTY6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCap6W4wAKCRDa6OEJdZac
 5ZF1D/4mDp7I1709CBhQCHy+kwpxksJoKmXvG09AsHSidA+yzYmMqvuJbQghxi4CCRcNetfNCW1
 foA1qBs0cKGmQw+f07gSLLZLET8zcfq+JwxmuapdDL8GCCA/8loewvAWzwi8C8mop6DfZN7P1BC
 l3S2stDag3WIN1IyPhYvJuHJgoW2fMbrxUsEmIam+H3xG43nAuOnTacE97uPijlW22Iez/sXp2z
 4qOYhNWLoqjWhHG6oHbIiapHSRGoscSC6QNkWgP4/AbpBC/A3rECTVH0D3fKST+OHPWdSgU07A9
 9IVuLUa7XbcvUoan5RoVmMjE4BvE7z66U1UuCDvrGiZcliy1eOwRh/qIsl7SkhV/cnZ+x8kwqnd
 hZTX3P7d1b1FdEhK/kVS1SGwa0B5oxVVIL9Wd2L8N+VKoktuBaJUXY3nauateyC34l0ME21HqxR
 6obD7V4plac0E7Mm0vEMyf0Kgd/eysLKlEnM28OGGdpF7vfLRO++6UPz0yXo5LdcNA/4NrkUJ61
 lUxvYxtt998Nt2OD5dQlV3/t+oHXQlJwo1I0m/z1VyWUv4Gsfbpq+NNg1vRfGnAltKrQbY9r1Zt
 nEugRr7JbIWds20nrdMmYHZWBC12T+gclVDi8fgGGgIgsHA3gpBHlJlGVA60XTAb1GU9WLTenpq
 Z42wfBoaCkVAODg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
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

StopService() unconditionally calls CloseServiceHandle() on both
the service and manager handles in the cleanup path, even when
OpenSCManager() or OpenService() failed and the handles are NULL.

Fixes: 917ebcb17027 ("qga-win: Fix QGA VSS Provider service stop failure")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 qga/vss-win32/install.cpp | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp
index 12b045e2074f..9e8db79c122c 100644
--- a/qga/vss-win32/install.cpp
+++ b/qga/vss-win32/install.cpp
@@ -597,8 +597,12 @@ STDAPI StopService(void)
     }
 
 out:
-    CloseServiceHandle(service);
-    CloseServiceHandle(manager);
+    if (service) {
+        CloseServiceHandle(service);
+    }
+    if (manager) {
+        CloseServiceHandle(manager);
+    }
     qga_debug_end;
     return hr;
 }

-- 
2.55.0.543.g5ebe2ebe4ea8


