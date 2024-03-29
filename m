Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E03C4C6FD1F
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 13:04:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqBt6-0006Ep-9z; Fri, 29 Mar 2024 09:03:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhuyangyang14@huawei.com>)
 id 1rqBt4-0006EE-ME; Fri, 29 Mar 2024 09:03:14 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhuyangyang14@huawei.com>)
 id 1rqBt1-0004ad-VB; Fri, 29 Mar 2024 09:03:14 -0400
Received: from mail.maildlp.com (unknown [172.19.163.44])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4V5gVc07Q3z1R91F;
 Fri, 29 Mar 2024 21:00:08 +0800 (CST)
Received: from dggpeml500011.china.huawei.com (unknown [7.185.36.84])
 by mail.maildlp.com (Postfix) with ESMTPS id B9B14140120;
 Fri, 29 Mar 2024 21:02:49 +0800 (CST)
Received: from huawei.com (10.91.158.201) by dggpeml500011.china.huawei.com
 (7.185.36.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 29 Mar
 2024 21:02:49 +0800
To: <eblake@redhat.com>
CC: <chenxiaoyu48@huawei.com>, <fam@euphon.net>, <luolongmin@huawei.com>,
 <qemu-block@nongnu.org>, <qemu-devel@nongnu.org>, <qemu-stable@nongnu.org>,
 <stefanha@redhat.com>, <suxiaodong1@huawei.com>, <wangyan122@huawei.com>,
 <yebiaoxiang@huawei.com>, <zhuyangyang14@huawei.com>
Subject: Re: [PATCH v1] coroutine: avoid inserting duplicate coroutine to
 co_queue_wakeup
Date: Fri, 29 Mar 2024 21:09:45 +0800
Message-ID: <20240329130946.4169083-1-zhuyangyang14@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <dv63ec4btdz32schwrwjebce4m7xbu5tt6fncebi5hzxnmctdy@xflzv6tolvrm>
References: <dv63ec4btdz32schwrwjebce4m7xbu5tt6fncebi5hzxnmctdy@xflzv6tolvrm>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.91.158.201]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500011.china.huawei.com (7.185.36.84)
Received-SPF: pass client-ip=45.249.212.35;
 envelope-from=zhuyangyang14@huawei.com; helo=szxga07-in.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Zhu Yangyang <zhuyangyang14@huawei.com>
From:  Zhu Yangyang via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 28 Mar 2024 07:40:14 -0500, Eric Blake wrote:
> On Mon, Mar 25, 2024 at 05:18:50PM +0800, zhuyangyang via wrote:
> > If g_main_loop_run()/aio_poll() is called in the coroutine context,
> > the pending coroutine may be woken up repeatedly, and the co_queue_wakeup
> > may be disordered.
> > 
> > When the poll() syscall exited in g_main_loop_run()/aio_poll(), it means
> > some listened events is completed. Therefore, the completion callback
> > function is dispatched.
> > 
> > If this callback function needs to invoke aio_co_enter(), it will only
> > wake up the coroutine (because we are already in coroutine context),
> > which may cause that the data on this listening event_fd/socket_fd
> > is not read/cleared. When the next poll () exits, it will be woken up again
> > and inserted into the wakeup queue again.
> > 
> > For example, if TLS is enabled in NBD, the server will call g_main_loop_run()
> > in the coroutine, and repeatedly wake up the io_read event on a socket.
> > The call stack is as follows:
> > 
> > aio_co_enter()
> > aio_co_wake()
> > qio_channel_restart_read()
> > aio_dispatch_handler()
> > aio_dispatch_handlers()
> > aio_dispatch()
> > aio_ctx_dispatch()
> > g_main_context_dispatch()
> > g_main_loop_run()
> > nbd_negotiate_handle_starttls()
> > nbd_negotiate_options()
> > nbd_negotiate()
> > nbd_co_client_start()
> > coroutine_trampoline()
> 
> zhuyangyang, do you have a reliable reproduction setup for how you
> were able to trigger this?  Obviously, it only happens when TLS is
> enabled (we aren't creating a g_main_loop_run for any other NBD
> command), and only when the server is first starting to serve a
> client; is this a case where you were hammering a long-running qemu
> process running an NBD server with multiple clients trying to
> reconnect to the server all near the same time?

I'm sorry I didn't make the background of the problem clear before,
this problem is not on the NBD command, but on the VM live migration
with qemu TLS.

Next, I'll detail how to reproduce the issue.

1. Make the problem more obvious.

When TLS is enabled during live migration, the migration progress
may be suspended because some I/O are not returned during the mirror job
on target host.

Now we know that the reason is that some coroutines are lost.
The entry function of these lost coroutines are nbd_trip().

Add an assertion on the target host side to make the problem
show up quickly.

$ git diff util/async.c
diff --git a/util/async.c b/util/async.c
index 0467890052..4e3547c3ea 100644
--- a/util/async.c
+++ b/util/async.c
@@ -705,6 +705,7 @@ void aio_co_enter(AioContext *ctx, Coroutine *co)
     if (qemu_in_coroutine()) {
         Coroutine *self = qemu_coroutine_self();
         assert(self != co);
+        assert(!co->co_queue_next.sqe_next);
         QSIMPLEQ_INSERT_TAIL(&self->co_queue_wakeup, co, co_queue_next);
     } else {
         qemu_aio_coroutine_enter(ctx, co);

2. Reproduce the issue

1) start vm on the origin host

Note: Configuring multiple disks for a VM 
(It is recommended to configure more than 6 disks)

These disk tasks(nbd_trip) will be performed simultaneously 
with nbd_negotiate_handle_starttls() on the main thread during migrate.

<domain type='kvm' id='1'>
  <name>centos7.3_64_server</name>
  <memory unit='KiB'>4194304</memory>
  <currentMemory unit='KiB'>4194304</currentMemory>
  <vcpu placement='static'>4</vcpu>
  <resource>
    <partition>/machine</partition>
  </resource>
  <os>
    <type arch='x86_64' machine='pc-i440fx-9.0'>hvm</type>
    <boot dev='hd'/>
  </os>
  <features>
    <acpi/>
    <apic eoi='on'/>
    <pae/>
  </features>
  <cpu mode='host-passthrough' check='none' migratable='on'/>
  <clock offset='utc'>
    <timer name='hpet' present='no'/>
    <timer name='rtc' tickpolicy='catchup' track='guest'/>
    <timer name='pit' tickpolicy='delay'/>
  </clock>
  <on_poweroff>destroy</on_poweroff>
  <on_reboot>restart</on_reboot>
  <on_crash>restart</on_crash>
  <devices>
    <emulator>/usr/bin/qemu-kvm</emulator>
    <disk type='file' device='disk'>
      <driver name='qemu' type='raw' cache='none' io='native'/>
      <source file='/Images/TestImg/centos7.3_64_server' index='6'/>
      <backingStore/>
      <target dev='vda' bus='virtio'/>
      <alias name='virtio-disk0'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x04' function='0x0'/>
    </disk>
    <disk type='file' device='disk'>
      <driver name='qemu' type='raw' cache='none' io='native'/>
      <source file='/Images/TestImg/kvm-disk-001' index='5'/>
      <backingStore/>
      <target dev='vdb' bus='virtio'/>
      <alias name='virtio-disk1'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x03' function='0x0'/>
    </disk>
    <disk type='file' device='disk'>
      <driver name='qemu' type='raw' cache='none' io='native'/>
      <source file='/Images/TestImg/kvm-disk-002' index='4'/>
      <backingStore/>
      <target dev='vdc' bus='virtio'/>
      <alias name='virtio-disk2'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x06' function='0x0'/>
    </disk>
    <disk type='file' device='disk'>
      <driver name='qemu' type='raw' cache='none' io='native'/>
      <source file='/Images/TestImg/kvm-disk-003' index='3'/>
      <backingStore/>
      <target dev='vdd' bus='virtio'/>
      <alias name='virtio-disk3'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x07' function='0x0'/>
    </disk>
    <disk type='file' device='disk'>
      <driver name='qemu' type='raw' cache='none' io='native'/>
      <source file='/Images/TestImg/kvm-disk-004' index='2'/>
      <backingStore/>
      <target dev='vde' bus='virtio'/>
      <alias name='virtio-disk4'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x08' function='0x0'/>
    </disk>
    <disk type='file' device='disk'>
      <driver name='qemu' type='raw' cache='none' io='native'/>
      <source file='/Images/TestImg/kvm-disk-005' index='1'/>
      <backingStore/>
      <target dev='vdf' bus='virtio'/>
      <alias name='virtio-disk5'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x09' function='0x0'/>
    </disk>
    <controller type='pci' index='0' model='pci-root'>
      <alias name='pci.0'/>
    </controller>
  </devices>
</domain>

$ virsh create vm_x86.xml
Domain 'centos7.3_64_server' created from /home/vm_x86.xml

2) migrate the vm to target host
virsh migrate --live --p2p \
   --migrateuri tcp:10.91.xxx.xxx centos7.3_64_server qemu+tcp://10.91.xxx.xxx/system \
   --copy-storage-all \
   --tls

Than, An error is reported on the peer host
qemu-kvm: ../util/async.c:705: aio_co_enter: Assertion `!co->co_queue_next.sqe_next' failed.

> 
> If we can come up with a reliable formula for reproducing the
> corrupted coroutine list, it would make a great iotest addition
> alongside the existing qemu-iotests 233 for ensuring that NBD TLS
> traffic is handled correctly in both server and client.

I'm not sure if this can be used for testing of qemu-nbd

> 
> > 
> > Signed-off-by: zhuyangyang <zhuyangyang14@huawei.com>
> 
> Side note: this appears to be your first qemu contribution (based on
> 'git shortlog --author zhuyangyang').  While I am not in a position to
> presume how you would like your name Anglicized, I will point out that
> the prevailing style is to separate given name from family name (just
> because your username at work has no spaces does not mean that your
> S-o-b has to follow suit).  It is also permissible to list your name
> in native characters alongside or in place of the Anglicized version;
> for example, 'git log --author="Stefano Dong"' shows this technique.

Yes, I will update my name in the next submission, thank you very much for your help

-- 
Best Regards,
Zhu Yangyang


