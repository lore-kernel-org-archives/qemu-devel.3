Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A6D0C88E53
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 11:24:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6RGt-0007yZ-Nw; Tue, 15 Sep 2026 07:24:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1x6RGo-0007xt-7Q
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 07:24:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1x6RGm-0001mz-F4
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 07:24:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789471451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D6hgPK2IS1QKGNozGyvaYa9W0IoQnt5bz9ayovwpZ6o=;
 b=LDYCIB43wOkmGcpr+PfgzSSbkv0lOcWONpBgSbXo5toN9uR3RkMfcp1SSNjOVFjc51K0ca
 gv2HcXDiM52btzI/WEnu2E8Z8Fy7PfsDXZiX7Xyz2z9EfstlLihMTGppHTDRcXUk/VQKXe
 JlAQK/r8HolTa/4aO/KrRHsgWQZqY9k=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-604-l6wt7EesOBq90630h2kR2g-1; Tue,
 15 Sep 2026 07:24:08 -0400
X-MC-Unique: l6wt7EesOBq90630h2kR2g-1
X-Mimecast-MFC-AGG-ID: l6wt7EesOBq90630h2kR2g_1789471447
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D3B30180B5D6; Tue, 15 Sep 2026 11:24:07 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.44.49.17])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1AE481956045; Tue, 15 Sep 2026 11:24:05 +0000 (UTC)
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>
Subject: [PULL 03/19] qga/installer: preserve VssOption registry value across
 upgrades
Date: Tue, 15 Sep 2026 14:23:21 +0300
Message-ID: <20260915112337.43307-4-kkostiuk@redhat.com>
In-Reply-To: <20260915112337.43307-1-kkostiuk@redhat.com>
References: <20260915112337.43307-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The VssOption registry value was unconditionally written to 1 on every
install, overwriting any administrator customization. Additionally, it
was created even when VSS support was not being installed.

Move VssOption into its own component guarded by the InstallVss
preprocessor conditional. Use a RegistrySearch to read any existing
value into the VSSOPTION_VALUE property (defaulting to #1 for fresh
installs), and write it back via MSI property substitution so admin
customizations survive upgrades.

Update the registry_entries component GUID since its resource set
changed.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2919
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260907-qga-v1-1-86456ad356e2@redhat.com
Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
---
 qga/installer/qemu-ga.wxs | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/qga/installer/qemu-ga.wxs b/qga/installer/qemu-ga.wxs
index 32b8308728..5be19b211c 100644
--- a/qga/installer/qemu-ga.wxs
+++ b/qga/installer/qemu-ga.wxs
@@ -31,6 +31,15 @@
       />
     <Media Id="1" Cabinet="qemu_ga.$(var.QEMU_GA_VERSION).cab" EmbedCab="yes" />
     <Property Id="WHSLogo">1</Property>
+    <?ifdef var.InstallVss?>
+    <Property Id="VSSOPTION_VALUE" Value="#1">
+      <RegistrySearch Id="VssOptionSearch"
+                      Root="HKLM"
+                      Key="System\CurrentControlSet\Services\QEMU Guest Agent VSS Provider"
+                      Name="VssOption"
+                      Type="raw" />
+    </Property>
+    <?endif?>
     <Property Id="ARPNOMODIFY" Value="yes" Secure="yes" />
     <MajorUpgrade
       DowngradeErrorMessage="Error: A newer version of QEMU guest agent is already installed."
@@ -111,7 +120,7 @@
               <File Id="libpcre2_8_0.dll" Name="libpcre2-8-0.dll" Source="$(var.BIN_DIR)/libpcre2-8-0.dll" KeyPath="yes" DiskId="1"/>
             </Component>
           <?endif?>
-          <Component Id="registry_entries" Guid="{D075D109-51CA-11E3-9F8B-000C29858960}">
+          <Component Id="registry_entries" Guid="{62A2D9E2-B22F-410C-8E41-A0D9E653B944}">
             <RegistryKey Root="HKLM"
                          Key="Software\$(var.QEMU_GA_MANUFACTURER)\$(var.QEMU_GA_DISTRO)\Tools\QemuGA">
               <RegistryValue Type="string" Name="ProductID" Value="fb0a0d66-c7fb-4e2e-a16b-c4a3bfe8d13b" />
@@ -122,11 +131,16 @@
               <RegistryValue Type="integer" Name="TypesSupported" Value="7" />
               <RegistryValue Type="string" Name="EventMessageFile" Value="[qemu_ga_directory]qemu-ga.exe" />
             </RegistryKey>
+          </Component>
+          <?ifdef var.InstallVss?>
+          <Component Id="vss_registry_option" Guid="{75166af0-cdc9-423f-9a30-50bb59342b9b}">
             <RegistryKey Root="HKLM"
                          Key="System\CurrentControlSet\Services\QEMU Guest Agent VSS Provider">
-              <RegistryValue Type="integer" Name="VssOption" Value="1" />
+              <!-- Type="string" so MSI resolves [VSSOPTION_VALUE]; the "#N" raw format produces a REG_DWORD. -->
+              <RegistryValue Type="string" Name="VssOption" Value="[VSSOPTION_VALUE]" KeyPath="yes" />
             </RegistryKey>
           </Component>
+          <?endif?>
         </Directory>
       </Directory>
     </Directory>
@@ -167,6 +181,7 @@
       <ComponentRef Id="libstdc++_6_lib" />
       <ComponentRef Id="qga_vss_dll" />
       <ComponentRef Id="qga_vss_tlb" />
+      <ComponentRef Id="vss_registry_option" />
       <?endif?>
       <ComponentRef Id="gspawn-helper-console" />
       <ComponentRef Id="gspawn-helper" />
-- 
2.55.0


