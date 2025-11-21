Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 071D2CFC515
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 03:58:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMeKB-0004uv-Gw; Fri, 21 Nov 2025 22:30:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vMeK0-0004lv-Pp
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 22:30:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vMeJc-00036W-C7
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 22:29:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763782159;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=way1dHQ/1jicWwBa/YZQvIEoo2ciCvwblAtkfp2jUR0=;
 b=NwHOGut+Kgmv8nJ5uCrLU1jTVyN1R7QrYIOSF6v20fuSk2H6g0BbjQktJaHaVKDg7ncA/a
 4l6YDjhAjH3BylvgjccQtcUx1kDnU+F94rmMMdkaz2OpF+VAq3L9Vw/r/vgZjnpKitvEEm
 dYxLPcKvQ8/faJOTtU4rOt9ohTp/kRE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-263--Sm_V1V9NxqhV9DxYwna_Q-1; Fri,
 21 Nov 2025 06:09:13 -0500
X-MC-Unique: -Sm_V1V9NxqhV9DxYwna_Q-1
X-Mimecast-MFC-AGG-ID: -Sm_V1V9NxqhV9DxYwna_Q_1763723352
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4DD5E1956089; Fri, 21 Nov 2025 11:09:12 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.184])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A195E1940E82; Fri, 21 Nov 2025 11:09:10 +0000 (UTC)
Date: Fri, 21 Nov 2025 11:09:07 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: konrad.schwarz@gmail.com, qemu-devel@nongnu.org, philmd@linaro.org,
 Konrad Schwarz <konrad.schwarz@siemens.com>
Subject: Re: [PATCH 1/1] scripts: Changed potential O(n) file size
 calculation to O(1)
Message-ID: <aSBIUz8PxYZHncVN@redhat.com>
References: <CA+kmUXafV4PPo2t+P23g9QRXHjaH_XBke3DjzbvciqBtw+i-OA@mail.gmail.com>
 <dee22f22-c2e5-4154-99a7-525bfeb965af@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dee22f22-c2e5-4154-99a7-525bfeb965af@siemens.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On Fri, Nov 21, 2025 at 11:16:11AM +0100, Jan Kiszka wrote:
> You want to add
> 
> From: Konrad Schwarz <konrad.schwarz@siemens.com>
> 
> to the top of the commit message when submitting via a different account
> so that author and signer are aligned. Or use git sendemail which will
> do that when author and submitter address differ.
> 
> On 19.11.25 18:28, konrad.schwarz@gmail.com wrote:
> > The mkemmc.sh script calculates file sizes via `wc -c'.  `wc'
> > normally works by reading the entire file, resulting in O(n) performance.
> > 
> > Unix file systems obviously know a file's size and POSIX `ls' reports this
> > information unambiguously, so replacing `wc' with `ls' ensures O(1)
> > performance.  The files in question tend to be large making this change
> > worthwhile.
> 
> Valid point.
> 
> > 
> > Signed-off-by: Konrad Schwarz <konrad.schwarz@siemens.com>
> > ---
> >  scripts/mkemmc.sh | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> > 
> > diff --git a/scripts/mkemmc.sh b/scripts/mkemmc.sh
> > index 45dc3f08fa..d2c4e84b16 100755
> > --- a/scripts/mkemmc.sh
> > +++ b/scripts/mkemmc.sh
> > @@ -37,13 +37,19 @@ usage() {
> >      exit "$1"
> >  }
> > 
> > +file_size() {
> > +	ls_line=$(ls -Hdog "$1") || return
> 
> This will not suppress the error message when a file does not exist or
> is not accessible, so:
> 
> ls_line=$(ls -Hdog "$1" 2>/dev/null) || return
> 
> > +	printf %s\\n "$ls_line" | cut -d\  -f3
> > +	unset ls_line

This parsing of 'ls' output could be simplified by
using the 'stat' command with a format string to
request only the file size.

    stat --format=%s "$1"


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


