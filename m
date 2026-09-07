Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC025C79F99
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 10:49:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3WuC-000639-Sc; Mon, 07 Sep 2026 06:48:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3WuA-000616-Uq
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 06:48:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3Wu9-0007ZH-3f
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 06:48:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788778128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tYfRNwV9tAgaeheG+Znb5EegaaSAbYL3kCuEkRWtyjU=;
 b=YUlrFF5aD0y4Pj4zkeCAjrnB9QB9YZmAx5QrVDSG38o/EN/UbVmoolPJvtmDO8kMs8c9Mm
 MjiSprHGwLOeO9zCfQkfVywbEpCbbeYz5m25HF00PmbAEqSaTw/ODYSOn/Ro+Tg4pbERxj
 ZMRl0+YXhgZdnGC8T4ahwK2EF2+7IEk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-117-7if3p-4AN2qRfzUNKxPtMA-1; Mon,
 07 Sep 2026 06:48:46 -0400
X-MC-Unique: 7if3p-4AN2qRfzUNKxPtMA-1
X-Mimecast-MFC-AGG-ID: 7if3p-4AN2qRfzUNKxPtMA_1788778126
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F3EC6182A11E; Mon,  7 Sep 2026 10:48:43 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5EA4526C; Mon,  7 Sep 2026 10:48:38 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 07 Sep 2026 14:48:25 +0400
Subject: [PATCH 01/17] qga/installer: preserve VssOption registry value
 across upgrades
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260907-qga-v1-1-86456ad356e2@redhat.com>
References: <20260907-qga-v1-0-86456ad356e2@redhat.com>
In-Reply-To: <20260907-qga-v1-0-86456ad356e2@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kostiantyn Kostiuk <kkostiuk@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3679;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=mtOKKpdNUw3uUnSWCflHT7P06kecXY08t1ekbENlSYw=;
 b=owEBawKU/ZANAwAKAdro4Ql1lpzlAcsmYgBqnpaApQU+WoY9Lb+KVl5jFyGMVHrVF1Ttmbysj
 /Ztx7KjmCyJAjEEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCap6WgAAKCRDa6OEJdZac
 5X9RD/DIexN3tycUt18PvY3VjXsnUjzKdsLm8GVhzw4rrgadoiDkwHcOplZVUHmlYFx6gAQl1O8
 DOdgFC7+gkBgSQxbBf9vD5oug4jNATDEzVxAmWiq6w8fj9SuHjs1aN8uWAbSw28Yb3XiSuDeSTf
 qZqp4+Bq/Pb2cdZqRdkxg29/THNyC1+P70uve9YDjFPllR9RFp9pi5Kq97j7QB99ucNdAJvgPcE
 pOGd72cS7uapAU+DkSPZoYsP11NuA2P6v8xtMF1bl/T2XfoJsFlWkOIUdDUnJvdbkyyuLuW0n6t
 HLvfByJkc49opX8uzHhc32InEkR6vs/E4pv1ryZzSEEa/PsG/gK+ZY9CXH/mLSIhNSso+blIafA
 TOYPtm6UM+mZy5ddSlJUAuIbzpjbPNXAzaS7sa9x9AwynMTepkPv5KuwShSkyvikgV4PHNEVOsU
 5efgaH01nca1tvIUozkoTlOcrj9AHAmBZI8piAfdp9Yg9NvljLEmBUgNOwVW8nrwVv/0wf+r+XZ
 YqtCgYdAAs2eFP5xUY9lCCjiVa94Xjku5erA66yZxSYk+uIAFlsQticjnG5Xey9Rp/NKUpMXgeW
 fgDqANpqJ3Q4+BVuRrhWLe001/54CyN6ziwsy5RzhfmisAGnIEJLP1n0aE+Qhvvz+WY9tDHVQjN
 WWlOerPDQapw=
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---
 qga/installer/qemu-ga.wxs | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/qga/installer/qemu-ga.wxs b/qga/installer/qemu-ga.wxs
index 32b8308728dc..5be19b211ccf 100644
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
2.55.0.543.g5ebe2ebe4ea8


