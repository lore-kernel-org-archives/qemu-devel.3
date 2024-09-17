Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C538CAC58D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 16:03:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqadZ-0005vK-Dx; Tue, 17 Sep 2024 12:01:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1sqadW-0005lV-LF
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 12:01:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1sqadU-0003gF-Vg
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 12:01:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726588863;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s/ofPsoeUxqxDQv2RABQLnVI8pNi50vFOv5/rQ2rWf0=;
 b=hNAl6iL7OiJ+/MRZ32Ws9QDC4FSSIzpTMhN2vRyxWG1lJ1Zel7s3KVgpLTrYWfOfN2yjtS
 0k2oIdu5vSCR7Dh/0G5Sn5m9hIbEEX2wkxg+sZzgY/oquoG2w0O0/ty1eykJcCeHSA6XFI
 7IKFm18cQtiZ2m8QoolxMKpEgE1G+2g=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-389-lmdaCVsgNu-c0V9JHBsEug-1; Tue,
 17 Sep 2024 12:01:02 -0400
X-MC-Unique: lmdaCVsgNu-c0V9JHBsEug-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 618261944AA4
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2024 16:01:01 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.226.82])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 348F630001A4; Tue, 17 Sep 2024 16:00:58 +0000 (UTC)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH RESEND v4 4/4] docs/system: Add recommendations to Hyper-V
 enlightenments doc
Date: Tue, 17 Sep 2024 18:00:51 +0200
Message-ID: <20240917160051.2637594-5-vkuznets@redhat.com>
In-Reply-To: <20240917160051.2637594-1-vkuznets@redhat.com>
References: <20240917160051.2637594-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=vkuznets@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

While hyperv.rst already has all currently implemented Hyper-V
enlightenments documented, it may be unclear what is the recommended set to
achieve the best result. Add the corresponding section to the doc.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 docs/system/i386/hyperv.rst | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/docs/system/i386/hyperv.rst b/docs/system/i386/hyperv.rst
index 009947e39141..1c1de77feb65 100644
--- a/docs/system/i386/hyperv.rst
+++ b/docs/system/i386/hyperv.rst
@@ -283,6 +283,36 @@ Supplementary features
   feature alters this behavior and only allows the guest to use exposed Hyper-V
   enlightenments.
 
+Recommendations
+---------------
+
+To achieve the best performance of Windows and Hyper-V guests and unless there
+are any specific requirements (e.g. migration to older QEMU/KVM versions,
+emulating specific Hyper-V version, ...), it is recommended to enable all
+currently implemented Hyper-V enlightenments with the following exceptions:
+
+- ``hv-syndbg``, ``hv-passthrough``, ``hv-enforce-cpuid`` should not be enabled
+  in production configurations as these are debugging/development features.
+- ``hv-reset`` can be avoided as modern Hyper-V versions don't expose it.
+- ``hv-evmcs`` can (and should) be enabled on Intel CPUs only. While the feature
+  is only used in nested configurations (Hyper-V, WSL2), enabling it for regular
+  Windows guests should not have any negative effects.
+- ``hv-no-nonarch-coresharing`` must only be enabled if vCPUs are properly pinned
+  so no non-architectural core sharing is possible.
+- ``hv-vendor-id``, ``hv-version-id-build``, ``hv-version-id-major``,
+  ``hv-version-id-minor``, ``hv-version-id-spack``, ``hv-version-id-sbranch``,
+  ``hv-version-id-snumber`` can be left unchanged, guests are not supposed to
+  behave differently when different Hyper-V version is presented to them.
+- ``hv-crash`` must only be enabled if the crash information is consumed via
+  QAPI by higher levels of the virtualization stack. Enabling this feature
+  effectively prevents Windows from creating dumps upon crashes.
+- ``hv-reenlightenment`` can only be used on hardware which supports TSC
+  scaling or when guest migration is not needed.
+- ``hv-spinlocks`` should be set to e.g. 0xfff when host CPUs are overcommited
+  (meaning there are other scheduled tasks or guests) and can be left unchanged
+  from the default value (0xffffffff) otherwise.
+- ``hv-avic``/``hv-apicv`` should not be enabled if the hardware does not
+  support APIC virtualization (Intel APICv, AMD AVIC).
 
 Useful links
 ------------
-- 
2.46.0


