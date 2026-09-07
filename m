Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EA56C79F9F
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 10:50:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3Wvo-0007Re-QD; Mon, 07 Sep 2026 06:50:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3Wvi-0007Qb-Kh
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 06:50:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3Wvf-0007yF-QD
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 06:50:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788778223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LAn9LXQ/71U5VFwcq/jTJlZ5CbT4GlJECNd20vWIhew=;
 b=Z3PBRZnyTOhoCRcaAdKRyprPFA6j7XU7r8uUJv2h57XwrGCXWeDBSF6GUTZHQkktczQPiq
 aJFVz6WfEEAtfMrGYxDRj7gpKn2r3cwZN+ChRubCYJQZkcIdplLukk7mpqccZjMeNkROIG
 7z36If0J4kbeFzsXV8w3WqodrrnNBcE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-319-fS58Uq05NuaVHqaVb4vt9w-1; Mon,
 07 Sep 2026 06:50:19 -0400
X-MC-Unique: fS58Uq05NuaVHqaVb4vt9w-1
X-Mimecast-MFC-AGG-ID: fS58Uq05NuaVHqaVb4vt9w_1788778219
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DC6BB19540DB; Mon,  7 Sep 2026 10:50:18 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E3D371800598; Mon,  7 Sep 2026 10:50:17 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 07 Sep 2026 14:50:01 +0400
Subject: [PATCH 03/17] qga/vss-win32: pass valid SERVICE_STATUS to
 ControlService
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260907-qga-v1-3-86456ad356e2@redhat.com>
References: <20260907-qga-v1-0-86456ad356e2@redhat.com>
In-Reply-To: <20260907-qga-v1-0-86456ad356e2@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kostiantyn Kostiuk <kkostiuk@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1148;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=sx6g589gOMK4C+r61jCesMHXiLnlP3zeTmUtl0johFk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqnpbj8uIlZRS8aujOLEZUe1jgSNgJT/ECW21f4
 z/4qxZuUDCJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCap6W4wAKCRDa6OEJdZac
 5XnmD/wMybTDFHh+XYgHaitcnJ/bi3EYGdV1F4IsiRocQyftNN3BILxc3tpDgSExTMnHHUi3OF8
 psD8scGrKMrGTyaoN/w9PJFSG3MqS84/ZKYiDb9ZI8Vxf/fPPL70l855HVHzYWENVjLhuItWoYF
 lfuYH6/P4EBt7zMZAsQzWr8YcXyoGPhZNJ0y+8pXWcnqxoDDYuJwxnqVTUMbbJHtDBogAMMsrIK
 sxJjsnyCv3xdBHgjIpwfE+h8kYkd51uPu9lzs6ezt8DyU8mgTi8i363+Df+tthMu8R8qBRhpwRf
 R08ZIpFqF5ayjTo0tbflwHJurYQ1+JhPTBUJpJpxzam0voh+isCgzBZndEEzZ0So0II8a+IfF4O
 E7WJCnwybPu0lq773OiY7aP+8sy0nY6pGVMURxv07CTqT70lecYGlIqwRCdYFFTJlTcHxhyHrFH
 vNzcG9BVLjsbCX7K8HdZnkPmk76Msb0FGikoWRUcVnEAyKTjWNe0cNrgtX6mPoEv1rlIm0pK9B5
 Mc3Jq6zr45wJK+9p7Zd8kxsV3WpEmoe0vgZE6Zh+X4xjA+j6uBXwWhc+w7Gv3r+Q1EUJMn3QhtB
 TvDmBiKsPevOE9EWv1yVMNhAwz6XwlETVprq+0KqL8URcBBowCT9W7GpziB028tHEw6Odn0uqOX
 SowxrrIT/sT7OPw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

ControlService requires a non-NULL lpServiceStatus parameter ([out] vs
[out, optional]).
Passing NULL is undefined behavior per MSDN and can crash on
some Windows versions.

Fixes: 917ebcb17027 ("qga-win: Fix QGA VSS Provider service stop failure")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 qga/vss-win32/install.cpp | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp
index 5b7a8e9bc529..f89658d277e9 100644
--- a/qga/vss-win32/install.cpp
+++ b/qga/vss-win32/install.cpp
@@ -572,6 +572,7 @@ namespace _com_util
 /* Stop QGA VSS provider service using Winsvc API  */
 STDAPI StopService(void)
 {
+    SERVICE_STATUS status;
     qga_debug_begin;
 
     HRESULT hr = S_OK;
@@ -590,7 +591,7 @@ STDAPI StopService(void)
         hr =  E_FAIL;
         goto out;
     }
-    if (!(ControlService(service, SERVICE_CONTROL_STOP, NULL))) {
+    if (!(ControlService(service, SERVICE_CONTROL_STOP, &status))) {
         errmsg(E_FAIL, "Failed to stop service");
         hr = E_FAIL;
     }

-- 
2.55.0.543.g5ebe2ebe4ea8


