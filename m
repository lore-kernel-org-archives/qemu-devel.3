Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD59ECA0FE0
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 11:30:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjzp7-0005rr-9J; Fri, 30 Aug 2024 07:29:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sjzp5-0005rF-5z
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 07:29:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sjzp3-0008G8-70
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 07:29:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725017384;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=3ThKtUkTqewH3+rqfcu3V1wlYzw0xAqRACgiAfew/to=;
 b=ZzmtZDDrYm4ooM32tI0GjTByZ/pawN1NOSCGveVHcLUCunFFYL5bfG+YhCHQOU3bLhfaDh
 PDQ0wX4O4muTexKeJOyxua1OPfBEvyHkcNnbwmH4xDaTc6PHbuVx91GH02QNH/46MT+0ql
 YHCKolUEVbn2P/DUw79GpvljgWB6XBA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-170-VADDnHpxO1WpCNFN5HYVAw-1; Fri,
 30 Aug 2024 07:29:40 -0400
X-MC-Unique: VADDnHpxO1WpCNFN5HYVAw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DA10219560BF; Fri, 30 Aug 2024 11:29:39 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.49])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 482731955F1B; Fri, 30 Aug 2024 11:29:36 +0000 (UTC)
Date: Fri, 30 Aug 2024 12:29:32 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org,
 Cleber Rosa <crosa@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 7/8] python/qapi: move scripts/qapi to python/qemu/qapi
Message-ID: <ZtGtHHXW6uFjaNPz@redhat.com>
References: <20240820002318.1380276-1-jsnow@redhat.com>
 <20240820002318.1380276-8-jsnow@redhat.com>
 <87bk1acl4s.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87bk1acl4s.fsf@pond.sub.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, Aug 30, 2024 at 01:20:35PM +0200, Markus Armbruster wrote:
> John Snow <jsnow@redhat.com> writes:
> 
> > This is being done for the sake of unifying the linting and static type
> > analysis configurations between scripts/qapi and python/qemu/*.
> >
> > With this change, the qapi module will now be checked by mypy, flake8,
> > pylint, isort etc under all python versions from 3.8 through 3.13 under
> > a variety of different dependency configurations in the GitLab testing
> > pipelines.
> >
> > The tests can be run locally, as always:
> >
> >> cd qemu.git/python
> >> make check-minreqs
> >> make check-tox
> >> make check-dev
> >
> > "check-minreqs" is the must-pass GitLab test.
> > "check-tox" is the optional allowed-to-fail GitLab test.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> 
> I don't understand why we have to keep Python code in its own directory
> just to get it checked.  We wouldn't do that say for Rust code, would
> we?  Anyway, if it's the price of checking, I'll pay[*].

The 'check-tox' target is defined in python/Makefile, and is
written to only check code below that location, which is a
somewhat arbitrary choice.

Having this in "make" at all is a bit outdated. Ideally all
the targets in python/Makefile should be converted into meson
targets and/or tests, in a "python" suite.

IOW, we should make 'check-tox' a target in meson.build at the
top level, and have it check any .py file in the source tree,
with an exclude list for files we know are not "clean" yet,
so we don't have to move stuff around as we clean up individual
files.

> 
> [...]
> 
> > diff --git a/scripts/qapi-gen.py b/scripts/qapi-gen.py
> > index f3518d29a54..42912c91716 100644
> > --- a/scripts/qapi-gen.py
> > +++ b/scripts/qapi-gen.py
> > @@ -11,9 +11,11 @@
> >  execution environment.
> >  """
> >  
> > +import os
> >  import sys
> >  
> > -from qapi import main
> > +sys.path.append(os.path.join(os.path.dirname(__file__), '..', 'python'))
> > +from qemu.qapi import main
> >  
> >  if __name__ == '__main__':
> >      sys.exit(main.main())
> 
> Suggest to use the opportunity to rename to just qapi-gen (no .py) and
> chmod +x, possibly in a separate patch.
> 
> [...]
> 
> 
> [*] Grudgingly.
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


