Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 610FFCCF9E3
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 13:33:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCHur-00066i-Vj; Fri, 24 Oct 2025 09:33:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vCHuS-00061n-7k
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 09:32:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vCHuM-0006i3-Ne
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 09:32:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761312753;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b1GaxKa27SjrtH/KtsIcygs1hqS/G+k0Q9fMRiZ1/CI=;
 b=LFKJN3+ixDkQKIrX6ULMrwHZzjph941qRk1mWkW6qcZPsiNVcmwr6o1TyOc2Uo08BeJwNl
 Hf3801TZxpNFn+BOd58IiuIkrK/fXNxj1FsYZxzTancotFk4Z4hfHsD6DZEDlAQziraHhP
 SSVswVYYcOrNMEDNgPkC9j1EwqlrN3A=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-412-uXX25-okNhioN_Zlbme7-w-1; Fri,
 24 Oct 2025 09:32:31 -0400
X-MC-Unique: uXX25-okNhioN_Zlbme7-w-1
X-Mimecast-MFC-AGG-ID: uXX25-okNhioN_Zlbme7-w_1761312750
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C711219540E0; Fri, 24 Oct 2025 13:32:30 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C781B180057C; Fri, 24 Oct 2025 13:32:27 +0000 (UTC)
Date: Fri, 24 Oct 2025 14:32:24 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 10/32] hw/core: report security status in query-machines
Message-ID: <aPt_6NX7n8Uqb76J@redhat.com>
References: <20250926140144.1998694-1-berrange@redhat.com>
 <20250926140144.1998694-11-berrange@redhat.com>
 <87zf9h6cd5.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87zf9h6cd5.fsf@pond.sub.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Oct 23, 2025 at 02:17:42PM +0200, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  hw/core/machine-qmp-cmds.c | 1 +
> >  qapi/machine.json          | 8 +++++++-
> >  2 files changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
> > index 6aca1a626e..4d9906f64a 100644
> > --- a/hw/core/machine-qmp-cmds.c
> > +++ b/hw/core/machine-qmp-cmds.c
> > @@ -100,6 +100,7 @@ MachineInfoList *qmp_query_machines(bool has_compat_props, bool compat_props,
> >          if (mc->default_ram_id) {
> >              info->default_ram_id = g_strdup(mc->default_ram_id);
> >          }
> > +        info->secure = object_class_is_secure(OBJECT_CLASS(mc));
> >  
> >          if (compat_props && mc->compat_props) {
> >              int i;
> > diff --git a/qapi/machine.json b/qapi/machine.json
> > index 038eab281c..bb2b308ccd 100644
> > --- a/qapi/machine.json
> > +++ b/qapi/machine.json
> > @@ -194,6 +194,11 @@
> >  #     present when `query-machines` argument @compat-props is true.
> >  #     (since 9.1)
> >  #
> > +# @secure: If true, the machine is declared to provide a security
> > +#     boundary from the guest; if false the machine is either
> > +#     not providing a security boundary, or its status is undefined.
> > +#     (since 10.2)
> > +#
> >  # Features:
> >  #
> >  # @unstable: Member @compat-props is experimental.
> > @@ -207,7 +212,8 @@
> >              'deprecated': 'bool', '*default-cpu-type': 'str',
> >              '*default-ram-id': 'str', 'acpi': 'bool',
> >              '*compat-props': { 'type': ['CompatProperty'],
> > -                               'features': ['unstable'] } } }
> > +                               'features': ['unstable'] },
> > +            'secure': 'bool' } }
> >  
> >  ##
> >  # @query-machines:
> 
> Isn't this redundant with qom-list-types?
> 
> {"execute": "qom-list-types", "arguments": {"implements": "machine"}}

Well if the mgmt app is already using 'query-machines' for other reasons,
and doesn't currently use 'qom-list-types', then it is useful to have
the info reported in the former too.  Also I viewed the 'secure' flag
as being conceptually twinned with the 'deprecated' flag which is also
here in 'query-machines'.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


