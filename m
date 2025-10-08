Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 708F7CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 07:10:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6OJ0-00082Q-DC; Wed, 08 Oct 2025 03:09:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v6OIy-00082D-Va
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 03:09:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v6OIw-0007sE-1s
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 03:09:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759907379;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=ip+5hxYM5RoHvplk/0yvZuFaQCSsgm4UDgG8D3LX/3c=;
 b=FPJQnSPDu9ne3NE+TfPBT1wRElY6qmOPxpYsEpXb4Id7Oq/+DjXesrFhFSrryK+pMhEJLE
 gPG3n54qmtNYFg9op4cxWcEcEvu2plS0mNk4X+idbq5CoDvqlIoSEuYngD+2onBZEu7BfL
 cHG74gEZWoWa8wb5E+ikLS3/b9kpXNQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-108--0ch0m5pPWyS0jMdsGvCvg-1; Wed,
 08 Oct 2025 03:09:35 -0400
X-MC-Unique: -0ch0m5pPWyS0jMdsGvCvg-1
X-Mimecast-MFC-AGG-ID: -0ch0m5pPWyS0jMdsGvCvg_1759907374
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8EF5519560A7; Wed,  8 Oct 2025 07:09:33 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.74])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 811451800446; Wed,  8 Oct 2025 07:09:29 +0000 (UTC)
Date: Wed, 8 Oct 2025 08:09:26 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v2] hw/uefi: add "info ovmf-log" + "query-ovmf-log"
 monitor commands
Message-ID: <aOYN1d2UYF3cYuDK@redhat.com>
References: <20251007135216.1687648-1-kraxel@redhat.com>
 <87347toqd4.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87347toqd4.fsf@pond.sub.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, Oct 08, 2025 at 08:32:39AM +0200, Markus Armbruster wrote:
> Gerd Hoffmann <kraxel@redhat.com> writes:
> 
> > Starting with the edk2-stable202508 tag OVMF (and ArmVirt too) have
> > optional support for logging to a memory buffer.  There is guest side
> > support -- for example in linux kernels v6.17+ -- to read that buffer.
> > But that might not helpful if your guest stops booting early enough that
> > guest tooling can not be used yet.  So host side support to read that
> > log buffer is a useful thing to have.
> >
> > This patch implements both qmp and hmp monitor commands to read the
> > firmware log.
> >
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> 
> [...]
> 
> > diff --git a/tests/qtest/qmp-cmd-test.c b/tests/qtest/qmp-cmd-test.c
> > index cf718761861d..ffdb7e979e0f 100644
> > --- a/tests/qtest/qmp-cmd-test.c
> > +++ b/tests/qtest/qmp-cmd-test.c
> > @@ -52,6 +52,8 @@ static int query_error_class(const char *cmd)
> >          /* Only valid with accel=tcg */
> >          { "x-query-jit", ERROR_CLASS_GENERIC_ERROR },
> >          { "xen-event-list", ERROR_CLASS_GENERIC_ERROR },
> > +        /* requires firmware with memory buffer logging support */
> > +        { "query-ovmf-log", ERROR_CLASS_GENERIC_ERROR },
> >          { NULL, -1 }
> >      };
> >      int i;
> 
> Makes sense.
> 
> > diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
> > index 6142f60e7b16..eca0614903d1 100644
> > --- a/hmp-commands-info.hx
> > +++ b/hmp-commands-info.hx
> > @@ -977,3 +977,16 @@ SRST
> >    ``info cryptodev``
> >      Show the crypto devices.
> >  ERST
> > +
> > +    {
> > +        .name       = "ovmf-log",
> > +        .args_type  = "",
> > +        .params     = "",
> > +        .help       = "show the ovmf debug log",
> > +        .cmd_info_hrt = qmp_query_ovmf_log,
> > +    },
> > +
> > +SRST
> > +  ``info ovmf-log``
> > +    Show the ovmf debug log.
> > +ERST
> > diff --git a/hw/uefi/meson.build b/hw/uefi/meson.build
> > index 91eb95f89e6d..c8f38dfae247 100644
> > --- a/hw/uefi/meson.build
> > +++ b/hw/uefi/meson.build
> > @@ -1,4 +1,4 @@
> > -system_ss.add(files('hardware-info.c'))
> > +system_ss.add(files('hardware-info.c', 'ovmf-log.c'))
> >  
> >  uefi_vars_ss = ss.source_set()
> >  if (config_all_devices.has_key('CONFIG_UEFI_VARS'))
> > diff --git a/qapi/machine.json b/qapi/machine.json
> > index 038eab281c78..329034035029 100644
> > --- a/qapi/machine.json
> > +++ b/qapi/machine.json
> > @@ -1839,6 +1839,16 @@
> >    'returns': 'HumanReadableText',
> >    'features': [ 'unstable' ]}
> >  
> > +##
> > +# @query-ovmf-log:
> > +#
> > +# Find firmware memory log buffer in guest memory, return content.
> > +#
> > +# Since: 10.2
> > +##
> > +{ 'command': 'query-ovmf-log',
> > +  'returns': 'HumanReadableText' }
> 
> All other commands returning HumanReadableText are unstable.  Does this
> one need to be stable?  If yes, why?

The main reason why all the others are 'unstable' is that I did a "blind"
conversion of "info XXXX" to "x-query-XXXX", with no consideration for
the data design. They are all returning structured data munged into an
opaque string targetted at humans, not machines.

For this log command the data is inherantly a string to begin with, so
the general problem data design doesn't apply here. This command is
suitable for consumption both by machines and humans. Overall I think
it is reasonable to consider this new command stable.

Maybe this means we should return 'str' instead of 'HumanReadableText'
to distinguish it ?

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


