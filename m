Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A270BCA1016
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 14:44:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvd5M-00079L-1V; Mon, 08 Sep 2025 10:43:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uvd5H-00078i-SF
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 10:43:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uvd51-00043G-U2
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 10:43:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757342566;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=azTKdModMr7sW1ZecTCOmAgxA8yqAQu7rqBbvjtaGds=;
 b=ZxtYNxlPJh1t7vEVWrdAUIF1XMtSXGVVC14t7kKSuqxHxTmIheQpDy+7dkiXJY8k79lLOy
 npD7ANXYyVdalzv6qcpJWR8PXG6kmUdP3Q9uwu2UCV8GB+jMWTgyi9ctIigXfihROHfcwF
 pfLs7koJl4qGEFTIXnmdWNGw+M6TmAs=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-264-u1gdpSjyMqmF6JNI3S99TA-1; Mon,
 08 Sep 2025 10:42:43 -0400
X-MC-Unique: u1gdpSjyMqmF6JNI3S99TA-1
X-Mimecast-MFC-AGG-ID: u1gdpSjyMqmF6JNI3S99TA_1757342562
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 69C2519560B8; Mon,  8 Sep 2025 14:42:42 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.93])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E1ACB1800452; Mon,  8 Sep 2025 14:42:38 +0000 (UTC)
Date: Mon, 8 Sep 2025 15:42:35 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: John Levon <john.levon@nutanix.com>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Thomas Huth <thuth@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
Subject: Re: [PATCH v4 3/3] tests/functional: add a vfio-user smoke test
Message-ID: <aL7rW6Tq9d-z8sGL@redhat.com>
References: <20250903201931.168317-1-john.levon@nutanix.com>
 <20250903201931.168317-4-john.levon@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250903201931.168317-4-john.levon@nutanix.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Wed, Sep 03, 2025 at 10:19:31PM +0200, John Levon wrote:
> From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> 
> Add a basic test of the vfio-user PCI client implementation.
> 
> Co-authored-by: John Levon <john.levon@nutanix.com>
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> Signed-off-by: John Levon <john.levon@nutanix.com>
> ---
>  MAINTAINERS                                   |   1 +
>  tests/functional/x86_64/meson.build           |   1 +
>  .../x86_64/test_vfio_user_client.py           | 207 ++++++++++++++++++
>  3 files changed, 209 insertions(+)
>  create mode 100755 tests/functional/x86_64/test_vfio_user_client.py
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1ae28e8804..9987ac8a4d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4305,6 +4305,7 @@ F: docs/system/devices/vfio-user.rst
>  F: hw/vfio-user/*
>  F: include/hw/vfio-user/*
>  F: subprojects/libvfio-user
> +F: tests/functional/x86_64/test_vfio_user_client.py
>  
>  EBPF:
>  M: Jason Wang <jasowang@redhat.com>
> diff --git a/tests/functional/x86_64/meson.build b/tests/functional/x86_64/meson.build
> index d0b4667bb8..eed1936976 100644
> --- a/tests/functional/x86_64/meson.build
> +++ b/tests/functional/x86_64/meson.build
> @@ -31,6 +31,7 @@ tests_x86_64_system_thorough = [
>    'replay',
>    'reverse_debug',
>    'tuxrun',
> +  'vfio_user_client',
>    'virtio_balloon',
>    'virtio_gpu',
>  ]
> diff --git a/tests/functional/x86_64/test_vfio_user_client.py b/tests/functional/x86_64/test_vfio_user_client.py
> new file mode 100755
> index 0000000000..a9cb2f4621
> --- /dev/null
> +++ b/tests/functional/x86_64/test_vfio_user_client.py
> @@ -0,0 +1,207 @@


> +    def prepare_images(self):
> +        """Set up the images for the VMs."""
> +        self.kernel_path = self.ASSET_KERNEL.fetch()
> +        rootfs_path = self.ASSET_ROOTFS.fetch()
> +
> +        self.server_rootfs_path = self.scratch_file('server.ext2')
> +        shutil.copy(rootfs_path, self.server_rootfs_path)
> +        os.chmod(self.server_rootfs_path, 0o600)
> +        self.client_rootfs_path = self.scratch_file('client.ext2')
> +        shutil.copy(rootfs_path, self.client_rootfs_path)
> +        os.chmod(self.client_rootfs_path, 0o600)

So copying the read-only asset to a writable file in the scratchdir....

> +
> +    def configure_server_vm_args(self, server_vm, sock_path):
> +        """
> +        Configuration for the server VM. Set up virtio-serial device backed by
> +        the given socket path.
> +        """
> +        server_vm.add_args('-kernel', self.kernel_path)
> +        server_vm.add_args('-append', 'console=ttyS0 root=/dev/sda')
> +        server_vm.add_args('-drive',
> +            f"file={self.server_rootfs_path},if=ide,format=raw,id=drv0")
> +        server_vm.add_args('-snapshot')

..but here you're using -snapshot, so surely the copying of the asset
into the scratch dir is not required ?

> +        server_vm.add_args('-chardev',
> +            f"socket,id=sock0,path={sock_path},telnet=off,server=on,wait=off")
> +        server_vm.add_args('-device', 'virtio-serial')
> +        server_vm.add_args('-device',
> +            'virtserialport,chardev=sock0,name=org.fedoraproject.port.0')
> +
> +    def configure_client_vm_args(self, client_vm, sock_path):
> +        """
> +        Configuration for the client VM. Point the vfio-user-pci device to the
> +        socket path configured above.
> +        """
> +
> +        client_vm.add_args('-kernel', self.kernel_path)
> +        client_vm.add_args('-append', 'console=ttyS0 root=/dev/sda')
> +        client_vm.add_args('-drive',
> +            f'file={self.client_rootfs_path},if=ide,format=raw,id=drv0')

...but  no using of -snapshot here, so copying the asset would be
required?

Can we just use -snapshot in both cases & avoid the copying ?

> +        client_vm.add_args('-device',
> +            '{"driver":"vfio-user-pci",' +
> +            '"socket":{"path": "%s", "type": "unix"}}' % sock_path)
> +

> +    def setup_vfio_user_pci_server(self, server_vm):
> +        """
> +        Start the libvfio-user server within the server VM, and arrange
> +        for data to shuttle between its socket and the virtio serial port.
> +        """
> +        wait_for_console_pattern(self, 'login:', None, server_vm)
> +        exec_command_and_wait_for_pattern(self, 'root', '#', None, server_vm)
> +
> +        exec_command_and_wait_for_pattern(self,
> +            'gpio-pci-idio-16 -v /tmp/vfio-user.sock >/var/tmp/gpio.out 2>&1 &',
> +            '#', None, server_vm)
> +        # wait for libvfio-user to initialize properly
> +        exec_command_and_wait_for_pattern(self, 'sleep 5', '#', None, server_vm)
> +        exec_command_and_wait_for_pattern(self,
> +            'socat UNIX-CONNECT:/tmp/vfio-user.sock /dev/vport0p1,ignoreeof ' +
> +            ' &', '#', None, server_vm)

Hardcoded socket paths in /tmp ...

> +
> +    def test_vfio_user_pci(self):
> +        self.prepare_images()
> +        self.set_machine('pc')
> +        self.require_device('virtio-serial')
> +        self.require_device('vfio-user-pci')
> +
> +        sock_dir = self.socket_dir()
> +        socket_path = sock_dir.name + '/vfio-user.sock'
> +        socket_path = '/tmp/vfio-user.sock'

This isn't honouring the temporary dir for the socket files.
This temp dir needs to be passed into setup_vfio_user_pci_server

> +
> +        server_vm = self.get_vm(name='server')
> +        server_vm.set_console()
> +        self.configure_server_vm_args(server_vm, socket_path)
> +
> +        server_vm.launch()
> +
> +        self.log.debug('starting libvfio-user server')
> +
> +        self.setup_vfio_user_pci_server(server_vm)
> +
> +        client_vm = self.get_vm(name="client")
> +        client_vm.set_console()
> +        self.configure_client_vm_args(client_vm, socket_path)
> +
> +        try:
> +            client_vm.launch()
> +        except:
> +            self.log.error('client VM failed to start, dumping server logs')
> +            exec_command_and_wait_for_pattern(self, 'cat /var/tmp/gpio.out',
> +                '#', None, server_vm)
> +            raise
> +
> +        self.log.debug('waiting for client VM boot')
> +
> +        wait_for_console_pattern(self, 'login:', None, client_vm)
> +        exec_command_and_wait_for_pattern(self, 'root', '#', None, client_vm)
> +
> +        #
> +        # Here, we'd like to actually interact with the gpio device a little
> +        # more as described at:
> +        #
> +        # https://github.com/nutanix/libvfio-user/blob/master/docs/qemu.md
> +        #
> +        # Unfortunately, the buildroot Linux kernel has some undiagnosed issue
> +        # so we don't get /sys/class/gpio. Nonetheless just the basic
> +        # initialization and setup is enough for basic testing of vfio-user.
> +        #
> +
> +        self.log.debug('collecting libvfio-user server output')
> +
> +        out = exec_command_and_wait_for_pattern(self,
> +            'cat /var/tmp/gpio.out',
> +            'gpio: region2: wrote 0 to (0x1:1)',
> +            None, server_vm)
> +
> +        pattern = re.compile(r'^gpio:')

Use of 're' is overkill here...

> +
> +        gpio_server_out = [s for s in out.decode().splitlines()
> +                                   if pattern.search(s)]

......  as this can just use s.startswith("gpio:")

> +
> +        for line in EXPECTED_SERVER_LINES:
> +            if line not in gpio_server_out:
> +                self.log.error(f'Missing server debug line: {line}')
> +                self.fail(False)
> +
> +
> +if __name__ == '__main__':
> +    QemuSystemTest.main()
> -- 
> 2.43.0
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


