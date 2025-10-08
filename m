Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11F6DCCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 21:06:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6bL1-0000DJ-8u; Wed, 08 Oct 2025 17:04:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1v6bKy-00009K-Og
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 17:04:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1v6bKs-0007OB-CH
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 17:04:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759957466;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Fy/xss5dvCTG3be1sSRpl75/U/9wrBpMJ0gFv9Ak5dc=;
 b=XGfrJiy/4/EtRZQRjJ4mt1q9MmkKpPm8Uu6RewXswQ0JEQy/GFsaoVE5tAbapzE+mvwRjW
 OTKM9Yb5ckjIkRc9pk92V57CxvErRU1ZFd0CvzZ8nN1RYgueZQ1Ij7R8uuteRqm67Ficp/
 Pbviii1lwZQ+XpDnR3t/gancTjIEAlE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-462-lj6jXe08OLWYJME1DeuRYA-1; Wed,
 08 Oct 2025 17:04:23 -0400
X-MC-Unique: lj6jXe08OLWYJME1DeuRYA-1
X-Mimecast-MFC-AGG-ID: lj6jXe08OLWYJME1DeuRYA_1759957463
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E90F31800451; Wed,  8 Oct 2025 21:04:22 +0000 (UTC)
Received: from redhat.com (unknown [10.2.17.180])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DC65219560BA; Wed,  8 Oct 2025 21:04:20 +0000 (UTC)
Date: Wed, 8 Oct 2025 16:04:17 -0500
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v2 5/5] tests/functional: add vdpa-blk blockdev-mirror test
Message-ID: <uyxtjuxabfbzugi6pju5csj5ssezt6lroff2exsrs35tj3sbxf@wbyvfg3ayirp>
References: <20251007183447.93120-1-stefanha@redhat.com>
 <20251007183447.93120-6-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007183447.93120-6-stefanha@redhat.com>
User-Agent: NeoMutt/20250905
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Oct 07, 2025 at 02:34:47PM -0400, Stefan Hajnoczi wrote:
> Add a test case that reproduces
> https://issues.redhat.com/browse/RHEL-88175.
> 
> When the mirror blockjob completes, it replaces the original vdpa-blk
> blockdev node with a new vdpa-blk blockdev. This will only work if the
> BlockRAMRegistrar populates memory mappings (see the previous commit).
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  tests/functional/x86_64/meson.build           |   1 +
>  .../functional/x86_64/test_vdpa_blk_mirror.py | 118 ++++++++++++++++++
>  2 files changed, 119 insertions(+)
>  create mode 100755 tests/functional/x86_64/test_vdpa_blk_mirror.py

I tried running this test to see how it fared on my system.  With the
entire series applied (and after I set up passwordless sudo, to run
instead of skip), the test passed.  I then reverted the rest of the
series, and the test hung, instead of timing out or printing an error
message about a specific failure.  Then I tried reapplying the rest of
the series, but now the test hangs because whatever state the system
was left in after the earlier failed test is preventing the re-run
from starting; and it appears to be uninterruptible (SIGINT is not
ending the hung test, and even ctrl-z is not letting me move the test
into a background process; I had to resort to kill -9 from another
terminal).

I'm less familiar with functional tests in general, but it might be
nice to figure out a way to quickly report failure when testing
without the rest of the series, rather than leaving the system in a
wedged state.

Of course, since CI will never be running the test without the rest of
the series in place, that is not a show-stopper for accepting this
series as-is.  I'm not even sure if adding a timeout to the dd command
[1] would help in tearing down the vdpa_sim_blk device on a test
failure.

And it may not even be something that QEMU can do anything about - the
whole point of the rest of the series is so that vdpa still has memory
mappings after migration so it can complete I/O; without the rest of
the series, the test is correctly proving that the migration lost the
mappings and thus can't complete I/O, even if I have no idea how to
force the kernel to relinquish the device when we know that the I/O
won't ever happen.

So, I'm fine if you add:

Tested-by: Eric Blake <eblake@redhat.com>

even though I'm not comfortable with a Reviewed-by at this time.

> diff --git a/tests/functional/x86_64/test_vdpa_blk_mirror.py b/tests/functional/x86_64/test_vdpa_blk_mirror.py

> +class VdpaBlk(LinuxKernelTest):
> +
> +    KERNEL_COMMAND_LINE = 'printk.time=0 console=ttyS0 rd.rescue'
> +    ASSET_KERNEL = Asset(
> +        ('https://archives.fedoraproject.org/pub/archive/fedora/linux/releases'
> +         '/31/Server/x86_64/os/images/pxeboot/vmlinuz'),
> +        'd4738d03dbbe083ca610d0821d0a8f1488bebbdccef54ce33e3adb35fda00129')
> +    ASSET_INITRD = Asset(
> +        ('https://archives.fedoraproject.org/pub/archive/fedora/linux/releases'
> +         '/31/Server/x86_64/os/images/pxeboot/initrd.img'),
> +        '277cd6c7adf77c7e63d73bbb2cded8ef9e2d3a2f100000e92ff1f8396513cd8b')
> +    VDPA_DEV_1 = f'vdpa-{os.getpid()}-1'
> +    VDPA_DEV_2 = f'vdpa-{os.getpid()}-2'
> +
> +    def setUp(self) -> None:
> +        def create_vdpa_dev(name):
> +            '''
> +            Create a new vdpasim_blk device and return its vhost_vdpa device
> +            path.
> +            '''
> +            run(f'sudo -n vdpa dev add mgmtdev vdpasim_blk name {name}')
> +            sysfs_vhost_vdpa_dev_dir = \
> +                glob.glob(f'/sys/bus/vdpa/devices/{name}/vhost-vdpa-*')[0]
> +            vhost_dev_basename = os.path.basename(sysfs_vhost_vdpa_dev_dir)
> +            vhost_dev_path = f'/dev/{vhost_dev_basename}'
> +            run(f'sudo -n chown {os.getuid()}:{os.getgid()} {vhost_dev_path}')
> +            return vhost_dev_path
> +
> +        try:
> +            run('sudo -n modprobe vhost_vdpa')
> +            run('sudo -n modprobe vdpa_sim_blk')

Once I did kill -9 on the hung test, manually trying this line fails
with:

$ sudo -n modprobe vdpa_sim_blk
modprobe: ERROR: could not insert 'vdpa_sim_blk': Device or resource busy

as my evidence that something really did get wedged in trying to clean
up after the hang.  Even

$ sudo -n vdpa dev show

is hanging with no output, no response to ctrl-c or -z, and requires
kill -9.  Running it under strace ends at:

...
socket(AF_NETLINK, SOCK_RAW, NETLINK_GENERIC) = 3
setsockopt(3, SOL_NETLINK, NETLINK_CAP_ACK, [1], 4) = 0
setsockopt(3, SOL_NETLINK, NETLINK_EXT_ACK, [1], 4) = 0
bind(3, {sa_family=AF_NETLINK, nl_pid=0, nl_groups=00000000}, 12) = 0
getsockname(3, {sa_family=AF_NETLINK, nl_pid=3694229, nl_groups=00000000}, [12]) = 0


> +
> +            self.vhost_dev_1_path = create_vdpa_dev(self.VDPA_DEV_1)
> +            self.vhost_dev_2_path = create_vdpa_dev(self.VDPA_DEV_2)
> +        except subprocess.CalledProcessError:
> +            self.skipTest('Failed to set up vdpa_blk device')
> +
> +        super().setUp()
> +
> +    def tearDown(self) -> None:
> +        super().tearDown()
> +
> +        try:
> +            run(f'sudo -n vdpa dev del {self.VDPA_DEV_2}')
> +            run(f'sudo -n vdpa dev del {self.VDPA_DEV_1}')
> +            run('sudo -n modprobe --remove vdpa_sim_blk')
> +            run('sudo -n modprobe --remove vhost_vdpa')

so these cleanups are not happening because of whatever else already
wedged.

> +        except subprocess.CalledProcessError:
> +            pass # ignore failures
> +
> +    def test_mirror(self) -> None:
> +        '''
> +        Check that I/O works after a mirror blockjob pivots. See
> +        https://issues.redhat.com/browse/RHEL-88175.
> +        '''
> +        kernel_path = self.ASSET_KERNEL.fetch()
> +        initrd_path = self.ASSET_INITRD.fetch()
> +
> +        self.vm.add_args('-m', '1G')
> +        self.vm.add_args('-object', 'memory-backend-memfd,id=mem,size=1G')
> +        self.vm.add_args('-machine', 'pc,accel=kvm:tcg,memory-backend=mem')
> +        self.vm.add_args('-append', self.KERNEL_COMMAND_LINE)
> +        self.vm.add_args('-blockdev',
> +            'virtio-blk-vhost-vdpa,node-name=vdpa-blk-0,' +
> +            f'path={self.vhost_dev_1_path},cache.direct=on')
> +        self.vm.add_args('-device', 'virtio-blk-pci,drive=vdpa-blk-0')
> +
> +        self.launch_kernel(kernel_path, initrd_path,
> +                           wait_for='# ')
> +
> +        self.vm.cmd('blockdev-add',
> +                    driver='virtio-blk-vhost-vdpa',
> +                    node_name='vdpa-blk-1',
> +                    path=self.vhost_dev_2_path,
> +                    cache={'direct': True})
> +        self.vm.cmd('blockdev-mirror',
> +                    device='vdpa-blk-0',
> +                    job_id='mirror0',
> +                    target='vdpa-blk-1',
> +                    sync='full',
> +                    target_is_zero=True)
> +        self.vm.event_wait('BLOCK_JOB_READY')
> +        self.vm.cmd('block-job-complete',
> +                    device='mirror0')
> +
> +        exec_command_and_wait_for_pattern(self,
> +            'dd if=/dev/vda of=/dev/null iflag=direct bs=4k count=1',

[1] This might be the spot where adding a timeout command would help
the guest relinquish control of the block device, but that is still
not obvious to me whether it would also be enough for the test to fail
cleanly and allow a clean restart.

> +            '4096 bytes (4.1 kB, 4.0 KiB) copied')
> +
> +
> +if __name__ == '__main__':
> +    LinuxKernelTest.main()
> -- 
> 2.51.0
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


