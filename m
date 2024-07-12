Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E231EC2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 08:14:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSBP4-0007z9-RK; Fri, 12 Jul 2024 04:13:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sSBP2-0007yb-L5
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 04:13:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sSBP0-0001uq-Jc
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 04:13:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720771991;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KdY4rHnNa3Gybb1KTxgIrMl6Q9u1JfXmSlKRyPb9kbc=;
 b=A3BFgYKtR8scdlewvJ3rJOfcxrbvVLpJwLVlCB0pWWdgIFzNAz0TdN8inf/INSEGRbk4kH
 Dnq9HLPe1W8HoRSZzZiyxeflKouA21n1oB/M9d8d6q6dk68vPBK6lVu8Tu6tJiimylHVPm
 iN9GIrwGR8mVk71xetioS+e8Ipvlmeg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-363-bBxfKlPNMAOz3F6kXgSk5Q-1; Fri,
 12 Jul 2024 04:13:06 -0400
X-MC-Unique: bBxfKlPNMAOz3F6kXgSk5Q-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 990401955F44; Fri, 12 Jul 2024 08:13:05 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.56])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 194C01956066; Fri, 12 Jul 2024 08:13:02 +0000 (UTC)
Date: Fri, 12 Jul 2024 09:12:59 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>
Subject: Re: [PATCH 04/14] qapi: add a 'command-features' pragma
Message-ID: <ZpDlizzbaXk4pa0U@redhat.com>
References: <20240604153242.251334-1-berrange@redhat.com>
 <20240604153242.251334-5-berrange@redhat.com>
 <87r0bzuj7d.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87r0bzuj7d.fsf@pond.sub.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
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

On Fri, Jul 12, 2024 at 10:07:34AM +0200, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > The 'command-features' pragma allows for defining additional
> > special features that are unique to a particular QAPI schema
> > instance and its implementation.
> 
> So far, we have special features (predefined, known to the generator and
> treated specially), and normal features (user-defined, not known to the
> generator).  You create a new kind in between: user-defined, not known
> to the generator, yet treated specially (I guess?).  Hmm.
> 
> Could you at least hint at indented use here?  What special treatment do
> you have in mind?

Essentially, these features are a way to attach metadata to commands that
the server side impl can later query. This eliminates the need to hardcode
lists of commands, such as in QGA which hardcodes a list of commands which
are safe to use when filesystems are frozen. This is illustrated later in
this series.

> 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  scripts/qapi/parser.py | 2 ++
> >  scripts/qapi/source.py | 2 ++
> >  2 files changed, 4 insertions(+)
> >
> > diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
> > index 7b13a583ac..36a9046243 100644
> > --- a/scripts/qapi/parser.py
> > +++ b/scripts/qapi/parser.py
> > @@ -243,6 +243,8 @@ def check_list_str(name: str, value: object) -> List[str]:
> >              pragma.documentation_exceptions = check_list_str(name, value)
> >          elif name == 'member-name-exceptions':
> >              pragma.member_name_exceptions = check_list_str(name, value)
> > +        elif name == 'command-features':
> > +            pragma.command_features = check_list_str(name, value)
> >          else:
> >              raise QAPISemError(info, "unknown pragma '%s'" % name)
> >  
> > diff --git a/scripts/qapi/source.py b/scripts/qapi/source.py
> > index 7b379fdc92..07c2958ac4 100644
> > --- a/scripts/qapi/source.py
> > +++ b/scripts/qapi/source.py
> > @@ -28,6 +28,8 @@ def __init__(self) -> None:
> >          self.documentation_exceptions: List[str] = []
> >          # Types whose member names may violate case conventions
> >          self.member_name_exceptions: List[str] = []
> > +        # Arbitrary extra features recorded against commands
> > +        self.command_features: List[str] = []
> >  
> >  
> >  class QAPISourceInfo:
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


