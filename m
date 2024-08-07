Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2F40C52D6F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 12:44:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbg1L-0002C6-86; Wed, 07 Aug 2024 08:44:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1sbg11-0000gR-9V
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 08:43:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1sbg0y-0005Pw-Ng
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 08:43:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723034618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Dp0XFDIpbGIxHakA9AT+4XWxwf1e1D4AxBZVRNIjJRc=;
 b=CbsE7wVINIcAKILhA4GbxPqJN3xlYQ3plmrByzriCWw3N7ni+EVvGLTn4gDV8FWpH/0Uyt
 DgA+9uOam7oYFdGNsvQa4tVZW4pSwGj5sQ434SFpZlGf3QJlxBah0r0Jr219fXP0EG8WLX
 JxcUZQNUdNldtiT9zcCVb6puPOUmf5c=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-144-f7ppGtyYOCGykC_W2vyTyg-1; Wed,
 07 Aug 2024 08:43:37 -0400
X-MC-Unique: f7ppGtyYOCGykC_W2vyTyg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3D15E1944B3B
 for <qemu-devel@nongnu.org>; Wed,  7 Aug 2024 12:43:36 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.208.25])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DA9D6300018D; Wed,  7 Aug 2024 12:43:34 +0000 (UTC)
From: Anthony Harivel <aharivel@redhat.com>
To: pbonzini@redhat.com
Cc: qemu-devel@nongnu.org,
	Anthony Harivel <aharivel@redhat.com>
Subject: [PATCH 0/1] Fix energy calcultation in RAPL MSR
Date: Wed,  7 Aug 2024 14:43:19 +0200
Message-ID: <20240807124320.1741124-1-aharivel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aharivel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Paolo,

The value reported by the calculation was looking very wrong to me.

This should fix it for good.

Calculated value appears now way more accurate from what is expected 
from the feature:

with "-smp 4":

[...]
# modprobe intel_rapl_msr.ko
intel_rapl_common: Found RAPL domain package
intel_rapl_common: found 1 domains on package-0
intel_rapl_common: Core CPU package-0:package energy=61035pJ, time=976us, power=125000uW
intel_rapl_common: update package-0 domain package data
# 
# 
# 
# cat /sys/class/powercap/intel-rapl:0/energy_uj 
303160
# cat /sys/class/powercap/intel-rapl:0/energy_uj 
325621
# cat /sys/class/powercap/intel-rapl:0/energy_uj 
325621
# cat /sys/class/powercap/intel-rapl:0/energy_uj 
357237
# cat /sys/class/powercap/intel-rapl:0/energy_uj 
357237
# cat /sys/class/powercap/intel-rapl:0/energy_uj 
388792
[...]

Tested with several SMP architecture.
(i.e -smp 4 / -smp 8,sockets=2,dies=1 / -smp 8,sockets=4,dies=2 )

Anthony Harivel (1):
  target/i386: Fix arguments for vmsr_read_thread_stat()

 target/i386/kvm/kvm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
2.45.2


