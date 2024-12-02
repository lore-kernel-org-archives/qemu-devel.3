Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 327A8D78321
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 13:41:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI6c8-0000PS-Du; Mon, 02 Dec 2024 08:37:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tI6Ty-0007te-RT
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:28:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tI6Tv-0000d4-FU
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:28:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733146133;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zojyDTFFNA31NzoYHYk4d7/O949Hqy/DPojAHqPHPD8=;
 b=O/E5RxATRtEGLT+SISMESyqUWMC+07WmohL4/AcDc5DyLG0+Ht8DmazmU+YkNOkjdx3z19
 6J/j3qsIOtxetoWv65zkZUbN7DR6WZM6D5eAgZKV0QO9GjKfh95dIkb1Gz27671S2GqA9R
 RSiy/EIhfi7C7FsMCF9jbSgV5VGMFoc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-160-GvSbtMb_PFGdhn2IckdhZg-1; Mon,
 02 Dec 2024 08:28:50 -0500
X-MC-Unique: GvSbtMb_PFGdhn2IckdhZg-1
X-Mimecast-MFC-AGG-ID: GvSbtMb_PFGdhn2IckdhZg
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8394C1944DDE; Mon,  2 Dec 2024 13:28:49 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.143])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BCFA91955D45; Mon,  2 Dec 2024 13:28:47 +0000 (UTC)
Date: Mon, 2 Dec 2024 13:28:44 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH 18/22] tests/functional: add 'archive_extract' to
 QemuBaseTest
Message-ID: <Z022DImyDM5PP2nn@redhat.com>
References: <20241129173120.761728-1-berrange@redhat.com>
 <20241129173120.761728-19-berrange@redhat.com>
 <9277a627-13d6-4d0f-9802-dec6b2606cbe@redhat.com>
 <Z02kTzobRDeEYHQR@redhat.com>
 <808c81b0-c64a-4a32-9683-c96b51145da3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <808c81b0-c64a-4a32-9683-c96b51145da3@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Dec 02, 2024 at 01:52:46PM +0100, Thomas Huth wrote:
> On 02/12/2024 13.13, Daniel P. Berrangé wrote:
> > On Mon, Dec 02, 2024 at 11:30:28AM +0100, Thomas Huth wrote:
> > > On 29/11/2024 18.31, Daniel P. Berrangé wrote:
> > > > This helper wrappers utils.archive_extract, forcing the use of the
> > > > scratch directory, to ensure any extracted files are cleaned at test
> > > > termination. If a specific member is requested, then the path to the
> > > > extracted file is also returned.
> > > > 
> > > > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > > > ---
> > > >    tests/functional/qemu_test/testcase.py | 36 ++++++++++++++++++++++++++
> > > >    1 file changed, 36 insertions(+)
> > > > 
> > > > diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
> > > > index 2f32742387..31d06f0172 100644
> > > > --- a/tests/functional/qemu_test/testcase.py
> > > > +++ b/tests/functional/qemu_test/testcase.py
> > > > @@ -28,6 +28,8 @@
> > > >    from .asset import Asset
> > > >    from .cmd import run_cmd
> > > >    from .config import BUILD_DIR
> > > > +from .utils import (archive_extract as utils_archive_extract,
> > > > +                    guess_archive_format)
> > > >    class QemuBaseTest(unittest.TestCase):
> > > > @@ -39,6 +41,40 @@ class QemuBaseTest(unittest.TestCase):
> > > >        log = None
> > > >        logdir = None
> > > > +    '''
> > > > +    @params archive: filename, Asset, or file-like object to extract
> > > > +    @params sub_dir: optional sub-directory to extract into
> > > > +    @params member: optional member file to limit extraction to
> > > > +
> > > > +    Extracts @archive into the scratch directory, or a
> > > > +    directory beneath named by @sub_dir. All files are
> > > > +    extracted unless @member specifies a limit.
> > > > +
> > > > +    If @member is non-None, returns the fully qualified
> > > > +    path to @member
> > > > +    '''
> > > > +    def archive_extract(self, archive, format=None, sub_dir=None, member=None):
> > > > +        if type(archive) == Asset:
> > > > +            if format is None:
> > > > +                format = guess_archive_format(archive.url)
> > > > +            archive = archive.fetch()
> > > > +        elif format is None:
> > > > +            format = guess_archive_format(archive)
> > > > +
> > > > +        if member is not None:
> > > > +            if os.path.isabs(member):
> > > > +                member = os.path.relpath(member, '/')
> > > > +
> > > > +        if sub_dir is None:
> > > > +            utils_archive_extract(archive, self.scratch_file(), format, member)
> > > > +        else:
> > > > +            utils_archive_extract(archive, self.scratch_file(sub_dir),
> > > > +                                  format, member)
> > > > +
> > > > +        if member is not None:
> > > > +            return self.scratch_file(member)
> > > > +        return None
> > > 
> > > Ah, ok, so the guessing is done here ...
> > > 
> > > But somehow it feels wrong to have a "archive_extract" function in the
> > > QemuBaseTest class that also does asset fetching under the hood.
> > > 
> > > Could you maybe rather move this into the asset.py file and rename the
> > > function to "fetch_and_extract()" to make it clearer what it does?
> > 
> > We can't move it into asset.py because not all callers are passing in an
> > Asset object - there are some cases where we've just got a local file.
> > eg when the asset we extracted contains other archives that need to be
> > extracted.
> 
> Couldn't those spots rather use the function from utils.py directly for the
> second extraction?
> 
> Anyway, I guess now it's likely better to keep it here since you want to
> have access to self.scratch_file() in this function, too.
> But maybe you could still at least rename it to fetch_and_extract() to make
> it more obvious what it all about?

I wanted to de-emphasize the 'fetch' concept, to make use of assets look
and work no different from local files.

In practice they are all local files, with no fetching taking place, as
the test suite arranges for everything to be pre-fetched into the local
cache. THe only time a "fetch" would ever happen during execution is if
you had directly invoked a python file, with an empt ycache.

IOW, from the POV of the executing test case, an Asset object is no more
than a wrapper around a local filename.

Hmm, in fact I wonder if we shouldn't implement the 'str' method to
directly return the local filename, so we can pass Asset object instances
to any method that expects a filename.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


