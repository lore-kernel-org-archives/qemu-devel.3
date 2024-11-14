Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81A58D65C6F
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 11:01:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBXbC-0001tK-P2; Thu, 14 Nov 2024 06:01:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tBXbB-0001su-H3
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 06:01:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tBXbA-0006v2-2G
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 06:01:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731582075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=82tSYR4nPqAOKacioK5+vZbuqxoj+kBi00Fqe4SIAZo=;
 b=UlPh0NMz/OqOIpwFCj6acU+FKVyi3iRCyoTlKxj32LyxYjx1cJY7xNeKlf90bQZ3+hPUBE
 JVDc1mdQlHWTwORbt3Plj3HAh/Ob4LP5Z3YqiCT0Hu6lRmLmFcffs9xU34jgXSvY7c0Hde
 tW5lLUU918hGgGoSCJomtUUJCj23/To=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-464-RREJZOkLOHif_s2belNM6Q-1; Thu,
 14 Nov 2024 06:01:10 -0500
X-MC-Unique: RREJZOkLOHif_s2belNM6Q-1
X-Mimecast-MFC-AGG-ID: RREJZOkLOHif_s2belNM6Q
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3EEEF19540EF; Thu, 14 Nov 2024 11:01:08 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.143])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1B81930000DF; Thu, 14 Nov 2024 11:01:07 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id B1C3E18009A8; Thu, 14 Nov 2024 12:01:01 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 2/5] x86/loader: only patch linux kernels
Date: Thu, 14 Nov 2024 12:00:58 +0100
Message-ID: <20241114110101.44322-3-kraxel@redhat.com>
In-Reply-To: <20241114110101.44322-1-kraxel@redhat.com>
References: <20241114110101.44322-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.119,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

If the binary loaded via -kernel is *not* a linux kernel (in which
case protocol == 0), do not patch the linux kernel header fields.

It's (a) pointless and (b) might break binaries by random patching
and (c) changes the binary hash which in turn breaks secure boot
verification.

Background: OVMF happily loads and runs not only linux kernels but
any efi binary via direct kernel boot.

Note: Breaking the secure boot verification is a problem for linux
kernels too, but fixed that is left for another day ...

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20240905141211.1253307-3-kraxel@redhat.com>
---
 hw/i386/x86-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index bc360a9ea44b..ee047308331a 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -943,7 +943,7 @@ void x86_load_linux(X86MachineState *x86ms,
      * kernel on the other side of the fw_cfg interface matches the hash of the
      * file the user passed in.
      */
-    if (!sev_enabled()) {
+    if (!sev_enabled() && protocol > 0) {
         memcpy(setup, header, MIN(sizeof(header), setup_size));
     }
 
-- 
2.47.0


