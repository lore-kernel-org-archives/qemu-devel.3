Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44368F30938
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 10:55:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy6Kx-00045U-9v; Thu, 05 Mar 2026 05:53:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vy6Kv-0003o3-5v
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 05:53:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vy6Kt-0005j3-Mg
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 05:53:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772708022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RhHUyKvu5fylUBKCcwjEcF9V9TxeOm8kTaIv18u5oII=;
 b=Ncz5dPUxUgalHFHYARfWcY+vEBktvn4XY8oeVqZvl14nXWK6IieOdRpfrINSPWahENzGMk
 osqWE7UkSJ1IoGhLT8+pAV+tFkaxOuG2AO8kIh/ulAusqo3N56hQqgxKLwesg/dslBQnFP
 xGbPzzK/lmoWg+axd4ULAIY7I7ZPrMs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-151-Mvoh-spqOLKkdGLEvilBxg-1; Thu,
 05 Mar 2026 05:53:39 -0500
X-MC-Unique: Mvoh-spqOLKkdGLEvilBxg-1
X-Mimecast-MFC-AGG-ID: Mvoh-spqOLKkdGLEvilBxg_1772708019
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E54AD19560A5; Thu,  5 Mar 2026 10:53:38 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.75])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D2FDE3003E98; Thu,  5 Mar 2026 10:53:36 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 25/28] hw/core/machine: Remove hw_compat_2_11[] array
Date: Thu,  5 Mar 2026 11:52:12 +0100
Message-ID: <20260305105215.302571-26-thuth@redhat.com>
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

The hw_compat_2_11[] array was only used by the pc-q35-2.11,
pc-i440fx-2.11 and s390-ccw-virtio-2.11 machines, which got
removed. Remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250501230129.2596-5-philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/core/boards.h | 3 ---
 hw/core/machine.c        | 8 --------
 2 files changed, 11 deletions(-)

diff --git a/include/hw/core/boards.h b/include/hw/core/boards.h
index 54988ecbcfb..30a55b61f6d 100644
--- a/include/hw/core/boards.h
+++ b/include/hw/core/boards.h
@@ -877,7 +877,4 @@ extern const size_t hw_compat_3_0_len;
 extern GlobalProperty hw_compat_2_12[];
 extern const size_t hw_compat_2_12_len;
 
-extern GlobalProperty hw_compat_2_11[];
-extern const size_t hw_compat_2_11_len;
-
 #endif
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 285adf1e07d..3e10aec07e1 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -250,14 +250,6 @@ GlobalProperty hw_compat_2_12[] = {
 };
 const size_t hw_compat_2_12_len = G_N_ELEMENTS(hw_compat_2_12);
 
-GlobalProperty hw_compat_2_11[] = {
-    { "hpet", "hpet-offset-saved", "false" },
-    { "virtio-blk-pci", "vectors", "2" },
-    { "vhost-user-blk-pci", "vectors", "2" },
-    { "e1000", "migrate_tso_props", "off" },
-};
-const size_t hw_compat_2_11_len = G_N_ELEMENTS(hw_compat_2_11);
-
 MachineState *current_machine;
 
 static char *machine_get_kernel(Object *obj, Error **errp)
-- 
2.53.0


