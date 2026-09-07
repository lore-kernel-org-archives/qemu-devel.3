Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6858C79F99
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 10:51:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3WwK-0007yI-8b; Mon, 07 Sep 2026 06:51:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3WwI-0007uP-93
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 06:51:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3WwF-00084G-0M
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 06:51:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788778258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1tAvx3fmlomjyknVZ/2aqsXF2G4mK66HM/0sUPy2ung=;
 b=DFgDjPNmFcPMUJ9w97rYWX7K5uAzLqrheBH47+IacKyPSSbBHwFHWpdmPBrgODXN9rCbca
 VyWD14tebZ1honEU/bEGcMA68nJ01hijx09C/tGKuYo7fLRakHR+/DxD5EUFsfUnPb/EUn
 qJQSN9+yX/i39VZb2xsPzgm9LY7bm3g=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-396-Jm5hikytMEuusSXGfXoplA-1; Mon,
 07 Sep 2026 06:50:55 -0400
X-MC-Unique: Jm5hikytMEuusSXGfXoplA-1
X-Mimecast-MFC-AGG-ID: Jm5hikytMEuusSXGfXoplA_1788778254
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3C18B19541AA; Mon,  7 Sep 2026 10:50:54 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6932C1800348; Mon,  7 Sep 2026 10:50:53 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 07 Sep 2026 14:50:11 +0400
Subject: [PATCH 13/17] qga/vss-win32: report QueryStatus return value on
 failure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260907-qga-v1-13-86456ad356e2@redhat.com>
References: <20260907-qga-v1-0-86456ad356e2@redhat.com>
In-Reply-To: <20260907-qga-v1-0-86456ad356e2@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kostiantyn Kostiuk <kkostiuk@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1225;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=ZtWeh7L52SviWsbhYRcGSL4GUIIW3vpBmGQ7tNQKqWM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqnpbjnHvIdg1nqgR0wVFm/3md70K777Ky83lpJ
 RbhQBz7sGeJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCap6W4wAKCRDa6OEJdZac
 5XkFD/0emNTE+vkhDXNPesDaVWYW5cmvtPt6XXpfY44Nwc4s01YPnMHUvPiJxPFSBG9e7wxm1GH
 xMAfsOltpr/EaFBWN96uLSmt25LAnkyd87mV7/E89Avmn9jWfzmf1RGTVeubqoGvI/f9DD7XuVG
 DSYvIeqoDQ6q1AjfLf8kusZa+0A3HuXk30RBfkJx8q6qNg74t/xAmu545ox+65Ah/efwML5FvZd
 EN6Kylwrty6xK7x/JKEwPNh0I60EX1x6OciC+hsWKV/VyCNeB0A0NB3T3JSiHqSn6zXfragsSr9
 037QxvghA8iFNWPS17wXRRPvwU/VsJkTpmvPkCE/O2JElkePCDY+EozTIYi3a4ECITU+IZombgS
 eS9r7+p4dG4Zl/GB8AMflS4ZH7yJYyKC8qHVljoyg/OH+c0oA4Rs3j5ArX348aXK47aaw5+TA3T
 zRpYPgXf9rgneEk3CkhTqplWIn9qh0vbKSjMoGbzZCf027eFZ2iMKb9ukHAiKiRruVRQa8e3PvB
 Nnr7PzRwt98FBAXSK/zv9aiSBUlvSS8U1fvi/PZ93SR/9nnuAxCecLLPO8i07D25zfjyg2NDT22
 vkDp7str3b7uGz3ig3QBihz90bvbHBeTmCkPDmGXWPeGeyki0uMvONbh7+HZePoghZEDSJ+Ppda
 T8p6QB7GI1N9rsg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

When IVssAsync::QueryStatus fails, the error was reported using its
output parameter `hr` rather than its return value `hr2`. Since the
output parameter is not guaranteed to be written on failure, this could
report a stale or uninitialized HRESULT, masking the actual error.

Fixes: b39297aedfab ("qemu-ga: Add Windows VSS provider and requester as DLL")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 qga/vss-win32/requester.cpp | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp
index e3a15f83bf90..b3daa060ac01 100644
--- a/qga/vss-win32/requester.cpp
+++ b/qga/vss-win32/requester.cpp
@@ -506,7 +506,7 @@ void requester_freeze(int *num_vols, void *mountpoints, ErrorSet *errset)
     for (i = 0; i < VSS_TIMEOUT_FREEZE_MSEC/VSS_TIMEOUT_EVENT_MSEC; i++) {
         HRESULT hr2 = vss_ctx.pAsyncSnapshot->QueryStatus(&hr, NULL);
         if (FAILED(hr2)) {
-            err_set(errset, hr, "failed to do snapshot set");
+            err_set(errset, hr2, "failed to query snapshot set status");
             goto out;
         }
         if (hr != VSS_S_ASYNC_PENDING) {

-- 
2.55.0.543.g5ebe2ebe4ea8


