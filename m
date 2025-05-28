Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C748EC3ABB2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 10:06:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKDfx-00045A-1Z; Wed, 28 May 2025 06:06:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uKDfZ-0003pg-1I
 for qemu-devel@nongnu.org; Wed, 28 May 2025 06:06:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uKDfX-0007EO-96
 for qemu-devel@nongnu.org; Wed, 28 May 2025 06:05:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748426754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dKZE1RSoSBOz6DDkalid0XJ7WvsEX48DFl11SRZz3mA=;
 b=Ah+8iJwbAJh+PCyXTAqxGvVJEMPh5k1GK1KBjaGEmKWE678l9l0GtXwAdY/z5srSEvUm5c
 KQgwjjQNNqhenRfZnTn8trdYLWQ9H/up/g2uiDgHpq1ULRH6XrKJ85qCMDTviD2+7SJT/J
 BZPM3DOe/1cVgOt9hDupPr10eks2wgc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-544-qRKwQ3UHM1ScL0Bqup-b5g-1; Wed,
 28 May 2025 06:05:51 -0400
X-MC-Unique: qRKwQ3UHM1ScL0Bqup-b5g-1
X-Mimecast-MFC-AGG-ID: qRKwQ3UHM1ScL0Bqup-b5g_1748426750
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 71BBF1800258; Wed, 28 May 2025 10:05:50 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.34.110])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D14C7180049D; Wed, 28 May 2025 10:05:46 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 12/27] hw/i386/pc: Remove pc_compat_2_4[] array
Date: Wed, 28 May 2025 12:04:52 +0200
Message-ID: <20250528100507.313906-13-thuth@redhat.com>
In-Reply-To: <20250528100507.313906-1-thuth@redhat.com>
References: <20250528100507.313906-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) DKIMWL_WL_HIGH=-2.907, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

The pc_compat_2_4[] array was only used by the pc-q35-2.4
and pc-i440fx-2.4 machines, which got removed. Remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Message-ID: <20250512083948.39294-4-philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/i386/pc.h |  3 ---
 hw/i386/pc.c         | 19 -------------------
 2 files changed, 22 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index f4a874b17fc..b34aa25fdce 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -301,9 +301,6 @@ extern const size_t pc_compat_2_6_len;
 extern GlobalProperty pc_compat_2_5[];
 extern const size_t pc_compat_2_5_len;
 
-extern GlobalProperty pc_compat_2_4[];
-extern const size_t pc_compat_2_4_len;
-
 #define DEFINE_PC_MACHINE(suffix, namestr, initfn, optsfn) \
     static void pc_machine_##suffix##_class_init(ObjectClass *oc, \
                                                  const void *data) \
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index c8bb4a3ee47..2b46714a5ac 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -262,25 +262,6 @@ const size_t pc_compat_2_6_len = G_N_ELEMENTS(pc_compat_2_6);
 GlobalProperty pc_compat_2_5[] = {};
 const size_t pc_compat_2_5_len = G_N_ELEMENTS(pc_compat_2_5);
 
-GlobalProperty pc_compat_2_4[] = {
-    PC_CPU_MODEL_IDS("2.4.0")
-    { "Haswell-" TYPE_X86_CPU, "abm", "off" },
-    { "Haswell-noTSX-" TYPE_X86_CPU, "abm", "off" },
-    { "Broadwell-" TYPE_X86_CPU, "abm", "off" },
-    { "Broadwell-noTSX-" TYPE_X86_CPU, "abm", "off" },
-    { "host" "-" TYPE_X86_CPU, "host-cache-info", "on" },
-    { TYPE_X86_CPU, "check", "off" },
-    { "qemu64" "-" TYPE_X86_CPU, "sse4a", "on" },
-    { "qemu64" "-" TYPE_X86_CPU, "abm", "on" },
-    { "qemu64" "-" TYPE_X86_CPU, "popcnt", "on" },
-    { "qemu32" "-" TYPE_X86_CPU, "popcnt", "on" },
-    { "Opteron_G2" "-" TYPE_X86_CPU, "rdtscp", "on" },
-    { "Opteron_G3" "-" TYPE_X86_CPU, "rdtscp", "on" },
-    { "Opteron_G4" "-" TYPE_X86_CPU, "rdtscp", "on" },
-    { "Opteron_G5" "-" TYPE_X86_CPU, "rdtscp", "on", }
-};
-const size_t pc_compat_2_4_len = G_N_ELEMENTS(pc_compat_2_4);
-
 /*
  * @PC_FW_DATA:
  * Size of the chunk of memory at the top of RAM for the BIOS ACPI tables
-- 
2.49.0


