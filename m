Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36C14D44145
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 11:26:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDMMm-0004Q8-UI; Tue, 19 Nov 2024 06:25:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tDMMk-0004PJ-Nj
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 06:25:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tDMMi-0002NN-OV
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 06:25:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732015535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PcoozvPkX5oZMRHs1LldVoH1xxefHbY/a5wQdQFD1XI=;
 b=NyCRM+Shd7qfTHoCTdFH3dC6GHkpsdBjmnv/uvZwvTHpKjKLiAL9GrAFgaFWZVVPtCg0aE
 VGRdZlwyD1VCScwT9rRfOQA09Q/+Vcj+PBeIcK+Zr/FNklZxpPTtfFOpBv6uGSmImn55NO
 44HakDXObxsb0rThA5lYIQSMFGbrItM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-IvQP2DTaOcCWvPsgIitEKw-1; Tue,
 19 Nov 2024 06:25:31 -0500
X-MC-Unique: IvQP2DTaOcCWvPsgIitEKw-1
X-Mimecast-MFC-AGG-ID: IvQP2DTaOcCWvPsgIitEKw
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B544B19560AF; Tue, 19 Nov 2024 11:25:30 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.242])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 335D819560A3; Tue, 19 Nov 2024 11:25:28 +0000 (UTC)
Date: Tue, 19 Nov 2024 12:25:26 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PULL 0/8] Block layer patches
Message-ID: <Zzx1prDqo3vPsIvN@redhat.com>
References: <20241114165657.254256-1-kwolf@redhat.com>
 <CAFEAcA-y2K74jbPwPwrCo=OfCn_eJpGskX5KVivAMxzQXLThrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-y2K74jbPwPwrCo=OfCn_eJpGskX5KVivAMxzQXLThrw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Am 15.11.2024 um 21:16 hat Peter Maydell geschrieben:
> On Thu, 14 Nov 2024 at 16:58, Kevin Wolf <kwolf@redhat.com> wrote:
> >
> > The following changes since commit f0a5a31c33a8109061c2493e475c8a2f4d022432:
> >
> >   Update version for v9.2.0-rc0 release (2024-11-13 21:44:45 +0000)
> >
> > are available in the Git repository at:
> >
> >   https://repo.or.cz/qemu/kevin.git tags/for-upstream
> >
> > for you to fetch changes up to 378a645b2f6125b1bdbd1fae3e8f30452d5b5934:
> >
> >   vl: use qmp_device_add() in qemu_create_cli_devices() (2024-11-14 17:55:51 +0100)
> >
> > ----------------------------------------------------------------
> > Block layer patches
> >
> > - Fix qmp_device_add() to not throw non-scalar options away (fixes
> >   iothread-vq-mapping being silently ignored in device_add)
> > - iotests: Fix mypy failure
> > - parallels: Avoid potential integer overflow
> > - Fix crash in migration_is_running()
> >
> 
> Hi; this seems to cause an error for the avocado test
> tests/avocado/hotplug_blk.py:HotPlug.test
> 
> https://gitlab.com/qemu-project/qemu/-/jobs/8387009365
> https://gitlab.com/qemu-project/qemu/-/jobs/8387009383
> 
> (12/51) tests/avocado/hotplug_blk.py:HotPlug.test: STARTED
> (12/51) tests/avocado/hotplug_blk.py:HotPlug.test: ERROR: Could not
> perform graceful shutdown (17.16 s)
> 
> If you dig through the build artefacts you can find the debug log:
> https://qemu-project.gitlab.io/-/qemu/-/jobs/8387009383/artifacts/build/tests/results/latest/test-results/12-tests_avocado_hotplug_blk.py_HotPlug.test/debug.log
> 
> and it seems like the test sends a device_add command over
> QMP and the result is that QEMU dies with an assertion failure.
> The relevant device_add is
> 
> [stdlog]   "execute": "device_add",
> [stdlog]   "arguments": {
> [stdlog]     "driver": "virtio-blk-pci",
> [stdlog]     "drive": "disk",
> [stdlog]     "id": "virtio-disk0",
> [stdlog]     "bus": "pci.1",
> [stdlog]     "addr": 1
> [stdlog]   },
> [stdlog]   "id": "__qmp#00002"
> [stdlog] }
> 
> Avocado helpfully hides the assertion message under a rock
> in a different log file:
> https://qemu-project.gitlab.io/-/qemu/-/jobs/8387009383/artifacts/build/tests/results/latest/test-results/12-tests_avocado_hotplug_blk.py_HotPlug.test/7f00b63ed810.log
> 
> qemu-system-x86_64: ../qapi/qobject-input-visitor.c:143:
> qobject_input_try_get_object: Assertion `removed' failed.
> 
> 
> I'm guessing this is Stefan's patches since they touch
> the device_add path.

Yes, this is Stefan's patches exposing a preexisting bug on a new code
path. You can already trigger the same bug on the command line with git
master:

$ ./qemu-system-x86_64 -blockdev null-co,node-name=disk -device '{ "driver": "virtio-blk-pci", "drive": "disk", "id": "virtio-disk0", "addr": 1 }'
qemu-system-x86_64: ../qapi/qobject-input-visitor.c:143: QObject *qobject_input_try_get_object(QObjectInputVisitor *, const char *, _Bool): Assertion `removed' failed.

The problem is that set_pci_devfn() visits the same field twice, which
is not allowed. Apparently the QemuOpts visitor accepts it anyway, but
the QObject one doesn't. I'll write a patch to use the proper alternate
mechanism instead, that should fix it.

Kevin


