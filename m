Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30489C3DA4B
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 12:45:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSFeT-00071y-VW; Fri, 12 Jul 2024 08:45:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sSFeR-0006uv-UO
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 08:45:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sSFeQ-0000ul-0J
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 08:45:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720788325;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=46s7AkIhFW3EDXbPBYpvcFSbgP7f/ZUlIpyg0O5yFSk=;
 b=VzjzvqdB+ZOC2fVbYc6pb0/VEJk6BRdAzxXYbeLW/UHsE2nexwYBKc72vlbybZQWeYrSvS
 39a3w2eaDBa0PULxI43UL/jsmNOmcN0x850pabfbhuG2yZlZrwanB9uPp486V8GQ0JPWhJ
 FcMmMjF2sLpk/ZmKG6JSGJ+aJvqbMYA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-646-BBdzFbWuNV2xb9atv_PyFg-1; Fri,
 12 Jul 2024 08:45:21 -0400
X-MC-Unique: BBdzFbWuNV2xb9atv_PyFg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 89AAD19772C9; Fri, 12 Jul 2024 12:45:20 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.56])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 77DCD195606C; Fri, 12 Jul 2024 12:45:17 +0000 (UTC)
Date: Fri, 12 Jul 2024 13:45:14 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 18/22] qga: don't disable fsfreeze commands if
 vss_init fails
Message-ID: <ZpElWmudo4Rx91NA@redhat.com>
References: <20240613150127.1361931-1-berrange@redhat.com>
 <20240613154406.1365469-1-berrange@redhat.com>
 <20240613154406.1365469-13-berrange@redhat.com>
 <g1m7d.30xyxwwcb8l4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <g1m7d.30xyxwwcb8l4@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.138,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jul 03, 2024 at 01:21:29PM +0300, Manos Pitsidianakis wrote:
> On Thu, 13 Jun 2024 18:44, "Daniel P. Berrangé" <berrange@redhat.com> wrote:
> > The fsfreeze commands are already written to report an error if
> > vss_init() fails. Reporting a more specific error message is more
> > helpful than a generic "command is disabled" message, which cannot
> > beteween an admin config decision and lack of platform support.
> 
> s/beteween/between
> 
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> > qga/commands-win32.c | 18 +++---------------
> > qga/main.c           |  4 ++++
> > 2 files changed, 7 insertions(+), 15 deletions(-)
> > 
> > diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> > index 2533e4c748..5866cc2e3c 100644
> > --- a/qga/commands-win32.c
> > +++ b/qga/commands-win32.c
> > @@ -1203,7 +1203,7 @@ GuestFilesystemInfoList *qmp_guest_get_fsinfo(Error **errp)
> > GuestFsfreezeStatus qmp_guest_fsfreeze_status(Error **errp)
> > {
> >     if (!vss_initialized()) {
> > -        error_setg(errp, QERR_UNSUPPORTED);
> > +        error_setg(errp, "fsfreeze not possible as VSS failed to initialize");
> >         return 0;
> 
> Should this be return -1 by the way?

This method has to return GuestFsfreezeStatus and
-1 isn't valid. Not a problem though, as the
QAPI code will check for *errp != NULL and not
consider the return value for error detection.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


