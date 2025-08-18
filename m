Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C68ECA0EE4
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Aug 2025 15:08:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uo1Sh-0004Ic-Li; Mon, 18 Aug 2025 11:07:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uo1Sa-0004I9-2w
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 11:07:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uo1SX-0000hg-T4
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 11:07:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755529659;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qoNIzjlh4Wcr8th8EfpJCiPtkgAq9W03t4WMdsZVxY4=;
 b=PM54PgMSDP1rFFHQs04o9tSGaKbS53Xo2yK4qs2MgW+FgaMs2QPdk3tu3+8N5nwJ/8lP3o
 btqsAm1kJy3uco88i1vCYiPxt+RT0ZOLk55Yx3CzL/ohxmSEHHG7Z/w26P/ayhQ0q5wAA3
 gib5tii6Uj8d4KJmmL2dZ8qXJss3d3s=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-518-Y0Bwp0jjNhG94yNwwCMVYA-1; Mon,
 18 Aug 2025 11:07:36 -0400
X-MC-Unique: Y0Bwp0jjNhG94yNwwCMVYA-1
X-Mimecast-MFC-AGG-ID: Y0Bwp0jjNhG94yNwwCMVYA_1755529655
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2772019775AF; Mon, 18 Aug 2025 15:07:35 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.90])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C0BF630001A8; Mon, 18 Aug 2025 15:07:31 +0000 (UTC)
Date: Mon, 18 Aug 2025 16:07:28 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, oleg.tolmatcev@gmail.com
Subject: Re: [PATCH v3 5/8] tracetool: support "-" as a shorthand for stdout
Message-ID: <aKNBsOekKkCSqgD7@redhat.com>
References: <20250806164832.1382919-1-berrange@redhat.com>
 <20250806164832.1382919-6-berrange@redhat.com>
 <20250807194608.GF51368@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250807194608.GF51368@fedora>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Aug 07, 2025 at 03:46:08PM -0400, Stefan Hajnoczi wrote:
> On Wed, Aug 06, 2025 at 05:48:29PM +0100, Daniel P. Berrangé wrote:
> > This avoids callers needing to use the UNIX-only /dev/stdout
> > workaround.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  scripts/tracetool/__init__.py | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__.py
> > index 0f33758870..c8fd3a7ddc 100644
> > --- a/scripts/tracetool/__init__.py
> > +++ b/scripts/tracetool/__init__.py
> > @@ -38,8 +38,12 @@ def error(*lines):
> >  
> >  def out_open(filename):
> >      global out_filename, out_fobj
> > -    out_filename = posix_relpath(filename)
> > -    out_fobj = open(filename, 'wt')
> > +    if filename == "-":
> > +        out_filename = "[stdout]"
> 
> A few lines above:
> 
>   out_filename = '<none>'
>   out_fobj = sys.stdout
> 
> Stick to '<none>' here for consistency?

Curious - that suggests that it was intended to be able to write to
stdout by default, but tracetool.py unconditionally calls out_open()
so those default assignments are effectively dead code, unless this
internal code is called by something other than the tracetool.py main
entrypoint ?

I guess I'd be inclined to change the global initialization to just
be 'None' to make it explicit that out_open is expected to always be
called ?

> > +        out_fobj = sys.stdout
> > +    else:
> > +        out_filename = posix_relpath(filename)
> 
> I have CCed Oleg in case he spots any portability issues, but I think
> this should still work on Windows.

This use of posix_relpath() was pre-existing, so there shouldn't be
any new issues from this.

> 
> > +        out_fobj = open(filename, 'wt')
> >  
> >  def out(*lines, **kwargs):
> >      """Write a set of output lines.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


