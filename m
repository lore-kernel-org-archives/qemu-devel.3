Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C04E9CAC58E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 15:51:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwjZl-0006Ap-3f; Thu, 11 Sep 2025 11:51:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uwjZb-000698-Cp
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 11:50:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uwjZX-0004cN-Ao
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 11:50:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757605841;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=xE1OeFL+aJXP22NyvSzR/6/5/v2eFZZ+fMMbGRg7c90=;
 b=Dc8usw7gC8i3UASR7sCEMIgRqpNtVWwxsihyOT/emyt4qOZy2qDBuF48V58X5RhUZIJkyz
 AXYty2SeGgrCVretR9no06lwC58QnAJrddWU+KfXJv5upjb9co8bJWJZquKVsjs0porYR8
 zOS5VEdkfAIeuDs/r+TbpGJzaG5FF3s=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-335-9kcC_jkvPXyie5rHj3f7hQ-1; Thu,
 11 Sep 2025 11:50:38 -0400
X-MC-Unique: 9kcC_jkvPXyie5rHj3f7hQ-1
X-Mimecast-MFC-AGG-ID: 9kcC_jkvPXyie5rHj3f7hQ_1757605837
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2B7B01800286; Thu, 11 Sep 2025 15:50:37 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.221])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 817FB300021A; Thu, 11 Sep 2025 15:50:33 +0000 (UTC)
Date: Thu, 11 Sep 2025 16:50:30 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
Subject: Re: [PATCH v5] tests/functional: add a vfio-user smoke test
Message-ID: <aMLvxvdBLlkXxR9q@redhat.com>
References: <20250911142228.1955529-1-john.levon@nutanix.com>
 <0d71919b-d5f9-47cd-9979-a692f3cf6a8d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0d71919b-d5f9-47cd-9979-a692f3cf6a8d@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Sep 11, 2025 at 05:27:24PM +0200, Thomas Huth wrote:
>  Hi!
> 
> On 11/09/2025 16.22, John Levon wrote:
> > From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> > 
> > Add a basic test of the vfio-user PCI client implementation.
> > 
> > Co-authored-by: John Levon <john.levon@nutanix.com>
> > Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> > Signed-off-by: John Levon <john.levon@nutanix.com>
> > ---
> ...
> > diff --git a/tests/functional/x86_64/test_vfio_user_client.py b/tests/functional/x86_64/test_vfio_user_client.py
> > new file mode 100755
> > index 0000000000..1e4c5bc875
> > --- /dev/null
> > +++ b/tests/functional/x86_64/test_vfio_user_client.py

> > +class VfioUserClient(QemuSystemTest):
> > +
> > +    ASSET_REPO = 'https://github.com/mcayland-ntx/libvfio-user-test'
> 
> Not sure whether that indirection works with the asset pre-caching
> mechanism? Daniel, could you comment on that?

It should be fine - the asset caching loads the class and
at that time python will have done the substitution.

> 
> > +    ASSET_KERNEL = Asset(
> > +        f'{ASSET_REPO}/raw/refs/heads/main/images/bzImage',
> > +        '40292fa6ce95d516e26bccf5974e138d0db65a6de0bc540cabae060fe9dea605'
> > +    )
> > +
> > +    ASSET_ROOTFS = Asset(
> > +        f'{ASSET_REPO}/raw/refs/heads/main/images/rootfs.ext2',
> > +        'e1e3abae8aebb8e6e77f08b1c531caeacf46250c94c815655c6bbea59fc3d1c1'
> > +    )



> > +    def prepare_images(self):
> > +        """Download the images for the VMs."""
> > +        self.kernel_path = self.ASSET_KERNEL.fetch()
> > +        self.rootfs_path = self.ASSET_ROOTFS.fetch()

Just put this inline, it doesn't seem this method now we removed
the extra copying logic

> > +
> > +    def configure_server_vm_args(self, server_vm, sock_path):
> > +        """
> > +        Configuration for the server VM. Set up virtio-serial device backed by
> > +        the given socket path.
> > +        """
> > +        server_vm.add_args('-kernel', self.kernel_path)
> > +        server_vm.add_args('-append', 'console=ttyS0 root=/dev/sda')
> > +        server_vm.add_args('-drive',
> > +            f"file={self.rootfs_path},if=ide,format=raw,id=drv0")
> > +        server_vm.add_args('-snapshot')
> > +        server_vm.add_args('-chardev',
> > +            f"socket,id=sock0,path={sock_path},telnet=off,server=on,wait=off")
> > +        server_vm.add_args('-device', 'virtio-serial')
> > +        server_vm.add_args('-device',
> > +            'virtserialport,chardev=sock0,name=org.fedoraproject.port.0')
> > +
> > +    def configure_client_vm_args(self, client_vm, sock_path):
> > +        """
> > +        Configuration for the client VM. Point the vfio-user-pci device to the
> > +        socket path configured above.
> > +        """
> > +
> > +        client_vm.add_args('-kernel', self.kernel_path)
> > +        client_vm.add_args('-append', 'console=ttyS0 root=/dev/sda')
> > +        client_vm.add_args('-drive',
> > +            f'file={self.rootfs_path},if=ide,format=raw,id=drv0')
> > +        client_vm.add_args('-snapshot')
> > +        client_vm.add_args('-device',
> > +            '{"driver":"vfio-user-pci",' +
> > +            '"socket":{"path": "%s", "type": "unix"}}' % sock_path)
> > +
> > +    def setup_vfio_user_pci_server(self, server_vm):
> > +        """
> > +        Start the libvfio-user server within the server VM, and arrange
> > +        for data to shuttle between its socket and the virtio serial port.
> > +        """
> > +        wait_for_console_pattern(self, 'login:', None, server_vm)
> > +        exec_command_and_wait_for_pattern(self, 'root', '#', None, server_vm)
> > +
> > +        exec_command_and_wait_for_pattern(self,
> > +            'gpio-pci-idio-16 -v /tmp/vfio-user.sock >/var/tmp/gpio.out 2>&1 &',
> > +            '#', None, server_vm)
> > +        # wait for libvfio-user to initialize properly
> > +        exec_command_and_wait_for_pattern(self, 'sleep 5', '#', None, server_vm)
> 
> Could the sleep be avoided? ... it's still a race condition (even if it's
> unlikely when you wait for 5 seconds), and always sleeping 5 seconds slows
> down the test quite a bit ...
> 
> Could you maybe poll something instead, e.g. output of "dmesg" or something
> in the file system? (sorry, I don't have any clue about vfio-user, so I
> don't know any better suggestions)
> 
> > +        exec_command_and_wait_for_pattern(self,
> > +            'socat UNIX-CONNECT:/tmp/vfio-user.sock /dev/vport0p1,ignoreeof ' +
> > +            ' &', '#', None, server_vm)
> > +
> > +    def test_vfio_user_pci(self):
> > +        self.prepare_images()
> 
> Please move the "prepare_images" after the set_machine() and
> require_device() calls. Reason: set_machine() and require_device() could
> skip the test if it's not available in the qemu binary, so in that case you
> don't want to try to fetch the assets first.
> 
> > +        self.set_machine('pc')
> > +        self.require_device('virtio-serial')
> > +        self.require_device('vfio-user-pci')
> > +
> > +        sock_dir = self.socket_dir()
> > +        socket_path = sock_dir.name + '/vfio-user.sock'
> 
> Better use os.path.join() instead of hard-coding slashes.
> 
>  Thanks,
>   Thomas
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


