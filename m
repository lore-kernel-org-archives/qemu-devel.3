Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DDC6D78310
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 12:11:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI5H5-00025i-NK; Mon, 02 Dec 2024 07:11:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tI5Gx-00025T-1E
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 07:11:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tI5Gv-0007vF-HO
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 07:11:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733141483;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s/5XEl04mqT/cWXXmdFAJ57C2SdUya77+SUhzHyBAck=;
 b=fgoFyx0mcLTkxajEqnrS3LYPshYfjL+eVP7tWwkXKj9EEO6fgSGQbMoHCYtnb4ltV/hokS
 ZplNrKxAcezy6Cr2bThMnGLMg9+9aGfxuPLQiPfHGJJfWrWEbDaIaQDqPKqMC2M0xh9ywv
 GgPnnIgXcawrbmzGUfBDecOAQZsRCrg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-LhezaczyMlaOP8xxFZCtQA-1; Mon,
 02 Dec 2024 07:11:20 -0500
X-MC-Unique: LhezaczyMlaOP8xxFZCtQA-1
X-Mimecast-MFC-AGG-ID: LhezaczyMlaOP8xxFZCtQA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 720281944D32; Mon,  2 Dec 2024 12:11:19 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.143])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 94E451956089; Mon,  2 Dec 2024 12:11:17 +0000 (UTC)
Date: Mon, 2 Dec 2024 12:11:13 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH 17/22] tests/functional: generalize archive_extract
Message-ID: <Z02j4RrFQfsm4IO9@redhat.com>
References: <20241129173120.761728-1-berrange@redhat.com>
 <20241129173120.761728-18-berrange@redhat.com>
 <f7e57416-5812-449b-8c9e-4d2bdc12adfd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f7e57416-5812-449b-8c9e-4d2bdc12adfd@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
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

On Mon, Dec 02, 2024 at 11:20:19AM +0100, Thomas Huth wrote:
> On 29/11/2024 18.31, Daniel P. Berrangé wrote:
> > There are many types of archives that the tests deal with, and
> > 'archive_extract' suggests it can cope with any, rather than only
> > tar files. Rename the existing method to 'tar_extract' and add a
> > new method that can dynamically extract any zip, tar or cpio file
> > based on file extension.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >   tests/functional/qemu_test/utils.py | 31 +++++++++++++++++++++++++++--
> >   1 file changed, 29 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tests/functional/qemu_test/utils.py b/tests/functional/qemu_test/utils.py
> > index bafe7fb80e..8c1df8f8c2 100644
> > --- a/tests/functional/qemu_test/utils.py
> > +++ b/tests/functional/qemu_test/utils.py
> > @@ -14,6 +14,7 @@
> >   import shutil
> >   import subprocess
> >   import tarfile
> > +import zipfile
> >   from .cmd import run_cmd
> > @@ -38,7 +39,33 @@ def image_pow2ceil_expand(path):
> >               with open(path, 'ab+') as fd:
> >                   fd.truncate(size_aligned)
> > -def archive_extract(archive, dest_dir, member=None):
> > +def archive_extract(archive, dest_dir, format=None, member=None):
> 
> Why not doing "if not format: format = guess_archive_format(archive)" here?
> Otherwise this helper function is rather useless - if you have to know the
> format, you could directly call the appropriate function anyway.

That's how I had things at first, but then I hit the problem that
about 80% of the files we're extracting are cached assets, and the
asset filenames are just a hash digest, so there's no file extension
to query.

I guess I could make this work by pushing the Asset object instance
right down into this method, rather than converting from Asset ->
filename in the caller.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


