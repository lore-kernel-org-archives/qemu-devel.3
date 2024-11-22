Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CCBFE65D3F
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 10:18:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEQjk-0005l7-QU; Fri, 22 Nov 2024 05:18:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tEQji-0005kg-CI
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 05:18:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tEQjg-0005Of-F6
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 05:18:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732270669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WKj2XMMLjA5oDyJ4LklTfMo/7bjeC/rtJ1uaGOEXTt8=;
 b=fhE4R3OeDHD7AvOcWKM9JofqWpfTRLVnFdiJNx/caqMi8aqJYfgSfbPGkIF5rNYgj3+4sW
 ongM+TuDRK79h/N6+3hvBkGv3u0zTBlF6RLo3sXyA+l+O5mpFOfHOyiVUKswMzsWeJw1L+
 IHLMMf954bvA+ZgGDEg4T/8i8FmbE74=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-443-T6ZrgW46MZO3ERr_jd9QlA-1; Fri,
 22 Nov 2024 05:17:46 -0500
X-MC-Unique: T6ZrgW46MZO3ERr_jd9QlA-1
X-Mimecast-MFC-AGG-ID: T6ZrgW46MZO3ERr_jd9QlA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A37E51955F07; Fri, 22 Nov 2024 10:17:44 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.157])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8EC931956086; Fri, 22 Nov 2024 10:17:42 +0000 (UTC)
Date: Fri, 22 Nov 2024 11:17:39 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com,
 stefanha@redhat.com, pkrempa@redhat.com
Subject: Re: [PULL v3 0/8] Block layer patches
Message-ID: <Z0BaQ0ahUn4ORhPS@redhat.com>
References: <20241120105106.50669-1-kwolf@redhat.com>
 <CAFEAcA9M_-4=UdOTwV251qOxuELAxXtJW8QaZWTs4bUq7dJwxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9M_-4=UdOTwV251qOxuELAxXtJW8QaZWTs4bUq7dJwxw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Am 20.11.2024 um 14:19 hat Peter Maydell geschrieben:
> On Wed, 20 Nov 2024 at 10:52, Kevin Wolf <kwolf@redhat.com> wrote:
> >
> > The following changes since commit e6459afb1ff4d86b361b14f4a2fc43f0d2b4d679:
> >
> >   Merge tag 'pull-target-arm-20241119' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2024-11-19 14:23:34 +0000)
> >
> > are available in the Git repository at:
> >
> >   https://repo.or.cz/qemu/kevin.git tags/for-upstream
> >
> > for you to fetch changes up to 83987bf722b6b692bc745b47901be76a1c97140b:
> >
> >   vl: use qmp_device_add() in qemu_create_cli_devices() (2024-11-20 11:47:49 +0100)
> >
> > ----------------------------------------------------------------
> > Block layer patches
> >
> > - Fix qmp_device_add() to not throw non-scalar options away (fixes
> >   iothread-vq-mapping being silently ignored in device_add)
> > - Fix qdev property crash with integer PCI addresses and JSON -device
> > - iotests: Fix mypy failure
> > - parallels: Avoid potential integer overflow
> > - Fix crash in migration_is_running()
> 
> Hi; the hotplug_blk.py:HotPlug.test avocado seems to be failing:
> 
> https://gitlab.com/qemu-project/qemu/-/jobs/8423313170
> https://gitlab.com/qemu-project/qemu/-/jobs/8423313162
> 
> [stdlog] 2024-11-20 12:49:35,669 avocado.test test L0740 ERROR| FAIL
> 1-tests/avocado/hotplug_blk.py:HotPlug.test -> AssertionError: 1 != 0
> : Guest command failed: test -e /sys/block/vda
> 
> https://qemu-project.gitlab.io/-/qemu/-/jobs/8423313162/artifacts/build/tests/results/latest/test-results/09-tests_avocado_hotplug_blk.py_HotPlug.test/debug.log
> 
> Looks like the test called device_add, it succeeded, but
> it didn't see the /sys/block/vda node appear in the guest.
> 
> (The test logic of "try the command, if it fails sleep for 1
> second then try a second time and if that fails call it a
> test error" doesn't seem super robust in the face of slow
> CI runners, but OTOH it failed the same way on both jobs,
> so I don't think that is the culprit here.)

This looks like a bug in the test case that was previously cancelled out
by a QEMU bug. :-/

{
  "execute": "device_add",
  "arguments": {
    "driver": "virtio-blk-pci",
    "drive": "disk",
    "id": "virtio-disk0",
    "bus": "pci.1",
    "addr": 1
  },
  "id": "__qmp#00002"
}

What it actually meant is "addr": "1". It's an unfortunate interface,
but string "1" and integer 1 mean different things for PCI address
properties... Going through QemuOpts turned everything into strings, so
that masked the bug in the test case.

Should I just fix the test case and move on, or are we concerned about
other users having a similar bug and want to move the change to 10.0,
keeping device_add with iothread-vq-mapping broken in 9.2?

As far as I can tell, libvirt always uses the string form, so everything
using libvirt should be fine either way. Peter (Krempa), can you
confirm?

Kevin


