Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC13DC44501
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 16:17:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wk2Hp-000246-Ht; Wed, 15 Jul 2026 12:16:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wk2Hn-00023N-9x
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 12:16:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wk2Hl-0000LC-0n
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 12:16:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784132194;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xQTsbQUmJq9g7eYt6FgvkGxktJr5XMT8t2pKAnZDEFY=;
 b=FBnKQ6ooPrlsq3Bd5xG69QAdPSkNFSzVqQy6GJ6OOxy2nDncWuNO4Z3tyqsbbmFVUvcDz1
 gEAOCNjb8JxIzEa3OJF0QorlcIvpLphEgofNRZjXBjvuxuKCD0MpZaqBDpZq775h16YYn4
 f53YT8xpvU2HFfKu8RvJ4MQfJ+OzxGA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-275-UfPn6vaaM5KnvdVQhYlimQ-1; Wed,
 15 Jul 2026 12:16:33 -0400
X-MC-Unique: UfPn6vaaM5KnvdVQhYlimQ-1
X-Mimecast-MFC-AGG-ID: UfPn6vaaM5KnvdVQhYlimQ_1784132192
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C906A1955BEE; Wed, 15 Jul 2026 16:16:31 +0000 (UTC)
Received: from redhat.com (unknown [10.44.34.221])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D7B711956086; Wed, 15 Jul 2026 16:16:29 +0000 (UTC)
Date: Wed, 15 Jul 2026 17:16:26 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v2] tests/docker: ensure container command is probed at
 most once
Message-ID: <aleyWsC-JqqnIV8k@redhat.com>
References: <20260715104218.1110301-1-berrange@redhat.com>
 <e3932087-16c8-4e34-98cf-c20cf7db9531@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e3932087-16c8-4e34-98cf-c20cf7db9531@oss.qualcomm.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=berrange@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

On Wed, Jul 15, 2026 at 09:07:18AM -0700, Pierrick Bouvier wrote:
> On 7/15/2026 3:42 AM, Daniel P. Berrangé wrote:
> > The '--engine' arg accepts either 'podman' or 'docker', which is
> > not sufficiently granular to map directly to a command. This
> > means that  docker.py still has to then probe the exact command
> > to use.
> > 
> > Meanwhile the 'probe' command prints out the full command to use
> > but this cannot be passed back to docker.py to avoid probing
> > again, so the caching is only useful in the few case where we
> > run a container directly bypassing docker.py.
> > 
> > Address this by replacing --engine with --command for docker.py.
> > 
> > This in turn requires the --container-engine configure arg to be
> > replaced with --container-command.
> > 
> > With these changes the container command is probed at most once
> > during configure and never again, while running in an unconfigured
> > tree will still probe on demand.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> > 
> > In v2:
> > 
> >  * Don't set container_command to "no" if 'probe' finds
> >    not viable binaries.
> > 
> >  configure                     | 25 +++++++------
> >  tests/docker/Makefile.include | 13 ++++---
> >  tests/docker/docker.py        | 67 ++++++++++++-----------------------
> >  3 files changed, 40 insertions(+), 65 deletions(-)


> 
> I still observe the same error when running make-tcg without
> podman/docker installed.
> bash: line 1: no: command not found
> 
> And I will suggest again to include in your series:
> https://lore.kernel.org/qemu-devel/20260710214343.2065491-27-pierrick.bouvier@oss.qualcomm.com/
> and detect if probe command worked or failed, and adapt behavior based
> on it. Existing behavior to compare to a string "no" is a very
> unfamiliar pattern for any command. `which` does not return no for instance.

That didn't do anything for me when I tested it, and this current
patch did fix the problem. Are you testing on top of a vanilla
git master, or did you have other patches that aren't merged
upstream.

When /usr/bin/podman was absent

 $ ./configure --target-list=s390x-linux-user
 ...
 $ grep CONTAINER build/config-host.mak 
 <no match>
 
 $ make run-tcg-tests-s390x-linux-user
  changing dir to build for make "run-tcg-tests-s390x-linux-user"...
  make[1]: Entering directory '/home/berrange/src/virt/qemu/build'
  ninja: no work to do.
  /home/berrange/src/virt/qemu/build/pyvenv/bin/meson introspect --targets --tests --benchmarks | /home/berrange/src/virt/qemu/build/pyvenv/bin/python3 -B scripts/mtest2make.py > Makefile.mtest
  make[1]: *** No rule to make target 'run-tcg-tests-s390x-linux-user'.  Stop.

configure has correctly skipped setup of the tcg cross
compiler targets.

When /usr/bin/podman was re-instaled it once again
worked


  $ ./configure --target-list=s390x-linux-user
  ...
  $ grep CONTAINER build/config-host.mak 
  CONTAINER_COMMAND=podman

  $ make run-tcg-tests-s390x-linux-user
  changing dir to build for make "run-tcg-tests-s390x-linux-user"...
  make[1]: Entering directory '/home/berrange/src/virt/qemu/build'
  ninja: no work to do.
  /home/berrange/src/virt/qemu/build/pyvenv/bin/meson introspect --targets --tests --benchmarks | /home/berrange/src/virt/qemu/build/pyvenv/bin/python3 -B scripts/mtest2make.py > Makefile.mtest
    BUILD   debian-s390x-cross
    BUILD   s390x-linux-user guest-tests
  tests/tcg/s390x-linux-user: -march=z14 detected
  tests/tcg/s390x-linux-user: -march=z15 detected
  ...tests running...

> You can test next patch using podman (which it seems you have):
> ```
> podman build \
> -f tests/docker/dockerfiles/debian-all-test-cross.docker -t all
> podman run -it --rm all -w $(pwd) -v $(pwd):$(pwd) all \
> bash -c "./configure && cd build && make all -j32 &&make check-tcg -j32"
> ```

I've run 'make check-tcg' and it correctly skips all tests when
podman is absent

  $ make check-tcg
  changing dir to build for make "check-tcg"...
  make[1]: Entering directory '/home/berrange/src/virt/qemu/build'
  make[1]: Nothing to be done for 'check-tcg'.
  make[1]: Leaving directory '/home/berrange/src/virt/qemu/build'


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


