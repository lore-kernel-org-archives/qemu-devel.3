Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C29EC19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 08:03:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqSfL-0006tT-7z; Fri, 07 Mar 2025 03:02:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tqSes-0006nf-If
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 03:02:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tqSep-0007bC-DH
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 03:02:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741334529;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4aQKxSiRKtabosOokJ69zqJs9IjcnxpM/zqFwhVkY/0=;
 b=O9afrjRsy8Br6rPoYLWgjdCd4njcwUE/oJRRju8e1djlt6XRzJSn01BpBQ2DKWuQmi553e
 269MlSJfmS/OjVTS1uBPgQLwnpJIr5kWJSOBBOKEKFOQlrxALTCgyWmUPr25GF2KUEMV2o
 DdmGYl4G139lMGPo3RSop3ARKmeOrzw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-445-moLuBlouMgW8NX3QnxBRvQ-1; Fri,
 07 Mar 2025 03:02:06 -0500
X-MC-Unique: moLuBlouMgW8NX3QnxBRvQ-1
X-Mimecast-MFC-AGG-ID: moLuBlouMgW8NX3QnxBRvQ_1741334525
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E6CE919560B2; Fri,  7 Mar 2025 08:02:04 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.49])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 037A018009BC; Fri,  7 Mar 2025 08:02:02 +0000 (UTC)
Date: Fri, 7 Mar 2025 08:02:00 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] tests/functional: fix race in virtio balloon test
Message-ID: <Z8qn4WB0EXdYOJE-@redhat.com>
References: <20250304183340.3749797-1-berrange@redhat.com>
 <5b5bcdd3-f102-4f32-967a-a352cd1803ed@linaro.org>
 <d06be182-b6f2-4031-91af-50475fae554c@redhat.com>
 <45c99267-0b91-469f-82d8-5261bbb8ca90@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <45c99267-0b91-469f-82d8-5261bbb8ca90@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Mar 06, 2025 at 08:23:15PM +0100, Thomas Huth wrote:
> On 06/03/2025 18.42, Thomas Huth wrote:
> > On 05/03/2025 13.25, Philippe Mathieu-Daudé wrote:
> > > Hi Daniel,
> > > 
> > > On 4/3/25 19:33, Daniel P. Berrangé wrote:
> > > > There are two race conditions in the recently added virtio balloon
> > > > test
> > > > 
> > > >   * The /dev/vda device node is not ready
> > > >   * The virtio-balloon driver has not issued the first stats refresh
> > > > 
> > > > To fix the former, monitor dmesg for a line about 'vda'.
> > > > 
> > > > To fix the latter, retry the stats query until seeing fresh data.
> > > > 
> > > > Adding 'quiet' to the kernel command line reduces serial output
> > > > which otherwise slows boot, making it less likely to hit the former
> > > > race too.
> > > > 
> > > > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > > > ---
> > > >   tests/functional/test_virtio_balloon.py | 24 +++++++++++++++++++-----
> > > >   1 file changed, 19 insertions(+), 5 deletions(-)
> > > > 
> > > > diff --git a/tests/functional/test_virtio_balloon.py
> > > > b/tests/functional/ test_virtio_balloon.py
> > > > index 67b48e1b4e..308d197eb3 100755
> > > > --- a/tests/functional/test_virtio_balloon.py
> > > > +++ b/tests/functional/test_virtio_balloon.py
> > > > @@ -32,7 +32,7 @@ class VirtioBalloonx86(QemuSystemTest):
> > > > 'e3c1b309d9203604922d6e255c2c5d098a309c2d46215d8fc026954f3c5c27a0')
> > > >       DEFAULT_KERNEL_PARAMS = ('root=/dev/vda1 console=ttyS0 net.ifnames=0 '
> > > > -                             'rd.rescue')
> > > > +                             'rd.rescue quiet')
> > > >       def wait_for_console_pattern(self, success_message, vm=None):
> > > >           wait_for_console_pattern(
> > > > @@ -47,6 +47,9 @@ def mount_root(self):
> > > >           prompt = '# '
> > > >           self.wait_for_console_pattern(prompt)
> > > > +        # Synchronize on virtio-block driver creating the root device
> > > > +        exec_command_and_wait_for_pattern(self, "while ! (dmesg
> > > > -c | grep vda:) ; do sleep 1 ; done", "vda1")
> > > > +
> > > >           exec_command_and_wait_for_pattern(self, 'mount
> > > > /dev/vda1 / sysroot',
> > > >                                             prompt)
> > > >           exec_command_and_wait_for_pattern(self, 'chroot /sysroot',
> > > > @@ -65,10 +68,21 @@ def assert_initial_stats(self):
> > > >               assert val == UNSET_STATS_VALUE
> > > >       def assert_running_stats(self, then):
> > > > -        ret = self.vm.qmp('qom-get',
> > > > -                          {'path': '/machine/peripheral/balloon',
> > > > -                           'property': 'guest-stats'})['return']
> > > > -        when = ret.get('last-update')
> > > > +        # We told the QEMU to refresh stats every 100ms, but
> > > > +        # there can be a delay between virtio-ballon driver
> > > > +        # being modprobed and seeing the first stats refresh
> > > > +        # Retry a few times for robustness under heavy load
> > > > +        retries = 10
> > > > +        when = 0
> > > > +        while when == 0 and retries:
> > > > +            ret = self.vm.qmp('qom-get',
> > > > +                              {'path': '/machine/peripheral/balloon',
> > > > +                               'property': 'guest-stats'})['return']
> > > > +            when = ret.get('last-update')
> > > > +            if when == 0:
> > > > +                retries = retries - 1
> > > > +                time.sleep(0.5)
> > > > +
> > > >           now = time.time()
> > > >           assert when > then and when < now
> > > 
> > > Unfortunately I'm still getting a timeout:
> > > https://gitlab.com/philmd/qemu/-/jobs/9318095233
> > > 
> > > 2025-03-05 12:09:55,360 - DEBUG: Console interaction:
> > > success_msg='Entering emergency mode.' failure_msg='Kernel panic -
> > > not syncing' send_string='None'
> > > 2025-03-05 12:09:55,360 - DEBUG: Opening console socket
> > > 2025-03-05 12:10:32,722 - DEBUG: Console interaction: success_msg='#
> > > ' failure_msg='Kernel panic - not syncing' send_string='None'
> > > 2025-03-05 12:10:32,823 - DEBUG: Console interaction:
> > > success_msg='vda1' failure_msg='None' send_string='while ! (dmesg -c
> > > | grep vda:) ; do sleep 1 ; done
> > > 
> > > 2025-03-05 12:10:30,534: Warning: /dev/vda1 does not exist
> > > 2025-03-05 12:10:30,535:
> > > 2025-03-05 12:10:30,598: Generating "/run/initramfs/rdsosreport.txt"
> > > 2025-03-05 12:10:32,720:
> > > 2025-03-05 12:10:32,721:
> > > 2025-03-05 12:10:32,722: Entering emergency mode.
> > > 2025-03-05 12:10:32,724: Exit the shell to continue.
> > > 2025-03-05 12:10:32,726: Type "journalctl" to view system logs.
> > > 2025-03-05 12:10:32,727: You might want to save "/run/initramfs/
> > > rdsosreport.txt" to a USB stick or /boot
> > > 2025-03-05 12:10:32,728: after mounting them and attach it to a bug report.
> > > 2025-03-05 12:10:32,729:
> > > 2025-03-05 12:10:32,731:
> > > 2025-03-05 12:10:32,823: :/#
> > 
> > Same for me, it always seems to hang when being run with the gitlab
> > shared runners:
> > 
> >   https://gitlab.com/thuth/qemu/-/jobs/9333926038#L612
> >   https://gitlab.com/thuth/qemu/-/jobs/9333926046#L625
> > 
> > ... no clue what's still going wrong, though ...
> 
> ... but I just noticed that all other functional tests that use the same
> assets are using:
> 
>         self.require_accelerator('kvm')
>         self.vm.add_args('-accel', 'kvm')

Hmm, yes, and my testing locally will be with kvm too.

> so they are skipped on the gitlab shared runners (but still executed in the
> custom runners of the qemu-project), while your test also is enabled for TCG
> and thus runs in the shared runners, too.
> So unless you've got a clue what's going wrong here (I fail to see the
> reason for the problem unfortunately), I'd suggest that we mark the
> virtio_balloon test with require_accelerator('kvm'), too, to get the CI
> working with the shared runners again. WDYT?

Lets do that for now

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


