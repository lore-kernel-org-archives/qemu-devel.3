Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B2B8C982CF
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 13:34:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7CFL-0000d5-Ef; Thu, 17 Sep 2026 09:33:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1x7CF5-0000bP-9H
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 09:33:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1x7CEy-0003WR-HY
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 09:33:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789652007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QUgn2pLNsDWfsI6yE3tCPpGdwJeOajVyjdQeyTCT2nc=;
 b=ATAlKa4D9FOdfKywUF8GnPCHeXDjxWNzWURbYWNc6tp+Ykxi21helOW/J4A79NaRoD0SMc
 iS8Oqg88Uha8wdwYIXdfCg5E6AStOpesaBLz4lg12y442CGJ3j2DLUeAOovKodAyHi7Q8x
 z2iAEJ/u3yAVIxKLC5/2lfRcqOsoAmg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-374-Nc-w_BsHMGGsZdXqzUmUEA-1; Thu,
 17 Sep 2026 09:33:24 -0400
X-MC-Unique: Nc-w_BsHMGGsZdXqzUmUEA-1
X-Mimecast-MFC-AGG-ID: Nc-w_BsHMGGsZdXqzUmUEA_1789652003
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 731511953964; Thu, 17 Sep 2026 13:33:23 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.48.37])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 32B4430001BE; Thu, 17 Sep 2026 13:33:23 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 53A7C1800788; Thu, 17 Sep 2026 15:33:19 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 5/5] hw/uefi: improve default config security
Date: Thu, 17 Sep 2026 15:33:18 +0200
Message-ID: <20260917133318.2004317-6-kraxel@redhat.com>
In-Reply-To: <20260917133318.2004317-1-kraxel@redhat.com>
References: <20260917133318.2004317-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

Recent UEFI spec versions do not require a self-signed PK any more.
There is no good reason to stick to this requirement, but there is one
reason to remove it:  It is not needed to enable CustomMode then to
enroll secure boot keys which are not self-signed.

This commit changes the uefi-vars default configuration to remove the
self signed platform key requirement and to disable CustomMode.

Little background on CustomMode:

This is a special edk2 mode which allows to freely update secure boot
variables.  This is used by the firmware setup utility to allow the user
change the secure boot certificates.  The EnrollDefaultKeys.efi utility
used to depend on CustomMode too.

Typically enabling CustomMode requires the user being physically
present.  Implementing such a check in a sensible way for a virtual
machine is not really possible though.  So OVMF doesn't do that and
CustomMode can be enabled without that physical presence check.
Therefore disabling CustomMode (by the qemu variable service blocking
updates of the EFI variable with EFI_WRITE_PROTECTED) is a nice security
improvement for secure boot support in virtual machines.

User-visible change:  Updating secure boot configuration via firmware
setup utility does not work by default.  Setting the
"disable-custom-mode=off" property will re-enable this if needed.
Alternatively the variable store can be prepared on the host machine
instead of doing it inside the guest.

Related edk2 commits:
 - 3c01a11daae2 ("OvmfPkg: set PcdRequireSelfSignedPk to FALSE").
 - 0a7ed7ed3457 ("OvmfPkg/EnrollDefaultKeys: do not require CustomMode")

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20260904085509.2267560-3-kraxel@redhat.com>
---
 hw/uefi/var-service-sysbus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/uefi/var-service-sysbus.c b/hw/uefi/var-service-sysbus.c
index c4acdea275ad..e5e0441e16f7 100644
--- a/hw/uefi/var-service-sysbus.c
+++ b/hw/uefi/var-service-sysbus.c
@@ -37,9 +37,9 @@ static const Property uefi_vars_sysbus_properties[] = {
     DEFINE_PROP_BOOL("force-secure-boot", uefi_vars_sysbus_state,
                      state.force_secure_boot, false),
     DEFINE_PROP_BOOL("disable-custom-mode", uefi_vars_sysbus_state,
-                     state.disable_custom_mode, false),
+                     state.disable_custom_mode, true),
     DEFINE_PROP_BOOL("require-self-signed-pk", uefi_vars_sysbus_state,
-                     state.require_self_signed_pk, true),
+                     state.require_self_signed_pk, false),
     DEFINE_PROP_BOOL("use-pio", uefi_vars_sysbus_state,
                      state.use_pio, false),
 };
-- 
2.55.0


