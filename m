Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 109D8F3C241
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 12:41:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzZux-0006Q3-0J; Mon, 09 Mar 2026 08:41:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vzZun-0006PZ-In
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 08:40:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vzZuk-0003cH-M5
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 08:40:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773060049;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=QW/RVnQZ3ZCNuQWwf5Qap8LaFm1dRaQBQG/m1o5ZlPk=;
 b=Sg+rJIvMQ2HQwxuW8gg6nfEM7SbQ0+/sUWk+i0ALuEBDaJMV1IsGy17b3ReV4AuELtKiq6
 NXwGysEFIsfjabejEm86QvmCtALF1mxjdkvNqnCVJ6jXHT5yL0RSATxdnYtVSrqI2+pz/o
 os+64Cz5USowI0Hl8CnAEDBmLfTAWIA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-169-5uMS5IXGM6GoPlH_dQZ1xA-1; Mon,
 09 Mar 2026 08:40:45 -0400
X-MC-Unique: 5uMS5IXGM6GoPlH_dQZ1xA-1
X-Mimecast-MFC-AGG-ID: 5uMS5IXGM6GoPlH_dQZ1xA_1773060045
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 01FC41955BE1; Mon,  9 Mar 2026 12:40:45 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.95])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 70E0E30001BB; Mon,  9 Mar 2026 12:40:43 +0000 (UTC)
Date: Mon, 9 Mar 2026 12:40:39 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>
Subject: Re: running a single functional test: where do the logs go?
Message-ID: <aa6_x250FtIdy1iw@redhat.com>
References: <CAFEAcA8FhiJZy6NqRUVnWQ+L6=fE8Ssqs9FEW2eO2eAVTrL=_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA8FhiJZy6NqRUVnWQ+L6=fE8Ssqs9FEW2eO2eAVTrL=_w@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Mar 09, 2026 at 11:55:58AM +0000, Peter Maydell wrote:
> The functional test documentation suggests running a single test
> with the build/run script. But if you do this where do the logfiles go?

They should always go in the build directory

> As you can see from this transcript, they don't seem to get written
> into the place that a "make check-functional" run puts them:
> 
> $ ls -l build/san/tests/functional/arm/test_emcraft_sf2.EmcraftSf2Machine.test_arm_emcraft_sf2/
> total 16
> -rw-r--r-- 1 pm215 pm215 3084 Mar  9 10:51 base.log
> -rw-r--r-- 1 pm215 pm215  825 Mar  9 10:51 console.log
> -rw-r--r-- 1 pm215 pm215  235 Mar  9 10:54 default.log
> drwxr-xr-x 3 pm215 pm215 4096 Mar  9 10:51 scratch
> $ date
> Mon Mar  9 11:20:13 GMT 2026
> $ time QEMU_TEST_QEMU_BINARY=./build/san/qemu-system-arm
> ./build/san/run tests/functional/arm/test_emcraft_sf2.py
> TAP version 13
> ok 1 test_emcraft_sf2.EmcraftSf2Machine.test_arm_emcraft_sf2
> 1..1
> 
> real    3m24.394s
> user    3m21.314s
> sys     0m3.100s
> $ ls -l build/san/tests/functional/arm/test_emcraft_sf2.EmcraftSf2Machine.test_arm_emcraft_sf2/
> total 16
> -rw-r--r-- 1 pm215 pm215 3084 Mar  9 10:51 base.log
> -rw-r--r-- 1 pm215 pm215  825 Mar  9 10:51 console.log
> -rw-r--r-- 1 pm215 pm215  235 Mar  9 10:54 default.log
> drwxr-xr-x 3 pm215 pm215 4096 Mar  9 10:51 scratch

That seems different from the behaviour I get


$ ls -al build/tests/functional/arm/test_emcraft_sf2.EmcraftSf2Machine.test_arm_emcraft_sf2/
total 28
drwxr-xr-x. 2 berrange berrange 4096 Mar  9 12:31 .
drwxr-xr-x. 3 berrange berrange 4096 Mar  9 12:30 ..
-rw-r--r--. 1 berrange berrange 6449 Mar  9 12:31 base.log
-rw-r--r--. 1 berrange berrange 8200 Mar  9 12:31 console.log
-rw-r--r--. 1 berrange berrange    0 Mar  9 12:30 default.log

$ time QEMU_TEST_QEMU_BINARY=qemu-system-arm ./build/run tests/functional/arm/test_emcraft_sf2.py
TAP version 13
ok 1 test_emcraft_sf2.EmcraftSf2Machine.test_arm_emcraft_sf2
1..1

real	0m10.731s
user	0m10.597s
sys	0m0.130s
$ ls -al build/tests/functional/arm/test_emcraft_sf2.EmcraftSf2Machine.test_arm_emcraft_sf2/
total 28
drwxr-xr-x. 2 berrange berrange 4096 Mar  9 12:32 .
drwxr-xr-x. 3 berrange berrange 4096 Mar  9 12:30 ..
-rw-r--r--. 1 berrange berrange 7253 Mar  9 12:32 base.log
-rw-r--r--. 1 berrange berrange 8200 Mar  9 12:32 console.log
-rw-r--r--. 1 berrange berrange    0 Mar  9 12:32 default.log


but in my case I'm just using ./build, where as you are using
./build/san, and I think that's tripping us up


def _build_dir():
    root = os.getenv('QEMU_BUILD_ROOT')
    if root is not None:
        return Path(root)
    # Makefile.mtest only exists in build dir, so if it is available, use CWD
    if os.path.exists('Makefile.mtest'):
        return Path(os.getcwd())

    root = os.path.join(_source_dir(), 'build')
    if os.path.exists(root):
        return Path(root)

    raise Exception("Cannot identify build dir, set QEMU_BUILD_ROOT")


The $CWD is the directory from which you are invoking the scripts,
so that Makefile.mtest check won't pass.

The _source_dir() / 'build'  test will pass, but that's not your
actual build dir, so that's not really correct.

The QEMU_BUILD_ROOT env was a special hack to allow overrides, but
we never set that by default.

These days, we do, however, set MESON_BUILD_ROOT in the meson devenv,
so the 'run' script should see that.

IOW, we should fix the _build_dir() method to look at MESON_BUILD_ROOT
instead of QEMU_BUILD_ROOT.

Meanwhile your logs are likely in build/tests/functional/... instead
of build/san/tests/functional.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


