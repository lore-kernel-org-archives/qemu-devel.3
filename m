Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26994F30938
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 10:53:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy6Kd-0002YR-Ti; Thu, 05 Mar 2026 05:53:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vy6Ka-0002GV-5p
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 05:53:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vy6KY-0005YX-R8
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 05:53:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772708002;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jd1hKHeCxl9t+/TaRpY6R5FxoeLFf4ZzQD5LIlTpNp4=;
 b=cJGOl195GUKz+Ai/3Xbwvs47mhpR20UiqsQxFAVT+GvNErjy2Qhj0X7hKcbN3Ak79sE/Dn
 KWDtLJ7mqIbu5aB7+yO0e4MD1zpJSqr8vhzRkE+DiSLccHBBXz8zHayz9B5F8VypZXFnIa
 DLvKp87NrtBcZSUYZO0Vk1SaT9rxric=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-213-acKu-DvZMYOTNzIflsP8OA-1; Thu,
 05 Mar 2026 05:53:18 -0500
X-MC-Unique: acKu-DvZMYOTNzIflsP8OA-1
X-Mimecast-MFC-AGG-ID: acKu-DvZMYOTNzIflsP8OA_1772707997
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B4D1E195605F; Thu,  5 Mar 2026 10:53:17 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.75])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 58DD43003E98; Thu,  5 Mar 2026 10:53:14 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 18/28] hw/i386/pc: Remove pc_compat_2_10[] array
Date: Thu,  5 Mar 2026 11:52:05 +0100
Message-ID: <20260305105215.302571-19-thuth@redhat.com>
In-Reply-To: <20260305105215.302571-1-thuth@redhat.com>
References: <20260305105215.302571-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 33
X-Spam_score: 3.3
X-Spam_bar: +++
X-Spam_report: (3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386, SPF_HELO_PASS=-0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

The pc_compat_2_10[] array was only used by the pc-q35-2.10
and pc-i440fx-2.10 machines, which got removed. Remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250501223522.99772-3-philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/i386/pc.h | 3 ---
 hw/i386/pc.c         | 7 -------
 2 files changed, 10 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 307c120b8a2..03ef7ba2494 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -286,9 +286,6 @@ extern const size_t pc_compat_2_12_len;
 extern GlobalProperty pc_compat_2_11[];
 extern const size_t pc_compat_2_11_len;
 
-extern GlobalProperty pc_compat_2_10[];
-extern const size_t pc_compat_2_10_len;
-
 #define DEFINE_PC_MACHINE(suffix, namestr, initfn, optsfn) \
     static void pc_machine_##suffix##_class_init(ObjectClass *oc, \
                                                  const void *data) \
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 8329988013e..59cfe4f01cd 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -235,13 +235,6 @@ GlobalProperty pc_compat_2_11[] = {
 };
 const size_t pc_compat_2_11_len = G_N_ELEMENTS(pc_compat_2_11);
 
-GlobalProperty pc_compat_2_10[] = {
-    { TYPE_X86_CPU, "x-hv-max-vps", "0x40" },
-    { "i440FX-pcihost", "x-pci-hole64-fix", "off" },
-    { "q35-pcihost", "x-pci-hole64-fix", "off" },
-};
-const size_t pc_compat_2_10_len = G_N_ELEMENTS(pc_compat_2_10);
-
 /*
  * @PC_FW_DATA:
  * Size of the chunk of memory at the top of RAM for the BIOS ACPI tables
-- 
2.53.0


