Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 819BAD78310
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 12:09:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI5En-0001AU-HZ; Mon, 02 Dec 2024 07:09:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tI5Ej-00019a-MA
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 07:09:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tI5Eb-0006nm-2Z
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 07:09:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733141340;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NbQs7zK1N/KAi+yiap3GgeTQjoEOugXlF8vk5nfhaPw=;
 b=ZMsd1PJKfim7tFCHNcClY8iGKcQK3V9TXDxEKJgXcgllmpP0Xm+q4jpPWTsMJ+rbWcjraM
 L7yzZgDI6nNC4KEnPbPsjPmly/DcP5KliApdVtkG7DGzVkGM4Lx4r71qBYxsu2CRU9g/hh
 8Y99O6oMVPHEYok3eV1xGULUXFe8CTk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-379-U4q8R0hWNC2UNA-CMk2O8Q-1; Mon,
 02 Dec 2024 07:08:56 -0500
X-MC-Unique: U4q8R0hWNC2UNA-CMk2O8Q-1
X-Mimecast-MFC-AGG-ID: U4q8R0hWNC2UNA-CMk2O8Q
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F16B41958B1E; Mon,  2 Dec 2024 12:08:55 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.143])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7FF7719560A3; Mon,  2 Dec 2024 12:08:54 +0000 (UTC)
Date: Mon, 2 Dec 2024 12:08:51 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH 16/22] tests/functional: add common deb_extract helper
Message-ID: <Z02jU5McwXyIWqOK@redhat.com>
References: <20241129173120.761728-1-berrange@redhat.com>
 <20241129173120.761728-17-berrange@redhat.com>
 <36f44436-5448-4ac8-bed5-1f23b79887dc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <36f44436-5448-4ac8-bed5-1f23b79887dc@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Dec 02, 2024 at 11:14:16AM +0100, Thomas Huth wrote:
> On 29/11/2024 18.31, Daniel P. Berrangé wrote:
> > This mirrors the existing archive_extract, cpio_extract and zip_extract
> > helpers
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >   tests/functional/qemu_test/linuxkernel.py | 15 +++++----------
> >   tests/functional/qemu_test/utils.py       | 13 +++++++++++++
> >   2 files changed, 18 insertions(+), 10 deletions(-)
> > 
> > diff --git a/tests/functional/qemu_test/linuxkernel.py b/tests/functional/qemu_test/linuxkernel.py
> > index a6525f9dd6..fb6a158d36 100644
> > --- a/tests/functional/qemu_test/linuxkernel.py
> > +++ b/tests/functional/qemu_test/linuxkernel.py

> > +def deb_extract(archive, dest_dir, member=None):
> > +    cwd = os.getcwd()
> > +    os.chdir(dest_dir)
> > +    try:
> > +        (stdout, stderr, ret) = run_cmd(['ar', 't', archive])
> > +        file_path = stdout.split()[2]
> > +        run_cmd(['ar', 'x', archive, file_path])
> > +        archive_extract(file_path, dest_dir, member)
> > +    finally:
> > +        os.chdir(cwd)
> 
> Not sure whether we really need this ... extracting .deb files is very
> specific to running Linux kernels in the guest, so IMHO it should be
> sufficient to have it in linuxkernel.py.

You've probably seen the motivation in later patches now - the desire is
to have a standardized "archive_extract" method that handles all types
of archive, automatically setting the dest_dir to 'workdir'. I didn't
want deb_extract to remain an exception to the pattern, because it is
used quite widely.


> Anyway, if we add more and more *_extract functions, we should maybe
> consider to move the extraction functions out of utils.py into an archive.py
> file, what do you think?

Yeah, good point. I temporarily forgot my general rule that files / dirs
called 'util' end up being a general "dumping ground" for unrelated stuff,
and more specialized files are a better idea.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


