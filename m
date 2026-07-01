Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DD5CC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 08:14:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weq5T-0003r8-QA; Wed, 01 Jul 2026 04:14:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1weq5S-0003qo-Qa
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 04:14:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1weq5R-0008Rg-1T
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 04:14:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782893663;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yq3nUJTjXjwnTts5/8ohN8hEBLtL5YDXp6m3lHCkJBw=;
 b=Cc1/CiMl+bi4aQtAaxOHkHakp3/7zLKlVPLOB+KmYwOThPrYadKyS0gK6ObBd/C5NlNI0J
 2j2fe0s7OG/N5CcQO9z6+DZDFYjQ/eddR/NU0rV+gU/cGIb+FLzEEtdBwtFTnLOf/7SfLh
 7WX+hq1/9q8Pa8PSy1sptr73ShP4tC4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-373-DBIZCQ96N0uPpNAz3bubDw-1; Wed,
 01 Jul 2026 04:14:22 -0400
X-MC-Unique: DBIZCQ96N0uPpNAz3bubDw-1
X-Mimecast-MFC-AGG-ID: DBIZCQ96N0uPpNAz3bubDw_1782893661
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 86493180AD68; Wed,  1 Jul 2026 08:14:20 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.35])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B4CDB180060E; Wed,  1 Jul 2026 08:14:16 +0000 (UTC)
Date: Wed, 1 Jul 2026 09:14:13 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, devel@lists.libvirt.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Christian Brauner <brauner@kernel.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Peter Krempa <pkrempa@redhat.com>
Subject: Re: [PATCH v5 33/35] tests: switch from -mon to -object monitor-qmp
Message-ID: <akTMVbD4jXprjdIf@redhat.com>
References: <20260624173752.2928717-1-berrange@redhat.com>
 <20260624173752.2928717-34-berrange@redhat.com>
 <87jyrf6u32.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87jyrf6u32.fsf@pond.sub.org>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Jul 01, 2026 at 09:35:13AM +0200, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > Use the new preferred low level option for configuring the
> > QMP service in libqtest and the python Machine class used
> > by tests. This will avoid triggering deprecation warnings
> > after the subsequent commit.
> >
> > Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> > Tested-by: Peter Krempa <pkrempa@redhat.com>
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  python/qemu/machine/machine.py | 4 ++--
> >  tests/qtest/libqtest.c         | 2 +-
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/python/qemu/machine/machine.py b/python/qemu/machine/machine.py
> > index ebb58d5b68..5f4845f5fb 100644
> > --- a/python/qemu/machine/machine.py
> > +++ b/python/qemu/machine/machine.py
> > @@ -304,8 +304,8 @@ def _base_args(self) -> List[str]:
> >                  )
> >              else:
> >                  moncdev = f"socket,id=mon,path={self._monitor_address}"
> > -            args.extend(['-chardev', moncdev, '-mon',
> > -                         'chardev=mon,mode=control'])
> > +            args.extend(['-chardev', moncdev, '-object',
> > +                         'monitor-qmp,id=qmp,chardev=mon'])
> >  
> >          if self._machine is not None:
> >              args.extend(['-machine', self._machine])
> > diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
> > index 4e22c66b75..c33c799c92 100644
> > --- a/tests/qtest/libqtest.c
> > +++ b/tests/qtest/libqtest.c
> > @@ -460,7 +460,7 @@ gchar *qtest_qemu_args(const char *extra_args)
> >                        "-qtest unix:%s "
> >                        "-qtest-log %s "
> >                        "-chardev socket,path=%s,id=char0 "
> > -                      "-mon chardev=char0,mode=control "
> > +                      "-object monitor-qmp,id=qmp0,chardev=char0 "
> >                        "-display none "
> >                        "-audio none "
> >                        "%s "
> 
> Have you considered tests/functional/qemu_test/testcase.py
> 
>         if sockpath is not None:
>             vm.add_args("-chardev",
>                         f"socket,id=backdoor,path={sockpath},server=on,wait=off",
>                         "-mon", "chardev=backdoor,mode=control")
> 
> and tests/tcg/{aarch64,arm}/Makefile.softmmu-target
> 
>     QEMU_SEMIHOST=-serial none -chardev stdio,mux=on,id=stdio0 -semihosting-config enable=on,chardev=stdio0 -mon chardev=stdio0,mode=readline
> 
> ?

I didn't think about them but the code allows for mixing of -mon  and
-object, so that CI passes shows they've not seen problems.

We could convert them to -object too if we like but it doesn't hugely
matter except from the pov of "best practice"

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


