Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 901E1C54E67
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 16:14:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rlABZ-0001YG-7c; Fri, 15 Mar 2024 12:13:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lorenz@brun.one>) id 1rl91I-0007iI-Hz
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 10:58:52 -0400
Received: from s2.dolansoft.org ([212.51.146.245] helo=mx.dolansoft.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lorenz@brun.one>) id 1rl91G-0005oE-Dh
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 10:58:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=brun.one;
 s=s1; h=MIME-Version:Message-ID:Date:Subject:Cc:To:From:In-Reply-To:
 References:From:To:Subject:Date:Message-ID:Reply-To;
 bh=q71kjRy1vgrW30Iwwa+K3qmXkGojyqby1TCUGLaZCwI=; b=KWsaEmWjLLmFA9teN/MSlDWCY/
 6q+6uh+TJyuSiEzrtt176fqeFqOHJwsJU+cVZUClNtstWftWoaByRwj9X4iwo/ANe/RnUnjWDuOjK
 xAtBJcy2uBvmPmorSeD/E5cQdAiZaI4uyn3dJezjzpixN2cwvHSCiLDBtTrcMUBegiRpxIY+41xYA
 3cYWPYlPOeZIipZn49DoSO5NyHVwxwWj5I8KeHG+WmnPhgEoJq9y0oUKwQIkOlm3Cn9FuDY4BUsPs
 XvL+dcRSSDrBzH9O9phRIU2l/vJ3dscuFCsT9+8i/LFxoEPodg1jrQ5ScOKSlaG4woNyAbdewvsqW
 yzN92W5A==;
Received: from [212.51.153.89] (helo=localhost.localdomain)
 by mx.dolansoft.org with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <lorenz@dolansoft.org>)
 id 1rl91A-000bvY-2e; Fri, 15 Mar 2024 14:58:44 +0000
From: Lorenz Brun <lorenz@brun.one>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Fam Zheng <fam@euphon.net>
Subject: [PATCH] scsi-generic: fix io_timeout property not applying
Date: Fri, 15 Mar 2024 15:58:31 +0100
Message-ID: <20240315145831.2531695-1-lorenz@brun.one>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.51.146.245; envelope-from=lorenz@brun.one;
 helo=mx.dolansoft.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 15 Mar 2024 12:13:31 -0400
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

The io_timeout property, introduced in c9b6609 (part of 6.0) is
silently overwritten by the hardcoded default value of 30 seconds
(DEFAULT_IO_TIMEOUT) in scsi_generic_realize because that function is
being called after the properties have already been applied.

The property definition already has a default value which is applied
correctly when no value is explicitly set, so we can just remove the
code which overrides the io_timeout completely.

This has been tested by stracing SG_IO operations with the io_timeout
property set and unset and now sets the timeout field in the ioctl
request to the proper value.

Fixes: c9b6609b69facad ("scsi: make io_timeout configurable")
Signed-off-by: Lorenz Brun <lorenz@brun.one>
---
 hw/scsi/scsi-generic.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index b7b04e1d63..ee945f87e3 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -752,7 +752,6 @@ static void scsi_generic_realize(SCSIDevice *s, Error **errp)
 
     /* Only used by scsi-block, but initialize it nevertheless to be clean.  */
     s->default_scsi_version = -1;
-    s->io_timeout = DEFAULT_IO_TIMEOUT;
     scsi_generic_read_device_inquiry(s);
 }
 
-- 
2.42.0


