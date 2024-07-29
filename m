Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A6B2C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 10:59:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYO5X-0007qR-DJ; Mon, 29 Jul 2024 06:58:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sYO5V-0007pH-IB
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 06:58:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sYO5T-0000MU-J3
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 06:58:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722250722;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=DJVO6EmDnCOMxh1KXNwzZT/gFc6L6PBNcI8l/LMriwE=;
 b=Uz9MK2mpP+f6y5TmLF7zTWH7NYFu75fclcuRrYwdq8DAFXi+2M70u2pzwryJpoYVZxONKK
 cOToXG/cf4Ioe6YAmY+dOvxc16OEQ7L3h76e6y+OjUiSsvt+hQI5gJNPvhJ4ipid0lOEKM
 CHa+xhIACY3tPTIiaNix6fY+7rq1to8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-491-K9OQYNd9N4WF8lqAdILW2g-1; Mon,
 29 Jul 2024 06:58:38 -0400
X-MC-Unique: K9OQYNd9N4WF8lqAdILW2g-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 44C981955D53; Mon, 29 Jul 2024 10:58:36 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.58])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A70FC19560AE; Mon, 29 Jul 2024 10:58:29 +0000 (UTC)
Date: Mon, 29 Jul 2024 11:58:26 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Cleber Rosa <crosa@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, kvm@vger.kernel.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 qemu-arm@nongnu.org, Radoslaw Biernacki <rad@semihalf.com>,
 Paul Durrant <paul@xen.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: Re: [PATCH 07/13] tests/avocado/kvm_xen_guest.py: cope with asset RW
 requirements
Message-ID: <Zqd10nIix4gXKtDw@redhat.com>
References: <20240726134438.14720-1-crosa@redhat.com>
 <20240726134438.14720-8-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240726134438.14720-8-crosa@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Jul 26, 2024 at 09:44:32AM -0400, Cleber Rosa wrote:
> Some of these tests actually require the root filesystem image,
> obtained through Avocado's asset feature and kept in a common cache
> location, to be writable.
> 
> This makes a distinction between the tests that actually have this
> requirement and those who don't.  The goal is to be as safe as
> possible, avoiding causing cache misses (because the assets get
> modified and thus need to be dowloaded again) while avoid copying the
> root filesystem backing file whenever possible.
> 
> This also allow these tests to be run in parallel with newer Avocado
> versions.
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>  tests/avocado/kvm_xen_guest.py | 27 ++++++++++++++++++---------
>  1 file changed, 18 insertions(+), 9 deletions(-)
> 
> diff --git a/tests/avocado/kvm_xen_guest.py b/tests/avocado/kvm_xen_guest.py
> index 318fadebc3..d73fa888ef 100644
> --- a/tests/avocado/kvm_xen_guest.py
> +++ b/tests/avocado/kvm_xen_guest.py
> @@ -10,6 +10,7 @@
>  # SPDX-License-Identifier: GPL-2.0-or-later
>  
>  import os
> +import shutil
>  
>  from qemu.machine import machine
>  
> @@ -43,7 +44,7 @@ def get_asset(self, name, sha1):
>          return self.fetch_asset(name=f"qemu-kvm-xen-guest-{name}",
>                                  locations=(url), asset_hash=sha1)
>  
> -    def common_vm_setup(self):
> +    def common_vm_setup(self, readwrite=False):
>          # We also catch lack of KVM_XEN support if we fail to launch
>          self.require_accelerator("kvm")
>  
> @@ -56,11 +57,19 @@ def common_vm_setup(self):
>                                            "367962983d0d32109998a70b45dcee4672d0b045")
>          self.rootfs = self.get_asset("rootfs.ext4",
>                                       "f1478401ea4b3fa2ea196396be44315bab2bb5e4")
> +        if readwrite:
> +            dest = os.path.join(self.workdir, os.path.basename(self.rootfs))
> +            shutil.copy(self.rootfs, dest)
> +            self.rootfs = dest

This is a very expensive way of creating a writable disk. Better to
avoid adding this 'readwrite' parameter at all, and instead create
a throwaway qcow2 overlay for the image for all tests. That ensures
writability for everything in a cheap manner.

>  
> -    def run_and_check(self):
> +    def run_and_check(self, readwrite=False):
> +        if readwrite:
> +            drive = f"file={self.rootfs},if=none,format=raw,id=drv0"
> +        else:
> +            drive = f"file={self.rootfs},if=none,readonly=on,format=raw,id=drv0"
>          self.vm.add_args('-kernel', self.kernel_path,
>                           '-append', self.kernel_params,
> -                         '-drive',  f"file={self.rootfs},if=none,snapshot=on,format=raw,id=drv0",
> +                         '-drive',  drive,
>                           '-device', 'xen-disk,drive=drv0,vdev=xvda',
>                           '-device', 'virtio-net-pci,netdev=unet',
>                           '-netdev', 'user,id=unet,hostfwd=:127.0.0.1:0-:22')
> @@ -90,11 +99,11 @@ def test_kvm_xen_guest(self):
>          :avocado: tags=kvm_xen_guest
>          """
>  
> -        self.common_vm_setup()
> +        self.common_vm_setup(True)
>  
>          self.kernel_params = (self.KERNEL_DEFAULT +
>                                ' xen_emul_unplug=ide-disks')
> -        self.run_and_check()
> +        self.run_and_check(True)
>          self.ssh_command('grep xen-pirq.*msi /proc/interrupts')
>  
>      def test_kvm_xen_guest_nomsi(self):
> @@ -102,11 +111,11 @@ def test_kvm_xen_guest_nomsi(self):
>          :avocado: tags=kvm_xen_guest_nomsi
>          """
>  
> -        self.common_vm_setup()
> +        self.common_vm_setup(True)
>  
>          self.kernel_params = (self.KERNEL_DEFAULT +
>                                ' xen_emul_unplug=ide-disks pci=nomsi')
> -        self.run_and_check()
> +        self.run_and_check(True)
>          self.ssh_command('grep xen-pirq.* /proc/interrupts')
>  
>      def test_kvm_xen_guest_noapic_nomsi(self):
> @@ -114,11 +123,11 @@ def test_kvm_xen_guest_noapic_nomsi(self):
>          :avocado: tags=kvm_xen_guest_noapic_nomsi
>          """
>  
> -        self.common_vm_setup()
> +        self.common_vm_setup(True)
>  
>          self.kernel_params = (self.KERNEL_DEFAULT +
>                                ' xen_emul_unplug=ide-disks noapic pci=nomsi')
> -        self.run_and_check()
> +        self.run_and_check(True)
>          self.ssh_command('grep xen-pirq /proc/interrupts')
>  
>      def test_kvm_xen_guest_vapic(self):
> -- 
> 2.45.2
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


