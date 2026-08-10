Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36058C5AD4E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 08:28:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtLN4-0000aX-TS; Mon, 10 Aug 2026 04:28:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wtLN2-0000Zx-Vs
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 04:28:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wtLN1-0004OJ-9X
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 04:28:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786350510;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=GsON3rbM1h0Bq1SQVa0jjvzHP3gtfdYlF6wyb2rKWZc=;
 b=bW4ebvtdoqMhiGCTeRCgbJCQKS9AjinZKhPLlY053il7NnMN/qrd0fVWTBPUnuA/4pB57C
 p/MxSrebcECI+Ftz+8ROZ+UdN+i44GhCG/Ey7IQURJjJh1epr47SrzV9uVsPVR44brZkYe
 0hOZ/RdCZ2YJECc5nApcryF2gyLSWps=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-aPODG9CLPa2q8oq398Evwg-1; Mon,
 10 Aug 2026 04:28:29 -0400
X-MC-Unique: aPODG9CLPa2q8oq398Evwg-1
X-Mimecast-MFC-AGG-ID: aPODG9CLPa2q8oq398Evwg_1786350508
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CCA021800148; Mon, 10 Aug 2026 08:28:27 +0000 (UTC)
Received: from redhat.com (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 72ED71956044; Mon, 10 Aug 2026 08:28:25 +0000 (UTC)
Date: Mon, 10 Aug 2026 09:28:22 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH] meson: disable "maybe uninitilized" errors with -Og
Message-ID: <anmLphIi2HdDXugu@redhat.com>
References: <f559b622eb2d1a384b4f30583a8af10531f4b032.1785144729.git.mst@redhat.com>
 <20260810025526-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260810025526-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.827,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Aug 10, 2026 at 02:57:06AM -0400, Michael S. Tsirkin wrote:
> On Mon, Jul 27, 2026 at 09:30:54AM -0400, Michael S. Tsirkin wrote:
> > GCC's "maybe uninitilized" warnings depend on optimizations
> > for code flow analysis, and produce false positive errors
> > with -Og. Default build gives us coverage with that,
> > so let's just disable with -Og.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> ping, comments on this?
> 
> As an alternative, I can see us doing this for everyone
> and only adding -Werror=maybe-uninitialized in CI for
> known good compiler/flag combos which do not produce
> too many false positives.

I see no compelling reason to disable it universally - the
problems are not too numerous, and IMHO if the code is
complex enough that the compiler is worried, then it is
better to have explicit initializers as that makes the code
easier to interpret for humans too.

> 
> 
> > ---
> >  meson.build | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/meson.build b/meson.build
> > index 164328ded8..a119dae6ac 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -742,6 +742,10 @@ warn_flags = [
> >    '-Wno-typedef-redefinition',
> >  ]
> >  
> > +if get_option('optimization') == 'g'
> > +  warn_flags += ['-Wno-error=maybe-uninitialized']
> > +endif
> > +
> >  if host_os != 'darwin'
> >    tsa_has_cleanup = cc.compiles('''
> >      struct __attribute__((capability("mutex"))) mutex {};
> > -- 
> > MST
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


