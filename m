Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0F7BC3ABCC
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 12:42:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEoxv-0002pi-VJ; Tue, 13 May 2025 08:42:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uEoxj-0002fN-Ox
 for qemu-devel@nongnu.org; Tue, 13 May 2025 08:42:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uEoxd-0000Hu-Ce
 for qemu-devel@nongnu.org; Tue, 13 May 2025 08:42:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747140134;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VgHGMLPQICELdIKohFxpnm4aLvWvct1m551lpryXFQs=;
 b=RPc28cmqjIC8LevJeL/JZo65scfL+W7DEnaFCECpXXFs3tJ3HUEchOl6khAs3kfGukTm/7
 gavzWBIiA6mI4bUH7HbrAuzJrMvZ4U3zVymibfZ8EcpdvTtAOw2p/sA3zjpO1mB2qEzKBJ
 ZugHkVdU0aMtgjmoSAG8EljigTSGzys=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-PNaNUxofNJOirhBHVEewlw-1; Tue,
 13 May 2025 08:42:11 -0400
X-MC-Unique: PNaNUxofNJOirhBHVEewlw-1
X-Mimecast-MFC-AGG-ID: PNaNUxofNJOirhBHVEewlw_1747140130
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1112B19560A7; Tue, 13 May 2025 12:42:10 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.110])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CC6DB1953B82; Tue, 13 May 2025 12:42:00 +0000 (UTC)
Date: Tue, 13 May 2025 13:41:52 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 08/10] qapi: Make CpuModelExpansionInfo::deprecated-props
 optional and generic
Message-ID: <aCM-ECjLAPjr5ITz@redhat.com>
References: <20250508135816.673087-1-berrange@redhat.com>
 <20250508135816.673087-9-berrange@redhat.com>
 <87r00sd6sv.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87r00sd6sv.fsf@pond.sub.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.549,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, May 13, 2025 at 02:38:40PM +0200, Markus Armbruster wrote:
> Copying my review from the initial posting:
> 
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > From: Philippe Mathieu-Daudé <philmd@linaro.org>
> >
> > We'd like to have some unified QAPI schema. Having a structure field
> > conditional to a target being built in is not very practical.
> >
> > While @deprecated-props is only used by s390x target, it is generic
> > enough and could be used by other targets (assuming we expand
> > CpuModelExpansionType enum values).
> >
> > Let's always include this field, regardless of the target, but
> > make it optional.
> >
> > Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > ---
> >  qapi/machine-target.json | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> >
> > diff --git a/qapi/machine-target.json b/qapi/machine-target.json
> > index 541f93eeb7..3b109b4af8 100644
> > --- a/qapi/machine-target.json
> > +++ b/qapi/machine-target.json
> > @@ -244,19 +244,18 @@
> >  #
> >  # @model: the expanded CpuModelInfo.
> >  #
> > -# @deprecated-props: a list of properties that are flagged as
> > +# @deprecated-props: an optional list of properties that are flagged as
> >  #     deprecated by the CPU vendor.  The list depends on the
> >  #     CpuModelExpansionType: "static" properties are a subset of the
> >  #     enabled-properties for the expanded model; "full" properties are
> >  #     a set of properties that are deprecated across all models for
> > -#     the architecture.  (since: 9.1).
> > +#     the architecture.  (since: 10.1 -- since 9.1 on s390x --).
> >  #
> >  # Since: 2.8
> >  ##
> >  { 'struct': 'CpuModelExpansionInfo',
> >    'data': { 'model': 'CpuModelInfo',
> > -            'deprecated-props' : { 'type': ['str'],
> > -                                   'if': 'TARGET_S390X' } },
> > +            '*deprecated-props' : { 'type': ['str'] } },
> 
> Make this
> 
>                '*deprecated-props' : ['str'] },
> 
> please.
> 
> When I see "optional array", I wonder about the difference between
> "absent" and "present and empty".  The doc comment doesn't quite explain
> it.  I figure "present and empty" means empty, while "absent" means we
> don't know / not implemented.
> 
> Is the difference useful?

I'm doubtful that the difference is useful.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


