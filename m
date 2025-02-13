Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B3EFC021A0
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 13:52:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiZcu-0001hS-UP; Thu, 13 Feb 2025 08:51:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchamart@redhat.com>)
 id 1tiZcp-0001fy-BB
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 08:51:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchamart@redhat.com>)
 id 1tiZcl-0001Ql-A3
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 08:51:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739454685;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v3Ka5DD552tfRB8O8dTkD7Lnt3ngyuMwpr7Jbz6905c=;
 b=UgVLgIyLUe5hPsJBr2Xv8idBjqFtaSPEkEMbTXDCoRI2SH/AUxX2f/Pb9oKpxCbc7nDL26
 9ZuqlF7pcqLjSkP8T6bcV1wDgK+ljf0CJBTbJ8tkOQMs8/OC0XQa3gI5/3wQarPSap8I75
 AIsu8zHxiUVNQuJiwWO4M9xq32tI4A8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-609-xfyzvp6MPJ6Q6Up0RnLX5A-1; Thu,
 13 Feb 2025 08:51:19 -0500
X-MC-Unique: xfyzvp6MPJ6Q6Up0RnLX5A-1
X-Mimecast-MFC-AGG-ID: xfyzvp6MPJ6Q6Up0RnLX5A
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CCB0618E6952; Thu, 13 Feb 2025 13:51:15 +0000 (UTC)
Received: from gezellig.redhat.com (unknown [10.45.242.15])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7175D300018D; Thu, 13 Feb 2025 13:51:05 +0000 (UTC)
From: Kashyap Chamarthy <kchamart@redhat.com>
To: qemu-devel@nongnu.org
Cc: maz@kernel.org, Joel Stanley <joel@jms.id.au>,
 Ninad Palsule <ninad@linux.ibm.com>, qemu-arm@nongnu.org,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eric Auger <eric.auger@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Hao Wu <wuhaotsh@google.com>, Tyrone Ting <kfting@nuvoton.com>,
 sebott@redhat.com, Steven Lee <steven_lee@aspeedtech.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Troy Lee <leetroy@gmail.com>, Alistair Francis <alistair@alistair23.me>,
 Kashyap Chamarthy <kchamart@redhat.com>
Subject: [PATCH v2 2/3] docs/cpu-features: Update "PAuth" (Pointer
 Authentication) details
Date: Thu, 13 Feb 2025 14:50:30 +0100
Message-ID: <20250213135032.2987289-3-kchamart@redhat.com>
In-Reply-To: <20250213135032.2987289-1-kchamart@redhat.com>
References: <20250213135032.2987289-1-kchamart@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kchamart@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 PP_MIME_FAKE_ASCII_TEXT=0.24, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

PAuth (Pointer Authentication), a security feature in software, is
relevant for both KVM and QEMU.  Relect this fact into the docs:

  - For KVM, `pauth` is a binary, "on" vs "off" option.  The host CPU
    will choose the cryptographic algorithm.

  - For TCG, however, along with `pauth`, a couple of properties can be
    controlled -- they're are related to cryptographic algorithm choice.

Thanks to Peter Maydell and Marc Zyngier for explaining more about PAuth
on IRC (#qemu, OFTC).

Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
---
v2: address Marc Zyngier's comments:
    https://lists.gnu.org/archive/html/qemu-devel/2025-01/msg03451.html
---
 docs/system/arm/cpu-features.rst | 46 +++++++++++++++++++++++++++++---
 1 file changed, 42 insertions(+), 4 deletions(-)

diff --git a/docs/system/arm/cpu-features.rst b/docs/system/arm/cpu-features.rst
index a596316384..94d260b573 100644
--- a/docs/system/arm/cpu-features.rst
+++ b/docs/system/arm/cpu-features.rst
@@ -204,11 +204,49 @@ the list of KVM vCPU features and their descriptions.
   the guest scheduler behavior and/or be exposed to the guest
   userspace.
 
-TCG vCPU Features
-=================
+"PAuth" (Pointer Authentication)
+================================
+
+PAuth (Pointer Authentication) is a security feature in software that
+was introduced in Armv8.3-A.  It aims to protect against ROP
+(return-oriented programming) attacks.
+
+KVM
+---
+
+``pauth``
+
+  Enable or disable ``FEAT_Pauth``.  No other properties can be
+  controlled.
+
+  The host CPU will define the PAC (pointer authentication
+  code) cryptographic algorithm.
+
+  There are different "levels" of PAuth support.  The host CPU
+  definition will define that level (e.g. PAuth, EPAC, PAuth2, FPAC,
+  FPACCOMBINE, etc).  Refer to the Arm architecture extension documents
+  for details about the description of these features.
+
+Live migration and PAuth
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+The level of PAuth support depends on which Arm architecture a given CPU
+supports (e.g. Armv8.3 vs. Armv8.6).  This gradation in PAuth support
+has implications for live migration.  For example, to be able to
+live-migrate from host-A (with Armv8.3) to host-B (with Arm v8.6):
+
+  - the source and destination hosts must "agree" on (a) the PAC
+    signature algorithm, and (b) all the sub-features of PAuth; or
+
+  - the alternative (and less desirable) option is to turn off PAuth
+    off on both source and destination — this is generally not
+    recommended, as PAuth is a security feature.
+
+TCG
+---
 
-TCG vCPU features are CPU features that are specific to TCG.
-Below is the list of TCG vCPU features and their descriptions.
+For TCG, along with ``pauth``, it is possible to control a few other
+properties of PAuth:
 
 ``pauth``
   Enable or disable ``FEAT_Pauth`` entirely.
-- 
2.48.1


