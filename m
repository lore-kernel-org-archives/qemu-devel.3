Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54CB5C9EC95
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 14:36:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfJ25-0004EF-Ot; Mon, 12 Jan 2026 09:36:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vfJ1s-0003yl-D9
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 09:36:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vfJ1p-00077C-6E
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 09:36:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768228576;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WElEOrPWpec2RJt5gdjThjmgblMIOZxYmZskrj4wDlY=;
 b=Of9NIAb8JUTwyBEsKWIakmZGtYPM7Dsd/Tv4jJLbFzgMGOOCO3CoN2EThHuNidaYblixMX
 yKRCTiOF/6QvKdWJvrDs8sYk26fpsyWZRsaFGOB6OjadbOW31eflQuEmfY9c2qLCLpAJp0
 C3mPnOlT0LSanRut3eAWkVAOR8WNNLI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-161-cyw4p2F-OHOb315Fr6M2YA-1; Mon,
 12 Jan 2026 09:36:14 -0500
X-MC-Unique: cyw4p2F-OHOb315Fr6M2YA-1
X-Mimecast-MFC-AGG-ID: cyw4p2F-OHOb315Fr6M2YA_1768228573
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6BB061956046; Mon, 12 Jan 2026 14:36:13 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.227])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 39E2819560AB; Mon, 12 Jan 2026 14:36:10 +0000 (UTC)
Date: Mon, 12 Jan 2026 14:36:02 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2 32/32] tests/functional/x86_64: add functional test to
 exercise vm fd change on reset
Message-ID: <aWUDCR5EQmWDWrob@redhat.com>
References: <20260112132259.76855-1-anisinha@redhat.com>
 <20260112132259.76855-33-anisinha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260112132259.76855-33-anisinha@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Jan 12, 2026 at 06:52:45PM +0530, Ani Sinha wrote:
> A new functional test is added that exercises the code changes related to
> closing of the old KVM VM file descriptor and opening a new one upon VM reset.
> This normally happens when confidential guests are resetted but for
> non-confidential guests, we use a special machine specific debug/test parameter
> 'x-change-vmfd-on-reset' to enable this behavior.
> Only specific code changes related to re-initialization of SEV-ES, SEV-SNP and
> TDX platforms are not exercized in this test as they require hardware that
> supports running confidential guests.
> 
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>  MAINTAINERS                                   |  6 ++
>  tests/functional/x86_64/meson.build           |  1 +
>  .../x86_64/test_vmfd_change_reboot.py         | 75 +++++++++++++++++++
>  3 files changed, 82 insertions(+)
>  create mode 100755 tests/functional/x86_64/test_vmfd_change_reboot.py


> diff --git a/tests/functional/x86_64/test_vmfd_change_reboot.py b/tests/functional/x86_64/test_vmfd_change_reboot.py
> new file mode 100755
> index 0000000000..3b33322880
> --- /dev/null
> +++ b/tests/functional/x86_64/test_vmfd_change_reboot.py
> @@ -0,0 +1,75 @@
> +#!/usr/bin/env python3
> +#
> +# KVM VM file descriptor change on reset test
> +#
> +# Copyright © 2026 Red Hat, Inc.
> +#
> +# Author:
> +#  Ani Sinha <anisinha@redhat.com>
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +import os
> +from qemu.machine import machine
> +
> +from qemu_test import QemuSystemTest, Asset, exec_command_and_wait_for_pattern
> +from qemu_test import wait_for_console_pattern
> +
> +class KVMGuest(QemuSystemTest):
> +
> +    ASSET_UKI = Asset('https://gitlab.com/anisinha/misc-artifacts/'
> +                      '-/raw/main/uki.x86-64.efi?ref_type=heads',
> +                      'e0f806bd1fa24111312e1fe849d2ee69808d4343930a5'
> +                      'dc8c1688da17c65f576')
> +    ASSET_OVMF = Asset('https://gitlab.com/anisinha/misc-artifacts/'
> +                       '-/raw/main/OVMF.stateless.fd?ref_type=heads',
> +                       '58a4275aafa8774bd6b1540adceae4ea434b8db75b476'
> +                       '11839ff47be88cfcf22')

What is the source of these two binaries - the repo doesn't show any
source code or references ?  Is there no way we can use standard distro
images for this test ?

> +
> +    def common_vm_setup(self):
> +        self.require_accelerator("kvm")
> +
> +        self.vm.set_console()
> +
> +        self.vm.add_args("-accel", "kvm")
> +        self.vm.add_args("-smp", "2")
> +        self.vm.add_args("-cpu", "host")
> +        self.vm.add_args("-m", "2G")
> +        self.vm.add_args("-nographic", "-nodefaults")
> +
> +        self.uki_path = self.ASSET_UKI.fetch()
> +        self.ovmf_path = self.ASSET_OVMF.fetch()
> +
> +    def run_and_check(self):
> +        self.vm.add_args('-kernel', self.uki_path)
> +        self.vm.add_args("-bios", self.ovmf_path)
> +        # enable KVM VMFD change on reset for a non-coco VM
> +        self.vm.add_args("-machine", "q35,x-change-vmfd-on-reset=on")
> +        # enable tracing
> +        self.vm.add_args("-d", "trace:kvm_reset_vmfd")
> +
> +        try:
> +            self.vm.launch()
> +        except machine.VMLaunchFailure as e:
> +            raise e
> +
> +        self.log.info('VM launched')
> +        console_pattern = 'bash-5.1#'
> +        wait_for_console_pattern(self, console_pattern)
> +        self.log.info('VM ready with a bash prompt')
> +
> +        exec_command_and_wait_for_pattern(self, '/usr/sbin/reboot -f',
> +                                          'reboot: machine restart')
> +        console_pattern = '# --- Hello world ---'
> +        wait_for_console_pattern(self, console_pattern)
> +        self.vm.shutdown()
> +        self.assertRegex(self.vm.get_log(),
> +                         r'kvm_reset_vmfd \nINFO: virtual machine accel file '
> +                         'descriptor has changed')
> +
> +    def test_vmfd_change_on_reset(self):
> +        self.common_vm_setup()
> +        self.run_and_check()
> +
> +if __name__ == '__main__':
> +    QemuSystemTest.main()
> -- 
> 2.42.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


