Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BA0DC2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 09:19:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSCQp-00038Q-4y; Fri, 12 Jul 2024 05:19:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sSCQn-000371-9j
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 05:19:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sSCQl-0003rD-KQ
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 05:19:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720775946;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=89LYHN4a8D+xhtePv0RcYlOJl23fvENIMB+zZ0GPPps=;
 b=Ad3eB7AOiMV+dvlhNFyTCiGjvnb0ggYt/36aNLooXLKc6KV5pyNMWRwokR5GW4wfqZ4vIC
 S7ULej3Y0UMjL1YkH9c8sH8VTlmlMSNFP/8JMPCe5qsFLs68Z8QYKHD5c64p8/WMivn3Jx
 F8R1WcrhP5f8eIJMzdblnRUIE4WRyMs=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-513-zo1r_gaxPw-YbOfpzbyGdA-1; Fri,
 12 Jul 2024 05:19:03 -0400
X-MC-Unique: zo1r_gaxPw-YbOfpzbyGdA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 54D1C1955F3B; Fri, 12 Jul 2024 09:19:02 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.56])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 28DFC1955E89; Fri, 12 Jul 2024 09:18:58 +0000 (UTC)
Date: Fri, 12 Jul 2024 10:18:55 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Konstantin Kostiuk <kkostiuk@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 21/22] qga: allow configuration file path via the cli
Message-ID: <ZpD0_zdxj-AVOcEG@redhat.com>
References: <20240613150127.1361931-1-berrange@redhat.com>
 <20240613154406.1365469-1-berrange@redhat.com>
 <20240613154406.1365469-16-berrange@redhat.com>
 <CAPMcbCo7CY1VJ+J8Zft7i5cG+1yDMKQa1hzmCNWxkin9G4cVTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPMcbCo7CY1VJ+J8Zft7i5cG+1yDMKQa1hzmCNWxkin9G4cVTA@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
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

On Fri, Jul 12, 2024 at 12:05:23PM +0300, Konstantin Kostiuk wrote:
> On Thu, Jun 13, 2024 at 6:45 PM Daniel P. Berrangé <berrange@redhat.com>
> wrote:
> 
> > Allowing the user to set the QGA_CONF environment variable to change
> > the default configuration file path is very unusual practice, made
> > more obscure since this ability is not documented.
> >
> > This introduces the more normal '-c PATH'  / '--config=PATH' command
> > line argument approach. This requires that we parse the comamnd line
> > twice, since we want the command line arguments to take priority over
> > the configuration file settings in general.
> >
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  docs/interop/qemu-ga.rst |  5 +++++
> >  qga/main.c               | 35 +++++++++++++++++++++++++++--------
> >  2 files changed, 32 insertions(+), 8 deletions(-)
> >
> > diff --git a/docs/interop/qemu-ga.rst b/docs/interop/qemu-ga.rst
> > index 72fb75a6f5..e42b370319 100644
> > --- a/docs/interop/qemu-ga.rst
> > +++ b/docs/interop/qemu-ga.rst
> > @@ -33,6 +33,11 @@ Options
> >
> >  .. program:: qemu-ga
> >
> > +.. option:: -c, --config=PATH
> > +
> > +  Configuration file path (the default is |CONFDIR|\ ``/qemu-ga.conf``,
> > +  unless overriden by the QGA_CONF environment variable)
> > +
> >  .. option:: -m, --method=METHOD
> >
> 
> Please also update qga/main.c static void usage(const char *cmd)

Opps, yes, will do.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


