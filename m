Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F9FBCA0FE7
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 14:33:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqYF4-0003GI-To; Mon, 25 Aug 2025 10:32:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1uqYF3-0003FN-7f
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 10:32:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1uqYEx-0001e0-VA
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 10:32:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756132322;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=zjc1ieJeYMHPFoFkYve/rIbERvx3QuOeuutbH4Q0Goo=;
 b=IFOX3hUhYS3V2hT+5Y4sLxCqzDAuijp6O6HxC9HIPqX6icv/iqyn3Q7O30PKzRtWpREYtw
 GwBozt2f0PhJAvN4pHU90jc0NRFBQfF1RdvnHwMjkQShwXJImvMHLH+ElwE4TOE2qMfORc
 kxsc48QQ/GQuUg0TTonbD2XoQiIby58=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-21-aTKqwkC_OSqkrk6bgoLFlA-1; Mon,
 25 Aug 2025 10:32:01 -0400
X-MC-Unique: aTKqwkC_OSqkrk6bgoLFlA-1
X-Mimecast-MFC-AGG-ID: aTKqwkC_OSqkrk6bgoLFlA_1756132320
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 32D2918002CE; Mon, 25 Aug 2025 14:32:00 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.45.224.207])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A29DE195419F; Mon, 25 Aug 2025 14:31:58 +0000 (UTC)
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Yan Vugenfirer <yvugenfi@redhat.com>
Subject: [PATCH] qga/installer: Remove QGA VSS if QGA installation failed
Date: Mon, 25 Aug 2025 17:31:55 +0300
Message-ID: <20250825143155.160913-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

When QGA Installer failed to install QGA service but install
QGA VSS provider, provider should be removed before installer
exits. Otherwise QGA VSS will has broken infomation and
prevent QGA installation in next run.

Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
---
 qga/installer/qemu-ga.wxs | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/qga/installer/qemu-ga.wxs b/qga/installer/qemu-ga.wxs
index df572adb4a..32b8308728 100644
--- a/qga/installer/qemu-ga.wxs
+++ b/qga/installer/qemu-ga.wxs
@@ -151,6 +151,14 @@
               Return="check"
               >
     </CustomAction>
+    <CustomAction Id="UnRegisterCom_Rollback"
+              ExeCommand='"[qemu_ga_directory]qga-vss.dll",DLLCOMUnregister'
+              Execute="rollback"
+              Property="rundll"
+              Impersonate="no"
+              Return="check"
+              >
+    </CustomAction>
     <?endif?>
 
     <Feature Id="QEMUFeature" Title="QEMU Guest Agent" Level="1">
@@ -174,8 +182,19 @@
 
     <InstallExecuteSequence>
       <?ifdef var.InstallVss?>
-      <Custom Action="UnRegisterCom" After="StopServices">Installed</Custom>
-      <Custom Action="RegisterCom" After="InstallServices">NOT REMOVE</Custom>
+        <!-- Use explicit Sequence number to provide an absolute position in the sequence-->
+        <!-- This is needed to set "UnRegisterCom_Rollback" before "RegisterCom" and after "InstallFiles"-->
+        <!-- but, Wix detect this double condition incorrectly -->
+
+        <!-- UnRegisterCom_Rollback (for install rollback): at 5849, right before RegisterCom (5850)-->
+        <!-- Runs only if the installation fails and rolls back-->
+        <Custom Action="UnRegisterCom_Rollback" Sequence="5849">NOT REMOVE</Custom>
+
+        <!-- RegisterCom (for install): at 5850, right after InstallFiles (5849) (old: After="InstallServices")-->
+        <Custom Action="RegisterCom" Sequence="5850">NOT REMOVE</Custom>
+
+        <!-- UnRegisterCom (for uninstall): at 1901, right after StopServices (1900) (old: After="StopServices")-->
+        <Custom Action="UnRegisterCom" Sequence="1901">Installed</Custom>
       <?endif?>
     </InstallExecuteSequence>
   </Product>
-- 
2.50.1


